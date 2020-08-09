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
                    '[Authorization Token] = "Bearer 7497EE20-6811-4405-A2EE-471A8BFE3682"
                    '[HttpMethod] = "POST"

                    Select Case authToken
                        Case "D1532BCE-BBF3-44BD-88C6-34D4151844B0"
                            'EmissionRecurrenceEmails
                            Task.Run(Function() LocalAPI.EmissionRecurrenceEmails())
                        Case Else
                            Response.StatusCode = 401
                            Response.End()
                            Return
                    End Select
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

End Class