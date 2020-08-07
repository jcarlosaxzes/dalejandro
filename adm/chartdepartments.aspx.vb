Imports Telerik.Web.UI
Public Class chartdepartments
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not IsPostBack Then
                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_DepartmentChart") Then Response.RedirectPermanent("~/adm/default.aspx")

                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Monthly Current vs Target"
                Master.PageTitle = "Departments/Monthly Current vs Target"
                Master.Help = "http://blog.pasconcept.com/2015/03/departments.html"
                lblCompanyId.Text = Session("companyId")


                lblEmployeeEmail.Text = Master.UserEmail
                cboDepartments.DataBind()
                Dim nDefaultDep As Integer = LocalAPI.GetEmployeeProperty(LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text), "FilterJob_Department")
                If nDefaultDep > 0 Then
                    ' Solo ve su Dpto
                    cboDepartments.SelectedValue = nDefaultDep
                    cboDepartments.Enabled = False
                End If

            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub btnFind_Click(sender As Object, e As EventArgs) Handles btnFind.Click
        If cboCurrentSource.SelectedValue = 0 Then
            SqlDataSource1.SelectCommand = "BudgetDepartments_Chart"
        Else
            SqlDataSource1.SelectCommand = "BudgetDepartmentsFromPyments_Chart"
        End If
        RadGrid1.DataBind()
        RadHtmlChart1.DataBind()
    End Sub
End Class
