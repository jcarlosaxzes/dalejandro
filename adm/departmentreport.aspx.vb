Public Class departmentreport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Allow_DepartmentReport") Then Response.RedirectPermanent("~/adm/default.aspx")

            Master.PageTitle = "Analytics/Department Report"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Department Report"
            lblEmployeeEmail.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")

            '!!!!
            'lblEmployeeEmail.Text="jorge@easterneg.com"

            cboYear.DataBind()

            cboDepartments.DataBind()
            Dim nDefaultDep As Integer = LocalAPI.GetEmployeeProperty(LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text), "FilterJob_Department")
            If nDefaultDep > 0 Then
                ' Solo ve su Dpto
                cboDepartments.SelectedValue = nDefaultDep
                cboDepartments.Enabled = False
            End If

            RefreshPage()
        End If


    End Sub
    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RefreshPage()
    End Sub

    Private Sub RefreshPage()
        lblROI.Text = FormatNumber(LocalAPI.Stadistic_DepartmentROI(cboDepartments.SelectedValue, cboYear.SelectedValue, lblCompanyId.Text)) & " %"
        lblCustomer1.Text = FormatCurrency(LocalAPI.Stadistic_DepartmentCustomer_AverageValue(cboDepartments.SelectedValue, cboYear.SelectedValue, lblCompanyId.Text))
        lblCustomer2.Text = FormatCurrency(LocalAPI.Stadistic_DepartmentCustomer_AverageRevenue(cboDepartments.SelectedValue, cboYear.SelectedValue, lblCompanyId.Text))
        Dim TotC As Integer = LocalAPI.Stadistic_DepartmentCustomer_Count(cboDepartments.SelectedValue, cboYear.SelectedValue, lblCompanyId.Text)
        lblCustomer3.Text = FormatNumber(TotC)
        Dim RecC As Integer = LocalAPI.Stadistic_DepartmentCustomerNew_Count(cboDepartments.SelectedValue, cboYear.SelectedValue, lblCompanyId.Text)
        lblCustomer4.Text = FormatNumber(RecC)
        lblCustomer5.Text = FormatNumber(TotC - RecC)

        lblDepartmentSalarySum.Text = FormatCurrency(LocalAPI.Stadistic_DepartmentSalarySum(cboDepartments.SelectedValue, cboYear.SelectedValue, -1))
        If Date.Today.Year = cboYear.SelectedValue Then
            lblDepartmentSalaryAvg.Text = FormatCurrency(LocalAPI.Stadistic_DepartmentSalaryAvg(cboDepartments.SelectedValue, cboYear.SelectedValue, -1) / Date.Today.Month)
        Else
            lblDepartmentSalaryAvg.Text = FormatCurrency(LocalAPI.Stadistic_DepartmentSalaryAvg(cboDepartments.SelectedValue, cboYear.SelectedValue, -1) / 12)
        End If

        lblDepartmentOverhead_Direct.Text = FormatCurrency(LocalAPI.Stadistic_DepartmentOverhead_Direct(cboDepartments.SelectedValue, cboYear.SelectedValue, lblCompanyId.Text))

    End Sub
    Protected Sub day_CheckedChanged(sender As Object, e As EventArgs) Handles month.CheckedChanged, year.CheckedChanged
        lblDatePart.Text = DirectCast(sender, CheckBox).ID
        RefreshPage()
    End Sub

    Private Sub SqlDataSourceDepartmentWorkload_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceDepartmentWorkload.Selecting
        Dim e1 As String = e.Command.Parameters(1).Value
    End Sub
End Class
