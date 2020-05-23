Imports Telerik.Web.UI

Public Class naics_us_codes
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            lblCompanyId.Text = Session("companyId")
            RadTreeListNaics.DataBind()
        End If
    End Sub

    Private Sub SqlDataSource1_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSource1.Selecting
        Dim LevelsList As String = ""
        Dim collection As IList(Of RadComboBoxItem) = cboLeves.CheckedItems
        If (collection.Count <> 0) Then
            For Each item As RadComboBoxItem In collection
                LevelsList = LevelsList + item.Value + ","
            Next
            ' Quitar la ultima coma
            LevelsList = Left(LevelsList, Len(LevelsList) - 1)
        Else
            LevelsList = "0"
        End If
        e.Command.Parameters("@LevelIdIN_List").Value = LevelsList
    End Sub

    Private Sub btnTablePage_Click(sender As Object, e As EventArgs) Handles btnTablePage.Click
        ViewMode(False)
    End Sub
    Private Sub btnTreePage_Click(sender As Object, e As EventArgs) Handles btnTreePage.Click
        ViewMode(True)
    End Sub
    Private Sub ViewMode(TreeView As Boolean)
        If TreeView Then
            btnTreePage.Visible = False
            RadGridNaics.Visible = False

            btnTablePage.Visible = True
            RadTreeListNaics.Visible = True
            RadTreeListNaics.DataBind()
        Else
            btnTablePage.Visible = False
            RadTreeListNaics.Visible = False

            btnTreePage.Visible = True
            RadGridNaics.Visible = True
            RadGridNaics.DataBind()
        End If

    End Sub

    Private Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        If btnTreePage.Visible Then
            RadGridNaics.DataBind()
        Else
            RadTreeListNaics.DataBind()
        End If
    End Sub
End Class