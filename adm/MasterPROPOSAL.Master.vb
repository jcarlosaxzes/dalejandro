Imports System.Threading.Tasks
Imports Microsoft.AspNet.Identity

Public Class MasterPROPOSAL
    Inherits System.Web.UI.MasterPage

    Private Sub MasterPROPOSAL_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try

            lblCompanyId.Text = Session("companyId")
            lblEmployeeEmail.Text = Context.User.Identity.GetUserName()
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

            lblProposalName.Text = LocalAPI.ProposalNumber(lblProposalId.Text)

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

End Class