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
        lblJobId.Text = Request.QueryString("JobId")
        Dim sPage = Mid(Request.Url.AbsolutePath, InStrRev(Request.Url.AbsolutePath, "/Job_") + 1)
        Select Case sPage
            Case "Job_job.aspx"
                lblActiveTab.Text = 0
            Case "Job_accounting.aspx"
                lblActiveTab.Text = 1
            Case "Job_employees.aspx"
                lblActiveTab.Text = 2
            Case "Job_proposals.aspx"
                lblActiveTab.Text = 3
            Case "Job_rfps.aspx"
                lblActiveTab.Text = 4
            Case "Job_notes.aspx"
                lblActiveTab.Text = 5
            Case "Job_times.aspx"
                lblActiveTab.Text = 6
            Case "Job_links.aspx"
                lblActiveTab.Text = 7
            Case "Job_schedule.aspx"
                lblActiveTab.Text = 8
            Case "Job_reviews.aspx"
                lblActiveTab.Text = 9
            Case "Job_tags.aspx"
                lblActiveTab.Text = 10
            Case "Job_trasmittals.aspx"
                lblActiveTab.Text = 11
            Case "Job_images_files.aspx"
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

