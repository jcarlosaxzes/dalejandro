Public Class messagestemplates
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            lblCompanyId.Text = Session("companyId")

        End If
    End Sub

    Private Sub btnRestore_Click(sender As Object, e As EventArgs) Handles btnRestore.Click
        LocalAPI.RestoreDefaultMessageTemplate(lblCompanyId.Text)
        RadGrid1.DataBind()
    End Sub
End Class