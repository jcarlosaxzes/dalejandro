Imports Telerik.Web.UI

Public Class clientscolletion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ClientsColletion") Then Response.RedirectPermanent("~/adm/default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Clients Collection"
            Master.PageTitle = "Clients Collection"
            lblCompanyId.Text = Session("companyId")
            If Not Request.QueryString("restoreFilter") Is Nothing Then
                RestoreFilter()
            End If
        End If
    End Sub

    Private Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        Response.Redirect("~/adm/newclientcollection.aspx")
    End Sub

    Private Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Select Case e.CommandName
            Case "Notification"
                Response.Redirect("~/adm/newclientcollection.aspx?collectionId=" & e.CommandArgument)
            Case "Close"
                LocalAPI.SetClientCollectionCloseOpen(e.CommandArgument)
                RadGrid1.DataBind()
                Master.InfoMessage("The record has changed its status!")
        End Select
    End Sub

    Protected Sub btnFind_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFind.Click
        SaveFilter()
        RadGrid1.DataBind()
    End Sub

    Private Sub SaveFilter()
        Session("Filter_Collect_cboStatus") = cboStatus.SelectedValue
        Session("Filter_Collect_txtFind") = txtFind.Text
    End Sub

    Private Sub RestoreFilter()
        Try
            cboStatus.SelectedValue = Session("Filter_Collect_cboStatus")
            txtFind.Text = Session("Filter_Collect_txtFind")
        Catch ex As Exception
        End Try
    End Sub
End Class