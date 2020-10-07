Public Class CreateJobFromProposal
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnFind_Click(sender As Object, e As EventArgs)
        Dim proposalId = txtProposalId.Text
        Dim companyId = cboCompany.SelectedValue
        LocalAPI.ProposalCreateJob(proposalId, companyId)
    End Sub
End Class