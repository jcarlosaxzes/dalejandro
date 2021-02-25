Public Class nojobstimetypes
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_MiscellaneousTimeCodes") Then Response.RedirectPermanent("~/adm/schedule.aspx")


            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Miscellaneous Time Codes"
            Master.PageTitle = "Company/Miscellaneous Time Codes"
            Master.Help = "http://blog.pasconcept.com/2012/08/other-miscellaneous-time-codes.html"
            lblCompanyId.Text = Session("companyId")
        End If
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub
End Class
