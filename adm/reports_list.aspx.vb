Imports Telerik.Web.UI

Public Class reports_list
    Inherits System.Web.UI.Page

    Dim QueryGropu As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_AnalyticReports") Then Response.RedirectPermanent("~/adm/default.aspx")

            lblCompanyId.Text = Session("companyId")

            If Not Request.QueryString("group") Is Nothing Then
                QueryGropu = Request.QueryString("group")
                TreeListReports.DataBind()
                Dim item = TreeListReports.FindItemByKeyValue("Name", QueryGropu)
                If Not IsNothing(item) Then
                    item.Expanded = True
                End If
            End If

        End If
    End Sub

    Private Sub TreeListReports_ItemCommand(sender As Object, e As TreeListCommandEventArgs) Handles TreeListReports.ItemCommand
        If e.CommandName = "Expand_Colapse" Then

            'Dime item TreeListReports.FindItemByKeyValue("Name", e.CommandArgument)
            Dim clickedItem As TreeListDataItem = e.Item

            clickedItem.Expanded = Not clickedItem.Expanded

            'clickedItem.Selected = Not clickedItem.Selected
        End If

        If e.CommandName = "Report" Then

            Dim reposrId As Integer = Val(e.CommandArgument)
            Response.Redirect("~/adm/reports?Id=" & reposrId)

        End If
    End Sub
End Class