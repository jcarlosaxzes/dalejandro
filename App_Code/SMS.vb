Imports Microsoft.VisualBasic
Imports System.Net
Imports System.IO

'   DDLCarrier
'<asp:DropDownList ID="DDLCarrier" runat="server">
'    <asp:ListItem Value="@text.att.net">AT&T</asp:ListItem>
'    <asp:ListItem Value="@cingularme.com">Cingular</asp:ListItem>
'    <asp:ListItem Value="@messaging.nextel.com">Nextel</asp:ListItem>
'    <asp:ListItem Value="@messaging.sprintpcs.com">Sprint</asp:ListItem>
'    <asp:ListItem Value="@tmomail.net">T-Mobile</asp:ListItem>
'    <asp:ListItem Value="@vtext.com">Verizon</asp:ListItem>
'    <asp:ListItem Value="@vmobl.com">Virgin Mobile</asp:ListItem>
'</asp:DropDownList>

''''''''''''''''''''''''''
'   clickatell service
''''''''''''''''''''''''''
'Client ID: PJEY04
'Username: axzes.com
'Password: Fernand0.
'https://central.clickatell.com/
' API Name: PASCONCEPT API
' API ID: 3541918
' Number from: 19546355214
' url: api.clickatell.com/http/sendmsg?user=juancperez&password=Fernand0.&api_id=3541918&to=13058075103&text=DimesitellegoesteSMS 


Public Class SMS

    Public Shared Function SendSMS(sPhoneNumber As String, sMessage As String, companyId As Integer) As Boolean
        Dim PrecioSMS As String = ConfigurationManager.AppSettings("SMS_Price")
        If ConfigurationManager.AppSettings("SMS") = "1" And Len(sMessage) > 0 Then
            ' Help: www.clickatell.com/apis-scripts/scripts/vb-net/
            Dim client As WebClient = New WebClient
            Dim SMS_api_id As Integer = LocalAPI.GetCompanyProperty(companyId, "SMS_api_id")
            If SMS_api_id > 0 Then
                ' Add a user agent header in case the requested URI contains a query.
                client.QueryString.Add("api_id", "3541918") ' Constante de momento, unica que esta pagada...
                'client.QueryString.Add("api_id", SMS_api_id)
                client.Headers.Add("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)")

                ' Parametros fijos de configuracion del servicio
                client.QueryString.Add("user", ConfigurationManager.AppSettings("SMS_user"))
                client.QueryString.Add("password", ConfigurationManager.AppSettings("SMS_password"))
                client.QueryString.Add("from", ConfigurationManager.AppSettings("SMS_from"))
                client.QueryString.Add("mo", ConfigurationManager.AppSettings("SMS_mo"))               ' 1 – Enable Reply

                ' Parametros dinamicos
                client.QueryString.Add("to", sPhoneNumber)
                client.QueryString.Add("text", sMessage)

                Dim baseurl As String = "http://api.clickatell.com/http/sendmsg"
                Dim data As Stream = client.OpenRead(baseurl)
                Dim reader As StreamReader = New StreamReader(data)
                Dim res As String = reader.ReadToEnd()
                data.Close()
                reader.Close()

                LocalAPI.sys_log_Nuevo_Ext(sPhoneNumber, LocalAPI.sys_log_AccionENUM.SMS_send, companyId, Left(sMessage, 80), PrecioSMS)
                If Left(res, 3) = "ID:" Then    ' Ej    ID: 73511d7163078d2dd655fe56178bbb83
                    Return True
                End If
            End If
        Else
            LocalAPI.sys_log_Nuevo_Ext(sPhoneNumber, LocalAPI.sys_log_AccionENUM.SMS_send, companyId, Left(sMessage, 80), PrecioSMS)
            Return True
        End If
    End Function

    Public Shared Function IsValidPhone(ByRef sPhoneNumber As String) As Boolean
        Try
            If Len(sPhoneNumber) >= 10 Then
                ' Quitar caracteres diferentes "-+. ()"
                sPhoneNumber = Replace(sPhoneNumber, "-", "")
                sPhoneNumber = Replace(sPhoneNumber, "+", "")
                sPhoneNumber = Replace(sPhoneNumber, ".", "")
                sPhoneNumber = Replace(sPhoneNumber, " ", "")
                sPhoneNumber = Replace(sPhoneNumber, "(", "")
                sPhoneNumber = Replace(sPhoneNumber, ")", "")

                Dim PhoneNumber As Long = sPhoneNumber

                If Len(sPhoneNumber) = 10 Then
                    sPhoneNumber = "1" & sPhoneNumber
                    Return True
                End If
                If Len(sPhoneNumber) = 11 Then
                    Return True
                End If
            End If
        Catch ex As Exception
            Return False
        End Try


    End Function

End Class
