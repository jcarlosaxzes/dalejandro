Imports Telerik.Web.UI
Public Class job_proposals
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")

                lblEmployeeEmail.Text = Master.UserEmail
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)

                lblJobId.Text = Request.QueryString("JobId")

            End If

            RadWindowManager1.EnableViewState = False

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub
    Protected Sub btnNewPropsal_Click(sender As Object, e As EventArgs) Handles btnNewPropsal.Click
        If btnNewPropsal.Text = "New Proposal (Change Order)" Then
            SqlDataSourceProposals.InsertCommand = "ProposalNew_ChangeOrder"
        Else
            SqlDataSourceProposals.InsertCommand = "ProposalNew_From_Job"
        End If
        SqlDataSourceProposals.Insert()
        RadGridProposals.DataBind()
    End Sub
    Protected Sub RadGridProposals_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridProposals.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EmailPrint"
                'sUrl = "~/ADMCLI/ProposalRDLC.aspx?ProposalId=" & e.CommandArgument & "&Origen=52"
                sUrl = "~/ADM/SendProposal.aspx?ProposalId=" & e.CommandArgument & "&JobId=" & lblJobId.Text & "&Origen=152"
                'CreateRadWindows(e.CommandName, sUrl, 980, 890, False, "OnClientCloseProposals")
                Response.Redirect(sUrl)
            Case "AceptProposal"
                sUrl = "~/ADMCLI/AceptProposal.aspx?ProposalId=" & e.CommandArgument
                'Response.RedirectPermanent(sUrl)
                CreateRadWindows(e.CommandName, sUrl, 960, 810, False, "OnClientCloseProposals")
            Case "GetSharedLink"
                sUrl = "~/ADMCLI/ShareLink.aspx?ObjType=11&ObjId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 520, 400, False, "OnClientCloseProposals")
            Case "EditProposal"
                ' Codigo sapx anterior
                '<asp:HyperLink ID="hlkProposalEdit" runat="server" Text='<%# Eval("ProposalNumber")%>' NavigateUrl='<%# Eval("Id", "~/ADM/Proposal.aspx?Id={0}")%>' ToolTip="Click to edit proposal in new tab" Target="_blank"></asp:HyperLink>
                sUrl = "~/ADM/Proposal.aspx?Id=" & e.CommandArgument & "&HideMasterMenu=1"
                CreateRadWindows(e.CommandName, sUrl, -1, 810, False, "OnClientCloseProposals")
            Case "Delete"
        End Select
    End Sub

    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean, OnClientCloseFn As String)
        RadWindowManager1.Windows.Clear()
        Dim window1 As RadWindow = New RadWindow()
        window1.NavigateUrl = sUrl
        window1.VisibleOnPageLoad = True
        window1.VisibleStatusbar = False
        window1.ID = WindowsID
        If Maximize Then window1.InitialBehaviors = WindowBehaviors.Maximize
        window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
        If Width = -1 Then
            window1.AutoSize = True
        Else
            window1.AutoSize = False
            window1.Width = Width
            window1.Height = Height
        End If
        window1.Modal = True
        window1.OnClientClose = OnClientCloseFn
        RadWindowManager1.Windows.Add(window1)
    End Sub
    Public Function ProposalStatusEnabled(proposalId As Integer, ByVal Status As Object) As Boolean
        Dim sStatus As String = "" & Status

        Select Case sStatus
            Case "Pending"
                Dim lJob As String = LocalAPI.GetProposalData(proposalId, "JobId")
                Return Val(lJob) = lblJobId.Text
            Case "Declined"
                Return True
            Case Else
                Return False
        End Select
    End Function

End Class
