Imports Telerik.Web.UI

Public Class employeewages
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Employees List"
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_EmployeesList") Then Response.RedirectPermanent("~/adm/schedule.aspx")

            lblCompanyId.Text = Session("companyId")

            cboYear.DataBind()
            If Not Request.QueryString("year") Is Nothing Then
                cboYear.SelectedValue = Request.QueryString("year")
            Else
                cboYear.SelectedValue = Year(Now())
            End If

            cboDepartments.DataBind()
            If Not Request.QueryString("departmentId") Is Nothing Then
                cboDepartments.SelectedValue = Request.QueryString("departmentId")
            End If

        End If

    End Sub

    Private Sub RadGridHourlyWage_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridHourlyWage.ItemCommand
        Select Case e.CommandName
            Case "EditHourlyWage"
                Dim guid As String = LocalAPI.GetEmployeeProperty(e.CommandArgument, "guid")
                Response.Redirect($"~/adm/employeehourlywage.aspx?guid={guid}&year={cboYear.SelectedValue}&departmentId={cboDepartments.SelectedValue}&backpage=employeewages")
        End Select

    End Sub

End Class