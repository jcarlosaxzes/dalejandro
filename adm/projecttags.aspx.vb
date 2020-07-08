Imports Telerik.Web.UI
Public Class projecttags
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            'If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_JobCodes") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Project Tags"
            Master.PageTitle = "Jobs/Project Tags"
            'Master.Help = "http://blog.pasconcept.com/2012/07/subconsultants-ae-disciplines-list.html"
            lblCompanyId.Text = Session("companyId")

            cboDepartments.DataBind()
            Dim userDepartmentId As Integer = LocalAPI.GetEmployeeProperty(LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text), "DepartmentId")
            If userDepartmentId > 0 Then
                cboDepartments.SelectedValue = userDepartmentId
            End If


        End If
    End Sub

    Private Sub cboDepartments_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboDepartments.SelectedIndexChanged
        cboCategory.Items.Clear()
        cboCategory.DataBind()
    End Sub

    Private Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub
End Class


