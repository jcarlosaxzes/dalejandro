Imports System.Data.SqlClient
Imports System.Net.Http
Imports System.Threading.Tasks
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq

Public Class PdfApi
    Public Property BaseUrl As String = "https://us1.pdfgeneratorapi.com/api/v3/"
    Public Property Key As String = "bdb8ab512d5daeb626aab7ce5a325b81ccf3f836b6ccfcb198bde8599a315c61"
    Public Property Secret As String = "764342337400f71b36d3e555779eb8f4f161626a76f1b16e73100cb844b116ca"
    Public Property Workspace As String = "info@axzes.com"

    Public Async Function GetBase64Document(ByVal documentId As String, ByVal body As String) As Task(Of String)
        Try
            Dim httpClient = New HttpClient()
            httpClient.BaseAddress = New Uri(BaseUrl)
            Dim httpRequestMessage As HttpRequestMessage = New HttpRequestMessage(HttpMethod.Post, $"templates/{documentId}/output")
            httpRequestMessage.Content = New StringContent(body, Encoding.UTF8, "application/json")
            httpRequestMessage.Headers.Add("Accept", "application/json")
            httpRequestMessage.Headers.Add("X-Auth-Key", Key)
            httpRequestMessage.Headers.Add("X-Auth-Secret", Secret)
            httpRequestMessage.Headers.Add("X-Auth-Workspace", Workspace)
            Dim response = Await httpClient.SendAsync(httpRequestMessage)
            Dim jsonResult = Await response.Content.ReadAsStringAsync()
            Dim jsonObj As JObject = JObject.Parse(jsonResult)
            Dim base64pdf = jsonObj("response").ToString()
            Return base64pdf
        Catch ex As Exception
            Throw
        End Try
    End Function


    ' Unmerged change from project '1_App_Code' 
    ' Before:
    '     Public Sub CreateProposalSignedPdf(guid As String, fileName As String)
    ' After:
    '     Public Sub CreateProposalSignedPdfAsync(guid As String, fileName As String)
    Public Async Function CreateProposalSignedPdfAsync(ProposalId As String, Keyname As String) As Task
        'Dim ProposalId As String = LocalAPI.GetSharedLink_Id(11, Guid)
        Dim CompanyId As String = LocalAPI.GetCompanyIdFromProposal(ProposalId)
        Dim bytePDF As Byte() = Await CreateProposalPdfBytes(ProposalId)
        Dim Url = AzureStorageApi.UploadBytesData("Proposal_Signed_" & DateTime.Now.Month & "_" & DateTime.Now.Day & "_" & DateTime.Now.Year & ".pdf", Keyname, bytePDF, "application/pdf", CompanyId, ProposalId, "Proposal")
    End Function

    Public Async Function CreateProposalPdfBytes(ProposalId As String) As Task(Of Byte())
        'Dim ProposalId As String = LocalAPI.GetSharedLink_Id(11, Guid)
        Dim CompanyId As String = LocalAPI.GetCompanyIdFromProposal(ProposalId)

        Dim jsonObj = loadJson(CompanyId, ProposalId)
        Dim json As String = jsonObj.ToString()
        Dim base64 As String = Await GetBase64Document("117735", json)
        Dim bytePDF As Byte() = Convert.FromBase64String(base64)
        Return bytePDF
    End Function

    Public Function loadJson(CompanyId As String, ProposalId As String) As JObject
        Dim jsonObj As JObject = New JObject()
        Try
            'Company Data
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
        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try

        'Proposal Data
        Try
            Dim jsonProposal As JObject = New JObject()
            Dim reader = ExecProsedure("PROPOSAL_Page_v20_Select", ProposalId)
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
                        If AceptanceSignature.GetType() IsNot GetType(DBNull) Then
                            jsonProposal.Add("AceptanceSignature", Convert.ToBase64String(AceptanceSignature))
                        End If
                    Else
                        jsonProposal.Add("AceptanceSignature", "")
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
                        If CompanySing.GetType() IsNot GetType(DBNull) Then
                            jsonProposal.Add("CompanySing", Convert.ToBase64String(CompanySing))
                        End If
                    Else
                            jsonProposal.Add("CompanySing", "")
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
        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try

        'Services Feeds
        Try
            Dim jsonTaskArray As JArray = New JArray()
            Dim reader = ExecProsedure("PROPOSAL_Details_Page_Select", ProposalId)
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
        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try

        'Payment Schedules
        Try
            Dim jsonPaymentArray As JArray = New JArray()
            Dim reader = ExecProsedure("Proposal_PaymentSchedule_SELECT", ProposalId)
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
        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try

        'Scope Work
        Try
            Dim reader = ExecProsedure("PROPOSAL_Details_Page_Select", ProposalId)
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

        'Phases
        Try
            Dim jsonPhaseArray As JArray = New JArray()
            Dim reader = ExecProsedure("PROPOSAL_phases_SELECT", ProposalId)
            While reader.Read()
                If reader.HasRows Then
                    Dim jsonPhases As JObject = New JObject()
                    jsonPhases.Add("Code", reader("Code").ToString())
                    jsonPhases.Add("Name", reader("Name").ToString())
                    jsonPhases.Add("Description", reader("Description").ToString())
                    jsonPhases.Add("Period", reader("Period").ToString())
                    jsonPhaseArray.Add(jsonPhases)
                End If
            End While

            jsonObj.Add("Phases", jsonPhaseArray)
            jsonObj.Add("PhasesCount", jsonPhaseArray.Count)

        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try


        Return jsonObj

    End Function


    Public Function ExecProsedure(ProcedureName As String, ProposalId As String) As SqlDataReader
        Dim cnn1 As SqlConnection = LocalAPI.GetConnection()
        Dim cmd As SqlCommand = cnn1.CreateCommand()
        cmd.CommandText = ProcedureName
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ProposalId", ProposalId)
        Dim reader = cmd.ExecuteReader()
        Return reader
    End Function

End Class

