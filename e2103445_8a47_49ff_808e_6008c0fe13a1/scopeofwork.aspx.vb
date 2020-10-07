﻿Public Class scopeofwork1
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

            If Not Request.QueryString("Print") Is Nothing Then
                'Response.Write("<script>window.print();</script>")
                Pdf_ServerClick()

                'Response.Redirect($"~/adm/titleblock?guid={Request.QueryString("guid")}")
            End If


        End If
    End Sub

    Protected Async Sub Pdf_ServerClick()
        Dim FileName As String = LocalAPI.GetJobCode(lblJobId.Text) & "_ScopeOfWork.pdf"
        Dim companyId = LocalAPI.GetJobProperty(lblJobId.Text, "companyId")
        Dim pdf As PdfApi = New PdfApi()
        ' Link to free page (no password)
        Dim url As String = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/scopeofwork.aspx" & "?guid=" & Request.QueryString("guid")
        Dim pdfBytes = Await pdf.GetConvertApiPdf(url)
        Dim response As HttpResponse = HttpContext.Current.Response
        response.ContentType = "application/pdf"
        response.AddHeader("Content-Disposition", "attachment; filename=" & FileName)
        response.ClearContent()
        response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length)
        response.Flush()
    End Sub

End Class