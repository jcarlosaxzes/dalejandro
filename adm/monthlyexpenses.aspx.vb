Imports Telerik.Web.UI
Public Class monthlyexpenses
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Expenses") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Company Expenses"
            Master.PageTitle = "Expenses/Company Expenses"


            lblCompanyId.Text = Session("companyId")
            SqlDataSourceYear.DataBind()
            cboYear.DataBind()
            cboYear.SelectedValue = Date.Today.Year
        End If
    End Sub

    Private Sub btnMonthlyNew_Click(sender As Object, e As EventArgs) Handles btnMonthlyNew.Click
        RadGridMonthly.MasterTableView.InsertItem()
    End Sub

    Private Sub cboYear_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboYear.SelectedIndexChanged
        If cboYear.SelectedValue > 0 Then
            RadHtmlChartMonthly.Visible = True
        Else
            RadHtmlChartMonthly.Visible = False
        End If
        RadHtmlChartYearly.Visible = Not RadHtmlChartMonthly.Visible
        FloatedTilesListView.DataBind()
    End Sub
End Class
