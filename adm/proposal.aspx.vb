Imports Telerik.Web.UI
Public Class proposal
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Pendiente en Edit mode
        '<asp:HyperLink ID="hlkJobLabel" runat="server" NavigateUrl='<%# LocalAPI.urlProjectLocationGmap(Eval("ProjectLocation"))%>' ImageUrl="../Images/Toolbar/gmap.png" 
        '    ToolTip='<%# String.Concat("Click to view [", Eval("ProjectLocation"), "] in Google Maps")%>' Visible='<%# Len(Eval("ProjectLocation")) > 0%>' Target="_blank"></asp:HyperLink>
        Try

            If (Not Page.IsPostBack) Then

                lblProposalId.Text = Me.Request.QueryString("proposalId")
                lblProposalNumber.Text = LocalAPI.ProposalNumber(lblProposalId.Text)

                panelViewProposalPage.DataBind()

                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ProposalsList") Then Response.RedirectPermanent("~/adm/default.aspx")

                lblCompanyId.Text = Session("companyId")


                If LocalAPI.IsCompanyViolation(lblProposalId.Text, "Proposal", lblCompanyId.Text) Then Response.RedirectPermanent("~/adm/default.aspx")

                If Val(lblCompanyId.Text) = 0 Then
                    ' Link externo de EEG
                    lblCompanyId.Text = 260962
                End If
                InitProposal()
                lblClientId.Text = LocalAPI.GetProposalProperty(lblProposalId.Text, "ClientId")
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)

                Me.Title = "Edit Proposal " & LocalAPI.ProposalNumber(lblProposalId.Text)
                Master.PageTitle = Me.Title

                'Master.PageTitle = "Edit Proposal"
                'Master.Help = "http://blog.pasconcept.com/2012/04/fee-proposal-edit-proposal-page.html"

                ' Panel izquierdo
                lblOriginalStatus.Text = LocalAPI.GetProposalData(lblProposalId.Text, "statusId")
                cboStatus.SelectedValue = lblOriginalStatus.Text

                EnabledProposal()

                ' Panel de informacion superior derecho
                lblEmployeeName.Text = LocalAPI.GetProposalProperty(lblProposalId.Text, "EmployeeName")
                lblEmailDate.Text = Left(LocalAPI.GetProposalProperty(lblProposalId.Text, "EmailDate"), 16)
                lblSelectedJobId.Text = LocalAPI.GetProposalProperty(lblProposalId.Text, "JobId")
                ' error.... If Val(lblSelectedJobId.Text) = 0 Then lblSelectedJobId.Text = -1

                ' Datos de Acceptance
                Dim sFirmado As String = LocalAPI.GetProposalProperty(lblProposalId.Text, "AceptanceName")
                If Len(sFirmado) > 0 Then
                    lblAceptanceName.Text = "By: " & sFirmado
                Else
                    lblAceptanceName.Text = "Unsigned"
                End If

                RadBinaryImageAceptanceSignature.DataValue = LocalAPI.GetSignProposal(lblProposalId.Text)

                If Not Request.QueryString("HideMasterMenu") Is Nothing Then
                    Master.HideMasterMenu()
                End If


                If Not Request.QueryString("backpage") Is Nothing Then
                    Session("propsalbackpage") = Request.QueryString("backpage")
                End If

                ConfigUploadPanels()

                ' Phases
                If LocalAPI.GetCompanyPhasesCount(lblCompanyId.Text) = 0 Then
                    RadWizardStepPhases.CssClass = "wizardStepHidden"
                    RadWizardStepPhaseSchedule.CssClass = "wizardStepHidden"
                Else
                    If Not Request.QueryString("TabPhase") Is Nothing Then
                        RadWizardStepPhases.Active = True
                    End If
                End If

            End If
            'RadWindowDataProcessing.NavigateUrl = "~/ADM/DataProcessing.aspx?ProposalId=" & lblProposalId.Text
            'RadWindowManager2.EnableViewState = False
            RadWindowManager1.EnableViewState = False


            Dim RadWizard1 As RadWizard = CType(FormViewProp1.FindControl("RadWizard1"), RadWizard)
            Dim WStep As RadWizardStep = RadWizard1.WizardSteps(1)

            Dim TaskStep As RadWizardStep = RadWizard2.WizardSteps(0)
            Dim btnNewTask As LinkButton = CType(TaskStep.FindControl("btnNewTask"), LinkButton)

            If lblOriginalStatus.Text > 1 Then
                CType(WStep.FindControl("cboPaymentSchedules"), RadComboBox).Visible = False
                CType(WStep.FindControl("btnGeneratePaymentSchedules"), LinkButton).Visible = False
                btnNewTask.Visible = False
            Else
                CType(WStep.FindControl("cboPaymentSchedules"), RadComboBox).Visible = True
                CType(WStep.FindControl("btnGeneratePaymentSchedules"), LinkButton).Visible = True
                btnNewTask.Visible = True
            End If


        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Protected Sub ConfigUploadPanels()
        Dim ExistingFiles As Integer = LocalAPI.GetEntityAzureFilesCount(lblProposalId.Text, "Proposal")

        If ExistingFiles = 0 Then
            RadWizardStepUpload.Active = True
            PanelUpload.Visible = True
            RadListViewFiles.Visible = False
            RadGridFiles.Visible = False
        Else
            RadWizardStepFiles.Active = True
            PanelUpload.Visible = False
            RadListViewFiles.Visible = False
            RadGridFiles.Visible = Not RadListViewFiles.Visible
            RadGridFiles.DataBind()
            RadListViewFiles.DataBind()
        End If

        btnGridPage.Visible = Not RadListViewFiles.Visible
        btnTablePage.Visible = RadListViewFiles.Visible

        RadCloudUpload1.MaxFileSize = LocalAPI.GetCompanyMaxFileSizeForUpload(lblCompanyId.Text)
        lblMaxSize.Text = $"[Maximum upload size per file: {LocalAPI.FormatByteSize(RadCloudUpload1.MaxFileSize)}]"

    End Sub
    Private Sub EnabledProposal()

        ' If Proposal Acepted, special Permit to change
        btnUpdateStatus.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Allow_EditAcceptedProposal")

        btnUpdate1.Enabled = (lblOriginalStatus.Text <> 4 And lblOriginalStatus.Text <> 2) ' diferente de Revised
        btnDeleteProposal.Enabled = (lblOriginalStatus.Text <> 2) ' diferente de Acepted

        btnNewTask.Enabled = btnUpdate1.Enabled
        RadGrid1.AllowAutomaticUpdates = btnUpdate1.Enabled
        RadGrid1.AllowAutomaticDeletes = btnUpdate1.Enabled
        RadGridPhases.AllowAutomaticDeletes = btnUpdate1.Enabled

        FormViewTC.Enabled = btnUpdate1.Enabled

        ' Otras acciones
        btnNewPhase.Enabled = btnUpdate1.Enabled
        RadGridPhases.AllowAutomaticUpdates = btnUpdate1.Enabled
        RadGridPhases.AllowAutomaticDeletes = btnUpdate1.Enabled

        RadGridPheseSchedule.AllowAutomaticUpdates = btnUpdate1.Enabled
        RadGridPheseSchedule.AllowAutomaticDeletes = btnUpdate1.Enabled


    End Sub

    Private Sub InitProposal()
        Try
            lblOriginalType.Text = LocalAPI.GetProposalData(lblProposalId.Text, "Proposal.Type")
            SqlDataSourceProposalType.DataBind()
            cboProposalType.DataBind()
            cboProposalType.SelectedValue = lblOriginalType.Text
            TotalsAnalisis()
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Function TotalsAnalisis() As Boolean
        Try
            Dim dTotal As Double = LocalAPI.GetProposalTotal(lblProposalId.Text)
            Dim dPSTotal As Double = LocalAPI.GetProposalPSTotal(lblProposalId.Text)
            Dim RadWizard1 As RadWizard = CType(FormViewProp1.FindControl("RadWizard1"), RadWizard)

            Dim WStep As RadWizardStep = RadWizard1.WizardSteps(1)

            CType(WStep.FindControl("lblProposalTotal"), Label).Text = FormatCurrency(dTotal)
            CType(WStep.FindControl("lblScheduleTotal"), Label).Text = FormatCurrency(dPSTotal)

            If dTotal = 0 Then
                CType(WStep.FindControl("lblTotalAlert"), Label).Text = "Alert. The Project Total is zero !"
                Return False
            Else
                If dPSTotal > 0 And (Math.Round(dTotal, 0) <> Math.Round(dPSTotal, 0)) Then
                    CType(WStep.FindControl("lblTotalAlert"), Label).Text = $"Your Project Total ({dTotal}) and your Payment Schedule Total ({dPSTotal}) do not match !"
                    Return False
                Else
                    CType(WStep.FindControl("lblTotalAlert"), Label).Text = ""
                    Return True
                End If
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Function

    Private Sub GuardarProposal(bMsg As Boolean)
        Try
            Dim sMsg As String = "Proposal Successfully Updated"
            FormViewProp1.UpdateItem(False)
            If bMsg Then Master.InfoMessage(sMsg)
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try

    End Sub

    Public Function FormatSource(source As String)
        Return source.Replace("1.-", "").Replace("2.-", "").Replace("3.-", "")
    End Function


    Protected Sub btnConfirmDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnConfirmDelete.Click
        LocalAPI.EliminarProposal(lblProposalId.Text)
        Response.Redirect("~/adm/proposals.aspx?restoreFilter=true")
    End Sub

    Protected Sub btnCancelDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelDelete.Click
        OcultarConfirmDelete()
    End Sub

    Protected Sub btnUpdateTandCTemplate_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim cbo As RadComboBox = CType(sender.NamingContainer.FindControl("cboTandCtemplates"), RadComboBox)
            If cbo.SelectedValue > 0 Then
                Dim editor As RadEditor = CType(sender.NamingContainer.FindControl("radEditor_TandC"), RadEditor)
                editor.Content = LocalAPI.GetProposalTemplateDescription(Val("" & cbo.SelectedValue))
            End If
            Master.InfoMessage("Proposal Template Successfully Updated")
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub
    Protected Sub cboTandCtemplates_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Try
            Dim cbo As RadComboBox = CType(sender.NamingContainer.FindControl("cboTandCtemplates"), RadComboBox)
            Dim editor As RadEditor = CType(sender.NamingContainer.FindControl("radEditor_TandC"), RadEditor)
            editor.Content = LocalAPI.GetProposalTemplateDescription(Val("" & cbo.SelectedValue))
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnUpdate1_Click(sender As Object, e As System.EventArgs) Handles btnUpdate1.Click
        If TotalsAnalisis() Then
            GuardarProposal(True)
        Else
            GuardarProposal(True)
            Dim RadWizard1 As RadWizard = CType(FormViewProp1.FindControl("RadWizard1"), RadWizard)
            Dim WStep As RadWizardStep = RadWizard1.WizardSteps(1)
            WStep.Active = True
        End If

    End Sub

    Protected Sub btnDeleteProposal_Click(sender As Object, e As System.EventArgs) Handles btnDeleteProposal.Click
        MostrarConfirmDelete()
    End Sub

    Private Sub MostrarConfirmDelete()
        RadToolTipDelete.Visible = True
        RadToolTipDelete.Show()
    End Sub

    Private Sub OcultarConfirmDelete()
        RadToolTipDelete.Visible = False
    End Sub

    Protected Sub btnPrintProposal_Click(sender As Object, e As EventArgs) Handles btnPrintProposal.Click
        If LocalAPI.GetProposalProperty(lblProposalId.Text, "ClientId") > 0 Then
            Response.Redirect("~/adm/SendProposal.aspx?ProposalId=" & lblProposalId.Text & "&backpage=proposal&HideMasterMenu=1")
        Else
            Master.InfoMessage("You Must Specify the Client and Update Proposal")
        End If

    End Sub

    Protected Sub btnPdf_Click(sender As Object, e As EventArgs) Handles btnPdf.Click
        Dim ProposalUrl = LocalAPI.GetSharedLink_URL(11, lblProposalId.Text)
        Session("PrintUrl") = ProposalUrl
        Session("PrintName") = "Proposal_" & LocalAPI.ProposalNumber(lblProposalId.Text) & ".pdf"
        Response.Redirect("~/ADM/pdf_print.aspx")
    End Sub

    Protected Sub btnGeneratePaymentSchedules_Click(sender As Object, e As EventArgs)
        Dim cboPayment = CType(sender.NamingContainer.FindControl("cboPaymentSchedules"), RadComboBox)
        If cboPayment.SelectedValue > 0 Then
            lblPaymentSchedules.Text = cboPayment.SelectedValue
            GuardarProposal(False)
            SqlDataSourceProposalPSUpdate.Update()
            FormViewProp1.DataBind()

            'Update Fees List
            Dim TaskStep As RadWizardStep = RadWizard2.WizardSteps(0)
            Dim RadGrid1 As RadGrid = CType(TaskStep.FindControl("RadGrid1"), RadGrid)
            RadGrid1.DataBind()

            'Show Step Payment Schedule
            Dim RadWizard1 As RadWizard = CType(FormViewProp1.FindControl("RadWizard1"), RadWizard)
            Dim WStep As RadWizardStep = RadWizard1.WizardSteps(1)
            WStep.Active = True

            Master.InfoMessage("Proposal Payment Schedules Successfully Updated")
        End If
    End Sub

    Protected Sub cboProposalType_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboProposalType.SelectedIndexChanged
        btnModifyType.Enabled = (cboProposalType.SelectedValue <> lblOriginalType.Text)
    End Sub

    Protected Sub btnModifyType_Click(sender As Object, e As EventArgs) Handles btnModifyType.Click
        lblOriginalType.Text = cboProposalType.SelectedValue
        LocalAPI.ModifyProposalType(lblProposalId.Text, cboProposalType.SelectedValue, lblCompanyId.Text)
        Response.Redirect("~/adm/proposal.aspx?proposalId=" & lblProposalId.Text)
    End Sub

    Protected Sub SqlDataSourceProp1_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceProp1.Updating
        'Allow unlink Job from Proposal
        'If Val(lblSelectedJobId.Text) > 0 Then
        e.Command.Parameters("@JobId").Value = Val(lblSelectedJobId.Text)
        'Else
        '    If Val("" & LocalAPI.GetProposalData(lblProposalId.Text, "JobId")) > 0 Then
        '        e.Command.Parameters("@JobId").Value = LocalAPI.GetProposalData(lblProposalId.Text, "JobId")
        '    End If
        'End If
    End Sub

    Protected Sub SqlDataSourceProp1_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceProp1.Updated
        lblOriginalStatus.Text = LocalAPI.GetProposalData(lblProposalId.Text, "statusId")
        cboStatus.SelectedValue = lblOriginalStatus.Text
    End Sub

    Protected Sub cboJobs_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboJobs.SelectedIndexChanged
        btnModifyJob.Enabled = True
    End Sub

    Protected Sub FormViewProp1_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormViewProp1.ItemUpdated
        Try

            SqlDataSourceJob.DataBind()
            cboJobs.DataBind()
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)

        End Try
    End Sub

    Protected Sub btnModifyJob_Click(sender As Object, e As EventArgs) Handles btnModifyJob.Click
        lblSelectedJobId.Text = cboJobs.SelectedValue
        'PanelJobAsociado()
        GuardarProposal(True)
        'btnModifyJob.Enabled = False
    End Sub

    Private Sub RadGrid1_EditCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.EditCommand
        GuardarProposal(False)
    End Sub
    Protected Sub btnNewPhase_Click(sender As Object, e As EventArgs) Handles btnNewPhase.Click
        Response.Redirect($"~/adm/proposalphase.aspx?proposalId={lblProposalId.Text}&backpage=proposal")
    End Sub
    Protected Sub btnPivotPhases_Click(sender As Object, e As EventArgs) Handles btnPivotPhases.Click
        Response.Redirect("~/adm/proposalpivotphases.aspx?proposalId=" & lblProposalId.Text)
    End Sub

    Protected Sub btnSchedule_Click(sender As Object, e As EventArgs) Handles btnSchedule.Click
        Response.Redirect("~/adm/proposalschedule.aspx?Id=" & lblProposalId.Text)
    End Sub

    Private Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim statusId As String = LocalAPI.GetProposalData(lblProposalId.Text, "statusId")
        Select Case e.CommandName
            Case "EditTask"
                Response.Redirect("~/adm/proposaltask.aspx?proposalId=" & lblProposalId.Text & "&detailId=" & e.CommandArgument)
            Case "DetailDuplicate"
                If cboStatus.SelectedValue <= 1 Then
                    lblDetailSelectedId.Text = e.CommandArgument
                    SqlDataSourceProposaldDetailDuplicate.Insert()
                    RadGrid1.DataBind()
                End If

            Case "OrderDown"
                If statusId <= 1 Then
                    LocalAPI.ProposalDetail_OrderBy_UPDATE(e.CommandArgument, 1)
                    RadGrid1.DataBind()
                End If
            Case "OrderUp"
                If statusId <= 1 Then
                    LocalAPI.ProposalDetail_OrderBy_UPDATE(e.CommandArgument, -1)
                    RadGrid1.DataBind()
                End If
        End Select

    End Sub

    Private Sub RadGridPhases_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridPhases.ItemCommand
        Select Case e.CommandName
            Case "EditPhase"
                Response.Redirect($"~/adm/proposalphase.aspx?Id={e.CommandArgument}&proposalId={lblProposalId.Text}&backpage=proposal")
        End Select

    End Sub

    Private Sub RadGridPheseSchedule_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridPheseSchedule.ItemCommand
        Select Case e.CommandName
            Case "Edit"
                lblPhaseSelectedId.Text = e.CommandArgument
        End Select
    End Sub

    Private Sub RadGridPheseSchedule_SelectedIndexChanged(sender As Object, e As EventArgs) Handles RadGridPheseSchedule.SelectedIndexChanged
        Dim e1 As String = RadGridPheseSchedule.SelectedValue
    End Sub



    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean, OnClientClose As String)
        RadWindowManager1.Windows.Clear()
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
        If Len(OnClientClose) > 0 Then window1.OnClientClose = OnClientClose
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Protected Sub btnSaveAs_Click(sender As Object, e As EventArgs) Handles btnSaveAs.Click
        Response.Redirect($"~/adm/proposal_save_copy.aspx?ProposalId={lblProposalId.Text}&backpage=proposal")
    End Sub
    Protected Sub btnSaveAsTemplate_Click(sender As Object, e As EventArgs) Handles btnSaveAsTemplate.Click
        Response.Redirect($"~/adm/proposal_save_as_template.aspx?ProposalId={lblProposalId.Text}&backpage=proposal")
    End Sub
    Protected Sub btnNewTask_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewTask.Click
        Try
            GuardarProposal(False)
            'CreateRadWindows("Form", "~/ADM/NewProposalTask.aspx?Id=" & lblProposalId.Text, 1024, 768, False, "OnClientClose")
            Response.Redirect("~/adm/proposaltask.aspx?proposalId=" & lblProposalId.Text)
        Catch ex As Exception
        End Try
    End Sub

    Private Sub cboStatus_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboStatus.SelectedIndexChanged
        btnUpdateStatus.Enabled = (cboStatus.SelectedValue <> lblOriginalStatus.Text)
    End Sub

    Private Sub btnUpdateStatus_Click(sender As Object, e As EventArgs) Handles btnUpdateStatus.Click
        If cboStatus.SelectedValue <> lblOriginalStatus.Text Then
            Select Case cboStatus.SelectedValue

                Case 0, 1 ' Not Emitted and Pending
                    LocalAPI.SetProposalStatus(lblProposalId.Text, cboStatus.SelectedValue)
                    lblOriginalStatus.Text = cboStatus.SelectedValue

                Case 2  ' Acepted
                    If (lblOriginalStatus.Text = 0 Or lblOriginalStatus.Text = 1) Then
                        LocalAPI.ProposalStatus2Acept(lblProposalId.Text, lblCompanyId.Text)
                        lblOriginalStatus.Text = cboStatus.SelectedValue
                    End If

                Case 3, 31, 32  ' Declined
                    LocalAPI.ProposalStatus2Declined(lblProposalId.Text, lblCompanyId.Text, cboStatus.SelectedValue)
                    lblOriginalStatus.Text = cboStatus.SelectedValue

                Case 4  ' Hold
                    LocalAPI.ProposalStatus2Hold(lblProposalId.Text)
                    lblOriginalStatus.Text = cboStatus.SelectedValue

            End Select

            btnUpdateStatus.Enabled = (cboStatus.SelectedValue <> lblOriginalStatus.Text)
            FormViewProp1.DataBind()
        End If

    End Sub

    Private Sub SqlDataSourceAzureFiles_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAzureFiles.Deleting
        Dim KeyName As String = LocalAPI.GetAzureFileKeyName(e.Command.Parameters("@Id").Value)
        AzureStorageApi.DeleteFile(KeyName)
    End Sub

    Private Sub RadGrid1_PreRender(sender As Object, e As EventArgs) Handles RadGrid1.PreRender
        RadGrid1.MasterTableView.GetColumn("phaseId").Display = IIf(LocalAPI.GetProposalPhasesCount(lblProposalId.Text) = 0, False, True)
        If lblCompanyId.Text = 260962 Then
            ' 6/9/2020 Fernando y Raissa ddefinen que no es visible en EEG
            RadGrid1.MasterTableView.GetColumn("Estimated").Visible = False
        End If
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Select Case Session("propsalbackpage")
            Case "job_proposals"
                Dim sUrl As String = LocalAPI.GetSharedLink_URL(8001, lblSelectedJobId.Text)
                Response.Redirect(sUrl)

            Case Else
                Response.Redirect("~/adm/proposals.aspx?restoreFilter=true")
        End Select

    End Sub
    Private Sub btnTotals_Click(sender As Object, e As EventArgs) Handles btnTotals.Click
        FormViewClientBalance.Visible = Not FormViewClientBalance.Visible
    End Sub


    Protected Sub btnUploadFiles_Click(sender As Object, e As EventArgs)
        RadWizardFiles.ActiveStepIndex = 0
        PanelUpload.Visible = True
    End Sub

    Protected Sub btnListFiles_Click(sender As Object, e As EventArgs)
        RadWizardFiles.ActiveStepIndex = 1
        PanelUpload.Visible = False
    End Sub

#Region "Bulk Delete"

    Private Sub btnBulkDelete_Click(sender As Object, e As EventArgs) Handles btnBulkDelete.Click
        lblSelectedId.Text = ""
        If RadListViewFiles.Visible Then
            If RadListViewFiles.SelectedItems.Count > 0 Then
                RadToolTipBulkDelete.Visible = True
                RadToolTipBulkDelete.Show()
            Else
                Master.ErrorMessage("Select (Mark) Files to Delete")
            End If
        Else
            If RadGridFiles.SelectedItems.Count > 0 Then
                RadToolTipBulkDelete.Visible = True
                RadToolTipBulkDelete.Show()
            Else
                Master.ErrorMessage("Select (Mark) Files to Delete")
            End If
        End If
    End Sub
    Protected Sub btnConfirmDeleteFiles_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnConfirmDeleteFiles.Click

        Try
            'get a reference to the row
            If String.IsNullOrEmpty(lblSelectedId.Text) Then
                If RadListViewFiles.Visible Then
                    If RadListViewFiles.SelectedItems.Count > 0 Then
                        For Each dataItem As RadListViewDataItem In RadListViewFiles.SelectedItems
                            If dataItem.Selected Then
                                Dim idFile = dataItem.GetDataKeyValue("Id").ToString()
                                Dim KeyName As String = LocalAPI.GetAzureFileKeyName(idFile)
                                LocalAPI.DeleteAzureFile(idFile)
                                AzureStorageApi.DeleteFile(KeyName)
                            End If
                        Next
                        RadListViewFiles.ClearSelectedItems()
                    Else
                        Master.ErrorMessage("Select records!")
                    End If
                Else
                    If RadGridFiles.SelectedItems.Count > 0 Then
                        For Each item As GridDataItem In RadGridFiles.SelectedItems
                            If item.Selected Then
                                item.Selected = False
                                Dim idFile = item("Id").Text
                                Dim KeyName As String = LocalAPI.GetAzureFileKeyName(idFile)
                                LocalAPI.DeleteAzureFile(idFile)
                                AzureStorageApi.DeleteFile(KeyName)
                            End If
                        Next
                    Else
                        Master.ErrorMessage("Select records!")
                    End If
                End If
            Else
                Dim KeyName As String = LocalAPI.GetAzureFileKeyName(lblSelectedId.Text)
                LocalAPI.DeleteAzureFile(lblSelectedId.Text)
                AzureStorageApi.DeleteFile(KeyName)
                lblSelectedId.Text = ""
            End If

            RadListViewFiles.DataBind()
            RadGridFiles.DataBind()

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnCancelDeleteFiles_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelDeleteFiles.Click
        RadToolTipBulkDelete.Visible = False
    End Sub

#End Region

#Region "Bulk Update"

    Private Sub btnBulkEdit_Click(sender As Object, e As EventArgs) Handles btnBulkEdit.Click
        lblSelectedId.Text = ""
        If RadListViewFiles.Visible Then
            If RadListViewFiles.SelectedItems.Count > 0 Then
                RadToolTipBulkEdit.Visible = True
                RadToolTipBulkEdit.Show()
            Else
                Master.ErrorMessage("Select (Mark) Files to Update")
            End If
        Else
            If RadGridFiles.SelectedItems.Count > 0 Then
                RadToolTipBulkEdit.Visible = True
                RadToolTipBulkEdit.Show()
            Else
                Master.ErrorMessage("Select (Mark) Files to Update")
            End If
        End If



    End Sub

    Private Sub btnUpdateStatusFiles_Click(sender As Object, e As EventArgs) Handles btnUpdateStatusFiles.Click

        If String.IsNullOrEmpty(lblSelectedId.Text) Then
            If RadListViewFiles.Visible Then
                RadListViewFiles.AllowMultiItemEdit = True
                For Each item As RadListViewDataItem In RadListViewFiles.SelectedItems
                    If item.Selected Then
                        item.Selected = False
                        Dim Id = item.OwnerListView.DataKeyValues(item.DisplayIndex)("Id").ToString()
                        Dim lblName As Label = CType(item.FindControl("lblFileName"), Label)
                        LocalAPI.UpdateAzureUploads(Id, cboDocTypeBulk.SelectedValue, lblName.Text, chkPublicBulk.Checked)
                    End If
                Next
            Else
                For Each item As GridDataItem In RadGridFiles.SelectedItems
                    If item.Selected Then
                        item.Selected = False
                        Dim Id = item("Id").Text
                        Dim lblName As Label = CType(item.FindControl("lblNameHide"), Label)
                        LocalAPI.UpdateAzureUploads(Id, cboDocTypeBulk.SelectedValue, lblName.Text, chkPublicBulk.Checked)
                    End If
                Next
            End If

        Else
            LocalAPI.UpdateAzureUploads(lblSelectedId.Text, cboDocTypeBulk.SelectedValue, lblSelectedName.Text, chkPublicBulk.Checked)
            lblSelectedId.Text = ""
        End If

        RadListViewFiles.DataBind()
        RadGridFiles.DataBind()
    End Sub


#End Region

    Public Sub RadCloudUpload1_FileUploaded(sender As Object, e As CloudFileUploadedEventArgs) Handles RadCloudUpload1.FileUploaded
        Try
            Dim tempName = e.FileInfo.KeyName
            Dim fileExt = IO.Path.GetExtension(tempName)
            Dim newName = "Companies/" & lblCompanyId.Text & $"/{Guid.NewGuid().ToString()}" & fileExt
            AzureStorageApi.CopyFile(tempName, newName, lblCompanyId.Text)
            AzureStorageApi.DeleteFile(tempName)

            ' The uploaded files need to be removed from the storage by the control after a certain time.
            e.IsValid = LocalAPI.AzureStorage_Insert(lblProposalId.Text, "Proposal", cboDocType.SelectedValue, e.FileInfo.OriginalFileName, newName, chkPublic.Checked, e.FileInfo.ContentLength, e.FileInfo.ContentType, lblCompanyId.Text)
            If e.IsValid Then
                'RadListViewFiles.ClearSelectedItems()
                'RadListViewFiles.DataBind()
                'RadGridFiles.DataBind()
                'RadWizardFiles.ActiveStepIndex = 1
                'PanelUpload.Visible = False
                'Master.InfoMessage(e.FileInfo.OriginalFileName & " uploaded")
            Else
                Master.ErrorMessage("The file " & e.FileInfo.OriginalFileName & " has been previously loaded!")
                AzureStorageApi.DeleteFile(newName)
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try

    End Sub

    Protected Sub RadGridFiles_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case e.CommandName
            Case "Update"
                lblSelectedId.Text = e.CommandArgument

                Dim item As GridDataItem = TryCast(e.Item, GridDataItem)

                lblSelectedId.Text = item.GetDataKeyValue("Id").ToString()
                lblSelectedName.Text = CType(item.FindControl("lblNameHide"), Label).Text
                Dim type As String = CType(item.FindControl("lblTypeHide"), Label).Text
                Dim spublic As String = CType(item.FindControl("lblPubicHide"), Label).Text

                RadToolTipBulkEdit.Visible = True
                RadToolTipBulkEdit.Show()
                CType(RadToolTipBulkEdit.FindControl("cboDocTypeBulk"), RadComboBox).SelectedValue = type
                CType(RadToolTipBulkEdit.FindControl("chkPublicBulk"), RadCheckBox).Checked = spublic
            Case "Delete"
                Dim item As GridDataItem = TryCast(e.Item, GridDataItem)
                lblSelectedId.Text = item.GetDataKeyValue("Id").ToString()
                RadToolTipBulkDelete.Visible = True
                RadToolTipBulkDelete.Show()
        End Select
    End Sub

    Private Sub RadListViewFiles_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles RadListViewFiles.ItemCommand

        Select Case e.CommandName
            Case "Update"
                Dim item As RadListViewDataItem = TryCast(e.ListViewItem, RadListViewDataItem)

                lblSelectedId.Text = item.GetDataKeyValue("Id").ToString()
                lblSelectedName.Text = CType(item.FindControl("lblNameHide"), Label).Text
                Dim type As String = CType(item.FindControl("lblTypeHide"), Label).Text
                Dim spublic As String = CType(item.FindControl("lblPubicHide"), Label).Text

                RadToolTipBulkEdit.Visible = True
                RadToolTipBulkEdit.Show()
                CType(RadToolTipBulkEdit.FindControl("cboDocTypeBulk"), RadComboBox).SelectedValue = type
                CType(RadToolTipBulkEdit.FindControl("chkPublicBulk"), RadCheckBox).Checked = spublic
        End Select
    End Sub

    Protected Sub btnTablePage_Click(sender As Object, e As EventArgs)
        RadListViewFiles.Visible = Not RadListViewFiles.Visible
        RadGridFiles.Visible = Not RadListViewFiles.Visible
        btnGridPage.Visible = Not RadListViewFiles.Visible
        btnTablePage.Visible = RadListViewFiles.Visible
    End Sub

    Private Sub btnSaveUpload_Click(sender As Object, e As EventArgs) Handles btnSaveUpload.Click
        ConfigUploadPanels()
    End Sub

    Private Sub FormViewProp1_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles FormViewProp1.ItemCommand
        Select Case e.CommandName
            Case "ViewJob"
                Dim sUrl As String = LocalAPI.GetSharedLink_URL(8001, e.CommandArgument)
                Response.Redirect(sUrl)

        End Select
    End Sub

    Protected Sub btnNewNote_Click(sender As Object, e As EventArgs) Handles btnNewNote.Click
        RadGridNotes.MasterTableView.InsertItem()
    End Sub
End Class

