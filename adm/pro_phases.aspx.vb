Imports Telerik.Web.UI

Public Class pro_phases
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then

                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Master.UserId

                lblProposalId.Text = LocalAPI.GetProposalIdFromGUID(Request.QueryString("guid"))

                IsProposalReadOnly()

                Master.ActiveTab(2)

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
            Case "AddTaskInPhase"
                Response.Redirect($"~/adm/proposaltask.aspx?proposalId={lblProposalId.Text}&backpage=proposalnewwizard&phaseId={e.CommandArgument}")
        End Select

    End Sub

    Private Function IsProposalReadOnly() As Boolean
        lblOriginalStatus.Text = LocalAPI.GetProposalData(lblProposalId.Text, "statusId")
        If lblOriginalStatus.Text > 1 Then
            btnNewPhase.Visible = False
            RadGridPhases.AllowAutomaticDeletes = False
            RadGridPhases.AllowAutomaticUpdates = False

            btnNewFee.Visible = False
            RadGridFees.AllowAutomaticDeletes = False
            RadGridFees.AllowAutomaticDeletes = False
            Return True
        Else
            Return False
        End If
    End Function

#Region "Fees_Step2"

    Private Sub btnNewFee_Click(sender As Object, e As EventArgs) Handles btnNewFee.Click
        Response.Redirect("~/adm/proposaltask.aspx?proposalId=" & lblProposalId.Text & "&backpage=pro_phases")
    End Sub

    Private Sub RadGridFees_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridFees.ItemCommand
        Dim statusId As String = LocalAPI.GetProposalData(lblProposalId.Text, "statusId")
        Select Case e.CommandName
            Case "EditTask"
                Response.Redirect($"~/adm/proposaltask.aspx?proposalId={lblProposalId.Text}&detailId={e.CommandArgument}&backpage=pro_phases")
            Case "OrderDown"
                If statusId <= 1 Then
                    LocalAPI.ProposalDetail_OrderBy_UPDATE(e.CommandArgument, 1)
                    RadGridFees.DataBind()
                End If
            Case "OrderUp"
                If statusId <= 1 Then
                    LocalAPI.ProposalDetail_OrderBy_UPDATE(e.CommandArgument, -1)
                    RadGridFees.DataBind()
                End If

            Case "DetailDuplicate"
                If statusId <= 1 Then
                    lblDetailSelectedId.Text = e.CommandArgument
                    SqlDataSourceProposaldDetailDuplicate.Insert()
                    RadGridFees.DataBind()
                End If
        End Select

    End Sub

#End Region

End Class