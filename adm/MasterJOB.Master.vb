Imports System.Threading.Tasks
Imports Microsoft.AspNet.Identity

Public Class MasterJOB
    Inherits System.Web.UI.MasterPage
    Private Sub MasterJOB_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try

            lblCompanyId.Text = Session("companyId")
            lblEmployeeEmail.Text = Context.User.Identity.GetUserName()
            lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)

            If Not Request.QueryString("backpage") Is Nothing Then
                Session("jobmasterpageback") = Request.QueryString("backpage")
            End If
            btnMasterClose.Visible = (Len("" & Session("jobmasterpageback")) > 0)

        Catch ex As Exception
            '!!! Posible perdida de session
            ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub RestoreLostVariables()
        ' PARCHE.... Perdida de session, error!!!!, recuperar companyId desde Job
        lblCompanyId.Text = LocalAPI.GetJobProperty(lblJobId.Text, "companyId")
        Session("companyId") = lblCompanyId.Text
        lblEmployeeEmail.Text = Context.User.Identity.GetUserName()
        lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then

            If Not Request.QueryString("guid") Is Nothing Then
                lblJobId.Text = LocalAPI.GetJobIdFromGUID(Request.QueryString("guid"))
            Else
                Back()
            End If

            lblJobName.Text = LocalAPI.GetJobCodeName(lblJobId.Text)

            ' Restore session value
            If Val(lblCompanyId.Text) = 0 Then
                RestoreLostVariables()
            End If

            If LocalAPI.IsCompanyViolation(lblJobId.Text, "Jobs", lblCompanyId.Text) Then Response.RedirectPermanent("~/adm/default.aspx")
            Page.Title = lblJobName.Text
            If Session("LastPage") <> HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Path) Then
                Session("LastPage") = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Path)
                Task.Run(Function() LocalAPI.EmployeePageTracking(UserId, Session("LastPage")))
            End If

        End If
    End Sub

    Public Function GetJobId()
        Return lblJobId.Text
    End Function
    Private Sub Back()
        'What is this ?
        Session("jobmasterpageback") = ""
        Select Case Session("jobmasterpageback")
            Case "jobs"
                Response.Redirect("~/adm/jobs?restoreFilter=1")
            Case "proposals"
                Response.Redirect("~/adm/proposals?restoreFilter=1")
            Case "invoices"
                Response.Redirect("~/adm/invoices")
            Case "requestforproposals"
                Response.Redirect("~/adm/requestforproposals")
            Case "rfps"
                Response.Redirect("~/adm/rfps")
            Case "client"
                Dim clientId As Integer = LocalAPI.GetJobProperty(lblJobId.Text, "Client")
                Response.Redirect($"~/adm/client?clientId={clientId}")
            Case Else
                Response.Redirect("~/adm/jobs?restoreFilter=1")
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
        If Not RadNavigationJob.Nodes(NodeId).Selected Then
            RadNavigationJob.Nodes(NodeId).Selected = True
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

