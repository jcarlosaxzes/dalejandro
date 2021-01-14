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

            If Not Request.QueryString("backpage") Is Nothing Then
                Session("permissionsbackpage") = Request.QueryString("backpage")
            End If

            lblEmployeeEmail.Text = LocalAPI.GetEmployeeEmail(lId:=lblEmployeeId.Text)
            lblEmployeeName.Text = LocalAPI.GetEmployeeFullName(lblEmployeeEmail.Text, lblCompanyId.Text) & " " & LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "Role")
        End If
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Select Case Session("permissionsbackpage")
            Case "employees"
                Response.Redirect("~/adm/employees.aspx")
            Case Else
                Response.Redirect("~/adm/employee_permissions.aspx")
        End Select

    End Sub
End Class