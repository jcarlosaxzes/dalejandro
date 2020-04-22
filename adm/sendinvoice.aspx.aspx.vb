Imports Telerik.Web.UI
Public Class sendinvoice_aspx
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                txtBody.DisableFilter(EditorFilters.ConvertFontToSpan)  ' Evita un error de ConvertFontToSpan
                lblInvoice.Text = Request.QueryString("InvoiceNo")

                If lblInvoice.Text > 0 Then
                    lblJobId.Text = LocalAPI.GetInvoiceProperty(lblInvoice.Text, "JobId")
                    lblClientId.Text = LocalAPI.GetJobProperty(lblJobId.Text, "Client")
                    txtEmissionRecurrenceDays.DbValue = LocalAPI.GetInvoiceProperty(lblInvoice.Text, "EmissionRecurrenceDays")
                    lblOrigen.Text = "" & Request.QueryString("Origen")
                    If Len(lblOrigen.Text) = 0 Then lblOrigen.Text = "1"

                    txtInvoiceNumber.Text = LocalAPI.InvoiceNumber(lblInvoice.Text)
                    txtInvoiceAmount.Text = FormatCurrency(LocalAPI.GetInvoiceAmount(lblInvoice.Text))
                    Title = ConfigurationManager.AppSettings("Titulo") & ". Invoice " & txtInvoiceNumber.Text

                    Dim nInvoiceType As Integer = Val(LocalAPI.GetInvoiceProperty(lblInvoice.Text, "InvoiceType"))

                    lblCompanyId.Text = LocalAPI.GetCompanyIdFromInvoice(lblInvoice.Text)

                    lblEmployeeEmail.Text = Master.UserEmail
                    lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)
                    lblEmployeeName.Text = LocalAPI.GetEmployeeName(lblEmployeeId.Text)

                    If Not LocalAPI.IsADMCLIuserAutorized(Membership.GetUser().UserName, lblCompanyId.Text) Then
                        lblInvoice.Text = "0"
                    End If

                    If nInvoiceType = 0 Then
                        ' Simple charge
                        Select Case lblOrigen.Text
                            Case 5, 6, 7   ' Desde Perfil Client, no hay opciones de Mail
                                'PanelEmail.Visible = False
                                PanelSMS.Visible = False
                            Case Else   ' Desde Admin
                                'txtTo.Text = LocalAPI.GetClientEmailFromInvoice(lblInvoice.Text)
                                SqlDataSourceClient.DataBind()

                                txtTo.Entries.Add(New AutoCompleteBoxEntry(LocalAPI.GetInvoiceProperty(lblInvoice.Text, "[Clients].[Name]"), LocalAPI.GetClientEmailFromInvoice(lblInvoice.Text)))
                                Dim sbillingContact As String = LocalAPI.GetBillingContactEmailFromInvoice(lblInvoice.Text)
                                If LocalAPI.ValidEmail(sbillingContact) Then
                                    txtTo.Entries.Add(New AutoCompleteBoxEntry(LocalAPI.GetInvoiceProperty(lblInvoice.Text, "[Clients].[Billing_contact]"), sbillingContact))
                                End If

                                txtCC.Text = LocalAPI.GetBillingContactEmailFromInvoice(lblInvoice.Text)

                                LeerInvoiceTemplate()
                                SMS_Init()
                        End Select

                    Else
                        ' Hourly rate
                        Response.RedirectPermanent("~/ADMCLI/InvoiceHR_RDLC.aspx?InvoiceNo=" & lblInvoice.Text & "&Origen=" & lblOrigen.Text)
                    End If

                    ' Tratamiento boton back
                    Select Case lblOrigen.Text
                        Case "103", "104", "1103"  ' desde editjob con ResponseRedirect()
                            RadWizard1.DisplayCancelButton = True
                        Case Else
                            RadWizard1.DisplayCancelButton = False
                    End Select

                    cboNotification.SelectedValue = 1
                    If Not LocalAPI.IsCompanySMSservice(lblCompanyId.Text) Then
                        cboNotification.Enabled = False
                    End If

                End If
            End If
            Me.Title = "Invoice " & lblInvoice.Text
        Catch ex As Exception
            ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

#Region "RadWizard Step Buttons"
    Private Sub RadWizard1_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.FinishButtonClick
        SendNotification()
    End Sub
    Private Sub RadWizard1_NextButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.NextButtonClick
        Select Case e.CurrentStep.ID
            Case "Confirmation"
                RadWizard1.WizardSteps(1).Enabled = True
                ' *********  Acciones relacionadas con todas las desiciones de Tab1 ******************

                '1.- Paneles visibles
                PanelEmail.Visible = (cboNotification.SelectedValue = 1 Or cboNotification.SelectedValue = 2)
                PanelUpload.Visible = (cboAttached.SelectedValue = 1)
                PanelSMS.Visible = (cboNotification.SelectedValue = 2 Or cboNotification.SelectedValue = 3)

                If Not PanelSMS.Visible Then
                    txtBody.Height = "300"
                End If

        End Select
    End Sub

    Private Sub RadWizard1_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.CancelButtonClick
        Dim jobId As Integer = LocalAPI.GetInvoiceProperty(lblInvoice.Text, "JobId")
        Select Case lblOrigen.Text
            Case "103"
                Response.Redirect("~/ADM/job.aspx?Job=" & jobId)'& "#invoices")
            Case "104"
                Response.Redirect("~/ADM/editjob.aspx?Job=" & jobId & "#invoices")
            Case "1103"
                Response.Redirect("~/ADM/Job_accounting.aspx?JobId=" & jobId) '& "#invoices")
        End Select
    End Sub
#End Region

    Private Sub LeerInvoiceTemplate()
        Try
            ' Variables
            Dim sProjectName As String = LocalAPI.GetInvoiceProperty(lblInvoice.Text, "[Jobs].[Job]")
            Dim sClienteName = LocalAPI.GetInvoiceProperty(lblInvoice.Text, "[Clients].[Name]")

            Dim sSign As String = LocalAPI.GetEmployeesSign(lblEmployeeId.Text)

            Dim sInvoiceNumber As String = LocalAPI.InvoiceNumber(lblInvoice.Text)
            ' Leer subjet y body template
            txtSubject.Text = LocalAPI.GetMessageTemplateSubject("Invoice", lblCompanyId.Text)
            Dim sBody As String = LocalAPI.GetMessageTemplateBody("Invoice", lblCompanyId.Text)

            ' sustituir variables
            txtSubject.Text = Replace(txtSubject.Text, "[Invoice Number]", sInvoiceNumber)
            txtSubject.Text = Replace(txtSubject.Text, "[Project Name]", sProjectName)


            sBody = Replace(sBody, "[Invoice Number]", sInvoiceNumber)
            sBody = Replace(sBody, "[Project Name]", sProjectName)
            sBody = Replace(sBody, "[Client Name]", sClienteName)
            sBody = Replace(sBody, "[Sign]", sSign)

            ' Enlace al Invoice
            Dim sURL As String = LocalAPI.GetSharedLink_URL(4, lblInvoice.Text)
            sBody = Replace(sBody, "[PASconceptLink]", sURL)

            sURL = LocalAPI.GetSharedLink_URL(8, lblInvoice.Text)
            sBody = Replace(sBody, "[JobLink]", sURL)

            txtBody.Content = sBody

        Catch ex As Exception
            ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub
    Private Sub AttachLinks()
        Try

            'get a reference to the row
            Dim nRecs As Integer
            If RadGridLinks.SelectedItems.Count > 0 Then
                txtBody.Content = txtBody.Content & "<br/><br/>Related Links:<br/>"
                For Each dataItem As GridDataItem In RadGridLinks.SelectedItems
                    If dataItem.Selected Then
                        txtBody.Content = txtBody.Content & " <a href=" & """" & dataItem("link").Text & """" & ">" & dataItem("Title").Text & "</a><br/>"
                        nRecs = nRecs + 1
                    End If
                Next
            End If

        Catch ex As Exception

        End Try
    End Sub

    Private Sub SendNotification()
        Try
            Dim bSendEmail As Boolean
            Dim bSendSMS As Boolean
            Dim sInfo As String = ""

            If cboNotification.SelectedValue = 1 Or cboNotification.SelectedValue = 2 Then
                Dim sInvoiceNumber As String = LocalAPI.InvoiceNumber(lblInvoice.Text)

                If txtTo.Text.Length > 0 Then

                    LocalAPI.ActualizarEmittedInvoice(lblInvoice.Text, lblEmployeeId.Text, txtEmissionRecurrenceDays.DbValue)
                    If cboInternalNotification.SelectedValue = 1 Then
                        LocalAPI.InvoiceMessage(lblInvoice.Text, lblCompanyId.Text)
                    End If
                    txtBody.Content = txtBody.Content & LocalAPI.GetPASSign()

                    ' Adjuntar Related Links
                    AttachLinks()

                    Dim sTo As String
                    For Each entry As AutoCompleteBoxEntry In txtTo.Entries
                        sTo = sTo & entry.Value & ","
                    Next
                    If Len(sTo) > 1 Then sTo = Left(sTo, Len(sTo) - 1)

                    Dim SenderDisplay As String = LocalAPI.GetEmployeeName(lblEmployeeId.Text)
                    Dim sBCO As String = Master.UserEmail
                    Dim AccountantEmail As String = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "AccountantEmail")
                    If LocalAPI.ValidEmail(AccountantEmail) Then
                        sBCO = sBCO & "," & AccountantEmail
                    End If

                    bSendEmail = LocalAPI.SendMail(sTo, txtCC.Text, sBCO, txtSubject.Text, txtBody.Content, lblCompanyId.Text,, SenderDisplay, lblEmployeeEmail.Text, SenderDisplay)

                    LocalAPI.NewAutomaticInvoiceReminderFromEmitted(lblInvoice.Text, lblEmployeeId.Text, lblCompanyId.Text)

                Else
                    InfoMessage("Email of '" & txtTo.Text & "' is nothing")
                End If
            End If

            If cboNotification.SelectedValue = 2 Or cboNotification.SelectedValue = 3 Then
                If SendProposalSMS() Then
                    bSendSMS = True
                End If

            End If

            If bSendEmail Or bSendSMS Then
                sInfo = "The Invoice was notified by "
            End If
            If bSendEmail Then
                sInfo = sInfo & "Email"
            End If
            If bSendSMS Then
                sInfo = sInfo & IIf(bSendEmail, " and by ", "") & "SMS"
            End If
            If Len(sInfo) > 0 Then InfoMessage(sInfo)

        Catch ex As Exception
            ErrorMessage("Email sending error. " & ex.Message)

        End Try
    End Sub

    Private Sub SMS_Init()
        If LocalAPI.IsCompanySMSservice(lblCompanyId.Text) Then
            Dim clientId As Integer = LocalAPI.GetClientIdFromInvoice(lblInvoice.Text)
            If Not LocalAPI.IsClientDenySMS(clientId) Then
                txtCellular.Text = LocalAPI.GetInvoiceProperty(lblInvoice.Text, "[Clients].[Cellular]")
                Dim InvoiceNumber As String = LocalAPI.InvoiceNumber(lblInvoice.Text)
                Dim sURL As String = LocalAPI.GetSharedLink_URL(4, lblInvoice.Text) & " "
                Dim jobId As Integer = LocalAPI.GetInvoiceProperty(lblInvoice.Text, "JobId")
                Dim JobName As String = LocalAPI.GetJobProperty(jobId, "Job")

                txtSMS.Text = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Name") & " notification" & vbCrLf &
                            "Click the following link to review the invoice for " & JobName & " (Invoice Number " & InvoiceNumber & ")   " &
                            sURL
            End If
        End If
    End Sub

    Private Function SendProposalSMS() As Boolean
        Try

            Dim sCellPhone As String = txtCellular.Text
            If SMS.IsValidPhone(sCellPhone) Then
                If SMS.SendSMS(sCellPhone, txtSMS.Text, lblCompanyId.Text) Then
                    Return True
                End If
            Else
                InfoMessage("SMS Error. Telephone format must be 10-digit number, eg.: 3058889999")
            End If

        Catch ex As Exception
            ErrorMessage("SMS error. " & ex.Message)
        End Try
    End Function

    Private Sub ErrorMessage(ByVal sText As String, Optional ByVal SecondsAutoCloseDelay As Integer = 0)
        If sText.Length > 0 Then
            RadNotificationError.Title = "Error message"
            RadNotificationError.Text = sText
            RadNotificationError.AutoCloseDelay = SecondsAutoCloseDelay * 1000
            RadNotificationError.Show()
        End If
    End Sub

    Private Sub InfoMessage(ByVal sText As String, Optional ByVal SecondsAutoCloseDelay As Integer = 3)
        If sText.Length > 0 Then
            RadNotificationWarning.Title = Me.Title
            RadNotificationWarning.Text = sText
            RadNotificationWarning.AutoCloseDelay = SecondsAutoCloseDelay * 1000
            RadNotificationWarning.Show()
        End If
    End Sub

    Protected Sub RadCloudUpload1_FileUploaded(sender As Object, e As Telerik.Web.UI.CloudFileUploadedEventArgs)
        Try
            If LocalAPI.IsAzureStorage(lblCompanyId.Text) Then

                ' The uploaded files need to be removed from the storage by the control after a certain time.
                e.IsValid = LocalAPI.JobAzureStorage_Insert(lblJobId.Text, 10, e.FileInfo.OriginalFileName, e.FileInfo.KeyName, True, e.FileInfo.ContentLength, e.FileInfo.ContentType)
                If e.IsValid Then
                    RadGridLinks.DataBind()
                    InfoMessage(e.FileInfo.OriginalFileName & " uploaded")
                Else
                    ErrorMessage("The file " & e.FileInfo.OriginalFileName & " has been previously loaded!")
                End If

            End If
        Catch ex As Exception
            e.IsValid = False
            ErrorMessage("Upload error. " & ex.Message)
        End Try
    End Sub
End Class

