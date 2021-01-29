Imports Telerik.Web.UI

Public Class pro_proposal
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then

                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Master.UserId

                ' Si no tiene permiso, la dirijo a message
                'If Not LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Deny_ProposalsList") Then Response.RedirectPermanent("~/adm/default.aspx")

                lblProposalId.Text = LocalAPI.GetProposalIdFromGUID(Request.QueryString("guid"))
                lblClientId.Text = LocalAPI.GetProposalProperty(lblProposalId.Text, "ClientId")
                panelViewProposalPage.DataBind()

                IsProposalReadOnly()

                Master.ActiveTab(0)

            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Private Function IsProposalReadOnly() As Boolean

        ' If Proposal Acepted, special Permit to change
        btnUpdate1.Enabled = (lblOriginalStatus.Text <> 4 And lblOriginalStatus.Text <> 2) ' diferente de Revised
        btnDeleteProposal.Enabled = (lblOriginalStatus.Text <> 2) ' diferente de Acepted

        btnNewTask.Enabled = btnUpdate1.Enabled
        RadGrid1.AllowAutomaticUpdates = btnUpdate1.Enabled
        RadGrid1.AllowAutomaticDeletes = btnUpdate1.Enabled

        Return btnUpdate1.Enabled

    End Function

#Region "ToolButtons Top"
    Protected Sub btnConfirmDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnConfirmDelete.Click
        LocalAPI.EliminarProposal(lblProposalId.Text)
        Response.Redirect("~/adm/proposals.aspx?restoreFilter=true")
    End Sub

    Protected Sub btnCancelDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelDelete.Click
        OcultarConfirmDelete()
    End Sub

    Protected Sub btnUpdate1_Click(sender As Object, e As System.EventArgs) Handles btnUpdate1.Click
        GuardarProposal(True)
    End Sub

    Protected Sub btnDeleteProposal_Click(sender As Object, e As System.EventArgs) Handles btnDeleteProposal.Click
        MostrarConfirmDelete()
    End Sub

    Private Sub MostrarConfirmDelete()
        RadToolTipDelete.Visible = True
        RadToolTipDelete.Show()
    End Sub

    Private Sub OcultarConfirmDelete()
        RadToolTipDelete.Visible = False
    End Sub

    Protected Sub btnPrintProposal_Click(sender As Object, e As EventArgs) Handles btnPrintProposal.Click
        If LocalAPI.GetProposalProperty(lblProposalId.Text, "ClientId") > 0 Then
            Response.Redirect("~/adm/SendProposal.aspx?ProposalId=" & lblProposalId.Text & "&backpage=proposal&HideMasterMenu=1")
        Else
            Master.InfoMessage("You Must Specify the Client and Update Proposal")
        End If

    End Sub

    Protected Sub btnPdf_Click(sender As Object, e As EventArgs) Handles btnPdf.Click
        Dim ProposalUrl = LocalAPI.GetSharedLink_URL(11, lblProposalId.Text)
        Session("PrintUrl") = ProposalUrl
        Session("PrintName") = "Proposal_" & LocalAPI.ProposalNumber(lblProposalId.Text) & ".pdf"
        Response.Redirect("~/ADM/pdf_print.aspx")
    End Sub

    Private Sub GuardarProposal(bMsg As Boolean)
        Try
            Dim sMsg As String = "Proposal Successfully Updated"
            FormViewProp1.UpdateItem(False)
            If bMsg Then Master.InfoMessage(sMsg)
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try

    End Sub

#End Region


#Region "Task"
    Protected Sub btnNewTask_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewTask.Click
        Try
            GuardarProposal(False)
            Response.Redirect($"~/adm/proposaltask.aspx?proposalId={lblProposalId.Text}&backpage=pro_proposal")
        Catch ex As Exception
        End Try
    End Sub

    Private Sub RadGrid1_PreRender(sender As Object, e As EventArgs) Handles RadGrid1.PreRender
        RadGrid1.MasterTableView.GetColumn("phaseId").Display = IIf(LocalAPI.GetProposalPhasesCount(lblProposalId.Text) = 0, False, True)
        If lblCompanyId.Text = 260962 Then
            ' 6/9/2020 Fernando y Raissa ddefinen que no es visible en EEG
            RadGrid1.MasterTableView.GetColumn("Estimated").Visible = False
        End If
    End Sub

    Private Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim statusId As String = LocalAPI.GetProposalData(lblProposalId.Text, "statusId")
        Select Case e.CommandName
            Case "EditTask"
                Response.Redirect($"~/adm/proposaltask.aspx?proposalId={lblProposalId.Text}&detailId={e.CommandArgument}&backpage=pro_proposal")
            Case "DetailDuplicate"
                If lblOriginalStatus.Text <= 1 Then
                    lblDetailSelectedId.Text = e.CommandArgument
                    SqlDataSourceProposaldDetailDuplicate.Insert()
                    RadGrid1.DataBind()
                End If

            Case "OrderDown"
                If statusId <= 1 Then
                    LocalAPI.ProposalDetail_OrderBy_UPDATE(e.CommandArgument, 1)
                    RadGrid1.DataBind()
                End If
            Case "OrderUp"
                If statusId <= 1 Then
                    LocalAPI.ProposalDetail_OrderBy_UPDATE(e.CommandArgument, -1)
                    RadGrid1.DataBind()
                End If
        End Select

    End Sub
#End Region

End Class