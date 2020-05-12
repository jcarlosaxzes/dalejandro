Public Class dashboard
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Dashboard") Then Response.RedirectPermanent("~/ADM/Default")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Dashboard"
            Master.PageTitle = "Analytics/Dashboard"
            Master.Help = "http://blog.pasconcept.com/2015/03/dashboard.html"
            lblCompanyId.Text = Session("companyId")


            RadHtmlChart1.Navigator.RangeSelector.From = DateAdd(DateInterval.Year, -2, Date.Today)
            RadHtmlChart1.Navigator.RangeSelector.[To] = Date.Today

            RadHtmlChartBillCollected.Navigator.RangeSelector.From = DateAdd(DateInterval.Year, -1, Date.Today)
            RadHtmlChartBillCollected.Navigator.RangeSelector.[To] = Date.Today


        End If
    End Sub

End Class
