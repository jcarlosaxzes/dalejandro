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
                    btnConnect.Visible = False
                    SyncPanel.Visible = True

                    Dim code = Request.QueryString("code")
                    Dim realmId = Request.QueryString("realmId")

                    Threading.Tasks.Task.Run(Function() GetAuthTokensAsync(code, realmId))


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


        Dim valid = qbAPI.IsValidAccessToken(lblCompanyId.Text)
        If Not valid And Request.QueryString("state") Is Nothing Then
            Threading.Tasks.Task.Run(Function() qbAPI.UpdateAccessTokenAsync(lblCompanyId.Text))
            btnConnect.Visible = True
            SyncPanel.Visible = False
        Else
            btnConnect.Visible = False
            SyncPanel.Visible = True
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



    Protected Sub btnConnect_Click(sender As Object, e As EventArgs)

        Dim valid = qbAPI.IsValidAccessToken(lblCompanyId.Text)
        If Not valid Then
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
        Else
            btnConnect.Visible = False
            SyncPanel.Visible = True
        End If


    End Sub


    Protected Sub btnGetCustomers_Click(sender As Object, e As EventArgs)
        qbAPI.LoadQBCustomers(lblCompanyId.Text)
        RadGrid1.DataBind()
    End Sub



    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand

        Select Case e.CommandName
            Case "Link"
                Dim ids As String() = CType(e.CommandArgument, String).Split(",")
                Dim QBId As Integer = ids(0)
                Dim ClientId = ids(1)
                LocalAPI.ActualizarClient(ClientId, "qbCustomerId", QBId)
                RadGrid1.DataBind()
                RadGridLinked.DataBind()
            Case "CreateNew"
                Dim QBId As Integer = e.CommandArgument
                Dim QBCustomer = LocalAPI.GetqbCustomer(QBId)
                Dim ClientId = LocalAPI.Client_INSERT(QBCustomer("DisplayName"), QBCustomer("Email"), QBCustomer("Title"), lblCompanyId.Text, QBCustomer("CompanyName"), QBCustomer("Addr_Line1"), QBCustomer("Addr_Line2"), QBCustomer("City"), "", QBCustomer("PostalCode"), QBCustomer("PrimaryPhone"), QBCustomer("Mobile"), "", "")
                LocalAPI.ActualizarClient(ClientId, "qbCustomerId", QBId)
                RadGrid1.DataBind()
                RadGridLinked.DataBind()
        End Select
    End Sub


    Protected Sub RadGridLinked_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridLinked.ItemCommand

        Select Case e.CommandName
            Case "UnLink"
                Dim ClientId As Integer = e.CommandArgument
                LocalAPI.ActualizarClient(ClientId, "qbCustomerId", 0)
                RadGrid1.DataBind()
                RadGridLinked.DataBind()
        End Select
    End Sub

End Class