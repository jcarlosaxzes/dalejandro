Imports System.Web
Imports System.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports Microsoft.Owin.Security
Imports Owin
Imports PASconcept.DataAccess.Repositories.Abstract

Partial Public Class Login
    Inherits Page
    
    Private ReadOnly _companiesRepository AS ICompaniesRepository
    
    Public Sub New (ByVal companiesRepository AS ICompaniesRepository)
        Me._companiesRepository = companiesRepository
    End Sub
    
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
                Dim signinManager = Context.GetOwinContext().GetUserManager(Of ApplicationSignInManager)()

                ' This doen't count login failures towards account lockout
                ' To enable password failures to trigger lockout, change to shouldLockout := True
                Dim result = signinManager.PasswordSignIn(UserName.Text, Password.Text, RememberMe.Checked, shouldLockout:=False)

                Select Case result
                    Case SignInStatus.Success
                        Dim hostName As String = LocalAPI.GetHostAppSite()
                        Dim hostCompany As Integer = LocalAPI.GetStringEscalar($"Select isnull(companyId,0) As companyId from Company where SubDomain='{hostName}'")
                        Dim companyId As Integer
                        If hostCompany > 0 Then
                            companyId = hostCompany
                            Session("IsMultiCompany") = 0
                        Else
                            companyId = Me._companiesRepository.GetDefaultCompanyId(UserName.Text)
                            Session("IsMultiCompany") = 1
                        End If



                        Session("companyId") = companyId
                        If LocalAPI.IAgree(UserName.Text) Then
                            If IsNothing(Request.QueryString("ReturnUrl")) Then
                                Response.Redirect("~/adm/dashboard")
                            Else
                                Response.Redirect(Request.QueryString("ReturnUrl"))
                            End If
                        Else
                            Response.Redirect("~/adm/useragree")
                        End If

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
