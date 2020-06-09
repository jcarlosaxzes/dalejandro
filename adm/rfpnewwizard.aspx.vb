Imports Telerik.Web.UI
Public Class rfpnewwizard
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Title = ConfigurationManager.AppSettings("Titulo") & ". New Request for Proposals"
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewRequestProposals") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            lblCompanyId.Text = Session("companyId")

            txtBody.DisableFilter(EditorFilters.ConvertFontToSpan)
            Master.PageTitle = "Subconsultants/New Request for Proposals"

            ' Inicializar valores
            txtSender.Text = LocalAPI.GetEmployeeFullName(Master.UserEmail, lblCompanyId.Text)
            txtSenderEmail.Text = Master.UserEmail

            RadDatePicker1.DbSelectedDate = Today

            lblAzureGuiId.Text = Guid.NewGuid().ToString()

            LeerMessageTemplate()

            If Not Request.QueryString("ParentId") Is Nothing Then
                lblParentId.Text = Request.QueryString("ParentId")
                If LocalAPI.IsCompanyViolation(lblParentId.Text, "RequestForProposals", lblCompanyId.Text) Then Response.RedirectPermanent("~/ADM/Default.aspx")
                ReadMasterRFP()
            End If

            If Not Request.QueryString("fromtree") Is Nothing Then
                lblBackSource.Text = 1
            End If


        End If

    End Sub
    Private Sub ReadMasterRFP()
        Try
            Dim RFFObject = LocalAPI.GetRecord(lblParentId.Text, "RFP_SELECT")

            txtProjectName.Text = RFFObject("ProjectName")
            txtProjectArea.Text = RFFObject("ProjectArea")
            txtIntroductoryText.Text = RFFObject("IntroductoryText")
            txtProjectLocation.Text = RFFObject("ProjectLocation")
            txtProjectDescription.Text = RFFObject("ProjectDescription")
            lblAzureGuiId.Text = RFFObject("guid")
            radEditor_TandC.Content = RFFObject("MyAgreements")

            Try
                txtText1.Text = RFFObject("PaymentText1")
                txtText2.Text = RFFObject("PaymentText2")
                txtText3.Text = RFFObject("PaymentText3")
                txtText4.Text = RFFObject("PaymentText4")
                txtText5.Text = RFFObject("PaymentText5")
                txtText6.Text = RFFObject("PaymentText6")
                txtText7.Text = RFFObject("PaymentText7")
                txtText8.Text = RFFObject("PaymentText8")
                txtText9.Text = RFFObject("PaymentText9")
                txtText10.Text = RFFObject("PaymentText10")
            Catch ex As Exception

            End Try
            Try

                txtValue1.Text = RFFObject("PaymentSchedule1")
                txtValue2.Text = RFFObject("PaymentSchedule2")
                txtValue3.Text = RFFObject("PaymentSchedule3")
                txtValue4.Text = RFFObject("PaymentSchedule4")
                txtValue5.Text = RFFObject("PaymentSchedule5")
                txtValue6.Text = RFFObject("PaymentSchedule6")
                txtValue7.Text = RFFObject("PaymentSchedule7")
                txtValue8.Text = RFFObject("PaymentSchedule8")
                txtValue9.Text = RFFObject("PaymentSchedule9")
                txtValue10.Text = RFFObject("PaymentSchedule10")
            Catch ex As Exception

            End Try

            PanelPS2.Visible = (txtValue2.Text > 0)
            PanelPS3.Visible = (txtValue3.Text > 0)
            PanelPS4.Visible = (txtValue4.Text > 0)
            PanelPS5.Visible = (txtValue5.Text > 0)
            PanelPS6.Visible = (txtValue6.Text > 0)
            PanelPS7.Visible = (txtValue7.Text > 0)
            PanelPS8.Visible = (txtValue8.Text > 0)
            PanelPS9.Visible = (txtValue9.Text > 0)
            PanelPS10.Visible = (txtValue10.Text > 0)


        Catch ex As Exception

        End Try
    End Sub
    Private Sub LeerMessageTemplate()
        Try
            If txtSubject.Text.Length = 0 Then
                ' Variables
                'Dim sProjectName As String = LocalAPI.GetInvoiceProperty(lblInvoice.Text, "[Jobs].[Job]")
                Dim sSign = LocalAPI.GetCompanySign(lblCompanyId.Text)

                ' Leer subjet y body template
                txtSubject.Text = LocalAPI.GetMessageTemplateSubject("New RFP", lblCompanyId.Text)
                txtBody.Content = LocalAPI.GetMessageTemplateBody("New RFP", lblCompanyId.Text)

                ' sustituir variables
                txtBody.Content = Replace(txtBody.Content, "[Sign]", sSign)

            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub SqlDataSourceRFP_Inserted(ByVal sender As Object, ByVal e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceRFP.Inserted
        lblRFPLastId.Text = e.Command.Parameters("@rfpId_OUT").Value

        ' Clone RequestForProposals_azureuploads
        LocalAPI.RequestForProposals_azureuploads_CLONE(lblRFPLastId.Text, lblAzureGuiId.Text)
    End Sub

    Private Function ValidarDatos() As Boolean
        lblMsg.Text = ""
        If RadListBoxDestinationSubContrator.Items.Count > 0 Then
            If opcUpdate.Checked Or opcUpdateAndSubmit.Checked Then
                Return True
            Else
                lblMsg.Text = "¡¡¡ Select Save Changes or Save Changes  And Submit option¡¡¡"
            End If
        Else
            lblMsg.Text = "¡¡¡ Select subconsultant(s) ¡¡¡"
            Return False
        End If
    End Function

    Private Sub SetPaymentsScheduleListControls(indexControl As Integer, dVal As Double, sText As String)
        Select Case indexControl
            Case 1
                txtValue1.Text = dVal
                txtText1.Text = sText
                'PanelPS1.Visible = dVal > 0
            Case 2
                txtValue2.Text = dVal
                txtText2.Text = sText
                PanelPS2.Visible = dVal > 0
            Case 3
                txtValue3.Text = dVal
                txtText3.Text = sText
                PanelPS3.Visible = dVal > 0
            Case 4
                txtValue4.Text = dVal
                txtText4.Text = sText
                PanelPS4.Visible = dVal > 0
            Case 5
                txtValue5.Text = dVal
                txtText5.Text = sText
                PanelPS5.Visible = dVal > 0
            Case 6
                txtValue6.Text = dVal
                txtText6.Text = sText
                PanelPS6.Visible = dVal > 0
            Case 7
                txtValue7.Text = dVal
                txtText7.Text = sText
                PanelPS7.Visible = dVal > 0
            Case 8
                txtValue8.Text = dVal
                txtText8.Text = sText
                PanelPS8.Visible = dVal > 0
            Case 9
                txtValue9.Text = dVal
                txtText9.Text = sText
                PanelPS9.Visible = dVal > 0
            Case 10
                txtValue10.Text = dVal
                txtText10.Text = sText
                PanelPS10.Visible = dVal > 0
        End Select
    End Sub

    Protected Sub RadWizard1_NextButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.NextButtonClick
        lblMsg.Text = ""
        Select Case e.CurrentStep.ID
            Case "RadWizardStepsSubconsultants"
                RadWizard1.WizardSteps(1).Enabled = (RadListBoxDestinationSubContrator.Items.Count > 0)

            Case "RadWizardStepProject"
                RadWizard1.WizardSteps(2).Enabled = Len(txtProjectName.Text) > 0
                RadWizard1.WizardSteps(3).Enabled = RadWizard1.WizardSteps(2).Enabled
                RadWizard1.WizardSteps(4).Enabled = RadWizard1.WizardSteps(2).Enabled
                RadWizard1.WizardSteps(5).Enabled = RadWizard1.WizardSteps(2).Enabled
                RadWizard1.WizardSteps(6).Enabled = RadWizard1.WizardSteps(2).Enabled
        End Select
    End Sub
    Private Sub RadWizard1_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.FinishButtonClick
        Try
            If ValidarDatos() Then
                Dim i As Integer
                'RadListBoxResult.Items.Add(New RadListBoxItem("Subconsultants................."))
                For i = 0 To RadListBoxDestinationSubContrator.Items.Count - 1
                    lblSubconsultaActiveId.Text = RadListBoxDestinationSubContrator.Items(i).Value

                    lblRFPLastId.Text = LocalAPI.RFP_INSERT(cboDiscipline.SelectedValue, lblSubconsultaActiveId.Text, txtProjectName.Text, txtProjectLocation.Text, txtProjectArea.Text, txtProjectDescription.Text, txtValue1.Text, txtText1.Text, txtValue2.Text, txtText2.Text, txtValue3.Text, txtText3.Text, txtValue4.Text, txtText4.Text, txtValue5.Text, txtText5.Text, txtValue6.Text, txtText6.Text, txtValue7.Text, txtText7.Text, txtValue8.Text, txtText8.Text, txtValue9.Text, txtText9.Text, txtValue10.Text, txtText10.Text, radEditor_TandC.Content, txtSender.Text, txtSenderEmail.Text, txtIntroductoryText.Text, RadDatePicker1.SelectedDate, lblParentId.Text, lblCompanyId.Text)

                    If i = 0 And lblParentId.Text = "0" Then
                        lblParentId.Text = lblRFPLastId.Text
                    End If


                    If opcUpdateAndSubmit.Checked Then
                        LocalAPI.NotificarRFP(lblRFPLastId.Text)
                        LocalAPI.SetRFPStatus(lblRFPLastId.Text, LocalAPI.RFPStatus_ENUM.Sent)
                    End If
                    LocalAPI.sys_log_Nuevo(Master.UserEmail, LocalAPI.sys_log_AccionENUM.NewRFP, lblCompanyId.Text, txtProjectName.Text)
                Next
                iframeViewRFP.Src = LocalAPI.GetSharedLink_URL(2002, lblRFPLastId.Text) & "&IsReadOnly=1"

                ' Delete original Images Uploads (sin @requestforproposalId definido todavia)
                LocalAPI.RequestForProposals_azureuploads_DELETE(lblAzureGuiId.Text)

                'Response.RedirectPermanent("~/ADM/RequestForProposals.aspx")
            Else
                RadWizardStepConfirmation.Active = True
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub


#Region "Attachment_Step7"
    Protected Sub RadCloudUpload1_FileUploaded(sender As Object, e As Telerik.Web.UI.CloudFileUploadedEventArgs)
        Try
            If LocalAPI.IsAzureStorage(lblCompanyId.Text) Then
                Dim tempName = e.FileInfo.KeyName
                Dim fileExt = IO.Path.GetExtension(tempName)
                Dim newName = "Companies/" & lblCompanyId.Text & $"/{Guid.NewGuid().ToString()}" & fileExt
                AzureStorageApi.CopyFile(tempName, newName, lblCompanyId.Text)
                AzureStorageApi.DeleteFile(tempName, 0)
                ' The uploaded files need to be removed from the storage by the control after a certain time.
                e.IsValid = LocalAPI.RequestForProposalsAzureStorage_Insert(0, CType(sender.NamingContainer.FindControl("cboDocType"), RadComboBox).SelectedValue, e.FileInfo.OriginalFileName, newName, CType(sender.NamingContainer.FindControl("chkPublic"), RadCheckBox).Checked, e.FileInfo.ContentLength, e.FileInfo.ContentType, lblAzureGuiId.Text)
                RadGridAzureuploads.DataBind()
                Master.InfoMessage(e.FileInfo.OriginalFileName & " uploaded")
            Else
                Master.ErrorMessage("You do not have hired the module Upload files")
            End If
        Catch ex As Exception
            e.IsValid = False
            lblMsg.Text = "Error. " & ex.Message
        End Try
    End Sub

    Private Sub SqlDataSourceAzureFiles_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAzureFiles.Deleting
        Dim KeyName As String = LocalAPI.GetRequestForProposalsAzureFileKeyName(e.Command.Parameters("@Id").Value)
        AzureStorageApi.DeleteFile(KeyName, lblCompanyId.Text)
    End Sub

    Private Sub cboPaymentSchedules_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboPaymentSchedules.SelectedIndexChanged
        Try
            If cboPaymentSchedules.SelectedValue > 0 Then
                Dim psValues As String = LocalAPI.GetStringEscalar("SELECT PaymentsScheduleList FROM Invoices_types WHERE [Id]=" & cboPaymentSchedules.SelectedValue)
                Dim psText As String = LocalAPI.GetStringEscalar("SELECT PaymentsTextList FROM Invoices_types WHERE [Id]=" & cboPaymentSchedules.SelectedValue)

                Dim sArrValues As String() = Split(psValues, ",")
                Dim sArrText As String() = Split(psText, ",")
                Dim i As Int16, j As Int16
                If sArrValues.Length > 0 Then
                    For i = 0 To sArrValues.Length - 1
                        If Len(sArrValues(i).ToString) > 0 Then
                            SetPaymentsScheduleListControls(i + 1, sArrValues(i), sArrText(i))
                        End If
                    Next
                End If
                For j = i To LocalAPI.MAXPaymentSchedule - 1
                    SetPaymentsScheduleListControls(j + 1, 0, "")
                Next
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub cboTandCtemplates_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboTandCtemplates.SelectedIndexChanged
        Try
            radEditor_TandC.Content = LocalAPI.GetProposalTemplateDescription(Val("" & cboTandCtemplates.SelectedValue))
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Select Case lblBackSource.Text
            Case 1
                Response.Redirect("~/adm/rfps.aspx")
            Case 2
                Response.Redirect("~/adm/requestforproposals.aspx")

        End Select
    End Sub

#End Region


End Class

