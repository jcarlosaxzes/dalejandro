Imports System.Data.SqlClient
Imports System.Security.Claims
Imports System.Threading.Tasks
Imports Intuit.Ipp.Core
Imports Intuit.Ipp.Data
Imports Intuit.Ipp.OAuth2PlatformClient
Imports Intuit.Ipp.QueryFilter
Imports Intuit.Ipp.Security
Imports Telerik.Web.UI

Public Class QueicBooksTestPages
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
            Dim clientid = qbAPI.GetClientId()
            Dim clientsecret = qbAPI.GetClientSecret()
            Dim redirectUrl = qbAPI.GetRedirectUrl()
            Dim environment = qbAPI.GetAppEnvironment()
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

            Dim clientid = qbAPI.GetClientId()
            Dim clientsecret = qbAPI.GetClientSecret()
            Dim redirectUrl = qbAPI.GetRedirectUrl()
            Dim environment = qbAPI.GetAppEnvironment()

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

        LoadQBCustomers()
        RadGrid1.DataBind()

    End Sub





    Private Sub LoadQBCustomers()
        Dim dt As New DataTable()

        'dt.Columns.Add(New DataColumn("OrderID", Type.GetType("System.Int32")))
        'dt.Columns.Add(New DataColumn("OrderDate", Type.GetType("System.DateTime")))
        'dt.Columns.Add(New DataColumn("Freight", Type.GetType("System.Decimal")))
        dt.Columns.Add(New DataColumn("companyId", Type.GetType("System.Int32")))
        dt.Columns.Add(New DataColumn("QBId", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("QBCompany", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("DisplayName", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("Email", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("Title", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("GivenName", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("MiddleName", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("FamilyName", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("PrintOnCheckName", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("CompanyName", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("City", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("PostalCode", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("Addr_Line1", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("Addr_Line2", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("Addr_Line3", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("Mobile", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("PrimaryPhone", Type.GetType("System.String")))




        Dim PrimaryKeyColumns As DataColumn() = New DataColumn(0) {}
        PrimaryKeyColumns(0) = dt.Columns("DisplayName")
        dt.PrimaryKey = PrimaryKeyColumns

        Dim qbCompanyId = LocalAPI.GetqbCompanyID(lblCompanyId.Text)
        Try
            Dim serviceContext = qbAPI.GetServiceContext(lblCompanyId.Text)
            Dim customerQueryService As QueryService(Of Customer) = New QueryService(Of Customer)(serviceContext)
            Dim Customers = customerQueryService.ExecuteIdsQuery("Select * From Customer")

            LocalAPI.ExecuteNonQuery(" delete [dbo].[Clients_SyncQB] where companyId = " & lblCompanyId.Text)

            For Each customerObj As Customer In Customers

                Dim row As DataRow = dt.NewRow()
                row("companyId") = lblCompanyId.Text
                row("QBId") = customerObj.Id
                row("QBCompany") = qbCompanyId
                row("DisplayName") = customerObj.DisplayName
                row("Email") = customerObj.PrimaryEmailAddr?.Address
                row("Title") = customerObj.Title
                row("GivenName") = customerObj.GivenName
                row("MiddleName") = customerObj.MiddleName
                row("FamilyName") = customerObj.FamilyName
                row("PrintOnCheckName") = customerObj.PrintOnCheckName
                row("CompanyName") = customerObj.CompanyName
                row("City") = customerObj.BillAddr?.City
                row("PostalCode") = customerObj.BillAddr?.PostalCode
                row("Addr_Line1") = customerObj.BillAddr?.Line1
                row("Addr_Line2") = customerObj.BillAddr?.Line2
                row("Addr_Line3") = customerObj.BillAddr?.Line3
                row("Mobile") = customerObj.Mobile?.FreeFormNumber
                row("PrimaryPhone") = customerObj.PrimaryPhone?.FreeFormNumber

                dt.Rows.Add(row)

            Next


            'insert into SQL

            Dim objbulk As SqlBulkCopy = New SqlBulkCopy(LocalAPI.GetConnection())
            objbulk.ColumnMappings.Add("companyId", "companyId")
            objbulk.ColumnMappings.Add("QBId", "QBId")
            objbulk.ColumnMappings.Add("QBCompany", "QBCompany")
            objbulk.ColumnMappings.Add("DisplayName", "DisplayName")
            objbulk.ColumnMappings.Add("Email", "Email")
            objbulk.ColumnMappings.Add("Title", "Title")
            objbulk.ColumnMappings.Add("GivenName", "GivenName")
            objbulk.ColumnMappings.Add("MiddleName", "MiddleName")
            objbulk.ColumnMappings.Add("FamilyName", "FamilyName")
            objbulk.ColumnMappings.Add("PrintOnCheckName", "PrintOnCheckName")
            objbulk.ColumnMappings.Add("CompanyName", "CompanyName")
            objbulk.ColumnMappings.Add("City", "City")
            objbulk.ColumnMappings.Add("PostalCode", "PostalCode")
            objbulk.ColumnMappings.Add("Addr_Line1", "Addr_Line1")
            objbulk.ColumnMappings.Add("Addr_Line2", "Addr_Line2")
            objbulk.ColumnMappings.Add("Addr_Line3", "Addr_Line3")
            objbulk.ColumnMappings.Add("Mobile", "Mobile")
            objbulk.ColumnMappings.Add("PrimaryPhone", "PrimaryPhone")

            objbulk.DestinationTableName = "Clients_SyncQB"
            objbulk.WriteToServer(dt)


        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try


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
                Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
                'Set Acction to Combo box
                Dim ClientId As Integer = e.CommandArgument
                LocalAPI.ActualizarClient(ClientId, "qbCustomerId", 0)
                RadGrid1.DataBind()
                RadGridLinked.DataBind()
        End Select
    End Sub

End Class