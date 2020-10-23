Imports Telerik.Web.UI

Public Class appointment
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblCompanyId.Text = Session("companyId")
            lblStartDate.Text = Session("appointment_start")
            lblEndDate.Text = Session("appointment_end")


            lblEntityType.Text = Request.QueryString("EntityType")
            lblEntityId.Text = Request.QueryString("EntityId")

            Dim s = DateTime.Now
            If Len(lblStartDate.Text) > 0 Then
                s = DateTime.Parse(lblStartDate.Text)
            End If
            Dim en = DateTime.Now.AddHours(1)
            If Len(lblEndDate.Text) > 0 Then
                en = DateTime.Parse(lblEndDate.Text)
            End If

            uStart.DbSelectedDate = s
            uEnd.DbSelectedDate = en
            lblEmployee.Text = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)
            lblAppointmentid.Text = Val(Request.QueryString("Id"))
            btnSave.Text = IIf(Val(Request.QueryString("Id")) > 0, "Update Event", "Create Event")
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

        If CType(FormView1.FindControl("txtSubject"), RadTextBox).Text.Length = 0 Then
            lblError.Text = "Please enter Subject"
            Return
        End If

        FormView1.UpdateItem(False)


    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        BackPage()
    End Sub

    Private Sub ShowSendCalendar()
        Try

            lblSelectedJob.Text = LocalAPI.GetAppointmentsProperty(lblAppointmentid.Text, "JobId")

            If lblSelectedJob.Text > 0 Then
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

    Protected Sub SqlDataSourceAppointments_Updated(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim newId = e.Command.Parameters("@ReturnId").Value.ToString()
        lblAppointmentid.Text = newId

        ShowSendCalendar()

    End Sub

    Protected Sub SqlDataSourceAppointments_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs)
        Dim newId = e.Command.Parameters
    End Sub

    Protected Sub SqlDataSourceAppointments_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        ' Dim newId = e.AffectedRows.
    End Sub

    Protected Sub BackPage()
        If (lblEntityType.Text = "Appointment") Then
            Response.Redirect("~/adm/schedule.aspx")
            Return
        End If

        If Request.QueryString("backpage") = "Notifications" Then
            Response.Redirect("~/adm/Notifications.aspx")
            Return
        End If

        If Request.QueryString("backpage") = "Job" Then
            Dim jobGuid = LocalAPI.GetJobProperty(lblEntityId.Text, "guid")
            Response.Redirect($"~/adm/job_schedule?guid={jobGuid}")
            Return
        End If

        If Request.QueryString("backpage") = "Client" Then
            Response.Redirect($"~/adm/Client?clientId={lblEntityId.Text}&FullPage=1&tab=schedule")
            Return
        End If

        If Request.QueryString("backpage") = "Clients" Then
            Response.Redirect($"~/adm/Clients?restoreFilter=true")
            Return
        End If

        If Request.QueryString("backpage") = "Jobs" Then
            Response.Redirect($"~/adm/Jobs?restoreFilter=true")
            Return
        End If

        Response.Redirect($"~/adm/schedule.aspx")
    End Sub



    Protected Sub FormView1_DataBound(sender As Object, e As EventArgs)
        If lblEntityType.Text = "Job" Then

            CType(FormView1.FindControl("txtSubject"), RadTextBox).Text = LocalAPI.GetJobProperty(lblEntityId.Text, "Code") & " " & LocalAPI.GetJobProperty(lblEntityId.Text, "Job")
            Dim clientId = LocalAPI.GetJobProperty(lblEntityId.Text, "Client")
            Dim cboJob = CType(FormView1.FindControl("cboJob"), RadComboBox)
            cboJob.SelectedValue = lblEntityId.Text
            cboJob.Enabled = False

            Dim cboClient = CType(FormView1.FindControl("cboClient"), RadComboBox)
            cboClient.SelectedValue = clientId
            cboClient.Enabled = False

        End If

        If lblEntityType.Text = "Client" Then

            Dim cboClient = CType(FormView1.FindControl("cboClient"), RadComboBox)
            cboClient.SelectedValue = lblEntityId.Text
            cboClient.Enabled = False

        End If
    End Sub

    Protected Sub btnSendCalendar_Click(sender As Object, e As EventArgs) Handles btnSendCalendar.Click
        If panelProposalTask.Visible Then

            LocalAPI.UpdateProposaltaskIdAppointment(lblAppointmentid.Text, cboTask.SelectedValue)
        End If

        If SendCalendar() Then
            RadToolTipSend.Visible = False
        End If

        If CType(FormView1.FindControl("chNotify"), RadCheckBox).Checked Then
            Response.Redirect($"~/adm/notificationsnew.aspx?AppointmentId={lblAppointmentid.Text}&EntityType={lblEntityType.Text}&EntityId={lblEntityId.Text}&backpage={Request.QueryString("backpage")}")
        Else
            BackPage()
        End If
    End Sub




    Private Function SendCalendar() As Boolean
        Try

            Dim sEmailTo As String = Master.UserEmail
            Dim ue As New ASCIIEncoding()
            Dim fileData As Byte() = ue.GetBytes(CType(FormView1.FindControl("txtDescription"), RadTextBox).Text)
            Dim sCCO As String

            Dim collection As IList(Of RadComboBoxItem) = cboMultiEmployees.CheckedItems
            If (collection.Count <> 0) Then

                For Each item As RadComboBoxItem In collection
                    sCCO = sCCO + LocalAPI.GetEmployeeEmail(lId:=item.Value) + ","
                Next
                ' Quitar la ultima coma
                sCCO = Left(sCCO, Len(sCCO) - 1)
            End If

            Return LocalAPI.SendMailAndAttachmentExt(sEmailTo, sCCO, CType(FormView1.FindControl("txtSubject"), RadTextBox).Text, fileData, CType(FormView1.FindControl("txtSubject"), RadTextBox).Text & ".ics", lblCompanyId.Text, 0, 0)

            Master.InfoMessage("Appointment '" & CType(FormView1.FindControl("txtSubject"), RadTextBox).Text & "' was sent")
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try


    End Function


    Private Sub SqlDataSourceAppointments_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAppointments.Updating
        Dim e1 As String = e.Command.Parameters("@Start").Value
    End Sub

    Private Sub btnCancelSendCalendar_Click(sender As Object, e As EventArgs) Handles btnCancelSendCalendar.Click
        If CType(FormView1.FindControl("chNotify"), RadCheckBox).Checked Then
            Response.Redirect($"~/adm/notificationsnew.aspx?AppointmentId={lblAppointmentid.Text}&EntityType={lblEntityType.Text}&EntityId={lblEntityId.Text}&backpage={Request.QueryString("backpage")}")
        Else
            BackPage()
        End If
    End Sub
End Class

