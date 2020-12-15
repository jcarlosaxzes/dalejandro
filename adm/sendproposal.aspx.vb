Imports Telerik.Web.UI
Public Class sendproposal
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not Page.IsPostBack) Then
            txtBody.DisableFilter(EditorFilters.ConvertFontToSpan)  ' Evita un error de ConvertFontToSpan
            lblProposalId.Text = Request.QueryString("ProposalId")
            lblCompanyId.Text = LocalAPI.GetCompanyIdFromProposal(lblProposalId.Text)
            Me.Title = "Send Proposal: " & LocalAPI.ProposalNumber(lblProposalId.Text) & " - " & LocalAPI.GetProposalProperty(lblProposalId.Text, "ProjectName")
            cboProjectManagerId.DataBind()
            cboProjectManagerId.SelectedValue = LocalAPI.GetProposalData(lblProposalId.Text, "ProjectManagerId")

            If lblProposalId.Text > 0 Then

                lblClientId.Text = LocalAPI.GetProposalProperty(lblProposalId.Text, "clientId")

                PanelEmail.Visible = True
                PanelSMS.Visible = True
                txtTo.Text = LocalAPI.GetClientEmailFromProposal(lblProposalId.Text)
                txtCC.Text = Master.UserEmail
                LeerProposalTemplate()
                SMS_Init()
                Dim clientId As Integer = LocalAPI.GetProposalProperty(lblProposalId.Text, "ClientId")

                PanelAgile.Visible = (lblCompanyId.Text = 260962)

                cboNotification.SelectedValue = 1
                If Not LocalAPI.IsCompanySMSservice(lblCompanyId.Text) Then
                    cboNotification.Enabled = False
                End If
                cboRetainer.DataBind()
                If LocalAPI.GetProposalProperty(lblProposalId.Text, "Retainer") Then
                    cboRetainer.SelectedValue = 1
                End If

                TotalsAnalisis()

                If Not Request.QueryString("backpage") Is Nothing Then
                    lblBackSource.Text = Request.QueryString("backpage")
                End If
                If Not Request.QueryString("HideMasterMenu") Is Nothing Then
                    Master.HideMasterMenu()
                End If


            End If
        End If
    End Sub
    Private Sub TotalsAnalisis()
        Dim dTotal As Double = LocalAPI.GetProposalTotal(lblProposalId.Text)
        Dim dPSTotal As Double = LocalAPI.GetProposalPSTotal(lblProposalId.Text)

        If dTotal = 0 Then
            PanelTotals.Visible = True
            lblTotalAlert.Text = "Alert. The Project Total is zero !"
        Else
            If (Math.Round(dTotal, 0) <> Math.Round(dPSTotal, 0)) Then
                PanelTotals.Visible = True
                lblTotalAlert.Text = $"Your Project Total ({FormatCurrency(dTotal)}) and your Payment Schedule Total ({FormatCurrency(dPSTotal)}) do not match !"
            Else
                PanelTotals.Visible = False
            End If
        End If

        'lblProposalTotal.Text = FormatCurrency(bTotal)
        'lblScheduleTotal.Text = FormatCurrency(bPSTotal)
        'If bTotal = 0 Then
        '    lblTotalAlert.Text = "It is mandatory that [Proposal Total] is greater than zero !"
        '    RadWizard1.DisplayNavigationButtons = False
        'Else
        '    If bPSTotal > 0 And (Math.Round(bTotal, 0) <> Math.Round(bPSTotal, 0)) Then
        '        lblTotalAlert.Text = "It Is mandatory that [Proposal Total] = [Payment Schedule Total] ! "
        '        RadWizard1.DisplayNavigationButtons = False
        '    End If
        'End If

    End Sub
#Region "RadWizard Step Buttons"
    Private Sub RadWizard1_NextButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.NextButtonClick
        Select Case e.CurrentStep.ID
            Case "Confirmation"
                RadWizard1.WizardSteps(1).Enabled = True
                ' *********  Acciones relacionadas con todas las desiciones de Tab1 ******************

                '1.- Paneles visibles
                PanelEmail.Visible = (cboNotification.SelectedValue = 1 Or cboNotification.SelectedValue = 2)
                PanelSMS.Visible = (cboNotification.SelectedValue = 2 Or cboNotification.SelectedValue = 3)
                If Not PanelSMS.Visible Then
                    txtBody.Height = "400"
                End If

                '2.- Save ProjectManagerId
                LocalAPI.SetProposalProjectManagerId(lblProposalId.Text, cboProjectManagerId.SelectedValue)

                '3.- Retainer
                LocalAPI.SetProposalRetainer(lblProposalId.Text, cboRetainer.SelectedValue)
        End Select
    End Sub

    Private Sub RadWizard1_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.FinishButtonClick
        SendNotification()
    End Sub

#End Region


    Private Sub LeerProposalTemplate()
        Try
            ' Variables
            Dim sProjectName As String = LocalAPI.GetProposalData(lblProposalId.Text, "[ProjectName]")
            Dim sProjectType As String = LocalAPI.GetProposalData(lblProposalId.Text, "[Jobs_types].[Name]")
            Dim sClienteName = LocalAPI.GetProposalData(lblProposalId.Text, "[Clients].[Name]")
            Dim sClienteCompany = LocalAPI.GetProposalData(lblProposalId.Text, "[Clients].[Company]")
            Dim sCompanyName = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Name")
            Dim sSign As String = LocalAPI.GetEmployeesSign(cboProjectManagerId.SelectedValue)
            ' Enlace al Proposal
            'txtBody.Content = Replace(txtBody.Content, "[PASconceptLink]", LocalAPI.GetHostAppSite() & "/ADMCLI/AceptProposal.aspx?ProposalId=" & lblProposalId.Text)
            Dim sURL As String = LocalAPI.GetSharedLink_URL(1111, lblProposalId.Text)

            Dim DictValues As Dictionary(Of String, String) = New Dictionary(Of String, String)
            DictValues.Add("[Project_Name]", sProjectName)
            DictValues.Add("[Id]", lblProposalId.Text)
            DictValues.Add("[Project_Type]", sProjectType)
            DictValues.Add("[Client_Name]", sClienteName)
            DictValues.Add("[Client_Company]", sClienteCompany)
            DictValues.Add("[Company_Name]", sCompanyName)
            DictValues.Add("[Sign]", sSign)
            DictValues.Add("[PASconceptLink]", sURL)
            DictValues.Add("[PASSign]", LocalAPI.GetPASSign())

            ' Leer subjet y body template
            txtSubject.Text = LocalAPI.GetMessageTemplateSubject("Proposal", lblCompanyId.Text, DictValues)
            txtBody.Content = LocalAPI.GetMessageTemplateBody("Proposal", lblCompanyId.Text, DictValues)

        Catch ex As Exception
            ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub SendNotification()
        Dim bSendEmail As Boolean
        Dim bSendSMS As Boolean
        Dim sInfo As String = ""
        Try
            If cboNotification.SelectedValue = 1 Or cboNotification.SelectedValue = 2 Then

                If LocalAPI.ValidEmail(txtTo.Text) Then
                    txtBody.Content = txtBody.Content & LocalAPI.GetPASSign()
                    LocalAPI.ProposalStatus2Emitted(lblProposalId.Text)
                    Dim HeadDepartmentEmail As String = LocalAPI.GetHeadDepartmentEmailFromProposal(lblProposalId.Text)

                    Dim ProposalByName = LocalAPI.GetEmployeeName(cboProjectManagerId.SelectedValue)
                    'Dim ProposalByEmail = LocalAPI.GetEmployeeEmail(lId:=cboProjectManagerId.SelectedValue)

                    Dim ProjectManagerEmail As String = LocalAPI.GetEmployeeEmail(lId:=cboProjectManagerId.SelectedValue)
                    Dim ProposalObject = LocalAPI.GetRecord(lblProposalId.Text, "ProposalRecord_SELECT")
                    Dim ClientId = ProposalObject("ClientId")
                    If SendGrid.Email.SendMail(txtTo.Text, txtCC.Text, HeadDepartmentEmail, txtSubject.Text, txtBody.Content, lblCompanyId.Text, ClientId, 0, "", ProposalByName, ProjectManagerEmail, ProposalByName) Then
                        bSendEmail = True
                    Else
                        ErrorMessage("Proposal was not sent by Email. ")
                    End If
                Else
                    ErrorMessage("Invalid Email: '" & txtTo.Text & "' ")
                End If
            End If

            If cboNotification.SelectedValue = 2 Or cboNotification.SelectedValue = 3 Then
                If SendProposalSMS() Then
                    bSendSMS = True
                End If

            End If
            If PanelAgile.Visible Then
                If cboAgile.SelectedValue = 1 Then
                    LocalAPI.ProposalToAgile(lblProposalId.Text, lblCompanyId.Text)
                End If
            End If

            If Len(sInfo) > 0 Then InfoMessage(sInfo)


        Catch ex As Exception
            ErrorMessage("Email sending Error." & ex.Message)
        End Try
    End Sub

    Private Sub SMS_Init()
        If LocalAPI.IsCompanySMSservice(lblCompanyId.Text) Then
            Dim clientId As Integer = LocalAPI.GetProposalProperty(lblProposalId.Text, "ClientId")
            If Not LocalAPI.IsClientAllowSMS(clientId) Then
                txtCellular.Text = LocalAPI.GetClientProperty(clientId, "Cellular")
                'chkSMS.Checked = Len(txtCellular.Text) >= 10
                Dim ProjectName As String = LocalAPI.GetProposalProperty(lblProposalId.Text, "ProjectName")
                Dim sURL As String = LocalAPI.GetSharedLink_URL(11, lblProposalId.Text) & " "

                txtSMS.Text = "You have received a proposal from " & LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Name") & " click below to review/accept: " & vbCrLf & sURL


            End If
        End If
    End Sub

    Private Function SendProposalSMS() As Boolean
        Try

            Dim sCellPhone As String = txtCellular.Text
            If SMS.IsValidPhone(sCellPhone) Then
                If SMS.SendSMS(Master.UserId, sCellPhone, txtSMS.Text, lblCompanyId.Text) Then
                    Return True
                End If
            Else
                InfoMessage("SMS Error. Telephone format must be 10-digit number, eg.: 3058889999")
            End If
        Catch ex As Exception
            ErrorMessage("SMS Error. " & ex.Message)
        End Try
    End Function

    Private Sub ErrorMessage(ByVal sText As String, Optional ByVal SecondsAutoCloseDelay As Integer = 0)
        If sText.Length > 0 Then
            RadNotificationError.Title = "Error message"
            RadNotificationError.Text = sText
            RadNotificationError.AutoCloseDelay = 0
            RadNotificationError.Show()
        End If
    End Sub

    Private Sub InfoMessage(ByVal sText As String, Optional ByVal SecondsAutoCloseDelay As Integer = 3)
        If sText.Length > 0 Then
            'RadNotificationWarning.Title = Me.Title
            RadNotificationWarning.Text = sText
            RadNotificationWarning.AutoCloseDelay = 0
            RadNotificationWarning.Show()
        End If
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Select Case lblBackSource.Text
            Case "proposal"
                Response.RedirectPermanent("~/adm/proposal.aspx?proposalId=" & lblProposalId.Text)
            Case "job_proposals"
                Dim jobId As Integer = LocalAPI.GetProposalProperty(lblProposalId.Text, "JobId")
                Dim sUrl As String = LocalAPI.GetSharedLink_URL(8004, jobId)
                Response.Redirect(sUrl)

            Case "proposalnewwizard"
                Response.RedirectPermanent("~/adm/proposals.aspx?restoreFilter=true")
            Case Else
                Response.RedirectPermanent("~/adm/proposals.aspx?restoreFilter=true")
        End Select
    End Sub
End Class

