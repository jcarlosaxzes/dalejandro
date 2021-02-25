Public Class departmentslist
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            '!!! pending permiso especifico
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_DepartmentsList") Then Response.RedirectPermanent("~/adm/schedule.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Department List"
            Master.PageTitle = "Departments/Department List"
            Master.Help = "http://blog.pasconcept.com/2015/03/departments.html"
            lblCompanyId.Text = Session("companyId")
        End If
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        Response.Redirect("~/adm/department_form.aspx")
    End Sub
    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Select Case e.CommandName
            Case "EditDepartment"
                Response.Redirect("~/adm/department_form.aspx?DepartmentId=" & e.CommandArgument)

        End Select
    End Sub
End Class
