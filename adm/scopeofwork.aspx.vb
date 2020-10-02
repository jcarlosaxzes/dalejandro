Imports Intuit.Ipp.Core.Configuration

Public Class scopeofwork
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
            End If
        End If
    End Sub


    'Private Sub Previous()
    '    Try
    '        'Dim attachment As String = "attachment; filename=" & LocalAPI.GetJobCode(lblJobId.Text) & "_ScopeOfWork.docx"
    '        Dim attachment As String = "attachment; filename=" & "19-001" & "__ScopeOfWork.txt"
    '        HttpContext.Current.Response.Clear()
    '        HttpContext.Current.Response.ClearHeaders()
    '        HttpContext.Current.Response.ClearContent()
    '        HttpContext.Current.Response.AddHeader("Content-Disposition", attachment)
    '        HttpContext.Current.Response.ContentType = "text/csv"
    '        HttpContext.Current.Response.AddHeader("axzes", "public")
    '        Dim sb = New StringBuilder()

    '        sb.AppendLine(txtHTML.Text.Replace("<br/>", "\r\n"))

    '        HttpContext.Current.Response.Write(sb.ToString())
    '        HttpContext.Current.Response.End()

    '    Catch ex As Exception
    '    End Try
    'End Sub

    Protected Async Sub Pdf_ServerClick()
        Dim FileName As String = LocalAPI.GetJobCode(lblJobId.Text) & "_ScopeOfWork.pdf"
        Dim companyId = LocalAPI.GetJobProperty(lblJobId.Text, "companyId")
        Dim pdf As PdfApi = New PdfApi()
        Dim url As String = LocalAPI.GetHostAppSite() & "/adm/scopeofwork.aspx" & "?guid=" & Request.QueryString("guid")
        Dim pdfBytes = Await pdf.GetConvertApiPdf(url)
        Dim response As HttpResponse = HttpContext.Current.Response
        response.ContentType = "application/pdf"
        response.AddHeader("Content-Disposition", "attachment; filename=" & FileName)
        response.ClearContent()
        response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length)
        response.Flush()
    End Sub
End Class
