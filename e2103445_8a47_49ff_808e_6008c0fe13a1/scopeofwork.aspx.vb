Public Class scopeofwork1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim CustomerID As Integer = 0
            If Not Request.QueryString("guid") Is Nothing Then
                lblJobId.Text = LocalAPI.GetJobIdFromGUID(Request.QueryString("guid"))

                lblProposalId.Text = LocalAPI.GetJobProperty(lblJobId.Text, "proposalId")
                CustomerID = LocalAPI.GetJobProperty(lblJobId.Text, "Client")
            End If
            '!!! lblProposalId.Text = 21164

            Dim sb = New StringBuilder()
            sb.AppendLine("Project: <b>" & LocalAPI.GetJobCodeName(lblJobId.Text) & "</b>")
            sb.AppendLine("<br/>")
            sb.AppendLine("<br/>")
            sb.AppendLine("Client Name: <b>" & LocalAPI.GetClientProperty(CustomerID, "Name") & "</b>")
            sb.AppendLine("<br/>")
            sb.AppendLine("Company: <b>" & LocalAPI.GetClientProperty(CustomerID, "Company") & "</b>")
            sb.AppendLine("<br/>")
            sb.AppendLine("Proposal Number: <b>" & LocalAPI.ProposalNumber(lblProposalId.Text) & "</b>")
            sb.AppendLine("<br/>")
            sb.AppendLine("Proposal By: <b>" & LocalAPI.GetJobProposalBy(lblJobId.Text) & "</b>")
            sb.AppendLine("<br/>")
            sb.AppendLine("<br/>")
            LocalAPI.GetScopeOfWork(lblProposalId.Text, sb)
            lblContent.Text = sb.ToString
            txtHTML.Content = sb.ToString

        End If
    End Sub


End Class