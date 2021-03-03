Imports Telerik.Web.UI

Public Class pro_proposal
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then

                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Master.UserId

                ' Si no tiene permiso, la dirijo a message
                'If Not LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Deny_ProposalsList") Then Response.RedirectPermanent("~/adm/schedule.aspx")

                lblProposalId.Text = LocalAPI.GetProposalIdFromGUID(Request.QueryString("guid"))
                lblClientId.Text = LocalAPI.GetProposalProperty(lblProposalId.Text, "ClientId")

                IsProposalReadOnly()

                Master.ActiveTab(0)

            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Private Function IsProposalReadOnly() As Boolean
        lblOriginalStatus.Text = LocalAPI.GetProposalData(lblProposalId.Text, "statusId")
        lblOriginalType.Text = LocalAPI.GetProposalData(lblProposalId.Text, "Proposal.Type")
        lblOriginalJobId.Text = LocalAPI.GetProposalProperty(lblProposalId.Text, "JobId")

        ' If Proposal Acepted, special Permit to change
        btnUpdate.Visible = (lblOriginalStatus.Text <> 4 And lblOriginalStatus.Text <> 2) ' diferente de Revised
        btnActions.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Allow_EditAcceptedProposal")

        If lblOriginalStatus.Text > 1 Then
            FormView1.DefaultMode = FormViewMode.ReadOnly
            Return True
        Else
            FormView1.DefaultMode = FormViewMode.Edit
            Return False
        End If

    End Function

#Region "ToolButtons Top"

    Protected Sub btnUpdate_Click(sender As Object, e As System.EventArgs) Handles btnUpdate.Click
        GuardarProposal(True)
    End Sub


    Private Sub GuardarProposal(bMsg As Boolean)
        Try
            Dim sMsg As String = "Proposal Successfully Updated"
            FormView1.UpdateItem(False)

            If bMsg Then Master.InfoMessage(sMsg)
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try

    End Sub

#End Region


#Region "Actions"
    Private Sub btnActions_Click(sender As Object, e As EventArgs) Handles btnActions.Click
        cboStatus.SelectedValue = lblOriginalStatus.Text
        RadToolTipActions.Visible = True
        RadToolTipActions.Show()
    End Sub

    Private Sub SqlDataSourceProp1_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceProp1.Updating
        'Allow unlink Job from Proposal
        'If Val(lblOriginalJobId.Text) > 0 Then
        e.Command.Parameters("@JobId").Value = Val(lblOriginalJobId.Text)
        'Else
        '    If Val("" & LocalAPI.GetProposalData(lblProposalId.Text, "JobId")) > 0 Then
        '        e.Command.Parameters("@JobId").Value = LocalAPI.GetProposalData(lblProposalId.Text, "JobId")
        '    End If
        'End If
    End Sub
    Protected Sub SqlDataSourceProp1_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceProp1.Updated
        IsProposalReadOnly()
    End Sub
    Protected Sub btnModifyJob_Click(sender As Object, e As EventArgs) Handles btnModifyJob.Click
        lblOriginalJobId.Text = cboJobs.SelectedValue
        GuardarProposal(True)
    End Sub
    Private Sub btnUpdateStatus_Click(sender As Object, e As EventArgs) Handles btnUpdateStatus.Click
        If cboStatus.SelectedValue <> lblOriginalStatus.Text Then
            Select Case cboStatus.SelectedValue

                Case 0, 1 ' Not Emitted and Pending
                    LocalAPI.SetProposalStatus(lblProposalId.Text, cboStatus.SelectedValue)
                    lblOriginalStatus.Text = cboStatus.SelectedValue

                Case 2  ' Acepted
                    If (lblOriginalStatus.Text = 0 Or lblOriginalStatus.Text = 1) Then
                        LocalAPI.ProposalStatus2Acept(lblProposalId.Text, lblCompanyId.Text)
                        lblOriginalStatus.Text = cboStatus.SelectedValue
                    End If

                Case 3, 31, 32  ' Declined
                    LocalAPI.ProposalStatus2Declined(lblProposalId.Text, lblCompanyId.Text, cboStatus.SelectedValue)
                    lblOriginalStatus.Text = cboStatus.SelectedValue

                Case 4  ' Hold
                    LocalAPI.ProposalStatus2Hold(lblProposalId.Text)
                    lblOriginalStatus.Text = cboStatus.SelectedValue

            End Select

            btnUpdateStatus.Enabled = (cboStatus.SelectedValue <> lblOriginalStatus.Text)
            FormView1.DataBind()
        End If

    End Sub
    Protected Sub btnModifyType_Click(sender As Object, e As EventArgs) Handles btnModifyType.Click
        lblOriginalType.Text = cboProposalType.SelectedValue
        LocalAPI.ModifyProposalType(lblProposalId.Text, cboProposalType.SelectedValue, lblCompanyId.Text)
        ' Redirect to Fees
        Response.Redirect(LocalAPI.GetSharedLink_URL(11002, lblProposalId.Text))
    End Sub

    Private Sub FormView1_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles FormView1.ItemCommand
        Select Case e.CommandName
            Case "ViewJob"
                Dim sUrl As String = LocalAPI.GetSharedLink_URL(8001, e.CommandArgument)
                Response.Redirect(sUrl)

        End Select
    End Sub

#End Region

End Class