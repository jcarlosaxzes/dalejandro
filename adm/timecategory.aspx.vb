Public Class timecategory
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_TimeCategory") Then Response.RedirectPermanent("~/ADM/Default.aspx")


            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Time Categories"
            Master.PageTitle = "Company/Time Categories"
            Master.Help = "http://blog.pasconcept.com/2015/08/otherstime-categories-list.html"
            lblCompanyId.Text = Session("companyId")
        End If
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub

End Class
