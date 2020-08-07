Public Class billvscollected
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ClientAccountsReport") Then Response.RedirectPermanent("~/adm/default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Bill vs Collected"
            Master.PageTitle = "Billing/Bill vs Collected"
            Master.Help = "http://blog.pasconcept.com/2015/04/billing-bill-vs-collected.html"
            lblCompanyId.Text = Session("companyId")
        End If
    End Sub

End Class