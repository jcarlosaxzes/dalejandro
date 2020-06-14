Imports Microsoft.AspNet.Identity

Public Class MasterJOB
    Inherits System.Web.UI.MasterPage
    Private Sub MasterJOB_Init(sender As Object, e As EventArgs) Handles Me.Init
        lblCompanyId.Text = Session("companyId")
        lblEmployeeEmail.Text = Context.User.Identity.GetUserName()
        lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            lblJobId.Text = Request.QueryString("jobId")
            If LocalAPI.IsCompanyViolation(lblJobId.Text, "Jobs", lblCompanyId.Text) Then Response.RedirectPermanent("~/ADM/Default.aspx")
        End If
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

