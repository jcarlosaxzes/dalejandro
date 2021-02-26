Imports Telerik.Web.UI
Imports Telerik.Web.UI.Calendar

Public Class employeenewdowntime
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". New Non-Productive Time"
            Master.PageTitle = "Employee New Non-Productive Time"
            If Not IsPostBack Then
                lblCompanyId.Text = Session("companyId")
                lblLogedEmployeeId.Text = Master.UserId

                If Not Request.QueryString("proposalId") Is Nothing Then
                    lblProposalId.Text = Request.QueryString("proposalId")
                    lblClientId.Text = LocalAPI.GetProposalProperty(lblProposalId.Text, "ClientId")
                    lblProposalLabel.Text = LocalAPI.GetProposalProperty(lblProposalId.Text, "ProjectName")
                    PanelProposal.Visible = True
                Else
                    PanelProposal.Visible = False
                End If

                If Not Session("employeefortime") Is Nothing Then
                    lblEmployeeId.Text = Session("employeefortime")
                Else
                    lblEmployeeId.Text = lblLogedEmployeeId.Text
                End If
                lblEmployeeName.Text = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "FullName")

                If Not Request.QueryString("Dialog") Is Nothing Then
                    Master.HideMasterMenu()
                    btnBack.Visible = False
                End If
                If Not Request.QueryString("HideMenu") Is Nothing Then
                    Master.HideMasterMenu()
                End If

                If Not Request.QueryString("backpage") Is Nothing Then
                    Session("employeenewnptimebackpage") = Request.QueryString("backpage")
                Else
                    Session("employeenewnptimebackpage") = ""
                End If

                cboType.DataBind()
                If Not Request.QueryString("Category") Is Nothing Then
                    Dim nType As Integer = LocalAPI.GetNonRegularTypesFromName(lblCompanyId.Text, Request.QueryString("Category"))
                    InitDlg(Date.Today, nType)
                Else
                    InitDlg(Date.Today, -1)
                End If

                Dim recors = LocalAPI.GetRecordFromQuery($"SELECT Id, Holiday, Description FROM Company_hollidays WHERE ([companyId] = {lblCompanyId.Text}) ORDER BY Holiday DESC")

            End If

        Catch ex As Exception
        End Try
    End Sub


    Private Sub InitDlg(TimeDate As DateTime, nType As Integer)

        RadDatePickerFrom.DbSelectedDate = TimeDate
        RadDatePickerTo.DbSelectedDate = TimeDate

        If nType > 0 Then
            cboType.SelectedValue = nType
            DefaultCategoryValues()
        End If

        ShowSumaryBox()

    End Sub


    Public Sub ShowSumaryBox()
        Dim dFrom As DateTime = Year(RadDatePickerFrom.DbSelectedDate) & "-01-01"
        Dim dTo As DateTime = Year(RadDatePickerFrom.DbSelectedDate) & "-12-31 23:59"
        Dim dPermited As Double
        Dim dHours As Double
        ' Benefits_vacations
        dHours = LocalAPI.GetEmployeeNonRegularHours_count(lblEmployeeId.Text, 7, dFrom, dTo)
        lblVac2.Text = dHours
        dPermited = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "Benefits_vacations")
        If dPermited >= 0 Then
            lblVac1.Text = dPermited
            lblVac3.Text = dPermited - dHours
        Else
            lblVac1.Text = ""
            lblVac3.Text = ""
        End If

        ' Benefits_personals Se suman 5 y 6 
        dHours = LocalAPI.GetEmployeeNonRegularHours_count(lblEmployeeId.Text, 5, dFrom, dTo)
        dHours = dHours + LocalAPI.GetEmployeeNonRegularHours_count(lblEmployeeId.Text, 6, dFrom, dTo)
        lblPer2.Text = dHours
        dPermited = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "Benefits_personals")
        If dPermited >= 0 Then
            lblPer1.Text = dPermited
            lblPer3.Text = dPermited - dHours
        Else
            lblPer1.Text = ""
            lblPer3.Text = ""
        End If
    End Sub


    Private Sub BackPage()
        Dim sUrl As String
        Select Case Session("employeenewnptimebackpage")

            Case "activejobsdashboad"
                If lblProposalId.Text > 0 Then
                    Response.Redirect("~/adm/activejobsdashboad.aspx?restoreFilter=true&ProposalTab=1")
                Else
                    Response.Redirect("~/adm/activejobsdashboad.aspx?restoreFilter=true")
                End If


            Case "time"
                Response.Redirect("~/adm/time.aspx?restoreFilter=true")

            Case "vacationandholidays"
                Response.Redirect("~/adm/vacationandholidays.aspx")

            Case Else
                Response.Redirect("~/adm/activejobsdashboad.aspx?restoreFilter=true")
        End Select

    End Sub

    Private Sub RefreshCalendar(Date1 As DateTime)
        Try
            RadDatePickerFrom.DbSelectedDate = Date1.Date
            RadDatePickerTo.DbSelectedDate = Date1.Date
            RadScheduler1.DataBind()

        Catch ex As Exception
        End Try
    End Sub




#Region "Add Record"
    Private Sub btnOkNewMiscellaneousTime_Click(sender As Object, e As EventArgs) Handles btnOkNewMiscellaneousTime.Click
        Try
            If LocalNewTMiscellaneousTime() Then
                Master.InfoMessage("New Time inserted")
            End If
            BackPage()

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try

    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        BackPage()
    End Sub

    Private Function LocalNewTMiscellaneousTime() As Boolean
        Try

            Dim bRet As Boolean

            Select Case cboType.SelectedValue
                Case 5, 6, 7
                    If AnalisisDeBenefits() Then
                        Dim requestId As Integer = LocalAPI.NewNonJobTime_Request(lblEmployeeId.Text, cboType.SelectedValue, RadDatePickerFrom.SelectedDate, RadDatePickerTo.SelectedDate, txtMiscellaneousHours.Text, txtNotes.Text, lblCompanyId.Text)
                        If requestId > 0 Then
                            bRet = True
                            MessageRequest(requestId)
                            Master.InfoMessage("Your request for " & cboType.Text & " has been sended to HR Manager and is currently in progress. Thank you for your patience as your request is reviewed for approval", 10)
                        End If

                    End If
                Case Else
                    bRet = LocalAPI.NewNonJobTime(lblEmployeeId.Text, cboType.SelectedValue, RadDatePickerFrom.SelectedDate, RadDatePickerFrom.SelectedDate, txtMiscellaneousHours.Text, txtNotes.Text, lblClientId.Text, 0, lblProposalId.Text, cboProposalTask.SelectedValue)
                    If bRet Then Master.InfoMessage(cboType.Text & " time inserted")
            End Select

            Return bRet

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Function

    Private Function AnalisisDeBenefits() As Boolean
        Dim dHours As Double
        Dim dSaldoFinal As String = 0
        Dim EntryTotalHours As Double = txtMiscellaneousHours.DbValue

        Dim fromDate As Date = RadDatePickerFrom.DbSelectedDate
        Dim toDate As Date = RadDatePickerTo.DbSelectedDate

        If fromDate < toDate Then
            Dim record = LocalAPI.GetRecordFromQuery($"select dbo.GetWorkDaysFromTo({lblCompanyId.Text},'{fromDate.ToString("yyyy-MM-dd")}','{toDate.ToString("yyyy-MM-dd")}') as WorkDays")
            EntryTotalHours = Val(record("WorkDays")) * EntryTotalHours
        ElseIf fromDate = toDate Then
            Dim record = LocalAPI.GetRecordFromQuery($"select dbo.GetWorkDaysFromTo({lblCompanyId.Text},'{fromDate.ToString("yyyy-MM-dd")}','{fromDate.ToString("yyyy-MM-dd")}') as WorkDays")
            EntryTotalHours = Val(record("WorkDays")) * EntryTotalHours
        Else
            Master.ErrorMessage("Date From must be earlier or equal than end Date To")
            Return False
        End If


        Select Case cboType.SelectedValue
            Case 7  ' Vacations
                If lblVac1.Text <> "" Then
                    dHours = lblVac3.Text
                End If

            Case 5, 6  ' Personal, Sick, 
                If lblPer1.Text <> "" Then
                    dHours = lblPer3.Text
                End If

        End Select

        If dHours < EntryTotalHours Then
            Master.ErrorMessage("Outstanding " & cboType.Text & " hours are " & EntryTotalHours - dHours, 0)
            Return False
        Else
            Return True

        End If
    End Function

    Private Function MessageRequest(requestId As Integer) As Boolean
        Try
            Dim sMsg As New System.Text.StringBuilder
            Dim HRname As String = LocalAPI.GetCompanyHRname(lblCompanyId.Text)
            Dim sTo As String = LocalAPI.GetCompanyHRemail(lblCompanyId.Text)
            Dim EmployeEmail As String = LocalAPI.GetEmployeeEmail(lblEmployeeId.Text)

            Dim DictValues As Dictionary(Of String, String) = New Dictionary(Of String, String)
            DictValues.Add("[CompanyName]", HRname)
            DictValues.Add("[EmployeeFullName]", LocalAPI.GetEmployeeFullName(EmployeEmail, lblCompanyId.Text))
            DictValues.Add("[Category]", cboType.Text)
            DictValues.Add("[DateRequest]", Date.Today)
            DictValues.Add("[DateFrom]", RadDatePickerFrom.SelectedDate)
            DictValues.Add("[DateTo]", RadDatePickerTo.SelectedDate)
            DictValues.Add("[Notes]", txtNotes.Text)
            DictValues.Add("[TimeHours]", txtMiscellaneousHours.Text)
            DictValues.Add("[UrlDetails]", LocalAPI.GetHostAppSite() & "/adm/ManagementRequest.aspx?Id=" & requestId & "&guid=" & LocalAPI.GetCompanyGUID(lblCompanyId.Text))
            DictValues.Add("[PASSign]", LocalAPI.GetPASSign())

            Dim sSubject As String = LocalAPI.GetMessageTemplateSubject("Add_Non_Productive_Time", lblCompanyId.Text, DictValues) & ". " & lblEmployeeName.Text
            Dim sBody As String = LocalAPI.GetMessageTemplateBody("Add_Non_Productive_Time", lblCompanyId.Text, DictValues)

            Return SendGrid.Email.SendMail(sTo, "", "", sSubject, sBody, lblCompanyId.Text, 0, 0)

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Function
#End Region

#Region "RadScheduler1"
    Private Sub RadScheduler1_NavigationCommand(sender As Object, e As SchedulerNavigationCommandEventArgs) Handles RadScheduler1.NavigationCommand
        If e.SelectedDate > CDate("1-1-2000") Then
            RefreshCalendar(e.SelectedDate)
        End If
        'Select Case e.Command
        '    Case SchedulerNavigationCommand.SwitchToDayView
        '        e.Cancel = True
        'End Select
    End Sub

    Private Sub RadScheduler1_NavigationComplete(sender As Object, e As SchedulerNavigationCompleteEventArgs) Handles RadScheduler1.NavigationComplete
        Select Case e.Command
            Case SchedulerNavigationCommand.SwitchToSelectedDay And RadScheduler1.SelectedView = SchedulerViewType.DayView
                RadScheduler1.SelectedView = SchedulerViewType.WeekView
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
                InitDlg(e.Appointment.Start, -1)
        End Select
        e.Cancel = True

        cboType.Focus()
    End Sub

    Private Sub cboType_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboType.SelectedIndexChanged
        DefaultCategoryValues
    End Sub
    Private Sub DefaultCategoryValues()
        txtNotes.Text = cboType.SelectedItem.Text
        RadCalendar1.SelectedDates.Clear()
        lbTotlaDaysHours.Text = "Total Work Days: 0 Total Hours: 0"
        lbTotlaDaysHours.ForeColor = Drawing.Color.Black

        If cboType.SelectedValue = 5 Or cboType.SelectedValue = 6 Or cboType.SelectedValue = 7 Then
            txtMiscellaneousHours.Text = "8"
            lblNotes.Visible = True
        Else
            txtMiscellaneousHours.Text = "1"
            lblNotes.Visible = False
        End If

        Select Case cboType.SelectedValue
            Case 5, 6, 7
                txtDateFrom.Text = "Date From:"
                lblAprovedNote.Visible = True
                btnOkNewMiscellaneousTime.Text = "Request Time"
                PanelDateRagePicker.Visible = True
                PanelTotlaHOursSelected.Visible = True
                btnUpdateHours.Visible = True
                RadDatePickerFrom.Visible = False
                txtDateFrom.Visible = False
            Case Else
                txtDateFrom.Text = "Date:"
                RadDatePickerFrom.Visible = True
                btnOkNewMiscellaneousTime.Text = "Add Time"
                RadDatePickerFrom.Enabled = True
                RadDatePickerTo.Enabled = True
                txtDateFrom.Visible = True
                PanelTotlaHOursSelected.Visible = False
                PanelDateRagePicker.Visible = False
                lblAprovedNote.Visible = False
                btnUpdateHours.Visible = False

        End Select
        If cboType.SelectedValue <= 3 Or cboType.SelectedValue <= 4 Or cboType.SelectedValue <= 8 Or cboType.SelectedValue <= 3 Then

        End If


    End Sub
    Private Sub RadGridLog_ItemDeleted(sender As Object, e As GridDeletedEventArgs) Handles RadGridLog.ItemDeleted
        SqlDataSourceEmployeeDailyTimeWorked.DataBind()
        RadScheduler1.DataBind()
        RadScheduler1.Rebind()
    End Sub

    Private Sub RadGridLog_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles RadGridLog.ItemDataBound


        Dim hr_email = LocalAPI.GetCompanyHRemail(lblCompanyId.Text)
        If Not String.IsNullOrEmpty(hr_email) AndAlso Master.UserEmail = hr_email Then
            Return
        End If

        If LocalAPI.IsMasterUser(Master.UserEmail, lblCompanyId.Text) Then
            Return
        End If


        If TypeOf e.Item Is GridDataItem Then
            Dim TimeType = e.Item.DataItem.Row.ItemArray(2)
            Dim _btnEdit = e.Item.FindControl("EditButton")

            Dim _btnDelete = e.Item.FindControl("gbcDeleteColumn")

            If TypeOf _btnEdit Is ImageButton Then
                Dim btnEdit As ImageButton = CType(_btnEdit, ImageButton)
                Dim btnDelete As ImageButton = CType(_btnDelete, ImageButton)
                Select Case TimeType
                    Case 5, 6, 7
                        btnEdit.Visible = False
                        btnEdit.Enabled = False
                        btnDelete.Visible = False
                        btnDelete.Enabled = False
                    Case Else
                        btnEdit.Visible = True
                        btnEdit.Enabled = True
                        btnDelete.Visible = True
                        btnDelete.Enabled = True
                End Select

            End If

        End If

    End Sub

    Private Sub RadCalendar1_SelectionChanged(sender As Object, e As SelectedDatesEventArgs) Handles RadCalendar1.SelectionChanged
        UpdateTotalHours()
    End Sub

    Private Sub UpdateTotalHours()

        If RadCalendar1.SelectedDates.Count > 0 Then
            RadScheduler1.SelectedDate = RadCalendar1.SelectedDates(0).Date
            RadDatePickerFrom.SelectedDate = RadCalendar1.SelectedDates(0).Date
            RadDatePickerTo.SelectedDate = RadCalendar1.SelectedDates(RadCalendar1.SelectedDates.Count - 1).Date
            SqlDataSourceEmployeeDailyTimeWorked.DataBind()
            RadScheduler1.DataBind()
            RadScheduler1.Rebind()
            Dim record = LocalAPI.GetRecordFromQuery($"select dbo.GetWorkDaysFromTo({lblCompanyId.Text},'{RadCalendar1.SelectedDates(0).Date.ToString("yyyy-MM-dd")}','{RadCalendar1.SelectedDates(RadCalendar1.SelectedDates.Count - 1).Date.ToString("yyyy-MM-dd")}') as WorkDays")
            Dim WorkDays = Val(record("WorkDays"))
            lbTotlaDaysHours.Text = $"Total Work Days: {WorkDays} Total Hours: {WorkDays * txtMiscellaneousHours.Value}"
            lbTotlaDaysHours.ForeColor = IIf((WorkDays * txtMiscellaneousHours.Value > Double.Parse(lblVac3.Text)), Drawing.Color.Red, Drawing.Color.Black)
        Else
            lbTotlaDaysHours.Text = $"Total Work Days: 0 Total Hours: 0"
            lbTotlaDaysHours.ForeColor = Drawing.Color.Black
        End If

    End Sub

    Private Sub btnUpdateHours_Click(sender As Object, e As EventArgs) Handles btnUpdateHours.Click
        UpdateTotalHours()
    End Sub

#End Region
End Class