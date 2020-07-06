Imports System.Threading.Tasks
Public Class singproposalsign
    Inherits System.Web.UI.Page

#Region "Page Properties"

    Public Property CompanyId() As Integer
        Get
            Return m_CompanyId
        End Get
        Private Set
            m_CompanyId = Value
        End Set
    End Property
    Private m_CompanyId As Integer
    Public Property CompanyName() As String
        Get
            Return m_CompanyName
        End Get
        Private Set
            m_CompanyName = Value
        End Set
    End Property
    Private m_CompanyName As String
    Public Property CompanyAddress() As String
        Get
            Return m_CompanyAddress
        End Get
        Private Set
            m_CompanyAddress = Value
        End Set
    End Property
    Private m_CompanyAddress As String
    Public Property CompanyCity() As String
        Get
            Return m_CompanyCity
        End Get
        Private Set
            m_CompanyCity = Value
        End Set
    End Property
    Private m_CompanyCity As String
    Public Property CompanyState() As String
        Get
            Return m_CompanyState
        End Get
        Private Set
            m_CompanyState = Value
        End Set
    End Property
    Private m_CompanyState As String
    Public Property CompanyZipCode() As String
        Get
            Return m_CompanyZipCode
        End Get
        Private Set
            m_CompanyZipCode = Value
        End Set
    End Property
    Private m_CompanyZipCode As String
    Public Property CompanyPhone() As String
        Get
            Return m_CompanyPhone
        End Get
        Private Set
            m_CompanyPhone = Value
        End Set
    End Property
    Private m_CompanyPhone As String
    Public Property CompanyEmail() As String
        Get
            Return m_CompanyEmail
        End Get
        Private Set
            m_CompanyEmail = Value
        End Set
    End Property
    Private m_CompanyEmail As String
    Public Property CompanyWebLink() As String
        Get
            Return m_CompanyWebLink
        End Get
        Private Set
            m_CompanyWebLink = Value
        End Set
    End Property
    Private m_CompanyWebLink As String
    Public Property CompanyLetterHead() As Byte()
        Get
            Return m_CompanyLetterHead
        End Get
        Private Set
            m_CompanyLetterHead = Value
        End Set
    End Property
    Private m_CompanyLetterHead As Byte()
    Public Property Base64StringCompanyLetterHead() As String
        Get
            Return m_Base64StringCompanyLetterHead
        End Get
        Private Set
            m_Base64StringCompanyLetterHead = Value
        End Set
    End Property
    Private m_Base64StringCompanyLetterHead As String
    Public Property CompanyLogo() As Byte()
        Get
            Return m_CompanyLogo
        End Get
        Private Set
            m_CompanyLogo = Value
        End Set
    End Property
    Private m_CompanyLogo As Byte()
    Public Property Base64StringCompanyLogo() As String
        Get
            Return m_Base64StringCompanyLogo
        End Get
        Private Set
            m_Base64StringCompanyLogo = Value
        End Set
    End Property
    Private m_Base64StringCompanyLogo As String
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Try
                If Not Request.QueryString("GuiId") Is Nothing Then
                    lblGuiId.Text = Request.QueryString("GuiId")
                    lblProposalId.Text = LocalAPI.GetSharedLink_Id(11, lblGuiId.Text)
                    lblCompanyId.Text = LocalAPI.GetCompanyIdFromProposal(lblProposalId.Text)
                    CompanyId = lblCompanyId.Text
                    UpdatePageProperties()

                    RadBarcode1.Text = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Signature.aspx?GuiId=" & lblGuiId.Text & "&ObjType=11"
                End If
                Dim IsReadOnly As Boolean
                If Not Request.QueryString("IsReadOnly") Is Nothing Then
                    IsReadOnly = Request.QueryString("IsReadOnly")
                Else
                    IsReadOnly = LocalAPI.GetProposalData(lblProposalId.Text, "statusId") > 1
                End If

                pnlSideTools.Visible = Not IsReadOnly
                '!!!lblProposalId.Text = 14424
                'lblCompanyId.Text = LocalAPI.GetCompanyIdFromProposal(lblProposalId.Text)

                ' Para navegar en CLIENT PORTAL.....................................
                Session("CLIENTPORTAL_clientId") = LocalAPI.GetProposalProperty(lblProposalId.Text, "ClientId")
            Catch generatedExceptionName As Exception
                Throw New HttpException(404, "Proposal not found")
            End Try
        Else
            Dim target = Request("__EVENTTARGET")
            If target = "btnSign" Then
                SignProposal(lblProposalId.Text, lblCompanyId.Text, txtSignName.Text, Request("__EVENTARGUMENT"))
            End If
        End If

        If Not Request.QueryString("printing") Is Nothing Then
            pnlSideTools.Visible = False
        End If
    End Sub

    Private Async Sub SignProposal(proposalId As Integer, companyId As Integer, clientName As String, img As String)
        Try
            pnlSideTools.Visible = False


            ' Confirm proposal acceptance
            Dim JobId As Integer
            JobId = LocalAPI.ProposalStatus2Acept(proposalId, companyId)
            ' Sign Proposal
            LocalAPI.SignProposal(proposalId, clientName, img)

            Dim pdf As PdfApi = New PdfApi()
            Dim newName = "Companies/" & companyId & $"/{Guid.NewGuid().ToString()}.pdf"
            Dim pdfUrl = "https://pasconceptstorage.blob.core.windows.net/documents/" & newName

            ' Accept Email
            ProposalAcceptedEmail(proposalId, companyId, pdfUrl)
            Await pdf.CreateProposalSignedPdfAsync(proposalId, newName)

            If JobId > 0 Then
                NewJobEmail(proposalId, JobId, companyId, pdfUrl)
            Else
                NoJobEmail(proposalId, companyId, pdfUrl)
            End If



            Master.DisplayMsg("The Proposal has been Accepted", "A notification has been sent to our employee in charge. Thank you")
            ' Then Redirect
            RedirectToThanksPage()
        Catch ex As Exception
            Master.DisplayMsg("Proposal Error", ex.Message.ToString(), "error")
        End Try
    End Sub

    Private Function NewJobEmail(lProposalId As Integer, ByVal JobId As Integer, ByVal companyid As Integer, ProposalPdfURL As String) As Boolean
        Try
            Dim sCC As String = ""
            Dim nClientId As Integer = LocalAPI.GetProposalData(lProposalId, "ClientId")

            Dim sAceptedDate As String = LocalAPI.GetProposalData(lProposalId, "AceptedDate")
            Dim ProposalNumber As String = LocalAPI.ProposalNumber(lblProposalId.Text)
            Dim JobCodeName As String = LocalAPI.GetJobCodeName(JobId)
            Dim JobGUID As String = LocalAPI.GetJobProperty(JobId, "guid")
            Dim guid As String = LocalAPI.GetJobCodeName(JobId)
            Dim sClientName As String = LocalAPI.GetClientName(nClientId)

            Dim sSubject As String = "New Job: " & JobCodeName
            Dim sMsg As New System.Text.StringBuilder

            sMsg.Append("Greetings,")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append(sClientName & " has accepted the Proposal " & ProposalNumber & " and has been created the Job: " & JobCodeName)
            sMsg.Append("<br />")
            sMsg.Append("Date: " & sAceptedDate)
            sMsg.Append("<br />")
            sMsg.Append("<br />")

            If companyid = 260962 Then
                Try
                    sCC = "mayte@easterneg.com,"
                    'Number,Name,Location,Client,Employee,Department,Type 
                    '18 605,Sloans Curve Cabana ,2100 S Ocean Blvd Parking, South Ocean Boulevard, Palm Beach, FL 33480, USA,The Windows guys of Florida,Celia Maria Suarez Quintas,Spec. Eng. WD,Shop Dwgs
                    sMsg.Append("<br />")
                    sMsg.Append("<b>Titleblock</b>")
                    sMsg.Append("<br />")
                    sMsg.Append("Click here to")
                    sMsg.Append("<a href=" & """" & LocalAPI.GetHostAppSite() & "/adm/titleblock.aspx?guid=" & JobGUID & """" & "> download Titleblock </a> csv file")
                    sMsg.Append("<br />")

                    sMsg.Append("<br />")
                    sMsg.Append("-------------------------------------------------------------------------------------------------------")
                    sMsg.Append("<br />")
                    sMsg.Append("<br />")
                    sMsg.Append("<b>Scope of Work</b>")
                    sMsg.Append("<br />")
                    sMsg.Append("Click here to ")
                    sMsg.Append("<a href=" & """" & LocalAPI.GetHostAppSite() & "/adm/scopeofwork.aspx?guid=" & JobGUID & """" & "> view Scope of Work </a> from Proposal Page")
                    sMsg.Append("<br />")

                Catch ex As Exception

                End Try
            End If

            sMsg.Append("<br />")
            sMsg.Append("<a href=""" & ProposalPdfURL & """> Download PDF </a>")
            sMsg.Append("<br />")

            sMsg.Append("<br />")
            sMsg.Append("Thank you.")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("PASconcept Notifications")
            sMsg.Append("<br />")
            sMsg.Append(LocalAPI.GetPASSign())

            Dim sBody As String = sMsg.ToString
            Dim sProjectManagerEmail As String = LocalAPI.GetProjectManagerEmailFromProposal(lProposalId)

            If Len(sProjectManagerEmail) > 0 Then
                sCC = sCC & LocalAPI.GetHeadDepartmentEmailFromProposal(lProposalId)
                Dim sProjectManagerName As String = LocalAPI.GetProjectManagerEmailFromProposal(lProposalId)
                If Len(sProjectManagerEmail) > 0 Then
                    sProjectManagerName = LocalAPI.GetEmployeeFullName(sProjectManagerEmail, lblCompanyId.Text)
                End If
                SendGrid.Email.SendMail(sProjectManagerEmail, sCC, "", sSubject, sBody, companyid,,, sProjectManagerEmail, sProjectManagerName)

                Dim sProposalURL As String = "https://www.pasconcept.com/e2103445_8a47_49ff_808e_6008c0fe13a1/SingProposalSign.aspx?GuiId=" & LocalAPI.GetProposalProperty(lProposalId, "guid")
                Dim recipientEmailSent As String = sCC & IIf(Len(sProjectManagerEmail) > 0, "," & sProjectManagerEmail, "")
                OneSignalNotification.SendNotification(recipientEmailSent, "Proposal Accepted -> Job created", sClientName & " has accepted the Proposal " & ProposalNumber & " and has been created the Job: " & JobCodeName, sProposalURL, companyid)
            End If

        Catch ex As Exception
            Master.DisplayMsg("NewJob Email", ex.Message.ToString(), "error")
        End Try

    End Function

    Private Function NoJobEmail(lProposalId As Integer, ByVal companyid As Integer, ProposalPdfURL As String) As Boolean
        Try
            '
            Dim sAceptedDate As String = LocalAPI.GetProposalData(lProposalId, "AceptedDate")
            Dim ProposalNumber As String = LocalAPI.ProposalNumber(lblProposalId.Text)

            Dim sSubject As String = "Alert. Proposal accepted " & ProposalNumber & ", And no Job created!!!"
            Dim sMsg As New System.Text.StringBuilder

            sMsg.Append("PASconcept Alert!!!,")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("The Proposal (<strong>" & ProposalNumber & "</strong>) has been acepted and a Job was not created!!!")
            sMsg.Append("<br />")
            sMsg.Append("Date: " & sAceptedDate)
            sMsg.Append("<br />")

            sMsg.Append("<br />")
            sMsg.Append("<a href=""" & ProposalPdfURL & """> Download PDF</a>")
            sMsg.Append("<br />")

            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Thank you.")

            Dim sBody As String = sMsg.ToString
            Dim sCC As String = ""
            Dim sProjectManagerEmail As String = ""
            Dim sCCO As String = ""
            sProjectManagerEmail = LocalAPI.GetProjectManagerEmailFromProposal(lProposalId)
            sCC = sProjectManagerEmail & IIf(Len(sProjectManagerEmail) > 0, ",", "") & LocalAPI.GetCompanyProperty(companyid, "webEmailProfitWarningCC")
            sCCO = "jcarlos@axzes.com," & LocalAPI.GetHeadDepartmentEmailFromProposal(lProposalId)

            Dim sProjectManagerName As String = ""
            If Len(sProjectManagerEmail) > 0 Then
                sProjectManagerName = LocalAPI.GetEmployeeFullName(sProjectManagerEmail, companyid)
            End If

            SendGrid.Email.SendMail(sProjectManagerEmail, sCC, sCCO, sSubject, sBody, companyid,,, sProjectManagerEmail, sProjectManagerName)

            Dim sProposalURL As String = "https://www.pasconcept.com/e2103445_8a47_49ff_808e_6008c0fe13a1/SingProposalSign.aspx?GuiId=" & LocalAPI.GetProposalProperty(lProposalId, "guid")
            Dim recipientEmailSent As String = sCC & IIf(Len(sProjectManagerEmail) > 0, "," & sProjectManagerEmail, "")
            recipientEmailSent = recipientEmailSent & "," & sCCO
            OneSignalNotification.SendNotification(recipientEmailSent, "Proposal accepted Alert!!!", "Proposal " & ProposalNumber & " has accepted and Job was not created!!!", sProposalURL, companyid)

        Catch ex As Exception
            Master.DisplayMsg("NoJob Email", ex.Message.ToString(), "error")
        End Try

    End Function

    Protected Sub btnDenyProposal_Click(sender As Object, e As EventArgs)
        Try
            ' Confirm proposal acceptance
            LocalAPI.ProposalStatus2Declined(lblProposalId.Text, "Declined anonymous online", 3)
            ' Decline Email
            EmailDeclined(lblProposalId.Text, lblCompanyId.Text)
            Master.DisplayMsg("The proposal has been Declined", "A notification has been sent to our employee in charge. Thank you")
            Response.Redirect(LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/SingProposalSign.aspx?GuiId=" & lblGuiId.Text)
        Catch ex As Exception
            Master.DisplayMsg("Proposal Error", ex.Message.ToString(), "error")
        End Try
    End Sub

    Private Function ProposalAcceptedEmail(ByVal lProposalId As Integer, ByVal companyid As Integer, PrposalpdfUrl As String) As Boolean
        Try
            Dim ProposalObject = LocalAPI.GetRecord(lProposalId, "ProposalRecord_SELECT")
            Dim sClientEmail As String = ProposalObject("ClientEmail")

            If Not LocalAPI.sys_IsLog(sClientEmail, LocalAPI.sys_log_AccionENUM.AceptProposal, companyid, "Proposal ID: " & lProposalId) Then
                LocalAPI.sys_log_Nuevo(sClientEmail, LocalAPI.sys_log_AccionENUM.AceptProposal, companyid, "Proposal ID: " & lProposalId)

                Dim CompanyName As String = LocalAPI.GetCompanyProperty(companyid, "Name")

                Dim sSubject As String = LocalAPI.GetMessageTemplateSubject("Proposal Acceptance", lblCompanyId.Text)
                Dim sBody As String = LocalAPI.GetMessageTemplateBody("Proposal Acceptance", lblCompanyId.Text)

                sSubject = Replace(sSubject, "[Project Name]", ProposalObject("ProjectName"))

                sBody = Replace(sBody, "[Project Name]", ProposalObject("ProjectName"))
                sBody = Replace(sBody, "[Company Name]", CompanyName)
                sBody = Replace(sBody, "[PASconceptLink]", LocalAPI.GetSharedLink_URL(11, lblProposalId.Text))
                sBody = Replace(sBody, "[ProposalBy]", ProposalObject("ProposalBy"))
                sBody = Replace(sBody, "[ProposalByEmail]", ProposalObject("ProposalByEmail"))
                sBody = Replace(sBody, "[CompamyPhone]", LocalAPI.GetCompanyProperty(companyid, "Phone"))

                sBody = sBody & " <br /> <a href=""" & PrposalpdfUrl & """ > Download PDF</a><br />"

                Dim sCC As String = ""
                Dim sProjectManagerEmail As String = ""
                Dim sCCO As String = ""

                If LocalAPI.IsCompanyNotification(lblCompanyId.Text, "Notification_AceptedProposal") Then
                    sProjectManagerEmail = LocalAPI.GetProjectManagerEmailFromProposal(lProposalId)
                    sCC = sProjectManagerEmail & IIf(Len(sProjectManagerEmail) > 0, ", ", "") & LocalAPI.GetCompanyProperty(companyid, "webEmailProfitWarningCC")
                    sCCO = LocalAPI.GetHeadDepartmentEmailFromProposal(lProposalId)
                End If


                If companyid = 260962 Then
                    ' !!! Parche1, copia a Raissa
                    Dim departmentId As Integer = LocalAPI.GetProposalProperty(lProposalId, "DepartmentId")
                    Select Case departmentId
                        Case 3, 4, 5, 12
                            sCC = sCC & IIf(Len(sCC) > 0, ", ", "") & "raissa@easterneg.com"
                    End Select
                End If


                Dim sProjectManagerName As String = ""
                If Len(sProjectManagerEmail) > 0 Then
                    sProjectManagerName = LocalAPI.GetEmployeeFullName(sProjectManagerEmail, companyid)
                End If
                SendGrid.Email.SendMail(sClientEmail, sCC, sCCO, sSubject, sBody, companyid,,, sProjectManagerEmail, sProjectManagerName)


                Dim recipientEmailSent As String = sCC & IIf(Len(sCCO) > 0, "," & sCCO, "")
                OneSignalNotification.SendNotification(recipientEmailSent, "Proposal Accepted", "Proposal " & ProposalObject("ProposalNumber") & " from " & ProposalObject("ClientName") & " has been accepted. Click here to view.", ProposalObject("ProposalURL"), companyid)

            End If

        Catch ex As Exception
            Master.DisplayMsg("Proposal Error", ex.Message.ToString(), "error")
        End Try

    End Function

    Private Function EmailDeclined(ByVal lProposalId As Integer, ByVal companyid As Integer) As Boolean
        Try
            ' 
            Dim nClientId As Integer = LocalAPI.GetProposalData(lProposalId, "ClientId")
            If LocalAPI.IsClientNotification(nClientId, "Notification_declinedproposal") Then

                Dim sAceptedDate As String = LocalAPI.GetProposalData(lProposalId, "AceptedDate")
                Dim ProposalNumber As String = LocalAPI.ProposalNumber(lblProposalId.Text)
                Dim sSubject As String = "You have declined Proposal " & ProposalNumber
                Dim sClientName As String = LocalAPI.GetClientName(nClientId)
                Dim sClientEmail As String = LocalAPI.GetClientEmailFromProposal(lProposalId)
                Dim sMsg As New System.Text.StringBuilder

                sMsg.Append("Greetings,")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("You have declined Proposal  (<strong>" & ProposalNumber & "</strong>), And a notification has been sent to '<strong>" & LocalAPI.GetCompanyProperty(companyid, "Name") & "</strong>")
                sMsg.Append("<br />")
                sMsg.Append("Date: " & sAceptedDate)
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Decline by: anonymously online")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Thank you.")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("PASconcept Notifications")

                Dim sBody As String = sMsg.ToString
                Dim sCC As String = ""
                Dim sCCO As String = ""
                If LocalAPI.IsCompanyNotification(lblCompanyId.Text, "Notification_AceptedProposal") Then
                    sCC = LocalAPI.GetCompanyProperty(companyid, "webEmailProfitWarningCC")
                    sCCO = LocalAPI.GetCompanyProperty(companyid, "webEmailProfitWarningCCO")
                End If

                Task.Run(Function() SendGrid.Email.SendMail(sClientEmail, sCC, sCCO, sSubject, sBody, lblCompanyId.Text))

                Dim sProposalURL As String = "https://www.pasconcept.com/e2103445_8a47_49ff_808e_6008c0fe13a1/SingProposalSign.aspx?GuiId=" & LocalAPI.GetProposalProperty(lProposalId, "guid")
                Dim recipientEmailSent As String = sCC & IIf(Len(sCCO) > 0, "," & sCCO, "")
                OneSignalNotification.SendNotification(recipientEmailSent, "Proposal Decline", "Proposal " & ProposalNumber & " from " & sClientName & " has been Declined. Click here to view.", sProposalURL, companyid)
            End If
        Catch ex As Exception
            Master.DisplayMsg("Proposal Error", ex.Message.ToString(), "error")
        End Try
    End Function

    ''' <summary>
    ''' Queries all needed company info from DB
    ''' and updates all page properties to be accessed from 'Client side'
    ''' </summary>
    Private Sub UpdatePageProperties()
        ' TODO: Do a Simple query in DB
        Try
            CompanyName = LocalAPI.GetCompanyProperty(CompanyId, "Name")
            CompanyAddress = LocalAPI.GetCompanyProperty(CompanyId, "Address")
            CompanyCity = LocalAPI.GetCompanyProperty(CompanyId, "City")
            CompanyState = LocalAPI.GetCompanyProperty(CompanyId, "State")
            CompanyZipCode = LocalAPI.GetCompanyProperty(CompanyId, "ZipCode")
            CompanyPhone = LocalAPI.GetCompanyProperty(CompanyId, "Phone")
            CompanyEmail = LocalAPI.GetCompanyProperty(CompanyId, "Email")
            CompanyWebLink = LocalAPI.GetCompanyProperty(CompanyId, "web")
            CompanyLogo = LocalAPI.GetCompanyLogo(CompanyId)
            CompanyLetterHead = LocalAPI.GetCompanyLetterHead(CompanyId)
            ' Encoding Images
            Base64StringCompanyLogo = Convert.ToBase64String(CompanyLogo)
            Base64StringCompanyLetterHead = Convert.ToBase64String(CompanyLetterHead)
        Catch ex As Exception

        End Try
    End Sub

    Public Function ShareDocumentsPanelVisible(IsSharePublicLinks As Integer) As Boolean
        If IsSharePublicLinks = 1 Then
            Return LocalAPI.IsAzureStorage(lblCompanyId.Text) And LocalAPI.GetAzureFilesCountInProposal(lblProposalId.Text) > 0
        End If
    End Function

    Private Sub RedirectToThanksPage()
        Dim url As String
        ' Corporative Thanks Page
        url = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "ThankPage_AceptanceProposal_url")
        If Len(url) = 0 Then
            url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/thank-you-proposal.aspx?GuiId=" & lblGuiId.Text
        End If
        Response.Redirect(url, False)
    End Sub

    Protected Async Sub btnPrint_Click(sender As Object, e As EventArgs)
        Dim pdf As PdfApi = New PdfApi()
        Dim pdfBytes = Await pdf.CreateProposalPdfBytes(lblProposalId.Text)
        Dim response As HttpResponse = HttpContext.Current.Response
        response.ContentType = "application/pdf"
        response.AddHeader("Content-Disposition", "attachment; filename=Proposal.pdf")
        response.ClearContent()
        response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length)
        response.Flush()

    End Sub
End Class
