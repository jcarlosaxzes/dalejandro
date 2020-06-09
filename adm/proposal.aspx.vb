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

                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ProposalsList") Then Response.RedirectPermanent("~/ADM/Default.aspx")

                lblCompanyId.Text = Session("companyId")


                If LocalAPI.IsCompanyViolation(lblProposalId.Text, "Proposal", lblCompanyId.Text) Then Response.RedirectPermanent("~/ADM/Default.aspx")

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
                If Val(lblSelectedJobId.Text) = 0 Then lblSelectedJobId.Text = -1

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
                    btnBack.Visible = False
                End If



            End If
            'RadWindowDataProcessing.NavigateUrl = "~/ADM/DataProcessing.aspx?ProposalId=" & lblProposalId.Text
            'RadWindowManager2.EnableViewState = False
            RadWindowManager1.EnableViewState = False

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Private Sub EnabledProposal()
        Dim Allow_EditAcceptedProposal As Boolean = LocalAPI.GetEmployeePermission(Master.UserId, "Allow_EditAcceptedProposal")
        If Allow_EditAcceptedProposal Then
            btnUpdate1.Enabled = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewProposal")
            btnDeleteProposal.Enabled = btnUpdate1.Enabled
        Else
            btnUpdate1.Enabled = lblOriginalStatus.Text <> 4 And lblOriginalStatus.Text <> 2 ' diferente de Revised
            btnDeleteProposal.Enabled = lblOriginalStatus.Text <> 2 ' diferente de Acepted
        End If
        btnNewTask.Enabled = btnUpdate1.Enabled
        RadGrid1.AllowAutomaticUpdates = btnUpdate1.Enabled
        RadGrid1.AllowAutomaticDeletes = btnUpdate1.Enabled
        FormViewTC.Enabled = btnUpdate1.Enabled

        ' Otras acciones
        btnNewPhase.Enabled = btnUpdate1.Enabled
        RadGridPhases.AllowAutomaticUpdates = btnUpdate1.Enabled
        RadGridPhases.AllowAutomaticDeletes = btnUpdate1.Enabled

        RadGridPheseSchedule.AllowAutomaticUpdates = btnUpdate1.Enabled
        RadGridPheseSchedule.AllowAutomaticDeletes = btnUpdate1.Enabled


    End Sub

    Private Sub InitProposal()
        lblOriginalType.Text = LocalAPI.GetProposalData(lblProposalId.Text, "Proposal.Type")
        SqlDataSourceProposalType.DataBind()
        cboProposalType.DataBind()
        cboProposalType.SelectedValue = lblOriginalType.Text
    End Sub

    Private Sub GuardarProposal(bMsg As Boolean)
        Try
            Dim sMsg As String = "Proposal Successfully Updated"
            FormViewProp1.UpdateItem(False)
            If bMsg Then Master.InfoMessage(sMsg)
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try

    End Sub

    Protected Sub btnConfirmDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnConfirmDelete.Click
        LocalAPI.EliminarProposal(lblProposalId.Text)
        Response.Redirect("~/adm/proposals.aspx")
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

    Protected Sub btnUpdate1_Click(sender As Object, e As System.EventArgs) Handles btnUpdate1.Click
        GuardarProposal(True)
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
            Response.Redirect("~/adm/SendProposal.aspx?ProposalId=" & lblProposalId.Text & "&fromproposal=1")
        Else
            Master.InfoMessage("You Must Specify the Client and Update Proposal")
        End If

    End Sub

    'Protected Sub btnGeneratePaymentSchedules_Click(sender As Object, e As EventArgs)
    '    If CType(sender.NamingContainer.FindControl("cboPaymentSchedules"), RadComboBox).SelectedValue > 0 Then
    '        GuardarProposal(False)
    '        LocalAPI.Proposal_GeneratePaymentSchedules(lblId.Text, CType(sender.NamingContainer.FindControl("cboPaymentSchedules"), RadComboBox).SelectedValue)
    '        FormViewProp1.DataBind()
    '        CType(sender.NamingContainer.FindControl("RadWizardStepPaymentSchedules"), RadWizardStep).Active = True
    '        'CType(sender.NamingContainer.FindControl("RadMultiPage0"), RadMultiPage).SelectedIndex = 1
    '        Master.InfoMessage("Proposal Payment Schedules Successfully Updated")
    '    End If
    'End Sub

    Protected Sub cboProposalType_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboProposalType.SelectedIndexChanged
        btnModifyType.Enabled = (cboProposalType.SelectedValue <> lblOriginalType.Text)
    End Sub

    Protected Sub btnModifyType_Click(sender As Object, e As EventArgs) Handles btnModifyType.Click
        lblOriginalType.Text = cboProposalType.SelectedValue
        LocalAPI.ModifyProposalType(lblProposalId.Text, cboProposalType.SelectedValue, lblCompanyId.Text)
        Response.Redirect("~/adm/proposal.aspx?proposalId=" & lblProposalId.Text)
    End Sub

    Protected Sub SqlDataSourceProp1_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceProp1.Updating
        If Val(lblSelectedJobId.Text) > 0 Then
            e.Command.Parameters("@JobId").Value = lblSelectedJobId.Text
        Else
            If Val("" & LocalAPI.GetProposalData(lblProposalId.Text, "JobId")) > 0 Then
                e.Command.Parameters("@JobId").Value = LocalAPI.GetProposalData(lblProposalId.Text, "JobId")
            End If
        End If
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
        btnModifyJob.Enabled = False
    End Sub

    Private Sub RadGrid1_EditCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.EditCommand
        GuardarProposal(False)
    End Sub
    Protected Sub btnNewPhase_Click(sender As Object, e As EventArgs) Handles btnNewPhase.Click
        Response.Redirect("~/adm/newpropsalphase.aspx?Id=" & lblProposalId.Text)
    End Sub
    Protected Sub btnPivotPhases_Click(sender As Object, e As EventArgs) Handles btnPivotPhases.Click
        Response.Redirect("~/adm/proposalphases.aspx?Id=" & lblProposalId.Text)
    End Sub

    Protected Sub btnSchedule_Click(sender As Object, e As EventArgs) Handles btnSchedule.Click
        Response.Redirect("~/adm/proposalschedule.aspx?Id=" & lblProposalId.Text)
    End Sub

    Private Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Select Case e.CommandName
            Case "EditTask"
                Response.Redirect("~/adm/proposaltask.aspx?proposalId=" & lblProposalId.Text & "&detailId=" & e.CommandArgument)
            Case "DetailDuplicate"
                lblDetailSelectedId.Text = e.CommandArgument
                SqlDataSourceProposaldDetailDuplicate.Insert()
                RadGrid1.DataBind()
        End Select

    End Sub

    Private Sub RadGridPhases_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridPhases.ItemCommand
        Select Case e.CommandName
            Case "EditPhase"
                Response.Redirect("~/adm/editproposalphase.aspx?Id=" & e.CommandArgument)
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

    Protected Sub RadCloudUpload1_FileUploaded(sender As Object, e As Telerik.Web.UI.CloudFileUploadedEventArgs)
        Try
            If LocalAPI.IsAzureStorage(lblCompanyId.Text) Then
                Dim tempName = e.FileInfo.KeyName
                Dim fileExt = IO.Path.GetExtension(tempName)
                Dim newName = "Companies/" & lblCompanyId.Text & $"/{Guid.NewGuid().ToString()}" & fileExt
                AzureStorageApi.CopyFile(tempName, newName, lblCompanyId.Text)
                AzureStorageApi.DeleteFile(tempName, 0)

                ' The uploaded files need to be removed from the storage by the control after a certain time.
                e.IsValid = LocalAPI.ProposalAzureStorage_Insert(lblProposalId.Text, CType(sender.NamingContainer.FindControl("cboDocType"), RadComboBox).SelectedValue, e.FileInfo.OriginalFileName, newName, CType(sender.NamingContainer.FindControl("chkPublic"), RadCheckBox).Checked, e.FileInfo.ContentLength, e.FileInfo.ContentType)
                If e.IsValid Then
                    CType(sender.NamingContainer.FindControl("RadGridAzureFiles"), RadGrid).DataBind()
                    Master.InfoMessage(e.FileInfo.OriginalFileName & " uploaded")
                Else
                    Master.ErrorMessage("The file " & e.FileInfo.OriginalFileName & " has been previously loaded!")
                End If
            Else
                Master.ErrorMessage("You do not have hired the module Upload files")
            End If
        Catch ex As Exception
            e.IsValid = False
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
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
        Response.Redirect("~/adm/saveproposalas.aspx?ProposalId=" & lblProposalId.Text)
    End Sub
    Protected Sub btnSaveAsTemplate_Click(sender As Object, e As EventArgs) Handles btnSaveAsTemplate.Click
        Response.Redirect("~/adm/saveproposalastemplate.aspx?ProposalId=" & lblProposalId.Text)
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
        Dim KeyName As String = LocalAPI.GetClientProsalJobAzureFileKeyName(e.Command.Parameters("@Id").Value, e.Command.Parameters("@Source").Value)
        AzureStorageApi.DeleteFile(KeyName, lblCompanyId.Text)
    End Sub

    Private Sub RadGrid1_PreRender(sender As Object, e As EventArgs) Handles RadGrid1.PreRender
        RadGrid1.MasterTableView.GetColumn("phaseId").Display = IIf(LocalAPI.GetProposalPhasesCount(lblProposalId.Text) = 0, False, True)
        If lblCompanyId.Text = 260962 Then
            ' 6/9/2020 Fernando y Raissa ddefinen que no es visible en EEG
            RadGrid1.MasterTableView.GetColumn("Estimated").Visible = False
        End If
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/proposals.aspx?restoreFilter=true")
    End Sub
    Private Sub btnTotals_Click(sender As Object, e As EventArgs) Handles btnTotals.Click
        FormViewClientBalance.Visible = Not FormViewClientBalance.Visible
    End Sub

End Class

