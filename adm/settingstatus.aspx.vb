Public Class settingstatus
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_CompanyProfile") Then Response.RedirectPermanent("~/adm/schedule.aspx")

            lblCompanyId.Text = Session("companyId")
            Master.PageTitle = "Start/Setting Status"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Setting Status"
        End If

    End Sub

End Class