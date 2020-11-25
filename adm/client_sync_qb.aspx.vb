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
        RadDatePickerFrom.DbSelectedDate = Date.Today.Month & "/01/" & Date.Today.Year
        RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate)
        RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, RadDatePickerTo.DbSelectedDate)

    End Sub

#Region "Clients"



    Protected Sub btnGetCustomers_Click(sender As Object, e As EventArgs)
        If qbAPI.IsValidAccessOrRefreshToken(lblCompanyId.Text) Then
            System.Threading.Thread.Sleep(3000)
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
                qbAPI.LinkCustomer(lblCompanyId.Text, ClientId, QBId)
                RadGrid1.Rebind()
                RadGridLinked.Rebind()

            Case "CreateNew"
                Dim QBId As Integer = e.CommandArgument
                qbAPI.CopyCustomer(lblCompanyId.Text, QBId)
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
                        If qbAPI.LinkCustomer(lblCompanyId.Text, Val(dataItem("Id").Text), Val(dataItem("QBId").Text)) Then
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
                        If qbAPI.CopyCustomer(lblCompanyId.Text, Val(dataItem("QBId").Text)) Then
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

#End Region


#Region "Employees"

    Private Sub btnGetEmployees_Click(sender As Object, e As EventArgs) Handles btnGetEmployees.Click
        If qbAPI.IsValidAccessOrRefreshToken(lblCompanyId.Text) Then
            System.Threading.Thread.Sleep(3000)
            qbAPI.LoadQBEmployees(lblCompanyId.Text)
            RadGridEmployees.DataBind()
        Else
            ' New Tab for QB Authentication
            Response.Redirect("~/adm/qb_refreshtoken.aspx?QBAuthBackPage=client_sync_qb")
        End If
    End Sub

    Protected Sub RadGridEmployees_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridEmployees.ItemCommand

        Dim ids As String() = CType(e.CommandArgument, String).Split(",")
        Dim QBId As Integer = ids(0)
        Dim EmployeeId = ids(1)

        Select Case e.CommandName
            Case "Link"
                LocalAPI.ExecuteNonQuery($"update Employees set [qbEmployeeId] = {QBId} where Id = " & EmployeeId)
                RadGridEmployees.Rebind()
                RadGridLinkedEmployees.Rebind()
            Case "QBUpdate"
                LocalAPI.ExecuteNonQuery($"update Employees set [qbEmployeeId] = {QBId} where Id = " & EmployeeId)
                LocalAPI.ExecuteNonQuery($"UPDATE EP SET EP.[Address] = QE.[Address],EP.[Address2] = QE.[Address2],EP.[City] = QE.[City],EP.[Estate] = QE.[Estate],EP.[ZipCode] = QE.[ZipCode],EP.[Phone] = QE.PrimaryPhone,EP.[Cellular] = QE.Mobile,EP.[starting_Date] = QE.[starting_Date],EP.[HourRate] = QE.[HourRate],EP.[SS] = QE.[SS],EP.[DOB] = QE.[DOB],EP.[Gender] =case when QE.[Gender]= 'Male' then 'M' else 'F' End FROM [Employees] as EP INNER JOIN [Employees_SyncQB] As QE ON EP.qbEmployeeId = QE.QBId WHERE EP.id = {EmployeeId}")
                RadGridEmployees.Rebind()
                RadGridLinkedEmployees.Rebind()

            Case "Search"
                lblSelectEmployee.Text = e.CommandArgument
                RadToolTipSearchEmployee.Visible = True
                RadToolTipSearchEmployee.Show()
        End Select
    End Sub


    Protected Sub RadGridSearhcEmployee_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridSearhcEmployee.ItemCommand

        Select Case e.CommandName
            Case "Link"
                Dim QBId As Integer = lblSelectEmployee.Text
                Dim EmployeeId = e.CommandArgument
                LocalAPI.ExecuteNonQuery($"update Employees set [qbEmployeeId] = {QBId} where Id = " & EmployeeId)
                RadGridEmployees.Rebind()
                RadGridLinkedEmployees.Rebind()

        End Select
    End Sub

    Protected Sub RadGridLinkedEmployees_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridLinkedEmployees.ItemCommand

        Dim EmployeeId As Integer = e.CommandArgument
        Select Case e.CommandName
            Case "UnLink"
                LocalAPI.ExecuteNonQuery($"update Employees set [qbEmployeeId] = 0 where Id = " & EmployeeId)
                RadGridEmployees.Rebind()
                RadGridLinkedEmployees.Rebind()
            Case "QBUpdate"
                LocalAPI.ExecuteNonQuery($"UPDATE EP SET EP.[Address] = QE.[Address],EP.[Address2] = QE.[Address2],EP.[City] = QE.[City],EP.[Estate] = QE.[Estate],EP.[ZipCode] = QE.[ZipCode],EP.[Phone] = QE.PrimaryPhone,EP.[Cellular] = QE.Mobile,EP.[starting_Date] = QE.[starting_Date],EP.[HourRate] = QE.[HourRate],EP.[SS] = QE.[SS],EP.[DOB] = QE.[DOB],EP.[Gender] =case when QE.[Gender]= 'Male' then 'M' else 'F' End FROM [Employees] as EP INNER JOIN [Employees_SyncQB] As QE ON EP.qbEmployeeId = QE.QBId WHERE EP.id = {EmployeeId}")
                RadGridEmployees.Rebind()
                RadGridLinkedEmployees.Rebind()
        End Select
    End Sub

    Protected Sub btnFindEmployee_Click(sender As Object, e As EventArgs) Handles btnFindEmployee.Click
        RadToolTipSearchEmployee.Visible = True
        RadToolTipSearchEmployee.Show()
        RadGridEmployees.Rebind()
    End Sub

    Private Sub btnBulkLinkEmployees_Click(sender As Object, e As EventArgs) Handles btnBulkLinkEmployees.Click
        Dim nRecs As Integer
        Try
            If RadGridEmployees.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In RadGridEmployees.SelectedItems
                    If dataItem.Selected Then
                        dataItem.Selected = False
                        LocalAPI.ExecuteNonQuery($"update Employees set [qbEmployeeId] = { Val(dataItem("QBId").Text)} where Id = " & Val(dataItem("Id").Text))
                        nRecs = nRecs + 1
                    End If
                Next
                RadGridEmployees.Rebind()
                RadGridLinkedEmployees.Rebind()
                Master.ErrorMessage(nRecs & " Records Linked")
            Else
                Master.ErrorMessage("Select (Mark) Records to Link")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub
    Private Sub btnBulkLinkUpdateEmployees_Click(sender As Object, e As EventArgs) Handles btnBulkLinkUpdateEmployees.Click
        Dim nRecs As Integer
        Try
            If RadGridEmployees.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In RadGridEmployees.SelectedItems
                    If dataItem.Selected Then
                        dataItem.Selected = False
                        Dim EmployeeId = Val(dataItem("Id").Text)
                        LocalAPI.ExecuteNonQuery($"update Employees set [qbEmployeeId] = { Val(dataItem("QBId").Text)} where Id = " & EmployeeId)
                        LocalAPI.ExecuteNonQuery($"UPDATE EP SET EP.[Address] = QE.[Address],EP.[Address2] = QE.[Address2],EP.[City] = QE.[City],EP.[Estate] = QE.[Estate],EP.[ZipCode] = QE.[ZipCode],EP.[Phone] = QE.PrimaryPhone,EP.[Cellular] = QE.Mobile,EP.[starting_Date] = QE.[starting_Date],EP.[HourRate] = QE.[HourRate],EP.[SS] = QE.[SS],EP.[DOB] = QE.[DOB],EP.[Gender] =case when QE.[Gender]= 'Male' then 'M' else 'F' End FROM [Employees] as EP INNER JOIN [Employees_SyncQB] As QE ON EP.qbEmployeeId = QE.QBId WHERE EP.id = {EmployeeId}")

                        nRecs = nRecs + 1
                    End If
                Next
                RadGridEmployees.Rebind()
                RadGridLinkedEmployees.Rebind()
                Master.ErrorMessage(nRecs & " Records Linked")
            Else
                Master.ErrorMessage("Select (Mark) Records to Link")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub
#End Region





#Region "Vendors"

    Private Sub btnGetVendors_Click(sender As Object, e As EventArgs) Handles btnGetVendors.Click
        If qbAPI.IsValidAccessOrRefreshToken(lblCompanyId.Text) Then
            System.Threading.Thread.Sleep(3000)
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

            Case "CreateNew"
                Dim QBId As Integer = e.CommandArgument
                qbAPI.CopyVendor(lblCompanyId.Text, QBId)
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
                        LocalAPI.ExecuteNonQuery($"update Vendors set [qbVendorsId] = {Val(dataItem("QBId").Text)} where Id = " & Val(dataItem("Id").Text))
                        nRecs = nRecs + 1
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
                        qbAPI.CopyVendor(lblCompanyId.Text, Val(dataItem("QBId").Text))
                        nRecs = nRecs + 1
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


#End Region

    Private Sub btnSyncPayments_Click(sender As Object, e As EventArgs) Handles btnSyncPayments.Click
        If qbAPI.IsValidAccessOrRefreshToken(lblCompanyId.Text) Then
            System.Threading.Thread.Sleep(3000)
            qbAPI.SyncInvoicesPayment(lblCompanyId.Text)
            RadGridPayments.DataBind()
        Else
            ' New Tab for QB Authentication
            Response.Redirect("~/adm/qb_refreshtoken.aspx?QBAuthBackPage=client_sync_qb")
        End If
    End Sub

End Class