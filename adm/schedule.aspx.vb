Imports System.Threading.Tasks
Imports Telerik.Web.UI
Public Class schedule
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Master.PageTitle = "Schedule"
            Master.Help = "http://blog.pasconcept.com/2015/03/calendar.html"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Calendar"
            lblCompanyId.Text = Session("companyId")
            lblEmployee.Text = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)
            Dim ViewMode As SchedulerViewType = LocalAPI.GetEmployeeProperty(lblEmployee.Text, "RadScheduler_Default_View")
            RadScheduler1.SelectedView = IIf(ViewMode = -1, 0, ViewMode)
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

                ShowSendCalendar()
                'SendCalendar(RadScheduler.ExportToICalendar(e.Container.Appointment), e.Container.Appointment.Subject)
        End Select
    End Sub

    Protected Sub RadScheduler1_AppointmentInsert(sender As Object, e As AppointmentInsertEventArgs) Handles RadScheduler1.AppointmentInsert
        lblSelectedSubject.Text = e.Appointment.Subject
        Dim aptStart = DateTime.SpecifyKind(e.Appointment.Start, DateTimeKind.Local)
        Dim aptStartOffset As TimeSpan = TimeZone.CurrentTimeZone.GetUtcOffset(aptStart) - RadScheduler1.TimeZoneOffset
        lblSelectedAppointmentId.Text = e.Appointment.ID
        lblTextAppointment.Text = RadScheduler.ExportToICalendar(e.Appointment, aptStartOffset)
        ShowSendCalendar()
        'SendCalendar(RadScheduler.ExportToICalendar(e.Appointment), e.Appointment.Subject)
    End Sub

    Private Sub ShowSendCalendar()
        Try

            lblSelectedJob.Text = LocalAPI.GetAppointmentsProperty(lblSelectedAppointmentId.Text, "JobId")

            If lblSelectedJob.Text > 0 Then
                cboTask.DataBind()

                panelProposalTask.Visible = (cboTask.Items.Count > 0)
                If panelProposalTask.Visible Then
                    Dim proposaldetalleId As Integer = LocalAPI.GetAppointmentsProperty(lblSelectedAppointmentId.Text, "proposaldetalleId")
                    If proposaldetalleId > 0 Then
                        cboTask.SelectedValue = proposaldetalleId
                    End If
                End If
            End If

            RadToolTipSend.Visible = True
            RadToolTipSend.Show()

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnSendCalendar_Click(sender As Object, e As EventArgs) Handles btnSendCalendar.Click
        If panelProposalTask.Visible Then

            LocalAPI.UpdateProposaltaskIdAppointment(lblSelectedAppointmentId.Text, cboTask.SelectedValue)
        End If

        If SendCalendar() Then
            RadToolTipSend.Visible = False
        End If
    End Sub

    Private Function SendCalendar() As Boolean
        Try

            Dim sEmailTo As String = Master.UserEmail
            Dim ue As New ASCIIEncoding()
            Dim fileData As Byte() = ue.GetBytes(lblTextAppointment.Text)
            Dim sCCO As String

            Dim collection As IList(Of RadComboBoxItem) = cboMultiEmployees.CheckedItems
            If (collection.Count <> 0) Then

                For Each item As RadComboBoxItem In collection
                    sCCO = sCCO + LocalAPI.GetEmployeeEmail(lId:=item.Value) + ","
                Next
                ' Quitar la ultima coma
                sCCO = Left(sCCO, Len(sCCO) - 1)
            End If

            Return LocalAPI.SendMailAndAttachmentExt(sEmailTo, sCCO, lblSelectedSubject.Text, fileData, lblSelectedSubject.Text & ".ics", lblCompanyId.Text, 0, 0)

            Master.InfoMessage("Appointment '" & lblSelectedSubject.Text & "' was sent")
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Function

    Private Function SendCalendar_old(data As String, sSubject As String) As String
        Try

            Dim sEmailTo As String = Master.UserEmail
            Dim ue As New ASCIIEncoding()
            Dim fileData As Byte() = ue.GetBytes(data)
            If ConfigurationManager.AppSettings("Debug") <> "1" Then
                Task.Run(Function() LocalAPI.SendMailAndAttachment(sEmailTo, sSubject, fileData, sSubject & ".ics", lblCompanyId.Text))
            End If
            Master.InfoMessage("Appointment '" & sSubject & "' was sent to " & sEmailTo, 2)
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Function

    Protected Sub SqlDataSourceAppointments_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceAppointments.Selected
        AppointmentsCount.Text = "Appointments: " & e.AffectedRows
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

    Protected Sub btnCRM_Click(sender As Object, e As EventArgs) Handles btnCRM.Click
        InitActivityForm()
        RadToolTipCRM.Visible = True
        RadToolTipCRM.Show()

    End Sub
    Protected Sub btnCRMOk_Click(sender As Object, e As EventArgs) Handles btnCRMOk.Click
        Try

            SqlDataSourceClientActivity.Insert()

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        InitActivityForm()
    End Sub

    Private Sub SqlDataSourceClientActivity_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceClientActivity.Inserted
        If cboEmployees.CheckedItems.Count > 0 Then
            SendEmployeeActivityEmails()
        End If
        Master.InfoMessage("New Client Activity Record was inserted ", 5)
    End Sub

    Private Sub InitActivityForm()
        txtSubject.Text = ""
        txtDescription.Text = ""
        cboClient.SelectedValue = -1
        cboActivityType.SelectedValue = -1

        Dim collection As IList(Of RadComboBoxItem) = cboEmployees.CheckedItems
        If (collection.Count <> 0) Then

            For Each item As RadComboBoxItem In collection
                item.Checked = False
            Next
        End If

        RadToolTipCRM.Visible = False
    End Sub

    Private Function SendEmployeeActivityEmails() As Boolean
        Try

            Dim sEmailTo As String = ""
            Dim collection As IList(Of RadComboBoxItem) = cboEmployees.CheckedItems
            If (collection.Count <> 0) Then

                For Each item As RadComboBoxItem In collection
                    sEmailTo = sEmailTo & LocalAPI.GetEmployeeEmail(lId:=item.Value) & ","

                    item.Checked = False
                Next
            End If
            If Len(sEmailTo) Then
                sEmailTo = Left(sEmailTo, Len(sEmailTo) - 1)

                Dim sMsg As New System.Text.StringBuilder

                sMsg.Append("This message is to notify the reception of client activity")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Date: <b>" & LocalAPI.GetDateTime() & "</b>")
                sMsg.Append("<br />")
                sMsg.Append("Activity: <b>" & cboActivityType.Text & "</b>")
                sMsg.Append("<br />")
                sMsg.Append("Client: <b>" & cboClient.Text & "</b>")
                sMsg.Append("<br />")
                sMsg.Append("Subject: <b>" & txtSubject.Text & "</b>")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Notes:")
                sMsg.Append("<br />")
                sMsg.Append(txtDescription.Text)
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Thank you.")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("PASconcept Notifications")
                sMsg.Append("<br />")

                Dim sBody As String = sMsg.ToString
                Dim sSubject As String = "PASconcet client activity. " & cboClient.Text & ", [" & cboActivityType.Text & "]"

                Task.Run(Function() SendGrid.Email.SendMail(sEmailTo, Master.UserEmail, "", sSubject, sBody, lblCompanyId.Text, cboClient.SelectedValue, 0))

            End If
            Return True
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Function

End Class

