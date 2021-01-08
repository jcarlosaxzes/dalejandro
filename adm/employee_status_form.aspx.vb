Public Class employee_status_form
    Inherits System.Web.UI.Page

    Protected Property SuccessMessageText() As String
        Get
            Return m_SuccessMessage
        End Get
        Private Set(value As String)
            m_SuccessMessage = value
            successMessage.Visible = Not [String].IsNullOrEmpty(value)
        End Set
    End Property
    Private m_SuccessMessage As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            lblCompanyId.Text = Session("companyId")
            lblEmployeeId.Text = Request.QueryString("employeeId")
            lblEmployeeEmail.Text = LocalAPI.GetEmployeeEmail(lId:=lblEmployeeId.Text)
            lblEmployeeName.Text = LocalAPI.GetEmployeeFullName(lblEmployeeEmail.Text, lblCompanyId.Text)
            RadDatePicker1.DbSelectedDate = Date.Today
            lblCurrentInactive.Text = IIf(LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "Inactive"), 1, 0)
            lblNewInactive.Text = IIf(lblCurrentInactive.Text, 0, 1)

            panelActive.Enabled = (lblCurrentInactive.Text = 1)
            txtHourlyRate.Value = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "HourRate")
            txtBenefits_vacations.Value = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "Benefits_vacations")
            txtBenefits_personals.Value = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "Benefits_personals")
            Try
                txtProducer.Value = LocalAPI.GetDepartmentsProperty(LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "DepartmentId"), "Productive")
            Catch ex As Exception
            End Try


            If lblCurrentInactive.Text Then
                lblCurrentStatus.Text = "Inactive"
                lblInactive_Date.Text = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "Inactive_Date")
                lblCurrentStatus.ForeColor = System.Drawing.Color.Red
                btnChangeStatus.Text = "Set Active"

            Else
                lblCurrentStatus.Text = "Active"
                lblCurrentStatus.ForeColor = System.Drawing.Color.DarkGreen
                btnChangeStatus.Text = "Set Inactive"
                btnChangeStatus.CssClass = "btn btn-danger btn-lg"
            End If

            lblCurrentAnualPSalary.Text = FormatNumber(LocalAPI.GetCompanyMultiplierProperty(lblCompanyId.Text, "Salary"), 2)
            lblCurrentMultiplier.Text = FormatNumber(LocalAPI.GetCompanyMultiplier(lblCompanyId.Text, Year(Today)), 2)
        End If
    End Sub

    Private Sub btnChangeStatus_Click(sender As Object, e As EventArgs) Handles btnChangeStatus.Click
        If chkConfirm.Checked Then
            '1- Employee status and Employee_HourlyWageHistory
            SqlDataSource1.Update()
            SuccessMessageText = "Employee status Changed successfully!"
            If lblCurrentInactive.Text Then
                lblCurrentStatus.Text = "Active"
                lblCurrentStatus.ForeColor = System.Drawing.Color.DarkGreen
                lblInactive_Date.Text = ""
            Else
                lblCurrentStatus.Text = "Inactive"
                lblCurrentStatus.ForeColor = System.Drawing.Color.Red
                lblInactive_Date.Text = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "Inactive_Date")
            End If

            '2- eeg360 user
            If lblCompanyId.Text = 260962 Then
                ' Change status in eeg360
                eeg360.EmployeeStatus_UPDATE(lblEmployeeEmail.Text, IIf(lblCurrentInactive.Text = 0, 1, 0))
                btnChangeStatus.Visible = False
            End If

            '3- ProductiveSalary
            lblCurrentAnualPSalary.Font.Strikeout = True
            lblCurrentAnualPSalary.ForeColor = System.Drawing.Color.Gray

            '4- Recalculate Multiplier
            LocalAPI.CompanyCalculateMultiplier(lblCompanyId.Text, Year(Today))

            Dim dbMultiplier As Double = LocalAPI.GetCompanyMultiplier(lblCompanyId.Text, Year(Today))
            LocalAPI.DeparmentBudgetByBaseSalaryForMultiplierFromThisMonth(lblCompanyId.Text, dbMultiplier, Year(Today), Month(Today))
            lblNewMultiplier.Text = "New Multiplier: " & FormatNumber(dbMultiplier, 2)
            lblCurrentMultiplier.Font.Strikeout = True
            lblCurrentMultiplier.ForeColor = System.Drawing.Color.Gray

            lblNewAnualPSalary.Text = " ...Was updated to: " & FormatNumber(LocalAPI.GetCompanyMultiplierProperty(lblCompanyId.Text, "Salary"), 2)
            lblNewMultiplier.Text = " ...Was updated to: " & FormatNumber(LocalAPI.GetCompanyMultiplier(lblCompanyId.Text, Year(Today)), 2)

            chkConfirm.Visible = False
            btnChangeStatus.Visible = False
        Else
            SuccessMessageText = "Confirm that you will change the status of the employee!"
        End If
    End Sub

    Private Sub SqlDataSource1_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource1.Updating
        Dim e1 As String = e.Command.Parameters("@Inactive").Value
    End Sub
End Class
