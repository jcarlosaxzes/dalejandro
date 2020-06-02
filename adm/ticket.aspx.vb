Imports System.Threading.Tasks
Imports Telerik.Web.UI
Public Class ticket
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")

                lblJobId.Text = Request.QueryString("JobId")

                cboEmployee.DataBind()
                If Not Request.QueryString("TicketId") Is Nothing Then
                    lblTicketId.Text = Request.QueryString("TicketId")
                    ReadTicketRecord()
                Else
                    ' MODO INSERT
                    lblTicketId.Text = "(New)"
                    Dim clientId As Integer = LocalAPI.GetJobProperty(lblJobId.Text, "Client")
                    txtNotificationClientName.Text = LocalAPI.GetClientProperty(clientId, "Name")
                    'txtNotificationClientEmail.Text = LocalAPI.GetClientProperty(clientId, "Email")
                    ' Maybe error
                    cboEmployee.SelectedValue = Master.UserId

                    ' Defaul values
                    cboStatusEdit.DataBind()
                    cboStatusEdit.SelectedText = "Ready for Development"
                    cboApprovedStatus.DataBind()
                    cboApprovedStatus.SelectedText = "Approved"

                    btnSave.Text = "Insert"
                End If
                Me.Page.Title = LocalAPI.GetJobCodeName(lblJobId.Text) & " Ticket " & lblTicketId.Text
            End If

        Catch ex As Exception
        End Try
    End Sub
    Private Sub ReadTicketRecord()
        Try
            Dim ticketRecord = LocalAPI.GetRecord(lblTicketId.Text, "Jobs_ticket_SELECT")

            If Len(ticketRecord("LocationModule")) > 0 Then cboLocationModuleEdit.SelectedText = ticketRecord("LocationModule")
            If Len(ticketRecord("AppName")) > 0 Then cboAppNameEdit.SelectedText = ticketRecord("AppName")
            txtTitle.Text = ticketRecord("Title")
            txtTags.Text = ticketRecord("Tags")
            txtClientDescription.Text = ticketRecord("ClientDescription")
            txtCompanyDescription.Text = ticketRecord("CompanyDescription")
            txtNotes.Text = ticketRecord("Notes")

            cboTypeEdit.DataBind()
            cboTypeEdit.SelectedText = ticketRecord("Type")
            cboPriority.SelectedText = ticketRecord("Priority")
            cboStatusEdit.SelectedText = ticketRecord("Status")

            cboEmployee.SelectedValue = ticketRecord("employeeId")

            txtNotificationClientName.Text = ticketRecord("NotificationClientName")
            txtNotificationClientEmail.Text = ticketRecord("NotificationClientEmail")

            cboApprovedStatus.SelectedText = ticketRecord("ApprovedStatus")

            chkIsBillable.Checked = ticketRecord("Billable")
            chkIsPrivate.Checked = ticketRecord("IsPrivate")

            txtEstimatedHours.Text = ticketRecord("EstimatedHours")
            Try
                RadDatePickerExpectedStartDate.SelectedDate = ticketRecord("ExpectedStartDate")
            Catch ex As Exception
            End Try
            Try
                RadDatePickerStagingDate.SelectedDate = ticketRecord("StagingDate")
            Catch ex As Exception
            End Try
            Try
                RadDatePickerProductionDate.SelectedDate = ticketRecord("ProductionDate")
            Catch ex As Exception
            End Try

            txttrelloURL.Text = ticketRecord("trelloURL")
            txtJiraURL.Text = ticketRecord("jiraURL")

        Catch ex As Exception

        End Try

    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        If Val(lblTicketId.Text) = 0 Then

            ' Insert Action
            SqlDataSource1.Insert()

            lblTicketId.Text = LocalAPI.GetTicketId(lblJobId.Text, txtTitle.Text)

            Master.InfoMessage("New Ticket inserted")
            ' Employee notification?

            ' Employee notification?
            If chkNotifyEmployee.Checked Then
                Task.Run(Function() LocalAPI.SendTicketNotificationToEmployee(lblJobId.Text, lblTicketId.Text, lblCompanyId.Text, "for " & Master.UserName))
            End If

            Response.Redirect("~/ADM/jobtickets.aspx?JobId=" & lblJobId.Text)
        Else
            ' Update Action
            SqlDataSource1.Update()
            Master.InfoMessage("Ticket was updated")

            ' Client notification?
            If chkNotifyClient.Checked Then
                Task.Run(Function() LocalAPI.SendTicketNotificationToClient(lblJobId.Text, lblTicketId.Text, cboEmployee.SelectedValue, lblCompanyId.Text))
            End If

            ' Employee notification?
            If chkNotifyEmployee.Checked Then
                Task.Run(Function() LocalAPI.SendTicketNotificationToEmployee(lblJobId.Text, lblTicketId.Text, lblCompanyId.Text, "for " & Master.UserName))
            End If

        End If


    End Sub
    Private Sub SqlDataSource1_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource1.Inserting
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub
    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        'Response.Redirect("~/ADM/JobTickets.aspx?JobId=" & lblJobId.Text)

    End Sub

    Private Sub cboNotificationBCCEmail_ItemDataBound(sender As Object, e As RadComboBoxItemEventArgs) Handles cboNotificationBCCEmail.ItemDataBound
        If Len(lblNotificationBCClientEmail.Text) > 0 Then
            e.Item.Checked = IIf(InStr(lblNotificationBCClientEmail.Text, e.Item.Text) > 0, True, False)
        Else
            e.Item.Checked = False
        End If

    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/jobtickets.aspx?JobId=" & lblJobId.Text)
    End Sub
End Class

