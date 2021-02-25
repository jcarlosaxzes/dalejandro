Imports Telerik.Web.UI

Public Class appointment
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            lblCompanyId.Text = Session("companyId")
            cboEmployee.DataBind()
            cboEmployee.SelectedValue = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)

            If Not Request.QueryString("EntityType") Is Nothing Then
                lblEntityType.Text = Request.QueryString("EntityType")
            Else
                lblEntityType.Text = "Appointment"
            End If
            lblEntityId.Text = Val("" & Request.QueryString("EntityId"))
            lblAppointmentid.Text = Val("" & Request.QueryString("Id"))

            ReadAppoitment()


            btnSave.Text = IIf(lblAppointmentid.Text > 0, "Update Activity", "Create Activity")
        End If
    End Sub

    Private Sub ReadAppoitment()

        If lblAppointmentid.Text > 0 Then

            ' Read Record......................................................
            Dim AppointmentObject = LocalAPI.GetRecord(lblAppointmentid.Text, "Appointment_v21_SELECT")

            txtSubject.Text = AppointmentObject("Subject")
            RadDateTimePickerStart.DbSelectedDate = AppointmentObject("Start")
            RadDateTimePickerEnd.DbSelectedDate = AppointmentObject("End")
            chAllDay.Checked = AppointmentObject("AllDay")

            cboActivity.DataBind()
            cboActivity.SelectedValue = AppointmentObject("ActivityId")
            cboEmployee.DataBind()
            cboEmployee.SelectedValue = AppointmentObject("EmployeeId")
            cboClient.DataBind()
            cboClient.SelectedValue = AppointmentObject("ClientId")
            If AppointmentObject("JobId") > 0 Then
                cboJob.DataBind()
                cboJob.SelectedValue = AppointmentObject("JobId")
            End If
            If AppointmentObject("proposalId") > 0 Then
                cboProposal.DataBind()
                cboProposal.SelectedValue = AppointmentObject("proposalId")
            End If
            If AppointmentObject("clientspreprojectId") > 0 Then
                cboPreProposal.DataBind()
                cboPreProposal.SelectedValue = AppointmentObject("clientspreprojectId")
            End If

            txtDescription.Text = AppointmentObject("Description")
            txtLocation.Text = AppointmentObject("Location")

            txtRecurrenceFrecuency.Text = AppointmentObject("RecurrenceFrequency")
            cboRecurrenceInterval.DataBind()
            cboRecurrenceInterval.SelectedValue = AppointmentObject("RecurrenceInterval")
            If Not AppointmentObject("RecurrenceUntil") Is Nothing Then dtpUntil.DbSelectedDate = AppointmentObject("RecurrenceUntil")
            chNotify.Checked = AppointmentObject("NotifyEmployee")
            cboStatus.DataBind()
            cboStatus.SelectedValue = AppointmentObject("statusId")

            ' Interfaz depending Entity .........................
            If lblEntityType.Text = "Appointment" Then
                ' From Appoitment, simulate Entity
                If cboJob.SelectedValue > 0 Then
                    lblEntityType.Text = "Job"
                ElseIf cboProposal.SelectedValue > 0 Then
                    lblEntityType.Text = "Proposal"
                ElseIf cboPreProposal.SelectedValue > 0 Then
                    lblEntityType.Text = "Pre-Proposal"
                Else
                    lblEntityType.Text = "Client"
                End If
            End If


            Select Case lblEntityType.Text
                Case "Appointment"


                Case "Client", "Clients"
                    cboClient.Enabled = False
                    PanelPreProposal.Visible = False
                    PanelProposal.Visible = False
                    PanelJob.Visible = False
                Case "Job", "Jobs"
                    cboClient.Enabled = False
                    cboJob.Enabled = False
                    PanelPreProposal.Visible = False
                    PanelProposal.Visible = False
                Case "Pre-Proposal"
                    cboClient.Enabled = False
                    cboPreProposal.Enabled = False
                    PanelProposal.Visible = False
                    PanelJob.Visible = False
                Case "Proposal"
                    cboClient.Enabled = False
                    cboProposal.Enabled = False
                    PanelPreProposal.Visible = False
                    PanelJob.Visible = False
                Case Else

            End Select

        Else
            ' New Record..................................
            If Not Session("appointment_start") Is Nothing Then
                RadDateTimePickerStart.DbSelectedDate = Session("appointment_start")
                RadDateTimePickerStart.Enabled = False
            Else
                RadDateTimePickerStart.DbSelectedDate = DateTime.Now
            End If
            If Not Session("appointment_end") Is Nothing Then
                RadDateTimePickerEnd.DbSelectedDate = Session("appointment_end")
                RadDateTimePickerStart.Enabled = False
            Else
                RadDateTimePickerEnd.DbSelectedDate = RadDateTimePickerStart.DbSelectedDate.AddHours(1)
            End If

        End If


    End Sub


    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If lblAppointmentid.Text > 0 Then
            ' UpdateRecord
            LocalAPI.Activity_UPDATE(lblAppointmentid.Text, txtSubject.Text, RadDateTimePickerStart.DbSelectedDate, RadDateTimePickerEnd.DbSelectedDate, cboActivity.SelectedValue, cboEmployee.SelectedValue, cboClient.SelectedValue, cboJob.SelectedValue, cboProposal.SelectedValue, cboPreProposal.SelectedValue, cboStatus.SelectedValue, txtDescription.Text, txtLocation.Text, chNotify.Checked, Val(txtRecurrenceFrecuency.Text), cboRecurrenceInterval.SelectedValue, dtpUntil.DbSelectedDate)
        Else
            ' Insert New Record
            LocalAPI.Activity_INSERT(txtSubject.Text, RadDateTimePickerStart.DbSelectedDate, RadDateTimePickerEnd.DbSelectedDate, cboActivity.SelectedValue, cboEmployee.SelectedValue, cboClient.SelectedValue, cboJob.SelectedValue, cboProposal.SelectedValue, cboPreProposal.SelectedValue, lblCompanyId.Text, cboStatus.SelectedValue, txtDescription.Text, txtLocation.Text, chNotify.Checked, Val(txtRecurrenceFrecuency.Text), cboRecurrenceInterval.SelectedValue, dtpUntil.DbSelectedDate)
        End If

        If chNotify.Checked Then
            ShowSendCalendar()
        Else
            BackPage()
        End If


    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        BackPage()
    End Sub

    Private Sub ShowSendCalendar()
        Try
            If cboJob.SelectedValue > 0 Then
                cboTask.DataBind()

                panelProposalTask.Visible = (cboTask.Items.Count > 0)
                If panelProposalTask.Visible Then
                    Dim proposaldetalleId As Integer = LocalAPI.GetAppointmentsProperty(lblAppointmentid.Text, "proposaldetalleId")
                    If proposaldetalleId > 0 Then
                        cboTask.SelectedValue = proposaldetalleId
                    End If
                End If
            Else
                panelProposalTask.Visible = False
            End If

            RadToolTipSend.Visible = True
            RadToolTipSend.Show()

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub BackPage()
        If (lblEntityType.Text = "Appointment") Then
            Response.Redirect("~/adm/schedule.aspx")
            Return
        End If

        Select Case Request.QueryString("backpage")
            Case "pre-projects"
                Response.Redirect($"~/adm/pre-projects?restoreFilter=true")
            Case "Clients"
                Response.Redirect($"~/adm/Clients?restoreFilter=true")
            Case "Proposals"
                Response.Redirect($"~/adm/proposals?restoreFilter=true")
            Case "Jobs"
                Response.Redirect($"~/adm/Jobs?restoreFilter=true")

            Case "Job"
                Dim jobGuid = LocalAPI.GetJobProperty(lblEntityId.Text, "guid")
                Response.Redirect($"~/adm/job_schedule?guid={jobGuid}")
            Case "Client"
                Response.Redirect($"~/adm/Client?clientId={lblEntityId.Text}&FullPage=1&tab=schedule")
            Case "Notifications"
                Response.Redirect("~/adm/Notifications.aspx")
            Case Else
                Response.Redirect($"~/adm/schedule.aspx")
        End Select
    End Sub


    Protected Sub btnSendCalendar_Click(sender As Object, e As EventArgs) Handles btnSendCalendar.Click
        If panelProposalTask.Visible Then

            LocalAPI.UpdateProposaltaskIdAppointment(lblAppointmentid.Text, cboTask.SelectedValue)
        End If

        If SendCalendar() Then
            RadToolTipSend.Visible = False
        End If

        If chNotify.Checked Then
            Response.Redirect($"~/adm/notificationsnew.aspx?AppointmentId={lblAppointmentid.Text}&EntityType={lblEntityType.Text}&EntityId={lblEntityId.Text}&backpage={Request.QueryString("backpage")}")
        Else
            BackPage()
        End If
    End Sub

    Private Function SendCalendar() As Boolean
        Try
            Dim subject = txtSubject.Text
            Dim start As DateTime = RadDateTimePickerStart.DbSelectedDate
            Dim EndD As DateTime = RadDateTimePickerEnd.DbSelectedDate
            Dim Description = txtDescription.Text
            Dim location = txtLocation.Text

            Dim sEmailTo As String = Master.UserEmail
            Dim ue As New ASCIIEncoding()
            Dim icsText = LocalAPI.CreateCalendarIcs(start, EndD, subject, location, Description)
            Dim fileData As Byte() = ue.GetBytes(icsText)
            Dim sCCO As String

            Dim collection As IList(Of RadComboBoxItem) = cboMultiEmployees.CheckedItems
            If (collection.Count <> 0) Then

                For Each item As RadComboBoxItem In collection
                    sCCO = sCCO + LocalAPI.GetEmployeeEmail(lId:=item.Value) + ","
                Next
                ' Quitar la ultima coma
                sCCO = Left(sCCO, Len(sCCO) - 1)
            End If

            Return LocalAPI.SendMailAndAttachmentExt(sEmailTo, sCCO, subject, fileData, subject & ".ics", lblCompanyId.Text, 0, 0)

            Master.InfoMessage("Appointment '" & subject & "' was sent")
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try


    End Function


    Private Sub btnCancelSendCalendar_Click(sender As Object, e As EventArgs) Handles btnCancelSendCalendar.Click
        BackPage()
    End Sub


    Private Sub cboClient_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboClient.SelectedIndexChanged
        If cboClient.SelectedValue > 0 Then
            cboJob.DataBind()
            cboProposal.DataBind()
            cboPreProposal.DataBind()
        End If
    End Sub
End Class

