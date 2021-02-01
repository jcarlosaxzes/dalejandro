Imports Intuit.Ipp.Data
Imports Intuit.Ipp.OAuth2PlatformClient
Imports Intuit.Ipp.QueryFilter
Imports Telerik.Web.UI

Public Class client_sync_Ebillity
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblCompanyId.Text = Session("companyId")
        End If
        If LocalAPI.IsEbilityModule(lblCompanyId.Text) Then
            btnGetCustomers.Visible = True
        Else
            btnGetCustomers.Visible = False
        End If

        RadWindowManager1.EnableViewState = False

    End Sub
#Region "Clients"



    Protected Sub btnGetCustomers_Click(sender As Object, e As EventArgs)
        System.Threading.Tasks.Task.Run(Function() EbillityApi.GetClientsAsync(lblCompanyId.Text))

    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand

        Select Case e.CommandName
            Case "Link"
                Dim ids As String() = CType(e.CommandArgument, String).Split(",")
                Dim EbillityId As Integer = ids(0)
                Dim PC_ClientId = ids(1)
                LocalAPI.CLIENT_Sync_Ebillity_Link(lblCompanyId.Text, EbillityId, PC_ClientId)

                RadGrid1.Rebind()
                RadGridLinked.Rebind()

            Case "CreateNew"
                Dim EbillityId As Integer = e.CommandArgument
                LocalAPI.Client_Sync_Ebillity_Clone(lblCompanyId.Text, EbillityId)
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
                Dim EbillityId As Integer = lblSelectCustomer.Text
                Dim PC_ClientId = e.CommandArgument

                If Val(EbillityId) > 0 And Val(PC_ClientId) > 0 Then
                    LocalAPI.CLIENT_Sync_Ebillity_Link(lblCompanyId.Text, Val(EbillityId), Val(PC_ClientId))
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
                LocalAPI.ExecuteNonQuery($"update [Clients_Sync_Ebillity] set [PC_ClientId] = null where [PC_ClientId] = {ClientId} ")
                RadGrid1.Rebind()
                RadGridLinked.Rebind()
        End Select
    End Sub

    Protected Sub btnFind_Click(sender As Object, e As EventArgs)
        RadToolTipSearchClient.Visible = True
        RadToolTipSearchClient.Show()
        RadGrid1.Rebind()
    End Sub


    Private Sub btnBulkLink_Click(sender As Object, e As EventArgs) Handles btnBulkLink.Click
        Dim nRecs As Integer
        Try
            If RadGrid1.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In RadGrid1.SelectedItems
                    If dataItem.Selected Then
                        dataItem.Selected = False
                        If Val(dataItem("ClientId").Text) > 0 And Val(dataItem("PC_ClientId").Text) > 0 Then
                            LocalAPI.CLIENT_Sync_Ebillity_Link(lblCompanyId.Text, Val(dataItem("ClientId").Text), Val(dataItem("PC_ClientId").Text))
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
                        LocalAPI.Client_Sync_Ebillity_Clone(lblCompanyId.Text, Val(dataItem("ClientId").Text))
                        nRecs = nRecs + 1
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
        System.Threading.Tasks.Task.Run(Function() EbillityApi.GetEmployeeAsync(lblCompanyId.Text))
    End Sub

    Protected Sub RadGridEmployees_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridEmployees.ItemCommand



        Select Case e.CommandName
            Case "Link"
                Dim ids As String() = CType(e.CommandArgument, String).Split(",")
                Dim EbillityId As Integer = ids(0)
                Dim EmployeeId = ids(1)

                LocalAPI.ExecuteNonQuery($"update [Employees_Sync_Ebillity] set [PC_EmployeeId] = {EmployeeId} where EmployeeId = {EbillityId}")
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
                Dim EbillityId As Integer = lblSelectEmployee.Text
                Dim EmployeeId = e.CommandArgument
                LocalAPI.ExecuteNonQuery($"update [Employees_Sync_Ebillity] set [PC_EmployeeId] = {EmployeeId} where EmployeeId = {EbillityId}")
                RadGridEmployees.Rebind()
                RadGridLinkedEmployees.Rebind()

        End Select
    End Sub

    Protected Sub RadGridLinkedEmployees_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridLinkedEmployees.ItemCommand

        Dim EmployeeId As Integer = e.CommandArgument
        Select Case e.CommandName
            Case "UnLink"
                LocalAPI.ExecuteNonQuery($"update [Employees_Sync_Ebillity] set [PC_EmployeeId] = null where EmployeeId = {EmployeeId}")
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
                        Dim EbillityId As Integer = Val(dataItem("EmployeeId").Text)
                        Dim EmployeeId = Val(dataItem("Id").Text)
                        If Val(EbillityId) > 0 And Val(EmployeeId) > 0 Then
                            LocalAPI.ExecuteNonQuery($"update [Employees_Sync_Ebillity] set [PC_EmployeeId] = {EmployeeId} where EmployeeId = {EbillityId}")

                            nRecs = nRecs + 1
                        End If
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

#Region "Project"



    Protected Sub RadGridProject_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridProject.ItemCommand

        Select Case e.CommandName
            Case "Link"
                Dim ids As String() = CType(e.CommandArgument, String).Split(",")
                Dim ClientId As Integer = ids(0)
                Dim JobId = ids(1)
                LocalAPI.ExecuteNonQuery($"update Clients_Sync_Ebillity Set PC_JobId = {JobId} where ClientId = {ClientId} and companyId={lblCompanyId.Text}")
                LocalAPI.Ebillity_Run_After_Sync(lblCompanyId.Text)
                RadGridProject.Rebind()
                RadGridLinkedProject.Rebind()

            Case "CreateNew"
                LocalAPI.CloneJobEbillity(e.CommandArgument, lblCompanyId.Text)
                LocalAPI.Ebillity_Run_After_Sync(lblCompanyId.Text)
                RadGridProject.Rebind()
                RadGridLinkedProject.Rebind()

            Case "Search"
                lblSelectProject.Text = e.CommandArgument
                RadToolTipSearchProject.Visible = True
                RadToolTipSearchProject.Show()
        End Select
    End Sub


    Protected Sub RadGridSearhcProject_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridSearhcProject.ItemCommand

        Select Case e.CommandName
            Case "Link"
                Dim ClientID As Integer = lblSelectProject.Text
                Dim JobId = e.CommandArgument
                If Val(ClientID) > 0 And Val(JobId) > 0 Then
                    LocalAPI.ExecuteNonQuery($"update Clients_Sync_Ebillity Set PC_JobId = {JobId} where ClientId = {ClientID} and companyId={lblCompanyId.Text}")
                End If
                RadToolTipSearchProject.Visible = False
                LocalAPI.Ebillity_Run_After_Sync(lblCompanyId.Text)
                RadGridProject.Rebind()
                RadGridLinkedProject.Rebind()

        End Select
    End Sub

    Private Sub btnFindJobs_Click(sender As Object, e As EventArgs) Handles btnFindJobs.Click
        RadToolTipSearchProject.Visible = True
        RadToolTipSearchProject.Show()
        RadGridProject.Rebind()
    End Sub

    Protected Sub RadGridLinkedProject_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridLinkedProject.ItemCommand

        Select Case e.CommandName
            Case "UnLink"
                Dim JobId As Integer = e.CommandArgument
                LocalAPI.ExecuteNonQuery($"update [Clients_Sync_Ebillity] set [PC_JobId] = null where [PC_JobId] = {JobId} and companyId={lblCompanyId.Text}")
                RadGridProject.Rebind()
                RadGridLinkedProject.Rebind()
        End Select
    End Sub



    Private Sub btnBulkLinkJobs_Click(sender As Object, e As EventArgs) Handles btnBulkLinkJobs.Click
        Dim nRecs As Integer
        Try
            If RadGridProject.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In RadGridProject.SelectedItems
                    If dataItem.Selected Then
                        dataItem.Selected = False
                        If Val(dataItem("ClientId").Text) > 0 And Val(dataItem("JobId").Text) > 0 Then
                            LocalAPI.ExecuteNonQuery($"update Clients_Sync_Ebillity Set PC_JobId = {Val(dataItem("JobId").Text)} where ClientId = {Val(dataItem("ClientId").Text)} and companyId = {lblCompanyId.Text}")
                            nRecs = nRecs + 1
                        End If
                    End If
                Next
                LocalAPI.Ebillity_Run_After_Sync(lblCompanyId.Text)
                RadGridProject.Rebind()
                RadGridLinkedProject.Rebind()
                Master.ErrorMessage(nRecs & " Records Linked")
            Else
                Master.ErrorMessage("Select (Mark) Records to Link")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub btnBulkCopyJobs_Click(sender As Object, e As EventArgs) Handles btnBulkCopyJobs.Click
        Dim nRecs As Integer
        Try
            If RadGridProject.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In RadGridProject.SelectedItems
                    If dataItem.Selected Then
                        dataItem.Selected = False
                        LocalAPI.CloneJobEbillity(Val(dataItem("ClientId").Text), lblCompanyId.Text)
                        nRecs = nRecs + 1
                    End If
                Next

                LocalAPI.Ebillity_Run_After_Sync(lblCompanyId.Text)
                RadGridProject.Rebind()
                RadGridLinkedProject.Rebind()
                Master.ErrorMessage(nRecs & " Records Copied")
            Else
                Master.ErrorMessage("Select (Mark) Records to Copy")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub


#End Region

#Region "TimeCategories"

    Private Sub btnGetTimeCategories_Click(sender As Object, e As EventArgs) Handles btnGetTimeCategories.Click
        System.Threading.Tasks.Task.Run(Function() EbillityApi.GetActivitiesAsync(lblCompanyId.Text))
    End Sub


    Protected Sub RadGridTimeCategories_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridTimeCategories.ItemCommand


        Select Case e.CommandName
            Case "Link"
                Dim ids As String() = CType(e.CommandArgument, String).Split(",")
                Dim ActivityId As Integer = ids(0)
                Dim PC_Time_Categories_ID = ids(1)
                LocalAPI.ExecuteNonQuery($"update  [Activity_Sync_Ebillity] set [PC_Time_Categories_ID] = {PC_Time_Categories_ID} where  [ActivityId] = {ActivityId}")

                RadGridTimeCategories.Rebind()
                RadGridLinkedTimeCategories.Rebind()

            Case "CreateNew"
                Dim ActivityId = e.CommandArgument
                LocalAPI.Activity_Sync_Ebillity_Clone(lblCompanyId.Text, ActivityId)
                RadGridTimeCategories.Rebind()
                RadGridLinkedTimeCategories.Rebind()

            Case "Search"
                lblSelectTimeCategories.Text = e.CommandArgument
                RadToolTipSearchTimeCategories.Visible = True
                RadToolTipSearchTimeCategories.Show()
        End Select
    End Sub


    Protected Sub RadGridSearhcTimeCategories_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridSearhcTimeCategories.ItemCommand

        Select Case e.CommandName
            Case "Link"
                Dim ActivityId As Integer = lblSelectTimeCategories.Text
                Dim PC_Time_Categories_ID = e.CommandArgument
                LocalAPI.ExecuteNonQuery($"update  [Activity_Sync_Ebillity] set [PC_Time_Categories_ID] = {PC_Time_Categories_ID} where  [ActivityId] = {ActivityId}")

                RadToolTipSearchTimeCategories.Visible = False
                RadGridTimeCategories.Rebind()
                RadGridLinkedTimeCategories.Rebind()

        End Select
    End Sub

    Private Sub btnFindTimeCategories_Click(sender As Object, e As EventArgs) Handles btnFindTimeCategories.Click
        RadToolTipSearchTimeCategories.Visible = True
        RadToolTipSearchTimeCategories.Show()
        RadGridTimeCategories.Rebind()
    End Sub

    Protected Sub RadGridLinkedTimeCategories_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridLinkedTimeCategories.ItemCommand

        Select Case e.CommandName
            Case "UnLink"
                Dim ActivityId As Integer = e.CommandArgument
                LocalAPI.ExecuteNonQuery($"update  [Activity_Sync_Ebillity]   set [PC_Time_Categories_ID] = null  where  [ActivityId] = {ActivityId} ")
                RadGridTimeCategories.Rebind()
                RadGridLinkedTimeCategories.Rebind()
        End Select
    End Sub

    Private Sub btnBulkLinkTimeCategories_Click(sender As Object, e As EventArgs) Handles btnBulkLinkTimeCategories.Click
        Dim nRecs As Integer
        Try
            If RadGridTimeCategories.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In RadGridTimeCategories.SelectedItems
                    If dataItem.Selected Then
                        dataItem.Selected = False
                        Dim ActivityId As Integer = Val(dataItem("ActivityId").Text)
                        Dim PC_Time_Categories_ID = Val(dataItem("PC_Time_Categories_ID").Text)
                        If Val(ActivityId) > 0 And Val(PC_Time_Categories_ID) > 0 Then
                            LocalAPI.ExecuteNonQuery($"update  [Activity_Sync_Ebillity] set [PC_Time_Categories_ID] = {PC_Time_Categories_ID} where  [ActivityId] = {ActivityId}")
                            nRecs = nRecs + 1
                        End If
                    End If
                Next
                RadGridTimeCategories.Rebind()
                RadGridLinkedTimeCategories.Rebind()
                Master.ErrorMessage(nRecs & " Records Linked")
            Else
                Master.ErrorMessage("Select (Mark) Records to Link")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub btnBulkCopyTimeCategories_Click(sender As Object, e As EventArgs) Handles btnBulkCopyTimeCategories.Click
        Dim nRecs As Integer
        Try
            If RadGridTimeCategories.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In RadGridTimeCategories.SelectedItems
                    If dataItem.Selected Then
                        dataItem.Selected = False
                        LocalAPI.Activity_Sync_Ebillity_Clone(lblCompanyId.Text, Val(dataItem("ActivityId").Text))
                        nRecs = nRecs + 1
                    End If
                Next
                RadGridTimeCategories.Rebind()
                RadGridLinkedTimeCategories.Rebind()
                Master.ErrorMessage(nRecs & " Records Copied")
            Else
                Master.ErrorMessage("Select (Mark) Records to Copy")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub



#End Region

#Region "TimeEntries"

    Private Sub btnGetTimeEntries_Click(sender As Object, e As EventArgs) Handles btnGetTimeEntries.Click
        System.Threading.Tasks.Task.Run(Function() EbillityApi.GetTimeEntriesAsync(lblCompanyId.Text))
    End Sub


#End Region


End Class