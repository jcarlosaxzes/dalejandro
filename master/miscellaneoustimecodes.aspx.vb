Public Class miscellaneoustimecodes
    Inherits System.Web.UI.Page
    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub

End Class