Imports Telerik.Web.UI
Public Class projectschedule
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Projectmap") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Project Schedule"
            Master.PageTitle = "Analytics/Project Schedule"
            Master.Help = "http://blog.pasconcept.com/2015/04/analyticsproject-schedule.html"
            lblCompanyId.Text = Session("companyId")

            Dim datefrom As Date = DateAdd(DateInterval.Month, -2, Date.Today)
            RadDatePickerFrom.DbSelectedDate = datefrom.Month & "/01/" & datefrom.Year
            RadDatePickerTo.DbSelectedDate = Date.Today

            cboEmployee.DataBind()
            cboDepartment.DataBind()

            cboSlotWidth.DataBind()

            RerfresGrantt()

        End If
    End Sub

    Private Sub RerfresGrantt()
        ShowCheckedOneItem(lblDepartmentIN_List, cboDepartment)
        RadGranttConfigurator()
        SqlDataSourceGrantt.DataBind()
    End Sub

    Protected Sub RadGranttConfigurator()
        'Week View
        RadGantt1.WeekView.SlotWidth = Unit.Parse(cboSlotWidth.SelectedValue)

        'Month View
        RadGantt1.MonthView.SlotWidth = Unit.Parse(cboSlotWidth.SelectedValue)

        'Year View
        RadGantt1.YearView.SlotWidth = Unit.Parse(cboSlotWidth.SelectedValue)

        'ResetDates(RadGantt1.DayView.RangeStart, RadGantt1.DayView.RangeEnd, RadGantt1.DayView.SelectedDate)

    End Sub

    Protected Sub RadGantt1_NavigationCommand(sender As Object, e As Telerik.Web.UI.Gantt.NavigationCommandEventArgs)
        'ResetDates(RadGantt1.DayView.RangeStart, RadGantt1.DayView.RangeEnd, RadGantt1.DayView.SelectedDate)

        Select Case e.Command
            Case Telerik.Web.UI.Gantt.GanttNavigationCommand.SwitchToDayView
                'ResetDates(RadGantt1.DayView.RangeStart, RadGantt1.DayView.RangeEnd, RadGantt1.DayView.SelectedDate)
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Day, -7, Date.Today)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, 7, Date.Today)
                RerfresGrantt()
            Case Telerik.Web.UI.Gantt.GanttNavigationCommand.SwitchToWeekView
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Month, -1, Date.Today)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Month, 1, Date.Today)
                RerfresGrantt()
                'ResetDates(RadGantt1.WeekView.RangeStart, RadGantt1.WeekView.RangeEnd, RadGantt1.WeekView.SelectedDate)
            Case Telerik.Web.UI.Gantt.GanttNavigationCommand.SwitchToMonthView
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Month, -3, Date.Today)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Month, 1, Date.Today)
                RerfresGrantt()
                'ResetDates(RadGantt1.MonthView.RangeStart, RadGantt1.MonthView.RangeEnd, RadGantt1.MonthView.SelectedDate)
            Case Telerik.Web.UI.Gantt.GanttNavigationCommand.SwitchToYearView
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Date.Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Date.Today.Year
                RerfresGrantt()

            Case Else
                Exit Select
        End Select
    End Sub

    Private Sub ResetDates(rangeStart As DateTime, rangeEnd As DateTime, selectedDate As DateTime)
        RadDatePickerFrom.MaxDate = rangeEnd.AddDays(-1)
        RadDatePickerTo.MinDate = rangeStart.AddDays(1)

        'SelectedDateDatePicker.MinDate = rangeStart
        'SelectedDateDatePicker.MaxDate = rangeEnd.AddDays(-1)

        'SelectedDateDatePicker.SelectedDate = selectedDate
        RadDatePickerFrom.SelectedDate = rangeStart
        RadDatePickerTo.SelectedDate = rangeEnd
    End Sub


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
    Protected Sub cboDepartment_ItemDataBound(sender As Object, e As RadComboBoxItemEventArgs) Handles cboDepartment.ItemDataBound
        ' Seleccionar todos onLoad
        e.Item.Checked = True
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RerfresGrantt()
    End Sub
End Class
