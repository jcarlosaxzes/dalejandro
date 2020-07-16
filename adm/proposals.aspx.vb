﻿Imports Telerik.Web.UI
Public Class proposals
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ProposalsList") Then Response.RedirectPermanent("~/ADM/Default.aspx")
                ' Si no tiene permiso New, boton.Visible=False
                'btnNew.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewProposal")
                btnNewWizard.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewProposal")
                btnPrivate.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Allow_PrivateMode")

                spanViewSummary.Visible = btnPrivate.Visible

                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Proposal List"
                Master.PageTitle = "Proposals/Proposal List"
                Master.Help = "http://blog.pasconcept.com/2012/04/fee-proposal-proposals-list-page.html"

                lblCompanyId.Text = Session("companyId")
                Dim employeeId As Integer = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)


                cboDepartments.DataBind()
                cboDepartments.SelectedValue = LocalAPI.GetEmployeeProperty(employeeId, "FilterProposal_Department")

                cboStatus.DataBind()
                cboClients.DataBind()

                If Not Request.QueryString("Buscar") Is Nothing Then
                    txtFind.Text = Request.QueryString("Buscar")
                End If

                cboPeriod.DataBind()
                cboPeriod.SelectedValue = LocalAPI.GetEmployeeProperty(employeeId, "FilterProposal_Month")
                IniciaPeriodo(cboPeriod.SelectedValue)

                If Not Request.QueryString("restoreFilter") Is Nothing Then
                    RestoreFilter()
                End If

                RefreshRecordset()

                If Not Request.QueryString("rfpGUID") Is Nothing Then
                    lblProposalIdFromRfp.Text = LocalAPI.CreateProposalFromRFP(Request.QueryString("rfpGUID"), employeeId, lblCompanyId.Text)
                End If

            End If

            RadWindowManager1.EnableViewState = False
            'If RadWindowManager1.Windows.Count > 0 Then
            '    RadWindowManager1.Windows.Clear()
            '    'RadGrid1.DataBind()
            'End If

        Catch ex As Exception

        End Try
    End Sub

    Private Sub Administradores_Proposals_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        If lblProposalIdFromRfp.Text > 0 Then
            lblProposalIdFromRfp.Text = "0"
            Response.Redirect("~/ADM/ProposalNewWizard.aspx?proposalId=" & lblProposalIdFromRfp.Text)
        End If

    End Sub

    Private Sub IniciaPeriodo(nPeriodo As Integer)
        cboPeriod.SelectedValue = nPeriodo
        Select Case nPeriodo
            Case 13  ' (All Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/2000"
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

            Case 15  ' (Last Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Today.Year - 1
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year - 1

            Case 30, 60, 90, 120, 180, 365 '   days....
                RadDatePickerTo.DbSelectedDate = Date.Today
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Day, 0 - nPeriodo, RadDatePickerTo.DbSelectedDate)

            Case 99   'Custom
                RadDatePickerFrom.Focus()
                ' Allow RadDatePicker user Values...

            Case 14  '14 and any other old setting (This Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

        End Select
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EmailPrint"
                Response.Redirect("~/adm/sendproposal.aspx?ProposalId=" & e.CommandArgument)

            Case "GetSharedLink"
                sUrl = "~/adm/sharelink.aspx?ObjType=11&ObjId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 520, 400, False)
            Case "EditProposal"
                Response.Redirect("~/adm/proposal.aspx?proposalId=" & e.CommandArgument)

            Case "EditWizard"
                Response.Redirect("~/ADM/ProposalNewWizard.aspx?proposalId=" & e.CommandArgument)

            Case "UploadFiles"
                Response.Redirect("~/ADM/ProposalNewWizard.aspx?proposalId=" & e.CommandArgument & "&AttachmentsTab=1")

            Case "EditJob"
                sUrl = "~/ADM/Job_job.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True)

            Case "EditClient"
                Response.Redirect("~/ADM/Client.aspx?clientId=" & e.CommandArgument)
        End Select
    End Sub

    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean)
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
        window1.OnClientClose = "OnClientClose"
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Public Function StatusEnabled(ByVal Status As Object) As Boolean
        Dim sStatus As String = "" & Status

        Select Case sStatus
            Case "Pending"
                'Dim lJob As String = LocalAPI.GetProposalData(proposalId, "JobId")
                Return True    'Val(lJob) <= 0
            Case "Declined"
                Return True
            Case Else
                Return False
        End Select
    End Function

    Public Function JobForeColor(jobId As Object, ByVal Status As Object) As Drawing.Color
        Dim sStatus As String = "" & Status

        Select Case sStatus
            Case "Pending"
                If Val("" & jobId) <= 0 Then
                    Return Drawing.Color.DarkBlue
                Else
                    Return Drawing.Color.Gray
                End If
            Case Else
                Return Drawing.Color.DarkBlue
        End Select
    End Function

    Private Sub RefreshRecordset()
        Try
            IniciaPeriodo(cboPeriod.SelectedValue)
            SqlDataSourceProp.DataBind()
            RadGrid1.DataBind()
            FormViewViewSummary.DataBind()
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub btnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        RefreshRecordset()
        SaveFilter()
    End Sub

    Private Sub SaveFilter()
        Session("Filter_Proposals_RadDatePickerFrom") = RadDatePickerFrom.SelectedDate
        Session("Filter_Proposals_RadDatePickerTo") = RadDatePickerTo.SelectedDate
        Session("Filter_Proposals_cboClients") = cboClients.SelectedValue
        Session("Filter_Proposals_cboStatus") = cboStatus.SelectedValue
        Session("Filter_Proposals_cboDepartments") = cboDepartments.SelectedValue
        Session("Filter_Proposals_txtFind") = txtFind.Text
    End Sub

    Private Sub RestoreFilter()
        Try
            RadDatePickerFrom.SelectedDate = Convert.ToDateTime(Session("Filter_Proposals_RadDatePickerFrom"))
            RadDatePickerTo.SelectedDate = Convert.ToDateTime(Session("Filter_Proposals_RadDatePickerTo"))
            cboClients.SelectedValue = Session("Filter_Proposals_cboClients")
            cboStatus.SelectedValue = Session("Filter_Proposals_cboStatus")
            cboDepartments.SelectedValue = Session("Filter_Proposals_cboDepartments")
            txtFind.Text = Session("Filter_Proposals_txtFind")
        Catch ex As Exception
        End Try
    End Sub

    Private tot As Double

    'Protected Sub RadGrid1_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadGrid1.Init
    '    Dim menu As GridFilterMenu = RadGrid1.FilterMenu
    '    Dim i As Integer
    '    While i < menu.Items.Count
    '        If menu.Items(i).Text <> "NoFilter" And menu.Items(i).Text <> "Contains" And menu.Items(i).Text <> "DoesNotContain" And menu.Items(i).Text <> "EqualTo" Then
    '            menu.Items.RemoveAt(i)
    '        Else
    '            i = i + 1
    '        End If
    '    End While
    'End Sub

    Protected Sub SqlDataSourceProp_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceProp.Selecting
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub

    Protected Sub RadGrid1_PreRender(sender As Object, e As EventArgs) Handles RadGrid1.PreRender
        If LocalAPI.IsTabletOrSmarthphone(Request.UserAgent) Then
            'RadGrid1.MasterTableView.GetColumn("Share").Visible = False
        End If
    End Sub

    'Protected Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
    '    CreateRadWindows("NewProposal", "~/ADM/Proposal_new.aspx", 970, 810, True)
    'End Sub
    Protected Sub btnNewWizard_Click(sender As Object, e As EventArgs) Handles btnNewWizard.Click
        CreateRadWindows("NewWizard", "~/ADM/ProposalNewWizard.aspx", 970, 810, True)
        Response.Redirect("~/ADM/ProposalNewWizard.aspx")
    End Sub

End Class
