Imports Intuit.Ipp.Data
Imports Intuit.Ipp.OAuth2PlatformClient
Imports Intuit.Ipp.QueryFilter

Public Class qb_refreshtoken
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Not Request.QueryString("QBAuthBackPage") Is Nothing Then
                Session("QBAuthBackPage") = Request.QueryString("QBAuthBackPage")
                Session("QBAuthBackPageJobId") = "" & Request.QueryString("JobId")
            End If
            If Not Request.QueryString("state") Is Nothing Then
                Dim state = Request.QueryString("state")
                If (state.Equals(Session("QBO_CSRFToken"))) Then
                    lblResutl.Text = ""

                    ' Read others parameters returned
                    Dim code = Request.QueryString("code")
                    Dim realmId = Request.QueryString("realmId")

                    Threading.Tasks.Task.Run(Function() GetAuthTokensAsync(code, realmId))

                    btnBack.Text = "Back"
                Else
                    lblResutl.Text = "Connection Error with QB!!!"

                End If
            End If

            ' Botones y paneles en funcion de connexion valida
            PanelSuccess.Visible = (btnBack.Text = "Back")
            PanelInstructions.Visible = Not PanelSuccess.Visible
            btnConnect.Visible = PanelInstructions.Visible

        End If

    End Sub

    Private Async Function GetAuthTokensAsync(ByVal code As String, ByVal realmId As String) As Threading.Tasks.Task
        If realmId IsNot Nothing Then
            Session("realmId") = realmId
        End If

        Try
            '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            'https://developer.intuit.com/app/developer/dashboard
            'user:jcarlos@axzes.com
            '
            Dim clientid = ConfigurationManager.AppSettings("clientid")
            Dim clientsecret = ConfigurationManager.AppSettings("clientsecret")
            Dim redirectUrl = ConfigurationManager.AppSettings("redirectUrl")
            Dim environment = ConfigurationManager.AppSettings("appEnvironment")
            Dim auth2Client As OAuth2Client = New OAuth2Client(clientid, clientsecret, redirectUrl, environment)

            Dim tokenResponse = Await auth2Client.GetBearerTokenAsync(code)

            LocalAPI.SetqbAccessToken(Session("companyId"), tokenResponse.AccessToken, tokenResponse.AccessTokenExpiresIn)

            LocalAPI.SetqbRefreshToken(Session("companyId"), tokenResponse.RefreshToken, tokenResponse.RefreshTokenExpiresIn)
            LocalAPI.SetqbCompanyID(Session("companyId"), realmId)


        Catch ex As Exception
            lblResutl.Text = ex.Message
        End Try
    End Function

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        BackPage()
    End Sub
    Protected Sub BackPage()
        Response.Redirect("~/adm/" & Session("QBAuthBackPage") & IIf(Len(Session("QBAuthBackPageJobId")) > 0, "?JobId=" & Session("QBAuthBackPageJobId"), ""))
    End Sub
    Private Sub btnConnect_Click(sender As Object, e As EventArgs) Handles btnConnect.Click
        Try

            Dim scopes As New List(Of OidcScopes)
            scopes.Add(OidcScopes.Accounting)

            Dim clientid = ConfigurationManager.AppSettings("clientid")
            Dim clientsecret = ConfigurationManager.AppSettings("clientsecret")
            Dim redirectUrl = ConfigurationManager.AppSettings("redirectUrl")
            Dim environment = ConfigurationManager.AppSettings("appEnvironment")

            Dim auth2Client As OAuth2Client = New OAuth2Client(clientid, clientsecret, redirectUrl, environment)

            Dim authorizeUrl = auth2Client.GetAuthorizationURL(scopes)
            Session("QBO_CSRFToken") = auth2Client.CSRFToken
            Response.Redirect(authorizeUrl)

        Catch ex As Exception
            lblResutl.Text = ex.Message
        End Try
    End Sub
End Class