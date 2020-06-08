Public Class newpropsalphase
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                lblCompanyId.Text = Session("companyId")
                lblproposalId.Text = Request.QueryString("Id")
            End If

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Response.Redirect("~/adm/proposal.aspx?proposalId=" & lblproposalId.Text & "&Tab2=1")
    End Sub
    Protected Sub cboPhaseTemplate_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles cboPhaseTemplate.SelectedIndexChanged
        If cboPhaseTemplate.SelectedValue > 0 Then
            CodeTextBox.Text = LocalAPI.GetPhaseTemplateProperty(cboPhaseTemplate.SelectedValue, "Code")
            NameTextBox.Text = LocalAPI.GetPhaseTemplateProperty(cboPhaseTemplate.SelectedValue, "Name")
            DescriptionEditor.Content = LocalAPI.GetPhaseTemplateProperty(cboPhaseTemplate.SelectedValue, "Description")
        End If
    End Sub
    Protected Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        SqlDataSource1.Insert()
    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        Response.Redirect("~/adm/proposal.aspx?proposalId=" & lblproposalId.Text & "&Tab2=1")
    End Sub
End Class
