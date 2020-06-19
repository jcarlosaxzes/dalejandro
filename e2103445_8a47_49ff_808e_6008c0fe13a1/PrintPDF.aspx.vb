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

    Public Sub loadJson()
        Try
            jsonObj = New JObject()
            Dim CompanyId As String = lblCompanyId.Text
            jsonObj.Add("CompanyId", CompanyId)
            jsonObj.Add("CompanyName", LocalAPI.GetCompanyProperty(CompanyId, "Name"))
            jsonObj.Add("CompanyAddress", LocalAPI.GetCompanyProperty(CompanyId, "Address"))
            jsonObj.Add("CompanyCity", LocalAPI.GetCompanyProperty(CompanyId, "City"))
            jsonObj.Add("CompanyState", LocalAPI.GetCompanyProperty(CompanyId, "State"))
            jsonObj.Add("CompanyZipCode", LocalAPI.GetCompanyProperty(CompanyId, "ZipCode"))
            jsonObj.Add("CompanyPhone", LocalAPI.GetCompanyProperty(CompanyId, "Phone"))
            jsonObj.Add("CompanyEmail", LocalAPI.GetCompanyProperty(CompanyId, "Email"))
            jsonObj.Add("CompanyWebLink", LocalAPI.GetCompanyProperty(CompanyId, "web"))
            Dim Base64StringCompanyLogo = LocalAPI.GetCompanyLogo(CompanyId)
            If (Base64StringCompanyLogo IsNot Nothing) Then
                jsonObj.Add("Base64StringCompanyLogo", Convert.ToBase64String(Base64StringCompanyLogo))
            Else
                jsonObj.Add("Base64StringCompanyLogo", "")
            End If
            Dim Base64StringCompanyLetterHead = LocalAPI.GetCompanyLetterHead(CompanyId)
            If (Base64StringCompanyLetterHead IsNot Nothing) Then
                jsonObj.Add("Base64StringCompanyLetterHead", Convert.ToBase64String(Base64StringCompanyLetterHead))
            Else
                jsonObj.Add("Base64StringCompanyLetterHead", "")
            End If

            Dim jsonProposal As JObject = New JObject()

            Dim reader = ExecProsedure("PROPOSAL_Page_v20_Select")
            While reader.Read()
                If reader.HasRows Then

                    jsonProposal.Add("ProposalNumber", reader("ProposalNumber").ToString())
                    Dim DateSrt = reader("Date").ToString()
                    If DateSrt IsNot Nothing And DateSrt.Length > 0 Then
                        Dim Date2 = DateTime.Parse(DateSrt)
                        jsonProposal.Add("Date", Date2.ToShortDateString())
                    Else
                        jsonProposal.Add("Date", "")
                    End If
                    jsonProposal.Add("ClientName", reader("ClientName").ToString())
                    jsonProposal.Add("ClientCompany", reader("ClientCompany").ToString())
                    jsonProposal.Add("ClientFullAddress", reader("ClientFullAddress").ToString())
                    jsonProposal.Add("Phone", reader("Phone").ToString())
                    jsonProposal.Add("Fax", reader("Fax").ToString())
                    jsonProposal.Add("Cellular", reader("Cellular").ToString())
                    jsonProposal.Add("Email", reader("Email").ToString())
                    jsonProposal.Add("nType", reader("nType").ToString())
                    jsonProposal.Add("ProjectName", reader("ProjectName").ToString())
                    jsonProposal.Add("ProjectLocation", reader("ProjectLocation").ToString())
                    jsonProposal.Add("ProjectArea", reader("ProjectArea").ToString())
                    jsonProposal.Add("TextBegin", reader("TextBegin").ToString())
                    jsonProposal.Add("TextEnd", reader("TextEnd").ToString())
                    jsonProposal.Add("Agreements", reader("Agreements").ToString())
                    jsonProposal.Add("Total", reader("Total").ToString())
                    jsonProposal.Add("AceptanceName", reader("AceptanceName").ToString())
                    Dim AceptanceSignature = reader("AceptanceSignature")
                    If (AceptanceSignature IsNot Nothing) Then
                        jsonObj.Add("AceptanceSignature", Convert.ToBase64String(AceptanceSignature))
                    Else
                        jsonObj.Add("AceptanceSignature", "")
                    End If
                    Dim AceptedDateSrt = reader("AceptedDate").ToString()
                    If AceptedDateSrt IsNot Nothing And AceptedDateSrt.Length > 0 Then
                        Dim AceptedDate = DateTime.Parse(AceptedDateSrt)
                        jsonProposal.Add("AceptedDate", AceptedDate.ToShortDateString())
                    Else
                        jsonProposal.Add("AceptedDate", "")
                    End If
                    jsonProposal.Add("StatusId", reader("StatusId").ToString())
                    Dim EmailDateSrt = reader("EmailDate").ToString()
                    If EmailDateSrt IsNot Nothing And EmailDateSrt.Length > 0 Then
                        Dim EmailDate = DateTime.Parse(EmailDateSrt)
                        jsonProposal.Add("EmailDate", EmailDate.ToShortDateString())
                    Else
                        jsonProposal.Add("EmailDate", "")
                    End If
                    jsonProposal.Add("CompanyName", reader("CompanyName").ToString())
                    jsonProposal.Add("LetterHead", reader("LetterHead").ToString())
                    Dim CompanySing = reader("CompanySing")
                    If (CompanySing IsNot Nothing) Then
                        jsonObj.Add("CompanySing", Convert.ToBase64String(CompanySing))
                    Else
                        jsonObj.Add("CompanySing", "")
                    End If
                    jsonProposal.Add("CompanyContact", reader("CompanyContact").ToString())
                    jsonProposal.Add("IsPhases", reader("IsPhases").ToString())
                    jsonProposal.Add("ProposalUse", reader("ProposalUse").ToString())
                    jsonProposal.Add("ProjectSector", reader("ProjectSector").ToString())
                    jsonProposal.Add("Owner", reader("Owner").ToString())
                    jsonProposal.Add("IsSharePublicLinks", reader("IsSharePublicLinks").ToString())
                    jsonProposal.Add("Proposalby", reader("Proposalby").ToString())
                    jsonProposal.Add("IsPaymentSchedule", reader("IsPaymentSchedule").ToString())
                End If
            End While

            jsonObj.Add("Proposal", jsonProposal)
            'Services Feeds
            Dim jsonTaskArray As JArray = New JArray()
            reader = ExecProsedure("PROPOSAL_Details_Page_Select")
            Dim TaskTotal As Decimal = 0
            While reader.Read()
                If reader.HasRows Then
                    Dim jsonTask As JObject = New JObject()
                    jsonTask.Add("Description", reader("Description").ToString())
                    jsonTask.Add("Amount", reader("Amount").ToString())
                    jsonTask.Add("Hours", reader("Hours").ToString())
                    jsonTask.Add("Rates", "$" & reader("Rates").ToString())
                    jsonTask.Add("TotalRow", "$" & reader("TotalRow").ToString())
                    TaskTotal += CType(reader("TotalRow").ToString(), Decimal)
                    jsonTaskArray.Add(jsonTask)
                End If
            End While

            jsonObj.Add("Feeds", jsonTaskArray)
            jsonObj.Add("FeedsTotal", "$" & TaskTotal)

            'Payment Schedules
            Dim jsonPaymentArray As JArray = New JArray()
            reader = ExecProsedure("Proposal_PaymentSchedule_SELECT")
            Dim PaymentTotal As Decimal = 0
            While reader.Read()
                If reader.HasRows Then
                    Dim jsonTask As JObject = New JObject()
                    jsonTask.Add("Percentage", reader("Percentage").ToString())
                    jsonTask.Add("Description", reader("Description").ToString())
                    jsonTask.Add("Amount", "$" & reader("Amount").ToString())
                    PaymentTotal += CType(reader("Amount").ToString(), Decimal)
                    jsonPaymentArray.Add(jsonTask)
                End If
            End While

            jsonObj.Add("Payments", jsonPaymentArray)
            jsonObj.Add("PaymentsTotal", "$" & PaymentTotal)

            reader = ExecProsedure("PROPOSAL_Details_Page_Select")
            Dim jsonScopeWorkArray As JArray = New JArray()
            While reader.Read()
                If reader.HasRows Then
                    Dim jsonScopeWork As JObject = New JObject()
                    jsonScopeWork.Add("Description", reader("Description").ToString())
                    jsonScopeWork.Add("DescriptionPlus", reader("DescriptionPlus").ToString())
                    jsonScopeWorkArray.Add(jsonScopeWork)
                End If
            End While

            jsonObj.Add("WorkScope", jsonScopeWorkArray)

        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try
    End Sub


    Protected Async Sub createPdf_Click(sender As Object, e As EventArgs)
        Try

            Dim pdf As PdfApi = New PdfApi()
            'Dim base64 As String = Await pdf.GetBase64Document("117735", json)

            'Dim bytePDF As Byte() = Convert.FromBase64String(base64)


            'Dim companyid = 261173
            'Dim newName = "Companies/" & companyid & $"/{Guid.NewGuid().ToString()}.pdf"
            'Dim Url = AzureStorageApi.UploadBytesData(newName, bytePDF, "application/pdf")

            lblProposalId.Text = LocalAPI.GetSharedLink_Id(11, txtGuID.Text)
            Dim CompanyId As String = LocalAPI.GetCompanyIdFromProposal(lblProposalId.Text)
            lblCompanyId.Text = CompanyId


            'Dim newName = "Companies/" & CompanyId & $"/{Guid.NewGuid().ToString()}.pdf"
            'Task.Run(Function() pdf.CreateProposalSignedPdfAsync(lblProposalId.Text, newName))
            'Response.Redirect("https://pasconceptstorage.blob.core.windows.net/documents/" & newName, False)

            Dim pdfBytes = Await pdf.CreateProposalPdfBytes(lblProposalId.Text)
            Dim response As HttpResponse = HttpContext.Current.Response
            response.ContentType = "application/pdf"
            response.AddHeader("Content-Disposition", "attachment; filename=file.pdf")
            response.ClearContent()
            response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length)
            response.Flush()

        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try


    End Sub
End Class