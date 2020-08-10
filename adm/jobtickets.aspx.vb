Imports System.Threading.Tasks
Imports Telerik.Web.UI
Public Class jobtickets
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Master.UserId
                If Not Request.QueryString("JobId") Is Nothing Then
                    lblJobId.Text = Request.QueryString("JobId")
                    lblJob.Text = LocalAPI.GetJobCodeName(lblJobId.Text)
                Else
                    lblJobId.Text = "-1"
                End If
                FormEditMode(lblJobId.Text)
                urlPublicLink.DataBind()
                Master.PageTitle = "Job/Tickets"
            End If
            RadWindowManager1.EnableViewState = False

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Public Function GetJobGUID() As String
        Return "../../e2103445_8a47_49ff_808e_6008c0fe13a1/tickets.aspx?guid=" & LocalAPI.GetJobProperty(lblJobId.Text, "guid")
    End Function
    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Select Case e.CommandName
            Case "ViewEditTicket"
                lblTicketId.Text = e.CommandArgument
                lblJobId.Text = LocalAPI.GetTicketProperty(lblTicketId.Text, "jobId")
                ReadTicketRecord()
                RadToolTipEditTicket.Visible = True
                RadToolTipEditTicket.Show()
            Case "NewTime"
                lblTicketId.Text = e.CommandArgument
                lblJobId.Text = LocalAPI.GetTicketProperty(lblTicketId.Text, "jobId")

                If cboFilterEmployee.SelectedValue > 0 Then
                    Session("employeefortime") = cboEmployee.SelectedValue
                End If
                CreateRadWindows(e.CommandName, "~/ADM/EmployeeNewTime.aspx?JobTicketId=" & e.CommandArgument & "&JobId=" & lblJobId.Text & "&Dialog=1", 1024, 820, True)

            Case "TicketBalance"
                lblTicketId.Text = e.CommandArgument
                lblJobId.Text = LocalAPI.GetTicketProperty(lblTicketId.Text, "jobId")
                Response.Redirect("~/adm/ticket_time.aspx?JobTicketId=" & lblTicketId.Text & "&jobId=" & lblJobId.Text)

            Case "Invoice"
                lblTicketId.Text = e.CommandArgument
                lblJobId.Text = LocalAPI.GetTicketProperty(lblTicketId.Text, "jobId")
                InvoiceDlg()

        End Select
    End Sub

    Private Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        Response.Redirect("~/ADM/Ticket.aspx?JobId=" & lblJobId.Text)
    End Sub

    Private Sub SqlDataSource1_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSource1.Selecting
        ' LocationModule Filter
        If cboLocationModule.Text = "(All Locations/Modules...)" Then
            e.Command.Parameters("@LocationModule").Value = ""
        Else
            e.Command.Parameters("@LocationModule").Value = cboLocationModule.Text
        End If
        ' AppName
        If cboAppName.Text = "(All App Names...)" Then
            e.Command.Parameters("@AppName").Value = ""
        Else
            e.Command.Parameters("@AppName").Value = cboAppName.Text
        End If

        ' Type Filter
        'If cboType.Text = "(All Types...)" Then
        '    e.Command.Parameters("@Type").Value = ""
        'Else
        '    e.Command.Parameters("@Type").Value = cboType.Text
        'End If


        ' Compouse Type Filter List
        Dim TypeIN_List As String = ""
        Dim collection1 As IList(Of RadComboBoxItem) = cboType.CheckedItems
        If (collection1.Count <> 0) Then

            For Each item As RadComboBoxItem In collection1
                TypeIN_List = TypeIN_List + item.Text + ","
            Next
            ' Quitar la ultima coma
            TypeIN_List = Left(TypeIN_List, Len(TypeIN_List) - 1)
        End If
        e.Command.Parameters("@TypeIN_List").Value = TypeIN_List


        ' Compouse Status Filter List
        Dim StatusIN_List As String = ""
        Dim collection2 As IList(Of RadComboBoxItem) = cboStatus.CheckedItems
        If (collection2.Count <> 0) Then

            For Each item As RadComboBoxItem In collection2
                StatusIN_List = StatusIN_List + item.Text + ","
            Next
            ' Quitar la ultima coma
            StatusIN_List = Left(StatusIN_List, Len(StatusIN_List) - 1)
        End If
        e.Command.Parameters("@StatusIN_List").Value = StatusIN_List
    End Sub

    Protected Sub cboType_ItemDataBound(sender As Object, e As RadComboBoxItemEventArgs) Handles cboType.ItemDataBound
        e.Item.Checked = True
    End Sub

    Private Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RadGrid1.DataBind()
    End Sub

    Private Sub btnURLClientNotification_Click(sender As Object, e As EventArgs) Handles btnURLClientNotification.Click
        CreateRadWindows("ClientNotif", "~/ADM/SendTicketPage.aspx?jobId=" & lblJobId.Text & "&employeeId=" & lblEmployeeId.Text, 960, 650, False)
    End Sub
    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean)
        RadWindowManager1.Windows.Clear()
        Dim window1 As RadWindow = New RadWindow()
        window1.NavigateUrl = sUrl
        window1.VisibleOnPageLoad = True
        window1.VisibleStatusbar = False
        window1.ID = WindowsID
        If Maximize Then window1.InitialBehaviors = WindowBehaviors.Maximize
        window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize Or WindowBehaviors.Maximize
        If Width = -1 Then
            window1.AutoSize = True
        Else
            window1.AutoSize = False
            window1.Width = Width
            window1.Height = Height
        End If
        window1.Modal = True
        window1.DestroyOnClose = True
        window1.OnClientClose = "OnClientClose"
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Protected Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
        RadGridToExport.DataBind()
        ConfigureExport(RadGridToExport)
        RadGridToExport.MasterTableView.ExportToCSV()
    End Sub

    Private Sub ConfigureExport(RadGrid1 As RadGrid)
        RadGrid1.ExportSettings.FileName = "Tickets_" & DateTime.Today.ToString("yyyy-MM-dd")
        RadGrid1.ExportSettings.ExportOnlyData = True
        RadGrid1.ExportSettings.IgnorePaging = True
        RadGrid1.ExportSettings.OpenInNewWindow = True
        RadGrid1.ExportSettings.UseItemStyles = False
        RadGrid1.ExportSettings.HideStructureColumns = True
        RadGrid1.MasterTableView.ShowFooter = True
    End Sub

    Private Sub btnMeetingRequest_Click(sender As Object, e As EventArgs) Handles btnMeetingRequest.Click
        Try
            Dim sMsg As New System.Text.StringBuilder
            If RadGrid1.SelectedItems.Count > 0 Then


                sMsg.Append("Hello,")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Below is the list of Tickets approved for discuss in next meeting dated [Date/Time]:")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                'get a reference to the row
                Dim ticketRecord
                For Each dataItem As GridDataItem In RadGrid1.SelectedItems
                    If dataItem.Selected Then
                        ticketRecord = LocalAPI.GetRecord(dataItem("Id").Text, "Jobs_ticket_SELECT")
                        sMsg.Append("<a href=" & """" & LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/ticket.aspx?guid=" & LocalAPI.GetJobProperty(lblJobId.Text, "guid") & "&TicketId=" & ticketRecord("Id") & """" & "> Ticket # " & ticketRecord("Id") & "</a>  <b>" & ticketRecord("Title") & "</b>")
                        sMsg.Append("<br />")
                    End If
                Next

                sMsg.Append("<br />")
                sMsg.Append("Regards,")
                sMsg.Append("<br />")
                sMsg.Append(LocalAPI.GetEmployeesSign(lblEmployeeId.Text))
                sMsg.Append("<br />")

                txtSubject.Text = "Meeting Request for " & lblJob.Text
                RadDatePickerDate.SelectedDate = Date.Now
                lblBody.Text = sMsg.ToString
                RadToolSendRequest.Visible = True
                RadToolSendRequest.Show()
            Else
                Master.ErrorMessage("Select Ticket for Request Meeting!")
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub btnSent_Click(sender As Object, e As EventArgs) Handles btnSent.Click
        lblBody.Text = Replace(lblBody.Text, "[Date/Time]", RadDatePickerDate.DbSelectedDate.ToString)
        Dim SenderEmail As String = LocalAPI.GetEmployeeEmail(lId:=lblEmployeeId.Text)
        Dim SenderDisplay As String = LocalAPI.GetEmployeeName(lblEmployeeId.Text)
        Dim clientId = LocalAPI.GetJobProperty(lblJobId.Text, "Client")
        Task.Run(Function() SendGrid.Email.SendMail(txtTo.Text, txtBCC.Text, SenderEmail, txtSubject.Text, lblBody.Text, lblCompanyId.Text, clientId, lblJobId.Text,, SenderDisplay, SenderEmail, SenderDisplay))
    End Sub

    Private Sub ReadTicketRecord()
        Try
            SqlDataSourceTicketAppName.DataBind()
            SqlDataSourceTicketLocationModule.DataBind()
            SqlDataSourceEmployee.DataBind()
            Dim ticketRecord = LocalAPI.GetRecord(lblTicketId.Text, "Jobs_ticket_SELECT")

            If Len(ticketRecord("LocationModule")) > 0 Then cboLocationModuleEdit.SelectedText = ticketRecord("LocationModule")
            lblLocationModuleEdit.Text = ticketRecord("LocationModule")
            If Len(ticketRecord("AppName")) > 0 Then cboAppNameEdit.SelectedText = ticketRecord("AppName")
            lblAppNameEdit.Text = ticketRecord("AppName")
            txtTitle.Text = ticketRecord("Title")
            txtTags.Text = ticketRecord("Tags")
            txtClientDescription.Text = ticketRecord("ClientDescription")
            txtCompanyDescription.Text = ticketRecord("CompanyDescription")
            txtNotes.Text = ticketRecord("Notes")

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

            RadDatePickerExpectedStartDate.SelectedDate = Nothing
            Try

                RadDatePickerExpectedStartDate.SelectedDate = ticketRecord("ExpectedStartDate")
            Catch ex As Exception
            End Try

            RadDatePickerStagingDate.SelectedDate = Nothing

            Try
                RadDatePickerStagingDate.SelectedDate = ticketRecord("StagingDate")
            Catch ex As Exception
            End Try

            RadDatePickerProductionDate.SelectedDate = Nothing
            Try
                RadDatePickerProductionDate.SelectedDate = ticketRecord("ProductionDate")
            Catch ex As Exception
            End Try

            txttrelloURL.Text = ticketRecord("trelloURL")
            txtJiraURL.Text = ticketRecord("jiraURL")

            cboNotificationBCCEmail.Text = ticketRecord("NotificationBCClientEmail")
        Catch ex As Exception

        End Try

    End Sub
    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        SqlDataSourceTicket.Update()
        Master.InfoMessage("Ticket was updated")
        RadGrid1.DataBind()
        ' Client notification?
        If chkNotifyClient.Checked Then
            Task.Run(Function() LocalAPI.SendTicketNotificationToClient(lblJobId.Text, lblTicketId.Text, cboEmployee.SelectedValue, lblCompanyId.Text))
        End If

        ' Employee notification?
        If chkNotifyEmployee.Checked Then
            Task.Run(Function() LocalAPI.SendTicketNotificationToEmployee(lblJobId.Text, lblTicketId.Text, lblCompanyId.Text, "for " & Master.UserName))
        End If


    End Sub

    Private Sub btnImport_Click(sender As Object, e As EventArgs) Handles btnImport.Click
        CreateRadWindows("ClientNotif", "~/ADM/ImportTickets.aspx?jobId=" & lblJobId.Text, 800, 600, False)
    End Sub

    Private Sub btnStatusUpdate_Click(sender As Object, e As EventArgs) Handles btnStatusUpdate.Click
        If RadGrid1.SelectedItems.Count > 0 Then
            RadToolTipStatusUpdate.Visible = True
            RadToolTipStatusUpdate.Show()
        Else
            Master.ErrorMessage("Select Tickets Previously to Update your Status!")
        End If
    End Sub

    Private Sub btnStatusUpdateConfirm_Click(sender As Object, e As EventArgs) Handles btnStatusUpdateConfirm.Click
        Try
            For Each dataItem As GridDataItem In RadGrid1.SelectedItems
                If dataItem.Selected Then
                    LocalAPI.Jobs_ticket_Status_UPDATE(dataItem("Id").Text, cboNewStatus.Text)
                End If
            Next
            Master.InfoMessage("The Status of the selected Tickets were Updated!")
            RadGrid1.DataBind()
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click
        Try
            For Each dataItem As GridDataItem In RadGrid1.SelectedItems
                If dataItem.Selected Then
                    LocalAPI.Jobs_ticket_Delete(dataItem("Id").Text)
                End If
            Next
            Master.InfoMessage("The 'Pending Approval' selected Tickets were Deleted!")
            RadGrid1.DataBind()
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub cboJobs_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboJobs.SelectedIndexChanged
        Response.Redirect("~/ADM/JobTickets.aspx" & IIf(cboJobs.SelectedValue > 0, "?jobId=" & cboJobs.SelectedValue, ""))
    End Sub
    Private Sub FormEditMode(JobId As Integer)

        If JobId = "-1" Then
            btnNew.Visible = False
        Else
            cboJobs.DataBind()
            cboJobs.SelectedValue = JobId
            btnNew.Visible = True
        End If
        btnImport.Visible = btnNew.Visible
        'btnSave.Visible = btnNew.Visible
        cboAppNameEdit.Visible = btnNew.Visible
        lblAppNameEdit.Visible = Not cboAppNameEdit.Visible
        cboLocationModuleEdit.Visible = btnNew.Visible
        lblLocationModuleEdit.Visible = Not cboLocationModuleEdit.Visible
    End Sub

    Private Sub InvoiceDlg()
        lblInvoiceId.Text = LocalAPI.GetTicketProperty(lblTicketId.Text, "InvoiceId")
        If lblInvoiceId.Text = 0 Then
            lblInvoiceId.Text = LocalAPI.Invoice_FromTicket(lblTicketId.Text)
        End If
        FormViewInvoice.DataBind()
        RadToolTipEditInvoice.Visible = True
        RadToolTipEditInvoice.Show()
    End Sub

    Private Sub btnUpdateInvoice_Click(sender As Object, e As EventArgs) Handles btnUpdateInvoice.Click
        RadToolTipEditInvoice.Visible = False
        FormViewInvoice.UpdateItem(True)
        Master.InfoMessage("Invoice updated!")
    End Sub

    Public Function GetInvoiceColor(ByVal invoiceId As Integer) As System.Drawing.Color
        If invoiceId = 0 Then
            Return System.Drawing.Color.DarkRed
        Else
            If LocalAPI.GetInvoiceAmount(invoiceId) > 0 Then
                Return System.Drawing.Color.DarkGreen
            Else
                Return System.Drawing.Color.DarkOrange
            End If
        End If

    End Function
    Public Function GetStagingDateLabelCSS(Id As Integer) As String
        Dim StagingDate As Date = LocalAPI.GetDateTimeEscalar("select StagingDate=case when StagingDate Is Null then '1/1/2019' else StagingDate end from Jobs_tickets where Id=" & Id)
        Select Case StagingDate
            Case < LocalAPI.GetDateTime()
                Return "label badge-danger"
            Case LocalAPI.GetDateTime()
                Return "badge badge-warning"
            Case > LocalAPI.GetDateTime()
                Return "label badge-success"
            Case Else
                Return "badge badge-secondary"
        End Select
    End Function
End Class

