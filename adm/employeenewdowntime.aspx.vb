Imports Telerik.Web.UI

Public Class employeenewdowntime
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". New Non-Productive Time"
            Master.PageTitle = "Employee New Non-Productive Time"
            If Not IsPostBack Then
                lblCompanyId.Text = Session("companyId")
                lblLogedEmployeeId.Text = Master.UserId

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

                InitDlg(Date.Today, -1)

            End If

        Catch ex As Exception
        End Try
    End Sub


    Private Sub InitDlg(TimeDate As DateTime, nType As Integer)

        ' Init fields
        If nType > 0 Then
            cboType.SelectedValue = nType
        End If

        txtMiscellaneousHours.Text = 1

        RadDatePickerFrom.DbSelectedDate = TimeDate
        RadDatePickerTo.DbSelectedDate = TimeDate

        txtNotes.Text = ""

        ShowSumaryBox()

        'cboType.Focus()

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
        Select Case Session("employeenewtimebackpage")

            Case "activejobsdashboad"
                Response.Redirect("~/adm/activejobsdashboad.aspx?restoreFilter=true")

            Case "time"
                Response.Redirect("~/adm/time.aspx?restoreFilter=true")

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
            If (cboType.SelectedValue = 5 Or cboType.SelectedValue = 6 Or cboType.SelectedValue = 7) And RadDatePickerFrom.DbSelectedDate > RadDatePickerTo.DbSelectedDate Then
                dateValidator.Visible = True
                Return
            Else
                dateValidator.Visible = False
            End If

            If LocalNewTMiscellaneousTime() Then
                Master.InfoMessage("New non-productive time inserted")
                ''BackPage()
                SqlDataSourceEmployeeDailyTimeWorked.DataBind()
                RadScheduler1.DataBind()
                RadScheduler1.Rebind()
                ShowSumaryBox()
            End If
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
            If AnalisisDeBenefits() Then
                Select Case cboType.SelectedValue
                    Case 5, 6, 7
                        Dim requestId As Integer = LocalAPI.NewNonJobTime_Request(lblEmployeeId.Text, cboType.SelectedValue, RadDatePickerFrom.SelectedDate, RadDatePickerTo.SelectedDate, txtMiscellaneousHours.Text, txtNotes.Text, lblCompanyId.Text)
                        If requestId > 0 Then
                            bRet = True
                            MessageRequest(requestId)
                            Master.InfoMessage("Your request for " & cboType.Text & " has been sended to HR Manager and is currently in progress. Thank you for your patience as your request is reviewed for approval", 10)
                        End If
                    Case Else
                        bRet = LocalAPI.NewNonJobTime(lblEmployeeId.Text, cboType.SelectedValue, RadDatePickerFrom.SelectedDate, RadDatePickerFrom.SelectedDate, txtMiscellaneousHours.Text, txtNotes.Text)
                        If bRet Then Master.InfoMessage(cboType.Text & " time inserted")

                End Select

                Return bRet
            End If

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Function

    Private Function AnalisisDeBenefits() As Boolean
        Dim dHours As Double
        Dim dPermited As Double
        Dim dSaldoFinal As String = 0
        Dim EntryTotalHours As Double = txtMiscellaneousHours.DbValue
        If RadDatePickerFrom.DbSelectedDate <> RadDatePickerTo.DbSelectedDate Then
            EntryTotalHours = Double.Parse(txtMiscellaneousHours.DbValue) * DateDiff(DateInterval.Day, RadDatePickerFrom.DbSelectedDate, RadDatePickerTo.DbSelectedDate)
        End If
        Select Case cboType.SelectedValue
            Case 7  ' Vacations
                If lblVac1.Text <> "" Then
                    dHours = lblVac2.Text
                    dSaldoFinal = lblVac1.Text - lblVac2.Text - EntryTotalHours
                End If

            Case 5, 6  ' Personal, Sick, 
                If lblPer1.Text <> "" Then
                    dSaldoFinal = lblPer1.Text - lblPer2.Text - EntryTotalHours
                End If
        End Select

        If dSaldoFinal < 0 Then
            Master.ErrorMessage("Outstanding " & cboType.Text & " hours are " & dPermited - dHours, 0)
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

        txtNotes.Text = cboType.SelectedItem.Text

        If cboType.SelectedValue = 7 Then
            txtMiscellaneousHours.Text = "8"
            lblNotes.Visible = True


        Else
            txtMiscellaneousHours.Text = "1"
            lblNotes.Visible = False
        End If

        Select Case cboType.SelectedValue
            Case 5, 6, 7
                txtDateFrom.Text = "Date From:"
                txtDateTo.Visible = True
                RadDatePickerTo.Visible = True
                lblAprovedNote.Visible = True
                btnOkNewMiscellaneousTime.Text = "Request Time"
                PanelDateRagePicker.Visible = True
                RadDatePickerFrom.Enabled = False
                RadDatePickerTo.Enabled = False
                lbTotlaDays.Visible = True

            Case Else
                txtDateFrom.Text = "Date:"
                txtDateTo.Visible = False
                RadDatePickerTo.Visible = False
                lblAprovedNote.Visible = False
                btnOkNewMiscellaneousTime.Text = "Add Time"
                PanelDateRagePicker.Visible = False
                RadDatePickerFrom.Enabled = True
                RadDatePickerTo.Enabled = True
                lbTotlaDays.Visible = True



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

#End Region
End Class