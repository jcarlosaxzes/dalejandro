Imports Microsoft.AspNet.Identity

Public Class ErrorPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If (Not Page.IsPostBack) Then
                InsertSysError(Server.GetLastError())
            End If
        Catch ex As Exception

        End Try
    End Sub
    Private Sub InsertSysError(objError As Exception)
        If Not objError Is Nothing Then
            Dim userEmail As String = ""
            Dim MessageErr As String = ""
            Dim SourceErr As String = ""
            Dim StackTraceErr As String = ""
            Try
                userEmail = Context.User.Identity.GetUserName()
            Catch ex As Exception
            End Try
            Try
                MessageErr = objError.Message
            Catch ex As Exception
            End Try
            Try
                SourceErr = objError.Source
            Catch ex As Exception
            End Try
            Try
                StackTraceErr = objError.StackTrace
            Catch ex As Exception
            End Try

            LocalAPI.sys_error_INSERT(Session("companyId"), userEmail, MessageErr, SourceErr, StackTraceErr)
        End If


    End Sub
End Class