Public Class historylog
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Title = ConfigurationManager.AppSettings("Titulo") & ". History Log"
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_HistoryLog") Then Response.RedirectPermanent("~/adm/default.aspx")

            Master.PageTitle = "Company/History Log"
            Master.Help = "http://blog.pasconcept.com/2012/08/others-pasconcept-history-log.html"
            lblCompanyId.Text = Session("companyId")
        End If
    End Sub

End Class
