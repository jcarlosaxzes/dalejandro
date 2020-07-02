Imports System.Data.SqlClient
Imports System.Net.Http
Imports System.Threading.Tasks
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq

Public Class PdfApi
    Public Property BaseUrl As String = "https://us1.pdfgeneratorapi.com/api/v3/"

    Public Property ConvertApi_BaseUrl As String = "https://v2.convertapi.com/convert/web/to/pdf"

    Public Property ConvertApi_Secret As String = "inTjL4nf0ZeuvVzH"
    Public Property Key As String = "bdb8ab512d5daeb626aab7ce5a325b81ccf3f836b6ccfcb198bde8599a315c61"
    Public Property Secret As String = "764342337400f71b36d3e555779eb8f4f161626a76f1b16e73100cb844b116ca"
    Public Property Workspace As String = "info@axzes.com"

    Public Async Function GetConvertApiPdf(ByVal Url As String) As Task(Of Byte())
        Try
            Dim httpClient = New HttpClient()
            httpClient.BaseAddress = New Uri(ConvertApi_BaseUrl)
            Dim encodeUrl As String = HttpUtility.UrlEncode(Url & "&printing=true")
            Dim httpRequestMessage As HttpRequestMessage = New HttpRequestMessage(HttpMethod.Get, $"?secret={ConvertApi_Secret}&download=inline&url={encodeUrl}")
            Dim response = Await httpClient.SendAsync(httpRequestMessage)
            Dim ByteArray = Await response.Content.ReadAsByteArrayAsync()
            Return ByteArray
        Catch ex As Exception
            Throw
        End Try
    End Function

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


    Public Async Function CreateProposalSignedPdfAsync(ProposalId As String, Keyname As String) As Task
        'Dim ProposalId As String = LocalAPI.GetSharedLink_Id(11, Guid)
        Dim CompanyId As String = LocalAPI.GetCompanyIdFromProposal(ProposalId)
        Dim ProposalUrl = LocalAPI.GetSharedLink_URL(11, ProposalId)
        Dim bytePDF As Byte() = Await GetConvertApiPdf(ProposalUrl)
        Dim Url = AzureStorageApi.UploadBytesData("Proposal_Signed_" & DateTime.Now.Month & "_" & DateTime.Now.Day & "_" & DateTime.Now.Year & ".pdf", Keyname, bytePDF, "application/pdf", CompanyId, ProposalId, "Proposal")
    End Function

    Public Async Function CreateProposalPdfBytes(ProposalId As String) As Task(Of Byte())
        Dim ProposalUrl = LocalAPI.GetSharedLink_URL(11, ProposalId)
        Dim bytePDF As Byte() = Await GetConvertApiPdf(ProposalUrl)
        Return bytePDF
    End Function

    Public Async Function CreateInvoicePdfBytes(companyId As String, InvoiceId As String) As Task(Of Byte())
        Dim jsonObj = loadInvoiceJson(companyId, InvoiceId)
        Dim json As String = jsonObj.ToString()
        Dim base64 As String = Await GetBase64Document("120636", json)
        Dim bytePDF As Byte() = Convert.FromBase64String(base64)
        Return bytePDF
    End Function


    Public Async Function CreateStatementsPdfBytes(companyId As String, StatementId As String) As Task(Of Byte())
        Dim jsonObj = loadStatementsJson(companyId, StatementId)
        Dim json As String = jsonObj.ToString()
        Dim base64 As String = Await GetBase64Document("120662", json)
        Dim bytePDF As Byte() = Convert.FromBase64String(base64)
        Return bytePDF
    End Function

    Public Async Function CreateWorkScopePdfBytes(companyId As String, JobId As String) As Task(Of Byte())
        Dim jsonObj = loadJobScopeJson(companyId, JobId)
        Dim json As String = jsonObj.ToString()
        Dim base64 As String = Await GetBase64Document("121504", json)
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
            Dim reader = ExecProsedure("PROPOSAL_Page_v20_Select", "@ProposalId", ProposalId)
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
            Dim reader = ExecProsedure("PROPOSAL_Details_ClientPage_Select", "@ProposalId", ProposalId)
            Dim TaskTotal As Decimal = 0
            While reader.Read()
                If reader.HasRows Then
                    Dim jsonTask As JObject = New JObject()
                    jsonTask.Add("Description", reader("Description").ToString())
                    jsonTask.Add("Amount", reader("Amount").ToString())
                    jsonTask.Add("Hours", reader("Hours").ToString())
                    Dim Rates = reader("Rates").ToString()
                    If Rates = "" Or Rates = "0" Then
                        jsonTask.Add("Rates", "")
                    Else
                        jsonTask.Add("Rates", FormatCurrency(Rates, 2))
                    End If
                    Dim LumpSum = reader("LumpSum").ToString()
                    Dim TotalRow = reader("TotalRow").ToString()
                    If (LumpSum = "1" Or TotalRow = "0") Then
                        jsonTask.Add("TotalRow", "")
                    Else
                        jsonTask.Add("TotalRow", FormatCurrency(TotalRow, 2))
                    End If
                    jsonTask.Add("LumpSum", LumpSum)
                    TaskTotal += CType(reader("TotalRow").ToString(), Decimal)
                    jsonTaskArray.Add(jsonTask)
                End If
            End While
            jsonObj.Add("Feeds", jsonTaskArray)
            jsonObj.Add("FeedsTotal", FormatCurrency(TaskTotal, 2))
        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try

        'Payment Schedules
        Try
            Dim jsonPaymentArray As JArray = New JArray()
            Dim reader = ExecProsedure("Proposal_PaymentSchedule_SELECT", "@ProposalId", ProposalId)
            Dim PaymentTotal As Decimal = 0
            While reader.Read()
                If reader.HasRows Then
                    Dim jsonTask As JObject = New JObject()
                    jsonTask.Add("Percentage", reader("Percentage").ToString() & "%")
                    jsonTask.Add("Description", reader("Description").ToString())
                    Dim Amount = reader("Amount").ToString()
                    If Amount = "" Or Amount = "0" Then
                        jsonTask.Add("Amount", "")
                    Else
                        jsonTask.Add("Amount", FormatCurrency(Amount, 2))
                    End If
                    PaymentTotal += CType(reader("Amount").ToString(), Decimal)
                    jsonPaymentArray.Add(jsonTask)
                End If
            End While

            jsonObj.Add("Payments", jsonPaymentArray)
            jsonObj.Add("PaymentsTotal", FormatCurrency(PaymentTotal, 2))
        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try

        'Scope Work
        Try
            Dim reader = ExecProsedure("PROPOSAL_Details_ClientPage_Select", "@ProposalId", ProposalId)
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
            Dim reader = ExecProsedure("PROPOSAL_phases_SELECT", "@ProposalId", ProposalId)
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


    Public Function loadInvoiceJson(CompanyId As String, InvoidceId As String) As JObject
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

        'Invoice
        Try
            Dim jsonInvoices As JObject = New JObject()
            Dim reader = ExecProsedure("INVOICE3_Adapter", "@InvoiceId", InvoidceId)
            While reader.Read()
                If reader.HasRows Then

                    jsonInvoices.Add("InvoiceId", reader("Id").ToString())
                    jsonInvoices.Add("InvoiceNumber", reader("InvoiceNumber").ToString())
                    Dim InvoicePaid = reader("InvoicePaid").ToString()
                    If InvoicePaid IsNot Nothing And InvoicePaid.Length > 0 Then
                        Dim paid = Decimal.Parse(InvoicePaid)
                        jsonInvoices.Add("InvoicePaid", FormatCurrency(paid, 2))
                    Else
                        jsonInvoices.Add("InvoicePaid", "0.00")
                    End If

                    Dim AmountDue = reader("AmountDue").ToString()
                    If AmountDue IsNot Nothing And AmountDue.Length > 0 Then
                        Dim paid = Decimal.Parse(AmountDue)
                        jsonInvoices.Add("AmountDue", FormatCurrency(paid, 2))
                    Else
                        jsonInvoices.Add("AmountDue", "0.00")
                    End If

                    jsonInvoices.Add("Billing", reader("Billing").ToString())
                    jsonInvoices.Add("Notes", reader("Notes").ToString())
                    jsonInvoices.Add("ProjectName", reader("ProjectName").ToString())
                    jsonInvoices.Add("ClientName", reader("ClientName").ToString())
                    jsonInvoices.Add("ClientCompany", reader("ClientCompany").ToString())
                    jsonInvoices.Add("ClientFullAddress", reader("ClientFullAddress").ToString())
                    jsonInvoices.Add("Phone", reader("Phone").ToString())
                    jsonInvoices.Add("Cellular", reader("Cellular").ToString())
                    jsonInvoices.Add("Fax", reader("Fax").ToString())
                    jsonInvoices.Add("Email", reader("Email").ToString())
                    Dim Budget = reader("Budget").ToString()
                    If Budget IsNot Nothing And Budget.Length > 0 Then
                        Dim paid = Decimal.Parse(Budget)
                        jsonInvoices.Add("Budget", FormatCurrency(paid, 2))
                    Else
                        jsonInvoices.Add("Budget", "0.00")
                    End If
                    jsonInvoices.Add("TotalPaid", reader("TotalPaid").ToString())
                    jsonInvoices.Add("Balance", reader("Balance").ToString())
                    jsonInvoices.Add("BillingContact", reader("BillingContact").ToString())
                    Dim LatestEmission = reader("LatestEmission").ToString()
                    If LatestEmission IsNot Nothing And LatestEmission.Length > 0 Then
                        Dim Date2 = DateTime.Parse(LatestEmission)
                        jsonInvoices.Add("LatestEmission", Date2.ToShortDateString())
                    Else
                        jsonInvoices.Add("LatestEmission", "")
                    End If
                    Dim MaturityDate = reader("MaturityDate").ToString()
                    If MaturityDate IsNot Nothing And MaturityDate.Length > 0 Then
                        Dim Date2 = DateTime.Parse(MaturityDate)
                        jsonInvoices.Add("MaturityDate", Date2.ToShortDateString())
                    Else
                        jsonInvoices.Add("MaturityDate", "")
                    End If

                    jsonInvoices.Add("ProjectLocation", reader("ProjectLocation").ToString())
                    jsonInvoices.Add("InvoiceType", reader("InvoiceType").ToString())
                    jsonInvoices.Add("Time", reader("Time").ToString())
                    jsonInvoices.Add("Rate", reader("Rate").ToString())
                    Dim FirstEmission = reader("FirstEmission").ToString()
                    If FirstEmission IsNot Nothing And FirstEmission.Length > 0 Then
                        Dim Date2 = DateTime.Parse(FirstEmission)
                        jsonInvoices.Add("FirstEmission", Date2.ToShortDateString())
                    Else
                        jsonInvoices.Add("FirstEmission", "")
                    End If
                End If
            End While
            jsonObj.Add("Invoices", jsonInvoices)
        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try


        Return jsonObj

    End Function


    Public Function loadStatementsJson(CompanyId As String, StatementId As String) As JObject
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

        'Invoice
        Try
            Dim jsonStatements As JObject = New JObject()
            Dim reader = ExecProsedure("STATEMENT2_Adapter", "@statementId", StatementId)
            While reader.Read()
                If reader.HasRows Then

                    jsonStatements.Add("Id", reader("Id").ToString())
                    jsonStatements.Add("StatementNumber", reader("StatementNumber").ToString())
                    Dim InvoiceDate = reader("InvoiceDate").ToString()
                    If InvoiceDate IsNot Nothing And InvoiceDate.Length > 0 Then
                        Dim Date2 = DateTime.Parse(InvoiceDate)
                        jsonStatements.Add("InvoiceDate", Date2.ToShortDateString())
                    Else
                        jsonStatements.Add("InvoiceDate", "")
                    End If
                    jsonStatements.Add("clientId", reader("clientId").ToString())
                    jsonStatements.Add("ClientName", reader("ClientName").ToString())
                    jsonStatements.Add("ClientCompany", reader("ClientCompany").ToString())
                    jsonStatements.Add("ClientFullAddress", reader("ClientFullAddress").ToString())
                    jsonStatements.Add("Phone", reader("Phone").ToString())
                    jsonStatements.Add("Cellular", reader("Cellular").ToString())
                    jsonStatements.Add("Fax", reader("Fax").ToString())
                    jsonStatements.Add("Email", reader("Email").ToString())
                    jsonStatements.Add("InvoiceNotes", reader("InvoiceNotes").ToString())
                    jsonStatements.Add("Emitted", reader("Emitted").ToString())
                    Dim FirstEmission = reader("FirstEmission").ToString()
                    If FirstEmission IsNot Nothing And FirstEmission.Length > 0 Then
                        Dim Date2 = DateTime.Parse(FirstEmission)
                        jsonStatements.Add("FirstEmission", Date2.ToShortDateString())
                    Else
                        jsonStatements.Add("FirstEmission", "")
                    End If
                    Dim LatestEmission = reader("LatestEmission").ToString()
                    If LatestEmission IsNot Nothing And LatestEmission.Length > 0 Then
                        Dim Date2 = DateTime.Parse(LatestEmission)
                        jsonStatements.Add("LatestEmission", Date2.ToShortDateString())
                    Else
                        jsonStatements.Add("LatestEmission", "")
                    End If
                    Dim AmountPaid = reader("AmountPaid").ToString()
                    If AmountPaid IsNot Nothing And AmountPaid.Length > 0 Then
                        Dim paid = Decimal.Parse(AmountPaid)
                        jsonStatements.Add("AmountPaid", FormatCurrency(paid, 2))
                    Else
                        jsonStatements.Add("AmountPaid", "0.00")
                    End If
                    Dim AmountBilled = reader("AmountBilled").ToString()
                    If AmountBilled IsNot Nothing And AmountBilled.Length > 0 Then
                        Dim paid = Decimal.Parse(AmountBilled)
                        jsonStatements.Add("AmountBilled", FormatCurrency(paid, 2))
                    Else
                        jsonStatements.Add("AmountBilled", "0.00")
                    End If
                    Dim AmountDue = reader("AmountDue").ToString()
                    If AmountDue IsNot Nothing And AmountDue.Length > 0 Then
                        Dim paid = Decimal.Parse(AmountDue)
                        jsonStatements.Add("AmountDue", FormatCurrency(paid, 2))
                    Else
                        jsonStatements.Add("AmountDue", "0.00")
                    End If



                End If
            End While
            jsonObj.Add("Statement", jsonStatements)
        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try

        'invoices
        Try
            Dim jsonInvoicesArray As JArray = New JArray()
            Dim reader = ExecProsedure("STATEMENT2_invoices_Adapter", "@statementId", StatementId)
            While reader.Read()
                If reader.HasRows Then
                    Dim jsonInvoice As JObject = New JObject()
                    jsonInvoice.Add("Id", reader("Id").ToString())
                    jsonInvoice.Add("InvoiceNumber", reader("InvoiceNumber").ToString())
                    jsonInvoice.Add("InvoiceDate", reader("InvoiceDate").ToString())
                    jsonInvoice.Add("InvoicePaid", reader("InvoicePaid").ToString())
                    jsonInvoice.Add("AmountDue", reader("AmountDue").ToString())
                    jsonInvoice.Add("PaidToDate", reader("PaidToDate").ToString())
                    jsonInvoice.Add("Notes", reader("Notes").ToString())
                    jsonInvoice.Add("JobName", reader("JobName").ToString())
                    jsonInvoice.Add("Balance", reader("Balance").ToString())
                    jsonInvoice.Add("Emitted", reader("Emitted").ToString())
                    jsonInvoice.Add("LatestEmission", reader("LatestEmission").ToString())
                    jsonInvoice.Add("MaturityDate", reader("MaturityDate").ToString())
                    jsonInvoice.Add("Time", reader("Time").ToString())
                    jsonInvoice.Add("Rate", reader("Rate").ToString())
                    jsonInvoice.Add("FirstEmission", reader("FirstEmission").ToString())

                    jsonInvoicesArray.Add(jsonInvoice)
                End If
            End While
            jsonObj.Add("Invoices", jsonInvoicesArray)

        Catch ex As Exception
            Console.WriteLine(ex.Message())
        End Try
        Dim jstr = jsonObj.ToString()
        Return jsonObj

    End Function


    Public Function loadJobScopeJson(CompanyId As String, JobId As String) As JObject

        Dim ProposalId = LocalAPI.GetJobProperty(JobId, "proposalId")
        Dim CustomerID = LocalAPI.GetJobProperty(JobId, "Client")


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

        Dim jsonWorkScope As JObject = New JObject()
        jsonWorkScope.Add("ProposalNumber", LocalAPI.ProposalNumber(ProposalId))
        jsonWorkScope.Add("ProposalBy", LocalAPI.GetJobProposalBy(JobId))
        jsonWorkScope.Add("ClientName", LocalAPI.GetClientProperty(CustomerID, "Name"))
        jsonWorkScope.Add("Company", LocalAPI.GetClientProperty(CustomerID, "Company"))

        Dim sb = New StringBuilder()
        LocalAPI.GetScopeOfWork(ProposalId, sb)
        jsonWorkScope.Add("ScopeOfWorkText", sb.ToString)
        jsonObj.Add("ScopeOfWork", jsonWorkScope)

        Dim jstr = jsonObj.ToString()
        Return jsonObj

    End Function



    Public Function ExecProsedure(ProcedureName As String, ParamName As String, ProposalId As String) As SqlDataReader
        Dim cnn1 As SqlConnection = LocalAPI.GetConnection()
        Dim cmd As SqlCommand = cnn1.CreateCommand()
        cmd.CommandText = ProcedureName
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.AddWithValue(ParamName, ProposalId)
        Dim reader = cmd.ExecuteReader()
        Return reader
    End Function

End Class

