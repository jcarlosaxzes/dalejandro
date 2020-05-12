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

        End If
        Refresh()
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
    Private Sub Refresh()
        lblJobId.Text = Request.QueryString("jobId")
        Dim sPage = Mid(Request.Url.AbsolutePath, InStrRev(Request.Url.AbsolutePath, "/job_") + 1)
        Select Case sPage
            Case "job_job.aspx"
                lblActiveTab.Text = 0
            Case "job_accounting.aspx"
                lblActiveTab.Text = 1
            Case "job_employees.aspx"
                lblActiveTab.Text = 2
            Case "job_proposals.aspx"
                lblActiveTab.Text = 3
            Case "job_rfps.aspx"
                lblActiveTab.Text = 4
            Case "job_notes.aspx"
                lblActiveTab.Text = 5
            Case "job_times.aspx"
                lblActiveTab.Text = 6
            Case "job_links.aspx"
                lblActiveTab.Text = 7
            Case "job_schedule.aspx"
                lblActiveTab.Text = 8
            Case "job_reviews.aspx"
                lblActiveTab.Text = 9
            Case "job_tags.aspx"
                lblActiveTab.Text = 10
            Case "job_trasmittals.aspx"
                lblActiveTab.Text = 11
            Case "job_images_files.aspx"
                lblActiveTab.Text = 12
        End Select
        Page.Title = LocalAPI.GetJobCodeName(lblJobId.Text)
        LoginViewMenuApp.DataBind()
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

