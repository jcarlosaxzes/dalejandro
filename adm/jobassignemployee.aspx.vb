Imports Microsoft.AspNet.Identity
Imports Telerik.Web.UI
Public Class jobassignemployee
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblJobId.Text = Val("" & Request.QueryString("JobId"))
                lblJobName.Text = LocalAPI.GetJobName(lblJobId.Text)
                lblDptoId.Text = LocalAPI.GetJobProperty(lblJobId.Text, "DepartmentId")

                Dim UserEmail = Context.User.Identity.GetUserName()
                btnPrivate.Visible = LocalAPI.GetEmployeePermission(LocalAPI.GetEmployeeId(UserEmail, lblCompanyId.Text), "Allow_PrivateMode")

                If lblDptoId.Text > 0 Then
                    cboDepartment.DataBind()
                    cboDepartment.SelectedValue = lblDptoId.Text
                End If

                ' Define parameters
                'Dim employeeId As Integer = LocalAPI.GetJobProperty(lblJobId.Text, "Employee")
                'chkIsProjectManager.Checked = (LocalAPI.GetJobProperty(lblJobId.Text, "Employee")) = 0

                'If employeeId > 0 Then
                '    cboMulticolumnEmployee.Value = employeeId
                'End If
                cboMulticolumnEmployee.DataBind()

                'Calculo del Valor inicial del riesgo

                Dim dJobBudget = LocalAPI.GetJobProperty(lblJobId.Text, "Budget")
                Dim initialRisk As Integer

                Select Case dJobBudget
                    Case 0 To 2000
                        initialRisk = 90
                    Case 2001 To 4000
                        initialRisk = 80
                    Case 4001 To 6000
                        initialRisk = 70
                    Case Else
                        initialRisk = 60
                End Select

                sliderUsedBudget.Value = initialRisk
                gaugeUsedBudget.Pointer.Value = initialRisk

                If Val(cboMulticolumnEmployee.Value) > 0 Then
                    txtHourlyRate.MinValue = LocalAPI.GetEmployeeHourRate(cboMulticolumnEmployee.Value)
                    txtHourlyRate.Value = txtHourlyRate.MinValue
                End If
                DefineHoursPerBudget()

                Try
                    RadDatePickerDeadline.DbSelectedDate = LocalAPI.GetJobProperty(lblJobId.Text, "EndDay")
                Catch ex As Exception
                End Try

            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Sub DefineHoursPerBudget()
        Dim riskValue As Double = sliderUsedBudget.Value / 100
        If Val(cboMulticolumnEmployee.Value) > 0 Then
            Dim dJobBudget = LocalAPI.GetJobProperty(lblJobId.Text, "Budget")
            Dim dRate As Double
            If dJobBudget > 0 Then
                dRate = LocalAPI.GetEmployeeHourRate(cboMulticolumnEmployee.Value)
                If dRate > 0 Then
                    ' Budget ya comprometido con otros employees
                    Dim dAssinedBudget As Double = LocalAPI.GetJobs_Employees_HoursXHourRate_assigned(lblJobId.Text)
                    If dAssinedBudget > dJobBudget * riskValue Then
                        txtEmployeeHours.Value = 0
                    Else
                        ' simulacion tiempo total ajustado para cubrir 90% del Budget
                        txtEmployeeHours.Value = (dJobBudget * riskValue - dAssinedBudget) / dRate
                    End If
                Else
                    txtEmployeeHours.Value = 0
                End If
            Else
                txtEmployeeHours.Value = 0
            End If
        End If
    End Sub

    Protected Sub btnDefineEmployee_Click(sender As Object, e As EventArgs) Handles btnDefineEmployee.Click
        Try
            Dim Scope As String
            If Val(cboMulticolumnEmployee.Value) > 0 And Not LocalAPI.IsEmployeeAssignedToJob(lblJobId.Text, Val(cboMulticolumnEmployee.Value)) Then
                Dim JobCodeName As String = LocalAPI.GetJobCodeName(lblJobId.Text)

                ' Review sin status="Not in Progress" pasar a "In Progress"
                If chkIsProjectManager.Checked = True Then
                    LocalAPI.SetEmployeePMOfJob(cboMulticolumnEmployee.Value, lblJobId.Text)
                    Scope = "Project Manager"
                Else
                    Scope = "Employee"
                End If

                LocalAPI.Jobs_Employees_assigned_INSERT(lblJobId.Text, cboMulticolumnEmployee.Value, txtEmployeeHours.DbValue, txtHourlyRate.Value, Scope, cboPosition.SelectedValue)

                NotifyEmployee(cboMulticolumnEmployee.Value, JobCodeName, txtEmployeeHours.DbValue)

                ' Reset values
                cboMulticolumnEmployee.DataBind()
                cboMulticolumnEmployee.Value = 0
                chkIsProjectManager.Checked = False
            End If
        Catch ex As Exception
            lblMsg.Text = ex.Message
        End Try
    End Sub

    Protected Sub NotifyEmployee(employeeId As Integer, JobCodeName As String, dHourds As Double)
        Dim sFullBody As New System.Text.StringBuilder
        sFullBody.Append("You had been assigned Job " & JobCodeName)
        sFullBody.Append("<br />")
        sFullBody.Append("Hours (remaining): " & dHourds)
        sFullBody.Append("<br />")

        LocalAPI.EmailToEmployee(employeeId, "Job: '" & JobCodeName & "' asigned", sFullBody, lblCompanyId.Text)
        lblMsg.Text = "Employee notified"
    End Sub

    Private Sub SqlDataSourceEmpl_activos_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceEmpl_activos.Selecting
        Dim E1 As String = e.Command.Parameters(0).Value
    End Sub
    Protected Sub cboDepartment_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboDepartment.SelectedIndexChanged
        cboMulticolumnEmployee.DataBind()
        If Val(cboMulticolumnEmployee.Value) > 0 Then
            RefreshEmployeePositionRate()
        End If
        DefineHoursPerBudget()
    End Sub

    Private Sub sliderUsedBudget_ValueChanged(sender As Object, e As EventArgs) Handles sliderUsedBudget.ValueChanged
        gaugeUsedBudget.Pointer.Value = sliderUsedBudget.Value
        DefineHoursPerBudget()
    End Sub
    Protected Sub txtHourlyRate_TextChanged(sender As Object, e As EventArgs) Handles txtHourlyRate.TextChanged
        DefineHoursPerBudget()
    End Sub

    Private Sub btnPrivate_Click(sender As Object, e As EventArgs) Handles btnPrivate.Click
        Select Case btnPrivate.Text
            Case "Private"
                txtHourlyRate.Visible = True
                btnPrivate.Text = "Public"
            Case "Public"
                txtHourlyRate.Visible = False
                btnPrivate.Text = "Private"
        End Select
    End Sub

    Private Sub cboMulticolumnEmployee_SelectedIndexChanged(sender As Object, e As RadMultiColumnComboBoxSelectedIndexChangedEventArgs) Handles cboMulticolumnEmployee.SelectedIndexChanged
        RefreshEmployeePositionRate()
    End Sub

    Private Sub cboPosition_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboPosition.SelectedIndexChanged
        If cboPosition.SelectedValue = 0 Then
            ' No existe Position
            txtHourlyRate.MinValue = LocalAPI.GetPositionProperty(cboMulticolumnEmployee.Value, "HourRate")
        End If
        DefineHoursPerBudget()
    End Sub

    Protected Sub RefreshEmployeePositionRate()
        If Val(cboMulticolumnEmployee.Value) > 0 Then
            ' Employee defined, Get Position?
            cboPosition.SelectedValue = LocalAPI.GetEmployeeProperty(cboMulticolumnEmployee.Value, "PositionId")
        End If
        If cboPosition.SelectedValue = 0 Then
            ' No existe Position
            txtHourlyRate.MinValue = LocalAPI.GetEmployeeHourRate(cboMulticolumnEmployee.Value)
        Else
            ' Rate of Position
            txtHourlyRate.MinValue = LocalAPI.GetPositionProperty(cboPosition.SelectedValue, "HourRate")
        End If
        txtHourlyRate.Value = txtHourlyRate.MinValue

        DefineHoursPerBudget()
    End Sub
End Class
