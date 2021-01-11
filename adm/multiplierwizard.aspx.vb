Imports Telerik.Web.UI

Public Class multiplierwizard
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            lblCompanyId.Text = Session("companyId")
            lblEmployeeId.Text = Master.UserId

            If Request.QueryString("Id") Is Nothing Then
                ' New Record
                txtYear.Text = LocalAPI.GetMaxYearOfCompanyMultiplier(lblCompanyId.Text) + 1
                txtTaxPercent.Text = 7
            Else
                lblMultiplierId.Text = Request.QueryString("Id")
                If LocalAPI.IsCompanyViolation(lblMultiplierId.Text, "Company_MultiplierByYear", lblCompanyId.Text) Then Response.RedirectPermanent("~/adm/default.aspx")

                ' Edit Record
                ReadYearInfo()
            End If
        End If

    End Sub

    Private Sub ReadYearInfo()
        Try
            Dim RecordObject = LocalAPI.GetRecord(lblMultiplierId.Text, "CompanyMultiplierRecord_SELECT")

            ' Salary
            txtYear.Text = RecordObject("Year")
            txtSalary.Text = RecordObject("Salary")
            txtTaxPercent.Text = RecordObject("TaxPercent")
            cboAutoSalary.SelectedValue = RecordObject("CalculateSalary")

            ' Productive Salary
            txtProductiveSalary.Text = RecordObject("ProductiveSalary")
            cboAutoProductiveSalary.SelectedValue = RecordObject("CalculateProductiveSalary")

            'SubContracts
            txtSubContracts.Text = RecordObject("SubContracts")
            'Rent
            txtRent.Text = RecordObject("Rent")
            'Others
            txtOthers.Text = RecordObject("Others")
            'Profit
            txtProfit.Text = RecordObject("Profit")

            ' Automatic InitializeEmployee
            cboInitializeEmployee.SelectedValue = RecordObject("InitializeEmployee")
            ' Automatic CalculateBudgetDepartment
            cboCalculateBudgetDepartment.SelectedValue = RecordObject("CalculateBudgetDepartment")

            lblPreviousMultiplier.Text = FormatNumber(RecordObject("Multiplier"), 2)

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub RadWizard1_NextButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.NextButtonClick
        e.NextStep.Enabled = True
    End Sub

    Private Sub RadWizard1_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.FinishButtonClick
        Try
            If lblMultiplierId.Text = 0 Then
                ' Insert New Record before calculate....
                LocalAPI.CompanyMultiplier_INSERT(lblCompanyId.Text, txtYear.DbValue, txtSalary.DbValue, txtTaxPercent.DbValue, txtSubContracts.DbValue, txtRent.DbValue, txtOthers.DbValue, txtProductiveSalary.DbValue, txtProfit.DbValue, cboAutoSalary.SelectedValue, cboAutoProductiveSalary.SelectedValue, cboInitializeEmployee.SelectedValue, cboCalculateBudgetDepartment.SelectedValue, cboStatus.SelectedValue)
            Else
                ' Update Record before calculate....
                LocalAPI.CompanyMultiplier_UPDATE(lblMultiplierId.Text, txtSalary.DbValue, txtTaxPercent.DbValue, txtSubContracts.DbValue, txtRent.DbValue, txtOthers.DbValue, txtProductiveSalary.DbValue, txtProfit.DbValue, cboAutoSalary.SelectedValue, cboAutoProductiveSalary.SelectedValue, cboInitializeEmployee.SelectedValue, cboCalculateBudgetDepartment.SelectedValue, cboStatus.SelectedValue)
            End If

            Dim dbMultiplier As Double = LocalAPI.CompanyCalculateMultiplier(lblCompanyId.Text, txtYear.Text)
            lblFinalMultiplier.Text = FormatNumber(dbMultiplier, 2)

            RadGridMultiplier_log.DataBind()
            Master.InfoMessage("Multiplier Updated for " & txtYear.Text)
        Catch ex As Exception

        End Try

    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/companymultiplier")
    End Sub

End Class