Imports Microsoft.AspNet.Identity

Public Class MasterPage
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Try
            ' Inicializando Controles y Properties de la Master Page
            UserEmail = Context.User.Identity.GetUserName()
            lblUserName.Text = LocalAPI.GetEmployeeFullName(UserEmail, Session("companyId"))

            Dim companyId As Integer = 260962 ' La empresa que envia mensajes como Master es EEG
            UserId = LocalAPI.GetEmployeeId(UserEmail, companyId)
            UserName = LocalAPI.GetEmployeeFullName(UserEmail, companyId)

        Catch ex As Exception

        End Try
    End Sub

    Private Sub MasterPage_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then

        End If
        lblWarning.Text = ""
    End Sub

    Public Property ErrorMessage() As String
        Get
            ErrorMessage = lblWarning.Text
        End Get
        Set(ByVal value As String)
            lblWarning.Text = value.ToString
        End Set
    End Property

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

    Public Property UserName() As String
        Get
            UserName = lblUserName.Text
        End Get
        Set(ByVal value As String)
            lblUserName.Text = value.ToString
        End Set
    End Property

End Class

