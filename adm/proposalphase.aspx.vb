Public Class proposalphase
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                lblCompanyId.Text = Session("companyId")
                lblproposalId.Text = Request.QueryString("proposalId")
                lblProposal.Text = LocalAPI.ProposalNumber(lblproposalId.Text)
                lblphaseId.Text = Request.QueryString("Id")

                If Val(lblphaseId.Text) = 0 Then
                    ' Insert
                    btnNewUpdate.Text = "Add Phase"
                Else
                    'Update
                    btnNewUpdate.Text = "Update Phase"
                    ReadDetails()
                End If


            End If

        Catch ex As Exception

        End Try
    End Sub

    Private Sub ReadDetails()
        Dim phaseObject = LocalAPI.GetRecord(lblphaseId.Text, "PROPOSAL_phase_SELECT")

        txtOrder.Text = phaseObject("nOrder")
        CodeTextBox.Text = phaseObject("Code")
        NameTextBox.Text = phaseObject("Name")
        DescriptionEditor.Content = phaseObject("Description")
        PeriodoTextBox.Text = phaseObject("Period")
        RadDatePickerFrom.DbSelectedDate = phaseObject("DateFrom")
        RadDatePickerTo.DbSelectedDate = phaseObject("DateTo")
        txtProgress.DbValue = phaseObject("Progress")

    End Sub
    Protected Sub cboPhaseTemplate_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles cboPhaseTemplate.SelectedIndexChanged
        If cboPhaseTemplate.SelectedValue > 0 Then
            CodeTextBox.Text = LocalAPI.GetPhaseTemplateProperty(cboPhaseTemplate.SelectedValue, "Code")
            NameTextBox.Text = LocalAPI.GetPhaseTemplateProperty(cboPhaseTemplate.SelectedValue, "Name")
            DescriptionEditor.Content = LocalAPI.GetPhaseTemplateProperty(cboPhaseTemplate.SelectedValue, "Description")
        End If
    End Sub

    Protected Sub Back()
        Response.Redirect("~/adm/proposal.aspx?proposalId=" & lblproposalId.Text & "&TabPhase=1")
    End Sub
    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Back()
    End Sub

    Private Sub btnNewUpdate_Click(sender As Object, e As EventArgs) Handles btnNewUpdate.Click
        If btnNewUpdate.Text = "Add Phase" Then
            If LocalAPI.ProposalPhases_INSERT(lblproposalId.Text, txtOrder.DbValue, CodeTextBox.Text, NameTextBox.Text, DescriptionEditor.Content, PeriodoTextBox.Text, RadDatePickerFrom.DbSelectedDate, RadDatePickerTo.DbSelectedDate, txtProgress.DbValue) Then
                Back()
            End If
        Else
            If LocalAPI.ProposalPhases_UPDATE(lblphaseId.Text, txtOrder.DbValue, CodeTextBox.Text, NameTextBox.Text, DescriptionEditor.Content, PeriodoTextBox.Text, RadDatePickerFrom.DbSelectedDate, RadDatePickerTo.DbSelectedDate, txtProgress.DbValue) Then
                Back()
            End If
        End If
    End Sub

End Class