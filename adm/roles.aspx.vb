Imports Telerik.Web.UI

Public Class roles
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")

                If Not Master.IsMasterUser() Then
                    Response.RedirectPermanent("~/ADM/Default.aspx")
                End If

                Master.PageTitle = "Employee/Roles"
            End If
            RadWindowManager1.EnableViewState = False

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Private Sub btnNewRole_Click(sender As Object, e As EventArgs) Handles btnNewRole.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "Permits"
                Response.Redirect("~/ADM/role_Permissions_form.aspx?roleId=" & e.CommandArgument)
        End Select
    End Sub

    Private Sub btnInitialize_Click(sender As Object, e As EventArgs) Handles btnInitialize.Click
        SqlDataSourceInitRoles.Insert()
        RadGrid1.DataBind()
        Master.InfoMessage("Roles have been initialized!")
    End Sub
End Class
