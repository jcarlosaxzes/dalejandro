﻿Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin
Imports Telerik.Web.UI

Public Class options
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As EventArgs) Handles Me.PreInit
        Theme = LocalAPI.DefinirTheme(Request.UserAgent)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Me.Title = ConfigurationManager.AppSettings("TituloWeb") & ". Account Options"

            If Not IsPostBack Then
                Master.PageTitle = "Company/Account Options"
                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Master.UserId
                lblEmployeeEmail.Text = Master.UserEmail

                Master.Help = "http://blog.pasconcept.com/2015/08/othersmy-account.html"
                Image1.ImageUrl = LocalAPI.GetEmployeePhotoURL(lblEmployeeEmail.Text)
            End If

        Catch ex As Exception
        End Try

    End Sub

    Protected Async Sub btnOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOk.Click
        Try

            Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim user As pasconcept20.ApplicationUser = Await manager.FindByEmailAsync(lblEmployeeEmail.Text)

            Dim signinManager = Context.GetOwinContext().GetUserManager(Of ApplicationSignInManager)()
            Dim result = signinManager.PasswordSignIn(lblEmployeeEmail.Text, txtOldPass.Text, False, shouldLockout:=False)

            If result = SignInStatus.Success Then
                If Me.txtPass.Text = Me.txtConPass.Text Then
                    user.PasswordHash = New PASPasswordHasher().HashPassword(txtPass.Text)
                    Await manager.UpdateAsync(user)
                    Master.InfoMessage("The password has been changed successfully", 15)
                    lblMsg.Text = "The password has been changed successfully"
                Else
                    Master.ErrorMessage("The new password do not match with the confirmation", 0)
                End If
            Else
                Master.ErrorMessage("Incorrect old password", 0)
            End If
        Catch ex As Exception
            Master.ErrorMessage("The password do not change! " & ex.Message)
        End Try

    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
        Try

            Dim urlPath As String = "~/Images/Employees/" & lblEmployeeId.Text & ".jpg"
            For Each f As UploadedFile In RadAsyncUpload1.UploadedFiles
                f.SaveAs(Server.MapPath(urlPath), True)
            Next
            Image1.ImageUrl = urlPath
            Label1.Text = "Employee photo has been successfully uploaded"
        Catch ex As Exception
            Label1.Text = ex.Message
        End Try
    End Sub

End Class
