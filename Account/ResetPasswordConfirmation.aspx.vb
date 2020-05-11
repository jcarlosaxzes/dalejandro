Imports System
Imports System.Threading.Tasks
Imports System.Web
Imports Microsoft.AspNet.Identity.Owin
Imports Owin

Partial Public Class ResetPasswordConfirmation
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LocalAPI.AppUserManager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim guid = Request.QueryString("guid")
            If Not IsNothing(guid) Then
                Dim semail = LocalAPI.GetUserEmailByGuid(guid)
                Email.Text = semail
            End If
        End If
    End Sub



    Protected Async Sub Reset_Click(sender As Object, e As EventArgs)
        If IsValid Then
            LocalAPI.AppUserManager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            If Password1.Text = password2.Text Then
                If Not (Await LocalAPI.AppUserManager.PasswordValidator.ValidateAsync(Password1.Text)).Succeeded Then
                    lblMsg.Text = "Minimum 6 (six) characters in length required,   Minimum 1 (one) nonalphanumeric character required"
                    lblMsg.ForeColor = Drawing.Color.Red
                    lblMsg.Visible = True
                    Return
                End If
                Dim user = Await LocalAPI.CreateOrUpdateUser(Email.Text, Password1.Text)
                lblMsg.Text = "Password Resset. Go to Login"
                lblMsg.Visible = True
                lblMsg.ForeColor = Drawing.ColorTranslator.FromHtml("#00A8E4")
                Response.Redirect("~/Account/ResetPasswordSuccess")
            Else
                lblMsg.Text = "Password not Math"
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Visible = True
            End If
        End If

    End Sub
End Class