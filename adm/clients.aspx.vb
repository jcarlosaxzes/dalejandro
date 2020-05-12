Imports Telerik.Web.UI
Public Class clients
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ClientsList") Then Response.RedirectPermanent("~/ADM/Default.aspx")
            ' Si no tiene permiso New, boton.Visible=False
            btnNewClient.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewClient")

            Master.PageTitle = "Clients/Clients List"
            Master.Help = "http://blog.pasconcept.com/2012/06/clients-list.html"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Clients List"
            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")

            '!!!! temporal
            'lblEmployee.Text = "carlos@allservicedesign.com"
            'lblCompanyId.Text = 260986

        End If
        'RadWindowManager1.EnableViewState = False
        If RadWindowManager1.Windows.Count > 0 Then
            RadWindowManager1.Windows.Clear()
            RadGrid1.DataBind()
        End If


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
                lblSelected.Text = ID
                If LocalAPI.EliminarCliente(CInt(lblSelected.Text)) Then
                    Master.InfoMessage("The client was deleted.")
                    lblSelected.Text = ""

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
        RadGrid1.DataBind()
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditClient"
                Response.Redirect("~/ADM/Client.aspx?clientId=" & e.CommandArgument & "&FullPage=1")

            Case "EditPhoto"
                'sUrl = "~/ADM/EditAvatar.aspx?Id=" & e.CommandArgument & "&Entity=Client"
                sUrl = "~/ADM/UploadPhoto.aspx?Id=" & e.CommandArgument & "&Entity=Client"
                CreateRadWindows(e.CommandName, sUrl, 640, 400)

            Case "AzureUpload"
                sUrl = "~/ADM/AzureStorage_client.aspx?clientId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 800, 600)

            Case "Duplicate"
                lblSelected.Text = e.CommandArgument
                SqlDataSource1.Insert()

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
        Response.Redirect("~/ADM/Client.aspx?clientId=" & e.Command.Parameters("@Id_OUT").Value)
    End Sub
End Class
