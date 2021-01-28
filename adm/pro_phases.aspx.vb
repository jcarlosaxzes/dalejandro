Imports Telerik.Web.UI

Public Class pro_phases
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then

                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Master.UserId

                lblProposalId.Text = LocalAPI.GetProposalIdFromGUID(Request.QueryString("guid"))

                Master.ActiveTab(5)

            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try

    End Sub

    Protected Sub btnNewPhase_Click(sender As Object, e As EventArgs) Handles btnNewPhase.Click
        Response.Redirect($"~/adm/proposalphase.aspx?proposalId={lblProposalId.Text}&backpage=pro_phases")
    End Sub

    Private Sub RadGridPhases_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridPhases.ItemCommand
        Select Case e.CommandName
            Case "EditPhase"
                Response.Redirect($"~/adm/proposalphase.aspx?Id={e.CommandArgument}&proposalId={lblProposalId.Text}&backpage=pro_phases")
        End Select

    End Sub


End Class