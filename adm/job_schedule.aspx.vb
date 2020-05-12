Imports Telerik.Web.UI
Public Class job_schedule
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(Membership.GetUser().Email, lblCompanyId.Text)

                lblJobId.Text = Request.QueryString("JobId")


                Dim ViewMode As Integer = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "RadScheduler_JobEdit_View")
                RadScheduler1.SelectedView = IIf(ViewMode = -1, 1, ViewMode)

            End If


        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub
    Protected Sub RadScheduler1_AppointmentInsert(sender As Object, e As AppointmentInsertEventArgs) Handles RadScheduler1.AppointmentInsert
        SendCalendar(RadScheduler.ExportToICalendar(e.Appointment), e.Appointment.Subject)
    End Sub

    Private Function SendCalendar(data As String, sSubject As String) As String
        Dim sEmployee As Integer = LocalAPI.GetJobProperty(lblJobId.Text, "Employee", lblCompanyId.Text)
        Dim sEmailTo As String = LocalAPI.GetEmployeeEmail(sEmployee)
        Dim ue As New ASCIIEncoding()
        Dim fileData As Byte() = ue.GetBytes(data)
        LocalAPI.SendMailAndAttachment(sEmailTo, sSubject, fileData, sSubject & ".ics", lblCompanyId.Text)
        Master.InfoMessage("Appointment '" & sSubject & "' was sent to " & sEmailTo, 2)
    End Function

    Protected Sub RadScheduler1_NavigationCommand(sender As Object, e As SchedulerNavigationCommandEventArgs) Handles RadScheduler1.NavigationCommand
        Select Case e.Command
            Case SchedulerNavigationCommand.SwitchToDayView,
                 SchedulerNavigationCommand.SwitchToMonthView,
                 SchedulerNavigationCommand.SwitchToWeekView,
                 SchedulerNavigationCommand.SwitchToTimelineView,
                SchedulerNavigationCommand.SwitchToMultiDayView,
                SchedulerNavigationCommand.SwitchToAgendaView
                LocalAPI.SetEmployeeIntegerProperty(lblEmployeeId.Text, "RadScheduler_JobEdit_View", e.Command)
        End Select

    End Sub

    Protected Sub SqlDataSourceAppointments_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceAppointments.Selecting
        e.Command.Parameters("@RangeStart").Value = RadScheduler1.VisibleRangeStart
        e.Command.Parameters("@RangeEnd").Value = RadScheduler1.VisibleRangeEnd
    End Sub

End Class
