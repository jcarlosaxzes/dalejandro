Imports Telerik.Windows.Documents.Flow.Model

Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Imports System.Data.SqlClient
Imports System.Threading.Tasks

Public Class PrintPDF
    Inherits System.Web.UI.Page
    Dim jsonObj As JObject

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            jsonObj = New JObject()
            lblProposalId.Text = LocalAPI.GetSharedLink_Id(11, txtGuID.Text)
            Dim CompanyId As String = LocalAPI.GetCompanyIdFromProposal(lblProposalId.Text)
            lblCompanyId.Text = CompanyId
        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try


    End Sub

    Public Function ExecProsedure(ProcedureName As String) As SqlDataReader
        Dim cnn1 As SqlConnection = LocalAPI.GetConnection()
        Dim cmd As SqlCommand = cnn1.CreateCommand()
        cmd.CommandText = ProcedureName
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ProposalId", lblProposalId.Text)
        Dim reader = cmd.ExecuteReader()
        Return reader
    End Function




    Protected Async Sub createPdf_Click(sender As Object, e As EventArgs)
        Try

            Dim pdf As PdfApi = New PdfApi()
            'Dim base64 As String = Await pdf.GetBase64Document("117735", json)

            'Dim bytePDF As Byte() = Convert.FromBase64String(base64)


            'Dim companyid = 261173
            'Dim newName = "Companies/" & companyid & $"/{Guid.NewGuid().ToString()}.pdf"
            'Dim Url = AzureStorageApi.UploadBytesData(newName, bytePDF, "application/pdf")

            'lblProposalId.Text = LocalAPI.GetSharedLink_Id(11, txtGuID.Text)
            'Dim CompanyId As String = LocalAPI.GetCompanyIdFromProposal(lblProposalId.Text)
            'lblCompanyId.Text = CompanyId


            'Dim newName = "Companies/" & CompanyId & $"/{Guid.NewGuid().ToString()}.pdf"
            'Task.Run(Function() pdf.CreateProposalSignedPdfAsync(lblProposalId.Text, newName))
            'Response.Redirect("https://pasconceptstorage.blob.core.windows.net/documents/" & newName, False)

            'Dim pdfBytes = Await pdf.CreateProposalPdfBytes(lblProposalId.Text)
            'Dim response As HttpResponse = HttpContext.Current.Response
            'response.ContentType = "application/pdf"
            'response.AddHeader("Content-Disposition", "attachment; filename=file.pdf")
            'response.ClearContent()
            'response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length)
            'response.Flush()

            '-------------------------------------------------------------------
            'Invocies

            'Dim InvoiceId = LocalAPI.GetSharedLink_Id(4, txtGuID.Text)
            'Dim companyId = LocalAPI.GetCompanyIdFromInvoice(InvoiceId)
            'Dim pdfBytes = Await pdf.CreateInvoicePdfBytes(companyId, InvoiceId)
            'Dim response As HttpResponse = HttpContext.Current.Response
            'response.ContentType = "application/pdf"
            'response.AddHeader("Content-Disposition", "attachment; filename=Invoice.pdf")
            'response.ClearContent()
            'response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length)
            'response.Flush()

            '---------------------------------------------------------------------------
            'Statements
            'Dim statementId = LocalAPI.GetSharedLink_Id(5, txtGuID.Text)
            'Dim companyId = LocalAPI.GetCompanyIdFromStatement(statementId)
            'Dim pdfBytes = Await pdf.CreateStatementsPdfBytes(companyId, statementId)
            'Dim response As HttpResponse = HttpContext.Current.Response
            'response.ContentType = "application/pdf"
            'response.AddHeader("Content-Disposition", "attachment; filename=statement.pdf")
            'response.ClearContent()
            'response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length)
            'response.Flush()


            '---------------------------------------------------------------------------
            'Scope Of Work
            Dim JobId = LocalAPI.GetJobIdFromGUID(txtGuID.Text)
            Dim companyId = LocalAPI.GetJobProperty(JobId, "companyId")
            'Dim json = pdf.loadJobScopeJson(companyId, JobId)
            'Dim js = json.ToString()

            Dim pdfBytes = Await pdf.CreateWorkScopePdfBytes(companyId, JobId)
            Dim response As HttpResponse = HttpContext.Current.Response
            response.ContentType = "application/pdf"
            response.AddHeader("Content-Disposition", "attachment; filename=WorkScope.pdf")
            response.ClearContent()
            response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length)
            response.Flush()


        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try


    End Sub
End Class