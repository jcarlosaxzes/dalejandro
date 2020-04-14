Public Class vendortypes
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ClientType") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Vendor Types"
            Master.PageTitle = "Contacts/Vendor Types"
            Master.Help = "http://blog.pasconcept.com/2015/08/clientsclient-type-list.html"
            lblCompanyId.Text = Session("companyId")
        End If
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub

    Protected Sub btnNewSubtype_Click(sender As Object, e As EventArgs) Handles btnNewSubtype.Click
        RadGrid2.MasterTableView.InsertItem()
    End Sub
End Class
