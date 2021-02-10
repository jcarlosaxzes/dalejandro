﻿Imports Microsoft.AspNet.Identity

Public Class proposal_save_copy
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            lblCompanyId.Text = Session("companyId")
            lblProposalId.Text = Request.QueryString("ProposalId")
            lblProposalNumber.Text = LocalAPI.ProposalNumber(lblProposalId.Text)

            If Not Request.QueryString("backpage") Is Nothing Then
                Session("proposalsavecopybackpage") = Request.QueryString("backpage")
            Else
                Session("proposalsavecopybackpage") = ""
            End If

            ProposalName()

            lblEmployeeId.Text = LocalAPI.GetEmployeeId(Context.User.Identity.GetUserName(), lblCompanyId.Text)

        End If

    End Sub
    Private Sub ProposalName()
        Dim sName As String = LocalAPI.GetProposalData(lblProposalId.Text, "ProjectName")
        Dim i As Integer = 1
        Do While True
            If Not LocalAPI.IsProposalOrJobName(sName & "(" & i & ")", lblCompanyId.Text) Then
                txtName.Text = sName & "(" & i & ")"
                Exit Do
            End If
            i = i + 1
        Loop
    End Sub

    Protected Sub btnOk_Click(sender As Object, e As EventArgs) Handles btnOk.Click
        SqlDataSource1.Insert()
    End Sub

    Private Sub SqlDataSource1_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource1.Inserting
        e.Command.Parameters("@copytaskdetails").Value = IIf(chkCopytaskdetails.Checked, 1, 0)
    End Sub
    Protected Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        Dim Id As String = e.Command.Parameters("@ProposalId").Value
        If Val(Id) > 0 Then
            Back(Id)
        End If
    End Sub

    Protected Sub opcCopiar_CheckedChanged(sender As Object, e As EventArgs) Handles opcCopiar.CheckedChanged
        lblOption.Text = "0"
    End Sub

    Protected Sub opcRevisar_CheckedChanged(sender As Object, e As EventArgs) Handles opcRevisar.CheckedChanged
        lblOption.Text = "1"
    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Back(lblProposalId.Text)
    End Sub

    Private Sub Back(proposalId As Integer)
        Select Case Session("proposalsavecopybackpage")
            Case "pro_proposal", "proposal"
                Response.Redirect(LocalAPI.GetSharedLink_URL(11001, proposalId))
            Case "proposalnewwizard"
                Response.Redirect("~/adm/proposalnewwizard.aspx?proposalId=" & proposalId)
            Case "proposals"
                Response.Redirect("~/adm/proposals.aspx?restoreFilter=true")
            Case Else
                Response.Redirect(LocalAPI.GetSharedLink_URL(11001, proposalId))
        End Select
    End Sub

End Class