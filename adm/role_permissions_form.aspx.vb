Public Class role_permissions_form
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            If Not Master.IsMasterUser() Then
                Response.RedirectPermanent("~/adm/schedule.aspx")
            End If
            lblCompanyId.Text = Session("companyId")
            lblRoleId.Text = Request.QueryString("roleId")
            If LocalAPI.IsCompanyViolation(lblRoleId.Text, "Employees_roles", lblCompanyId.Text) Then Response.RedirectPermanent("~/adm/schedule.aspx")
            FormView1.DataBind()
        End If
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/roles.aspx")
    End Sub
End Class