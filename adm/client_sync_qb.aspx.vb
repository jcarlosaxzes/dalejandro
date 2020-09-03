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
        If LocalAPI.IsQuickBookDesckModule(lblCompanyId.Text) Then
            ConnectPanel.Visible = False
        Else
            If qbAPI.IsValidAccessToken(lblCompanyId.Text) Then
                btnDisconnectFromQuickBooks.Visible = True
                btnConnectToQuickBooks.Visible = False
                btnGetCustomers.Visible = True
            ElseIf qbAPI.IsValidRefreshToken(lblCompanyId.Text) Then
                btnDisconnectFromQuickBooks.Visible = True
                btnConnectToQuickBooks.Visible = False
                btnGetCustomers.Visible = True
                Threading.Tasks.Task.Run(Function() qbAPI.UpdateAccessTokenAsync(lblCompanyId.Text))
            Else
                btnDisconnectFromQuickBooks.Visible = False
                btnConnectToQuickBooks.Visible = True
                btnGetCustomers.Visible = False
            End If
        End If



        RadWindowManager1.EnableViewState = False
    End Sub

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
                LinkCustomer(ClientId, QBId)
                RadGrid1.Rebind()
                RadGridLinked.Rebind()

            Case "CreateNew"
                Dim QBId As Integer = e.CommandArgument
                CopyCustomer(QBId)
                RadGrid1.Rebind()
                RadGridLinked.Rebind()

            Case "Search"
                lblSelectCustomer.Text = e.CommandArgument
                RadToolTipSearchClient.Visible = True
                RadToolTipSearchClient.Show()
        End Select
    End Sub

    Protected Function LinkCustomer(ClientId As Integer, QBId As Integer) As Boolean
        If ClientId > 0 And QBId > 0 Then
            If (LocalAPI.IsQuickBookDesckModule(lblCompanyId.Text)) Then
                Dim QBCustomer = LocalAPI.GetqbCustomer(QBId)
                LocalAPI.ActualizarClient(ClientId, "qbListID", QBCustomer("ListID"))
            End If
            Return LocalAPI.ActualizarClient(ClientId, "qbCustomerId", QBId)
        End If
    End Function
    Protected Function CopyCustomer(QBId As Integer) As Boolean
        If QBId > 0 Then
            Dim QBCustomer = LocalAPI.GetqbCustomer(QBId)
            Dim ClientId = LocalAPI.Client_INSERT(QBCustomer("DisplayName"), QBCustomer("Email"), QBCustomer("Title"), lblCompanyId.Text, QBCustomer("CompanyName"), QBCustomer("Addr_Line1"), QBCustomer("Addr_Line2"), QBCustomer("City"), QBCustomer("CountrySubDivisionCode"), QBCustomer("PostalCode"), QBCustomer("PrimaryPhone"), QBCustomer("Mobile"), "", "")
            If (LocalAPI.IsQuickBookDesckModule(lblCompanyId.Text)) Then
                LocalAPI.ActualizarClient(ClientId, "qbListID", QBCustomer("ListID"))
            End If
            Return LocalAPI.ActualizarClient(ClientId, "qbCustomerId", QBId)
        End If
    End Function
    Protected Sub RadGridSearhcClient_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridSearhcClient.ItemCommand

        Select Case e.CommandName
            Case "Link"
                Dim QBId As Integer = lblSelectCustomer.Text
                Dim ClientId = e.CommandArgument
                LocalAPI.ActualizarClient(ClientId, "qbCustomerId", QBId)
                If (LocalAPI.IsQuickBookDesckModule(lblCompanyId.Text)) Then
                    Dim QBCustomer = LocalAPI.GetqbCustomer(QBId)
                    LocalAPI.ActualizarClient(ClientId, "qbListID", QBCustomer("ListID"))
                End If
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

    Private Sub btnConnectToQuickBooks_Click(sender As Object, e As EventArgs) Handles btnConnectToQuickBooks.Click
        Response.Redirect("~/adm/qb_refreshtoken.aspx?QBAuthBackPage=client_sync_qb")
    End Sub

    Private Sub btnDisconnectFromQuickBooks_Click(sender As Object, e As EventArgs) Handles btnDisconnectFromQuickBooks.Click
        Response.Redirect("~/adm/qb_disconnect")
    End Sub

    Private Sub btnBulkLink_Click(sender As Object, e As EventArgs) Handles btnBulkLink.Click
        Dim nRecs As Integer
        Try
            If RadGrid1.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In RadGrid1.SelectedItems
                    If dataItem.Selected Then
                        dataItem.Selected = False
                        If LinkCustomer(Val(dataItem("Id").Text), Val(dataItem("QBId").Text)) Then
                            nRecs = nRecs + 1
                        End If
                    End If
                Next
                RadGrid1.Rebind()
                RadGridLinked.Rebind()
                Master.ErrorMessage(nRecs & " Records Linked")
            Else
                Master.ErrorMessage("Select (Mark) Records to Link")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub btnBulkCopy_Click(sender As Object, e As EventArgs) Handles btnBulkCopy.Click
        Dim nRecs As Integer
        Try
            If RadGrid1.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In RadGrid1.SelectedItems
                    If dataItem.Selected Then
                        dataItem.Selected = False
                        If CopyCustomer(Val(dataItem("QBId").Text)) Then
                            nRecs = nRecs + 1
                        End If
                    End If
                Next
                RadGrid1.Rebind()
                RadGridLinked.Rebind()
                Master.ErrorMessage(nRecs & " Records Copied")
            Else
                Master.ErrorMessage("Select (Mark) Records to Copy")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub


End Class