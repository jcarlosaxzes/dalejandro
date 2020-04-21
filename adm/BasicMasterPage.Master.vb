Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin
Public Class BasicMasterPage
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Try
            ' Inicializando Controles y Properties de la Master Page
            UserEmail = Context.User.Identity.GetUserName()

            UserId = LocalAPI.GetEmployeeId(UserEmail, Session("companyId"))
            Session("Version") = LocalAPI.sys_VersionId(Session("companyId"))
            UserName = LocalAPI.GetEmployeeFullName(UserEmail)

        Catch ex As Exception

        End Try
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
            If Session("AdmLogin") Is Nothing Then
                Session("AdmLogin") = UserEmail
                LocalAPI.sys_log_Nuevo(UserEmail, LocalAPI.sys_log_AccionENUM.AdminLogin, Session("companyId"), LocalAPI.GetEmployeeFullName(UserEmail))
            End If
        End Get
        Set(ByVal value As String)
            lblEmployeeEmail.Text = value.ToString
        End Set
    End Property

    Public Property UserName() As String
        Get
            UserName = lblUserName.Text
        End Get
        Set(ByVal value As String)
            lblUserName.Text = value.ToString
        End Set
    End Property

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
            RadNotificationWarning.Title = lblPageTitle.Text
            RadNotificationWarning.Text = sText
            RadNotificationWarning.AutoCloseDelay = SecondsAutoCloseDelay * 1000
            RadNotificationWarning.Show()
        End If
        'lblWarning.Text = sText
    End Sub

    Public WriteOnly Property PageTitle() As String
        Set(ByVal value As String)
            lblPageTitle.Text = value
        End Set
    End Property
End Class

