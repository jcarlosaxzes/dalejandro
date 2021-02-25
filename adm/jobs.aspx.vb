Imports Telerik.Web.UI

Public Class jobs
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Jobs"
            If (Not Page.IsPostBack) Then

                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_JobsList") Then Response.RedirectPermanent("~/adm/default.aspx")
                btnNew.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewJob")

                btnPrivate.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Allow_PrivateMode")
                spanViewSummary.Visible = btnPrivate.Visible
                btnExport.Visible = btnPrivate.Visible

                Master.PageTitle = "Jobs/Jobs List"
                Master.Help = "http://blog.pasconcept.com/2012/04/jobs-jobs-listhome-page.html"
                lblEmployee.Text = Master.UserEmail
                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployee.Text, lblCompanyId.Text)

                cboEmployee.DataBind()
                If Len(Session("Employee")) Then
                    cboEmployee.SelectedValue = Session("Employee")
                Else
                    cboEmployee.SelectedValue = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "FilterJob_Employee")
                End If

                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Allow_OtherEmployeeJobs") Then
                    cboEmployee.SelectedValue = lblEmployeeId.Text
                    cboEmployee.Enabled = False
                End If

                cboDepartments.DataBind()

                If LocalAPI.IsFilterClipboard(lblEmployeeId.Text, lblCompanyId.Text) Then
                    btnPasteF.Enabled = True
                Else
                    btnPasteF.Enabled = False
                End If



                If Not Request.QueryString("restoreFilter") Is Nothing Then
                    RestoreFilter()
                Else
                    DefaultUserAccountFilters()
                    ShowCheckedOneItem(lblDepartmentIdIN_List, cboDepartments)
                End If
                IniciaPeriodo(cboPeriod.SelectedValue)

                EEGvertical()

                RadGrid1.DataBind()

                SaveFilter()
            End If

            'If RadWindowManagerJob.Windows.Count > 0 Then
            '    RadWindowManagerJob.Windows.Clear()
            '    'RadGrid1.DataBind()
            'End If
            RadWindowManagerJob.EnableViewState = False
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub DefaultUserAccountFilters()
        cboPeriod.DataBind()
        cboPeriod.SelectedValue = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "FilterJob_Month")
        If Not Request.QueryString("JobIdInput") Is Nothing Then
            lblJobIdInput.Text = Request.QueryString("JobIdInput")
        End If
    End Sub
    Private Sub EEGvertical()
        If lblCompanyId.Text = 260962 Then
            panelSubbar.Visible = True
        End If

    End Sub

    Private Sub IniciaPeriodo(nPeriodo As Integer)
        cboPeriod.SelectedValue = nPeriodo
        Select Case nPeriodo
            Case 13  ' (All Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/2000"
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

            Case 15  ' (Last Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Today.Year - 1
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year - 1

            Case 16  ' (This Month)
                RadDatePickerFrom.DbSelectedDate = Today.Month & "/01/" & Today.Year
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate))
            Case 17  ' (Past Month)
                RadDatePickerFrom.DbSelectedDate = Today.Month & "/01/" & Today.Year
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Month, -1, RadDatePickerFrom.DbSelectedDate)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate))

            Case 30, 60, 90, 120, 180, 365 '   days....
                RadDatePickerTo.DbSelectedDate = Date.Today
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Day, 0 - nPeriodo, RadDatePickerTo.DbSelectedDate)

            Case 99   'Custom
                RadDatePickerFrom.Focus()
                ' Allow RadDatePicker user Values...

            Case 14  '14 and any other old setting (This Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

        End Select
    End Sub

    Public Function GetBudgetUsedImageUrl(ByVal dValue As Double) As String
        Try

            If dValue < 60 Then
                Return "~/Images/Toolbar/flag_green.png"
            ElseIf dValue < 90 Then
                Return "~/Images/Toolbar/flag_yellow.png"
            Else
                Return "~/Images/Toolbar/flag_red.png"
            End If
        Catch ex As Exception

        End Try
    End Function

    Protected Sub SqlDataSourceJobs_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceJobs.Selecting
        Dim e1 As String = e.Command.Parameters("@Employee").Value
    End Sub

    Private Sub SqlDataSourceJobs_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceJobs.Updating
        Dim e1 As String = e.Command.Parameters("@Employee").Value
    End Sub
    Private Sub SqlDataSourceJobs_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceJobs.Updated
        Dim e1 As String = e.Command.Parameters("@Employee").Value
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        Refresh()
    End Sub

    Private Sub Refresh()
        Try
            IniciaPeriodo(cboPeriod.SelectedValue)

            ShowCheckedOneItem(lblDepartmentIdIN_List, cboDepartments)

            ShowCheckedOneItemByText(lblTagIN_List, cboFilterTags)

            RadGrid1.DataBind()
            SaveFilter()

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Sub

    Private Sub SaveFilter()
        Session("Filter_Jpbs_cboPeriod") = cboPeriod.SelectedValue
        Session("Filter_Jpbs_RadDatePickerFrom") = RadDatePickerFrom.SelectedDate
        Session("Filter_Jpbs_RadDatePickerTo") = RadDatePickerTo.SelectedDate
        Session("Filter_Jpbs_cboEmployee") = cboEmployee.SelectedValue
        Session("Filter_Jpbs_cboStatus") = cboStatus.SelectedValue
        Session("Filter_Jpbs_cboClients") = cboClients.SelectedValue
        ShowCheckedOneItem(lblDepartmentIdIN_List, cboDepartments)
        Session("Filter_Jpbs_lblDepartmentIdIN_List") = lblDepartmentIdIN_List.Text
        Session("Filter_Jpbs_cboJobType") = cboJobType.SelectedValue
        Session("Filter_Jpbs_lblExcludeClientId_List") = lblExcludeClientId_List.Text
        Session("Filter_Jpbs_cboBalanceStatus") = cboBalanceStatus.SelectedValue
        Session("Filter_Jpbs_lblTagIN_List") = lblTagIN_List.Text
        Session("Filter_Jpbs_txtFind") = txtFind.Text
    End Sub

    Private Sub RestoreFilter()
        Try
            cboPeriod.DataBind()
            cboPeriod.SelectedValue = Session("Filter_Jpbs_cboPeriod")
            RadDatePickerFrom.SelectedDate = Convert.ToDateTime(Session("Filter_Jpbs_RadDatePickerFrom"))
            RadDatePickerTo.SelectedDate = Convert.ToDateTime(Session("Filter_Jpbs_RadDatePickerTo"))
            cboEmployee.SelectedValue = Session("Filter_Jpbs_cboEmployee")
            cboStatus.DataBind()
            cboStatus.SelectedValue = Session("Filter_Jpbs_cboStatus")
            cboClients.DataBind()
            cboClients.SelectedValue = Session("Filter_Jpbs_cboClients")
            lblDepartmentIdIN_List.Text = Session("Filter_Jpbs_lblDepartmentIdIN_List")
            SetCheckedOneItem(lblDepartmentIdIN_List, cboDepartments)
            cboJobType.DataBind()
            cboJobType.SelectedValue = Session("Filter_Jpbs_cboJobType")
            lblExcludeClientId_List.Text = Session("Filter_Jpbs_lblExcludeClientId_List")
            cboBalanceStatus.DataBind()
            cboBalanceStatus.SelectedValue = Session("Filter_Jpbs_cboBalanceStatus")
            lblTagIN_List.Text = Session("Filter_Jpbs_lblTagIN_List")
            txtFind.Text = Session("Filter_Jpbs_txtFind")

        Catch ex As Exception
            Dim e1 As String = ex.Message
        End Try
    End Sub

    Private Sub SetCheckedOneItem(LabelIN_List As Label, Combo1 As RadComboBox)
        Try
            If Len(LabelIN_List.Text) > 0 Then
                Dim sArrValues As String() = Split(LabelIN_List.Text, ",")
                Dim nValues As Integer = sArrValues.Length
                Dim collection As IList(Of RadComboBoxItem) = Combo1.Items
                If (collection.Count <> 0) Then
                    For Each item As RadComboBoxItem In collection
                        For i = 0 To nValues - 1
                            If item.Value = sArrValues(i) Then
                                item.Checked = True
                                Exit For
                            End If
                        Next
                    Next
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    'Protected Sub RadGrid1_BatchEditCommand(sender As Object, e As Telerik.Web.UI.GridBatchEditingEventArgs) Handles RadGrid1.BatchEditCommand
    '    For Each command As GridBatchEditingCommand In e.Commands
    '        If command.Type = GridBatchEditingCommandType.Update Then
    '            Dim newValues As Hashtable = command.NewValues
    '            Dim oldValues As Hashtable = command.OldValues
    '            Dim employee As Integer = newValues("Employee").ToString
    '            Dim status As Integer = newValues("Status").ToString
    '            Dim ID As Integer = oldValues("Id").ToString
    '        End If
    '    Next

    'End Sub
    'Protected Sub RadGrid1_ItemUpdated(source As Object, e As Telerik.Web.UI.GridUpdatedEventArgs) Handles RadGrid1.ItemUpdated
    '    Try

    '        Dim item As GridEditableItem = DirectCast(e.Item, GridEditableItem)
    '        Dim id As [String] = item.GetDataKeyValue("Id").ToString()
    '        If e.Exception IsNot Nothing Then
    '            e.KeepInEditMode = True
    '            e.ExceptionHandled = True
    '            Master.ErrorMessage("Employeeassign error: " & e.Exception.Message)
    '        Else
    '            'Master.InfoMessage("Employee with ID " + id + " is Assigned!")
    '        End If

    '    Catch ex As Exception
    '        Master.ErrorMessage("Error. " & ex.Message)
    '    End Try
    'End Sub

    Protected Sub RadGrid1_PreRender(sender As Object, e As EventArgs) Handles RadGrid1.PreRender
        Try

            If lblCompanyId.Text = 260962 Then 'EEG vertica
                RadGrid1.MasterTableView.GetColumn("ClientSelectColumn").Visible = True
                'RadGrid1.MasterTableView.GetColumn("Type").Visible = False
                'RadGrid1.MasterTableView.GetColumn("Balance").Visible = False
                'RadGrid1.MasterTableView.GetColumn("Coste").Visible = False
                'RadGrid1.MasterTableView.GetColumn("Employee").Visible = False
                'RadGrid1.MasterTableView.GetColumn("Open_date").Visible = False

            End If
        Catch ex As Exception

        End Try
    End Sub

    Public Function urlRPFList(jobCode As String, dValue As Double) As String
        If dValue > 0 Then
            Return "~/ADM/RequestForProposals.aspx?BasicMP=1&Find=" & jobCode
        End If

    End Function

    Private Sub ShowCheckedOneItem(LabelIN_List As Label, Combo1 As RadComboBox)
        ' Companies...............................
        LabelIN_List.Text = ""
        Dim collection As IList(Of RadComboBoxItem) = Combo1.CheckedItems
        If (collection.Count <> 0) Then

            For Each item As RadComboBoxItem In collection
                LabelIN_List.Text = LabelIN_List.Text + item.Value + ","
            Next
            ' Quitar la ultima coma
            LabelIN_List.Text = Left(LabelIN_List.Text, Len(LabelIN_List.Text) - 1)
        End If
    End Sub
    Private Sub ShowCheckedOneItemByText(LabelIN_List As Label, Combo1 As RadComboBox)
        ' Companies...............................
        LabelIN_List.Text = ""
        Dim collection As IList(Of RadComboBoxItem) = Combo1.CheckedItems
        If (collection.Count <> 0) Then

            For Each item As RadComboBoxItem In collection
                LabelIN_List.Text = LabelIN_List.Text + item.Text + ","
            Next
            ' Quitar la ultima coma
            LabelIN_List.Text = Left(LabelIN_List.Text, Len(LabelIN_List.Text) - 1)
        End If
    End Sub

    Protected Sub cboDepartments_ItemDataBound(sender As Object, e As RadComboBoxItemEventArgs) Handles cboDepartments.ItemDataBound
        Dim nDefaultDep As Integer = LocalAPI.GetEmployeeProperty(LocalAPI.GetEmployeeId(lblEmployee.Text, lblCompanyId.Text), "FilterJob_Department")
        If nDefaultDep > 0 Then
            If e.Item.Value = nDefaultDep Then
                ' Seleccionar un Job type
                e.Item.Checked = True
            End If
        End If
    End Sub

    Public Function GetCollectedPercent(ByVal dBudget As Double, dCollected As Double) As Double
        Dim dPercent As Double
        If dBudget > 0 Then
            dPercent = dCollected * 100 / dBudget
        End If
        Return Math.Round(dPercent, 0)
    End Function

    Public Function GetFontColor(ByVal dPercent As Double) As System.Drawing.Color
        If dPercent < 75 Then
            Return System.Drawing.Color.Black
        Else
            Return System.Drawing.Color.Yellow
        End If

    End Function
    Public Function GetJobStatusCss(ByVal StatusId As Integer) As String
        Select Case StatusId
            Case 0  'Not in Progress
                Return "NotInProgress"
            Case 1  'Inactive
                Return "Inactive"
            Case 2  'In Progress
                Return "InProgress"
            Case 3  'On Hold
                Return "OnHold"
            Case 4  'Submitted
                Return "lnkNotInProgress"
            Case 5  'UnderRevision
                Return "UnderRevision"
            Case 6  'Approved
                Return "Approved"
            Case 7  'Done
                Return "Done"
        End Select
    End Function
    Public Function GetFormatString(ByVal Coste As String, Profit As String) As String
        Try
            Return Coste & StrDup(12 - (Len(Coste) + Len(Profit)), "_") & Profit & "%"
        Catch ex As Exception

        End Try

    End Function

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand

        Select Case e.CommandName
            Case "View/Edit Info", "View/Edit Billing", "View/Edit Client Profile", "View/Edit Employees", "View/Edit Proposal(s)", "View/Edit Expenses", "View/Edit Notes", "View/Edit Time Entries", "View/Edit Files", "View Schedule", "View/Edit Revisions", "View/Edit Tickets", "View/Edit Transmittals", "Update Status", "Add Time"
                FireJobCommand(e.CommandName, e.CommandArgument)
            Case "AddCalendar"
                Response.Redirect($"~/adm/appointment?Id=&EntityType=Job&EntityId={e.CommandArgument}&backpage=Jobs")

            Case "AddNotifications"
                Response.Redirect($"~/adm/notificationsnew.aspx?AppointmentId=&EntityType=Job&EntityId={e.CommandArgument}&backpage=Jobs")

            Case "Hide Client"
                Dim ClientId As Integer = e.CommandArgument
                If ClientId > 0 Then
                    lblExcludeClientId_List.Text = lblExcludeClientId_List.Text & IIf(Len(lblExcludeClientId_List.Text) > 0, ",", "") & ClientId
                    btnClientUnhide.Visible = True
                    Refresh()
                End If

            Case "AddActivity"
                lblSelectedJobId.Text = e.CommandArgument
                lblSelectedClientId.Text = LocalAPI.GetJobProperty(lblSelectedJobId.Text, "Client")
                NewClientActivityDlg(True)

        End Select
    End Sub

    Private Sub FireJobCommand(CommandName As String, JobId As Integer)
        Try
            Dim sUrl As String
            Select Case CommandName
                Case "View/Edit Info"
                    sUrl = LocalAPI.GetSharedLink_URL(8001, JobId) & "&backpage=jobs"
                    Response.Redirect(sUrl)

                Case "View/Edit Billing"
                    sUrl = LocalAPI.GetSharedLink_URL(8002, JobId) & "&backpage=jobs"
                    Response.Redirect(sUrl)

                Case "View/Edit Employees"
                    sUrl = LocalAPI.GetSharedLink_URL(8003, JobId) & "&backpage=jobs"
                    Response.Redirect(sUrl)

                Case "View/Edit Proposal(s)"
                    sUrl = LocalAPI.GetSharedLink_URL(8004, JobId) & "&backpage=jobs"
                    Response.Redirect(sUrl)

                Case "View/Edit Expenses"
                    sUrl = LocalAPI.GetSharedLink_URL(8005, JobId) & "&backpage=jobs"
                    Response.Redirect(sUrl)

                Case "View/Edit Notes"
                    sUrl = LocalAPI.GetSharedLink_URL(8006, JobId) & "&backpage=jobs"
                    Response.Redirect(sUrl)

                Case "View/Edit Time Entries"
                    sUrl = LocalAPI.GetSharedLink_URL(8007, JobId) & "&backpage=jobs"
                    Response.Redirect(sUrl)

                Case "View/Edit Files"
                    sUrl = LocalAPI.GetSharedLink_URL(8008, JobId) & "&backpage=jobs"
                    Response.Redirect(sUrl)

                Case "View Schedule"
                    sUrl = LocalAPI.GetSharedLink_URL(8009, JobId) & "&backpage=jobs"
                    Response.Redirect(sUrl)

                Case "View/Edit Revisions"
                    sUrl = LocalAPI.GetSharedLink_URL(8010, JobId) & "&backpage=jobs"
                    Response.Redirect(sUrl)

                Case "View/Edit Tickets"
                    Response.Redirect($"~/adm/JobTickets.aspx?JobId={JobId}")

                Case "View/Edit Tags"
                    sUrl = LocalAPI.GetSharedLink_URL(8011, JobId) & "&backpage=jobs"
                    Response.Redirect(sUrl)

                Case "View/Edit Transmittals"
                    sUrl = LocalAPI.GetSharedLink_URL(8012, JobId) & "&backpage=jobs"
                    Response.Redirect(sUrl)

                Case "Update Status"
                    lblSelectedJobId.Text = JobId
                    cboJobNewStatus.DataBind()
                    RadToolTipJobStatus.Visible = True
                    RadToolTipJobStatus.Show()

                Case "View/Edit Client Profile"
                    Dim ClientId As Integer = LocalAPI.GetJobProperty(JobId, "Client")
                    sUrl = $"~/ADM/Client.aspx?clientId={ClientId}&Dialog=1"
                    CreateRadWindows(CommandName, sUrl, 970, 750, False, False)

                Case "Job Print View"
                    Dim guid As String = LocalAPI.GetJobProperty(JobId, "guid")
                    sUrl = "~/e2103445_8a47_49ff_808e_6008c0fe13a1/job.aspx?guid=" & guid
                    CreateRadWindows(CommandName, sUrl, 1024, 820, True, False)

                Case "Hide Client"
                    Dim ClientId As Integer = LocalAPI.GetJobProperty(JobId, "Client")
                    If ClientId > 0 Then
                        lblExcludeClientId_List.Text = lblExcludeClientId_List.Text & IIf(Len(lblExcludeClientId_List.Text) > 0, ",", "") & ClientId
                        btnClientUnhide.Visible = True
                        Refresh()
                    End If

                Case "Add Time"
                    If cboEmployee.SelectedValue > 0 Then
                        Session("employeefortime") = cboEmployee.SelectedValue
                    End If
                    sUrl = "~/ADM/EmployeeNewTime.aspx?JobId=" & JobId & "&backpage=jobs"
                    Response.Redirect(sUrl)




            End Select
        Catch ex As Exception

        End Try
    End Sub

    Private Sub ConfigureExport_csv()
        RadGridToPrint.AllowPaging = False
        RadGridToPrint.ExportSettings.FileName = "PASConcept_Jobs_" & Format(Date.Today, "MM-dd-yyyy")
        RadGridToPrint.ExportSettings.ExportOnlyData = True
        RadGridToPrint.ExportSettings.IgnorePaging = True
        RadGridToPrint.ExportSettings.OpenInNewWindow = True
    End Sub

    Protected Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click

        ConfigureExport_csv()
        RadGridToPrint.MasterTableView.ExportToCSV()

    End Sub

    Private Sub PrintPopUp()
        Try
            RadWindowManagerPrint.Windows.Clear()
            Dim window1 As RadWindow = New RadWindow()
            window1.NavigateUrl = "~/ADM/jobsreport.aspx"
            'window1.NavigateUrl = "~/temp/default2.aspx"
            window1.VisibleOnPageLoad = True
            window1.VisibleStatusbar = False
            window1.ID = "print"
            window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
            window1.Width = 960
            window1.Height = 700
            window1.Modal = True
            window1.DestroyOnClose = True
            RadWindowManagerPrint.Windows.Add(window1)
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean, bRefreshOnClose As Boolean)
        Try

            RadWindowManagerJob.Windows.Clear()
            Dim window1 As RadWindow = New RadWindow()
            window1.NavigateUrl = sUrl
            window1.VisibleOnPageLoad = True
            window1.VisibleStatusbar = False
            window1.ID = WindowsID
            If Maximize Then window1.InitialBehaviors = WindowBehaviors.Maximize
            window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
            window1.Width = Width
            window1.Height = Height
            window1.Modal = True
            window1.DestroyOnClose = True
            If bRefreshOnClose Then window1.OnClientClose = "OnClientClose"
            window1.ShowOnTopWhenMaximized = Maximize
            RadWindowManagerJob.Windows.Add(window1)
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        Try
            Response.Redirect("~/adm/newjob.aspx")
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub RadGrid1_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles RadGrid1.ItemDataBound
        Try

            If TypeOf e.Item Is GridDataItem Then
                Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
                'Set Acction to Combo box
                Dim jobId As Integer = item("Id").Text

                Dim lblBalanceSymbol As Label = DirectCast(item.FindControl("lblBalanceSymbol"), Label)
                If DirectCast(item.FindControl("lblBalance"), Label).Text <> 0 Then
                    Dim lEmitted As Integer = LocalAPI.GetInvoiceEmmited(jobId)
                    Select Case lEmitted
                        Case 0  '"~/Images/Toolbar/white_circle.png"
                            lblBalanceSymbol.ForeColor = System.Drawing.Color.Blue
                            lblBalanceSymbol.ToolTip = "Blue. Existing Pending Balance, Invoice Not Emitted"

                        Case 1  '"~/Images/Toolbar/green_circle.png"
                            lblBalanceSymbol.ForeColor = System.Drawing.Color.Green
                            lblBalanceSymbol.ToolTip = "Green. Existing Pending Balance, Invoice Emitted One Time"

                        Case 2  '"~/Images/Toolbar/yellow_circle.png"
                            lblBalanceSymbol.ForeColor = System.Drawing.Color.Orange
                            lblBalanceSymbol.ToolTip = "Orange. Existing Pending Balance, Invoice Emitted Two Times"

                        Case Else   '"~/Images/Toolbar/red_circle.png"
                            lblBalanceSymbol.ForeColor = System.Drawing.Color.Red
                            lblBalanceSymbol.ToolTip = "Red. Existing Pending Balance, Invoice Emitted Three Time"
                    End Select
                Else
                    ' Balance = 0
                    If DirectCast(item.FindControl("lblBudget"), Label).Text = DirectCast(item.FindControl("lblJobBilledAmount"), Label).Text Then
                        ' Budget = SUM(Invoice Amount)
                        lblBalanceSymbol.ForeColor = System.Drawing.Color.Black
                        lblBalanceSymbol.ToolTip = "Black. Closed and Paid in Full."
                    Else
                        ' Budget <> SUM(Invoice Amount)
                        lblBalanceSymbol.ForeColor = System.Drawing.Color.Purple
                        lblBalanceSymbol.ToolTip = "Purple. Warning: No Pending Balance but Budget is Not Equal to the Billed Amount"
                    End If
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    'Protected Sub btnHideClient_Click(ByVal sender As Object, ByVal e As System.EventArgs)
    '    Try
    '        Dim ClientId As Integer = CType(sender, ImageButton).CommandArgument
    '        If ClientId > 0 Then
    '            lblExcludeClientId_List.Text = lblExcludeClientId_List.Text & IIf(Len(lblExcludeClientId_List.Text) > 0, ",", "") & ClientId
    '            btnClientUnhide.Visible = True
    '            Refresh()
    '        End If
    '    Catch ex As Exception

    '    End Try
    'End Sub

    Protected Sub btnClientUnhide_Click(sender As Object, e As EventArgs) Handles btnClientUnhide.Click
        lblExcludeClientId_List.Text = ""
        Refresh()
    End Sub

    Private Sub CopyFilterToEmployeeClipboard(employeeId As Integer)
        Try

            LocalAPI.ClearFilterClipboard(employeeId, lblCompanyId.Text)
            LocalAPI.CopyIntFilterClipboard(employeeId, 2, cboPeriod.SelectedValue, lblCompanyId.Text)
            LocalAPI.CopyIntFilterClipboard(employeeId, 3, cboEmployee.SelectedValue, lblCompanyId.Text)
            LocalAPI.CopyIntFilterClipboard(employeeId, 4, cboStatus.SelectedValue, lblCompanyId.Text)
            LocalAPI.CopyIntFilterClipboard(employeeId, 5, cboClients.SelectedValue, lblCompanyId.Text)
            LocalAPI.CopyIntFilterClipboard(employeeId, 6, cboJobType.SelectedValue, lblCompanyId.Text)
            LocalAPI.CopyTextFilterClipboard(employeeId, 7, lblDepartmentIdIN_List.Text, lblCompanyId.Text)
            LocalAPI.CopyIntFilterClipboard(employeeId, 8, cboBalanceStatus.SelectedValue, lblCompanyId.Text)
            LocalAPI.CopyTextFilterClipboard(employeeId, 9, txtFind.Text, lblCompanyId.Text)
            LocalAPI.CopyTextFilterClipboard(employeeId, 10, lblExcludeClientId_List.Text, lblCompanyId.Text)

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnCopyF_Click(sender As Object, e As EventArgs) Handles btnCopyF.Click
        CopyFilterToEmployeeClipboard(lblEmployeeId.Text)
        btnPasteF.Enabled = True
        Master.InfoMessage("Filters copied to clipboard")
    End Sub

    Protected Sub btnPasteF_Click(sender As Object, e As EventArgs) Handles btnPasteF.Click
        Try
            If LocalAPI.IsFilterClipboard(lblEmployeeId.Text, lblCompanyId.Text) Then
                cboPeriod.SelectedValue = LocalAPI.GetIntFilterClipboard(lblEmployeeId.Text, 2, lblCompanyId.Text)
                cboEmployee.SelectedValue = LocalAPI.GetIntFilterClipboard(lblEmployeeId.Text, 3, lblCompanyId.Text)
                cboStatus.SelectedValue = LocalAPI.GetIntFilterClipboard(lblEmployeeId.Text, 4, lblCompanyId.Text)
                cboClients.SelectedValue = LocalAPI.GetIntFilterClipboard(lblEmployeeId.Text, 5, lblCompanyId.Text)
                cboJobType.SelectedValue = LocalAPI.GetIntFilterClipboard(lblEmployeeId.Text, 6, lblCompanyId.Text)
                lblDepartmentIdIN_List.Text = LocalAPI.GetTextFilterClipboard(lblEmployeeId.Text, 7, lblCompanyId.Text)
                cboBalanceStatus.SelectedValue = LocalAPI.GetIntFilterClipboard(lblEmployeeId.Text, 8, lblCompanyId.Text)
                txtFind.Text = LocalAPI.GetTextFilterClipboard(lblEmployeeId.Text, 9, lblCompanyId.Text)
                lblExcludeClientId_List.Text = LocalAPI.GetTextFilterClipboard(lblEmployeeId.Text, 10, lblCompanyId.Text)

                Refresh()

            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnUpdateJobStatus_Click(sender As Object, e As EventArgs) Handles btnUpdateJobStatus.Click
        ' Actualizar cambios de status
        LocalAPI.SetJobStatus(lblSelectedJobId.Text, cboJobNewStatus.SelectedValue, lblEmployeeId.Text, lblCompanyId.Text, lblEmployeeId.Text)
        RadToolTipJobStatus.Visible = False

        Refresh()
    End Sub
    Protected Sub btnCanceUpdateJobStatus_Click(sender As Object, e As EventArgs) Handles btnCanceUpdateJobStatus.Click
        RadToolTipJobStatus.Visible = False
    End Sub

    Protected Sub RadGrid1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadGrid1.DataBound
        Try
            Dim footerItem As GridFooterItem = RadGrid1.MasterTableView.GetItems(GridItemType.Footer)(0)
            lblTotalBudget.Text = footerItem("Budget").Text
            lblTotalBilled.Text = footerItem("Billed").Text
            lblTotalCollected.Text = footerItem("Collected").Text
            LabelblTotalBalance.Text = footerItem("Balance").Text
            lblTotalSubFees.Text = footerItem("SubFees").Text

            lblTotalBudgetUsed.Text = footerItem("BudgetUsed").Text
        Catch ex As Exception

        End Try
    End Sub

    Private Sub btnShare_Click(sender As Object, e As EventArgs) Handles btnShare.Click
        txtShareFilter.Text = LocalAPI.GetEmployeeFullName(lblEmployee.Text, lblCompanyId.Text) & " has Shared a filter setting with you. To apply click the 'Get' button from your Job List filter settings."
        RadToolTipShareFilter.Visible = True
        RadToolTipShareFilter.Show()
    End Sub

    Protected Sub btnShareF_Click(sender As Object, e As EventArgs) Handles btnShareF.Click
        Try
            CopyFilterToEmployeeClipboard(cboEmployeeShare.SelectedValue)
            Dim sTo As String = LocalAPI.GetEmployeeEmail(cboEmployeeShare.SelectedValue)
            Dim sBody As String = txtShareFilter.Text
            Dim clientId = LocalAPI.GetJobProperty(lblSelectedJobId.Text, "Client")

            SendGrid.Email.SendMail(sTo, lblEmployee.Text, "", "PASconcept. Share filter setting with you", sBody, lblCompanyId.Text, clientId, lblSelectedJobId.Text,, LocalAPI.GetEmployeeFullName(lblEmployee.Text, lblCompanyId.Text), lblEmployee.Text)
            Master.InfoMessage("Filters shared with employee")

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub btnApplyStatus_Click(sender As Object, e As EventArgs) Handles btnApplyStatus.Click
        If RadGrid1.SelectedItems.Count > 0 And cboStatusLotes.SelectedValue >= 0 Then
            Dim nSelecteds As Integer = RadGrid1.SelectedItems.Count
            For Each dataItem As GridDataItem In RadGrid1.SelectedItems

                If dataItem.Selected Then
                    lblSelectedJobId.Text = dataItem("Id").Text
                    dataItem.Selected = False
                    LocalAPI.SetJobStatus(lblSelectedJobId.Text, cboStatusLotes.SelectedValue, lblEmployeeId.Text, lblCompanyId.Text, lblEmployeeId.Text, False)
                End If
            Next
            cboStatusLotes.SelectedValue = -1
            Master.InfoMessage(cboStatusLotes.SelectedItem.Text & " status was assigned to " & nSelecteds & " selected Jobs")
            Refresh()
        Else
            Master.ErrorMessage("You must to select records previously!")
        End If

    End Sub

    Private Sub SqlDataSourceJobs_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceJobs.Deleting
        Try
            Dim jobId As Integer = e.Command.Parameters("@Id").Value
            Dim Notes As String = LocalAPI.GetJobCodeName(jobId)
            LocalAPI.sys_log_Nuevo(Master.UserEmail, LocalAPI.sys_log_AccionENUM.DeleteProposal, lblCompanyId.Text, "Delete Job: " & Notes)
        Catch ex As Exception
        End Try
    End Sub

#Region "Activity"
    Private Sub NewClientActivityDlg(bInitDlg As Boolean)
        If bInitDlg Then
            cboActivityEmployees.SelectedValue = lblEmployeeId.Text
            RadDateTimePickerActivityDueDate.DbSelectedDate = DateAdd(DateInterval.Hour, 24, Now)
            cboActivityType.SelectedValue = -1
            lblClientName.Text = LocalAPI.GetClientProperty(lblSelectedClientId.Text, "Client")
            txtActivitySubject.Text = ""
        End If

        RadToolTipNewActivity.Visible = True
        RadToolTipNewActivity.Show()
    End Sub

    Private Sub btnAddActivity_Click(sender As Object, e As EventArgs) Handles btnAddActivity.Click
        Try
            ' Insert new Activity
            Dim EndDate As DateTime = DateAdd(DateInterval.Minute, CInt(cboActivityDuration.SelectedValue), RadDateTimePickerActivityDueDate.DbSelectedDate)
            Dim ActivityId As Integer = LocalAPI.Activity_INSERT(txtActivitySubject.Text, RadDateTimePickerActivityDueDate.DbSelectedDate, EndDate, cboActivityType.SelectedValue, cboActivityEmployees.SelectedValue, lblSelectedClientId.Text, 0, 0, lblSelectedJobId.Text, lblCompanyId.Text, 1, txtActivityDescription.Text)
            If chkMoreOptions.Checked Then
                Response.Redirect($"~/adm/appointment?Id={ActivityId}&EntityType=Jobs&EntityId={lblSelectedJobId.Text}&backpage=Jobs")
            Else
                Master.InfoMessage("The Activity was inserted successfully!")
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

#End Region
End Class