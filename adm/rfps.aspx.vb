Imports Telerik.Web.UI
Public Class rfps
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            lblCompanyId.Text = Session("companyId")
            Dim EmployeeId As Integer = Master.ValidateRequestMode
            If Not LocalAPI.GetEmployeePermission(EmployeeId, "Deny_RequestsProposalsList") Then Response.RedirectPermanent("~/adm/default.aspx")
            ' Si no tiene permiso New, boton.Visible=False
            btnNew.Visible = LocalAPI.GetEmployeePermission(EmployeeId, "Deny_NewRequestProposals")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Requests for Proposals"
            Master.Help = "http://blog.pasconcept.com/2012/07/subconsultants-rfp-responses-list.html"
            If Request.QueryString("BasicMP") Is Nothing Then
                Master.PageTitle = "Subconsultants/Requests for Proposals"
                Master.Help = "http://blog.pasconcept.com/2012/07/subconsultants-list.html"
            End If

            If Not Request.QueryString("Find") Is Nothing Then
                txtFind.Text = Request.QueryString("Find")
            End If

            cboPeriod.DataBind()
            cboPeriod.SelectedValue = LocalAPI.GetEmployeeProperty(EmployeeId, "FilterProposal_Month")
            IniciaPeriodo(cboPeriod.SelectedValue)


        End If
        'RadWindowManager1.EnableViewState = False
        If RadWindowManager1.Windows.Count > 0 Then
            RadWindowManager1.Windows.Clear()
        End If

    End Sub

    Private Sub IniciaPeriodo(nPeriodo As Integer)

        Select Case nPeriodo
            Case 13  ' All Years...
                RadDatePickerFrom.DbSelectedDate = "01/01/2000"
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

            Case 30, 60, 90, 120, 180, 365 '   days....
                RadDatePickerTo.DbSelectedDate = Date.Today
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Day, 0 - nPeriodo, RadDatePickerTo.DbSelectedDate)

            Case 14  ' This year...
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Date.Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Date.Today.Year
            Case 99 ' Custom

        End Select
        cboPeriod.SelectedValue = nPeriodo
    End Sub
    Private Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        IniciaPeriodo(cboPeriod.SelectedValue)
        RadTreeList1.DataBind()
    End Sub

    Private Sub RadTreeList1_ItemCommand(sender As Object, e As TreeListCommandEventArgs) Handles RadTreeList1.ItemCommand
        Dim sUrl As String = ""
        Try
            Select Case e.CommandName
                Case "Refresh"
                    RadTreeList1.DataBind()

                Case "NewRFPforProject"
                    Response.Redirect("~/adm/RFPNewWizard.aspx?ParentId=" & e.CommandArgument & "&fromtree=1")


                Case "EditForm"
                    Response.Redirect("~/adm/rfp.aspx?rfpId=" & e.CommandArgument & "&fromtree=1")

                Case "SendRFP"
                    lblRFPSelected.Text = e.CommandArgument
                    If LocalAPI.NotificarRFP(lblRFPSelected.Text) Then
                        LocalAPI.SetRFPStatus(lblRFPSelected.Text, LocalAPI.RFPStatus_ENUM.Sent, "", cboJob.SelectedValue)
                        RadTreeList1.DataBind()
                        Master.InfoMessage("The status of RFP was updated and the subconsultant notified")
                    End If

                Case "DeclineRFP"
                    lblRFPSelected.Text = e.CommandArgument
                    RadToolTipDecline.Visible = True
                    RadToolTipDecline.Show()

                Case "AceptRFP"
                    lblRFPSelected.Text = e.CommandArgument
                    lblRFPNumber.Text = "Accept/Define Job Request for Proposal: " & LocalAPI.RFPNumber(lblRFPSelected.Text)
                    RadToolTipAccept.Visible = True
                    RadToolTipAccept.Show()

                Case "ViewJobPage"
                    sUrl = "~/adm/Job_rfps.aspx?JobId=" & e.CommandArgument
                    CreateRadWindows(e.CommandName, sUrl, 960, 820, False)

            End Select
        Catch ex As Exception
            lblGuiId.Text = "e2103445-8a47-49ff-808e-6008c0fe13a1"

        End Try
    End Sub
    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, bRefreshOnClose As Boolean)
        RadWindowManager1.Windows.Clear()
        Dim window1 As RadWindow = New RadWindow()
        window1.NavigateUrl = sUrl
        window1.VisibleOnPageLoad = True
        window1.VisibleStatusbar = False
        window1.ID = WindowsID
        window1.InitialBehaviors = WindowBehaviors.Maximize
        window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
        window1.Width = Width
        window1.Height = Height
        window1.Modal = True
        If bRefreshOnClose Then window1.OnClientClose = "OnClientClose"
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        Response.Redirect("~/ADM/RFPNewWizard.aspx?fromtree=1")
    End Sub
    Protected Sub btnUpdateTandCTemplate_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try

            Dim btnUpdate As RadButton = sender
            Dim cbo As RadComboBox = CType(btnUpdate.NamingContainer.FindControl("cboTandCtemplates"), RadComboBox)
            Dim editor As RadEditor = CType(btnUpdate.NamingContainer.FindControl("radEditor_TandC"), RadEditor)
            editor.Content = LocalAPI.GetProposalTemplateDescription(Val("" & cbo.SelectedValue))
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub
    Protected Sub btnPaymentSchedules_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try

            Dim btnGenerate As RadButton = sender
            Dim PanelContainer As Panel
            Dim cbo As RadComboBox = CType(btnGenerate.NamingContainer.FindControl("cboPaymentSchedules"), RadComboBox)

            Dim psValues As String = LocalAPI.GetStringEscalar("SELECT PaymentsScheduleList FROM Invoices_types WHERE [Id]=" & cbo.SelectedValue)
            Dim psText As String = LocalAPI.GetStringEscalar("SELECT PaymentsTextList FROM Invoices_types WHERE [Id]=" & cbo.SelectedValue)

            Dim sArrValues As String() = Split(psValues, ",")
            Dim sArrText As String() = Split(psText, ",")
            Dim i As Int16, j As Int16
            If sArrValues.Length > 0 Then
                For i = 0 To sArrValues.Length - 1
                    If Len(sArrValues(i).ToString) > 0 Then
                        PanelContainer = CType(btnGenerate.NamingContainer.FindControl("PanelPS" & i + 1), Panel)
                        CType(PanelContainer.FindControl("txtValue" & i + 1), RadTextBox).Text = sArrValues(i)
                        CType(PanelContainer.FindControl("txtText" & i + 1), RadTextBox).Text = sArrText(i)
                        PanelContainer.Visible = True
                    End If
                Next
            End If
            For j = i To 3
                PanelContainer = CType(btnGenerate.NamingContainer.FindControl("PanelPS" & j + 1), Panel)
                CType(PanelContainer.FindControl("txtValue" & j + 1), RadTextBox).Text = 0
                CType(PanelContainer.FindControl("txtText" & j + 1), RadTextBox).Text = ""
                PanelContainer.Visible = False
            Next

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnNewFileLink_Click(sender As Object, e As EventArgs)
        'get a reference to the row
        Dim item As GridEditFormItem = CType(sender, RadButton).NamingContainer
        CType(item.FindControl("RadGridLinks"), RadGrid).MasterTableView.InsertItem()
    End Sub


#Region "Accept"
    Private Sub btnAcceptConfirm_Click(sender As Object, e As EventArgs) Handles btnAcceptConfirm.Click
        Try
            If lblRFPSelected.Text > 0 Then
                LocalAPI.SetRFPStatus(lblRFPSelected.Text, LocalAPI.RFPStatus_ENUM.Acepted, "", cboJob.SelectedValue)
                If chkNotifyAccept.Checked Then
                    EmailAcept(lblRFPSelected.Text, lblCompanyId.Text)
                    Master.InfoMessage("The status of RFP was updated and the subconsultant notified")
                Else
                    Master.InfoMessage("The status of RFP was updated.")
                End If
            End If

            RadTreeList1.DataBind()
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub
    Private Function EmailAcept(ByVal rfpId As Integer, ByVal companyid As Integer) As Boolean
        Try
            Dim RFPObject = LocalAPI.GetRecord(rfpId, "RFP_SELECT")
            Dim DictValues As Dictionary(Of String, String) = New Dictionary(Of String, String)
            DictValues.Add("[RFPNumber]", RFPObject("RFPNumber"))
            DictValues.Add("[ProjectName]", RFPObject("ProjectName"))
            DictValues.Add("[ProjectLocation]", RFPObject("ProjectLocation"))
            DictValues.Add("[SubconsultantName]", RFPObject("SubconsultantName"))
            DictValues.Add("[Discipline]", RFPObject("Discipline"))
            DictValues.Add("[Client]", RFPObject("Client"))
            DictValues.Add("[Total]", RFPObject("Total"))
            DictValues.Add("[Sender]", RFPObject("Sender"))
            DictValues.Add("[SenderEmail]", RFPObject("SenderEmail"))
            DictValues.Add("[CompanyName]", RFPObject("CompanyName"))
            DictValues.Add("[CompanyContact]", RFPObject("CompanyContact"))
            DictValues.Add("[SharedLink_URL]", LocalAPI.GetSharedLink_URL(2002, rfpId))
            DictValues.Add("[PASSign]", LocalAPI.GetPASSign())

            Dim sSubject As String = LocalAPI.GetMessageTemplateSubject("RFP_Accepted_Notification", lblCompanyId.Text, DictValues)
            Dim sBody As String = LocalAPI.GetMessageTemplateBody("RFP_Accepted_Notification", lblCompanyId.Text, DictValues)

            Dim sCC As String = ""
            Dim sCCO As String = ""
            If LocalAPI.IsCompanyNotification(lblCompanyId.Text, "Notification_AceptedRFP") Then
                sCC = Master.UserEmail
                'sCCO = LocalAPI.GetCompanyProperty(companyid, "webEmailProfitWarningCCO")
            End If
            Dim jobId = LocalAPI.GetRFPProperty(rfpId, "jobId")
            Dim clientId = "0"
            If Not String.IsNullOrEmpty(jobId) Then
                clientId = LocalAPI.GetJobProperty(jobId, "Client")
            End If
            SendGrid.Email.SendMail(RFPObject("SubConsultanstEmail"), sCC, "", sSubject, sBody, lblCompanyId.Text, clientId, jobId, RFPObject("SenderEmail"), RFPObject("CompanyName"), RFPObject("SenderEmail"))
            Return True
        Catch ex As Exception
            'lblStatus.Text = ex.Message
        End Try

    End Function

#End Region
#Region "Decline"
    Private Sub btnDeclineConfirm_Click(sender As Object, e As EventArgs) Handles btnDeclineConfirm.Click
        Try
            If lblRFPSelected.Text > 0 Then
                LocalAPI.SetRFPStatus(lblRFPSelected.Text, LocalAPI.RFPStatus_ENUM.Declined, txtDeclineNotes.Text)
                If chkNotifyDecline.Checked Then
                    EmailDeclined(lblRFPSelected.Text, lblCompanyId.Text)
                End If
                RadTreeList1.DataBind()
                txtDeclineNotes.Text = ""
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub
    Private Function EmailDeclined(ByVal rfpId As Integer, ByVal companyid As Integer) As Boolean
        Try

            Dim RFPObject = LocalAPI.GetRecord(rfpId, "RFP_SELECT")

            Dim DictValues As Dictionary(Of String, String) = New Dictionary(Of String, String)
            DictValues.Add("[SubconsultantName]", RFPObject("SubconsultantName"))
            DictValues.Add("[Sender]", RFPObject("Sender"))
            DictValues.Add("[Organization]", RFPObject("Organization"))
            DictValues.Add("[ProjectName]", RFPObject("ProjectName"))
            DictValues.Add("[CompanyName]", RFPObject("CompanyName"))
            DictValues.Add("[RFPNumber]", RFPObject("RFPNumber"))
            DictValues.Add("[ProjectLocation]", RFPObject("ProjectLocation"))
            DictValues.Add("[Discipline]", RFPObject("Discipline"))
            DictValues.Add("[Client]", RFPObject("Client"))
            DictValues.Add("[Total]", RFPObject("Total"))
            DictValues.Add("[SenderEmail]", RFPObject("SenderEmail"))
            DictValues.Add("[CompanyContact]", RFPObject("CompanyContact"))
            DictValues.Add("[DeclineNotes]", txtDeclineNotes.Text)
            DictValues.Add("[PASSign]", LocalAPI.GetPASSign())

            Dim sSubject As String = LocalAPI.GetMessageTemplateSubject("RFP_Decline_Notification", lblCompanyId.Text, DictValues)
            Dim sBody As String = LocalAPI.GetMessageTemplateBody("RFP_Decline_Notification", lblCompanyId.Text, DictValues)

            Dim sCC As String = ""
            Dim sCCO As String = ""
            If LocalAPI.IsCompanyNotification(lblCompanyId.Text, "Notification_AceptedRFP") Then
                sCC = Master.UserEmail
                'sCCO = LocalAPI.GetCompanyProperty(companyid, "webEmailProfitWarningCCO")
            End If
            Dim jobId = LocalAPI.GetRFPProperty(rfpId, "jobId")
            Dim clientId = "0"
            If Not String.IsNullOrEmpty(jobId) Then
                clientId = LocalAPI.GetJobProperty(jobId, "Client")
            End If
            SendGrid.Email.SendMail(RFPObject("SubConsultanstEmail"), sCC, "", sSubject, sBody, lblCompanyId.Text, clientId, jobId, RFPObject("CompanyName"), RFPObject("SenderEmail"), RFPObject("Organization"))
            Return True

        Catch ex As Exception
        End Try
    End Function
#End Region

#Region "RadToolTipNewRFPforProject"
    Private Sub btnInsertRFPforProject_Click(sender As Object, e As EventArgs) Handles btnInsertRFPforProject.Click
        Try
            Dim newRFPId As Integer = LocalAPI.NewRFP_for_Existing_Project(lblRFPSelected.Text, cboSubconsultantNew.SelectedValue)

            RadTreeList1.DataBind()

            Master.InfoMessage("New RFP Inserted!")
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub


#End Region
    Private Sub btnTablePage_Click(sender As Object, e As EventArgs) Handles btnTablePage.Click
        Response.RedirectPermanent("~/ADM/RequestForProposals.aspx")
    End Sub


    Private Sub SqlDataSourceAzureFiles_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAzureFiles.Deleting
        Dim KeyName As String = LocalAPI.GetAzureFileKeyName(e.Command.Parameters("@Id").Value)
        AzureStorageApi.DeleteFile(KeyName)
    End Sub

End Class
