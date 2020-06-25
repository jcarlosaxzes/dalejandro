﻿Imports Telerik.Web.UI
Public Class proposalnewwizard
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then

                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)
                ' Analisis de Cantidad en esta Caracteristica¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡
                Dim CantidadPermitida As Double, CantidadActual As Double
                If LocalAPI.sys_CaracteristicaCantidad(lblCompanyId.Text, 202, Session("Version"), CantidadPermitida, CantidadActual) Then
                    Response.RedirectPermanent("~/ADM/VersionFeatures.aspx?Feature=Amount of Proposal per year(" & CantidadPermitida & ")")
                End If

                cboClients.DataBind()
                cboEmployee.DataBind()
                cboSector.DataBind()


                If Request.QueryString("proposalId") Is Nothing Then
                    ' New Proposal.....................
                    SqlDataSourceClient.DataBind()

                    SqlDataSourceEmployees.DataBind()

                    cboEmployee.SelectedValue = Master.UserId

                    LocalAPI.FirstDeparment(lblCompanyId.Text)
                    SqlDataSourceDepartments.DataBind()
                    cboDepartment.DataBind()

                    ' No quieren predefinirlo....cboDepartment.SelectedValue = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "DepartmentId")

                    ' From Pre-Project?
                    If Not Request.QueryString("preprojectId") Is Nothing Then
                        lblPreProjectId.Text = Request.QueryString("preprojectId")
                        cboProjectManagerId.DataBind()

                        ReadPreProject(lblPreProjectId.Text)
                        RadWizard1.WizardSteps(1).Enabled = True
                        RadWizardStepProposal.Active = True
                    End If

                Else
                    ' Edit Proposal....................
                    lblProposalId.Text = Request.QueryString("proposalId")
                    lblClientId.Text = LocalAPI.GetProposalProperty(lblProposalId.Text, "ClientId")

                    cboPaymentSchedules.DataBind()
                    cboPaymentSchedules.SelectedValue = LocalAPI.GetProposalProperty(lblProposalId.Text, "paymentscheduleId")
                    RadGridPS.DataBind()

                    cboPaymentSchedules.Visible = LocalAPI.IsGeneralPS(lblProposalId.Text)
                    btnUpdatePS.Visible = cboPaymentSchedules.Visible

                    ProposalItemsDataBind()

                    For i = 1 To RadWizard1.WizardSteps.Count - 1
                        RadWizard1.WizardSteps(i).Enabled = True
                    Next

                    ' Active Tab?
                    If Not Request.QueryString("AttachmentsTab") Is Nothing Then
                        RadWizardStepAttachments.Active = True
                    ElseIf Not Request.QueryString("ProposalTab") Is Nothing Then
                        RadWizardStepProposal.Active = True
                    Else
                        'FeesTab
                        RadWizardStepFees.Active = True
                    End If
                End If

                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". New Proposal"
                Master.PageTitle = "Proposals/New Proposal"
                'Master.Help = "http://blog.pasconcept.com/2012/04/fee-proposal-edit-proposal-page.html"

            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub ReadPreProject(preprojectId As Integer)
        Try
            Dim PreProjectInfo = LocalAPI.GetRecord(preprojectId, "Pre_Project_SELECT")

            txtProposalName.Text = PreProjectInfo("Name")
            cboClients.SelectedValue = PreProjectInfo("clientId")
            ReadClientInfo_Step0()
            cboProjectType.SelectedValue = PreProjectInfo("ProjectType")
            txtProjectAddressLine.Text = PreProjectInfo("ProjectLocation")
            cboEmployee.SelectedValue = PreProjectInfo("PreparedBy")
            cboProjectManagerId.SelectedValue = PreProjectInfo("ProposalBy")
            cboDepartment.SelectedValue = PreProjectInfo("DepartmentId")
        Catch ex As Exception
        End Try
    End Sub

    Private Sub ProposalItemsDataBind()
        If lblProposalId.Text > "0" Then

            ReadProposal(lblProposalId.Text)

            SqlDataSourceProposal_Step1.DataBind()

            RadGridFees.DataBind()

            FormViewTC.DataBind()

            RadGridPS.DataBind()

            RadGridAzureuploads.DataBind()

            iframeViewProposal.Src = LocalAPI.GetSharedLink_URL(111, lblProposalId.Text) & "&IsReadOnly=1"

        End If
    End Sub

    Private Function NewProposal() As Boolean
        ' INSERT NEW PROPOSAL
        If Not LocalAPI.IsProposalOrJobName(txtProposalName.Text, lblCompanyId.Text) Then
            lblProposalId.Text = LocalAPI.CreateProposal(cboType.SelectedValue, txtProposalName.Text, cboEmployee.SelectedValue, lblCompanyId.Text, lblEmployeeId.Text,
                                                         cboSector.SelectedValue, cboUse.SelectedValue, cboUse2.SelectedValue,
                                                      cboDepartment.SelectedValue, 0,
                                                         txtProjectAddressLine.Text, txtUnit.DbValue, cboMeasure.SelectedValue, cboProjectType.SelectedValue, cboClients.SelectedValue, cboProjectManagerId.SelectedValue)

            ' UPDATE PROPOSAL, aunque sea despues de NEW para incluir todos los Campos adicionales
            SqlDataSourceProposal_Step1.Update()

            ' Update proposalId si viene de PreProject
            If lblPreProjectId.Text > 0 Then
                LocalAPI.SetPreProject_proposalId(lblPreProjectId.Text, lblProposalId.Text)
            End If


            ProposalItemsDataBind()

            Return (lblProposalId.Text > 0)
        Else
            RadWizard1.ActiveStepIndex = 1
            lblMsg.Text = "'" & txtProposalName.Text & "' is the name of other proposal or job. Change this property."
            txtProposalName.Focus()
        End If
    End Function

#Region "RadWizard Step Buttons"
    Protected Sub RadWizard1_NextButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.NextButtonClick
        lblMsg.Text = ""
        Select Case e.CurrentStep.ID
            Case "Client"
                SqlDataSourceProposalClient.Update()

                RadWizard1.WizardSteps(1).Enabled = (cboClients.SelectedValue) > 0

            Case "RadWizardStepProposal"
                If lblProposalId.Text = "0" Then

                    NewProposal()

                Else
                    ' UPDATE PROPOSAL
                    SqlDataSourceProposal_Step1.Update()
                End If

                RadWizard1.WizardSteps(2).Enabled = (lblProposalId.Text) > 0
                RadWizard1.WizardSteps(3).Enabled = (lblProposalId.Text) > 0
                RadWizard1.WizardSteps(4).Enabled = (lblProposalId.Text) > 0
                RadWizard1.WizardSteps(5).Enabled = (lblProposalId.Text) > 0
                RadWizard1.WizardSteps(6).Enabled = (lblProposalId.Text) > 0

            Case "Fees"
                FormViewTC.DataBind()

            Case "TC"
                If FormViewTC.CurrentMode = FormViewMode.Edit Then
                    FormViewTC.UpdateItem(True)
                    FormViewTC.ChangeMode(FormViewMode.ReadOnly)
                End If
                HideTCtoolbar()
                RadGridAzureuploads.DataBind()

            Case "Payment"
                RadGridPS.DataBind()

            Case "RadWizardStepAttachments"
                RadGridAzureuploads.DataBind()

        End Select
    End Sub

    Private Sub RadWizard1_PreviousButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.PreviousButtonClick

        Select Case e.CurrentStep.ID
            Case "RadWizardStepProposal"
                ReadClientInfo_Step0()

            Case "Fees"
                ReadProposal(lblProposalId.Text)

            Case "TC"
                RadGridFees.DataBind()

            Case "Payment"
                FormViewTC.DataBind()

            Case "RadWizardStepAttachments"
                RadGridPS.DataBind()

            Case "Preview"
                RadGridAzureuploads.DataBind()

        End Select

    End Sub

    Private Sub RadWizard1_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.FinishButtonClick
        If lblProposalId.Text > 0 Then
            Response.Redirect("~/adm/proposal.aspx?proposalId=" & lblProposalId.Text)
        End If

    End Sub
#End Region

#Region "Client_Step0"

    Private Sub RefreshClientControls()
        cboClients.Items.Clear()
        cboClients.Items.Insert(0, New RadComboBoxItem("(Select Pre-Project...)", -1))
        SqlDataSourceProposalClient.DataBind()
        cboClients.DataBind()
        cboClients.SelectedValue = lblClientId.Text
        RadWizard1.WizardSteps(1).Enabled = (lblClientId.Text) > 0
    End Sub

    Private Sub SqlDataSourceProposalClient_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceProposalClient.Updated
        lblClientId.Text = e.Command.Parameters("@Id_OUT").Value.ToString
        If cboClients.SelectedValue = "-1" Then
            RefreshClientControls()
        End If
    End Sub

    Private Sub SqlDataSourceProposalClient_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceProposalClient.Updating
        Dim e1 As String = e.Command.Parameters(1).Value
    End Sub
    Protected Sub cboClients_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboClients.SelectedIndexChanged
        lblClientId.Text = cboClients.SelectedValue
        ReadClientInfo_Step0()
    End Sub

    Private Sub ReadClientInfo_Step0()
        Dim clientId As Integer = cboClients.SelectedValue
        If clientId > 0 Then
            Dim ClientObject = LocalAPI.GetRecord(clientId, "CLIENT_FROM_SELECT")

            txtClientName.Text = ClientObject("Name")
            txtClientEmail.Text = LCase(ClientObject("Email"))
            txtClientPhone.Text = ClientObject("Phone")
            txtClientAddress.Text = ClientObject("Address")
            txtClientCity.Text = ClientObject("City")
            txtClientState.Text = ClientObject("State")
            txtClientZipCode.Text = ClientObject("ZipCode")
            txtClientCompany.Text = ClientObject("Company")
            cboClientType.SelectedValue = ClientObject("Type")
        End If
        lblMsg.Text = ""
    End Sub
#End Region

#Region "Proposal_Step1"

    Private Sub ReadProposal(proposalId As Integer)
        If proposalId > 0 Then
            Dim ProposalObject = LocalAPI.GetRecord(proposalId, "PROPOSAL_FROM_SELECT")

            ' Step 0
            lblClientId.Text = ProposalObject("ClientId")
            If lblClientId.Text <> cboClients.SelectedValue Then
                cboClients.SelectedValue = lblClientId.Text
                ReadClientInfo_Step0()
            End If

            ' Step 1
            txtProposalName.Text = ProposalObject("ProjectName")
            txtProjectAddressLine.Text = ProposalObject("ProjectLocation")
            cboType.SelectedValue = ProposalObject("Type")
            If Len(ProposalObject("ProjectType")) > 0 Then
                cboProjectType.SelectedValue = ProposalObject("ProjectType")
            End If
            cboDepartment.SelectedValue = ProposalObject("DepartmentId")
            cboRetainer.SelectedValue = IIf(ProposalObject("Retainer"), 1, 0)
            txtUnit.DbValue = ProposalObject("Unit")
            cboMeasure.SelectedValue = ProposalObject("Measure")
            cboSector.SelectedValue = ProposalObject("ProjectSector")
            cboUse.DataBind()
            cboUse.SelectedValue = ProposalObject("ProjectUse")
            cboUse2.Text = ProposalObject("ProjectUse2")
            If ProposalObject("EmployeeAprovedId") > 0 Then cboEmployee.SelectedValue = ProposalObject("EmployeeAprovedId")
            TextBoxOwner.Text = ProposalObject("Owner")
            If ProposalObject("ProjectManagerId") > 0 Then cboProjectManagerId.SelectedValue = ProposalObject("ProjectManagerId")

            chkLumpSum.Checked = IIf(ProposalObject("ProjectSector") = 0, False, True)
        End If
    End Sub
#End Region

#Region "Fees_Step2"

    Private Sub btnNewFeeOk_Click(sender As Object, e As EventArgs) Handles btnNewFeeOk.Click
        Response.Redirect("~/adm/proposaltask.aspx?proposalId=" & lblProposalId.Text & "&fromwizard=1")
    End Sub

    Private Sub RadGridFees_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridFees.ItemCommand
        Select Case e.CommandName
            Case "EditTask"
                Response.Redirect("~/adm/proposaltask.aspx?proposalId=" & lblProposalId.Text & "&detailId=" & e.CommandArgument & "&fromwizard=1")
            Case "OrderDown"
                LocalAPI.ProposalDetail_OrderBy_UPDATE(e.CommandArgument, 1)
                RadGridFees.DataBind()
            Case "OrderUp"
                LocalAPI.ProposalDetail_OrderBy_UPDATE(e.CommandArgument, -1)
                RadGridFees.DataBind()

            Case "DetailDuplicate"
                lblDetailSelectedId.Text = e.CommandArgument
                SqlDataSourceProposaldDetailDuplicate.Insert()
                RadGridFees.DataBind()
        End Select

    End Sub

#End Region

#Region "Term_Conditions_Step5"
    Protected Sub btnEditTC_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEditTC.Click
        divBtnTC.Visible = False
        divFormTC.Visible = True
        FormViewTC.ChangeMode(FormViewMode.Edit)
    End Sub
    Protected Sub btnTCUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnTCUpdate.Click
        FormViewTC.UpdateItem(True)
        HideTCtoolbar()
    End Sub
    Protected Sub btnCloseTC_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCloseTC.Click
        HideTCtoolbar()
    End Sub

    Private Sub cboTandCtemplates_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboTandCtemplates.SelectedIndexChanged
        SqlDataSourceTandCtemplates.Update()
        HideTCtoolbar()
        FormViewTC.DataBind()
    End Sub

    Private Sub HideTCtoolbar()
        FormViewTC.ChangeMode(FormViewMode.ReadOnly)
        cboTandCtemplates.SelectedValue = -1
        divFormTC.Visible = False
        divBtnTC.Visible = True
    End Sub

#End Region

#Region "PaymentSchedule_Step6"
    Private Sub cboRetainer_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboRetainer.SelectedIndexChanged
        If cboRetainer.SelectedValue <> -1 Then
            LocalAPI.SetProposalRetainer(lblProposalId.Text, cboRetainer.SelectedValue)
        End If
    End Sub

    Private Sub btnUpdatePS_Click(sender As Object, e As EventArgs) Handles btnUpdatePS.Click
        ' New code 6-3-2020
        SqlDataSourcePS.Update()
        RadGridPS.DataBind()
    End Sub

#End Region


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
                e.IsValid = LocalAPI.ProposalAzureStorage_Insert(lblProposalId.Text, CType(sender.NamingContainer.FindControl("cboDocType"), RadComboBox).SelectedValue, e.FileInfo.OriginalFileName, newName, CType(sender.NamingContainer.FindControl("chkPublic"), RadCheckBox).Checked, e.FileInfo.ContentLength, e.FileInfo.ContentType, lblCompanyId.Text)
                If e.IsValid Then
                    RadGridAzureuploads.DataBind()
                    Master.InfoMessage(e.FileInfo.OriginalFileName & " uploaded")
                Else
                    Master.ErrorMessage("The file " & e.FileInfo.OriginalFileName & " has been previously loaded!")
                End If
            Else
                Master.ErrorMessage("You do not have hired the module Upload files")
            End If
        Catch ex As Exception
            e.IsValid = False
            lblMsg.Text = "Error. " & ex.Message
        End Try
    End Sub

    Private Sub SqlDataSourceTandCtemplates_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceTandCtemplates.Updating
        Dim E1 As String = e.Command.Parameters(0).Value
    End Sub

#End Region

#Region "Finish_Step8"

#End Region
    Protected Sub btnSend_Click(sender As Object, e As EventArgs) Handles btnSend.Click
        Response.RedirectPermanent("~/ADM/SendProposal.aspx?ProposalId=" & lblProposalId.Text & "&backpage=proposalnewwizard")
    End Sub

    Private Sub SqlDataSourceAzureFiles_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAzureFiles.Deleting
        Dim KeyName As String = LocalAPI.GetAzureFileKeyName(e.Command.Parameters("@Id").Value)
        AzureStorageApi.DeleteFile(KeyName, lblCompanyId.Text)
    End Sub

    Private Sub SqlDataSourceProposal_Step1_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceProposal_Step1.Updating
        Dim e1 As String = e.Command.Parameters("@ProjectSector").Value
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/proposals.aspx")
    End Sub

    Private Sub SqlDataSourcePS_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourcePS.Updating
        'cboPaymentSchedules.SelectedValue
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub

    Private Sub RadGridFees_PreRender(sender As Object, e As EventArgs) Handles RadGridFees.PreRender
        If lblCompanyId.Text = 260962 Then
            ' 6/9/2020 Fernando y Raissa ddefinen que no es visible en EEG
            RadGridFees.MasterTableView.GetColumn("Estimated").Visible = False
        End If

    End Sub
End Class
