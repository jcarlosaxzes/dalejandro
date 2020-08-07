Public Class jobuse
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_UseClassification") Then Response.RedirectPermanent("~/adm/default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Use & Occupancy Classification"
            Master.PageTitle = "Proposals/Use & Occupancy Classification"
            Master.Help = "http://blog.pasconcept.com/2015/08/proposalsuse-occupancy-classification.html"
            lblCompanyId.Text = Session("companyId")
        End If
    End Sub

End Class


