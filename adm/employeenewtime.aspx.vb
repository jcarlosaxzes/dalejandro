Imports Telerik.Web.UI
Public Class employeenewtime
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". New Time"
            Master.PageTitle = "Employee New Time"
            If Not IsPostBack Then
                lblCompanyId.Text = Session("companyId")
                lblLogedEmployeeId.Text = Master.UserId

                If Not Session("employeefortime") Is Nothing Then
                    lblEmployeeId.Text = Session("employeefortime")
                Else
                    lblEmployeeId.Text = lblLogedEmployeeId.Text
                End If

                lblSelectedJob.Text = Request.QueryString("JobId")
                lblEmployeeName.Text = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "FullName")

                lblClientId.Text = LocalAPI.GetJobProperty(lblSelectedJob.Text, "Client")

                cboCategory.DataBind()

                If Not Request.QueryString("JobTicketId") Is Nothing Then
                    lblSelectedTicket.Text = Request.QueryString("JobTicketId")
                End If

                If Not Request.QueryString("Dialog") Is Nothing Then
                    Master.HideMasterMenu()
                    btnBack.Visible = False
                End If
                If Not Request.QueryString("HideMenu") Is Nothing Then
                    Master.HideMasterMenu()
                End If

                If Not Request.QueryString("backpage") Is Nothing Then
                    Session("employeenewtimebackpage") = Request.QueryString("backpage")
                Else
                    Session("employeenewtimebackpage") = ""
                End If

                'RadScheduler1.Visible = (lblCompanyId.Text = 260973 Or lblCompanyId.Text = 99)

                InitDialog()

            End If

        Catch ex As Exception
        End Try
    End Sub

    Private Sub InitDialog()
        Try
            cboJobStatus.DataBind()
            cboJobStatus.SelectedValue = -1
            txtDescription.Text = ""

            Dim DefaultValuesObject = LocalAPI.GetJobNewTimeDefaultValues(lblSelectedJob.Text, lblEmployeeId.Text)
            ' Dim SalesRep as String = verificationRecord("SalesRep")

            txtTimeSel.Text = DefaultValuesObject("Hours")

            RefreshCalendar(DefaultValuesObject("DateOfWork"))

            If LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Type") = 16 Then
                ' Programmers/Computer/IT
                divProposalTask.Visible = False
                divTickets.Visible = (LocalAPI.GetActiveJobTicketsCount(lblSelectedJob.Text) > 0)

                If divTickets.Visible And lblSelectedTicket.Text > 0 Then
                    cboActiveTickets.DataBind()
                    cboActiveTickets.SelectedValue = lblSelectedTicket.Text
                    txtDescription.Text = cboActiveTickets.Text
                End If

            Else
                divTickets.Visible = False
                divProposalTask.Visible = LocalAPI.IsProposalTaskForJob(lblSelectedJob.Text)
            End If

            cboCategory.SelectedValue = DefaultValuesObject("CategoryId")

            If divProposalTask.Visible Then
                cboTask.DataBind()
                cboTask.SelectedValue = DefaultValuesObject("ProposalTaskId")
                'cboMulticolumnTask.DataBind()
                'cboMulticolumnTask.Value = DefaultValuesObject("ProposalTaskId")
                'cboMulticolumnTask.Focus()
            Else
                txtDescription.Focus()
            End If


            RadGridTimes.DataBind()

            BotonesVisibles()

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnInsertTime_Click(sender As Object, e As EventArgs) Handles btnInsertTime.Click
        Try

            If LocalNewTime() Then
                If btnBack.Visible Then
                    BackPage()
                Else
                    InitDialog()
                    RadGridTimes.DataBind()
                    Master.InfoMessage("New time inserted")
                End If
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub btnInsertTimeAndInvoice_Click(sender As Object, e As EventArgs) Handles btnInsertTimeAndInvoice.Click
        Try

            If LocalNewTime() Then
                Dim TimeId As Integer = LocalAPI.GetLastTimeId(lblEmployeeId.Text, lblSelectedJob.Text)
                LocalNewInvoice(TimeId)

                If btnBack.Visible Then
                    BackPage()
                Else
                    InitDialog()
                    Master.InfoMessage("New time & invoice inserted")
                End If
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub
    Protected Sub LocalNewInvoice(TimeId As Integer)
        Dim dRate As Double = 0
        If Val(cboTask.SelectedValue) > 0 Then
            dRate = LocalAPI.GetProposalTaskRate(cboTask.SelectedValue)
            'If Val(cboMulticolumnTask.Value) > 0 Then
            '    dRate = LocalAPI.GetProposalTaskRate(cboMulticolumnTask.Value)
        Else
            ' Parche para Axzes a $35/Hour
            'If lblCompanyId.Text = 260973 Then
            '    dRate = 35
            'Else
            ' dRate = LocalAPI.GetEmployeeHourRate(lblEmployeeId.Text)
            'End If

            ' 9-3-2020 
            dRate = LocalAPI.GetEmployeeAssignedHourRate(lblSelectedJob.Text, lblEmployeeId.Text)

        End If

        LocalAPI.NuevoInvoiceHourlyRate(TimeId, lblSelectedJob.Text, txtTimeSel.Value, dRate)

    End Sub
    Protected Function LocalNewTime() As Boolean
        Try
            Dim taskId As Integer = 0
            Dim JobTicketId As Integer = 0
            If divProposalTask.Visible Then
                If cboTask.SelectedValue > 0 Then
                    taskId = cboTask.SelectedValue
                    'If cboMulticolumnTask.Value > 0 Then
                    '    taskId = cboMulticolumnTask.Value

                End If
            End If
            If divTickets.Visible Then
                JobTicketId = cboActiveTickets.SelectedValue
            End If
            If LocalAPI.InsertNewTime(lblEmployeeId.Text, lblSelectedJob.Text, RadDatePicker1.SelectedDate, txtTimeSel.Value, txtDescription.Text,
                                  taskId, cboCategory.SelectedValue, lblCompanyId.Text, JobTicketId) Then

                ' Actualizar el status del Job
                If cboJobStatus.SelectedValue <> -1 Then
                    LocalAPI.SetJobStatus(lblSelectedJob.Text, cboJobStatus.SelectedValue, lblEmployeeId.Text, lblCompanyId.Text, lblEmployeeId.Text)
                    cboJobStatus.SelectedValue = -1
                End If

                Return True
            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Private Sub cboActiveTickets_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboActiveTickets.SelectedIndexChanged
        If cboActiveTickets.SelectedValue > 0 Then
            txtDescription.Text = cboActiveTickets.Text
            If cboCategory.SelectedValue = 0 Then
                cboCategory.Focus()
            Else
                txtDescription.Focus()
            End If
        End If
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        BackPage()
    End Sub

    Private Sub BotonesVisibles()
        ' Botones Time & TimeAndInvoices Visible????

        ' Case 1: FROM CLIENT BillType
        Dim type As Integer = LocalAPI.GetClientProperty(lblClientId.Text, "BillType")
        Select Case type
            Case 1  ' Solo Time
                btnInsertTimeAndInvoice.Visible = False
                btnInsertTime.Visible = True
            Case 2  ' Solo Time+Invoices
                btnInsertTime.Visible = False
                btnInsertTimeAndInvoice.Visible = True
            Case Else

                ' Case 2: FROM JOB BillType
                type = LocalAPI.GetJobProperty(lblSelectedJob.Text, "BillType")
                Select Case type
                    Case 1  ' Solo Time
                        btnInsertTimeAndInvoice.Visible = False
                        btnInsertTime.Visible = True
                    Case 2  ' Solo Time+Invoices
                        btnInsertTime.Visible = False
                        btnInsertTimeAndInvoice.Visible = True
                    Case Else
                        If divProposalTask.Visible Then
                            If cboTask.SelectedValue > 0 Then
                                ' Case 3: FROM Proposal_detail BillType
                                type = LocalAPI.GetProposalDetailProperty(cboTask.SelectedValue, "BillType")
                                Select Case type
                                    Case 1  ' Solo Time
                                        btnInsertTimeAndInvoice.Visible = False
                                        btnInsertTime.Visible = True
                                    Case 2  ' Solo Time+Invoices
                                        btnInsertTime.Visible = False
                                        btnInsertTimeAndInvoice.Visible = True
                                    Case Else
                                        ' 0 Billiable=False
                                        btnInsertTimeAndInvoice.Visible = True
                                        btnInsertTime.Visible = True
                                End Select
                            End If
                        End If
                End Select
        End Select

    End Sub
    'Private Sub cboMulticolumnTask_SelectedIndexChanged(sender As Object, e As RadMultiColumnComboBoxSelectedIndexChangedEventArgs) Handles cboMulticolumnTask.SelectedIndexChanged
    '    BotonesVisibles()
    'End Sub

    Private Sub BackPage()
        Dim sUrl As String
        Select Case Session("employeenewtimebackpage")

            Case "jobs"
                Response.Redirect("~/adm/jobs.aspx?restoreFilter=true")

            Case "activejobsdashboad"
                Response.Redirect("~/adm/activejobsdashboad.aspx?restoreFilter=true")

            Case "time"
                Response.Redirect("~/adm/time.aspx?restoreFilter=true")

            Case "job_times"
                sUrl = LocalAPI.GetSharedLink_URL(8007, lblSelectedJob.Text)
                Response.Redirect(sUrl)

            Case "job_employees"
                sUrl = LocalAPI.GetSharedLink_URL(8003, lblSelectedJob.Text)
                Response.Redirect(sUrl)

            Case Else
                Response.Redirect("~/adm/default.aspx")
        End Select

    End Sub
    Private Sub RefreshCalendar(Date1 As DateTime)
        Try
            RadDatePicker1.DbSelectedDate = Date1.Date
            'SqlDataSourceEmployeeDailyTimeWorked.DataBind()
            RadScheduler1.DataBind()
        Catch ex As Exception
        End Try
    End Sub
    Private Sub RadScheduler1_NavigationCommand(sender As Object, e As SchedulerNavigationCommandEventArgs) Handles RadScheduler1.NavigationCommand
        If e.SelectedDate > CDate("1-1-2000") Then
            RefreshCalendar(e.SelectedDate)
        End If
        Select Case e.Command
            Case SchedulerNavigationCommand.SwitchToDayView
                e.Cancel = True
        End Select
    End Sub

    Private Sub RadScheduler1_NavigationComplete(sender As Object, e As SchedulerNavigationCompleteEventArgs) Handles RadScheduler1.NavigationComplete
        Select Case e.Command
            Case SchedulerNavigationCommand.SwitchToSelectedDay And RadScheduler1.SelectedView = SchedulerViewType.DayView
                RadScheduler1.SelectedView = SchedulerViewType.MonthView
        End Select
    End Sub

    Private Sub RadScheduler1_AppointmentDataBound(sender As Object, e As SchedulerEventArgs) Handles RadScheduler1.AppointmentDataBound
        Select Case e.Appointment.Description
            Case "Productive Time"
                e.Appointment.CssClass = "rsCategoryBlue"
                e.Appointment.Font.Size = 10
                e.Appointment.ForeColor = System.Drawing.Color.White
            Case "Non Productive Time"
                e.Appointment.CssClass = "rsCategoryPink"
                e.Appointment.Font.Size = 10
                e.Appointment.ForeColor = System.Drawing.Color.White

            Case "Holiday"
                e.Appointment.CssClass = "rsCategoryGreen"
                e.Appointment.Font.Size = 10
                e.Appointment.ForeColor = System.Drawing.Color.White
        End Select
    End Sub

    Private Sub RadScheduler1_FormCreating(sender As Object, e As SchedulerFormCreatingEventArgs) Handles RadScheduler1.FormCreating

        Select Case e.Mode
            Case SchedulerFormMode.Edit, SchedulerFormMode.Insert
                RadDatePicker1.DbSelectedDate = e.Appointment.Start
        End Select
        e.Cancel = True

        Dim Hours As Double = LocalAPI.GetHoursEmployeeTimeCheckIn(lblEmployeeId.Text, RadDatePicker1.DbSelectedDate)
        txtTimeSel.Text = IIf(Hours > 8, 1, 8 - Hours)
        txtTimeSel.Focus()
    End Sub

    Private Sub cboTask_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboTask.SelectedIndexChanged
        BotonesVisibles()
    End Sub

End Class

