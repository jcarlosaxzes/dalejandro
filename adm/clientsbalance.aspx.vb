Imports Telerik.Web.UI
Public Class clientsbalance
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ClientAccountsReport") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Clients Balance"
            Master.PageTitle = "Billing/Clients Balance"
            Master.Help = "http://blog.pasconcept.com/2015/08/billingclient-accounts-report.html"
            lblCompanyId.Text = Session("companyId")
        End If
    End Sub

    Private Sub RadGrid1_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles RadGrid1.ItemDataBound
        'If e.Item.ItemType = GridItemType.Item OrElse e.Item.ItemType = GridItemType.AlternatingItem Then
        '    Dim item As GridDataItem = TryCast(e.Item, GridDataItem)
        '    Dim chart As RadHtmlChart = TryCast(item("ChartColumn").FindControl("ChartClientBalance"), RadHtmlChart)
        '    SqlDataSourceChat.SelectParameters(0).DefaultValue = item.GetDataKeyValue("ClientId").ToString()
        '    chart.DataSource = SqlDataSourceChat.[Select](DataSourceSelectArguments.Empty)

        '    chart.DataBind()
        'End If
    End Sub
    Protected Sub ExcelButton_Click(sender As Object, e As ImageClickEventArgs) Handles ExcelButton.Click
        ConfigureExport()
        RadGrid1.MasterTableView.ExportToExcel()
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

End Class
