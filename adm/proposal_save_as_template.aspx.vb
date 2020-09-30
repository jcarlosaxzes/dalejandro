﻿Public Class proposal_save_as_template
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            lblCompanyId.Text = Session("companyId")
            lblProposalId.Text = Request.QueryString("ProposalId")
            lblProposalNumber.Text = LocalAPI.ProposalNumber(lblProposalId.Text)

            If Not Request.QueryString("backpage") Is Nothing Then
                Session("proposalsaveastemplatebackpage") = Request.QueryString("backpage")
            Else
                Session("proposalsaveastemplatebackpage") = ""
            End If

            TemplateName()
        End If

    End Sub

    Private Sub TemplateName()
        Dim sName As String = LocalAPI.GetProposalTypename(lblProposalId.Text)
        Dim i As Integer = 1
        Do While True
            If Not LocalAPI.IsProposalTypeName(sName & "(" & i & ")", lblCompanyId.Text) Then
                txtName.Text = sName & "(" & i & ")"
                Exit Do
            End If
            i = i + 1
        Loop
    End Sub

    Protected Sub btnOk_Click(sender As Object, e As EventArgs) Handles btnOk.Click
        SqlDataSource1.Insert()
    End Sub

    Protected Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        Back(lblProposalId.Text)
    End Sub
    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Back(lblProposalId.Text)
    End Sub

    Private Sub Back(proposalId As Integer)
        Select Case Session("proposalsaveastemplatebackpage")
            Case "proposal"
                Response.Redirect("~/adm/proposal.aspx?proposalId=" & proposalId)
            Case "proposalnewwizard"
                Response.Redirect("~/adm/proposalnewwizard.aspx?proposalId=" & proposalId)
            Case "proposals"
                Response.Redirect("~/adm/proposals.aspx?restoreFilter=true")
            Case Else
                Response.Redirect("~/adm/proposal.aspx?proposalId=" & proposalId)
        End Select
    End Sub
End Class