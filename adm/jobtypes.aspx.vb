Public Class jobtypes
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_JobCodes") Then Response.RedirectPermanent("~/adm/schedule.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Job Types"
            Master.PageTitle = "Jobs/Job Types"
            Master.Help = "http://blog.pasconcept.com/2012/05/jobs-job-type-classification-codes.html"

            lblCompanyId.Text = Session("companyId")
        End If
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub
End Class
