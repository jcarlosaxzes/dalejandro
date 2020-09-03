Imports System.Threading.Tasks

Public Class post
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If Not Page.IsPostBack Then
                If HttpContext.Current.Request.HttpMethod = "POST" Then
                    Dim requestHeaders = HttpContext.Current.Request.Headers
                    Dim authToken = requestHeaders("Authorization")
                    '[WebHook URL] "https://app.pasconcept.com/api/webhooks/post"
                    '[Authorization Token] = "Bearer D1532BCE-BBF3-44BD-88C6-34D4151844B0"
                    '[HttpMethod] = "POST"

                    Select Case authToken
                        Case "Bearer D1532BCE-BBF3-44BD-88C6-34D4151844B0"
                            'Daily Recurrence Tasks
                            Task.Run(Function() LocalAPI.DailyRecurrenceTasks())
                            Response.StatusCode = 200
                        Case Else
                            Response.StatusCode = 401
                    End Select
                Else
                    Response.StatusCode = 401
                End If

            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

End Class