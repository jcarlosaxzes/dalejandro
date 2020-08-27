Imports Intuit.Ipp.Data
Imports Intuit.Ipp.OAuth2PlatformClient
Imports Intuit.Ipp.QueryFilter
Imports Telerik.Web.UI

Public Class client_sync_qb
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblCompanyId.Text = Session("companyId")
        End If
        RadWindowManager1.EnableViewState = False
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
            Master.ErrorMessage(ex.Message)
        End Try


    End Function

    Protected Sub btnGetCustomers_Click(sender As Object, e As EventArgs)
        If qbAPI.IsValidAccessToken(lblCompanyId.Text) Then
            qbAPI.LoadQBCustomers(lblCompanyId.Text)
            RadGrid1.DataBind()
        Else
            ' New Tab for QB Authentication
            Response.Redirect("~/adm/qb_refreshtoken.aspx?QBAuthBackPage=client_sync_qb")
        End If
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand

        Select Case e.CommandName
            Case "Link"
                Dim ids As String() = CType(e.CommandArgument, String).Split(",")
                Dim QBId As Integer = ids(0)
                Dim ClientId = ids(1)
                LocalAPI.ActualizarClient(ClientId, "qbCustomerId", QBId)
                RadGrid1.Rebind()
                RadGridLinked.Rebind()
            Case "CreateNew"
                Dim QBId As Integer = e.CommandArgument
                Dim QBCustomer = LocalAPI.GetqbCustomer(QBId)
                Dim ClientId = LocalAPI.Client_INSERT(QBCustomer("DisplayName"), QBCustomer("Email"), QBCustomer("Title"), lblCompanyId.Text, QBCustomer("CompanyName"), QBCustomer("Addr_Line1"), QBCustomer("Addr_Line2"), QBCustomer("City"), QBCustomer(""), QBCustomer("PostalCode"), QBCustomer("PrimaryPhone"), QBCustomer("Mobile"), "", "")
                LocalAPI.ActualizarClient(ClientId, "qbCustomerId", QBId)
                RadGrid1.Rebind()
                RadGridLinked.Rebind()
            Case "Search"
                lblSelectCustomer.Text = e.CommandArgument
                RadToolTipSearchClient.Visible = True
                RadToolTipSearchClient.Show()
        End Select
    End Sub
    Protected Sub RadGridSearhcClient_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridSearhcClient.ItemCommand

        Select Case e.CommandName
            Case "Link"
                Dim QBId As Integer = lblSelectCustomer.Text
                Dim ClientId = e.CommandArgument
                LocalAPI.ActualizarClient(ClientId, "qbCustomerId", QBId)
                RadToolTipSearchClient.Visible = False
                RadGrid1.Rebind()
                RadGridLinked.Rebind()

        End Select
    End Sub

    Protected Sub RadGridLinked_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridLinked.ItemCommand

        Select Case e.CommandName
            Case "UnLink"
                Dim ClientId As Integer = e.CommandArgument
                LocalAPI.ActualizarClient(ClientId, "qbCustomerId", 0)
                RadGrid1.Rebind()
                RadGridLinked.Rebind()
        End Select
    End Sub

    Protected Sub btnFind_Click(sender As Object, e As EventArgs)
        RadToolTipSearchClient.Visible = True
        RadToolTipSearchClient.Show()
        RadGrid1.Rebind()
    End Sub

    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean)
        RadWindowManager1.Windows.Clear()
        Dim window1 As RadWindow = New RadWindow()
        window1.NavigateUrl = sUrl
        window1.VisibleOnPageLoad = True
        window1.VisibleStatusbar = False
        window1.ID = WindowsID
        If Maximize Then window1.InitialBehaviors = WindowBehaviors.Maximize
        window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize Or WindowBehaviors.Maximize
        If Width = -1 Then
            window1.AutoSize = True
        Else
            window1.AutoSize = False
            window1.Width = Width
            window1.Height = Height
        End If
        window1.Modal = True
        window1.DestroyOnClose = True
        RadWindowManager1.Windows.Add(window1)
    End Sub

End Class