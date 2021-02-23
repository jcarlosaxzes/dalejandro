Imports System.Threading.Tasks
Imports Telerik.Web.UI
Public Class clients
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ClientsList") Then Response.RedirectPermanent("~/adm/default.aspx")

            lblCompanyId.Text = Session("companyId")
            lblEmployee.Text = Master.UserEmail
            lblEmployeeId.Text = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)


            ' Si no tiene permiso New, boton.Visible=False
            btnNewClient.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewClient")

            Master.PageTitle = "Clients/Clients List"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Clients List"

            If Not Request.QueryString("restoreFilter") Is Nothing Then
                RestoreFilter()
            End If
        End If

        RadWindowManager1.EnableViewState = False
        'If RadWindowManager1.Windows.Count > 0 Then
        '    RadWindowManager1.Windows.Clear()
        '    'RadGrid1.DataBind()
        'End If


    End Sub

    Private Sub SaveFilter()
        Session("Filter_Clients_cboStatus") = cboStatus.SelectedValue
        Session("Filter_Clients_txtFind") = txtFind.Text
    End Sub

    Private Sub RestoreFilter()
        Try
            cboStatus.SelectedValue = Session("Filter_Clients_cboStatus")
            txtFind.Text = Session("Filter_Clients_txtFind")
        Catch ex As Exception
        End Try
    End Sub
    'Protected Sub btnCredentials_Click(ByVal sender As Object, ByVal e As System.EventArgs)
    '    Try
    '        Dim id As String = CType(sender, ImageButton).CommandArgument
    '        If Val(id) > 0 Then
    '            Master.InfoMessage("Sending credentials ... please wait", 10)
    '            Dim sEmail As String = LocalAPI.GetClientEmail(id)
    '            If sEmail.Length > 0 Then
    '                LocalAPI.RefrescarUsuarioVinculado(sEmail, "Clientes")
    '                If LocalAPI.ClientEmailCredentials(id, lblCompanyId.Text) Then
    '                    Master.InfoMessage("The client Credentials have been sent by email")
    '                End If
    '            End If
    '        End If
    '    Catch ex As Exception
    '        Master.ErrorMessage("Error. " & ex.Message)

    '    End Try


    'End Sub

    Protected Sub RadGrid1_DeleteCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.DeleteCommand
        Try
            Dim ID As String = (CType(e.Item, GridDataItem)).OwnerTableView.DataKeyValues(e.Item.ItemIndex)("Id").ToString
            If Val(ID) > 0 Then
                lblSelectedClientId.Text = ID
                If LocalAPI.EliminarCliente(CInt(lblSelectedClientId.Text)) Then
                    Master.InfoMessage("The client was deleted.")
                    lblSelectedClientId.Text = ""

                    ' Refrescar el grid
                    RadGrid1.DataBind()
                End If
            Else
                Master.ErrorMessage("Select the client to delete", 0)
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnFind_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFind.Click
        SaveFilter()
        RadGrid1.DataBind()
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditClient"
                Response.Redirect($"~/adm/client.aspx?clientId={e.CommandArgument}&backpage=clients")

            Case "EditPhoto"
                'sUrl = "~/ADM/EditAvatar.aspx?Id=" & e.CommandArgument & "&Entity=Client"
                sUrl = "~/ADM/UploadPhoto.aspx?Id=" & e.CommandArgument & "&Entity=Client"
                CreateRadWindows(e.CommandName, sUrl, 640, 480)

            Case "AzureUpload"
                sUrl = "~/ADM/AzureStorage_client.aspx?clientId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 800, 600)

            Case "Duplicate"
                lblSelectedClientId.Text = e.CommandArgument
                SqlDataSource1.Insert()

            Case "SendAcknowledgment"
                If LocalAPI.SendClientAcknowledmentEmail(e.CommandArgument, Master.UserId, lblCompanyId.Text) Then
                    Master.InfoMessage("The acknowledgment email was sent to the client!", 0)
                End If

            Case "ClientToAgile"
                LocalAPI.PASconceptClientToAgile(e.CommandArgument, "EEG_Client", Master.UserId)

            Case "AddActivity"
                lblSelectedClientId.Text = e.CommandArgument
                NewClientActivityDlg(True)

            Case "AddNotifications"
                Response.Redirect($"~/adm/notificationsnew.aspx?AppointmentId=&EntityType=Client&EntityId={e.CommandArgument}&backpage=Clients")

        End Select
    End Sub

    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer)
        RadWindowManager1.Windows.Clear()
        Dim window1 As RadWindow = New RadWindow()
        window1.NavigateUrl = sUrl
        window1.VisibleOnPageLoad = True
        window1.VisibleStatusbar = False
        window1.ID = WindowsID
        'window1.InitialBehaviors = WindowBehaviors.Maximize
        window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
        window1.Width = Width
        window1.Height = Height
        window1.Modal = True
        window1.OnClientClose = "OnClientClose"
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Protected Sub btnNewClient_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewClient.Click
        Response.Redirect("~/adm/newclient.aspx")
    End Sub

    Protected Sub RadGrid1_PreRender(sender As Object, e As EventArgs) Handles RadGrid1.PreRender
        Try
            RadGrid1.MasterTableView.GetColumn("QB").Visible = LocalAPI.IsQuickBookClients(lblCompanyId.Text)
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnQB_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim id As Integer = CType(sender, ImageButton).CommandArgument
            If Val(id) > 0 Then
                'qbAPI.CreateUpdateQBCustomer(id, lblCompanyId.Text, lblEmployee.Text)
                Master.InfoMessage("Client successfully synchronized with QuickBook", 0)
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message & ". May be another employee, vendor, or customer is already using this name.  Please enter a different name")


        End Try
    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        ' Duplicate client
        Response.Redirect($"~/ADM/Client.aspx?clientId={e.Command.Parameters("@Id_OUT").Value}&backpage=clients")
    End Sub

    Private Sub SqlDataSource1_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource1.Deleting
        Try
            Dim Notes As String = LocalAPI.GetClientProperty(e.Command.Parameters("@Id").Value, "Name")
            LocalAPI.sys_log_Nuevo(Master.UserEmail, LocalAPI.sys_log_AccionENUM.DeleteClient, lblCompanyId.Text, "Delete Client: " & Notes)
        Catch ex As Exception
        End Try

    End Sub

#Region "Activity"
    Private Sub NewClientActivityDlg(bInitDlg As Boolean)
        If bInitDlg Then
            cboEmployees.SelectedValue = lblEmployeeId.Text
            cboActivityType.SelectedValue = -1
            lblClientName.Text = LocalAPI.GetClientProperty(lblSelectedClientId.Text, "Client")
            txtSubject.Text = ""
        End If

        RadToolTipNewActivity.Visible = True
        RadToolTipNewActivity.Show()
    End Sub

    Private Sub btnAddActivity_Click(sender As Object, e As EventArgs) Handles btnAddActivity.Click
        Try
            ' Insert new Activity
            Dim EndDate As DateTime = DateAdd(DateInterval.Minute, CInt(cboDuration.SelectedValue), RadDateTimePicker1.DbSelectedDate)
            Dim ActivityId As Integer = LocalAPI.Activity_INSERT(txtSubject.Text, RadDateTimePicker1.DbSelectedDate, EndDate, cboActivityType.SelectedValue, cboEmployees.SelectedValue, lblSelectedClientId.Text, 0, 0, 0, lblCompanyId.Text, 1)
            If chkMoreOptions.Checked Then
                Response.Redirect($"~/adm/appointment?Id={ActivityId}&EntityType=Client&EntityId={ActivityId}&backpage=Clients")
            Else
                Master.InfoMessage("The Activity was inserted successfully!")
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    'Private Sub cboActivityType_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboActivityType.SelectedIndexChanged
    '    Select Case cboActivityType.SelectedValue
    '        Case 0  'Appointment
    '            cboDuration.SelectedValue = 60
    '            PanelLocation.Visible = True
    '        Case 1  'Meeting
    '            cboDuration.SelectedValue = 120
    '            PanelLocation.Visible = True
    '        Case 2  'Site Visit
    '            cboDuration.SelectedValue = 240
    '            PanelLocation.Visible = True
    '        Case 3  'Email
    '            cboDuration.SelectedValue = 15
    '            PanelLocation.Visible = False
    '        Case 4  'Call
    '            cboDuration.SelectedValue = 15
    '            PanelLocation.Visible = False
    '        Case Else
    '            cboDuration.SelectedValue = 60
    '            PanelLocation.Visible = True

    '    End Select

    '    NewClientActivityDlg(False)
    'End Sub
#End Region
End Class
