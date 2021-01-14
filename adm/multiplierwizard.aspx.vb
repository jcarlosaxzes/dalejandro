Imports Telerik.Web.UI

Public Class multiplierwizard
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            lblCompanyId.Text = Session("companyId")
            lblEmployeeId.Text = Master.UserId

            If Request.QueryString("Id") Is Nothing Then
                ' New Record
                lblModeInsert.Text = 1
                lblYear.Text = LocalAPI.GetMaxYearOfCompanyMultiplier(lblCompanyId.Text) + 1
                txtTaxPercent.Text = 7
            Else
                ' Edit Record
                lblModeInsert.Text = 0
                lblMultiplierId.Text = Request.QueryString("Id")
                If LocalAPI.IsCompanyViolation(lblMultiplierId.Text, "Company_MultiplierByYear", lblCompanyId.Text) Then Response.RedirectPermanent("~/adm/default.aspx")
                ReadYearInfo()
            End If
            lblYearTab1.Text = lblYear.Text
            lblTitleYear.Text = lblYear.Text

            RefreshEmployeeWage()
            ReadPastYearInfo()

        End If

    End Sub
    Private Sub RefreshEmployeeWage()
        ' Before Calculate
        LocalAPI.EmployeesHourlyWage_INSERT(lblYear.Text, lblCompanyId.Text)
        RadGridHourlyWage.DataBind()
    End Sub

    Private Sub ReadYearInfo()
        Try
            Dim RecordObject = LocalAPI.GetRecord(lblMultiplierId.Text, "CompanyMultiplierRecord_SELECT")

            ' Salary
            lblYear.Text = RecordObject("Year")
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

            panelRecord.DataBind()

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub ReadPastYearInfo()
        Try
            Dim MultiplierId As Integer = LocalAPI.GetNumericEscalar($"select Id from Company_MultiplierByYear where companyId={lblCompanyId.Text} and year={lblYear.Text - 1}")
            Dim RecordObject = LocalAPI.GetRecord(MultiplierId, "CompanyMultiplierRecord_SELECT")
            If MultiplierId > 0 Then
                ' Salary
                lblPastYear.Text = RecordObject("Year")
                lblPastSalary.Text = FormatNumber(RecordObject("Salary"), 2)
                lblPastTaxPercent.Text = RecordObject("TaxPercent")

                ' Productive Salary
                lblPastProductiveSalary.Text = FormatNumber(RecordObject("ProductiveSalary"), 2)

                'SubContracts
                lblPastSubContracts.Text = FormatNumber(RecordObject("SubContracts"), 2)
                'Rent
                lblPastRent.Text = FormatNumber(RecordObject("Rent"), 2)
                'Others
                lblPastOthers.Text = FormatNumber(RecordObject("Others"), 2)
                'Profit
                lblPastProfit.Text = FormatNumber(RecordObject("Profit"), 2)
            End If
            panelRecord.DataBind()
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub RadWizard1_NextButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.NextButtonClick
        Try

            If lblMultiplierId.Text = 0 Then
                ' Insert New Record before calculate....
                lblMultiplierId.Text = LocalAPI.CompanyMultiplier_INSERT(lblCompanyId.Text, lblYear.Text, txtSalary.DbValue, txtTaxPercent.DbValue, txtSubContracts.DbValue, txtRent.DbValue, txtOthers.DbValue, txtProductiveSalary.DbValue, txtProfit.DbValue, cboAutoSalary.SelectedValue, cboAutoProductiveSalary.SelectedValue, cboInitializeEmployee.SelectedValue, cboCalculateBudgetDepartment.SelectedValue, cboStatus.SelectedValue)
            End If

            ' Calculate Firt Time
            LocalAPI.CompanyCalculateMultiplier(lblCompanyId.Text, lblYear.Text)

            ' Record Current Year after Calculate
            ReadYearInfo()

        Catch ex As Exception

        End Try
    End Sub

    Private Sub RadWizard1_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.FinishButtonClick
        Try
            ' Update Record AGAIN....
            LocalAPI.CompanyMultiplier_UPDATE(lblMultiplierId.Text, txtSalary.DbValue, txtTaxPercent.DbValue, txtSubContracts.DbValue, txtRent.DbValue, txtOthers.DbValue, txtProductiveSalary.DbValue, txtProfit.DbValue, cboAutoSalary.SelectedValue, cboAutoProductiveSalary.SelectedValue, cboInitializeEmployee.SelectedValue, cboCalculateBudgetDepartment.SelectedValue, cboStatus.SelectedValue)

            ' Re-Calculate AGAIN
            Dim dbMultiplier As Double = LocalAPI.CompanyCalculateMultiplier(lblCompanyId.Text, lblYear.Text)
            lblFinalMultiplier.Text = FormatNumber(dbMultiplier, 2)

            RadGridMultiplier_log.DataBind()
            Master.InfoMessage("Multiplier Updated for " & lblYear.Text)
        Catch ex As Exception

        End Try

    End Sub

    Private Sub Back()
        If lblModeInsert.Text = 1 And lblFinalMultiplier.Text = "" Then
            ' Cancel Calculate, if NEW Year then DELETE
            LocalAPI.CompanyMultiplier_DELETE(lblCompanyId.Text, lblYear.Text)
        End If

        Response.Redirect("~/adm/companymultiplier")
    End Sub
    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Back()
    End Sub

    Private Sub RadWizard1_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.CancelButtonClick
        Back()
    End Sub

End Class