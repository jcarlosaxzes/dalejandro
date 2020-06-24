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
            sb.AppendLine("Proposal Number: <b>" & LocalAPI.ProposalNumber(lblProposalId.Text) & "</b>")
            sb.AppendLine("<br/>")
            sb.AppendLine("Proposal By: <b>" & LocalAPI.GetJobProposalBy(lblJobId.Text) & "</b>")
            sb.AppendLine("<br/>")
            sb.AppendLine("Client Name: <b>" & LocalAPI.GetClientProperty(CustomerID, "Name") & "</b>")
            sb.AppendLine("<br/>")
            sb.AppendLine("Company: <b>" & LocalAPI.GetClientProperty(CustomerID, "Company") & "</b>")
            sb.AppendLine("<br/>")
            sb.AppendLine("<br/>")
            LocalAPI.GetScopeOfWork(lblProposalId.Text, sb)
            lblContent.Text = sb.ToString
            txtHTML.Content = sb.ToString
        End If
    End Sub

    Private Async Sub btnDownload_Click(sender As Object, e As EventArgs) Handles btnDownload.Click
        Dim companyId = LocalAPI.GetJobProperty(lblJobId.Text, "companyId")
        Dim pdf As PdfApi = New PdfApi()
        Dim pdfBytes = Await pdf.CreateWorkScopePdfBytes(companyId, lblJobId.Text)
        Dim response As HttpResponse = HttpContext.Current.Response
        response.ContentType = "application/pdf"
        response.AddHeader("Content-Disposition", "attachment; filename=WorkScope.pdf")
        response.ClearContent()
        response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length)
        response.Flush()

    End Sub

    Private Sub Previous()
        Try

            'Dim attachment As String = "attachment; filename=" & LocalAPI.GetJobCode(lblJobId.Text) & "_ScopeOfWork.docx"
            Dim attachment As String = "attachment; filename=" & "19-001" & "__ScopeOfWork.txt"
            HttpContext.Current.Response.Clear()
            HttpContext.Current.Response.ClearHeaders()
            HttpContext.Current.Response.ClearContent()
            HttpContext.Current.Response.AddHeader("Content-Disposition", attachment)
            HttpContext.Current.Response.ContentType = "text/csv"
            HttpContext.Current.Response.AddHeader("axzes", "public")
            Dim sb = New StringBuilder()

            sb.AppendLine(txtHTML.Text.Replace("<br/>", "\r\n"))

            HttpContext.Current.Response.Write(sb.ToString())
            HttpContext.Current.Response.End()

        Catch ex As Exception
        End Try
    End Sub
End Class
