Imports Telerik.Web.UI
Public Class proposal_types
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ProposalTemplates") Then Response.RedirectPermanent("~/adm/schedule.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Proposal Templates"
            Master.PageTitle = "Proposals/Proposal Templates"
            Master.Help = "http://blog.pasconcept.com/2012/04/fee-proposal-templates.html"

            lblCompanyId.Text = Session("companyId")
        End If
        RadWindowManager1.EnableViewState = False

    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditTemplate"
                Response.Redirect("~/ADM/proposaltemplate.aspx?templateId=" & e.CommandArgument)

        End Select
    End Sub


    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        Response.Redirect("~/ADM/proposaltemplate.aspx")
    End Sub

End Class
