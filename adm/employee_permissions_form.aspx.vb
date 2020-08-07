Public Class employee_permissions_form
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            If Not Master.IsMasterUser() Then
                Response.RedirectPermanent("~/adm/default.aspx")
            End If
            lblCompanyId.Text = Session("companyId")
            lblEmployeeId.Text = Request.QueryString("employeeId")
            If LocalAPI.IsCompanyViolation(lblEmployeeId.Text, "Employees", lblCompanyId.Text) Then Response.RedirectPermanent("~/adm/default.aspx")

            lblEmployeeEmail.Text = LocalAPI.GetEmployeeEmail(lId:=lblEmployeeId.Text)
            lblEmployeeName.Text = LocalAPI.GetEmployeeFullName(lblEmployeeEmail.Text, lblCompanyId.Text) & " " & LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "Role")
        End If
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/employee_permissions.aspx")
    End Sub
End Class