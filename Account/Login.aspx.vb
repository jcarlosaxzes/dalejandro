﻿Imports System.Web
Imports System.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports Microsoft.Owin.Security
Imports Owin

Partial Public Class Login
    Inherits Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As EventArgs) Handles Me.PreInit
        Theme = LocalAPI.DefinirTheme(Request.UserAgent)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            ' Borrar todas las variables de sesion
            Session.Abandon()
        End If
    End Sub

    Protected Sub OnClickHandler(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnk As LinkButton = CType(sender, LinkButton)
        If lnk.CommandName = "Login" Then
            If IsValid Then
                ' Validate the user password
                Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
                Dim signinManager = Context.GetOwinContext().GetUserManager(Of ApplicationSignInManager)()

                ' This doen't count login failures towards account lockout
                ' To enable password failures to trigger lockout, change to shouldLockout := True
                Dim result = signinManager.PasswordSignIn(UserName.Text, Password.Text, RememberMe.Checked, shouldLockout:=False)

                Select Case result
                    Case SignInStatus.Success
                        IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
                        Exit Select
                    Case SignInStatus.LockedOut
                        Response.Redirect("/Account/Lockout")
                        Exit Select
                    Case SignInStatus.RequiresVerification
                        Response.Redirect(String.Format("/Account/TwoFactorAuthenticationSignIn?ReturnUrl={0}&RememberMe={1}",
                                                    Request.QueryString("ReturnUrl"),
                                                   True),
                                      True)
                        Exit Select
                    Case Else
                        FailureText.Text = "Invalid login attempt"
                        Exit Select
                End Select
            End If
        End If
    End Sub


End Class
