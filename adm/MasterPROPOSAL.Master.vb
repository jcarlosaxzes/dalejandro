Imports System.Threading.Tasks
Imports Microsoft.AspNet.Identity

Public Class MasterPROPOSAL
    Inherits System.Web.UI.MasterPage

    Private Sub MasterPROPOSAL_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try
            ' Para evitar perdida de session....
            lblEmployeeEmail.Text = Context.User.Identity.GetUserName()
            If Session("companyId") Is Nothing Then
                Session("companyId") = LocalAPI.GetCompanyDefault(lblEmployeeEmail.Text)
                Session("LastPage") = ""
            End If

            lblCompanyId.Text = Val("" & Session("companyId"))

            ' Restore session value
            If Val(lblCompanyId.Text) = 0 Then
                RestoreLostVariables()
            End If

            lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)

            If Not Request.QueryString("backpage") Is Nothing Then
                Session("proposalmasterpageback") = Request.QueryString("backpage")
            End If

        Catch ex As Exception
            '!!! Posible perdida de session
            ErrorMessage(ex.Message)
        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then

            If Not Request.QueryString("guid") Is Nothing Then
                lblProposalId.Text = LocalAPI.GetProposalIdFromGUID(Request.QueryString("guid"))
            Else
                Back()
            End If

            lblProposalName.Text = LocalAPI.ProposalNumber(lblProposalId.Text) & " " & LocalAPI.GetProposalProperty(lblProposalId.Text, "ProjectName")
            lblClientId.Text = LocalAPI.GetProposalProperty(lblProposalId.Text, "ClientId")
            panelViewProposalPage.DataBind()

            ' Restore session value
            If Val(lblCompanyId.Text) = 0 Then
                RestoreLostVariables()
            End If

            'If LocalAPI.IsCompanyViolation(lblProposalId.Text, "Proposals", lblCompanyId.Text) Then Response.RedirectPermanent("~/adm/default.aspx")
            Page.Title = lblProposalName.Text
            'If Session("LastPage") <> HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Path) Then
            '    Session("LastPage") = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Path)
            '    Task.Run(Function() LocalAPI.EmployeePageTracking(UserId, Session("LastPage")))
            'End If

            If Session("proposalclientsummary") Is Nothing Then
                Session("proposalclientsummary") = "0"
            End If
            FormViewClientBalance.Visible = IIf(Session("proposalclientsummary") = "1", True, False)

        End If
    End Sub
    Private Sub RestoreLostVariables()
        ' PARCHE.... Perdida de session, error!!!!, recuperar companyId desde Proposal
        lblCompanyId.Text = LocalAPI.GetProposalProperty(lblProposalId.Text, "companyId")
        Session("companyId") = lblCompanyId.Text
        lblEmployeeEmail.Text = Context.User.Identity.GetUserName()
        lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)
    End Sub

    Public Function GetProposalId()
        Return lblProposalId.Text
    End Function
    Private Sub Back()
        'What is this ?
        'Session("proposalmasterpageback") = ""
        Select Case "" & Session("proposalmasterpageback")
            Case "proposals"
                Response.Redirect("~/adm/proposals?restoreFilter=1")

            Case "job_proposals"
                Dim JobId As Integer = LocalAPI.GetProposalProperty(lblProposalId.Text, "JobId")
                Response.Redirect(LocalAPI.GetSharedLink_URL(8004, JobId))

            Case Else
                Response.Redirect("~/adm/proposals?restoreFilter=1")
        End Select

    End Sub
    Private Sub btnMasterClose_Click(sender As Object, e As EventArgs) Handles btnMasterClose.Click
        Back()
    End Sub


    Public Property UserId() As Integer
        Get
            UserId = lblEmployeeId.Text
        End Get
        Set(ByVal value As Integer)
            lblEmployeeId.Text = value.ToString
        End Set
    End Property
    Public Property UserEmail() As String
        Get
            UserEmail = lblEmployeeEmail.Text
        End Get
        Set(ByVal value As String)
            lblEmployeeEmail.Text = value.ToString
        End Set
    End Property

    Public Sub ActiveTab(NodeId As String)
        If Not RadNavigationProposal.Nodes(NodeId).Selected Then
            RadNavigationProposal.Nodes(NodeId).Selected = True
        End If

    End Sub

    Public Sub ErrorMessage(ByVal sText As String, Optional ByVal SecondsAutoCloseDelay As Integer = 0)
        If sText.Length > 0 Then
            RadNotificationError.Title = "Error message"
            RadNotificationError.Text = sText
            RadNotificationError.AutoCloseDelay = SecondsAutoCloseDelay * 1000
            RadNotificationError.Show()
        End If
    End Sub

    Public Sub InfoMessage(ByVal sText As String, Optional ByVal SecondsAutoCloseDelay As Integer = 1)
        If sText.Length > 0 Then
            RadNotificationWarning.Title = Page.Title
            RadNotificationWarning.Text = sText
            RadNotificationWarning.AutoCloseDelay = SecondsAutoCloseDelay * 1000
            RadNotificationWarning.Show()
        End If
    End Sub

    Public Function EmployeePermission(sOpcion As String) As Boolean
        Return LocalAPI.GetEmployeePermission(lblEmployeeId.Text, sOpcion)
    End Function

    Private Sub btnSaveAs_Click(sender As Object, e As EventArgs) Handles btnSaveAs.Click
        Response.Redirect($"~/adm/proposal_save_copy.aspx?ProposalId={lblProposalId.Text}&backpage=pro_proposal")
    End Sub
    Protected Sub btnSaveAsTemplate_Click(sender As Object, e As EventArgs) Handles btnSaveAsTemplate.Click
        Response.Redirect($"~/adm/proposal_save_as_template.aspx?ProposalId={lblProposalId.Text}&backpage=pro_proposal")
    End Sub
    Protected Sub btnPrintProposal_Click(sender As Object, e As EventArgs) Handles btnPrintProposal.Click
        If LocalAPI.GetProposalProperty(lblProposalId.Text, "ClientId") > 0 Then
            Response.Redirect("~/adm/SendProposal.aspx?ProposalId=" & lblProposalId.Text & "&backpage=pro_proposal&HideMasterMenu=1")
        Else
            InfoMessage("You Must Specify the Client and Update Proposal")
        End If
    End Sub
    Protected Sub btnPdf_Click(sender As Object, e As EventArgs) Handles btnPdf.Click
        Dim ProposalUrl = LocalAPI.GetSharedLink_URL(11, lblProposalId.Text)
        Session("PrintUrl") = ProposalUrl
        Session("PrintName") = "Proposal_" & LocalAPI.ProposalNumber(lblProposalId.Text) & ".pdf"
        Response.Redirect("~/ADM/pdf_print.aspx")
    End Sub

    Private Sub btnSummary_Click(sender As Object, e As EventArgs) Handles btnSummary.Click
        Session("proposalclientsummary") = IIf(Session("proposalclientsummary") = "1", "0", "1")
        FormViewClientBalance.Visible = IIf(Session("proposalclientsummary") = "1", True, False)
    End Sub
End Class