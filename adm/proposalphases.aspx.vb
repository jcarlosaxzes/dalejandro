Public Class proposalphases
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

    Protected Sub btnExcel_Click(sender As Object, e As EventArgs) Handles btnExcel.Click
        ConfigureExport()
        RadPivotGrid1.ExportToExcel()
    End Sub

    Private Sub ConfigureExport()
        Dim sProposalNumber As String = LocalAPI.ProposalNumber(lblproposalId.Text)
        RadPivotGrid1.ExportSettings.FileName = "ProposalPhases_" & sProposalNumber
        RadPivotGrid1.ExportSettings.IgnorePaging = True
        RadPivotGrid1.ExportSettings.OpenInNewWindow = True
        RadPivotGrid1.ExportSettings.UseItemStyles = False
    End Sub
End Class
