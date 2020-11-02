Public Class billingplans
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As EventArgs) Handles Me.PreInit
        Theme = LocalAPI.DefinirTheme(Request.UserAgent)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
        End If
    End Sub

    Private Sub btnNewPlan_Click(sender As Object, e As EventArgs) Handles btnNewPlan.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub
End Class
