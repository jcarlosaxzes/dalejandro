Imports System.Threading.Tasks
Imports Telerik.Web.UI
Public Class schedule
    Inherits System.Web.UI.Page

    Private Property EditedAppointmentID() As Object
        Get
            Return ViewState("EditedAppointmentID")
        End Get
        Set(value As Object)
            ViewState("EditedAppointmentID") = value
        End Set
    End Property

    Private Property EditedAppointmentParentID() As Object
        Get
            Return ViewState("EditedAppointmentParentID")
        End Get
        Set(value As Object)
            ViewState("EditedAppointmentParentID") = value
        End Set
    End Property

    Private Property EditedAppointment() As Telerik.Web.UI.Appointment
        Get
            Return If((EditedAppointmentID IsNot Nothing), RadScheduler1.Appointments.FindByID(EditedAppointmentID), Nothing)
        End Get
        Set(value As Telerik.Web.UI.Appointment)
            EditedAppointmentID = value.ID
            EditedAppointmentParentID = value.RecurrenceParentID
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Master.PageTitle = "Schedule"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Calendar"
            lblCompanyId.Text = Session("companyId")
            lblEmployee.Text = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)
            Dim ViewMode As SchedulerViewType = LocalAPI.GetEmployeeProperty(lblEmployee.Text, "RadScheduler_Default_View")
            RadScheduler1.SelectedView = IIf(ViewMode = -1, 0, ViewMode)

            RadWindowManager1.EnableViewState = False
        End If

    End Sub

    Private Sub WriteCalendar(ByVal data As String)
        Dim response As HttpResponse = Page.Response

        response.Clear()
        response.Buffer = True

        response.ContentType = "text/calendar"
        response.ContentEncoding = Encoding.UTF8
        response.Charset = "utf-8"

        response.AddHeader("Content-Disposition", "attachment;filename=""RadSchedulerExport.ics""")

        response.Write(data)
        response.[End]()
    End Sub

    Protected Sub RadScheduler1_AppointmentCommand(sender As Object, e As AppointmentCommandEventArgs) Handles RadScheduler1.AppointmentCommand
        Select Case e.CommandName
            Case "Update"
                lblSelectedSubject.Text = e.Container.Appointment.Subject
                Dim aptStart = DateTime.SpecifyKind(e.Container.Appointment.Start, DateTimeKind.Local)
                Dim aptStartOffset As TimeSpan = TimeZone.CurrentTimeZone.GetUtcOffset(aptStart) - RadScheduler1.TimeZoneOffset
                lblSelectedAppointmentId.Text = e.Container.Appointment.ID
                lblTextAppointment.Text = RadScheduler.ExportToICalendar(e.Container.Appointment, aptStartOffset)

        End Select
    End Sub

    Protected Sub RadScheduler1_AppointmentInsert(sender As Object, e As AppointmentInsertEventArgs) Handles RadScheduler1.AppointmentInsert
        lblSelectedSubject.Text = e.Appointment.Subject
        Dim aptStart = DateTime.SpecifyKind(e.Appointment.Start, DateTimeKind.Local)
        Dim aptStartOffset As TimeSpan = TimeZone.CurrentTimeZone.GetUtcOffset(aptStart) - RadScheduler1.TimeZoneOffset
        lblSelectedAppointmentId.Text = e.Appointment.ID
        lblTextAppointment.Text = RadScheduler.ExportToICalendar(e.Appointment, aptStartOffset)
    End Sub

    Protected Sub SqlDataSourceAppointments_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceAppointments.Selected
        AppointmentsCount.Text = "Activities: " & e.AffectedRows
    End Sub

    Protected Sub SqlDataSourceAppointments_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceAppointments.Selecting
        e.Command.Parameters("@RangeStart").Value = RadScheduler1.VisibleRangeStart
        e.Command.Parameters("@RangeEnd").Value = RadScheduler1.VisibleRangeEnd
    End Sub

    Protected Sub btnPDF_Click(sender As Object, e As EventArgs) Handles btnPDF.Click
        RadScheduler1.ExportToPdf()
    End Sub

    Protected Sub btnOutlook_Click(sender As Object, e As EventArgs) Handles btnOutlook.Click
        WriteCalendar(RadScheduler.ExportToICalendar(RadScheduler1.Appointments, True))
    End Sub

    Protected Sub RadScheduler1_FormCreated(sender As Object, e As SchedulerFormCreatedEventArgs) Handles RadScheduler1.FormCreated
        If (e.Container.Mode = SchedulerFormMode.AdvancedEdit) OrElse (e.Container.Mode = SchedulerFormMode.AdvancedInsert) Then
            CType(e.Container.FindControl("ResAssign to User"), RadDropDownList).Width = 450
            CType(e.Container.FindControl("ResAssign to User"), RadDropDownList).ZIndex = 7004
            CType(e.Container.FindControl("ResClient"), RadDropDownList).Width = 450
            CType(e.Container.FindControl("ResClient"), RadDropDownList).ZIndex = 7004
            CType(e.Container.FindControl("ResJob"), RadDropDownList).Width = 450
            CType(e.Container.FindControl("ResJob"), RadDropDownList).ZIndex = 7005
        End If
    End Sub

    Protected Sub RadScheduler1_NavigationCommand(sender As Object, e As SchedulerNavigationCommandEventArgs) Handles RadScheduler1.NavigationCommand
        Select Case e.Command
            Case SchedulerNavigationCommand.SwitchToDayView,
                 SchedulerNavigationCommand.SwitchToMonthView,
                 SchedulerNavigationCommand.SwitchToWeekView,
                 SchedulerNavigationCommand.SwitchToTimelineView,
                SchedulerNavigationCommand.SwitchToMultiDayView,
                SchedulerNavigationCommand.SwitchToAgendaView
                LocalAPI.SetEmployeeIntegerProperty(lblEmployee.Text, "RadScheduler_Default_View", e.Command)
        End Select

    End Sub

    Protected Sub btnAddEvent_Click(sender As Object, e As EventArgs) Handles btnAddEvent.Click

        Response.Redirect($"~/adm/appointment?Id=&EntityType=Appointment&EntityId=&backpage=Schedule")

    End Sub
    Protected Sub RadScheduler1_FormCreating(sender As Object, e As SchedulerFormCreatingEventArgs)


        If e.Mode <> SchedulerFormMode.Hidden Then
            EditedAppointment = e.Appointment
            e.Cancel = True
        End If

        Dim appointmentToEdit = RadScheduler1.PrepareToEdit(e.Appointment, RadScheduler1.EditingRecurringSeries)
        Session("appointment_start") = appointmentToEdit.Start.ToString("yyyy-MM-dd HH:mm:ss")
        Session("appointment_end") = DateAdd(DateInterval.Hour, 1, Session("appointment_start")) 'appointmentToEdit.End.ToString("yyyy-MM-dd HH:mm:ss")
        Dim Id = appointmentToEdit.ID
        Dim url = $"{LocalAPI.GetHostAppSite()}/adm/appointment?Id={Id}&EntityType=Appointment&EntityId={Id}&backpage=Schedule"
        ScriptManager.RegisterStartupScript(Page, [GetType](), "formScript", $"RedirectPage('{url}');", True)
    End Sub

    Private Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        If cboEmployee.SelectedValue > 0 Then
            lblTitle.Text = "Pending Activities for " & cboEmployee.Text
        Else
            lblTitle.Text = "Pending Activities for all employees"
        End If
        RefreshData()
    End Sub
    Private Sub RefreshData()
        RadGridPending.DataBind()
        RadScheduler1.Rebind()
        RadScheduler1.DataBind()
    End Sub

    Private Sub RadGridPending_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridPending.ItemCommand
        Select Case e.CommandName
            Case "Update"
                Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
                LocalAPI.AppointmentComplete(item("Id").Text)
                RefreshData()
            Case "Edit"
                Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
                Response.Redirect(LocalAPI.GetSharedLink_URL(12001, item("Id").Text))

            Case "EditClient"
                CreateRadWindows("ClientW", $"~/ADM/Client.aspx?clientId={e.CommandArgument}&Dialog=1", 970, 750, False)

        End Select
    End Sub
    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean)
        RadWindowManager1.Windows.Clear()
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
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Public Function GetDueDateColor(ByVal DueDate As DateTime) As System.Drawing.Color
        If DueDate < Today Then
            Return System.Drawing.Color.Red
        Else
            Return System.Drawing.Color.Black
        End If
    End Function

    Private Sub SqlDataSourceAppointments_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAppointments.Updating
        LocalAPI.Appointment_DragAndDrop_UPDATE(e.Command.Parameters("@Id").Value, e.Command.Parameters("@Start").Value, e.Command.Parameters("@End").Value)
        RefreshData()
        e.Cancel = True
    End Sub
End Class

