Imports Telerik.Web.UI

Public Class vacationandholidays
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_EmployeesList") Then Response.RedirectPermanent("~/adm/default.aspx")

            lblCompanyId.Text = Session("companyId")
            lblLogedEmployeeId.Text = Master.UserId

            If Session("employeefortime") Is Nothing Then
                Session("employeefortime") = lblLogedEmployeeId.Text
            End If

            cboEmployee.DataBind()
            cboEmployee.SelectedValue = Session("employeefortime")

        End If
    End Sub

#Region "Vacations"
    Private Sub RadScheduler1_AppointmentDataBound(sender As Object, e As SchedulerEventArgs) Handles RadScheduler1.AppointmentDataBound
        Select Case e.Appointment.Description
            Case "Vacation"
                e.Appointment.CssClass = "rsCategoryPink"
                e.Appointment.Font.Size = 10
                e.Appointment.ForeColor = System.Drawing.Color.White

            Case "Holiday"
                e.Appointment.CssClass = "rsCategoryGreen"
                e.Appointment.Font.Size = 10
                e.Appointment.ForeColor = System.Drawing.Color.White

            Case "Closure"
                e.Appointment.CssClass = "rsCategoryDarkBlue"
                e.Appointment.Font.Size = 10
                e.Appointment.ForeColor = System.Drawing.Color.White

            Case "Payday"
                e.Appointment.CssClass = "rsCategoryDarkRed"
                e.Appointment.Font.Size = 10
                e.Appointment.ForeColor = System.Drawing.Color.White
        End Select
    End Sub

    Private Sub RadScheduler1_NavigationComplete(sender As Object, e As SchedulerNavigationCompleteEventArgs) Handles RadScheduler1.NavigationComplete
        Select Case e.Command
            Case SchedulerNavigationCommand.SwitchToSelectedDay And RadScheduler1.SelectedView = SchedulerViewType.DayView
                RadScheduler1.SelectedView = SchedulerViewType.WeekView
        End Select
    End Sub

    Private Sub btnUpdateHolidays_Click(sender As Object, e As EventArgs) Handles btnUpdateHolidays.Click
        RadToolTipHolidays.Visible = True
        RadToolTipHolidays.Show()
    End Sub

    Private Sub RadGridHoliday_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridHoliday.ItemCommand
        RadToolTipHolidays.Show()
    End Sub

    Private Sub btnNewVacation_Click(sender As Object, e As EventArgs) Handles btnNewVacation.Click
        Response.Redirect("~/adm/employeenewdowntime.aspx?backpage=vacationandholidays&Category=Vacation")
    End Sub

    Private Sub btnCloseHoliday_Click(sender As Object, e As EventArgs) Handles btnCloseHoliday.Click
        RadScheduler1.DataBind()
        RadScheduler1.Rebind()

    End Sub

    Private Sub btnFind_Click(sender As Object, e As EventArgs) Handles btnFind.Click
        RadScheduler1.DataBind()
        RadScheduler1.Rebind()
    End Sub


#End Region
End Class