Public Class SqlMembershipProviderHelper
    Inherits SqlMembershipProvider

    Public Function GetClearTextPassword(ByVal encryptedPwd As String) As String

        Dim encodedPassword As Byte() = Convert.FromBase64String(encryptedPwd)
        Dim bytes As Byte() = Me.DecryptPassword(encodedPassword)

        If bytes Is Nothing Then
            Return Nothing
        End If

        Return Encoding.Unicode.GetString(bytes, &H10, bytes.Length - &H10)
    End Function
End Class
