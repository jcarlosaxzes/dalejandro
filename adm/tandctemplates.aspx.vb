Imports Telerik.Web.UI

Public Class tandctemplates
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ProposalTermsConditions") Then Response.RedirectPermanent("~/adm/default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Terms & Conditions"
            Master.PageTitle = "Proposals/Terms & Conditions"
            Master.Help = "http://blog.pasconcept.com/2012/04/fee-proposal-terms-and-conditions.html"
            lblCompanyId.Text = Session("companyId")

        End If
        RadWindowManager1.EnableViewState = False
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        Response.Redirect("~/ADM/tandctemplate_form.aspx")
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditTemplate"
                Response.Redirect("~/ADM/tandctemplate_form.aspx?templateId=" & e.CommandArgument)
        End Select
    End Sub



End Class
