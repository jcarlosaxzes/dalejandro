Public Class employeereport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Allow_DepartmentReport") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Master.PageTitle = "Analytics/Employee Report"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Employee Report"
            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")

            cboYear.DataBind()
            cboEmployees.DataBind()

            RefreshPage()
        End If
    End Sub
    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RefreshPage()
    End Sub

    Private Sub RefreshPage()
        btnView.DataBind()
    End Sub

    Protected Sub btnMemory_Click(sender As Object, e As EventArgs) Handles btnMemory.Click
        LocalAPI.EmployeeEmailMemory(cboEmployees.SelectedValue, lblCompanyId.Text, cboYear.SelectedValue)
    End Sub
    Public Function GetMemoryUrl() As String
        Return "~/adm/memory.aspx?companyId=" & lblCompanyId.Text & "&year=" & cboYear.SelectedValue & "&employeeId=" & cboEmployees.SelectedValue
    End Function
End Class
