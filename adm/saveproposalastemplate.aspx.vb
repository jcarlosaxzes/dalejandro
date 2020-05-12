Public Class saveproposalastemplate
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            lblCompanyId.Text = Session("companyId")
            lblProposalId.Text = Request.QueryString("ProposalId")
            lblProposalNumber.Text = LocalAPI.ProposalNumber(lblProposalId.Text)
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
        'Response.Write("<script language='javascript' type='text/javascript'>parent.location.href='../adm/proposal.aspx?Id=" & lblProposalId.Text & "';</script>")
        Response.Redirect("~/adm/proposal.aspx?Id=" & lblProposalId.Text)
    End Sub
    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Response.Redirect("~/adm/proposal.aspx?Id=" & lblProposalId.Text)
    End Sub

End Class
