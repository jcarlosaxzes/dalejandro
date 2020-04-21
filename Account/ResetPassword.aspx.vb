Imports System
Imports System.Linq
Imports System.Web
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports Owin

Partial Public Class ResetPassword
    Inherits System.Web.UI.Page

    Protected Property StatusMessage() As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub

    Protected Async Sub Reset_Click(sender As Object, e As EventArgs)
        If IsValid Then
            LocalAPI.AppUserManager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim user = LocalAPI.ExisteUserIdentity(Email.Text)
            If user Then
                Await LocalAPI.EmployeeEmailResetPassword(Email.Text)
                lblMsg.Text = "Review you Email to Reset your Password"
                lblMsg.Visible = True
                lblMsg.ForeColor = Drawing.ColorTranslator.FromHtml("#00A8E4")
            Else
                lblMsg.Text = "No user found"
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Visible = True


            End If
        End If

    End Sub
End Class