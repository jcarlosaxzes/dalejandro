Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin
Imports pasconcept20.IdentityHelper.IdentityHelper

Public Class newversion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If (Not Page.IsPostBack) Then
                If Not Request.QueryString("useremail") Is Nothing Then
                    MigrateUser(Request.QueryString("useremail"))
                End If
            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Private Function MigrateUser(Email As String) As Boolean
        Try

            Dim password = LocalAPI.GetMembershipUserPasswod(Email)
            LocalAPI.AppUserManager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()

            If CreateUser(Email, password) Then
                LocalAPI.NormalizeUser(Email)
            End If

            LocalAPI.ConfirmEmailUser(Email)

            LocalAPI.ExecuteNonQuery($"update [dbo].[Employees] set [IsMigrate] = 1 where [Email] = '{Email}'")

        Catch ex As Exception

        End Try
    End Function
    Public Shared Function CreateUser(email As String, password As String) As Boolean
        Try

            If IsNothing(password) Then
                password = "ValidPassword@#$<GDE45"
            End If
            Dim manager = New UserManager()
            Dim user = New ApplicationUser() With {.UserName = email}
            user.Email = email

            '2.- Crear el usuario en Asp.Net.Identity
            Dim result = manager.Create(user, password)
            Return result.Succeeded

        Catch ex As Exception

        End Try
    End Function
End Class