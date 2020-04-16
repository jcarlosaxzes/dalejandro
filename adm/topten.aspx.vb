Public Class topten
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Analytics") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Top Ten"
            Master.PageTitle = "Analytics/Most Important Clients"
            lblCompanyId.Text = Session("companyId")
            Master.Help = "http://blog.pasconcept.com/2015/04/analyticstop-ten-chart.html"
        End If
    End Sub

End Class
