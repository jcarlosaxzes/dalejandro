Imports Telerik.Web.UI
Public Class clients_monthlytimeandcosts
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            '!!! pending permiso especifico
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_AnalyticReports") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Margins per Client"
            Master.PageTitle = "Analytics/Margins per Client"
            lblCompanyId.Text = Session("companyId")

        End If
    End Sub

    Protected Sub ExcelButton_Click(sender As Object, e As ImageClickEventArgs) Handles ExcelButton.Click
        If cboYear.SelectedValue > 0 Then
            ConfigureExport(RadGridMonthly)
            RadGridMonthly.MasterTableView.ExportToExcel()
        Else
            ConfigureExport(RadGridAllYears)
            RadGridAllYears.MasterTableView.ExportToExcel()
        End If
    End Sub
    Private Sub ConfigureExport(RadGrid1 As RadGrid)
        RadGrid1.ExportSettings.FileName = "CLIENTS_Time_And_Costs_" & DateTime.Today.ToString("yyyy-MM-dd")
        RadGrid1.ExportSettings.ExportOnlyData = True
        RadGrid1.ExportSettings.IgnorePaging = True
        RadGrid1.ExportSettings.OpenInNewWindow = True
        RadGrid1.ExportSettings.UseItemStyles = False
        RadGrid1.ExportSettings.HideStructureColumns = True
        RadGrid1.MasterTableView.ShowFooter = True
    End Sub

    Private Sub cboYear_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboYear.SelectedIndexChanged
        If cboYear.SelectedValue > 0 Then
            RadGridMonthly.Visible = True
            RadGridAllYears.Visible = False
        Else
            RadGridMonthly.Visible = False
            RadGridAllYears.Visible = True
        End If
    End Sub

    Public Function GetMagenColor(ByVal MargenValue As Double) As System.Drawing.Color
        Select Case MargenValue
            Case -2000 To 0
                Return System.Drawing.Color.Orange
            Case > 0
                Return System.Drawing.Color.DarkGreen
            Case Else
                Return System.Drawing.Color.Red
        End Select
    End Function
End Class
