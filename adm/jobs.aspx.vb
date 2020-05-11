Imports Telerik.Web.UI

Public Class jobs
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Jobs List"
            If (Not Page.IsPostBack) Then

                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_JobsList") Then Response.RedirectPermanent("~/ADM/Default.aspx")
                btnNew.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewJob")

                btnPrivate.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Budget")
                panelTotals.Visible = btnPrivate.Visible

                Master.PageTitle = "Jobs/Jobs List"
                Master.Help = "http://blog.pasconcept.com/2012/04/jobs-jobs-listhome-page.html"
                lblEmployee.Text = Master.UserEmail
                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployee.Text, lblCompanyId.Text)

                LocalAPI.RefreshYearsList()

                cboPeriod.DataBind()
                cboPeriod.SelectedValue = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "FilterJob_Month")
                IniciaPeriodo(cboPeriod.SelectedValue)

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

                ShowCheckedOneItem(lblDepartmentIdIN_List, cboDepartments)

                SqlDataSourceJobs.DataBind()
            End If

            If RadWindowManagerJob.Windows.Count > 0 Then
                RadWindowManagerJob.Windows.Clear()
                RadGrid1.DataBind()
            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Sub IniciaPeriodo(nPeriodo As Integer)
        Select Case nPeriodo
            Case 13  ' (All Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/2000"
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

            Case 15  ' (Last Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Today.Year - 1
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year - 1

            Case 30, 60, 90, 120, 180, 365 '   days....
                RadDatePickerTo.DbSelectedDate = Date.Today
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Day, 0 - nPeriodo, RadDatePickerTo.DbSelectedDate)

            Case 99   'Custom
                ' Allow RadDatePicker user Values...

            Case 14  '14 and any other old setting (This Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

        End Select
        cboPeriod.SelectedValue = nPeriodo
    End Sub

    Protected Sub cboStatusLotes_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboStatusLotes.SelectedIndexChanged
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

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
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

            If LocalAPI.IsTabletOrSmarthphone(Request.UserAgent) Then
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

    Public Function GetBudgetUsedCss(ByVal dPercent As Double) As String
        If dPercent < 25 Then
            Return "GreenYellowProgressBar"
        ElseIf dPercent < 50 Then
            Return "GreenProgressBar"
        ElseIf dPercent < 75 Then
            Return "OrangeProgressBar" 'System.Drawing.Color.Orange
        ElseIf dPercent < 100 Then
            Return "OrangeRedProgressBar" 'System.Drawing.Color.OrangeRed
        Else
            Return "RedProgressBar" 'System.Drawing.Color.DarkRed
        End If
    End Function

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
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditJob"
                sUrl = "~/ADM/Job_job.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True, True)

            Case "Accounting"
                sUrl = "~/ADM/Job_accounting.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True, True)

            Case "Images"
                sUrl = "~/ADM/Job_images_files.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True, False)

            Case "JobTimes"
                sUrl = "~/ADM/Job_times.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True, True)

            Case "Notes"
                sUrl = "~/ADM/Job_notes.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True, True)

            Case "JobTags"
                sUrl = "~/ADM/Job_tags.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True, True)

            Case "GetSharedLink"
                sUrl = "~/adm/sharelink.aspx?ObjType=2&ObjId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 520, 400, False, False)

            Case "EditClient"
                sUrl = "~/ADM/Client.aspx?clientId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 850, 750, False, False)

            Case "Tags"
                sUrl = "~/ADM/Job_tags.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True, False)

            Case "AzureUpload"
                sUrl = "~/ADM/Job_links.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True, False)
                'sUrl = "~/ADM/AzureStorage.aspx?JobId=" & e.CommandArgument

            Case "HideClient"
                Dim ClientId As Integer = e.CommandArgument
                If ClientId > 0 Then
                    lblExcludeClientId_List.Text = lblExcludeClientId_List.Text & IIf(Len(lblExcludeClientId_List.Text) > 0, ",", "") & ClientId
                    btnUnhide.Visible = True
                    Refresh()
                End If

            Case "SetEmployee"
                sUrl = "~/ADM/Job_employees.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True, True)
                'sUrl = "~/ADM/JobAssignEmployee.aspx?JobId=" & e.CommandArgument
                'CreateRadWindows(e.CommandName, sUrl, 850, 650, False, True)

            Case "EditStatus"
                lblSelectedJobId.Text = e.CommandArgument
                cboJobNewStatus.DataBind()
                RadToolTipJobStatus.Visible = True
                RadToolTipJobStatus.Show()

            Case "NewTime"
                sUrl = "~/ADM/EmployeeNewTime.aspx?JobId=" & e.CommandArgument & "&Dialog=1"
                CreateRadWindows(e.CommandName, sUrl, 1024, 820, True, False)

        End Select
    End Sub

    Protected Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click
        CopyFilterToEmployeeClipboard(lblEmployeeId.Text)
        PrintPopUp()
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
            CreateRadWindows("NewJob", "~/ADM/newjob.aspx", 800, 720, False, True)
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub RadGrid1_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles RadGrid1.ItemDataBound
        Try

            If TypeOf e.Item Is GridDataItem Then
                Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
                Dim Label1 As Label = DirectCast(item.FindControl("lblJobInvoiceAmount"), Label)
                If DirectCast(item.FindControl("lblBalance"), Label).Text <> 0 Then
                    Dim jobId As Integer = item("Id").Text
                    Dim lEmitted As Integer = LocalAPI.GetInvoiceEmmited(jobId)
                    Select Case lEmitted
                        Case 0  '"~/Images/Toolbar/white_circle.png"
                            Label1.BackColor = System.Drawing.Color.Blue
                            Label1.ToolTip = "Blue. Balance>0 and Amount Due<>0 and Emitted=0"

                        Case 1  '"~/Images/Toolbar/green_circle.png"
                            Label1.BackColor = System.Drawing.Color.Green
                            Label1.ToolTip = "Green. Balance>0 and Amount Due<>0 and Emitted=1"

                        Case 2  '"~/Images/Toolbar/yellow_circle.png"
                            Label1.BackColor = System.Drawing.Color.Orange
                            Label1.ToolTip = "Orange. Balance>0 and Amount Due<>0 and Emitted=2"

                        Case Else   '"~/Images/Toolbar/red_circle.png"
                            Label1.BackColor = System.Drawing.Color.OrangeRed
                            Label1.ToolTip = "OrangeRed. Balance>0 and Amount Due<>0 and Emitted>=3"
                    End Select
                Else
                    ' Balance = 0
                    If DirectCast(item.FindControl("lblBudget"), Label).Text = DirectCast(item.FindControl("lblJobInvoiceAmount"), Label).Text Then
                        ' Budget = SUM(Invoice Amount)
                        Label1.BackColor = System.Drawing.Color.Black
                        Label1.ToolTip = "Black. Close, Balance=0 and JobBudget=SUM(Invoice Amount)"
                    Else
                        ' Budget <> SUM(Invoice Amount)
                        Label1.BackColor = System.Drawing.Color.Purple
                        Label1.ToolTip = "Purple. ? Balance=0 but JobBudget<>SUM(Invoice Amount)"
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
    '            btnUnhide.Visible = True
    '            Refresh()
    '        End If
    '    Catch ex As Exception

    '    End Try
    'End Sub

    Protected Sub btnUnhide_Click(sender As Object, e As EventArgs) Handles btnUnhide.Click
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
            lblTotalBilled.Text = footerItem("JobInvoiceAmountHide").Text
            lblTotalCollected.Text = footerItem("CollectedtHide").Text
            lblTotalPending.Text = footerItem("JobInvoiceAmountPendingHide").Text
            LabelblTotalBalance.Text = footerItem("Balance").Text
            lblTotalSubContract.Text = footerItem("SubContractHide").Text
        Catch ex As Exception

        End Try
    End Sub

    Private Sub btnShare_Click(sender As Object, e As EventArgs) Handles btnShare.Click
        txtShareFilter.Text = LocalAPI.GetEmployeeFullName(lblEmployee.Text) & " has Shared a filter setting with you. To apply click the 'Get' button from your Job List filter settings."
        RadToolTipShareFilter.Visible = True
        RadToolTipShareFilter.Show()
    End Sub

    Protected Sub btnShareF_Click(sender As Object, e As EventArgs) Handles btnShareF.Click
        Try
            CopyFilterToEmployeeClipboard(cboEmployeeShare.SelectedValue)
            Dim sTo As String = LocalAPI.GetEmployeeEmail(cboEmployeeShare.SelectedValue)
            Dim sBody As String = txtShareFilter.Text

            LocalAPI.SendMail(sTo, lblEmployee.Text, "", "PASconcept. Share filter setting with you", sBody, lblCompanyId.Text,, LocalAPI.GetEmployeeFullName(lblEmployee.Text), lblEmployee.Text)
            Master.InfoMessage("Filters shared with employee")

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

End Class