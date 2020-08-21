Imports Intuit.Ipp.Data
Imports Intuit.Ipp.OAuth2PlatformClient
Imports Intuit.Ipp.QueryFilter

Public Class client_sync_qb
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblCompanyId.Text = Session("companyId")

            If Not Request.QueryString("state") Is Nothing Then
                Dim state = Request.QueryString("state")

                If (state.Equals(Session("QBO_CSRFToken"))) Then
                    lblResutl.Text = "Connected Success"
                    Dim code = Request.QueryString("code")
                    Dim realmId = Request.QueryString("realmId")
                    Threading.Tasks.Task.Run(Function() GetAuthTokensAsync(code, realmId))
                    RadWizardQB.ActiveStepIndex = 1

                Else
                    lblResutl.Text = "Conected Error"


                    '    String code = Request.QueryString["code"] ?? "none";
                    'String realmId = Request.QueryString["realmId"] ?? "none";
                    'await GetAuthTokensAsync(code, realmId);

                    'ViewBag.Error = Request.QueryString["error"] ?? "none";

                    'Return RedirectToAction("Tokens", "App");
                End If
            End If
        End If
    End Sub


    Private Async Function GetAuthTokensAsync(ByVal code As String, ByVal realmId As String) As Threading.Tasks.Task
        If realmId IsNot Nothing Then
            Session("realmId") = realmId
        End If

        Try
            Dim clientid = ConfigurationManager.AppSettings("clientid")
            Dim clientsecret = ConfigurationManager.AppSettings("clientsecret")
            Dim redirectUrl = ConfigurationManager.AppSettings("redirectUrl")
            Dim environment = ConfigurationManager.AppSettings("appEnvironment")
            Dim auth2Client As OAuth2Client = New OAuth2Client(clientid, clientsecret, redirectUrl, environment)

            Dim tokenResponse = Await auth2Client.GetBearerTokenAsync(code)

            LocalAPI.SetqbAccessToken(lblCompanyId.Text, tokenResponse.AccessToken, tokenResponse.AccessTokenExpiresIn)
            LocalAPI.SetqbRefreshToken(lblCompanyId.Text, tokenResponse.RefreshToken, tokenResponse.RefreshTokenExpiresIn)
            LocalAPI.SetqbCompanyID(lblCompanyId.Text, realmId)

        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try


    End Function

End Class