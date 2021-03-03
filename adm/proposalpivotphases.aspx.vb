Public Class proposalpivotphases
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                lblCompanyId.Text = Session("companyId")
                lblproposalId.Text = Request.QueryString("proposalId")
                lblProposal.Text = LocalAPI.ProposalNumber(lblproposalId.Text)

            End If

        Catch ex As Exception

        End Try

    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect(LocalAPI.GetSharedLink_URL(11006, lblproposalId.Text))
    End Sub
End Class