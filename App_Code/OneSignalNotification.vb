Imports Microsoft.VisualBasic
Imports Newtonsoft.Json
Imports System.IO
Imports System.Net
Imports System.Net.Http

Public Class OneSignalNotification
    Const domainUrl As String = "https://pasconcept-api-dev.azurewebsites.net/api/"

    Const appID As String = "e25455bf-d944-4c58-b688-45af3d74f2f7"

    Public Shared Function SendNotification(UserEmailList As String, MessageHeading As String, MessageContent As String, URL As String, companyId As Integer) As String
        Try

            If Len(UserEmailList) > 0 Then
                Dim recipients As List(Of RecipientViewModel) = New List(Of RecipientViewModel)()
                ' Componer json 
                Dim i As Integer
                Dim sArrValues As String() = Split(UserEmailList, ",")
                Dim nValues As Integer = sArrValues.Length
                For i = 0 To nValues - 1
                    If Len(sArrValues(i).ToString) > 3 Then
                        Dim recipient = New RecipientViewModel() With {
               .IdRecipient = LocalAPI.GetEmployeeId(sArrValues(i), companyId),
               .EmailRecipient = sArrValues(i)}
                        recipients.Add(recipient)
                    End If
                Next i

                ' asign to NotificationViewModel
                '!!! ID, typeDocId para los Mobiles
                Dim notification As NotificationViewModel = New NotificationViewModel() With {
                .Heading = "PAConcept. " & MessageHeading,
                .Content = MessageContent,
                .WebUrl = URL,
                .Parameters = New List(Of ParameterViewModel)(),
                .Recipients = recipients
             }

                ' INSERT RECORD TO DABATABASE
                Try
                    LocalAPI.PushNotification_INSERT("PASconcept", UserEmailList, MessageHeading, MessageContent, URL, "", companyId)
                Catch ex As Exception
                End Try

                Try
                    'Using httpClient = New HttpClient()
                    '    Dim jsonObject As String = JsonConvert.SerializeObject(notification)
                    '    Using content = New StringContent(jsonObject, Encoding.UTF8, "application/json")
                    '        Using response = httpClient.PostAsync(domainUrl & "notification/createnotification", content)
                    '            Return response.Result.ToString()
                    '        End Using
                    '    End Using
                    'End Using
                Catch ex As Exception
                End Try

            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Class NotificationViewModel
        Public Property Heading As String
        Public Property Content As String
        Public Property WebUrl As String
        Public Property Parameters As IEnumerable(Of ParameterViewModel)
        Public Property Recipients As IEnumerable(Of RecipientViewModel)
    End Class
    Public Class ParameterViewModel
        Public Property NameParameter As String
        Public Property Parameter As String
    End Class
    Public Class RecipientViewModel
        Public Property IdRecipient As String
        Public Property EmailRecipient As String
    End Class

End Class
