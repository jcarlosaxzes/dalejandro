Public Class discipline
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_DisciplinesList") Then Response.RedirectPermanent("~/adm/default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". A/E Disciplines"
            Master.PageTitle = "Subconsultants/A/E Disciplines"
            Master.Help = "http://blog.pasconcept.com/2012/07/subconsultants-ae-disciplines-list.html"
            lblCompanyId.Text = Session("companyId")
        End If
    End Sub
    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub
End Class