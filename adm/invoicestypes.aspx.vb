Public Class invoicestypes
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_BillingSchedules") Then Response.RedirectPermanent("~/adm/default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Payment Schedules"
            Master.PageTitle = "Proposals/Payment Schedules"
            Master.Help = "http://blog.pasconcept.com/2015/08/proposalpayment-schedules-list.html"
            lblCompanyId.Text = Session("companyId")
        End If

    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub
End Class
