Imports Telerik.Web.UI
Public Class contacts
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ContactsList") Then Response.RedirectPermanent("~/ADM/Default.aspx")
            ' Si no tiene permiso New, boton.Visible=False
            btnNewContact.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewContact")
            btnImport.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Importdata")

            Master.PageTitle = "Contacts/Contacts List"
            Master.Help = "http://blog.pasconcept.com/2012/06/clients-list.html"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Contacts List"
            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")

            'btnAgileCRM.Enabled = IIf(Len(LocalAPI.GetCompanyProperty(lblCompanyId.Text, "agileApiKey")) > 0, True, False)

            ' Permisos individuales
            btnNewClient.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewClient")
            btnNewEmployee.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewEmployee")
            btnNewSubconsultant.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewSubconsultant")
            btnNewVendor.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewVendor")


        End If
        RadWindowManager1.EnableViewState = False

    End Sub

    Protected Sub btnFind_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFind.Click
        RadGrid1.DataBind()
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "o"
                sUrl = "~/ADM/Contact.aspx?ContactId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 850, 700)
            Case "c"
                Response.Redirect("~/adm/client.aspx?clientId=" & e.CommandArgument & "&fromcontacts=1")
            Case "e"
                Response.Redirect("~/adm/employee.aspx?employeeId=" & e.CommandArgument & "&fromcontacts=1")
            Case "s"
                Response.Redirect("~/adm/subconsultant.aspx?subconsultantId=" & e.CommandArgument & "&fromcontacts=1")
            Case "v"
                Response.Redirect("~/adm/vendor.aspx?vendorId=" & e.CommandArgument & "&fromcontacts=1")
        End Select
    End Sub
    Private Sub SqlDataSource1_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSource1.Selecting
        e.Command.Parameters("@IncludeContacts").Value = 0
        e.Command.Parameters("@IncludeClients").Value = 0
        e.Command.Parameters("@IncludeEmployees").Value = 0
        e.Command.Parameters("@IncludeSubConsultants").Value = 0
        e.Command.Parameters("@IncludeVendors").Value = 0

        Dim collection As IList(Of RadComboBoxItem) = cboContactType.CheckedItems
        For Each item As RadComboBoxItem In collection
            Select Case item.Text
                Case "Contacts"
                    e.Command.Parameters("@IncludeContacts").Value = item.Checked
                Case "Clients"
                    e.Command.Parameters("@IncludeClients").Value = item.Checked
                Case "Employees"
                    e.Command.Parameters("@IncludeEmployees").Value = item.Checked
                Case "SubConsultants"
                    e.Command.Parameters("@IncludeSubConsultants").Value = item.Checked
                Case "Vendors"
                    e.Command.Parameters("@IncludeVendors").Value = item.Checked
            End Select
        Next
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

    Protected Sub btnNewContact_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewContact.Click
        CreateRadWindows("NewContact", "~/ADM/NewContact.aspx", 850, 700)
    End Sub

    'Protected Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click
    '    If RadGrid1.SelectedItems.Count > 0 Then
    '        Dim n As Integer

    '        For Each dataItem As GridDataItem In RadGrid1.SelectedItems
    '            If dataItem.Selected Then
    '                LocalAPI.DeleteContact(dataItem("Id").Text)
    '                n = n + 1
    '            End If
    '        Next

    '        Master.InfoMessage(n & " Contacts Deleted", 0)
    '    Else
    '        Master.ErrorMessage("Select Row(s) before Delete")
    '    End If

    'End Sub

    'Protected Sub btnAgileCRM_Click(sender As Object, e As EventArgs) Handles btnAgileCRM.Click
    '    If RadGrid1.SelectedItems.Count > 0 And Len(txtTag.Text) > 0 Then
    '        Dim n As Integer

    '        n = ContactsToAgile()

    '        Master.InfoMessage(n & " Contacts to " & txtTag.Text & " Campaign", 0)
    '    Else
    '        Master.ErrorMessage("Select Row(s) and define 'Tag Campaign' before Lauch Campaign")
    '    End If

    'End Sub

    Protected Function ContactsToAgile() As Integer
        'Dim n As Integer
        'Dim AgileRet As String
        'Dim jsonContact As String
        'Dim contactId As Integer
        'Dim Email As String
        'Dim ContactName As String
        'Dim ContactType As String
        'Dim CompanyName As String
        'For Each dataItem As GridDataItem In RadGrid1.SelectedItems
        '    If dataItem.Selected Then
        '        contactId = dataItem("Id").Text
        '        ContactName = dataItem("Name").Text
        '        ContactType = dataItem("ContactType").Text
        '        CompanyName = dataItem("Company").Text
        '        Email = dataItem("Email").Text

        '        If Agile.IsContact(Email, lblCompanyId.Text) Then
        '            ' Add Tag
        '            Agile.AddTags(Email, txtTag.Text, lblCompanyId.Text)
        '        Else
        '            ' Crear contacto completo
        '            jsonContact = LocalAPI.GetContactJson(Email, ContactName, CompanyName, txtTag.Text)
        '            AgileRet = Agile.CreateContact(jsonContact, lblCompanyId.Text)
        '        End If

        '        UpdateContactTAG(contactId, ContactType, txtTag.Text)
        '        n = n + 1
        '    End If
        'Next
        'RadGrid1.DataBind()
        'Return n
    End Function

    Protected Function UpdateContactTAG(contactId As Integer, ContactType As String, Tag As String) As Boolean
        Select Case ContactType
            Case "Prospective", "Personal", "Others"
                LocalAPI.UpdateContactTAGS(contactId, Tag)
            Case "Client"
                LocalAPI.UpdateClientTAGS(contactId, Tag)
            Case "Employee"
                LocalAPI.UpdateEmployeeTAGS(contactId, Tag)
            Case "Employee"
                LocalAPI.UpdateEmployeeTAGS(contactId, Tag)
            Case "Subconsultant"
                LocalAPI.UpdateSubConsultanTAGS(contactId, Tag)
        End Select
    End Function

    Private Sub btnImport_Click(sender As Object, e As EventArgs) Handles btnImport.Click
        Response.Redirect("~/ADM/ImportData.aspx?source=OutlookContacts")

    End Sub
    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        Response.Redirect("~/ADM/ImportData.aspx?source=ExportedContacts")

    End Sub

    Private Sub SqlDataSource1_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource1.Deleting
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub
    Protected Sub btnNewClient_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewClient.Click
        Response.Redirect("~/adm/newclient.aspx?fromcontacts=1")
    End Sub
    Protected Sub btnNewEmployee_Click(sender As Object, e As EventArgs) Handles btnNewEmployee.Click
        Response.Redirect("~/adm/newemployee.aspx?fromcontacts=1")
    End Sub

    Protected Sub btnNewSubconsultant_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewSubconsultant.Click
        Response.Redirect("~/adm/newsubconsultant.aspx?fromcontacts=1")
    End Sub
    Protected Sub btnNewVendor_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewVendor.Click
        Response.Redirect("~/adm/newvendor.aspx?fromcontacts=1")

    End Sub
End Class

