Public Class cashflow
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Cashflow") Then Response.RedirectPermanent("~/adm/default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Cash Flow"
            Master.PageTitle = "Expenses/Cash Flow"


            lblCompanyId.Text = Session("companyId")
            SqlDataSourceYear.DataBind()
            cboYear.DataBind()
            cboYear.SelectedValue = Date.Today.Year
        End If
    End Sub
End Class
