Imports Telerik.Web.UI

Public Class employees_sync_qb
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
                btnGetVendors.Visible = True
            ElseIf qbAPI.IsValidRefreshToken(lblCompanyId.Text) Then
                btnDisconnectFromQuickBooks.Visible = True
                btnConnectToQuickBooks.Visible = False
                btnGetVendors.Visible = True
                Threading.Tasks.Task.Run(Function() qbAPI.UpdateAccessTokenAsync(lblCompanyId.Text))
            Else
                btnDisconnectFromQuickBooks.Visible = False
                btnConnectToQuickBooks.Visible = True
                btnGetVendors.Visible = False
            End If
        End If



        RadWindowManager1.EnableViewState = False
    End Sub


    Private Sub btnConnectToQuickBooks_Click(sender As Object, e As EventArgs) Handles btnConnectToQuickBooks.Click
        Response.Redirect("~/adm/qb_refreshtoken.aspx?QBAuthBackPage=client_sync_qb")
    End Sub

    Private Sub btnDisconnectFromQuickBooks_Click(sender As Object, e As EventArgs) Handles btnDisconnectFromQuickBooks.Click
        Response.Redirect("~/adm/qb_disconnect")
    End Sub


    Private Sub btnGetVendors_Click(sender As Object, e As EventArgs) Handles btnGetVendors.Click
        If qbAPI.IsValidAccessToken(lblCompanyId.Text) Then
            qbAPI.LoadQBVendors(lblCompanyId.Text)
            RadGridVendors.DataBind()
        Else
            ' New Tab for QB Authentication
            Response.Redirect("~/adm/qb_refreshtoken.aspx?QBAuthBackPage=client_sync_qb")
        End If
    End Sub

    Protected Sub RadGridVendors_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridVendors.ItemCommand

        Select Case e.CommandName
            Case "Link"
                Dim ids As String() = CType(e.CommandArgument, String).Split(",")
                Dim QBId As Integer = ids(0)
                Dim VendorsId = ids(1)
                LocalAPI.ExecuteNonQuery($"update Vendors set [qbVendorsId] = {QBId} where Id = " & VendorsId)
                RadGridVendors.Rebind()
                RadGridLinkedVendors.Rebind()


            Case "Search"
                lblSelectVendors.Text = e.CommandArgument
                RadToolTipSearchVendors.Visible = True
                RadToolTipSearchVendors.Show()
        End Select
    End Sub


    Protected Sub RadGridSearhcVendors_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridSearhcVendors.ItemCommand

        Select Case e.CommandName
            Case "Link"
                Dim QBId As Integer = lblSelectVendors.Text
                Dim VendorsId = e.CommandArgument
                LocalAPI.ExecuteNonQuery($"update Vendors set [qbVendorsId] = {QBId} where Id = " & VendorsId)
                RadGridVendors.Rebind()
                RadGridLinkedVendors.Rebind()

        End Select
    End Sub

    Protected Sub RadGridLinkedVendors_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridLinkedVendors.ItemCommand

        Select Case e.CommandName
            Case "UnLink"
                Dim VendorsId As Integer = e.CommandArgument
                LocalAPI.ExecuteNonQuery($"update Vendors set [qbVendorsId] = 0 where Id = " & VendorsId)
                RadGridVendors.Rebind()
                RadGridLinkedVendors.Rebind()
        End Select
    End Sub

    Protected Sub btnFindVendors_Click(sender As Object, e As EventArgs) Handles btnFindVendors.Click
        RadToolTipSearchVendors.Visible = True
        RadToolTipSearchVendors.Show()
        RadGridVendors.Rebind()
    End Sub


    Private Sub btnBulkLinkVendors_Click(sender As Object, e As EventArgs) Handles btnBulkLinkVendors.Click
        Dim nRecs As Integer
        Try
            If RadGridVendors.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In RadGridVendors.SelectedItems
                    If dataItem.Selected Then
                        dataItem.Selected = False
                        If qbAPI.LinkCustomer(lblCompanyId.Text, Val(dataItem("Id").Text), Val(dataItem("QBId").Text)) Then
                            nRecs = nRecs + 1
                        End If
                    End If
                Next
                RadGridVendors.Rebind()
                RadGridLinkedVendors.Rebind()
                Master.ErrorMessage(nRecs & " Records Linked")
            Else
                Master.ErrorMessage("Select (Mark) Records to Link")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub btnBulkCopyVendors_Click(sender As Object, e As EventArgs) Handles btnBulkCopyVendors.Click
        Dim nRecs As Integer
        Try
            If RadGridVendors.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In RadGridVendors.SelectedItems
                    If dataItem.Selected Then
                        dataItem.Selected = False
                        If qbAPI.CopyCustomer(lblCompanyId.Text, Val(dataItem("QBId").Text)) Then
                            nRecs = nRecs + 1
                        End If
                    End If
                Next
                RadGridVendors.Rebind()
                RadGridLinkedVendors.Rebind()
                Master.ErrorMessage(nRecs & " Records Copied")
            Else
                Master.ErrorMessage("Select (Mark) Records to Copy")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub btnGetExpenses_Click(sender As Object, e As EventArgs) Handles btnGetExpenses.Click
        If qbAPI.IsValidAccessToken(lblCompanyId.Text) Then
            qbAPI.SyncInvoicesPayment(lblCompanyId.Text)
            'qbAPI.LoadQBTransactionList(lblCompanyId.Text, New DateTime(2020, 1, 1), New DateTime(2020, 9, 30))
            RadGridVendors.DataBind()
        Else
            ' New Tab for QB Authentication
            Response.Redirect("~/adm/qb_refreshtoken.aspx?QBAuthBackPage=client_sync_qb")
        End If
    End Sub
End Class