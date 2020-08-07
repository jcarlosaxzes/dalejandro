Public Class transmittalpackagetypes
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_TransmittalPackageTypes") Then Response.RedirectPermanent("~/adm/default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Transmittal Package Types"
            Master.PageTitle = "Transmittal Package Types"
            Master.Help = "http://blog.pasconcept.com/2015/04/jobstransmittal-letter.html"
            lblCompanyId.Text = Session("companyId")
        End If
    End Sub

    Private Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub
End Class