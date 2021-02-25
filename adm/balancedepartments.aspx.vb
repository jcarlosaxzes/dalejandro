Public Class balancedepartments
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            '!!! pending permiso especifico
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_DepartmentBalance") Then Response.RedirectPermanent("~/adm/schedule.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Balance Departments"
            Master.PageTitle = "Departments/Balance"
            Master.Help = "http://blog.pasconcept.com/2015/08/departmentsbalance.html"
            lblCompanyId.Text = Session("companyId")

            cboYear.DataBind()
            SqlDataSource1.DataBind()

        End If
    End Sub

    Private Sub ConfigureExport()
        RadGrid1.ExportSettings.FileName = "Department_balance_" & DateTime.Today.ToString("yyyy-MM-dd")
        RadGrid1.ExportSettings.ExportOnlyData = True
        RadGrid1.ExportSettings.IgnorePaging = True
        RadGrid1.ExportSettings.OpenInNewWindow = True
        RadGrid1.ExportSettings.UseItemStyles = False
        RadGrid1.ExportSettings.HideStructureColumns = True
        RadGrid1.MasterTableView.ShowFooter = True
    End Sub
    Protected Sub RadGrid1_PreRender(sender As Object, e As EventArgs) Handles RadGrid1.PreRender
        Try
            Dim Mes As Integer = 0
            If cboYear.Text = Date.Today.Year Then
                Mes = Date.Today.Month + 1
            End If
            Dim i As Integer
            For i = Mes To 12
                RadGrid1.MasterTableView.GetColumn(MonthName(i, True)).Visible = False
                RadGrid1.MasterTableView.GetColumn(MonthName(i, True) & "E").Visible = False
                RadGrid1.MasterTableView.GetColumn(MonthName(i, True) & "B").Visible = False
                RadGrid1.MasterTableView.GetColumn(MonthName(i, True) & "AB").Visible = False
            Next
            RadGrid1.DataBind()
        Catch ex As Exception

        End Try
    End Sub

    Private Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
        ConfigureExport()
        RadGrid1.MasterTableView.ExportToExcel()
    End Sub
End Class
