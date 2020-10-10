Imports Telerik.Web.UI

Public Class Notifications
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblCompanyId.Text = Session("companyId")
        End If
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand

        Select Case e.CommandName
            Case "Edit"
                Dim id = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex)("Id").ToString()
                Response.Redirect($"~/adm/notificationsnew.aspx?EntityId={id}&EntityType=Notifications&backpage=Notifications")
        End Select
    End Sub


End Class