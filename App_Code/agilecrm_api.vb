Imports Microsoft.VisualBasic
Imports System.Net
Imports System.Web
Imports System.IO
Imports System.Security.Cryptography.X509Certificates
Imports System.Web.Script.Serialization

Public Class Agile
    'Implements ICertificatePolicy
    '******Please insert your Domain Name and Api Key here********

    '*************************************************************
    Private Shared Function GetAgileEmail(companyId As integer) As String
        return LocalAPI.GetCompanyProperty(companyId,"agileEmail")   ' "Axzesllc@gmail.com"
    End Function

    Private Shared Function GetApiKey(companyId As integer) As String
        return LocalAPI.GetCompanyProperty(companyId,"agileApiKey")   ' "q9nrgnctvccs7nsepmu1laetor"
    End Function

    Private Shared Function GetDomainUrl(companyId As integer) As String
        Dim domain As String = LocalAPI.GetCompanyProperty(companyId,"agileDomain")   ' "Axzesllc"
        If Len(domain)>0 Then
            return "https://" & domain & ".agilecrm.com/core/js/api/"
        End If
    End Function

    Public Shared Function GetDomainUrl2(companyId As integer) As String
        Dim domain As String = LocalAPI.GetCompanyProperty(companyId,"agileDomain")   ' "Axzesllc"
        If Len(domain)>0 Then
            return "https://" & domain &  ".agilecrm.com/dev/api/"
        End If
    End Function

    Public Shared Function IsContact(email As String, companyId As integer) As Boolean
        Try
            Dim jsC = New JavaScriptSerializer()
            ' If not exist, json value of 'id' key is 'null'.
            Dim result As String = GetContact2(email, companyId)
            Dim dataC = jsC.Deserialize(Of Object)(result)
            Dim Id As String = dataC("id")

            Return True

        Catch ex As Exception
            Return False
        End Try
    End Function


    '
    '   * If no such contact found, returns a json string where value of 'id' key maps to 'null'.
    '   

    Public Shared Function GetContact(email As String, companyId As integer) As String
        Dim nextUrl As String = "contact/email/"
        Dim queryString As String = Convert.ToString("email=") & email

        Dim result As String = HttpGet(nextUrl, queryString, companyId)
        Return result
    End Function

    Public Shared Function GetContact2(email As String, companyId As integer) As String
        'https://github.com/agilecrm/c-sharp-api#1-contact
        Return agileCRM("contacts/search/email/" & email, "GET", Nothing, "application/json",companyId)
    End Function

    Public Shared Function DeleteContact2(email As String, companyId As integer) As String
        Dim res As String = GetContact2(email,companyId)

        Dim jsC = New JavaScriptSerializer()
        Dim resJson = jsC.Deserialize(Of Object)(res)

        Dim result As String = agileCRM("contacts/" &  resJson("id"), "DELETE", Nothing, "application/json",companyId)
        Return result
    End Function

    '
    '   * It creates a contact with description 'contactJson'.
    '   
    Public Shared Function CreateContact(contactJson As String, companyId As integer) As String
        Try

            Dim nextUrl As String = "contacts/"
            Dim queryString As String = "contact=" & System.Uri.EscapeDataString(contactJson)

            Dim result As String = HttpGet(nextUrl, queryString,companyId )
            Return result

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    '
    '   * Returns null if no contact is found otherwise a success status.
    '   

    Public Shared Function DeleteContact(email As String, companyId As integer) As String
        Dim nextUrl As String = "contact/delete/"
        Dim queryString As String = Convert.ToString("email=") & email

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Create a task represented by 'taskJson', in stringified json format, for contact associated with 'email'.
    '   

    Public Shared Function CreateTask(email As String, taskJson As String, companyId As integer) As String
        Dim nextUrl As String = "task/"
        Dim queryString As String = (Convert.ToString("email=") & email) & "&task=" & System.Uri.EscapeDataString(taskJson)

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Add deal and relate contact to the deal 'opportunity', in stringified json format.
    '   

    Public Shared Function CreateDeals(email As String, deal As String, companyId As integer) As String
        Dim nextUrl As String = "opportunity/"
        Dim queryString As String = (Convert.ToString("email=") & email) & "&opportunity=" & System.Uri.EscapeDataString(deal)

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Add/replace 'property', in stringified json format, with the contact associated with 'email'.
    '   

    Public Shared Function AddProperty(email As String, [property] As String, companyId As integer) As String
        Dim nextUrl As String = "contacts/add-property/"
        Dim queryString As String = (Convert.ToString("email=") & email) & "&data=" & System.Uri.EscapeDataString([property])

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Add 'note', in stringified json format, to the contact associated with 'email'
    '   

    Public Shared Function AddNote(email As String, note As String, companyId As integer) As String
        Dim nextUrl As String = "contacts/add-note/"
        Dim queryString As String = (Convert.ToString("email=") & email) & "&data=" & System.Uri.EscapeDataString(note)

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Add 'campaign', in stringified json format, to the contact associated 'email'.
    '   

    Public Shared Function AddCampaign(email As String, campaign As String, companyId As integer) As String
        Dim nextUrl As String = "contacts/add-campaign/"
        Dim queryString As String = (Convert.ToString("email=") & email) & "&data=" & System.Uri.EscapeDataString(campaign)

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Get template of gadget 'gadget'.
    '   

    Public Shared Function GetGadgetTemplate(gadget As String, companyId As integer) As String
        Dim nextUrl As String = "gmail-template/"
        Dim queryString As String = Convert.ToString("template=") & gadget

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Add 'score' to the score of contact associated with 'email' email. It always returns null.
    '   

    Public Shared Function AddScore(email As String, score As Integer, companyId As integer) As String
        Dim nextUrl As String = "contacts/add-score/"
        Dim queryString As String = (Convert.ToString("email=") & email) & "&score=" & score

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Subtract 'score' from the score of contact associated with 'email' email. It always returns null.
    '   

    Public Shared Function SubtractScore(email As String, score As Integer, companyId As integer) As String
        Dim nextUrl As String = "contacts/subtract-score/"
        Dim queryString As String = (Convert.ToString("email=") & email) & "&score=" & score

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Add tags mentioned in 'tags' to the contact with email 'email'. If tag is already present it returns the contact in stringified json object.
    '   

    Public Shared Function AddTags(email As String, tags As String, companyId As integer) As String
        Dim nextUrl As String = "contacts/add-tags/"
        Dim queryString As String = Convert.ToString((Convert.ToString("email=") & email) & "&tags=") & tags

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Remove tags mentioned in 'tags' to the contact with email 'email'. If tag is already absent, it returns contact in stringified json object.
    '   

    Public Shared Function RemoveTags(email As String, tags As String, companyId As integer) As String
        Dim nextUrl As String = "contacts/remove-tags/"
        Dim queryString As String = Convert.ToString((Convert.ToString("email=") & email) & "&tags=") & tags

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Enrolls a contact with contact id "contactId" to workflow with id "workflowId"
    '   

    ' ** It will return some EXCEPTION, IGNORE this.
    Public Shared Function SubscribeContact(contactId As Long, workflowId As Long, companyId As integer) As String
        Dim nextUrl As String = "campaign/enroll/" & contactId & "/" & workflowId & "/"
        Dim queryString As String = ""

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Returns the score of contact with email 'email'. If there's no such contact returns a null object.
    '   

    Public Shared Function GetScore(email As String, companyId As integer) As String
        Dim nextUrl As String = "contacts/get-score/"
        Dim queryString As String = Convert.ToString("email=") & email

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Returns the notes in sringified json object form of contact with email 'email'. If there's no such contact returns a null object.
    '   

    Public Shared Function GetNotes(email As String, companyId As integer) As String
        Dim nextUrl As String = "contacts/get-notes/"
        Dim queryString As String = Convert.ToString("email=") & email

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Returns the tags of contact with email 'email'. If there's no such contact returns a null object. Result will be stringified form of array of strings, eg., "[\"tag1\", \"tag2\"]"
    '   

    Public Shared Function GetTags(email As String, companyId As integer) As String
        Dim nextUrl As String = "contacts/get-tags/"
        Dim queryString As String = Convert.ToString("email=") & email

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Returns the tasks of contact with email 'email'. If there's no such contact returns a null object.
    '   

    Public Shared Function GetTasks(email As String, companyId As integer) As String
        Dim nextUrl As String = "contacts/get-tasks/"
        Dim queryString As String = Convert.ToString("email=") & email

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Returns the deals with contact with email 'email'. If there's no such contact returns a null object.
    '   

    Public Shared Function GetDeals(email As String, companyId As integer) As String
        Dim nextUrl As String = "contacts/get-deals/"
        Dim queryString As String = Convert.ToString("email=") & email

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Returns all the detail of the campaings with which contact with 'emai' is associated.
    '   

    Public Shared Function GetCampaigns(email As String, companyId As integer) As String
        Dim nextUrl As String = "contacts/get-campaigns/"
        Dim queryString As String = Convert.ToString("email=") & email

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Returns all log of the campaings with which contact with 'emai' is associated.
    '   

    Public Shared Function GetCampaignLogs(email As String, companyId As integer) As String
        Dim nextUrl As String = "contacts/get-campaign-logs/"
        Dim queryString As String = Convert.ToString("email=") & email

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '
    '   * Returns all the work flow of current domain user. Result will be stringified form of array of strings.
    '   

    Public Shared Function GetWorkflows(companyId As integer) As String
        Dim nextUrl As String = "contacts/get-workflows/"
        Dim queryString As String = ""

        Dim result As String = HttpGet(nextUrl, queryString,companyId)
        Return result
    End Function

    '***********************PRIVATE***************************************


    Private Shared Function HttpGet(nextUrl As String, queryString As String, companyId As integer) As String
        Try
            Dim url As String = Convert.ToString((GetDomainUrl(companyId) & nextUrl) & "?" & "id=") & GetApiKey(companyId)

            If Not String.IsNullOrEmpty(queryString) Then
                url += Convert.ToString("&") & queryString
            End If

            ' url = System.Web.HttpUtility.UrlEncode(url);   // Library not provided everywhere, at least at mono.
            'url = System.Uri.EscapeUriString(url);          // Should not be used for encoding whole url.
            'url = System.Uri.EscapeDataString(url);
            'url = System.Net.WebUtility.UrlEncode(url);

            'Console.WriteLine(url);

            Dim request As HttpWebRequest = TryCast(WebRequest.Create(url), HttpWebRequest)
            request.Method = "GET"
            Dim result As String = Nothing

            Using response As HttpWebResponse = TryCast(request.GetResponse(), HttpWebResponse)
                Dim dataStream As Stream = response.GetResponseStream()
                Dim reader As New StreamReader(dataStream)
                result = reader.ReadToEnd()

                reader.Close()
                dataStream.Close()
                response.Close()
            End Using

            Return result
        Catch e As Exception
            Return "Exception caught!!!" & vbLf & e.ToString()
        End Try
    End Function


    Private Shared Function agileCRM(nextUrl As String, method As String, data As String, contenttype As String, companyId As integer) As String
        Try
            Dim url As String = GetDomainUrl2(companyId) & nextUrl

            'Console.WriteLine(url);
            Dim encoded As [String] = System.Convert.ToBase64String(System.Text.Encoding.GetEncoding("ISO-8859-1").GetBytes(GetAgileEmail(companyId) + ":" + GetApiKey(companyId)))
            'Dim bytes As Byte() = System.Text.Encoding.UTF8.GetBytes(pPostData)
            Dim request As HttpWebRequest = TryCast(WebRequest.Create(url), HttpWebRequest)

            If Not String.IsNullOrEmpty(data) Then
                request.ContentLength = data.Length
            End If

            request.Method = method
            request.ContentType = contenttype
            request.Accept = "application/json"

            request.Headers.Add("Authorization", "Basic " + encoded)
            Dim result As String = Nothing

            Select Case method
                Case "GET"
                    Using response As HttpWebResponse = TryCast(request.GetResponse(), HttpWebResponse)
                        Dim dataStream As Stream = response.GetResponseStream()
                        Dim reader As New StreamReader(dataStream)
                        result = reader.ReadToEnd()

                        reader.Close()
                        dataStream.Close()
                        response.Close()
                    End Using

                    Return result
                    Exit Select
                Case "POST"
                    Using webStream As Stream = request.GetRequestStream()
                        Using requestWriter As New StreamWriter(webStream, System.Text.Encoding.ASCII)
                            requestWriter.Write(data)
                        End Using
                    End Using
                    Using response As HttpWebResponse = TryCast(request.GetResponse(), HttpWebResponse)
                        Dim dataStream As Stream = response.GetResponseStream()
                        Dim reader As New StreamReader(dataStream)
                        result = reader.ReadToEnd()

                        reader.Close()
                        dataStream.Close()
                        response.Close()
                    End Using

                    Return result
                    Exit Select
                Case "PUT"
                    Using webStream As Stream = request.GetRequestStream()
                        Using requestWriter As New StreamWriter(webStream, System.Text.Encoding.ASCII)
                            requestWriter.Write(data)
                        End Using
                    End Using
                    Using response As HttpWebResponse = TryCast(request.GetResponse(), HttpWebResponse)
                        Dim dataStream As Stream = response.GetResponseStream()
                        Dim reader As New StreamReader(dataStream)
                        result = reader.ReadToEnd()

                        reader.Close()
                        dataStream.Close()
                        response.Close()
                    End Using

                    Return result
                    Exit Select
                Case "DELETE"
                    Using response As HttpWebResponse = TryCast(request.GetResponse(), HttpWebResponse)
                        Dim dataStream As Stream = response.GetResponseStream()
                        Dim reader As New StreamReader(dataStream)
                        result = reader.ReadToEnd()

                        reader.Close()
                        dataStream.Close()
                        response.Close()
                    End Using

                    Return result
                    Exit Select
                Case Else
                    Return "nothing"
                    Exit Select



            End Select
        Catch e As Exception
            Return "Exception caught!!!" & vbLf + e.ToString()
        End Try
    End Function


    Public Function CheckValidationResult(sp As ServicePoint, certificate As X509Certificate, request As WebRequest, [error] As Integer) As Boolean
        Return True
    End Function
End Class

