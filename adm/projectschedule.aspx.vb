Imports Telerik.Web.UI
Public Class projectschedule
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Projectmap") Then Response.RedirectPermanent("~/adm/default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Project Schedule"
            Master.PageTitle = "Analytics/Project Schedule"
            Master.Help = "http://blog.pasconcept.com/2015/04/analyticsproject-schedule.html"
            lblCompanyId.Text = Session("companyId")


            cboPeriod.DataBind()
            cboPeriod.SelectedValue = LocalAPI.GetEmployeeProperty(Master.UserId, "FilterJob_Month")
            IniciaPeriodo(cboPeriod.SelectedValue)

            cboEmployee.DataBind()
            cboDepartment.DataBind()

            cboSlotWidth.DataBind()

            RerfresGrantt()

        End If
    End Sub
    Private Sub IniciaPeriodo(nPeriodo As Integer)
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
                ' Allow RadDatePicker user Values...

            Case 14  '14 and any other old setting (This Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

        End Select
        cboPeriod.SelectedValue = nPeriodo
    End Sub
    Private Sub RerfresGrantt()
        IniciaPeriodo(cboPeriod.SelectedValue)
        ShowCheckedOneItem(lblDepartmentIN_List, cboDepartment)
        RadGranttConfigurator()
        RadGantt1.DataBind()
    End Sub

    Protected Sub RadGranttConfigurator()
        'Week View
        RadGantt1.WeekView.SlotWidth = Unit.Parse(cboSlotWidth.SelectedValue)

        'Month View
        RadGantt1.MonthView.SlotWidth = Unit.Parse(cboSlotWidth.SelectedValue)

        'Year View
        RadGantt1.YearView.SlotWidth = Unit.Parse(cboSlotWidth.SelectedValue)


    End Sub

    Protected Sub RadGantt1_NavigationCommand(sender As Object, e As Telerik.Web.UI.Gantt.NavigationCommandEventArgs)
        'ResetDates(RadGantt1.DayView.RangeStart, RadGantt1.DayView.RangeEnd, RadGantt1.DayView.SelectedDate)

        Select Case e.Command
            Case Telerik.Web.UI.Gantt.GanttNavigationCommand.SwitchToDayView
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Day, -7, Date.Today)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, 7, Date.Today)
                RerfresGrantt()
            Case Telerik.Web.UI.Gantt.GanttNavigationCommand.SwitchToWeekView
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Month, -1, Date.Today)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Month, 1, Date.Today)
                RerfresGrantt()
            Case Telerik.Web.UI.Gantt.GanttNavigationCommand.SwitchToMonthView
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Month, -3, Date.Today)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Month, 1, Date.Today)
                RerfresGrantt()
            Case Telerik.Web.UI.Gantt.GanttNavigationCommand.SwitchToYearView
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Date.Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Date.Today.Year
                RerfresGrantt()

            Case Else
                Exit Select
        End Select
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

    Private Sub cboParentMode_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboParentMode.SelectedIndexChanged
        RerfresGrantt()
    End Sub
End Class
