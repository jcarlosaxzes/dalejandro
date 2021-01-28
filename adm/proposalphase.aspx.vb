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
                    btnUpdateAndBack.Visible = False
                Else
                    'Update
                    btnNewUpdate.Text = "Update Phase"
                    btnUpdateAndBack.Visible = True
                    ReadDetails()
                End If

                If Not Request.QueryString("backpage") Is Nothing Then
                    Session("pphasebackpage") = Request.QueryString("backpage")
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
        Select Case Session("pphasebackpage")
            Case "proposalnewwizard"
                Response.Redirect("~/adm/proposalnewwizard.aspx?proposalId=" & lblproposalId.Text & "&FeesTab=1")
            Case "pro_phases"
                Response.Redirect(LocalAPI.GetSharedLink_URL(11006, lblproposalId.Text))
            Case Else
                Response.Redirect("~/adm/proposal.aspx?proposalId=" & lblproposalId.Text & "&TabPhase=1")
        End Select

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
            LocalAPI.ProposalPhases_UPDATE(lblphaseId.Text, txtOrder.DbValue, CodeTextBox.Text, NameTextBox.Text, DescriptionEditor.Content, PeriodoTextBox.Text, RadDatePickerFrom.DbSelectedDate, RadDatePickerTo.DbSelectedDate, txtProgress.DbValue)
        End If
    End Sub

    Private Sub btnUpdateAndBack_Click(sender As Object, e As EventArgs) Handles btnUpdateAndBack.Click
        If LocalAPI.ProposalPhases_UPDATE(lblphaseId.Text, txtOrder.DbValue, CodeTextBox.Text, NameTextBox.Text, DescriptionEditor.Content, PeriodoTextBox.Text, RadDatePickerFrom.DbSelectedDate, RadDatePickerTo.DbSelectedDate, txtProgress.DbValue) Then
            Back()
        End If

    End Sub
End Class