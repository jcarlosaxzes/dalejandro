Imports System.Net.Http
Imports Newtonsoft.Json

Module SendGrid
    Public Class AppEmail
        Public Property Name As String
        Public Property Email As String
    End Class

    Public Class AppEmailBody
        Public Property Subject As String
        Public Property [To] As AppEmail
        Public Property ReplyTo As AppEmail
        Public Property From As AppEmail = New AppEmail With {
            .Email = "info@pasconcept.com",
            .Name = "PASconcept"
        }
        Public Property Ccs As IEnumerable(Of AppEmail) = New List(Of AppEmail)()
        Public Property PlainTextContent As String
        Public Property HtmlContent As String
        Public Property IsExternal As Boolean
    End Class

    Public Class Email
        Public Shared Function SendMail(ByVal sTo As String, ByVal sCC As String, ByVal sCCO As String, ByVal sSubtject As String, ByVal sBody As String, ByVal companyId As Integer,
                                    Optional ByVal sFromMail As String = "", Optional ByVal sFromDisplay As String = "",
                                    Optional replyToMail As String = "", Optional ByVal sReplyToDisplay As String = "") As Boolean

            Return LocalAPI.SendMail(sTo, sCC, sCCO, sSubtject, sBody, companyId, sFromMail, sFromDisplay, replyToMail, sReplyToDisplay)

        End Function


        Public Shared Function SendMailSendGrid(ByVal sTo As String, ByVal sCC As String, ByVal sCCO As String, ByVal sSubtject As String, ByVal sBody As String, ByVal companyId As Integer,
                                    Optional ByVal sFromMail As String = "", Optional ByVal sFromDisplay As String = "",
                                    Optional replyToMail As String = "", Optional ByVal sReplyToDisplay As String = "") As Boolean
            Try


                Dim fromAddr As String
                Dim sUserName As String


                If companyId > 0 Then
                    ' Si existe credenciales de envio de email desde una company, se utilizan
                    fromAddr = LocalAPI.GetCompanyProperty(companyId, "webEmailUserName")
                    sUserName = LocalAPI.GetCompanyProperty(companyId, "webEmailUserName")
                End If

                Dim sFrom As String = sFromMail
                If sFrom.Length = 0 Then sFrom = fromAddr
                Dim sDisplay As String = sFromDisplay
                If sDisplay.Length = 0 Then sDisplay = IIf(companyId > 0, LocalAPI.GetCompanyProperty(companyId, "Name"), "PASconcept")


                Dim mails As AppEmailBody = New AppEmailBody()
                mails.From = New AppEmail() With {.Name = sDisplay, .Email = sFrom}
                Dim sCCs As ArrayList = New ArrayList()

                If ConfigurationManager.AppSettings("Debug") = "1" Then
                    mails.To = New AppEmail() With {.Name = "", .Email = "jcarlos@axzes.com"}
                Else
                    mails.To = New AppEmail() With {.Name = "", .Email = sTo}
                    If Len(sCC) > 0 Then
                        Dim sCCplit() As String = Split(sCC, ",")
                        For Each cc In sCCplit
                            If (LocalAPI.ValidEmail(cc)) Then
                                sCCs.Add(New AppEmail() With {.Name = "", .Email = cc})
                            End If
                        Next
                    End If
                    If Len(sCCO) > 0 Then
                        Dim sCCplit() As String = Split(sCCO, ",")
                        For Each cc In sCCplit
                            If (LocalAPI.ValidEmail(cc)) Then
                                sCCs.Add(New AppEmail() With {.Name = "", .Email = cc})
                            End If
                        Next
                    End If
                    mails.Ccs = sCCs.Cast(Of AppEmail)

                End If
                mails.Subject = sSubtject
                mails.HtmlContent = sBody
                If Len(replyToMail) > 0 Then
                    mails.ReplyTo = New AppEmail() With {.Name = sReplyToDisplay, .Email = replyToMail}
                End If

                Dim resutl As String
                Try
                    Dim hClient As HttpClient = New HttpClient()
                    Dim jsonObjectObj As String = JsonConvert.SerializeObject(mails)
                    Dim contentPayload = New StringContent(jsonObjectObj, Encoding.UTF8, "application/json")
                    Dim response = hClient.PostAsync("https://pasconceptsendemail.azurewebsites.net/api/SendEmail?code=2vzCvWTwZBjLn0wIv8UNdIeHIah6TjUu6AGcpvvCCoDzflGzKgiHSQ==", contentPayload)
                    resutl = response.Result.ToString()
                Catch ex As Exception
                    Return False
                End Try

                SendMailSendGrid = True

                If companyId > 0 Then
                    Dim sAdresses As String = sTo
                    If Len(sCC) > 0 And sTo <> sCC Then sAdresses = sAdresses & ";" & sCC
                    LocalAPI.SendMessage(sFrom, sAdresses, sSubtject, sBody, "", False, companyId)
                End If
            Catch ex As Exception
                Throw ex
            End Try
        End Function
    End Class

End Module
