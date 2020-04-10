Imports Telerik.Web.UI
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
                btnPrivate.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Budget")

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

                RefreshRecordset()

                If Not Request.QueryString("rfpGUID") Is Nothing Then
                    lblProposalIdFromRfp.Text = LocalAPI.CreateProposalFromRFP(Request.QueryString("rfpGUID"), employeeId, lblCompanyId.Text)
                End If
            End If

            'RadWindowManager1.EnableViewState = False
            If RadWindowManager1.Windows.Count > 0 Then
                RadWindowManager1.Windows.Clear()
                RadGrid1.DataBind()
            End If

        Catch ex As Exception

        End Try
    End Sub

    Private Sub Administradores_Proposals_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        If lblProposalIdFromRfp.Text > 0 Then
            Dim sUrl As String = "~/ADM/ProposalNewWizard.aspx?proposalId=" & lblProposalIdFromRfp.Text
            lblProposalIdFromRfp.Text = "0"
            CreateRadWindows("RFP", sUrl, 970, 810, True)
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

        End Select
        cboPeriod.SelectedValue = nPeriodo
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EmailPrint"
                'sUrl = "~/ADMCLI/ProposalRDLC.aspx?ProposalId=" & e.CommandArgument & "&Origen=2"
                sUrl = "~/ADM/SendProposal.aspx?ProposalId=" & e.CommandArgument & "&Origen=2"
                CreateRadWindows(e.CommandName, sUrl, 980, 740, False)
            Case "AceptProposal"
                sUrl = "~/ADMCLI/AceptProposal.aspx?ProposalId=" & e.CommandArgument
                'Response.RedirectPermanent(sUrl)
                CreateRadWindows(e.CommandName, sUrl, 960, 700, True)
            Case "GetSharedLink"
                sUrl = "~/ADMCLI/ShareLink.aspx?ObjType=11&ObjId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 520, 400, False)
            Case "EditProposal"
                ' Codigo sapx anterior
                '<asp:HyperLink ID="hlkProposalEdit" runat="server" Text='<%# Eval("ProposalNumber")%>' NavigateUrl='<%# Eval("Id", "~/ADM/Proposal.aspx?Id={0}")%>' ToolTip="Click to edit proposal in new tab" Target="_blank"></asp:HyperLink>

                sUrl = "~/ADM/Proposal.aspx?Id=" & e.CommandArgument

                'sUrl = "~/ADM/ProposalNewWizard.aspx?proposalId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 970, 810, True)
            Case "EditWizard"
                sUrl = "~/ADM/ProposalNewWizard.aspx?proposalId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 970, 810, True)

            Case "UploadFiles"
                sUrl = "~/ADM/ProposalNewWizard.aspx?proposalId=" & e.CommandArgument & "&AttachmentsTab=1"
                CreateRadWindows(e.CommandName, sUrl, 970, 810, True)

            Case "EditJob"
                sUrl = "~/ADM/Job_job.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True)

            Case "EditClient"
                sUrl = "~/ADM/Client.aspx?clientId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 850, 750, False)
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

        Catch ex As Exception
        End Try
    End Sub

    Protected Sub btnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        RefreshRecordset()
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
    End Sub

    Protected Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click
        CreateRadWindows("rptProposalList", "~/RPT/rptProposalList.aspx?Year=" & Today.Year & "&Period=" & cboPeriod.SelectedValue & "&Client=" & cboClients.SelectedValue & "&StatusId=" & cboStatus.SelectedValue & "&Find=" & txtFind.Text, 850, 700, False)
    End Sub

End Class
