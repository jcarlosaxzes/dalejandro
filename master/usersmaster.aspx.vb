Public Class usersmaster
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
        ConfigureExport_csv()
        RadGrid1.MasterTableView.ExportToCSV()
    End Sub

    Private Sub ConfigureExport_csv()
        RadGrid1.AllowPaging = False
        RadGrid1.ExportSettings.FileName = "PASConcept_PrimeUsers_" & Format(Date.Today, "MM-dd-yyyy")
        RadGrid1.ExportSettings.ExportOnlyData = True
        RadGrid1.ExportSettings.IgnorePaging = True
        RadGrid1.ExportSettings.OpenInNewWindow = True
    End Sub
End Class