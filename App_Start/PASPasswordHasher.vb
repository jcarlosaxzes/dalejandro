Imports System.Security.Cryptography
Imports Microsoft.AspNet.Identity
Imports System.Security.Cryptography.keyde
Imports System.IO
Imports Microsoft.AspNetCore.Cryptography.KeyDerivation

Public Class PASPasswordHasher
    Implements IPasswordHasher

    Public Sub New()
    End Sub

    Public Dim  _rng as RandomNumberGenerator

    Public Function HashPassword(password As String) As String Implements IPasswordHasher.HashPassword
        Dim hash = HashPasswordV2(password)
        Return hash
    End Function

    Public Function HashPasswordV2(password As String) As String
        Using rng As RNGCryptoServiceProvider = New RNGCryptoServiceProvider()

            Dim Pbkdf2Prf As KeyDerivationPrf = KeyDerivationPrf.HMACSHA1  ' // Default For Rfc2898DeriveBytes
            Dim Pbkdf2IterCount As Short = 1000 '; // Default For Rfc2898DeriveBytes
            Dim Pbkdf2SubkeyLength = 256 / 8  ' // 256 bits
            Dim SaltSize As Short = 128 / 8  ' // 128 bits

            '// Produce a version 2 text hash.
            Dim salt(SaltSize - 1) As Byte
            rng.GetBytes(salt)
            Dim subkey = KeyDerivation.Pbkdf2(password, salt, Pbkdf2Prf, Pbkdf2IterCount, Pbkdf2SubkeyLength)

            Dim outputBytes(SaltSize + Pbkdf2SubkeyLength) As Byte
            outputBytes(0) = &H0 ' // format marker
            Buffer.BlockCopy(salt, 0, outputBytes, 1, SaltSize)
            Buffer.BlockCopy(subkey, 0, outputBytes, 1 + SaltSize, Pbkdf2SubkeyLength)

            Dim hash = Convert.ToBase64String(outputBytes)
            Return hash
        End Using
    End Function


    Public Function VerifyHashedPasswordV2(hashedPassword() As Byte, password As String) As Boolean

        Dim Pbkdf2Prf As KeyDerivationPrf = KeyDerivationPrf.HMACSHA1  ' // Default For Rfc2898DeriveBytes
        Dim Pbkdf2IterCount As Short = 1000 '; // Default For Rfc2898DeriveBytes
        Dim Pbkdf2SubkeyLength = 256 / 8  ' // 256 bits
        Dim SaltSize As Short = 128 / 8  ' // 128 bits

        'We know ahead of time the exact length of a valid hashed password payload.
        If hashedPassword.Length <> 1 + SaltSize + Pbkdf2SubkeyLength Then
            Return False '; // bad size
        End If

        Dim salt(SaltSize - 1) As Byte
        Buffer.BlockCopy(hashedPassword, 1, salt, 0, salt.Length)

        Dim expectedSubkey(Pbkdf2SubkeyLength - 1) As Byte
        Buffer.BlockCopy(hashedPassword, salt.Length + 1, expectedSubkey, 0, expectedSubkey.Length)
        ' Hash the incoming password And verify it
        Dim actualSubkey = KeyDerivation.Pbkdf2(password, salt, Pbkdf2Prf, Pbkdf2IterCount, Pbkdf2SubkeyLength)
        Return ByteArraysEqual(actualSubkey, expectedSubkey)

    End Function

    Public Function VerifyHashedPassword(hashedPassword As String, providedPassword As String) As PasswordVerificationResult Implements IPasswordHasher.VerifyHashedPassword

        ' for test
        Dim testing = HashPasswordV2(providedPassword)
        Dim BytesPassword = Convert.FromBase64String(hashedPassword)

        If VerifyHashedPasswordV2(BytesPassword, providedPassword) Then
            Return PasswordVerificationResult.Success
        Else
            Return PasswordVerificationResult.Failed
        End If
    End Function

    Public Sub WriteNetworkByteOrder(ByVal bytess() As Byte, offset As Short, value As UShort)
        bytess(offset + 0) = (value >> 24)
        bytess(offset + 1) = (value >> 16)
        bytess(offset + 2) = (value >> 8)
        bytess(offset + 3) = (value >> 0)
    End Sub

    Public Function ByteArraysEqual(a() As Byte, b() As Byte) As Boolean
        If a Is Nothing Or b Is Nothing Then
            Return False
        End If

        If a.Count <> b.Count Then
            Return False
        End If

        For i = 0 To a.Count - 1
            If a(i) <> b(i) Then
                Return False
            End If
        Next

        Return True

    End Function

End Class
