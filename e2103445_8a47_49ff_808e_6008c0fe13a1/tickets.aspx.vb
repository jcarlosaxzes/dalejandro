Imports Telerik.Web.UI

Public Class tickets
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then

            If Not Request.QueryString("guid") Is Nothing Then
                Dim guid As String = Request.QueryString("guid")
                lblJobId.Text = LocalAPI.GetJobIdFromGUID(guid)
                lblCompanyId.Text = LocalAPI.GetJobProperty(lblJobId.Text, "companyId")
                lblJob.Text = LocalAPI.GetJobCodeName(lblJobId.Text)

                ' client-GUID to Header Master Page
                Session("CLIENTPORTAL_clientId") = LocalAPI.GetJobProperty(lblJobId.Text, "Client")
                Master.Company = lblCompanyId.Text
            End If
        End If
    End Sub

    Private Sub SqlDataSource1_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSource1.Selecting
        ' LocationModule Filter
        If cboModuleFilter.Text = "(All Locations/Modules...)" Then
            e.Command.Parameters("@LocationModule").Value = ""
        Else
            e.Command.Parameters("@LocationModule").Value = cboModuleFilter.Text
        End If
        ' AppName
        If cboAppFilter.Text = "(All App Names...)" Then
            e.Command.Parameters("@AppName").Value = ""
        Else
            e.Command.Parameters("@AppName").Value = cboAppFilter.Text
        End If

        '' Type Filter
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
    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Select Case e.CommandName
            Case "ViewEditTicket"
                ReadTicketRecord(e.CommandArgument)
                RadToolTipEditTicket.Visible = True
                RadToolTipEditTicket.Show()
        End Select
    End Sub
    Private Sub ReadTicketRecord(ticketId As Integer)
        Try
            lblTicketId.Text = ticketId
            Dim ticketRecord = LocalAPI.GetRecord(lblTicketId.Text, "Jobs_ticket_SELECT")

            lblModuleApp.Text = ticketRecord("LocationModule") & " - " & ticketRecord("AppName")
            lblEmployeeId.Text = ticketRecord("employeeId")

            lblTitle.Text = ticketRecord("Title")

            lblClientDescription.Text = ticketRecord("ClientDescription")

            lblType.Text = ticketRecord("Type")
            lblStatus.Text = ticketRecord("Status")

            cboPriorityEdit.SelectedText = ticketRecord("Priority")
            cboApprovedStatus.SelectedText = ticketRecord("ApprovedStatus")
            txtNotes.Text = ticketRecord("Notes")

            txtNotificationClientName.Text = ticketRecord("NotificationClientName")
            txtNotificationClientEmail.Text = ticketRecord("NotificationClientEmail")

            txttrelloURL.Text = ticketRecord("trelloURL")
            txtJiraURL.Text = ticketRecord("jiraURL")

            ' btnUpdate
            btnUpdate.Visible = LocalAPI.IsTicketEditable(lblStatus.Text)
        Catch ex As Exception

        End Try

    End Sub

    Private Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        ' Default Values
        lblEmployeeId.Text = LocalAPI.GetJobProperty(lblJobId.Text, "Employee")
        txtTitle.Text = ""
        txtClientDescription.Text = ""
        txtNotificationClientNameInsert.Text = ""
        txtNotificationClientEmailInsert.Text = ""

        RadToolTipInsertTicket.Visible = True
        RadToolTipInsertTicket.Show()
    End Sub

    Private Sub btnNewConfirm_Click(sender As Object, e As EventArgs) Handles btnNewConfirm.Click
        SqlDataSourceTicket.Insert()
        Master.InfoMessage("New Ticket Inserted")
        RadGrid1.DataBind()
        lblTicketId.Text = LocalAPI.GetTicketId(lblJobId.Text, txtTitle.Text)
        LocalAPI.SendTicketNotificationToEmployee(lblJobId.Text, lblTicketId.Text, lblCompanyId.Text, "for a Client.")
    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        SqlDataSourceTicket.Update()
        Master.InfoMessage("Ticket Update")
        RadGrid1.DataBind()
        LocalAPI.SendTicketNotificationToEmployee(lblJobId.Text, lblTicketId.Text, lblCompanyId.Text, "for a Client.")
    End Sub

    Private Sub btnRefreshGrid_Click(sender As Object, e As EventArgs) Handles btnRefreshGrid.Click
        RadGrid1.DataBind()
    End Sub
End Class
