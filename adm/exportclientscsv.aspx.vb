Public Class exportclientscsv
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Master.PageTitle = "Export Clients"
            Master.Help = "http://blog.pasconcept.com/2015/04/clientsexport-client-list.html"
        End If
    End Sub

    Private Sub btnOk_Click(sender As Object, e As EventArgs) Handles btnOk.Click
        LocalAPI.ExportClients(HttpContext.Current, txtFileName.Text, cboSep.SelectedValue)
    End Sub
End Class