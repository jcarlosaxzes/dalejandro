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

                    ReadPaymentSchedule()

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

                For i = RadWizard1.ActiveStepIndex + 1 To RadWizard1.WizardSteps.Count - 1
                    RadWizard1.WizardSteps(i).Enabled = False
                Next

                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". New Proposal"
                Master.PageTitle = "Proposals/New Proposal"
                'Master.Help = "http://blog.pasconcept.com/2012/04/fee-proposal-edit-proposal-page.html"

            End If
            RadWindowManagerJob.EnableViewState = False
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub ReadPaymentSchedule()
        cboPaymentSchedules.DataBind()

        ' General PS or PS by individual Services Fee(s)
        Dim GeneralPs = LocalAPI.IsGeneralPS(lblProposalId.Text)

        If GeneralPs Then
            ' General PS
            cboPaymentSchedules.SelectedValue = LocalAPI.GetProposalProperty(lblProposalId.Text, "paymentscheduleId")
        Else
            ' PS by individual Services Fee
            cboPaymentSchedules.SelectedValue = -1
        End If

        RadGridPS.DataBind()
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
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub ProposalItemsDataBind()
        If lblProposalId.Text > "0" Then

            ReadProposal(lblProposalId.Text)

            SqlDataSourceProposal_Step1.DataBind()

            RadGridFees.DataBind()

            RefreshRatios()

            FormViewTC.DataBind()

            RadGridPS.DataBind()

            RadGridAzureuploads.DataBind()

            iframeViewProposal.Src = LocalAPI.GetSharedLink_URL(111, lblProposalId.Text) & "&IsReadOnly=1&FromWizard=1"

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
                e.NextStep.Enabled = True
                SqlDataSourceProposalClient.Update()

                RadWizard1.WizardSteps(1).Enabled = (cboClients.SelectedValue) > 0

            Case "RadWizardStepProposal"
                e.NextStep.Enabled = True
                If lblProposalId.Text = "0" Then

                    NewProposal()

                Else
                    ' UPDATE PROPOSAL
                    SqlDataSourceProposal_Step1.Update()
                    RefreshRatios()
                End If

                'RadWizard1.WizardSteps(2).Enabled = (lblProposalId.Text) > 0
                'RadWizard1.WizardSteps(3).Enabled = (lblProposalId.Text) > 0
                'RadWizard1.WizardSteps(4).Enabled = (lblProposalId.Text) > 0
                'RadWizard1.WizardSteps(5).Enabled = (lblProposalId.Text) > 0
                'RadWizard1.WizardSteps(6).Enabled = (lblProposalId.Text) > 0

            Case "RadWizardStepFees"
                e.NextStep.Enabled = True
                FormViewTC.DataBind()

            Case "TC"
                e.NextStep.Enabled = True
                If FormViewTC.CurrentMode = FormViewMode.Edit Then
                    FormViewTC.UpdateItem(True)
                    FormViewTC.ChangeMode(FormViewMode.ReadOnly)
                End If
                HideTCtoolbar()
                RadGridAzureuploads.DataBind()

                TotalsAnalisis()

            Case "Payment"

                e.NextStep.Enabled = True
                RadGridPS.DataBind()

            Case "RadWizardStepAttachments"
                e.NextStep.Enabled = True
                RadGridAzureuploads.DataBind()

        End Select

        For i = RadWizard1.ActiveStepIndex + 1 To RadWizard1.WizardSteps.Count - 1
            RadWizard1.WizardSteps(i).Enabled = False
        Next

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
        If cboClients.SelectedValue <= 0 Then
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
            lblProposalNumber.Text = ProposalObject("ProposalNumber")
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
            cboMeasure.DataBind()
            cboMeasure.SelectedValue = ProposalObject("Measure")
            cboSector.SelectedValue = ProposalObject("ProjectSector")
            cboUse.DataBind()
            cboUse.SelectedValue = ProposalObject("ProjectUse")
            cboUse2.Text = ProposalObject("ProjectUse2")
            If ProposalObject("EmployeeAprovedId") > 0 Then cboEmployee.SelectedValue = ProposalObject("EmployeeAprovedId")
            TextBoxOwner.Text = ProposalObject("Owner")
            If ProposalObject("ProjectManagerId") > 0 Then cboProjectManagerId.SelectedValue = ProposalObject("ProjectManagerId")

            chkLumpSum.Checked = IIf(ProposalObject("LumpSum") = 0, False, True)
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
        RadGridFees.DataBind()
        TotalsAnalisis()
        SqlDataSourceProposal_Step1.Update()
        RefreshRatios()
    End Sub

    Private Sub TotalsAnalisis()
        Dim bTotal As Double = LocalAPI.GetProposalTotal(lblProposalId.Text)
        Dim bPSTotal As Double = LocalAPI.GetProposalPSTotal(lblProposalId.Text)
        lblProposalTotal.Text = FormatCurrency(bTotal)
        lblScheduleTotal.Text = FormatCurrency(bPSTotal)
        If bTotal = 0 Then
            lblTotalAlert.Text = "It is mandatory that [Proposal Total] is greater than zero !"
            RadWizard1.DisplayNavigationButtons = False
        Else
            If bPSTotal > 0 And (Math.Round(bTotal, 0) <> Math.Round(bPSTotal, 0)) Then
                lblTotalAlert.Text = "It Is mandatory that [Proposal Total] = [Payment Schedule Total] ! "
                RadWizard1.DisplayNavigationButtons = False
            Else
                lblTotalAlert.Text = ""
                RadWizard1.DisplayNavigationButtons = True
            End If
        End If

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
                AzureStorageApi.DeleteFile(tempName)
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
        AzureStorageApi.DeleteFile(KeyName)
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

    Private Sub chkLumpSum_Click(sender As Object, e As EventArgs) Handles chkLumpSum.Click
        LocalAPI.SetProposalLumpSum(lblProposalId.Text, IIf(chkLumpSum.Checked, 1, 0))
    End Sub

    Private Sub btnRefreshRatios_Click(sender As Object, e As EventArgs) Handles btnRefreshRatios.Click
        RefreshRatios()
    End Sub
    Private Sub RefreshRatios()
        RadGridRatios.DataBind()
        '!!!RadHtmlChartRatios.DataBind()
        lblMeasureAndUnits.Text = cboProjectType.Text & ": " & IIf(txtUnit.Text > 0, FormatNumber(txtUnit.Text, 2), "(Units Pending!)") & " " & IIf(Len(cboMeasure.Text) > 0, cboMeasure.Text, "(Measure Pending!)")
        CalculateFromRatio(txtRatio.DbValue, txtRatio.Label)
    End Sub
    Private Sub SqlDataSourceRatios_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceRatios.Selecting
        If cboClientRatios.SelectedValue = 0 Then
            e.Command.Parameters("@clientId").Value = cboClients.SelectedValue
        Else
            e.Command.Parameters("@clientId").Value = -1
        End If
        If cboDatesRates.SelectedValue = 0 Then
            ' Last 3 years
            e.Command.Parameters("@DateFrom").Value = "1-1-2000"
        Else
            e.Command.Parameters("@DateFrom").Value = DateAdd(DateInterval.Year, -3, Today)
        End If
        e.Command.Parameters("@DateTo").Value = "12-31-" & Year(Today)
    End Sub

    Private Sub CalculateFromRatio(Value As Double, Text As String)
        Try
            txtRatio.DbValue = Value
            txtRatio.Label = Text
            txtEstimatedTotal.Text = FormatCurrency(txtRatio.DbValue * txtUnit.Text)
        Catch ex As Exception

        End Try
    End Sub
    Private Sub RadGridRatios_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridRatios.ItemCommand
        Select Case e.CommandName
            Case "EditJob"
                Dim sUrl = "~/ADM/Job_job.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True, True)

            Case "RemoveRow"
                lblExcludeJobsList.Text = lblExcludeJobsList.Text & IIf(Len(lblExcludeJobsList.Text) > 0, ",", "") & e.CommandArgument
                RadGridRatios.DataBind()
            Case "CosteByUnit"
                CalculateFromRatio(e.CommandArgument, "Cost By Unit: ")
            Case "AdjustedByUnit"
                CalculateFromRatio(e.CommandArgument, "Adjusted By Unit: ")
            Case "HourByUnit"
                CalculateFromRatio(e.CommandArgument, "Hours By Unit: ")
            Case "BudgetByUnit"
                CalculateFromRatio(e.CommandArgument, "Budget By Unit: ")
        End Select
    End Sub
    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean, bRefreshOnClose As Boolean)
        Try

            RadWindowManagerJob.Windows.Clear()
            Dim window1 As RadWindow = New RadWindow()
            window1.NavigateUrl = sUrl
            window1.VisibleOnPageLoad = True
            window1.VisibleStatusbar = False
            window1.ID = WindowsID
            If Maximize Then window1.InitialBehaviors = WindowBehaviors.Maximize
            window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
            window1.Width = Width
            window1.Height = Height
            window1.Modal = True
            window1.DestroyOnClose = True
            If bRefreshOnClose Then window1.OnClientClose = "OnClientClose"
            window1.ShowOnTopWhenMaximized = Maximize
            RadWindowManagerJob.Windows.Add(window1)
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub
End Class
