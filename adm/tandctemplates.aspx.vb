Public Class tandctemplates
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ProposalTermsConditions") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Terms & Conditions"
            Master.PageTitle = "Proposals/Terms & Conditions"
            Master.Help = "http://blog.pasconcept.com/2012/04/fee-proposal-terms-and-conditions.html"
            lblCompanyId.Text = Session("companyId")

            Response.AddHeader("Set-Cookie", "HttpOnly;Secure;SameSite=Strict")
        End If

    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub
End Class
