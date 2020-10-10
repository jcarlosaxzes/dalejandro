Imports Telerik.Web.UI
Public Class job_schedule
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Master.UserId
                lblJobId.Text = LocalAPI.GetJobIdFromGUID(Request.QueryString("guid"))

                Dim ViewMode As Integer = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "RadScheduler_JobEdit_View")
                RadScheduler1.SelectedView = IIf(ViewMode = -1, 1, ViewMode)
                Master.ActiveTab(8)
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

    Protected Sub RadScheduler1_FormCreating(sender As Object, e As SchedulerFormCreatingEventArgs)

        If e.Mode <> SchedulerFormMode.Hidden Then
            e.Cancel = True
        End If

        Dim appointmentToEdit = RadScheduler1.PrepareToEdit(e.Appointment, RadScheduler1.EditingRecurringSeries)
        Session("appointment_start") = appointmentToEdit.Start.ToString("yyyy-MM-dd HH:mm:ss")
        Session("appointment_end") = appointmentToEdit.End.ToString("yyyy-MM-dd HH:mm:ss")
        Dim Id = appointmentToEdit.ID

        Dim url = $"{LocalAPI.GetHostAppSite()}/adm/appointment?Id={Id}&EntityType=Job&EntityId={lblJobId.Text}&backpage=Job"
        'adm/job_schedule?guid=421a0ab6-db23-44f9-a516-847511e5c75e
        '                Response.Redirect($"~/adm/notificationsnew.aspx?id={id}&EntityType=Notifications&backpage=Notifications")
        '       Response.Redirect($"~/adm/appointment?backpage=calendar")
        ScriptManager.RegisterStartupScript(Page, [GetType](), "formScript", $"RedirectPage('{url}');", True)

    End Sub



    Protected Sub SqlDataSourceAppointments_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceAppointments.Selecting
        e.Command.Parameters("@RangeStart").Value = RadScheduler1.VisibleRangeStart
        e.Command.Parameters("@RangeEnd").Value = RadScheduler1.VisibleRangeEnd
    End Sub

    Protected Sub btnAddEvent_Click(sender As Object, e As EventArgs) Handles btnAddEvent.Click

        Response.Redirect($"~/adm/appointment?Id=&EntityType=Job&EntityId={lblJobId.Text}&backpage=Job")

    End Sub

End Class
