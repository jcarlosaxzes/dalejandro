Public Class phasestemplate
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ProposalTemplates") Then Response.RedirectPermanent("~/adm/schedule.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Phases Templates"
            Master.PageTitle = "Proposal/Phases templates"
            Master.Help = "http://blog.pasconcept.com/"
            lblCompanyId.Text = Session("companyId")
        End If
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub
End Class
