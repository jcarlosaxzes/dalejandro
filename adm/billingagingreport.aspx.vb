Public Class billingagingreport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ClientAccountsReport") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Client Aging Report"
            Master.PageTitle = "Billing/Client Aging Report"
            Master.Help = "http://blog.pasconcept.com/2015/08/billingclient-accounts-report.html"
            lblCompanyId.Text = Session("companyId")
        End If
    End Sub
    Private Sub ConfigureExport()
        RadGrid1.ExportSettings.FileName = "Client_balance_" & DateTime.Today.ToString("yyyy-MM-dd")
        RadGrid1.ExportSettings.ExportOnlyData = True
        RadGrid1.ExportSettings.IgnorePaging = True
        RadGrid1.ExportSettings.OpenInNewWindow = True
        RadGrid1.ExportSettings.UseItemStyles = False
        RadGrid1.ExportSettings.HideStructureColumns = True
        RadGrid1.MasterTableView.ShowFooter = True
    End Sub

    Private Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
        ConfigureExport()
        RadGrid1.MasterTableView.ExportToExcel()
    End Sub
End Class
