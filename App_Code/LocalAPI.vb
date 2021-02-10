Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports System.Data
Imports System.Net.Mail
Imports System.IO
Imports System.Web.Configuration
Imports System.Runtime.Remoting.Contexts
Imports Telerik.Web.UI
Imports System.Configuration
Imports System.Threading.Tasks

Imports System.Linq

Imports Microsoft.AspNet.Identity.Owin
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNetCore.Identity

Imports System.Net
Imports System.Net.Http
Imports System.Net.Http.Headers
Imports System.Runtime.CompilerServices
Imports System.Text
Imports System.Web.Script.Serialization
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Converters

Imports Newtonsoft.Json.Linq

Imports HtmlAgilityPack
Public Class LocalAPI
    ' VARIABLES PUBLICAS DE LA SESSION
    Public DataBaseSubscriber As String
    Public Shared AppUserManager As pasconcept20.ApplicationUserManager
    Public Shared SiteUrl As String

#Region "Enum"
    Public Enum sys_log_AccionENUM
        AdminLogin = 1
        EmployeeLogin = 2
        ClientLogin = 3
        DeleteClient = 33
        SubconsultanLogin = 4
        SMS_send = 7
        EmailCampaign = 8
        NewJob = 101
        DeleteJob = 102
        NewProposal = 201
        DeleteProposal = 202
        AceptProposal = 205
        NewEmployee = 301
        InactiveEmployee = 302
        DeleteEmployee = 303
        NewClient = 401
        NewPaid = 601
        DeletePaid = 602
        NewJobLink = 901
        NewRFP = 1001
        DeleteRFP = 1002
        NewJobNote = 1101
        NewInvoice = 1201
        DeleteInvoice = 1202
        NewStatement = 1203
        DeleteStatement = 1204
        NewPaidDay = 1301
        NewTime = 1401
        NewNonJobTime = 1501
        NewSubconsultan = 1601
        PAS_IntuitQB = 2001
        UnhandleError = 404
        azure_post = 3001
    End Enum

    Public Enum MensajeOneTime_ENUM
        WELCOME_CLIENT_IMPROVED_30_10_2011 = 1
        WELCOME_SUBCONSULTAN_IMPROVED_30_10_2011 = 2
    End Enum

    Public Enum ProposalStatus_ENUM
        AllStatus = -1
        NotEmitted = 0
        Pending = 1
        Acepted = 2
        Declined = 3
        Hold = 4
        Declined_NotCompetitive = 31
        Declined_NotSubmitted = 32
    End Enum
    Public Enum RFPStatus_ENUM
        AllStatus = -1
        NoEmitted = 0
        Sent = 1
        Submitted = 2
        Acepted = 3
        Rejected = 4
        Declined = 5
        Closed = 6
    End Enum

    ''' <summary>
    ''' Enum linked to WebhookTypes table in Database
    ''' (Change indexes if table changes)
    ''' </summary>
    Public Enum PayPalWebhookType
        Plan = 1
        Subscription = 2
        Payment = 3
    End Enum

    ''' <summary>
    ''' Enum that represents PayPal Agreement's status
    ''' </summary>
    Public Enum PayPalAgreementStatus
        Active = 1
        Canceled = 0
    End Enum


    Public Structure ContactStruct
        Public ID As Integer
        Public FirstName As String
        Public LastName As String
        Public Company As String
        Public Position As String
        Public Address As String
        Public Address2 As String
        Public City As String
        Public State As String
        Public ZipCode As String
        Public Country As String
        Public FullHomeAddress As String
        Public Phone As String
        Public BusinessPhone As String
        Public Cellular As String
        Public Fax As String
        Public Email As String
        Public BusinessEmail As String
        Public Notes As String
        Public ContactType As String
        Public ContactSubtype As String
        Public ReferredBy As String
        Public WebPage As String
    End Structure


    Public Structure JobTicketStruct
        Public TicketId As Integer
        Public jobId As Integer
        Public LocationModule As String
        Public AppName As String
        Public Title As String
        Public ClientDescription As String
        Public CompanyDescription As String
        Public Notes As String
        Public Type As String
        Public Priority As String
        Public Status As String
        Public ApprovedStatus As String
        Public employeeId As Integer
        Public NotificationClientName As String
        Public NotificationClientEmail As String
        Public NotificationBCClientEmail As String
        Public trelloURL As String
        Public jiraURL As String
        Public Tags As String
        Public ExpectedStartDate As String
        Public StagingDate As String
        Public ProductionDate As String
        Public EstimatedHours As Double
    End Structure


    Public Structure LeadStruct
        Public Company As String
        Public FirstName As String
        Public LastName As String
        Public Email As String
        Public Phone As String
        Public Cellular As String
        Public Website As String
        Public AddressLine1 As String
        Public AddressLine2 As String
        Public City As String
        Public State As String
        Public ZipCode As String
        Public JobTitle As String
        Public Position As String
        Public Tags As String
        Public SourceId As Integer
    End Structure

#End Region

#Region "Miselaneas"
    Public Shared Function GetDateTime() As Date
        Return DateAdd(DateInterval.Hour, -5, Date.Now)
    End Function

    Public Shared Function UnixTimeStampToDateTime(unixTimeStamp As Int64) As DateTime
        Dim dtDateTime As System.DateTime = New DateTime(1970, 1, 1, 0, 0, 0, 0, System.DateTimeKind.Utc)
        dtDateTime = dtDateTime.AddSeconds(unixTimeStamp).ToLocalTime()
        Return dtDateTime
    End Function

    Public Shared Function DateTimeToUnixTimeStamp(sdate As DateTime) As Int64
        Dim epoch As DateTime = New DateTime(1970, 1, 1, 0, 0, 0, 0).ToLocalTime()
        Dim span As TimeSpan = (sdate.ToLocalTime() - epoch)
        Return CType(span.TotalSeconds, Int64)
    End Function


    Public Shared Function sys_VersionAndRevision(versionId As Integer) As String
        Dim sVerName As String = sys_VersionName(versionId)
        Return "Version: <b>" & sVerName & "</b>, Revision: 5.0.0 (Jan 15, 2020). Azure deployment"

        ' 4.3.0 (Feb 19, 2015)
        ' - Nueva funcionalidad para analisis por departments
        ' - Separadas las Bases de Datos PASconcept.mdf(datos) y pasconcept_users.mdf (user for Login)
        ' 4.3.0 (Mar 16, 2015)
        ' - Nueva funcionalidad DataProcessing.aspx
        ' 4.3.1 (Mar 20, 2015)
        ' - Nueva Page Dashboard.aspx
        ' 4.3.1 (Mar 24, 2015)
        ' - Proposal Aceptance tipo Shared, sin credenciales
        ' - Nueva Page ProjectMap.aspx
        ' 4.3.2 (Apr 14, 2015)
        ' - Proposal Aceptance tipo Shared, sin credenciales
        ' - Nueva Page ProjectMap.aspx
        ' 4.3.2 (Apr 23, 2015)
        ' - Job Edit
        ' - Nuevo estilo pot Tabs
        ' - New Proposal (Change Order)
        ' - Jobs List (Columna Status y Budget Used mas visuales)
        ' - Employee Efficiency Chart (4 Pesta�as con mucha mas info)
        ' 4.3.2 (May 04, 2015)
        ' - Invoices to Client with Related Links
        ' - RadWindows Maximized, Employee, Client and Job in PopPup
        ' - New Pages (Job, Proposal, Client, Employee) son PopUp y Navegan a Edit
        ' 4.3.2 (May 06, 2015)
        ' - Nuevo Skin = Silk
        ' 4.4.0 (May 12, 2015)
        ' - SMS Messages
        ' 4.4.0 (May 15, 2015)
        ' - Proposal PopUp con Tabs
        ' 4.4.1 (May 20, 2015)
        ' - Marketing Campaing
        ' - Movil Client Finder (CallTo:...)
        ' - Invoice Responsive para Movil
        ' - MASTER. Bill SMS, Bill Campaign, Bill SMS iBinderbook
        ' - MASTER. Update Jobs Geocodes
        ' - Job. Update Longitud, Latitud
        ' 4.4.2 (Jun 22, 2015)
        ' - ~/OPE/projects.aspx
        ' - ~/OPE/project.aspx (Job shared link)
        ' 4.4.3 (Jul 9, 2015)
        ' - Project Map (More...) link to Project Profile
        ' - Employee control of Vacation and Personal/Sick days
        ' - Request for Vacation/Personal days
        ' - Schedule. +Client Activity
        ' 4.4.4 (Jul 21, 2015)
        ' - Proposal Phaes 
        ' - Phases Templates
        ' - Edit Proposal Details with Phases
        ' - LiveDemo.aspx (version LiveDemo, user miamiengineeringinfo@gmail.com)
        ' - Multi Employees assined for Job
        ' 4.4.5 (Sep 29, 2015)
        ' - Client Availability field
        ' - Employee Default page (only employee Jobs, order by lastTime DESC
        ' - Project/Time Tags
        ' - Company Agreement Template (Manual and NonCompete)
        ' - Employee Agreement (Manual and NonCompete)
        ' 4.4.6 (Oct 16, 2015)
        ' - Al aceptar un Proposal y Crear el Job, CreateInvoicesFromPaymentSchedule 
        ' - Proposal.Retainer, al Aceptar un Proposal, se crea Job, se crea Invoice y se emite al cliente
        ' 4.5.0 (Sep 15, 2016)
        ' - All pages with responsive masterpage
        '  class=far fa-xxxxxxx
        ' - Contacts
        ' - Jobs/Proposal. Private Mode
        ' - Jobs Time/ Assign Employee by multiple employee
        ' - Employee Portal. New and more simple
        ' - Azure Upload in Jobs, Proposal, Clients
        ' - Billing Manager
        ' - New Filter panels less hight
        ' - Jobs Tags
        '4.6.0 (Feb 14, 2018)
        ' - Job Edit Full reviewed
    End Function

    Public Shared Function GetConnection() As SqlConnection
        Try
            Dim cnn1 As SqlConnection
            ' Connect to the source
            cnn1 = New SqlConnection(ConfigurationManager.ConnectionStrings("cnnProjectsAccounting").ToString)
            ' Open the database
            cnn1.Open()
            ' Return the object
            Return cnn1

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    ''' <summary>
    ''' Returns a new SqlConnection obj without its stream opened
    ''' </summary>
    ''' <returns></returns>
    Public Shared Function GetOpenConnection() As SqlConnection
        Try
            ' Connect to the source
            Dim cnnString = ConfigurationManager.ConnectionStrings("cnnProjectsAccounting").ConnectionString
            Dim cnn1 = New SqlConnection(cnnString)
            ' Return connection (object)
            Return cnn1
        Catch e As Exception
            Throw e
        End Try
    End Function

    Public Shared Function GetUsersConnection() As SqlConnection
        Try
            Dim cnn1 As SqlConnection
            ' Connect to the source
            cnn1 = New SqlConnection(ConfigurationManager.ConnectionStrings("cnnAspNetUsers").ToString)
            ' Open the database
            cnn1.Open()
            ' Return the object
            Return cnn1

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function IsFirewallViolation(UserId As Integer, IP_Address As String) As Boolean
        Dim URLFirewall As String = GetEmployeeProperty(UserId, "URLFirewall")
        If Len(URLFirewall) > 0 Then
            If InStr(URLFirewall, IP_Address) = 0 Then
                Return True
            End If
        End If
    End Function


    ''' <summary>
    ''' Generic Function to execute a Sql Query
    ''' </summary>
    ''' <param name="sSelectCommand"></param>
    ''' <returns></returns>
    Public Shared Function GetScalar(Of T)(sSelectCommand As String) As T
        Using cnn1 As SqlConnection = GetOpenConnection()
            Try
                cnn1.Open()
                Dim cmd = New SqlCommand(sSelectCommand, cnn1)
                Dim value = cmd.ExecuteScalar()
                If value Is Nothing OrElse value Is DBNull.Value Then
                    Return Nothing
                End If
                Return DirectCast(value, T)
            Catch e As Exception
                Throw e
            End Try
        End Using
    End Function

    ''' <summary>
    ''' Returns Company Logo img as a byte[] representation
    ''' </summary>
    ''' <param name="companyId"></param>
    ''' <returns></returns>
    Public Shared Function GetCompanyLogo(companyId As Integer) As Byte()
        Try
            Dim sQuery = "SELECT shortLogo FROM Company WHERE companyId=" & companyId
            Return GetScalar(Of Byte())(sQuery)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ''' <summary>
    ''' Returns Company Letter Head img as a byte[] representation
    ''' </summary>
    ''' <param name="companyId"></param>
    ''' <returns></returns>
    Public Shared Function GetCompanyLetterHead(companyId As Integer) As Byte()
        Try
            Dim sQuery = "SELECT imgLogo FROM Company WHERE companyId=" & companyId
            Return GetScalar(Of Byte())(sQuery)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetStringEscalar(ByVal sSelectCommand As String) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand(sSelectCommand, cnn1)
            GetStringEscalar = Convert.ToString(cmd.ExecuteScalar())
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetDateTimeEscalar(ByVal sSelectCommand As String) As DateTime
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand(sSelectCommand, cnn1)
            GetDateTimeEscalar = Convert.ToString(cmd.ExecuteScalar())
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetNumericEscalar(ByVal sSelectCommand As String) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand(sSelectCommand, cnn1)
            GetNumericEscalar = Convert.ToDouble(cmd.ExecuteScalar())
            cnn1.Close()
        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Shared Function ExecuteNonQuery(ByVal sCommandText As String) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            cmd.CommandText = sCommandText

            Dim lAffectedRecords As Integer = cmd.ExecuteNonQuery()
            cnn1.Close()

            Return lAffectedRecords
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetRecord(Id As Integer, StoreProcedureName As String) As Dictionary(Of String, Object)
        ' Devuelve un objeto con todos los valores del SELECT del store procedure
        ' El parametro de entrada debe llamarse "@Id"
        ' Ejemplo de Llamado y uso
        ' Dim verificationRecord = LocalAPI.GetRecord(verificationId,"VerificationRecord_SELECT")
        ' Dim SalesRep as String = verificationRecord("SalesRep")
        Dim result = New Dictionary(Of String, Object)()
        Try
            Using conn As SqlConnection = GetConnection()
                Using comm As New SqlCommand(StoreProcedureName, conn)
                    comm.CommandType = CommandType.StoredProcedure

                    Dim p0 As New SqlParameter("@Id", SqlDbType.Int)
                    p0.Direction = ParameterDirection.Input
                    p0.Value = Id
                    comm.Parameters.Add(p0)

                    Dim reader = comm.ExecuteReader()
                    If reader.HasRows Then
                        ' We only read one time (of course, its only one result :p)
                        reader.Read()
                        For lp As Integer = 0 To reader.FieldCount - 1
                            result.Add(reader.GetName(lp), reader.GetValue(lp))
                        Next
                    End If
                End Using
            End Using
            Return result
        Catch e As Exception
            Return result
        End Try
    End Function

    Public Shared Function GetRecordFromQuery(sql As String) As Dictionary(Of String, Object)
        ' Devuelve un objeto con todos los valores del SELECT
        Dim result = New Dictionary(Of String, Object)()
        Try
            Using conn As SqlConnection = GetConnection()
                Using comm As New SqlCommand(sql, conn)
                    comm.CommandType = CommandType.Text

                    Dim reader = comm.ExecuteReader()
                    If reader.HasRows Then
                        ' We only read one time (of course, its only one result :p)
                        reader.Read()
                        For lp As Integer = 0 To reader.FieldCount - 1
                            result.Add(reader.GetName(lp), reader.GetValue(lp))
                        Next
                    End If
                End Using
            End Using
            Return result
        Catch e As Exception
            Return result
        End Try
    End Function

    Public Shared Function GetRecordAllFromQuery(sql As String) As Dictionary(Of String, Object)
        ' Devuelve un objeto con todos los valores del SELECT
        Dim result = New Dictionary(Of String, Object)()
        Try
            Using conn As SqlConnection = GetConnection()
                Using comm As New SqlCommand(sql, conn)
                    comm.CommandType = CommandType.Text

                    Dim reader = comm.ExecuteReader()

                    If reader.HasRows Then
                        ' We only read one time (of course, its only one result :p)
                        reader.Read()
                        For lp As Integer = 0 To reader.FieldCount - 1
                            result.Add(reader.GetName(lp), reader.GetValue(lp))
                        Next
                    End If
                End Using
            End Using
            Return result
        Catch e As Exception
            Return result
        End Try
    End Function

    Public Shared Function sys_error_INSERT(ByVal companyId As Integer, userEmail As String, Message As String, Source As String, StackTrace As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "sys_error_INSERT"
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@userEmail", userEmail)
            cmd.Parameters.AddWithValue("@Message", Message)
            cmd.Parameters.AddWithValue("@Source", Source)
            cmd.Parameters.AddWithValue("@StackTrace", StackTrace)

            cmd.ExecuteNonQuery()

            cnn1.Close()
            Return True
        Catch ex As Exception

        End Try
    End Function
    Public Shared Function DefinirTheme(ByVal sUserAgent As String) As String
        'Try
        Return "Estandar"
        '    Dim sTheme As String = ConfigurationManager.AppSettings("ForzarTheme")
        '    If Len(sTheme) > 0 Then
        '        DefinirTheme = ConfigurationManager.AppSettings("ForzarTheme")
        '    Else
        '        If sUserAgent.Contains("Android") Or _
        '                                      sUserAgent.Contains("iPhone") Or _
        '                                        sUserAgent.Contains("iPad") Or _
        '                                        sUserAgent.Contains("BlackBerry") Then
        '            DefinirTheme = "SmartPhone"
        '        Else
        '            DefinirTheme = "Estandar"
        '        End If
        '    End If
        'Catch ex As Exception
        '    DefinirTheme = "Estandar"
        'End Try
    End Function

    Public Shared Function IsTabletOrSmarthphone(ByVal sUserAgent As String) As Boolean
        ' sUserAgent:=Request.UserAgent
        Try
            If sUserAgent.Contains("Android") Or
                                              sUserAgent.Contains("iPhone") Or
                                                sUserAgent.Contains("iPad") Or
                                                sUserAgent.Contains("BlackBerry") Then
                Return True
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function PhoneHTML(ByVal sUserAgent As String, sPhone As String) As String
        ' sUserAgent:=Request.UserAgent
        Dim nPhone As Long = Val(sPhone)
        Dim sFinalPhone As String
        Try
            If Len(nPhone.ToString) > 9 Then
                Dim FormatPhone As String = String.Format("{0:(###) ###-####}", nPhone)
                sFinalPhone = "<a href=" & """" & "tel:" & nPhone & """" & ">" & FormatPhone & "</a>"
                'If sUserAgent.Contains("Android") Then
                '    sFinalPhone = "<a href=" & """" & "tel:" & nPhone & """" & ">" & FormatPhone & "</a>"
                'ElseIf sUserAgent.Contains("iPhone") Then
                '    sFinalPhone = "<a href=" & """" & "tel:" & nPhone & """" & ">" & FormatPhone & "</a>"
                '    'sFinalPhone = "<a href=" & """" & "callto:" & nPhone & """" & ">" & FormatPhone & "</a>"
                'Else
                '    sFinalPhone = FormatPhone
                'End If
                Return sFinalPhone
            End If

        Catch ex As Exception
            Return ""
        End Try
    End Function

    Public Shared Function CallTo(ByVal sUserAgent As String, nPhone As Long) As String
        ' sUserAgent:=Request.UserAgent
        Try
            If Len(nPhone.ToString) > 9 Then
                'Dim FormatPhone As String = String.Format("{0:(###) ###-####}", nPhone)
                If sUserAgent.Contains("Android") Then
                    Return """" & "tel:" & nPhone & """"
                ElseIf sUserAgent.Contains("iPhone") Then
                    Return """" & "callto:" & nPhone & """"
                End If
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function PhoneHTMLFormat(nPhone As Long) As String
        ' sUserAgent:=Request.UserAgent
        Try
            If Len(nPhone.ToString) > 9 Then
                Return String.Format("{0:(###) ###-####}", nPhone)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function DegradadoDeColor(ByVal Value As Double, IsRate As String) As System.Drawing.Color
        If IsRate = "false" Then
            Return System.Drawing.Color.Black
        Else

            Select Case Value
                Case Is < 1.25
                    'Return System.Drawing.ColorTranslator.FromHtml("#00ff00")
                    Return System.Drawing.Color.YellowGreen

                Case Is < 1.5
                    'Return System.Drawing.ColorTranslator.FromHtml("#009900")
                    Return System.Drawing.Color.Green

                Case Is < 1.75
                    'Return System.Drawing.ColorTranslator.FromHtml("#bdbd00")
                    Return System.Drawing.Color.DarkGreen
                Case Is < 2
                    'Return System.Drawing.ColorTranslator.FromHtml("#606000")
                    Return System.Drawing.Color.Orange
                Case Is < 2.25
                    'Return System.Drawing.ColorTranslator.FromHtml("#683400")
                    Return System.Drawing.Color.DarkOrange
                Case Is < 2.5
                    'Return System.Drawing.ColorTranslator.FromHtml("#ca6500")
                    Return System.Drawing.Color.OrangeRed
                Case Is < 2.75
                    'Return System.Drawing.ColorTranslator.FromHtml("#ff0000")
                    Return System.Drawing.Color.Red
                Case Else
                    Return System.Drawing.Color.DarkRed
            End Select
        End If
    End Function

    Public Shared Function DegradadoDeColorPercent(ByVal Value As Double) As System.Drawing.Color

        Select Case Value
            Case Is < 13
                'Return System.Drawing.ColorTranslator.FromHtml("#00ff00")
                Return System.Drawing.Color.YellowGreen

            Case Is < 25
                'Return System.Drawing.ColorTranslator.FromHtml("#009900")
                Return System.Drawing.Color.Green

            Case Is < 38
                'Return System.Drawing.ColorTranslator.FromHtml("#bdbd00")
                Return System.Drawing.Color.DarkGreen
            Case Is < 50
                'Return System.Drawing.ColorTranslator.FromHtml("#606000")
                Return System.Drawing.Color.Orange
            Case Is < 63
                'Return System.Drawing.ColorTranslator.FromHtml("#683400")
                Return System.Drawing.Color.DarkOrange
            Case Is < 75
                'Return System.Drawing.ColorTranslator.FromHtml("#ca6500")
                Return System.Drawing.Color.OrangeRed
            Case Is < 88
                'Return System.Drawing.ColorTranslator.FromHtml("#ff0000")
                Return System.Drawing.Color.Red
            Case Else
                Return System.Drawing.Color.DarkRed
        End Select
    End Function

    Public Shared Function DegradadoDeColorInverso(ByVal Value As Double, IsRate As String) As System.Drawing.Color

        If IsRate = "false" Then
            Return System.Drawing.Color.Black
        Else
            Select Case Value
                Case Is < 0.13
                    'Return System.Drawing.ColorTranslator.FromHtml("#00ff00")
                    Return System.Drawing.Color.DarkRed

                Case Is < 0.21
                    'Return System.Drawing.ColorTranslator.FromHtml("#009900")
                    Return System.Drawing.Color.Red

                Case Is < 0.31
                    'Return System.Drawing.ColorTranslator.FromHtml("#bdbd00")
                    Return System.Drawing.Color.OrangeRed
                Case Is < 0.4
                    'Return System.Drawing.ColorTranslator.FromHtml("#606000")
                    Return System.Drawing.Color.DarkOrange
                Case Is < 0.5
                    'Return System.Drawing.ColorTranslator.FromHtml("#683400")
                    Return System.Drawing.Color.Orange
                Case Is < 0.65
                    'Return System.Drawing.ColorTranslator.FromHtml("#ca6500")
                    Return System.Drawing.Color.DarkGreen
                Case Is < 0.8
                    'Return System.Drawing.ColorTranslator.FromHtml("#ff0000")
                    Return System.Drawing.Color.Green
                Case Else
                    Return System.Drawing.Color.YellowGreen
            End Select
        End If
    End Function

    Public Shared Function DegradadoDeColorWorkload(ByVal Workload As Double) As System.Drawing.Color

        Select Case Workload
            Case Is > 2000
                Return System.Drawing.Color.DarkRed

            Case Is > 1000
                Return System.Drawing.Color.Red

            Case Is > 750
                Return System.Drawing.Color.OrangeRed
            Case Is > 500
                Return System.Drawing.Color.DarkOrange
            Case Is > 300
                Return System.Drawing.Color.Orange
            Case Is > 150
                Return System.Drawing.Color.DarkGreen
            Case Is > 50
                Return System.Drawing.Color.Green
            Case Else
                Return System.Drawing.Color.YellowGreen
        End Select
    End Function

    Public Shared Function DegradadoDeEfficiency(ByVal Efficiency As Double) As System.Drawing.Color

        Select Case Efficiency
            Case Is >= 150
                Return System.Drawing.Color.DarkRed

            Case Is > 100
                Return System.Drawing.Color.Red

            Case Is > 90
                Return System.Drawing.Color.OrangeRed
            Case Is > 85
                Return System.Drawing.Color.DarkOrange
            Case Is > 80
                Return System.Drawing.Color.Orange
            Case Is > 70
                Return System.Drawing.Color.DarkGreen
            Case Is > 50
                Return System.Drawing.Color.Green
            Case Else
                Return System.Drawing.Color.YellowGreen
        End Select
    End Function

    Public Shared Function FormatNumerosConSigno(ByVal Value As Double, decimales As Integer) As String
        Select Case Value
            Case 0
                Return "0"
            Case Is > 0
                Return "+" & FormatNumber(Value, decimales)
            Case Else
                Return FormatNumber(Value, decimales)

        End Select

    End Function
    Public Shared Function ClientStatusColor(ByVal Value As Double) As System.Drawing.Color
        Select Case Value
            Case 0  ' Inactive
                Return System.Drawing.Color.DarkRed
            Case 1  ' Active
                Return System.Drawing.Color.DarkGreen
            Case 2  ' Potencial
                Return System.Drawing.Color.DarkBlue
            Case 3 ' Prospective
                Return System.Drawing.Color.Black
            Case -1 ' Not defined
                Return System.Drawing.Color.White
        End Select
    End Function

    Public Shared ReadOnly Property MAXPaymentSchedule() As Integer
        Get
            Return 10
        End Get
    End Property

    Public Shared Function parseAddress(ByVal input As String,
                                        ByRef address1 As String,
                                        ByRef address2 As String,
                                        ByRef city As String,
                                        ByRef state As String,
                                        ByRef zip As String) As Boolean
        Try

            input = input.Replace(",", "")
            input = input.Replace("  ", " ")
            Dim splitString() As String = Split(input)
            Dim streetMarker() As String = New String() {"street", "st", "st.", "avenue", "ave", "ave.", "blvd", "blvd.", "highway", "hwy", "hwy.", "box", "road", "rd", "rd.", "lane", "ln", "ln.", "circle", "circ", "circ.", "court", "ct", "ct."}

            Dim streetMarkerIndex As Integer

            zip = splitString(splitString.Length - 1).ToString()
            state = splitString(splitString.Length - 2).ToString()
            streetMarkerIndex = getLastIndexOf(splitString, streetMarker) + 1
            Dim sb As New StringBuilder

            For counter As Integer = streetMarkerIndex To splitString.Length - 3
                sb.Append(splitString(counter) + " ")
            Next counter
            city = RTrim(sb.ToString())
            Dim addressIndex As Integer = 0

            For counter As Integer = 0 To streetMarkerIndex
                If IsNumeric(splitString(counter)) _
                    Or splitString(counter).ToString.ToLower = "po" _
                    Or splitString(counter).ToString().ToLower().Replace(".", "") = "po" Then
                    addressIndex = counter
                    Exit For
                End If
            Next counter

            sb = New StringBuilder
            For counter As Integer = addressIndex To streetMarkerIndex - 1
                sb.Append(splitString(counter) + " ")
            Next counter

            address1 = RTrim(sb.ToString())

            sb = New StringBuilder

            If addressIndex = 0 Then
                If splitString(splitString.Length - 2).ToString() <> splitString(streetMarkerIndex + 1) Then
                    For counter As Integer = streetMarkerIndex To splitString.Length - 2
                        sb.Append(splitString(counter) + " ")
                    Next counter
                End If
            Else
                For counter As Integer = 0 To addressIndex - 1
                    sb.Append(splitString(counter) + " ")
                Next counter
            End If
            address2 = RTrim(sb.ToString())

            Return True
        Catch ex As Exception
            Return False
        End Try

    End Function

    Private Shared Function getLastIndexOf(ByVal sArray As String(), ByVal checkArray As String()) As Integer
        Dim sourceIndex As Integer = 0
        Dim outputIndex As Integer = 0
        For Each item As String In checkArray
            For Each source As String In sArray
                If source.ToLower = item.ToLower Then
                    outputIndex = sourceIndex
                    If item.ToLower = "box" Then
                        outputIndex = outputIndex + 1
                    End If
                End If
                sourceIndex = sourceIndex + 1
            Next
            sourceIndex = 0
        Next
        Return outputIndex
    End Function

    Private Shared Function Base64ToImage(base64String As String) As System.Drawing.Image
        Dim imgBytes As Byte() = Convert.FromBase64String(base64String)
        Dim ms As New System.IO.MemoryStream(imgBytes, 0, imgBytes.Length)
        ms.Write(imgBytes, 0, imgBytes.Length)
        Dim res As System.Drawing.Image = System.Drawing.Image.FromStream(ms, True)
        Return res
    End Function

    Private Shared Function Base64ToByteArray(base64String As String) As Byte()
        Dim imgBytes As Byte() = Convert.FromBase64String(base64String)
    End Function

    Public Function imageToByteArray(imageIn As System.Drawing.Image) As Byte()
        Dim ms As New MemoryStream()
        imageIn.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return ms.ToArray()
    End Function

    Public Shared Sub DownloadRemoteImageToFile(strURL As String, fileName As String)
        Dim client As New WebClient
        client.DownloadFile(strURL, fileName)
    End Sub


    Public Shared Sub DownloadRemoteImageToFile2(uri As String, fileName As String)
        Try

            Dim request As HttpWebRequest = DirectCast(WebRequest.Create(uri), HttpWebRequest)
            Dim response As HttpWebResponse = DirectCast(request.GetResponse(), HttpWebResponse)

            ' Check that the remote file was found. The ContentType
            ' check is performed since a request for a non-existent
            ' image file might be redirected to a 404-page, which would
            ' yield the StatusCode "OK", even though the image was not
            ' found.
            'If (response.StatusCode = HttpStatusCode.OK OrElse response.StatusCode = HttpStatusCode.Moved OrElse response.StatusCode = HttpStatusCode.Redirect) AndAlso response.ContentType.StartsWith("image", StringComparison.OrdinalIgnoreCase) Then

            ' if the remote file was found, download oit
            Using inputStream As Stream = response.GetResponseStream()
                Using outputStream As Stream = File.OpenWrite(fileName)
                    Dim buffer As Byte() = New Byte(4095) {}
                    Dim bytesRead As Integer
                    Do
                        bytesRead = inputStream.Read(buffer, 0, buffer.Length)
                        outputStream.Write(buffer, 0, bytesRead)
                    Loop While bytesRead <> 0
                End Using
            End Using
            'End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Private Shared Function FormatearNumero2Tsql(ByVal sVal As String) As String
        If sVal.Length = 0 Then sVal = "0"
        FormatearNumero2Tsql = Decimal.Parse(sVal)
        'FormatearMoney = sVal.Replace(",", ".")
    End Function

    Public Shared Function GetHostAppSite() As String
        Try
            Return HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority)
        Catch ex As Exception
            Return SiteUrl
        End Try
        'If Len(GetHostAppSite) = 0 Then GetHostAppSite = "https://pasconcept.com/"

        'HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) Return https://localhost:44308
        'HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Path) Return https://localhost:44308/adm/sharelink
        'HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Query) Return https://localhost:44308/adm/sharelink?ObjType=111&ObjId=23396
        'HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Scheme) Return https://


    End Function
    Public Shared Function GetCompanyBySubDomain() As Integer
        If HttpContext.Current.Session("IsMultiCompany") = "Verdadero" Then
            Return 0
        End If

        If HttpContext.Current.Session("IsMultiCompany") = "Falso" Then
            Return HttpContext.Current.Session("IsMultiCompanyId")
        End If

        Dim hostName As String = LocalAPI.GetHostAppSite()
        Dim hostCompany As Integer = LocalAPI.GetNumericEscalar($"Select isnull(companyId,0) As companyId from Company where SubDomain='{hostName}'")
        If hostCompany = 0 Then
            HttpContext.Current.Session("IsMultiCompany") = "Verdadero"
        Else
            HttpContext.Current.Session("IsMultiCompany") = "Falso"
            HttpContext.Current.Session("IsMultiCompanyId") = hostCompany
        End If
        Return hostCompany
    End Function

    Public Shared Function GetSubscriberDatabase(ByVal sSubscriberCode As String) As String
        Dim cnn1 As OleDbConnection
        cnn1 = New OleDbConnection(ConfigurationManager.ConnectionStrings("cnnSubscribers").ToString)
        cnn1.Open()
        Try
            Dim cmd As New OleDbCommand("SELECT [DatabaseName] FROM [Subscribers] WHERE [Code]='" & sSubscriberCode & "'", cnn1)
            Dim rdr As OleDbDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetSubscriberDatabase = "" & rdr("DatabaseName")
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function urlProjectLocationGmap(sProjectLocation As String) As String
        If Len(sProjectLocation) > 0 Then
            Return "http://maps.google.com/?q=" & sProjectLocation
        Else
            Return "http://maps.google.com?q=Miami"
        End If
    End Function

    Private Shared Function AddWorkDays(ByVal startDate As Date, ByVal workDays As Integer) As Date
        Dim endDate As Date = startDate
        Dim n As Integer = 0
        If workDays > 0 Then
            n = 1
        ElseIf workDays < 0 Then
            n = -1
        End If
        If n <> 0 Then
            For i = 1 To Math.Abs(workDays)
                endDate = endDate.AddDays(n)
                While (endDate.DayOfWeek = DayOfWeek.Saturday OrElse endDate.DayOfWeek = DayOfWeek.Sunday)
                    endDate = endDate.AddDays(n)
                End While
            Next
        End If
        Return endDate
    End Function

    Public Shared Function GetDateUTHlocal() As String
        Return "DateAdd(hour,-5,GetDate())"
    End Function


    Public Shared Function GetDateFromOfTimeFrame(TimeFrameId As Integer) As DateTime
        '@TimeFrameId
        '    1:  All Years
        '    2:  Last Years
        '    3:  This Years
        '    4:  Last Quarter
        '    5:  This Quarter
        '    6:  Last Month
        '    7:  This Month
        '    8:  Last 30 Days
        '    9:  Last 15 Days
        '    10: Last 7 Days
        '    11: Last  Day
        '    12: Today
        '    13: MTD Y - 1
        '    14: MTD
        '    15: QTD Y - 1
        '    16: QTD
        '    17: YTD Y - 1
        '    18: YTD

        Return GetDateTimeEscalar(String.Format("select dbo.GetDateFromOfTimeFrame({0})", TimeFrameId))
    End Function

    Public Shared Function GetDateToOfTimeFrame(TimeFrameId As Integer) As DateTime
        '@TimeFrameId
        '	1:  All Years
        '    2:  Last Years
        '    3:  This Years
        '    4:  Last Quarter
        '    5:  This Quarter
        '    6:  Last Month
        '    7:  This Month
        '    8:  Last 30 Days
        '    9:  Last 15 Days
        '    10: Last 7 Days
        '    11: Last  Day
        '    12: Today

        '13:     TDY-1(for MTD Y-1, QTD Y-1, YTD Y-1) Today Time 00:00:00 -365
        '	14: TD(for MTD, QTD, YTD.) Today: Time 0:  00:00 period starting from the beginning of the current X up until now 
        '										… but Not including today's date, because it might not be complete yet.

        Return GetDateTimeEscalar(String.Format("select dbo.GetDateToOfTimeFrame({0})", TimeFrameId))
    End Function


    Public Shared Function GetMailTemplateFromHTML(TemplateName As String) As String
        Try
            Dim sBody = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("~/MailTemplates/" & TemplateName))
            Return sBody
        Catch e As Exception
            Throw e
        End Try
    End Function

    Public Shared Function GetAmount(Amount As String) As Double
        Try

            Dim dAmount As Double = 0
            Amount = Replace(Amount, ",", "")
            Amount = Replace(Amount, "$", "")
            Amount = Replace(Amount, "(", "")
            Amount = Replace(Amount, ")", "")
            Amount = Replace(Amount, """", "")
            Amount = Replace(Amount, " ", "")
            If Len(Amount) > 0 Then
                dAmount = Amount
            End If
            Return dAmount
        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Shared Function GetPhoneNumber(Phone As String) As String
        Try
            If Len(Phone) = 0 Then
                Return ""
            Else
                Dim PhoneNumber As String
                PhoneNumber = Replace(Phone, "-", "")
                PhoneNumber = Replace(PhoneNumber, " ", "")
                PhoneNumber = Replace(PhoneNumber, "+", "")
                PhoneNumber = Replace(PhoneNumber, ".", "")
                PhoneNumber = Replace(PhoneNumber, " ", "")
                PhoneNumber = Replace(PhoneNumber, "(", "")
                PhoneNumber = Replace(PhoneNumber, ")", "")
                PhoneNumber = Left(PhoneNumber, 10)
                Return PhoneNumber
            End If
        Catch ex As Exception
            Return ""
        End Try
    End Function

    Public Shared Function GetName(Name As String) As String
        Name = Replace(Name, """", "")
        Name = Replace(Name, ".", "")
        Return Trim(Name)
    End Function

    Public Shared Function FormatByteSize(bytesSize As Int64) As String
        Dim sizes As String() = {"B", "KB", "MB", "GB", "TB"}
        Dim order As Integer = 0
        While bytesSize >= 1024 AndAlso order < sizes.Length - 1
            order += 1
            bytesSize = bytesSize / 1024
        End While
        Dim result As String = String.Format("{0:0.##} {1}", bytesSize, sizes(order))
        Return result
    End Function


    Public Shared Function TruncateString(value As String, maxLength As Integer) As String
        If String.IsNullOrEmpty(value) Then Return value
        Return If(value.Length <= maxLength, value, value.Substring(0, maxLength) & "...")
    End Function

#End Region

#Region "RFP"
    Public Shared Function RFPNumber(ByVal Id As Integer) As String
        Return GetStringEscalar("SELECT dbo.RFPNumber(" & Id & ")")
    End Function

    Public Shared Function GetRFPStatusLabelCSS(ByVal status As String) As String
        Select Case status
            Case "0", "Not Emitted"
                Return "badge badge-secondary statuslabel"

            Case "1", "Pending", "Sent"  'In Progress
                Return "badge badge-info statuslabel"

            Case "2", "Responded", "Submitted"
                Return "badge badge-warning statuslabel"

            Case "3", "Accepted"
                Return "badge badge-success"

            Case "4", "Rejected", "5", "Declined"
                Return "badge badge-danger statuslabel"

            Case "6", "Closed"
                Return "badge badge-dark statuslabel"
        End Select
    End Function

    Public Shared Function GetRFPIdFromGUID(rfpGUID As String) As Integer
        'inject sql!!! Return GetNumericEscalar("SELECT ISNULL(Id,0) FROM RequestForProposals WHERE [guid]='" & rfpGUID & "'")
        Dim cnn1 As SqlConnection = GetConnection()
        Dim cmd As New SqlCommand("SELECT ISNULL(Id,0) FROM RequestForProposals WHERE [guid]=@rfpGUID", cnn1)
        cmd.Parameters.AddWithValue("@rfpGUID", rfpGUID)
        GetRFPIdFromGUID = Convert.ToDouble(cmd.ExecuteScalar())
        cnn1.Close()
    End Function

    Public Shared Function SetRFPStatus(ByVal rfpId As Integer, ByVal nSatus As RFPStatus_ENUM, Optional ByVal sDeclinedNotes As String = "", Optional ByVal jobId As Integer = -1) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            Select Case nSatus
                Case RFPStatus_ENUM.Sent
                    cmd.CommandText = "UPDATE [RequestForProposals] SET [StateId]=" & nSatus & ",DateSended=dbo.CurrentTime(), Emitted=isnull(Emitted,0)+1 WHERE Id=" & rfpId
                Case RFPStatus_ENUM.Submitted
                    cmd.CommandText = "UPDATE [RequestForProposals] SET [StateId]=" & nSatus & ", [RespondedDate]=dbo.CurrentTime() WHERE Id=" & rfpId
                Case RFPStatus_ENUM.Acepted
                    cmd.CommandText = "UPDATE [RequestForProposals] Set [StateId]=" & nSatus & ", [AceptedDate]=dbo.CurrentTime(), [jobId]=" & jobId & " WHERE Id=" & rfpId
                Case RFPStatus_ENUM.Rejected
                    cmd.CommandText = "UPDATE [RequestForProposals] Set [StateId]=" & nSatus & ", [AceptedDate]=dbo.CurrentTime(), [DeclinedNotes]='" & sDeclinedNotes & "' WHERE Id=" & rfpId
                Case RFPStatus_ENUM.Declined
                    cmd.CommandText = "UPDATE [RequestForProposals] SET [StateId]=" & nSatus & ", [AceptedDate]=dbo.CurrentTime(), [DeclinedNotes]='" & sDeclinedNotes & "' WHERE Id=" & rfpId
            End Select

            cmd.ExecuteNonQuery()
            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function SetRFPEmmited(ByVal rfpId As Integer) As Boolean
        Try
            Return ExecuteNonQuery("UPDATE [RequestForProposals] SET DateSended=dbo.CurrentTime(), Emitted=isnull(Emitted,0)+1 WHERE Id=" & rfpId)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function RFP_INSERT(disciplineId As Integer, subconsultanId As Integer, ProjectName As String, ProjectLocation As String, ProjectArea As String, ProjectDescription As String,
                                      PaymentSchedule1 As Double, PaymentText1 As String, PaymentSchedule2 As Double, PaymentText2 As String, PaymentSchedule3 As Double, PaymentText3 As String,
                                      PaymentSchedule4 As Double, PaymentText4 As String, PaymentSchedule5 As Double, PaymentText5 As String, PaymentSchedule6 As Double, PaymentText6 As String,
                                      PaymentSchedule7 As Double, PaymentText7 As String, PaymentSchedule8 As Double, PaymentText8 As String, PaymentSchedule9 As Double, PaymentText9 As String,
                                      PaymentSchedule10 As Double, PaymentText10 As String, MyAgreements As String, Sender As String, SenderEmail As String, IntroductoryText As String,
                                      DateSended As DateTime, ParentID As Integer, companyId As Integer
                                      ) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            Dim rfpId As Integer = 0

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "RFP_INSERT"
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@disciplineId", disciplineId)
            cmd.Parameters.AddWithValue("@subconsultanId", subconsultanId)
            cmd.Parameters.AddWithValue("@ProjectName", ProjectName)
            cmd.Parameters.AddWithValue("@ProjectLocation", ProjectLocation)
            cmd.Parameters.AddWithValue("@ProjectArea", ProjectArea)
            cmd.Parameters.AddWithValue("@ProjectDescription", ProjectDescription)
            cmd.Parameters.AddWithValue("@PaymentSchedule1", PaymentSchedule1)
            cmd.Parameters.AddWithValue("@PaymentText1", PaymentText1)
            cmd.Parameters.AddWithValue("@PaymentSchedule2", PaymentSchedule2)
            cmd.Parameters.AddWithValue("@PaymentText2", PaymentText2)
            cmd.Parameters.AddWithValue("@PaymentSchedule3", PaymentSchedule3)
            cmd.Parameters.AddWithValue("@PaymentText3", PaymentText3)
            cmd.Parameters.AddWithValue("@PaymentSchedule4", PaymentSchedule4)
            cmd.Parameters.AddWithValue("@PaymentText4", PaymentText4)
            cmd.Parameters.AddWithValue("@PaymentSchedule5", PaymentSchedule5)
            cmd.Parameters.AddWithValue("@PaymentText5", PaymentText5)
            cmd.Parameters.AddWithValue("@PaymentSchedule6", PaymentSchedule6)
            cmd.Parameters.AddWithValue("@PaymentText6", PaymentText6)
            cmd.Parameters.AddWithValue("@PaymentSchedule7", PaymentSchedule7)
            cmd.Parameters.AddWithValue("@PaymentText7", PaymentText7)
            cmd.Parameters.AddWithValue("@PaymentSchedule8", PaymentSchedule8)
            cmd.Parameters.AddWithValue("@PaymentText8", PaymentText8)
            cmd.Parameters.AddWithValue("@PaymentSchedule9", PaymentSchedule9)
            cmd.Parameters.AddWithValue("@PaymentText9", PaymentText9)
            cmd.Parameters.AddWithValue("@PaymentSchedule10", PaymentSchedule10)
            cmd.Parameters.AddWithValue("@PaymentText10", PaymentText10)

            cmd.Parameters.AddWithValue("@MyAgreements", MyAgreements)
            cmd.Parameters.AddWithValue("@Sender", Sender)
            cmd.Parameters.AddWithValue("@SenderEmail", SenderEmail)
            cmd.Parameters.AddWithValue("@DateSended", DateSended)
            cmd.Parameters.AddWithValue("@IntroductoryText", IntroductoryText)
            cmd.Parameters.AddWithValue("@guiId", Guid.NewGuid.ToString())
            cmd.Parameters.AddWithValue("ParentID", ParentID)
            cmd.Parameters.AddWithValue("companyId", companyId)

            ' Set up the output parameter 
            Dim parId As SqlParameter = New SqlParameter("@rfpId_OUT", SqlDbType.Int)
            parId.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            rfpId = parId.Value
            cnn1.Close()

            Return rfpId
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetRFPProperty(ByVal lId As Long, ByRef sProperty As String) As String
        Try

            Select Case sProperty
                Case "guid", "ProjectName", "ProjectLocation", "ProjectDescription", "MyAgreements", "Agreements", "IntroductoryText"
                    Return GetStringEscalar("SELECT TOP 1 isnull([" & sProperty & "],'') FROM RequestForProposals where Id=" & lId)
                Case "disciplineId", "subconsultanId", "companyId", "jobId", "StateId", "Total"
                    Return GetNumericEscalar("SELECT TOP 1 isnull([" & sProperty & "],0) FROM RequestForProposals where Id=" & lId)
                Case Else
                    Return GetStringEscalar("SELECT ISNULL(" & sProperty & ",'') " &
                                            "FROM RequestForProposals LEFT OUTER JOIN Company ON RequestForProposals.companyId = Company.companyId LEFT OUTER JOIN SubConsultans ON RequestForProposals.subconsultanId = SubConsultans.Id " &
                                            "WHERE RequestForProposals.Id=" & lId)
            End Select

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function NewRFP_for_Existing_Project(ByVal rfpId_SOURCE As Integer, subconsultanId As Integer) As Integer
        Dim cnn1 As SqlConnection = GetConnection()
        Try


            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "RFP_DUPLICATE"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@rfpId_SOURCE", rfpId_SOURCE)
            cmd.Parameters.AddWithValue("@subconsultanId", subconsultanId)
            ' Execute the stored procedure.
            Dim parOUT_ID As New SqlParameter("@rfpId_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            Return parOUT_ID.Value

        Catch ex As Exception
            Throw ex
        Finally
            cnn1.Close()
        End Try

    End Function

    Public Shared Function GetRFPTotal(ByVal nYear As Int16, ByVal nMes As Int16, ByVal nStatusId As ProposalStatus_ENUM, ByVal lSubconsultantId As Integer, ByVal companyId As Integer) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim sWhere As String = "WHERE companyId=" & companyId & " AND YEAR(DateCreated)=" & nYear
            If nMes > 0 Then sWhere = sWhere & " AND Month(DateCreated)=" & nMes
            If nStatusId >= 0 Then sWhere = sWhere & " AND ISNULL([StateId],0)=" & nStatusId
            If lSubconsultantId > 0 Then sWhere = sWhere & " AND ISNULL([subconsultanId],0)=" & lSubconsultantId

            Dim cmd As New SqlCommand("SELECT ISNULL(SUM(LineTotal),0) AS Expr1 FROM RequestForProposals INNER JOIN RequestForProposals_details ON RequestForProposals.Id = RequestForProposals_details.rfpId  " & sWhere, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetRFPTotal = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetMyRPFPending(UserEmail As String) As Integer
        Return GetNumericEscalar("SELECT COUNT(*) AS Expr1 FROM RequestForProposals INNER JOIN SubConsultans ON RequestForProposals.subconsultanId = SubConsultans.Id WHERE StateId=2 and SubConsultans.Email='" & UserEmail & "'")
    End Function

    Public Shared Function NotificarRFP(ByVal rfpId As Integer) As Boolean
        Try
            Dim RFPObject = LocalAPI.GetRecord(rfpId, "RFP_SELECT")

            Dim sSign = LocalAPI.GetCompanySign(RFPObject("companyId"))
            Dim sSubject As String = LocalAPI.GetMessageTemplateSubject("New RFP", RFPObject("companyId"))
            Dim sBody As String = LocalAPI.GetMessageTemplateBody("New RFP", RFPObject("companyId"))
            sBody = Replace(sBody, "[Sign]", sSign)

            sBody = sBody & "<br/>" & LocalAPI.GetPASSign()

            ' Sustituir variables
            sSubject = Replace(sSubject, "[Prime Name]", RFPObject("CompanyName"))
            sSubject = Replace(sSubject, "[Project Name]", RFPObject("ProjectName"))

            sBody = Replace(sBody, "[Prime Name]", RFPObject("CompanyName"))
            sBody = Replace(sBody, "[Subconsultant Name]", RFPObject("SubconsultantName"))
            sBody = Replace(sBody, "[Project Name]", RFPObject("ProjectName"))

            Dim sURLPASconceptUser As String = LocalAPI.GetSharedLink_URL(2003, rfpId)
            Dim sURLGetst As String = LocalAPI.GetSharedLink_URL(2002, rfpId)
            sBody = Replace(sBody, "[PASconcept_link]", sURLPASconceptUser)
            sBody = Replace(sBody, "[Guest_Link]", sURLGetst)

            Dim jobId = LocalAPI.GetRFPProperty(rfpId, "jobId")
            Dim clientId = "0"
            If Not String.IsNullOrEmpty(jobId) Then
                clientId = LocalAPI.GetJobProperty(jobId, "Client")
            End If

            SendGrid.Email.SendMail(RFPObject("SubConsultanstEmail"), RFPObject("SenderEmail"), "", sSubject, sBody, RFPObject("companyId"), clientId, jobId, RFPObject("SenderEmail"), RFPObject("CompanyName"), RFPObject("SenderEmail"))


            Return True

        Catch ex As Exception
            Throw ex
        End Try
    End Function

#End Region

#Region "Company"
    Public Shared Function GetCompanyProperty(ByVal companyId As Long, ByVal sProperty As String) As String
        Try
            Select Case sProperty
                Case "webEmailPort"
                    Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],25) FROM [Company] WHERE [companyId]=" & companyId)

                Case "Multiplier"
                    Return GetCompanyMultiplier(companyId, GetDateTime().Year)

                Case "webEmailEnableSsl", "webEmailPort", "Inactive", "Billing_plan", "Version", "Type", "SMS_api_id", "PayHereMax", "AxzesClientId", "AxzesJobId", "webUseDefaultCredentials", "Custom"
                    Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],0) FROM [Company] WHERE [companyId]=" & companyId)

                Case "StartYear"
                    Return GetStringEscalar("SELECT Year([StartDate]) FROM [Company] WHERE [companyId]=" & companyId)

                Case Else
                    Return GetStringEscalar("SELECT ISNULL([" & sProperty & "],'') FROM [Company] WHERE [companyId]=" & companyId)

            End Select
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function IsCompanyViolation(entityId As Integer, Entity As String, companyId As Integer) As Boolean
        Return IIf(GetNumericEscalar(String.Format("select count(*) from [{0}] where Id={1} and [companyId]={2}", Entity, entityId, companyId)) = 0, True, False)
    End Function
    Public Shared Function GetCompanyMultiplier(ByVal companyId As Integer, Year As Integer) As Double
        Dim Multiplier As Double = GetNumericEscalar($"SELECT ISNULL([Multiplier],0) FROM [Company_MultiplierByYear] WHERE [companyId]={companyId} and [Year]={Year}")
        Return IIf(Multiplier < 1, 1, Multiplier)
    End Function

    Public Shared Function GetCompanyMaxFileSizeForUpload(ByVal companyId As Integer) As Integer
        Dim MaxFileSize As Double = GetNumericEscalar($"SELECT ISNULL([MaxFileSize],0) FROM [Company] WHERE [companyId]={companyId}")
        If MaxFileSize = 0 Then
            ' Default MaxFileSize (1048576)
            Return 1048576
        Else
            Return MaxFileSize
        End If
    End Function


    Public Shared Function IsCompanyTwilio(companyId As Integer) As Boolean
        Return IIf(GetNumericEscalar($"select count(*) from [Company_twiliosetting] where companyId={companyId} and Active=1") = 1, True, False)
    End Function

    Public Shared Function IsCompanyNotification(ByVal companyId As Integer, NotificationField As String) As Boolean
        Try

            Return GetNumericEscalar("SELECT ISNULL(" & NotificationField & ",0) FROM [Company] WHERE companyId=" & companyId)

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function IsCompanySMSservice(ByVal companyId As Integer) As Boolean
        Return IsCompanyTwilio(companyId)
    End Function


    Public Shared Function GetCompanyMultiplierProperty(ByVal companyId As Integer, sProperty As String) As Double
        Try
            Select Case sProperty
                Case "Salary", "SalaryTax", "SubContracts", "Rent", "Others", "Total", "ProductiveSalary", "Profit", "TotalAndProfit"
                    Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],0) FROM [Company_MultiplierByYear] WHERE [companyId]=" & companyId & " and [Year]=" & GetDateTime().Year)

                Case "Multiplier"
                    Return GetCompanyMultiplier(companyId, GetDateTime().Year)

            End Select
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function BindCompanyToAxzesClient(ByVal companyId As Integer, clientId As Integer) As Integer
        Try

            If clientId = 0 Then
                ' Create Client first
                Dim cnn1 As SqlConnection = GetConnection()
                Dim cmd As SqlCommand = cnn1.CreateCommand()

                ' ClienteEmail
                ' Setup the command to execute the stored procedure.
                cmd.CommandText = "AxzesClientFromCompany_INSERT"
                cmd.CommandType = CommandType.StoredProcedure

                ' Set up the input parameter 
                cmd.Parameters.AddWithValue("@companyId", companyId)
                ' Execute the stored procedure.
                Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
                parOUT_ID.Direction = ParameterDirection.Output
                cmd.Parameters.Add(parOUT_ID)

                cmd.ExecuteNonQuery()

                clientId = parOUT_ID.Value
                cnn1.Close()
            End If
            ' Bind 
            ExecuteNonQuery(String.Format("UPDATE [Company] Set [AxzesClientId]={0} WHERE companyId={1}", clientId, companyId))
            Return clientId
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function BindCompanyToAxzesJob(ByVal companyId As Integer, clientId As Integer, jobId As Integer) As Boolean
        If jobId = 0 Then
            ' Create Job

            Dim sJobCode As String = GetNextJobCode(Right(Year(GetDateTime()), 2), 260973)
            Dim companyName As String = GetCompanyName(companyId)
            jobId = NuevoJob(sJobCode, companyName & " Services PASconcept Subscription", Date.Today, clientId, 0, 0, "001", 149, "", "", 0, "", "", 61, "", 149, 0, 260973, True)
        End If
        ' Job -> AllowOpenBudget
        ExecuteNonQuery(String.Format("UPDATE [Jobs] Set [AllowOpenBudget]=1 WHERE Id={0}", jobId))
        ' Bind 
        Return ExecuteNonQuery(String.Format("UPDATE [Company] Set [AxzesJobId]={0} WHERE companyId={1}", jobId, companyId))
    End Function

    Public Shared Function BindCompanyToAxzesInvoice(jobId As Integer, ByVal Company_PaymentsId As Integer, AxzesInvoiceId As Integer) As Integer
        Try

            If AxzesInvoiceId = 0 Then

                Dim Company_PaymentObject = GetRecord(Company_PaymentsId, "Company_Payment_Select")

                ' New Axzes Invoice
                AxzesInvoiceId = Invoice_INSERT(jobId, Company_PaymentObject("CreateDate"), Company_PaymentObject("Amount"), Company_PaymentObject("Notes"), Company_PaymentObject("ExpirationDate"))

                ' New Payment?
                If Company_PaymentObject("Status") = "Paid" Then
                    Invoice_Payment_INSERT(AxzesInvoiceId, Company_PaymentObject("PaidDate"), Company_PaymentObject("Method"), Company_PaymentObject("Amount"), "Automatic payment from PASconcet subscription", 0)
                End If

            End If

            ' Bind 

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Company_Payments_BindInvoiceAxzes_UPDATE"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Company_PaymentsId", Company_PaymentsId)
            cmd.Parameters.AddWithValue("@AxzesInvoiceId", AxzesInvoiceId)

            cmd.ExecuteNonQuery()
            cnn1.Close()

            Return AxzesInvoiceId
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function GetCompanyMultiplierStatusLabelCSS(ByVal status As String) As String
        Select Case UCase(status)
            Case "YES"
                Return "badge badge-success statuslabel"
            Case Else   ' NO'
                Return "badge badge-danger statuslabel"
        End Select

    End Function


    Public Shared Function CompanyMultiplier_INSERT(companyId As Integer, Year As Integer, Salary As Double, SubContracts As Double, Rent As Double, Others As Double, ProductiveSalary As Double, Profit As Double, CalculateSalary As Integer, CalculateProductiveSalary As Integer, InitializeEmployee As Integer, CalculateBudgetDepartment As Integer, Closed As Integer) As Integer
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "CompanyMultiplierRecord_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@Year", Year)
            cmd.Parameters.AddWithValue("@Salary", Salary)
            cmd.Parameters.AddWithValue("@SubContracts", SubContracts)
            cmd.Parameters.AddWithValue("@Rent", Rent)
            cmd.Parameters.AddWithValue("@Others", Others)
            cmd.Parameters.AddWithValue("@ProductiveSalary", ProductiveSalary)
            cmd.Parameters.AddWithValue("@Profit", Profit)
            cmd.Parameters.AddWithValue("@CalculateSalary", CalculateSalary)
            cmd.Parameters.AddWithValue("@CalculateProductiveSalary", CalculateProductiveSalary)
            cmd.Parameters.AddWithValue("@InitializeEmployee", InitializeEmployee)
            cmd.Parameters.AddWithValue("@CalculateBudgetDepartment", CalculateBudgetDepartment)
            cmd.Parameters.AddWithValue("@Closed", Closed)

            cmd.ExecuteNonQuery()
            cnn1.Close()

            Return GetNumericEscalar($"select Id from Company_MultiplierByYear where companyId={companyId} and year={Year}")

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function CompanyPayrollCallendar_InitYear(year As Integer, companyId As Integer) As Boolean
        Try

            Dim dDate As DateTime = GetLastPaidDay(companyId)

            While dDate.Year <= year
                dDate = DateAdd(DateInterval.Day, 14, dDate)
                NuevoPaidDay(dDate, companyId)
            End While

            Return True

        Catch ex As Exception

        End Try
    End Function

    Public Shared Function AllCompanyPayrollCallendar_InitYear(year As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("select companyId from Company where ISNULL(Company.BlockSubcriptionExpired, 0)=0", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader

            Do While rdr.Read()
                If rdr.HasRows Then
                    CompanyPayrollCallendar_InitYear(year,rdr("companyId"))
                End If
            Loop

            rdr.Close()
            cnn1.Close()

        Catch ex As Exception

        End Try
    End Function

    Public Shared Function CompanyMultiplier_UPDATE(Id As Integer, Salary As Double, SubContracts As Double, Rent As Double, Others As Double, ProductiveSalary As Double, Profit As Double, CalculateSalary As Integer, CalculateProductiveSalary As Integer, InitializeEmployee As Integer, CalculateBudgetDepartment As Integer, Closed As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "CompanyMultiplierRecord_UPDATE"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Salary", Salary)
            cmd.Parameters.AddWithValue("@SubContracts", SubContracts)
            cmd.Parameters.AddWithValue("@Rent", Rent)
            cmd.Parameters.AddWithValue("@Others", Others)
            cmd.Parameters.AddWithValue("@ProductiveSalary", ProductiveSalary)
            cmd.Parameters.AddWithValue("@Profit", Profit)
            cmd.Parameters.AddWithValue("@CalculateSalary", CalculateSalary)
            cmd.Parameters.AddWithValue("@CalculateProductiveSalary", CalculateProductiveSalary)
            cmd.Parameters.AddWithValue("@InitializeEmployee", InitializeEmployee)
            cmd.Parameters.AddWithValue("@CalculateBudgetDepartment", CalculateBudgetDepartment)
            cmd.Parameters.AddWithValue("@Closed", Closed)
            cmd.Parameters.AddWithValue("@Id", Id)

            cmd.ExecuteNonQuery()
            cnn1.Close()

            Return True

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function CompanyMultiplier_DELETE(companyId As Integer, Year As Integer) As Boolean
        Try

            Dim MultiplierId As Integer = LocalAPI.GetNumericEscalar($"select Id from Company_MultiplierByYear where companyId={companyId} and year={Year}")

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "CompanyMultiplierRecord_DELETE"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Id", MultiplierId)

            cmd.ExecuteNonQuery()
            cnn1.Close()

            Return True

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function CompanyCalculateMultiplier(ByVal companyId As Integer, YearValue As Integer) As Double
        Try
            Dim MultiplierId As Integer = GetNumericEscalar($"select top 1 Id from Company_MultiplierByYear WHERE companyId={companyId} and [Year]={YearValue}")
            Dim RecordObject = LocalAPI.GetRecord(MultiplierId, "CompanyMultiplierRecord_SELECT")

            ' If Closed?
            If RecordObject("Closed") = 0 Then
                If RecordObject("InitializeEmployee") = 1 Then
                    ' Before Calculate
                    EmployeesHourlyWage_INSERT(YearValue, companyId)

                    ' Calculate....................................................................
                    Dim cnn1 As SqlConnection = GetConnection()
                    Dim cmd As SqlCommand = cnn1.CreateCommand()

                    cmd.CommandText = "CompanyCalculateMultiplier_CALCULATE"
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@year", YearValue)
                    cmd.Parameters.AddWithValue("@companyId", companyId)

                    cmd.ExecuteNonQuery()

                    cnn1.Close()

                    ' After Calculate
                    If RecordObject("CalculateBudgetDepartment") = 1 Then
                        DeparmentBudgetByBaseSalaryForMultiplierFromThisMonth(companyId, RecordObject("Multiplier"), YearValue, IIf(YearValue = Year(Today), Month(Today), 1))
                    End If
                End If
            End If

            Return GetCompanyMultiplier(companyId, YearValue)

        Catch ex As Exception

        End Try
    End Function

    Public Shared Function GetMaxYearOfCompanyMultiplier(ByVal companyId As Integer) As Integer
        Dim MaxYear As Integer = GetNumericEscalar($"SELECT max([Year]) FROM [Company_MultiplierByYear] WHERE [companyId]={companyId}")
        If MaxYear > 0 Then
            Return MaxYear
        Else
            Return GetCompanyProperty(companyId, "StartYear")
        End If
    End Function




    Public Shared Function EmployeesUpdateHourlyRate(ByVal companyId As Integer, Multiplier As Double) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "EmployeesHourlyRate_UPDATE"
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@Multiplier", Multiplier)
            cmd.Parameters.AddWithValue("@companyId", companyId)

            cmd.ExecuteNonQuery()

            cnn1.Close()
            Return True
        Catch ex As Exception

        End Try
    End Function
    Public Shared Function GetCompanyName(ByVal companyId As Integer) As String
        Return GetStringEscalar("SELECT [Name] FROM [Company] WHERE [companyId]=" & companyId)
    End Function

    Public Shared Function GetCompanyLaguage(ByVal companyId As Integer) As String
        Return GetStringEscalar("SELECT ISNULL([Language],'en') FROM [Company] WHERE [companyId]=" & companyId)
    End Function

    Public Shared Function GetCompanybillingExpirationDate(ByVal companyId As Long) As Date
        Return GetStringEscalar("SELECT billingExpirationDate FROM [Company] WHERE [companyId]=" & companyId)
    End Function

    Public Shared Function GetCompanyBillingAmount(ByVal companyId As Integer) As Double
        Return GetStringEscalar(String.Format("SELECT dbo.GetCompanybillingAmount({0})", companyId))
    End Function

    Public Shared Function CompanyExpirationDateUpdate(ByVal companyId As Integer, NewExpirationDate As DateTime) As Boolean

        Return ExecuteNonQuery(String.Format("UPDATE [Company] SET [billingExpirationDate]={0} ,AlertMasterSubscriptionExpired = 0, SendRenewSubscription = 0 WHERE [companyId]={1}", GetFecha_102(NewExpirationDate), companyId))
    End Function

    Public Shared Function GetCompanyHRemail(ByVal companyId As Long) As String
        Dim sEmail As String = GetCompanyProperty(companyId, "HR_Email")

        If Len(sEmail) > 4 Then
            Return sEmail
        Else
            Return GetCompanyProperty(companyId, "Email")
        End If
    End Function

    Public Shared Function GetCompanyHRname(ByVal companyId As Long) As String
        Dim sName As String = GetCompanyProperty(companyId, "HR_Name")

        If Len(sName) > 0 Then
            Return sName
        Else
            Return "Human Resource manager"
        End If
    End Function
    Public Shared Function GetCompanySign(ByVal companyId As Long) As String
        Try
            Dim sSign As New System.Text.StringBuilder
            sSign.Append("<br />")
            sSign.Append("<strong>" & GetCompanyProperty(companyId, "EmailSign") & "</strong>")
            sSign.Append("<br />")
            sSign.Append(GetCompanyProperty(companyId, "EmailSign2"))

            GetCompanySign = sSign.ToString
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetPASSign() As String
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT [dbo].[PASConcepSign] ()", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetPASSign = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetPASShortSign() As String
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT [dbo].[PASConcepShortSign] ()", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetPASShortSign = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function NewCompany_Agreements_TEMPLATE(ByRef companyId As Integer) As Boolean
        Try
            If GetNumericEscalar("SELECT COUNT(*) FROM [Company_Agreements_TEMPLATE] WHERE companyId=" & companyId) = 0 Then
                Return ExecuteNonQuery("INSERT INTO Company_Agreements_TEMPLATE(EmployeeManual, EmployeeNonCompete, companyId) VALUES('Employee Manual...','Employee NonCompete...'," & companyId & ")")
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetSettingStatusCSS(ByVal status As String) As String
        Select Case status
            Case "poor"
                Return "badge badge-danger"
            Case "fair"
                Return "badge badge-warning"
            Case "excellent"
                Return "badge badge-success"
            Case Else
                Return "badge badge-secondary"
        End Select
    End Function

#End Region

#Region "Jobs"

    Public Shared Function GetJobStatusLabelCSS(ByVal statusId As Integer) As String
        '        0   Not in Progress		"default"
        '        1   Inactive		"default"
        '        2   In Progress		"success"
        '        3   On Hold			"danger"
        '        4   Submitted		"warning"
        '        5   Under Revision		"danger"
        '        6   Approved		"info"
        '        7   Done			"primary"
        Select Case statusId
            Case 0  'Not in Progress
                Return "badge badge-secondary statuslabel"
            Case 1  'Inactive
                Return "badge badge-light statuslabel"
            Case 2  'In Progress
                Return "badge badge-success statuslabel"
            Case 3  'On Hold,
                Return "badge badge-danger statuslabel"
            Case 4  'Submitted
                Return "badge badge-warning statuslabel"
            Case 5    ' Under Revision
                Return "badge badge-info statuslabel"
            Case 6  ''Approved
                Return "badge badge-primary statuslabel"
            Case 7  ' Done
                Return "badge badge-dark statuslabel"
        End Select
    End Function

    Public Shared Function GetBudgetUsedCss(ByVal dPercent As Double) As String
        Try

            If dPercent < 25 Then
                Return "GreenYellowProgressBar"
            ElseIf dPercent < 50 Then
                Return "GreenProgressBar"
            ElseIf dPercent < 75 Then
                Return "OrangeProgressBar" 'System.Drawing.Color.Orange
            ElseIf dPercent < 100 Then
                Return "OrangeRedProgressBar" 'System.Drawing.Color.OrangeRed
            Else
                Return "RedProgressBar" 'System.Drawing.Color.DarkRed
            End If
        Catch ex As Exception
            Return "GreenYellowProgressBar"
        End Try
    End Function


    Public Shared Function GetPercentUpLabelCSS(ByVal PercentValue As Integer) As String
        Select Case PercentValue
            Case 0 To 33
                Return "badge badge-pill badge-secondary"
            Case 34 To 66
                Return "badge badge-pill badge-success"
            Case 67 To 99
                Return "badge badge-pill badge-warning"
            Case >= 100
                Return "badge badge-pill badge-danger"
        End Select
    End Function
    Public Shared Function GetPercentDonwLabelCSS(ByVal PercentValue As Integer) As String
        Select Case PercentValue
            Case 0 To 33
                Return "badge badge-pill badge-danger"
            Case 34 To 66
                Return "badge badge-pill badge-warning"
            Case 67 To 99
                Return "badge badge-pill badge-secondary"
            Case >= 100
                Return "badge badge-pill badge-success"
        End Select
    End Function


    Public Shared Function GetJobStatusColorCSS(ByVal statusId As Integer) As String
        '        0   Not in Progress		"default"
        '        1   Inactive		"default"
        '        2   In Progress		"success"
        '        3   On Hold			"danger"
        '        4   Submitted		"warning"
        '        5   Under Revision		"danger"
        '        6   Approved		"info"
        '        7   Done			"primary"
        Select Case statusId
            Case 0  'Not in Progress
                Return "color:#6c757d"
            Case 1  'Inactive
                Return "badge badge-light"
            Case 2  'In Progress
                Return "color:#28a745"
            Case 3  'On Hold,
                Return "color:#dc3545"
            Case 4  'Submitted
                Return "color:#d39e00"
            Case 5    ' Under Revision
                Return "color:#17a2b8"
            Case 6  ''Approved
                Return "color:#007bff"
            Case 7  ' Done
                Return "color:#343a40"
        End Select
    End Function

    Public Shared Function GetJobStatusButonCSS(ByVal statusId As Integer) As String
        '        0   Not in Progress		"default"
        '        1   Inactive		"default"
        '        2   In Progress		"success"
        '        3   On Hold			"danger"
        '        4   Submitted		"warning"
        '        5   Under Revision		"danger"
        '        6   Approved		"info"
        '        7   Done			"primary"
        Select Case statusId
            Case 0  'Not in Progress
                Return "btn btn-secondary"
            Case 1  'Inactive
                Return "btn btn-light"
            Case 2  'In Progress
                Return "btn btn-success"
            Case 3  'On Hold,
                Return "btn btn-danger"
            Case 4  'Submitted
                Return "btn btn-warning"
            Case 5    ' Under Revision
                Return "btn btn-info"
            Case 6  ''Approved
                Return "btn btn-primary"
            Case 7  ' Done
                Return "btn btn-dark"
        End Select
    End Function

    Public Shared Function GetInvoicePastDueLabelCSS(ByVal pastdue_status As String) As String
        Select Case pastdue_status
            Case "90D+"
                Return "badge badge-danger statuslabel"
            Case "61 to 90D"
                Return "badge badge-warning statuslabel"
            Case "31 to 60D"
                Return "badge badge-info statuslabel"
            Case "1 to 30D"
                Return "badge badge-secondary statuslabel"
            Case Else
                Return ""
        End Select
    End Function

    Public Shared Function ConvertSpanTags(Value As String) As String
        Dim sRet As String = ""
        If Len(Value) > 0 Then

            ' Comienzo, inicio de Tabla
            sRet = "<table><tr><td>" & Value

            ' Dentro del Tag
            sRet = Replace(sRet, "[", "<span class='badge badge-secondary'>")
            sRet = Replace(sRet, "]", "</span>")

            ' Entre cada Tag
            sRet = Replace(sRet, ",", "</td></tr><tr><td>")

            ' Finalizar cierre Tabla
            sRet = sRet & "</td></tr></table>"
        End If
        Return sRet
    End Function

    Public Shared Function JobMailStatusChange(jobId As Integer, employeeId As Integer, statusName As String, companyId As Integer) As Boolean
        Try
            '
            Dim EmployeeName As String = GetEmployeeName(employeeId)
            Dim EmployeeEmail As String = GetEmployeeEmail(employeeId)
            Dim sJobName As String = LocalAPI.GetJobCodeName(jobId)
            Dim sJobCode As String = LocalAPI.GetJobCode(jobId)
            Dim sSubject As String = "Job " & sJobCode & " change to " & statusName & " status"
            Dim sMsg As New System.Text.StringBuilder

            sMsg.Append("Greetings,")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append(EmployeeName & " changed the status of job <strong>" & sJobName & "</strong> to " & statusName)
            sMsg.Append("<br />")
            sMsg.Append("Date: " & LocalAPI.GetDateTime())
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("PASconcept Notifications")
            sMsg.Append("<br />")
            sMsg.Append(LocalAPI.GetPASSign())

            Dim sBody As String = sMsg.ToString
            Dim sTo As String = GetHeadDepartmentEmailFromJob(jobId)
            Dim clientID = LocalAPI.GetJobProperty(jobId, "Client")
            Task.Run(Function() SendGrid.Email.SendMail(sTo, EmployeeEmail, "", sSubject, sBody, companyId, clientID, jobId))

            Dim recipientEmailSent As String = sTo & "," & EmployeeEmail
            OneSignalNotification.SendNotification(recipientEmailSent, "Job status changed", EmployeeName & " changed the status of job " & sJobName & " to " & statusName, "", companyId)

        Catch ex As Exception

        End Try

    End Function



    Public Shared Function IsAlertJobEndDay(employeeId As Integer) As Integer
        Try
            ' Devuelve el primer Job que este asignado al employee y EndDay sea Null or vencido hace "7" day y Status Active
            Return GetNumericEscalar("select top 1 Id from jobs WHERE (EndDay is Null or EndDay<DateAdd(day,-7,GetDate())) and status=2 and employee=" & employeeId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function NuevoJob(ByRef sCode As String,
                                        ByRef sJob As String,
                                        ByRef sOpen_date As DateTime,
                                        ByRef lClient As Integer,
                                        ByRef dBudget As Double,
                                        ByVal ProposalTemplate As Integer,
                                        ByVal sType As String,
                                        ByVal nEmployee As Integer,
                                        ByVal sProjectLocation As String,
                                        ByVal sProjectArea As String,
                                        ByVal nSector As Integer,
                                        ByVal sCodeUse As String,
                                        ByVal sCodeUse2 As String,
                                        ByVal nDpto As Integer,
                                        ByVal OwnerName As String,
                                        ByVal AEofRecord As Integer,
                                        ByVal ConstructionCost As Double,
                                        ByVal companyId As Integer,
                                    Optional bEmailToEmployee As Boolean = True) As Long
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            If LocalAPI.GetCompanyProperty(companyId, "Type") = 16 And nSector = 0 Then
                ' Initialize for IT companies
                nSector = 2
                sCodeUse = "B"
            End If

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "JOB_FORM_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Code", sCode)
            cmd.Parameters.AddWithValue("@JobName", sJob)
            cmd.Parameters.AddWithValue("@Open_date", sOpen_date)
            cmd.Parameters.AddWithValue("@ClientId", lClient)
            cmd.Parameters.AddWithValue("@Budget", dBudget)
            cmd.Parameters.AddWithValue("@ProposalType", ProposalTemplate)
            cmd.Parameters.AddWithValue("@Type", sType)
            cmd.Parameters.AddWithValue("@EmployeeId", nEmployee)
            cmd.Parameters.AddWithValue("@Status", -1)
            cmd.Parameters.AddWithValue("@ProjectLocation", sProjectLocation)
            cmd.Parameters.AddWithValue("@ProjectArea", sProjectArea)
            cmd.Parameters.AddWithValue("@ProjectSector", nSector)
            cmd.Parameters.AddWithValue("@ProjectUse", sCodeUse)
            cmd.Parameters.AddWithValue("@ProjectUse2", sCodeUse2)
            cmd.Parameters.AddWithValue("@DepartmentId", nDpto)
            cmd.Parameters.AddWithValue("@OwnerName", OwnerName)
            cmd.Parameters.AddWithValue("@RecordBy", AEofRecord)
            cmd.Parameters.AddWithValue("@Cost", ConstructionCost)
            cmd.Parameters.AddWithValue("@companyId", companyId)

            ' Execute the stored procedure.
            Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            Dim lJobId As Integer = parOUT_ID.Value
            cnn1.Close()

            'cmd.CommandText = "INSERT INTO [Jobs] (Code, Job,Open_date,Client,Budget, ProposalType, Type,Employee, Status, ProjectLocation, ProjectArea, ProjectSector, ProjectUse, ProjectUse2, DepartmentId, Owner, RecordBy, Cost, companyId, [guid]) " &
            '                                        "VALUES ('" & sCode & "',@JobName," &
            '                                            GetFecha_102(sOpen_date) & "," &
            '                                            Val(lClient.ToString) & "," &
            '                                            IIf(Len(mBudget) > 0, FormatearNumero2Tsql(mBudget), "0") & "," &
            '                                            ProposalTemplate & ",'" &
            '                                            sType & "'," &
            '                                            nEmployee & "-1,@ProjectLocation,'" &
            '                                            sProjectArea & "'," &
            '                                            nSector & ",'" &
            '                                            sCodeUse & "','" &
            '                                            sCodeUse2 & "'," &
            '                                            nDpto & ",@OwnerName," &
            '                                            IIf(AEofRecord > 0, AEofRecord, "NULL") & "," &
            '                                            ConstructionCost & "," &
            '                                            companyId & ", NewID())"
            'cmd.Parameters.AddWithValue("@JobName", sJob)
            'cmd.Parameters.AddWithValue("@ProjectLocation", sProjectLocation)
            'cmd.Parameters.AddWithValue("@OwnerName", OwnerName)
            'cmd.ExecuteNonQuery()
            'cnn1.Close()

            ' Leer Id del Job creado ''GetJobData_ob(sCode, "Id", companyId)
            ' Dim lJobId As Integer = GetNumericEscalar("SELECT [Id] FROM [Jobs] WHERE companyId=" & companyId & " AND [Code]='" & sCode & "'")

            ' Actualizar cambios de status
            ' Ultimo parametro no se va a usar
            SetJobStatus(lJobId, 0, nEmployee, companyId, 0)

            ' Email to employee
            If nEmployee > 0 Then

                ' Update Department
                ExecuteNonQuery("UPDATE [Jobs] Set [DepartmentId]=(select DepartmentId from Employees where Id=" & nEmployee & ") WHERE Id=" & lJobId)

                If bEmailToEmployee Then
                    LocalAPI.Jobs_Employees_assigned_INSERT(lJobId, nEmployee, 0, 0)

                    Dim sCodejobClientType As String = sCode & "-" & GetClientInitials(lClient) & "-" & sType
                    Dim sFullBody As New System.Text.StringBuilder
                    sFullBody.Append("You have been assigned Job " & sCode & ", '" & sJob & "', on " & FormatDateTime(sOpen_date, DateFormat.ShortDate) & "")
                    sFullBody.Append("<br />")
                    sFullBody.Append("Client: '" & GetClientName(lClient) & "'")
                    sFullBody.Append("<br />")
                    sFullBody.Append("Type of Project: '" & GetJobTypeName(sType) & "'")

                    EmailToEmployee(nEmployee, "Job " & sCodejobClientType & ", '" & sJob & "' assigned", sFullBody, companyId)
                End If
            End If

            LocalAPI.Clients_activities_INSERT(lClient, "C", "Jobs", lJobId, nEmployee)

            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewJob, companyId, sCode)

            Return lJobId

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function EliminarJob(ByVal lId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            cmd.CommandText = "DELETE FROM [Jobs] WHERE Id=" & lId.ToString
            cmd.ExecuteNonQuery()

            cmd.CommandText = "DELETE FROM [Employees_time] WHERE Job=" & lId.ToString
            cmd.ExecuteNonQuery()

            cmd.CommandText = "DELETE FROM [Invoices] WHERE JobId=" & lId.ToString
            cmd.ExecuteNonQuery()

            cmd.CommandText = "DELETE FROM [Jobs_Subcontracts] WHERE JobId=" & lId.ToString
            cmd.ExecuteNonQuery()

            cmd.CommandText = "DELETE FROM [Paids] WHERE Job=" & lId.ToString
            cmd.ExecuteNonQuery()

            cmd.CommandText = "DELETE FROM [Jobs_links] WHERE Job=" & lId.ToString
            cmd.ExecuteNonQuery()

            cmd.CommandText = "UPDATE [Proposal] SET JobId=Null, StatusId=1 WHERE JobId=" & lId.ToString
            cmd.ExecuteNonQuery()

            cmd.CommandText = "DELETE FROM [Appointments] WHERE JobId=" & lId.ToString
            cmd.ExecuteNonQuery()

            cnn1.Close()
            EliminarJob = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobData(ByVal lId As Long,
                                        ByRef sCode As String,
                                        ByRef sJob As String,
                                        ByRef sOpen_date As String,
                                        ByRef sClientId As String,
                                        ByRef mBudget As String,
                                        ByRef sType As String,
                                        ByRef nEmployee As Integer,
                                        ByRef Status As Integer,
                                        ByRef ProjectLocation As String,
                                        ByRef ProjectArea As String,
                                        ByRef Owner As String,
                                        ByRef Cost As Double,
                                        ByRef RecordBy As Integer,
                                        ByRef SignedDate As DateTime,
                                        ByRef Description As String,
                                        ByRef Change_orders As String,
                                        ByRef Lifespan As String,
                                        ByRef Sector As Integer,
                                        ByRef Use As String,
                                        ByRef Dpto As Integer,
                                        ByRef Unit As Double,
                                        ByRef Measure As Integer,
                                        ByRef nProjectType As Integer,
                                        ByRef StartDay As DateTime,
                                        ByRef EndDay As DateTime,
                                        ByRef WorkingDays As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT * FROM [Jobs] WHERE [Id]=" & lId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                sCode = rdr("Code").ToString
                sJob = rdr("Job").ToString
                sOpen_date = rdr("Open_date").ToString
                sClientId = rdr("Client").ToString
                mBudget = rdr("Budget").ToString
                sType = rdr("Type").ToString
                nEmployee = Val("" & rdr("Employee").ToString)
                Status = rdr("Status")
                ProjectLocation = "" & rdr("ProjectLocation")
                ProjectArea = "" & rdr("ProjectArea")
                ' Otros datos Job_ex
                Owner = "" & rdr("Owner")
                Cost = IIf(IsDBNull(rdr("Cost")), 0, rdr("Cost"))
                RecordBy = Val("" & rdr("RecordBy"))
                SignedDate = IIf(IsDBNull(rdr("SignedDate")), rdr("Open_date"), rdr("SignedDate"))
                Description = "" & rdr("Description")
                Change_orders = "" & rdr("Change_orders")
                Lifespan = "" & rdr("Lifespan")
                Sector = Val("" & rdr("ProjectSector"))
                Use = "" & rdr("ProjectUse")
                Dpto = Val("" & rdr("DepartmentId"))
                Unit = Val("" & rdr("Unit"))
                Measure = Val("" & rdr("Measure"))
                nProjectType = Val("" & rdr("ProposalType"))
                StartDay = IIf(IsDBNull(rdr("StartDay")), rdr("Open_date"), rdr("StartDay"))
                EndDay = IIf(IsDBNull(rdr("EndDay")), "1/1/1980", rdr("EndDay"))
                WorkingDays = Val("" & rdr("Workdays"))

                GetJobData = True

            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobName(ByVal lJobId As Long) As String
        Try
            Return GetStringEscalar("SELECT [Job] FROM [Jobs] WHERE [Id]=" & lJobId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function GetJobCodeName(ByVal lJobId As Long) As String
        Try
            Return GetStringEscalar("SELECT [Code]+' '+[Job] FROM [Jobs] WHERE [Id]=" & lJobId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function GetJobProposalBy(ByVal jobId As Integer) As String
        Try
            Return GetStringEscalar("SELECT top 1 Employees.FullName FROM Proposal inner join Employees on Proposal.ProjectManagerId=Employees.Id where jobId=" & jobId & " order by Proposal.Id")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetDepartmentTargetThisMonth(ByVal companyId As Integer, departmentId As Integer) As Double
        Try
            Dim nYear As Integer = Year(GetDateTime())
            Dim nMonth As Integer = Month(GetDateTime())
            Return GetNumericEscalar("select dbo.DepartmentBudget_Moth(" & companyId & "," & departmentId & "," & nYear & "," & nMonth & ")")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetDepartmentExecutedThisMonth(ByVal companyId As Integer, departmentId As Integer) As Double
        Try
            Dim nYear As Integer = Year(GetDateTime())
            Dim nMonth As Integer = Month(GetDateTime())
            Return GetNumericEscalar("select dbo.JobBudgetExecutedMonth(" & companyId & "," & departmentId & "," & nYear & "," & nMonth & ")")
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function GetDepartmentTargetAccumulated(ByVal companyId As Integer, departmentId As Integer) As Double
        Try
            Dim nYear As Integer = Year(GetDateTime())
            Dim nMonth As Integer = Month(GetDateTime())
            Return GetNumericEscalar("select dbo.DepartmentBudgetAccumulatedToMonth(" & companyId & "," & departmentId & "," & nYear & "," & nMonth & ")")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetDepartmentAccumulatedBalance(ByVal companyId As Integer, departmentId As Integer) As Double
        Try
            Dim nYear As Integer = Year(GetDateTime())
            Dim nMonth As Integer = Month(GetDateTime())
            Return GetNumericEscalar("select dbo.JobBudgetAccumulatedtoMonth(" & companyId & "," & departmentId & "," & nYear & "," & nMonth & ")") - GetDepartmentTargetAccumulated(companyId, departmentId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetInvoiceEmmittedMonth(ByVal companyId As Integer) As Double
        Try
            Dim nYear As Integer = Year(GetDateTime())
            Dim nMonth As Integer = Month(GetDateTime())
            Return GetNumericEscalar("select dbo.InvoiceEmmittedMonth(" & companyId & "," & nYear & "," & nMonth & ")")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetInvoiceCollectedMonth(ByVal companyId As Integer) As Double
        Try
            Dim nYear As Integer = Year(GetDateTime())
            Dim nMonth As Integer = Month(GetDateTime())
            Return GetNumericEscalar("select dbo.InvoiceCollectedMonth(" & companyId & "," & nYear & "," & nMonth & ")")
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function GetBudgetExecuted(ByVal companyId As Integer) As Double
        Try
            Dim nYear As Integer = Year(GetDateTime())
            Dim nMonth As Integer = Month(GetDateTime())
            Return GetNumericEscalar("select sum(Budget) from Jobs where companyId=" & companyId & " and year(Open_date)=" & nYear & " and month(Open_date)=" & nMonth)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobTotal(ByVal lJobId As Long, ByVal sTotalField As String) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT [" & sTotalField & "] FROM [Jobs] WHERE [Id]=" & lJobId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetJobTotal = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobTotalMesAno(ByVal sTotalField As String, ByVal nMes As Int16, ByVal nAno As Int16, ByVal companyId As Integer, Optional ByVal ClientId As Integer = -1) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim sWhere As String = "WHERE companyId=" & companyId
            If nAno > 0 Then sWhere = sWhere & " AND Year([Open_date])=" & nAno
            If nMes > 0 Then sWhere = sWhere & " AND Month([Open_date])=" & nMes
            If ClientId > 0 Then sWhere = sWhere & " AND Client=" & ClientId
            Dim cmd As New SqlCommand("SELECT ISNULL(SUM([" & sTotalField & "]),0) AS TOTAL FROM [Jobs] " &
                                      sWhere, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetJobTotalMesAno = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobTypeName(ByVal sTypeId As String) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT [Name] FROM [Jobs_types] WHERE [Id]='" & sTypeId & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetJobTypeName = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobCode(ByVal lId As Long) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Code FROM [Jobs] WHERE [Id]=" & lId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetJobCode = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobNameByweekly(ByVal nEmployee As Integer, ByVal sFechaDesde As String, ByVal sFechaHasta As String, ByVal JobIndex As Int16) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            ' Selecciona los Jobs en los que ha metido Time y los Jobs Open asigados a el employee en el periodo
            'Dim cmd As New SqlCommand("SELECT Job FROM ( " & _
            '                            "select Jobs.Job from Employees_time INNER JOIN Jobs ON Employees_time.Job = Jobs.Id " & _
            '                                    "where Employees_time.Employee=" & nEmployee.ToString & _
            '                                        " and Employees_time.Fecha>=" & GetFecha_102(sFechaDesde) & _
            '                                        " and Employees_time.Fecha<=" & GetFecha_102(sFechaHasta) & _
            '                                        " group by Jobs.Job " & _
            '                            "union all " & _
            '                            "select Job from Jobs WHERE Employee=" & nEmployee.ToString & " and [status] not in(0,1) AND Jobs.Open_date<=" & GetFecha_102(sFechaDesde) & _
            '                            ") T GROUP BY T.Job ORDER BY T.Job", cnn1)

            ' Selecciona SOLO los Jobs en los que ha metido Time 
            Dim cmd As New SqlCommand("SELECT Jobs.Job FROM Employees_time INNER JOIN Jobs ON Employees_time.Job = Jobs.Id " &
                                        "WHERE Employees_time.Employee=" & nEmployee.ToString &
                                        " AND Employees_time.Fecha>=" & GetFecha_102(sFechaDesde) &
                                        " AND Employees_time.Fecha<=" & GetFecha_102(sFechaHasta) &
                                        " GROUP BY Jobs.Job", cnn1)

            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            Dim i As Integer
            Do While rdr.Read()
                If rdr.HasRows Then
                    If i = JobIndex Then
                        GetJobNameByweekly = "" & rdr(0).ToString()
                        Exit Do
                    End If
                    i = i + 1
                End If
            Loop
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobEmployee(ByVal lId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT isnull(Employee,0) FROM [Jobs] WHERE [Id]=" & lId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetJobEmployee = Val("" & rdr(0).ToString)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function IsTypeJob(ByVal sTypeId As String, ByVal companyId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT [Name] FROM [Jobs_types] WHERE companyId=" & companyId & " AND [Id]='" & sTypeId & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            IsTypeJob = rdr.HasRows
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobId(ByVal sName As String, ByVal companyId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT [Id] FROM [Jobs] WHERE companyId=@companyId AND [Job]=@Name", cnn1)
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@Name", sName)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetJobId = rdr("Id")
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobCodeFromName(ByRef JobName As String, ByVal companyId As Integer) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT [Code] FROM [Jobs] WHERE companyId=@companyId AND [Job]=@Name", cnn1)
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@Name", JobName)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetJobCodeFromName = rdr("Code")
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobIdFromCode(ByRef jobCode As String, ByVal companyId As Integer) As Integer
        Return GetNumericEscalar("SELECT TOP 1 [Id] FROM [Jobs] where [Code]='" & jobCode & "' and companyId=" & companyId)
    End Function

    Public Shared Function GetJobIdFromGUID(ByVal guid As String) As Integer
        'Inject SQL!!!! Return GetNumericEscalar("SELECT [Id] FROM [Jobs] where [guid]='" & guid & "'")
        Dim cnn1 As SqlConnection = GetConnection()
        Dim cmd As New SqlCommand("SELECT [Id] FROM [Jobs] where [guid]=@guid", cnn1)
        cmd.Parameters.AddWithValue("@guid", guid)
        GetJobIdFromGUID = Convert.ToDouble(cmd.ExecuteScalar())
        cnn1.Close()

    End Function

    Public Shared Function GetJobCoste(ByRef jobId As Integer) As Double
        Return GetNumericEscalar("SELECT dbo.JobCoste(" & jobId & ") AS Coste ")
    End Function
    Public Shared Function GetJobAssignedHoursUsedPercent(ByRef jobId As Integer) As Double
        Return GetNumericEscalar("SELECT dbo.JobAssignedHoursUsedPercent(" & jobId & ")")
    End Function
    Public Shared Function GetJobHourWorked(ByRef jobId As Integer) As Double
        Return GetNumericEscalar("SELECT dbo.JobHours(" & jobId & ") AS Coste ")
    End Function


    Public Shared Function GetJobProperty(ByRef jobId As Integer, ByVal sProperty As String, ByVal companyId As Integer) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT ISNULL([" & sProperty & "],'') FROM [Jobs] WHERE companyId=" & companyId & " AND [Id]=" & jobId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                Return rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Return ""
        End Try
    End Function

    Public Shared Function GetJobProperty(ByRef jobId As Integer, ByVal sProperty As String) As String
        Select Case sProperty
            Case "Client", "Employee", "Unit", "qbJobId", "companyId", "BillType"
                Return GetNumericEscalar("SELECT TOP 1 [" & sProperty & "] FROM [Jobs] where [Id]=" & jobId)

            Case "proposalId"
                Return GetNumericEscalar("select top 1 Id from Proposal where isnull(JobId,0)=" & jobId)

            Case "Open_date", "StartDay", "EndDay", "Done_Date"
                Return GetDateTimeEscalar("SELECT TOP 1 [" & sProperty & "] FROM [Jobs] where [Id]=" & jobId)

            Case Else
                Return GetStringEscalar("SELECT TOP 1 isnull([" & sProperty & "],'') FROM [Jobs] where [Id]=" & jobId)
        End Select

    End Function

    Public Shared Function GetJobSubContractedFees(ByVal jobId As Long) As Double
        Try
            '************COSTE POR HORA DEL EMPLOYEE x MULTIPLIER ************************
            Return GetNumericEscalar(String.Format("select dbo.JobSubContracted({0})", jobId))

        Catch ex As Exception

        End Try
    End Function
    Public Shared Function GetJobBudgetUsed(ByVal jobId As Long) As Double
        Try
            Return GetNumericEscalar(String.Format("select dbo.JobCoste({0})", jobId))

        Catch ex As Exception

        End Try
    End Function


    Public Shared Function GetJobStreeViewImage(ByRef jobId As Integer, Optional Resolution As String = "1024x768") As String
        Dim Address As String = GetStringEscalar("SELECT isnull(ProjectLocation,'') FROM [Jobs] where [Id]=" & jobId)
        Return "https://maps.googleapis.com/maps/api/streetview?size=" & Resolution & "&location=" & Address & "&key=AIzaSyAqYC89QG6cp_vv1UnQIo-wgVpRV4wzX3A"
    End Function

    Public Shared Function GetNextJobCode(ByVal sPrefijo As String, ByVal companyId As Integer) As String
        Try
            Return GetStringEscalar("Select [dbo].[GetNextJobCode](" & sPrefijo & "," & companyId & ")")
        Catch ex As Exception
            Return sPrefijo & "-0001"
        End Try
    End Function

    Public Shared Function GetNewJobCode_old(ByVal sPrefijo As String, ByVal companyId As Integer) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT TOP 1 Right('000' + CAST(Right(code,3)+1 AS NVARCHAR(10)),3) FROM jobs WHERE Left(code,2)='" & sPrefijo & "' AND companyId=" & companyId & " ORDER BY Right(code,3) DESC", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetNewJobCode_old = rdr(0).ToString
            Else
                GetNewJobCode_old = "001"
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            GetNewJobCode_old = "001"
        End Try
    End Function

    Public Shared Function GetBackJob(ByVal sCode As String, ByVal companyId As Integer) As Long
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT top 1 Id, [Code] FROM [Jobs] WHERE companyId=" & companyId & " AND [Code]<'" & sCode & "' ORDER BY [Code] DESC", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetBackJob = rdr("Id").ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetNextJob(ByVal sCode As String, ByVal companyId As Integer) As Long
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT top 1 Id, [Code] FROM [Jobs] WHERE companyId=" & companyId & " AND [Code]>'" & sCode & "' ORDER BY [Code]", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetNextJob = rdr("Id").ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Shared Function privGetJobBudget(ByVal cnn1 As SqlConnection,
                                        ByVal lId As Long) As Double
        Try
            Dim cmd As New SqlCommand("SELECT Budget FROM [Jobs] WHERE [Id]=" & lId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                privGetJobBudget = rdr("Budget")
            End If
            rdr.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobBalance(ByVal jobId As Long) As Double
        Try
            Return GetNumericEscalar("SELECT dbo.JobBalance(" & jobId & ")")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobBudget(ByVal lId As Long) As Double
        Try
            Return GetNumericEscalar("SELECT isnull(Budget,0) FROM [Jobs] WHERE [Id]=" & lId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function GetJobInvoiceAmount(ByVal lId As Long) As Double
        Try
            Return GetNumericEscalar("SELECT SUM(isnull(Amount,0)) FROM [Invoices] WHERE [JobId]=" & lId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Shared Function privGetJobTotalInvoiceAmount(ByVal cnn1 As SqlConnection,
                                        ByVal lId As Long) As Double
        Try
            Dim cmd As New SqlCommand("SELECT ISNULL(SUM(Amount),0) AS Total FROM Invoices WHERE JobId=" & lId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                privGetJobTotalInvoiceAmount = rdr(0)
            End If
            rdr.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function NuevoPaid(ByRef lJob As Integer,
                                ByVal sFecha As String, ByVal dPaid As Double, ByVal sNotas As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            cmd.CommandText = "INSERT INTO [Paids] (Job, Fecha, Paid, Notas) " &
                                                    "VALUES (" & lJob.ToString & ", " &
                                                        GetFecha_102(sFecha) & ",0,'" &
                                                        sNotas & "')"

            cmd.ExecuteNonQuery()
            cnn1.Close()
            NuevoPaid = True

            Dim companyId As Integer = GetCompanyIdFromJob(lJob)
            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewPaid, companyId, sNotas)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function NuevoFileLink(ByRef lJob As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            cmd.CommandText = "INSERT INTO [Jobs_links] (Job) VALUES (" & lJob.ToString & ")"

            cmd.ExecuteNonQuery()
            cnn1.Close()
            NuevoFileLink = True

            Dim companyId As Integer = GetCompanyIdFromJob(lJob)
            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewJobLink, companyId, lJob)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function NewJobNote(ByRef lJob As Integer, employeeId As Integer) As Boolean
        Try
            ExecuteNonQuery("INSERT INTO [Jobs_notes] ([JobId], [Date], [employeeId]) VALUES (" & lJob.ToString & ", " & GetDateUTHlocal() & "," & employeeId & ")")

            NewJobNote = True

            Dim companyId As Integer = GetCompanyIdFromJob(lJob)
            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewJobNote, companyId, lJob)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function NewJobNote(ByRef lJob As Integer, Note As String, employeeId As Integer) As Boolean
        Try
            Return ExecuteNonQuery("INSERT INTO [Jobs_notes] ([JobId], [Date], [Note], [employeeId]) VALUES (" & lJob.ToString & ", " & GetDateUTHlocal() & ", '" & Note & "'," & employeeId & ")")

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function GetJobStatusId(ByVal lId As Integer) As Integer
        Return GetNumericEscalar("Select ISNULL([Status],0) FROM [Jobs] WHERE [Id]=" & lId)
    End Function

    Public Shared Function SetJobStatus(ByVal lId As Integer, statusId As Integer, employeeId As Integer, companyId As Integer, UserEmployee As Integer, Optional bNotified As Boolean = True) As Boolean
        Try

            If statusId <> GetJobStatusId(lId) Then

                Dim cnn1 As SqlConnection = GetConnection()
                Dim cmd As SqlCommand = cnn1.CreateCommand()

                ' Update statusId, create Log and Note in Job.
                cmd.CommandText = "JOB_EmployeeStatus2_UPDATE"
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@Id", lId)
                cmd.Parameters.AddWithValue("@Employee", employeeId)
                cmd.Parameters.AddWithValue("@Status", statusId)
                cmd.Parameters.AddWithValue("@UserEmployee", UserEmployee)

                cmd.ExecuteNonQuery()

                cnn1.Close()

                If bNotified Then
                    Select Case statusId
                        Case 1
                            EmailJobInactive(lId, employeeId, companyId)
                        Case 2  'In Progress
                            LocalAPI.JobMailStatusChange(lId, employeeId, "In Progress", companyId)
                        Case 3  'On Hold
                            LocalAPI.JobMailStatusChange(lId, employeeId, "On Hold", companyId)
                        Case 4  'Submitted
                            LocalAPI.JobMailStatusChange(lId, employeeId, "Submitted", companyId)
                        Case 5  'Under Revision
                            LocalAPI.JobMailStatusChange(lId, employeeId, "Under Revision", companyId)
                        Case 6  'Approved
                            LocalAPI.JobMailStatusChange(lId, employeeId, "Approved", companyId)
                        Case 7  'Done
                            LocalAPI.JobMailStatusChange(lId, employeeId, "Done", companyId)
                    End Select
                End If

            End If
        Catch ex As Exception

        End Try

    End Function

    Public Shared Function SetJobInProgress_old(ByVal lId As Integer) As Boolean
        If GetJobStatusId(lId) = 0 Then
            ExecuteNonQuery("UPDATE [Jobs] Set [Status]=2 WHERE Id=" & lId.ToString)
            Return NewJobNote(lId, "New status: In Progress", 0)
        End If
    End Function

    'Public Shared Function SetJobInactive(ByVal lId As Integer) As Boolean
    '    If ExecuteNonQuery("update Jobs set Status=1 where Jobs.Id=" & lId & " and Jobs.Status=4 and Type<>'FR1' and (select isnull(sum(AmountDue),0) from Invoices where JobId=Jobs.Id)=0 and (select count(*) from Invoices where JobId=Jobs.Id and Amount=0)=0 and (select count(*) from Invoices where JobId=Jobs.Id )>0") > 0 Then
    '        NewJobNote(lId, "New status: Inactive")
    '        Return True
    '    End If
    'End Function

    Public Shared Function Jobs_Employees_assigned_INSERT(jobId As Integer, employeeId As Integer, Optional Hours As Integer = 0, Optional HourRate As Double = 0, Optional Scope As String = "Poject Manager", Optional positionId As Integer = 0) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Jobs_Employees_assigned_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@jobId", jobId)
            cmd.Parameters.AddWithValue("@employeeId", employeeId)
            cmd.Parameters.AddWithValue("@positionId", IIf(positionId > 0, positionId, GetEmployeeProperty(employeeId, "PositionId")))
            cmd.Parameters.AddWithValue("@Scope", Scope)
            cmd.Parameters.AddWithValue("@Hours", Hours)
            cmd.Parameters.AddWithValue("@HourRate", HourRate)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            ' evitar error por posible duplicado
            'Throw ex
        End Try
    End Function

    Public Shared Function GetJobsEmployeesassignedProperty(ByVal lId As Integer, sProperty As String) As Integer
        Select Case sProperty
            Case "HourRate", "Hours", "positionId", "employeeId"
                ' Numeric values
                Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],0) FROM Jobs_Employees_assigned WHERE Id=" & lId)

            Case Else
                Return GetStringEscalar("SELECT ISNULL([" & sProperty & "],'') FROM Jobs_Employees_assigned WHERE Id=" & lId)

        End Select


    End Function


    Public Shared Function Jobs_Ratios_MinAvgMax(PageSize As Integer, DateFrom As DateTime, DateTo As DateTime, measureId As Integer, UnitFrom As Integer, UnitTo As Integer, departmentIdIN_List As String, jobType As String, ExcludeJobsList As String, clientId As Integer, companyId As Integer, ByRef UnitTo_OUT As Integer, ByRef RecNumbers_OUT As Integer, ByRef MIN_CosteByUnit As Double, ByRef AVG_CosteByUnit As Double, ByRef MAX_CosteByUnit As Double, ByRef MIN_HourByUnit As Double, ByRef AVG_HourByUnit As Double, ByRef MAX_HourByUnit As Double) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "JOBS_Ratios_MinAvgMax"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@TOPRecords", PageSize)
            cmd.Parameters.AddWithValue("@DateFrom", DateFrom)
            cmd.Parameters.AddWithValue("@DateTo", DateTo)
            cmd.Parameters.AddWithValue("@measureId", measureId)
            cmd.Parameters.AddWithValue("@UnitFrom", UnitFrom)
            cmd.Parameters.AddWithValue("@UnitTo", UnitTo)
            cmd.Parameters.AddWithValue("@departmentIdIN_List", departmentIdIN_List)
            cmd.Parameters.AddWithValue("@jobType", jobType)
            cmd.Parameters.AddWithValue("@ExcludeJobsList", ExcludeJobsList)
            cmd.Parameters.AddWithValue("@clientId", clientId)
            cmd.Parameters.AddWithValue("@companyId", companyId)


            ' Set up the output parameter 
            Dim parUnitTo_OUT As SqlParameter = New SqlParameter("@UnitTo_OUT", SqlDbType.Int)
            parUnitTo_OUT.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parUnitTo_OUT)

            Dim parRecNumbers_OUT As SqlParameter = New SqlParameter("@RecNumbers_OUT", SqlDbType.Int)
            parRecNumbers_OUT.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parRecNumbers_OUT)

            Dim par1MIN_CosteByUnit As SqlParameter = New SqlParameter("@MIN_CosteByUnit", SqlDbType.Float)
            par1MIN_CosteByUnit.Direction = ParameterDirection.Output
            cmd.Parameters.Add(par1MIN_CosteByUnit)

            Dim par1AVG_CosteByUnit As SqlParameter = New SqlParameter("@AVG_CosteByUnit", SqlDbType.Float)
            par1AVG_CosteByUnit.Direction = ParameterDirection.Output
            cmd.Parameters.Add(par1AVG_CosteByUnit)

            Dim par1MAX_CosteByUnit As SqlParameter = New SqlParameter("@MAX_CosteByUnit", SqlDbType.Float)
            par1MAX_CosteByUnit.Direction = ParameterDirection.Output
            cmd.Parameters.Add(par1MAX_CosteByUnit)

            Dim par2MIN_HourByUnit As SqlParameter = New SqlParameter("@MIN_HourByUnit", SqlDbType.Float)
            par2MIN_HourByUnit.Direction = ParameterDirection.Output
            cmd.Parameters.Add(par2MIN_HourByUnit)

            Dim par2AVG_HourByUnit As SqlParameter = New SqlParameter("@AVG_HourByUnit", SqlDbType.Float)
            par2AVG_HourByUnit.Direction = ParameterDirection.Output
            cmd.Parameters.Add(par2AVG_HourByUnit)

            Dim par2MAX_HourByUnit As SqlParameter = New SqlParameter("@MAX_HourByUnit", SqlDbType.Float)
            par2MAX_HourByUnit.Direction = ParameterDirection.Output
            cmd.Parameters.Add(par2MAX_HourByUnit)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            Try
                UnitTo_OUT = IIf(parUnitTo_OUT.Value Is Nothing, 0, parUnitTo_OUT.Value)
                RecNumbers_OUT = parRecNumbers_OUT.Value

                MIN_CosteByUnit = par1MIN_CosteByUnit.Value
                AVG_CosteByUnit = par1AVG_CosteByUnit.Value
                MAX_CosteByUnit = par1MAX_CosteByUnit.Value

                MIN_HourByUnit = par2MIN_HourByUnit.Value
                AVG_HourByUnit = par2AVG_HourByUnit.Value
                MAX_HourByUnit = par2MAX_HourByUnit.Value


            Catch ex As Exception
                UnitTo_OUT = 0
                RecNumbers_OUT = 0
                MIN_CosteByUnit = 0
                AVG_CosteByUnit = 0
                MAX_CosteByUnit = 0

            End Try

        Catch ex As Exception
            Throw ex
        End Try

    End Function

#End Region

#Region "Timesheet"
    Public Shared Function GetJobNewTimeDefaultValues(jobId As Integer, employeeId As Integer) As Dictionary(Of String, Object)
        ' Devuelve un objeto con todos los valores del SELECT del store procedure
        ' El parametro de entrada debe llamarse "@Id"
        ' Ejemplo de Llamado y uso
        ' Dim verificationRecord = LocalAPI.GetRecord(verificationId,"VerificationRecord_SELECT")
        ' Dim SalesRep as String = verificationRecord("SalesRep")
        Dim result = New Dictionary(Of String, Object)()
        Try
            Using conn As SqlConnection = GetConnection()
                Using comm As New SqlCommand("Job_NewTime_DefaultValues_SELECT", conn)
                    comm.CommandType = CommandType.StoredProcedure

                    Dim p0 As New SqlParameter("@jobId", SqlDbType.Int)
                    p0.Direction = ParameterDirection.Input
                    p0.Value = jobId
                    comm.Parameters.Add(p0)

                    Dim p1 As New SqlParameter("@employeeId", SqlDbType.Int)
                    p1.Direction = ParameterDirection.Input
                    p1.Value = employeeId
                    comm.Parameters.Add(p1)

                    Dim reader = comm.ExecuteReader()
                    If reader.HasRows Then
                        ' We only read one time (of course, its only one result :p)
                        reader.Read()
                        For lp As Integer = 0 To reader.FieldCount - 1
                            result.Add(reader.GetName(lp), reader.GetValue(lp))
                        Next
                    End If
                End Using
            End Using
            Return result
        Catch e As Exception
            Return result
        End Try
    End Function
#End Region

#Region "Invoices & Payments"

    Public Shared Function GetInvoiceInfo(invoiceId As Integer) As Dictionary(Of String, Object)
        Dim result = New Dictionary(Of String, Object)()
        Try
            Using conn As SqlConnection = GetConnection()
                Using comm As New SqlCommand("dbo.INVOICE3_Adapter", conn)
                    comm.CommandType = CommandType.StoredProcedure

                    Dim p0 As New SqlParameter("@InvoiceId", SqlDbType.Int)
                    p0.Direction = ParameterDirection.Input
                    p0.Value = invoiceId
                    comm.Parameters.Add(p0)

                    Dim reader = comm.ExecuteReader()
                    If reader.HasRows Then
                        ' We only read one time (of course, its only one result :p)
                        reader.Read()
                        For lp As Integer = 0 To reader.FieldCount - 1
                            result.Add(reader.GetName(lp), reader.GetValue(lp))
                        Next
                    End If
                End Using
            End Using
            Return result
        Catch e As Exception
            Return result
        End Try
    End Function

    Public Shared Function GetStatementInfo(statementId As Integer) As Dictionary(Of String, Object)
        Dim result = New Dictionary(Of String, Object)()
        Try
            Using conn As SqlConnection = GetConnection()
                Using comm As New SqlCommand("dbo.STATEMENT2_Adapter", conn)
                    comm.CommandType = CommandType.StoredProcedure

                    Dim p0 As New SqlParameter("@statementId", SqlDbType.Int)
                    p0.Direction = ParameterDirection.Input
                    p0.Value = statementId
                    comm.Parameters.Add(p0)

                    Dim reader = comm.ExecuteReader()
                    If reader.HasRows Then
                        ' We only read one time (of course, its only one result :p)
                        reader.Read()
                        For lp As Integer = 0 To reader.FieldCount - 1
                            result.Add(reader.GetName(lp), reader.GetValue(lp))
                        Next
                    End If
                End Using
            End Using
            Return result
        Catch e As Exception
            Return result
        End Try
    End Function

    Public Shared Function IsBillingModule(companyId As Integer) As Boolean
        Return GetNumericEscalar("SELECT isnull([billingModule],0) FROM Company where companyId=" & companyId)
    End Function

    Public Shared Function GetPaymentsForInvoice(InvoiceId As Integer) As Integer
        Return GetNumericEscalar("SELECT count(*) FROM Invoices_payments inner join Invoices ON Invoices_payments.InvoiceId=Invoices.Id where Invoices.Id=" & InvoiceId)
    End Function

    Public Shared Function SetInvoiceBatDebt(ByVal invoiceId As Integer) As Boolean
        Try
            ExecuteNonQuery("UPDATE [Invoices] SET [BadDebt]=1, [BadDebtDate]=" & GetDateUTHlocal() & " WHERE Id=" & invoiceId & " And isnull(statementId,0)=0")
            ExecuteNonQuery("UPDATE [Invoices] SET Emitted=1,[FirstEmission]=BadDebtDate, [LatestEmission]=BadDebtDate  WHERE Id =" & invoiceId & " and isnull(Emitted,0)=0")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function SetInvoiceScheduleEmail(ByVal invoiceId As Integer, nDays As Integer) As Boolean
        Try
            ExecuteNonQuery("UPDATE [Invoices] SET EmissionRecurrenceDays=" & nDays & " WHERE Id=" & invoiceId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function SetInvoiceQBRef(invoiceId As Integer, QBId As String, employeeId As Integer) As Boolean
        Try
            ExecuteNonQuery("UPDATE [Invoices] SET [qbInvoiceId] = '" & QBId & "' WHERE Id=" & invoiceId)
            ActualizarEmittedInvoice(invoiceId, employeeId)
            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function Invoice_INSERT(jobId As Integer, InvoiceDate As DateTime, Amount As Double, InvoiceNotes As String, MaturityDate As DateTime) As Integer
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            Dim Number As Integer = GetInvoiceNumber(jobId)

            ' ClienteEmail
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Invoice_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@JobId", jobId)
            cmd.Parameters.AddWithValue("@Number", Number)
            cmd.Parameters.AddWithValue("@InvoiceDate", InvoiceDate)
            cmd.Parameters.AddWithValue("@Amount", Amount)
            cmd.Parameters.AddWithValue("@InvoiceNotes", InvoiceNotes)
            cmd.Parameters.AddWithValue("@MaturityDate", MaturityDate)
            ' Execute the stored procedure.
            Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            Dim InvoiceId As Integer = parOUT_ID.Value
            cnn1.Close()

            Return InvoiceId

        Catch ex As Exception
            Throw ex
        End Try


    End Function

    Public Shared Function Invoice_Payment_INSERT(InvoiceId As Integer, CollectedDate As DateTime, Method As Integer, Amount As Double, CollectedNotes As String, employeeId As Integer) As Integer
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Invoice_Payment_v20_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@InvoiceId", InvoiceId)
            cmd.Parameters.AddWithValue("@CollectedDate", CollectedDate)
            cmd.Parameters.AddWithValue("@Method", Method)
            cmd.Parameters.AddWithValue("@Amount", Amount)
            cmd.Parameters.AddWithValue("@CollectedNotes", CollectedNotes)

            cmd.Parameters.AddWithValue("@OriginalFileName", "")
            cmd.Parameters.AddWithValue("@KeyName", "")
            cmd.Parameters.AddWithValue("@ContentBytes", 0)
            cmd.Parameters.AddWithValue("@ContentType", "")

            cmd.Parameters.AddWithValue("@employeeId", employeeId)

            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return InvoiceId

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function SetPaymentReconcileStatus(ByVal Id As Integer, ReconcileValue As Integer) As Boolean
        If Id > 0 Then
            ' direct Payment Id
            Return ExecuteNonQuery($"UPDATE [Invoices_payments] Set ReconciledBank={ReconcileValue} where Id={Id}")
        Else
            ' Statement Id
            Dim statementId As Integer = 0 - Id
            Return ExecuteNonQuery($"UPDATE P Set P.ReconciledBank={ReconcileValue} from Invoices_payments P inner join Invoices I on P.InvoiceId = I.Id where isnull(I.statementId,0)={statementId}")
        End If
    End Function

    Public Shared Function ActualizarEmittedInvoice(ByVal lId As Integer, employeeId As Integer, Optional nEmissionRecurrenceDays As Integer = -1) As Boolean
        Try
            ExecuteNonQuery("UPDATE [Invoices] SET [FirstEmission]=" & GetDateUTHlocal() & " WHERE Id=" & lId.ToString & " AND ISNULL(Emitted,0)=0")
            If nEmissionRecurrenceDays >= 0 Then
                ExecuteNonQuery("UPDATE [Invoices] SET Emitted=ISNULL(Emitted,0)+1, [LatestEmission]=" & GetDateUTHlocal() & ", EmissionRecurrenceDays=" & nEmissionRecurrenceDays & " WHERE Id=" & lId.ToString)
            Else
                ExecuteNonQuery("UPDATE [Invoices] SET Emitted=ISNULL(Emitted,0)+1, [LatestEmission]=" & GetDateUTHlocal() & " WHERE Id=" & lId.ToString)
            End If

            If employeeId > 0 Then
                Dim clientId As Integer = LocalAPI.GetClientIdFromInvoice(lId)
                Clients_activities_INSERT(clientId, "U", "Invoices", lId, employeeId)
            End If

            ActualizarEmittedInvoice = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function ActualizarEmittedStatetment(ByVal lId As Integer) As Boolean
        Try
            ExecuteNonQuery("UPDATE [Invoices_statements] SET [FirstEmission]=" & GetDateUTHlocal() & " WHERE Id=" & lId.ToString & " AND ISNULL(Emitted,0)=0")
            ExecuteNonQuery("UPDATE [Invoices_statements] SET Emitted=ISNULL(Emitted,0)+1, [LatestEmission]=" & GetDateUTHlocal() & " WHERE Id=" & lId.ToString)

            ' Marcar emision de Invoices del statement
            ExecuteNonQuery("UPDATE [Invoices] SET [FirstEmission]=" & GetDateUTHlocal() & " WHERE statementId=" & lId.ToString & " AND ISNULL(Emitted,0)=0")
            ExecuteNonQuery("UPDATE [Invoices] SET Emitted=ISNULL(Emitted,0)+1, [LatestEmission]=" & GetDateUTHlocal() & " WHERE statementId=" & lId.ToString)

            ActualizarEmittedStatetment = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetLastPaidDay(ByVal companyId As Integer) As DateTime
        If GetNumericEscalar("select count(*) from PaidDays where companyId=" & companyId) > 0 Then
            Return GetDateTimeEscalar("select PaidDay from PaidDays where companyId=" & companyId & " order by PaidDay DESC")
        Else
            Return GetDateTime()
        End If

    End Function

    Public Shared Function NuevoPaidDay(ByVal sFecha As String, ByVal companyId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            cmd.CommandText = "INSERT INTO [PaidDays] ([PaidDay],companyId) " &
                                                    "VALUES (" & GetFecha_102(sFecha) & "," & companyId & ")"

            cmd.ExecuteNonQuery()
            cnn1.Close()
            NuevoPaidDay = True

            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewPaidDay, companyId, sFecha)

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function GenerateInvoicesSchedules(ByVal lJob As Integer,
                                ByVal nInvoiceType As Int16, employeeId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim sPaymentsScheduleList As String
            Dim sPaymentsTextList As String
            Dim BillingFrequency As String
            Dim sDueDate As DateTime
            Dim bOverTotal As Boolean

            Dim cmd As New SqlCommand("SELECT [Id],[Name],[PaymentsScheduleList],[PaymentsTextList],[companyId],isnull([BillingFrequency],'') As BillingFrequency                                              FROM [Invoices_types] WHERE [Id]=" & nInvoiceType, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                sPaymentsScheduleList = rdr("PaymentsScheduleList").ToString
                sPaymentsTextList = rdr("PaymentsTextList").ToString
                BillingFrequency = rdr("BillingFrequency").ToString
            End If
            rdr.Close()
            Dim dBudget As Double = privGetJobBudget(cnn1, lJob)
            Dim dBalance As Double = dBudget
            If Len(sPaymentsScheduleList) > 0 Then
                Dim sArr1 As String() = Split(sPaymentsScheduleList, ",")
                Dim sArr2 As String() = Split(sPaymentsTextList, ",")
                Dim dAmount As Double
                Dim dPercent As Double
                Dim sInvoiceNotes As String
                Dim dTotalAmount As Double
                If Len(BillingFrequency) > 0 Then sDueDate = LocalAPI.GetDateTime()

                If sArr1.Length > 0 Then
                    Dim i As Int16
                    For i = 0 To sArr1.Length - 1
                        If Len(sArr1(i).ToString) > 0 Then
                            dPercent = IIf(IsNumeric(sArr1(i)), sArr1(i), 0)
                            sInvoiceNotes = sArr2(i).ToString
                            If i = sArr1.Length - 1 Then
                                ' Resto
                                dAmount = dBalance
                            Else
                                'Fraccion
                                dAmount = Math.Round(dBudget * dPercent / 100.0, 2, MidpointRounding.ToEven)
                                dBalance = dBalance - dAmount
                            End If

                            dTotalAmount = privGetJobTotalInvoiceAmount(cnn1, lJob)
                            If dTotalAmount + dAmount <= dBudget Then
                                If Len(BillingFrequency) > 0 Then GetNextDate(sDueDate, BillingFrequency)
                                NuevoInvoiceSimpleChargeExt(lJob, LocalAPI.GetDateTime(), dAmount, sInvoiceNotes, sDueDate, employeeId)
                            Else
                                bOverTotal = True
                            End If
                        End If
                    Next
                End If
            Else
                ' No existe el tipo, crear un Invoice vacio, con la diferencia del 
                Dim TotalAmount As Double = GetJobInvoicesAmountTotal(lJob)
                Dim Amount As Double = IIf(dBudget > TotalAmount, dBudget - TotalAmount, 0)
                If Len(BillingFrequency) > 0 Then GetNextDate(sDueDate, BillingFrequency)
                NuevoInvoiceSimpleChargeExt(lJob, GetDateTime(), Amount, "", sDueDate, employeeId)
            End If
            cnn1.Close()

            Return Not bOverTotal
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Private Shared Sub GetNextDate(ByRef InitialDate As DateTime, BillingFrequency As String)
        Select Case BillingFrequency
            Case "month"
                InitialDate = DateAdd(DateInterval.Month, 1, InitialDate)
            Case "quarter"
                InitialDate = DateAdd(DateInterval.Quarter, 1, InitialDate)
            Case "week"
                InitialDate = DateAdd(DateInterval.Day, 7, InitialDate)
            Case "day"
                InitialDate = DateAdd(DateInterval.Day, 1, InitialDate)
        End Select

    End Sub
    Private Shared Function GetInvoiceNumber(JobId As Integer) As Integer
        Try
            Dim Number As Integer = GetNumericEscalar("SELECT ISNULL(MAX(Number),0)+1 FROM Invoices WHERE JobId=" & JobId)
            If Number = 0 Then Number = 1

            Return Number

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function NuevoInvoiceSimpleCharge(ByVal lJob As Integer,
                                    ByVal sInvoiceDate As DateTime,
                                    ByVal dAmount As Double,
                                    ByVal sInvoiceNotes As String,
                                    Optional employeeId As Integer = 0) As Integer
        Try

            Dim Number As Integer = GetInvoiceNumber(lJob)

            'ExecuteNonQuery("INSERT INTO [Invoices] (JobId, InvoiceDate, Amount, InvoiceNotes, Emitted, InvoiceType, Number, [guid]) " &
            '                                         "VALUES (" & lJob.ToString & ", " &
            '                                             GetFecha_102(sInvoiceDate) & "," &
            '                                             FormatearNumero2Tsql(dAmount) & ",'" &
            '                                             sInvoiceNotes & "', 0, 0," & Number & ", NewId())")

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "INVOICE_SimpleCharge_v20_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@JobId", lJob)
            cmd.Parameters.AddWithValue("@InvoiceDate", sInvoiceDate)
            cmd.Parameters.AddWithValue("@Amount", FormatearNumero2Tsql(dAmount))
            cmd.Parameters.AddWithValue("@InvoiceNotes", sInvoiceNotes)
            cmd.Parameters.AddWithValue("@Number", Number)
            cmd.Parameters.AddWithValue("@employeeId", employeeId)

            cmd.ExecuteNonQuery()

            cnn1.Close()


            Return GetNumericEscalar("SELECT TOP 1 [Id] FROM [Invoices] where [JobId]=" & lJob & " order by Id desc")

            'Dim companyId As Integer = GetCompanyIdFromJob(lJob)
            'LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewInvoice, companyId, sInvoiceNotes)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function Invoice_Duplicate(ByVal invoiceId As Integer) As Integer
        Dim cnn1 As SqlConnection = GetConnection()
        Try

            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "INVOICE_DUPLICATE"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@sourceInvoiceId", invoiceId)
            ' Execute the stored procedure.
            Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            Return parOUT_ID.Value

        Catch ex As Exception
            Throw ex
        Finally
            cnn1.Close()
        End Try
    End Function
    Public Shared Function NuevoInvoiceSimpleChargeExt(ByVal lJob As Integer,
                                ByVal sInvoiceDate As DateTime,
                                ByVal dAmount As Double,
                                ByVal sInvoiceNotes As String,
                                ByVal sDueDate As Nullable(Of DateTime),
                                employeeId As Integer) As Integer
        Try

            Dim invoiceId As Integer = NuevoInvoiceSimpleCharge(lJob, sInvoiceDate, dAmount, sInvoiceNotes, employeeId)

            If Not (sDueDate = Nothing) Then
                ' Ext... Adicionalmente, Set el sDueDate
                ExecuteNonQuery("UPDATE Invoices SET MaturityDate=" & GetFecha_102(sDueDate) & " WHERE Id=" & invoiceId)
            End If

            Return invoiceId
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function NuevoInvoiceHourlyRate(ByVal timeId As Integer, ByVal lJob As Integer, ByVal dHours As Double, ByVal dRate As Double, Optional Description As String = "") As Boolean
        Try
            Dim invDescription As String = Description
            Dim Number As Integer = GetInvoiceNumber(lJob)
            Dim dAmount As Double = Math.Round(dHours * dRate, 2)
            ' Invoice desde EmployeeTime

            If Len(invDescription) = 0 Then
                invDescription = GetStringEscalar("SELECT [Description] FROM [Employees_time] WHERE [Id]=" & timeId)
            End If

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "INVOICE_HourlyRate_INSERT"
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@dAmount", FormatearNumero2Tsql(dAmount))
            cmd.Parameters.AddWithValue("@InvoiceNotes", invDescription)
            cmd.Parameters.AddWithValue("@Number", Number)
            cmd.Parameters.AddWithValue("@Time", FormatearNumero2Tsql(dHours))
            cmd.Parameters.AddWithValue("@dRate", FormatearNumero2Tsql(dRate))
            cmd.Parameters.AddWithValue("@JobId", lJob)
            cmd.Parameters.AddWithValue("@timeId", timeId)

            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True

            Dim companyId As Integer = GetCompanyIdFromJob(lJob)
            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewInvoice, companyId, "Time id: " & timeId)


        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function NewAutomaticInvoiceReminderFromEmitted(InvoiceId As Integer, employeeId As Integer, ByVal companyId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "INVOICE_REMAINDER_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@InvoiceId", InvoiceId)
            cmd.Parameters.AddWithValue("@employeeId", employeeId)
            cmd.Parameters.AddWithValue("@ClientContactName", "")
            cmd.Parameters.AddWithValue("@Email", "")
            cmd.Parameters.AddWithValue("@Notes", "Automatic remider by emission")
            cmd.Parameters.AddWithValue("@Remainder", GetDateTime())
            cmd.Parameters.AddWithValue("@statusId", 2)
            cmd.Parameters.AddWithValue("@companyId", companyId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function NewAutomaticStatementReminderFromEmitted(statementId As Integer, employeeId As Integer, ByVal companyId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "STATEMENT_REMAINDER_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@statementId", statementId)
            cmd.Parameters.AddWithValue("@employeeId", employeeId)
            cmd.Parameters.AddWithValue("@ClientContactName", "")
            cmd.Parameters.AddWithValue("@Email", "")
            cmd.Parameters.AddWithValue("@Notes", "Automatic remider by emission")
            cmd.Parameters.AddWithValue("@Remainder", GetDateTime())
            cmd.Parameters.AddWithValue("@statusId", 2)
            cmd.Parameters.AddWithValue("@companyId", companyId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Function

#End Region

#Region "SinClasificar"

    Public Shared Function IsJobName(ByVal lJobId As Integer, ByVal sName As String, ByVal companyId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim sSQL As String = "SELECT [Id] FROM [Jobs] WHERE [companyId]=" & companyId & " And [Job]='" & sName & "'"
            If lJobId > 0 Then
                sSQL = sSQL & " AND Id<>" & lJobId.ToString
            End If
            Dim cmd As New SqlCommand(sSQL, cnn1)

            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            IsJobName = rdr.HasRows
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function IsProposalTypeName(ByVal sName As String, ByVal companyId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()

            Dim cmd As New SqlCommand("SELECT [Id] FROM [Proposal_types] WHERE [companyId]=" & companyId & " AND [Name]='" & sName & "'", cnn1)

            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            IsProposalTypeName = rdr.HasRows
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function IsProposalTaskForJob(ByVal jobId As Integer) As Boolean
        Return GetNumericEscalar($"SELECT Count(*) FROM Proposal_details inner join Proposal on Proposal_details.ProposalId=Proposal.Id  WHERE Proposal.JobId={jobId}")
    End Function

    Public Shared Function IsEmployeeId(ByVal lId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Id FROM [Employees] WHERE [Id]=" & lId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            IsEmployeeId = rdr.HasRows
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetHoursPerJob(ByVal lJob As Integer) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT SUM(Employees_time.Time) AS TotalTime FROM Employees_time " &
                                      "WHERE Employees_time.Job=" & lJob.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                If Len(rdr("TotalTime").ToString) > 0 Then GetHoursPerJob = rdr("TotalTime").ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetWeeklyDates(ByVal sFecha As String, ByRef sFecDes As String, ByRef sFecHas As String, companyId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()

            GetWeeklyDates = GetWeeklyDates(cnn1, sFecha, sFecDes, sFecHas, companyId)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Shared Function GetWeeklyDates(ByVal cnn1 As SqlConnection, ByVal sFecha As String, ByRef sFecDes As String, ByRef sFecHas As String, companyId As Integer) As Boolean
        Try

            Dim cmd As SqlCommand = New SqlCommand("SELECT TOP (1) PaidDay FROM PaidDays " &
                                                    "WHERE companyId=" & companyId & " and PaidDay<" & GetFecha_102(sFecha) & " ORDER BY PaidDay DESC", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                If Len(rdr("PaidDay").ToString) > 0 Then sFecDes = DateAdd(DateInterval.Day, 1, rdr("PaidDay")).ToString
            End If
            rdr.Close()

            cmd.CommandText = "SELECT TOP (1) PaidDay FROM PaidDays " &
                                                    "WHERE companyId=" & companyId & " and PaidDay>=" & GetFecha_102(sFecha) & " ORDER BY PaidDay"
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                If Len(rdr("PaidDay").ToString) > 0 Then sFecHas = rdr("PaidDay").ToString
            End If
            rdr.Close()

            If Len(sFecDes) = 0 Then sFecDes = sFecha
            If Len(sFecHas) = 0 Then sFecHas = DateAdd(DateInterval.Day, 14, CDate(sFecDes))
            GetWeeklyDates = True

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetFechaCorta(ByVal sFecha As String) As String
        Dim lPos As Int16
        lPos = InStr(sFecha, " ")
        If lPos > 0 Then
            GetFechaCorta = Left(sFecha, lPos - 1)
        Else
            GetFechaCorta = sFecha
        End If
    End Function

    Public Shared Function IsActiveJob(ByVal jobId As Integer) As Boolean
        Dim Value = GetNumericEscalar("SELECT Jobs_status.Active FROM Jobs INNER JOIN Jobs_status ON Jobs.Status = Jobs_status.Id WHERE Jobs.Id=" & jobId)

        Return IIf(Value = 0, False, True)

    End Function

    Public Shared Function GetJobStatusName(ByVal statusId As Integer) As String
        Return GetStringEscalar("SELECT Name FROM Jobs_status WHERE Id=" & statusId)
    End Function



    Public Shared Function IsJobComplete(ByVal jobId As Integer) As Boolean
        Return GetNumericEscalar("SELECT dbo.IsJobComplete(" & jobId & ")")
    End Function

    ' ................................................................................................................................
    ' Funcion: GetLastEmployeeJob
    '          Retorna el ultimo Job trabajado por el employee
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetLastEmployeeJob(ByVal sEmail As String, lCompanyId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand
            cmd = New SqlCommand("SELECT TOP (1) Employees_time.Job FROM Employees_time INNER JOIN Employees ON Employees_time.Employee = Employees.Id " &
                                        "WHERE (Employees.Email='" & sEmail & "') AND Employees.companyId=" & lCompanyId & " ORDER BY Employees_time.DateEntry DESC", cnn1)
            Dim lValidJob As Integer
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                lValidJob = rdr(0)
                If IsActiveJob(lValidJob) Then GetLastEmployeeJob = lValidJob
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Shared Function NuevoTimeWeekly(ByVal lEmployee As Integer, ByVal sFecDes As String, ByVal sFecHas As String, ByVal dTime As String) As Boolean
        Try
            If dTime > 0 Then
                Dim cnn1 As SqlConnection = GetConnection()
                Dim cmd As New SqlCommand("INSERT INTO [EmployeesWeekly] ([Employee],[DateFrom],[DateTo],[Time]) " &
                                                            "VALUES (" & lEmployee.ToString & "," &
                                                                GetFecha_102(sFecDes) & "," &
                                                                GetFecha_102(sFecHas) & "," &
                                                                dTime & ")", cnn1)
                cmd.ExecuteNonQuery()
                cnn1.Close()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: SetEmployeesWeekly
    '          Actualizar tabla EmployeesWeekly con los tiempos por quincena
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function SetEmployeesWeekly(ByVal lEmployee As Integer, ByVal nYear As Int16) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            cmd.CommandText = "DELETE FROM [EmployeesWeekly] " 'WHERE Employee=" & lEmployee.ToString
            cmd.ExecuteNonQuery()
            If lEmployee > 0 Then
                Dim sEmail As String = GetEmployeeEmail(lEmployee)
                If Len(sEmail) > 0 Then

                    cmd.CommandText = "SELECT PaidDay FROM PaidDays WHERE Year(PaidDay)=" & nYear.ToString & " ORDER BY PaidDay"
                    Dim rdr As SqlDataReader
                    Dim sFecDes As String, sFecHas As String
                    Dim sTime As String, sTem As String
                    Dim bPrimeraVez As Boolean = True
                    rdr = cmd.ExecuteReader
                    While rdr.Read()
                        If bPrimeraVez Then
                            If rdr.HasRows Then
                                If Len(rdr("PaidDay").ToString) > 0 Then sFecDes = GetFechaCorta(rdr("PaidDay").ToString)
                            End If
                            bPrimeraVez = False
                        Else
                            sFecHas = ""
                            If rdr.HasRows Then
                                If Len(rdr("PaidDay").ToString) > 0 Then sFecHas = GetFechaCorta(rdr("PaidDay").ToString)
                                If Len(sFecDes) > 0 And Len(sFecHas) > 0 Then
                                    sTime = GetEmployeeHoursDay(lEmployee, sFecHas, True, sTem)
                                    NuevoTimeWeekly(lEmployee, sFecDes, sFecHas, sTime)
                                End If
                            End If
                            sFecDes = sFecHas
                        End If
                    End While
                    rdr.Close()
                End If
            End If
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    ' ................................................................................................................................
    ' Funcion: ActualizarEmployee
    '          Actualizar Employee en la tabla 'Employees' 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function ActualizarEmployee(ByVal lId As Long,
                                                ByVal sName As String, ByVal sPosition As String, ByVal sEmployee_Code As String, ByVal sAddress As String, ByVal sAddress2 As String, ByVal sCity As String, ByVal sState As String,
                                                ByVal sZipCode As String, ByVal sPhone As String, ByVal sCellular As String,
                                                ByVal sEmail As String, ByVal sHourRate As String,
                                                ByVal sStartingDate As String, ByVal sSS As String, ByVal sDOB As String, ByVal bInactive As Boolean) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            cmd.CommandText = "UPDATE [Employees] SET Name='" & sName & "', " &
                                                "Employee_Code='" & sEmployee_Code & "', " &
                                                "Position='" & sPosition & "', " &
                                                "Address='" & sAddress & "', " &
                                                "Address2='" & sAddress2 & "', " &
                                                "City='" & sCity & "', " &
                                                "Estate='" & sState & "', " &
                                                "ZipCode='" & sZipCode & "', " &
                                                "Phone='" & sPhone & "', " &
                                                "Cellular='" & sCellular & "', " &
                                                "Email='" & sEmail & "', " &
                                                "HourRate=" & FormatearNumero2Tsql(sHourRate) & "," &
                                                "starting_Date=" & GetFecha_102(sStartingDate) & "," &
                                                "SS='" & sSS & "', " &
                                                "DOB=" & GetFecha_102(sDOB) & "," &
                                                "[Inactive]=" & IIf(bInactive, 1, 0) &
                                                " WHERE Id=" & lId.ToString

            cmd.ExecuteNonQuery()
            cnn1.Close()
            ActualizarEmployee = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: Employees
    '          Elimina un Employee en la tabla 'Employees' 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function EliminarEmployee(ByVal employeeId As Integer) As Boolean
        Try
            Dim sEmail As String = GetEmployeeEmail(employeeId)
            ' Eliminar User
            If employeeId > 0 Then

                Dim cnn1 As SqlConnection = GetConnection()
                Dim cmd As SqlCommand = cnn1.CreateCommand()

                ' ClienteEmail
                cmd.CommandText = "DELETE FROM [Employees] WHERE Id=" & employeeId.ToString
                cmd.ExecuteNonQuery()

                cmd.CommandText = "DELETE FROM [Employees_time] WHERE Employee=" & employeeId.ToString
                cmd.ExecuteNonQuery()

                cmd.CommandText = "DELETE FROM [Employees_warning] WHERE Employee=" & employeeId.ToString
                cmd.ExecuteNonQuery()

                cmd.CommandText = "DELETE FROM [Employee_Agreements] WHERE employeeId=" & employeeId.ToString
                cmd.ExecuteNonQuery()

                cmd.CommandText = "DELETE FROM [Employee_HourlyWageHistory] WHERE employeeId=" & employeeId.ToString
                cmd.ExecuteNonQuery()

                cnn1.Close()

                'EliminarUser(sEmail)

                EliminarEmployee = True
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' Eliminar un usuario del Membership
    ' Si ya no existen Clients/Employees/Subconsultans asociados
    Public Shared Function EliminarUser(sEmail As String) As Boolean
        Try
            Dim nRegs As Integer = GetNumericEscalar("SELECT COUNT(*) FROM [Employees] WHERE [Email]='" & sEmail & "'")
            If nRegs = 0 Then
                nRegs = GetNumericEscalar("SELECT COUNT(*) FROM [Clients] WHERE [Email]='" & sEmail & "'")
                If nRegs = 0 Then
                    nRegs = GetNumericEscalar("SELECT COUNT(*) FROM [SubConsultans] WHERE [Email]='" & sEmail & "'")
                    If nRegs = 0 Then
                        'Membership.DeleteUser(sEmail, True)
                        Return True
                    End If
                End If
            End If
        Catch ex As Exception

        End Try
    End Function


    Public Shared Function EliminarProposal(ByVal proposalId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Eliminar ficha
            cmd.CommandText = "DELETE FROM Proposal WHERE [Id]=" & proposalId.ToString
            cmd.ExecuteNonQuery()

            cnn1.Close()
            EliminarProposal = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    ' ................................................................................................................................
    ' Funcion: EliminarCliente
    '          Elimina un job en la tabla 'Jobs' 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function EliminarCliente(ByVal clientId As Integer) As Boolean
        Try

            ' User Email
            Dim ClientEmail As String = GetClientEmail(clientId)

            ' Eliminate Entity y references......
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Client_DELETE"
            cmd.CommandType = CommandType.StoredProcedure
            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Id", clientId)
            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()
            cnn1.Close()

            ' Eliminate User....
            EliminarUser(ClientEmail)

            Return True

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function EliminarSubConsultan(ByVal lId As Integer) As Boolean
        Try
            ' Eliminar User
            Dim SubConsultansEmail As String = GetSubConsultanEmail(lId)

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Eliminar ficha
            cmd.CommandText = "DELETE FROM [SubConsultans] WHERE Id=" & lId.ToString
            cmd.ExecuteNonQuery()

            '???? Eliminar otros datos asociados....

            cnn1.Close()

            EliminarUser(SubConsultansEmail)

            EliminarSubConsultan = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetLastTimeId(ByVal lEmployee As Integer, ByVal lJob As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT TOP 1 Id FROM Employees_time WHERE Employee=" & lEmployee & " AND Job=" & lJob & " ORDER BY Id DESC", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetLastTimeId = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try


    End Function

    Public Shared Function GetTimeProperty(ByVal timeId As Integer, sProperty As String) As String
        Try
            Select Case sProperty
                Case "Employee", "Job", "Time", "HourRate", "proposaldetalleId", "CategoryId"
                    ' Numeric values
                    Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],0) FROM Employees_time WHERE Id=" & timeId)

                Case Else
                    Return GetStringEscalar("SELECT ISNULL([" & sProperty & "],'') FROM Employees_time WHERE Id=" & timeId)

            End Select

        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Shared Function SetEmployeePMOfJob(ByVal lEmployee As Integer, ByVal lJob As Integer) As Boolean
        ' Inicializa el Employee con el primer Time que se le asigna al Job
        Return ExecuteNonQuery("UPDATE Jobs SET Employee=" & lEmployee & " WHERE Id=" & lJob)

    End Function

    Public Shared Function InicializeEmployeeOfJob(ByVal lEmployee As Integer, ByVal lJob As Integer) As Boolean
        ' Status= In Progress
        ExecuteNonQuery("UPDATE Jobs SET Status=2 WHERE Id=" & lJob & " and Status=0")
        ' Inicializa el Employee con el primer Time que se le asigna al Job
        Return ExecuteNonQuery("UPDATE Jobs SET Employee=" & lEmployee & " WHERE Id=" & lJob & " AND ISNULL(Employee,0)=0")

    End Function

    Public Shared Function SetJobLocationError(ByVal lJob As Integer) As Boolean
        Try
            Return ExecuteNonQuery("UPDATE Jobs SET ProjectLocation=Left('(!) '+[ProjectLocation],80) WHERE Id=" & lJob & " and left(ProjectLocation,3)<>'(!)'")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function NewTime_old(ByVal lEmployee As Integer, ByVal lJob As Integer, ByVal sFecha As DateTime,
                                            ByVal dTime As Double, ByVal sDescription As String, proposaldetalleId As Integer, CategoryId As Integer) As Boolean
        Try
            'InicializeEmployeeOfJob(lEmployee, lJob)

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "JobTimeEntries_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@JobId", lJob)
            cmd.Parameters.AddWithValue("@EmployeeId", lEmployee)
            cmd.Parameters.AddWithValue("@Fecha", sFecha)
            cmd.Parameters.AddWithValue("@Hours", dTime)
            cmd.Parameters.AddWithValue("@Description", sDescription)
            cmd.Parameters.AddWithValue("@proposaldetalleId", proposaldetalleId)
            cmd.Parameters.AddWithValue("@CategoryId", CategoryId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function InsertNewTime(ByVal lEmployee As Integer, ByVal lJob As Integer, ByVal sFecha As DateTime,
                                            ByVal dTime As Double, ByVal sDescription As String, proposaldetalleId As Integer, CategoryId As Integer, companyId As Integer, Optional JobTicketId As Integer = 0) As Boolean
        Try
            'InicializeEmployeeOfJob(lEmployee, lJob)

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "JobTimeEntries_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@JobId", lJob)
            cmd.Parameters.AddWithValue("@EmployeeId", lEmployee)
            cmd.Parameters.AddWithValue("@Fecha", sFecha)
            cmd.Parameters.AddWithValue("@Hours", dTime)
            cmd.Parameters.AddWithValue("@Description", sDescription)
            cmd.Parameters.AddWithValue("@proposaldetalleId", proposaldetalleId)
            cmd.Parameters.AddWithValue("@CategoryId", CategoryId)
            cmd.Parameters.AddWithValue("@JobTicketId", JobTicketId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            ' Cambio automatico de status despues de New Time
            Select Case GetJobStatusId(lJob)
                Case 0  'Not in Progress pasa a In Progress
                    LocalAPI.SetJobStatus(lJob, 2, lEmployee, companyId, lEmployee)
                Case 4  'Submitted pasa a Under Revision
                    LocalAPI.SetJobStatus(lJob, 5, lEmployee, companyId, lEmployee)
            End Select

            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function NewNonJobTime(ByVal EmployeeId As Integer, ByVal TypeId As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime, ByVal Hours As Double, ByVal Notes As String) As Boolean
        Try
            'InicializeEmployeeOfJob(lEmployee, lJob)

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "NonProductiveTime_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@EmployeeId", EmployeeId)
            cmd.Parameters.AddWithValue("@TypeId", TypeId)
            cmd.Parameters.AddWithValue("@DateFrom", DateFrom)
            cmd.Parameters.AddWithValue("@DateTo", DateTo)
            cmd.Parameters.AddWithValue("@Hours", Hours)
            cmd.Parameters.AddWithValue("@Notes", Notes)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewNonJobTime, -1, Notes)
            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function NewNonJobTime_old(ByVal lEmployee As Integer, ByVal lType As Integer, ByVal DateFrom As String, ByVal DateTo As String, ByVal nTime As String, ByVal sNotes As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            Dim sTime As String = FormatearNumero2Tsql(nTime.ToString)
            ' ClienteEmail
            cmd.CommandText = "INSERT INTO [Employees_NonRegularHours] (EmployeeId, Type, DateFrom, DateTo, Hours, Notes) " &
                                                    "VALUES (" & lEmployee.ToString & "," &
                                                        lType.ToString & "," &
                                                        GetFecha_102(DateFrom) & "," &
                                                        GetFecha_102(DateTo) & "," &
                                                        sTime & ",'" &
                                                        sNotes & "')"

            cmd.ExecuteNonQuery()
            cnn1.Close()
            Return True

            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewNonJobTime, -1, sNotes)

        Catch ex As Exception
            Throw ex
        End Try
    End Function


    ' ................................................................................................................................
    ' Funcion: GetTimeData
    '          Leer datos del Time 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetTimeData(ByVal lId As Long,
                                        ByRef lEmployee As Integer, ByRef lJob As Integer, ByRef sFecha As String,
                                        ByRef nTime As Double, ByRef sDescription As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT * FROM [Employees_time] WHERE [Id]=" & lId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                lEmployee = rdr("Employee")
                lJob = rdr("Job").ToString
                sFecha = rdr("Fecha").ToString
                nTime = rdr("Time").ToString
                sDescription = rdr("Description").ToString
                GetTimeData = True
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetTandCPages() As Integer
        Return GetNumericEscalar("SELECT COUNT(*) FROM TandC")
    End Function

    ' ................................................................................................................................
    ' Funcion: GetClientsNumbers
    '          Cantidad de clientes
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientsNumbers(ByVal companyId As Integer) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT ISNULL(COUNT(*), 0) As Cantidad  FROM [Clients] WHERE companyId=" & companyId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientsNumbers = rdr("Cantidad")
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    ' ................................................................................................................................
    ' Funcion: GetClientsNumbers
    '          Cantidad de clientes
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientsNumbers(ByVal nYear As Int16, ByVal companyId As Integer) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT ISNULL(COUNT(*), 0) As Cantidad  FROM [Clients] WHERE companyId=" & companyId & " AND YEAR(StartingDate)=" & nYear, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientsNumbers = rdr("Cantidad")
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetEmployeeNoCollectedInvoiceNumber
    '          Leer cantidad de Invoices No Collected para el Empleado 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientNoCollectedInvoiceNumber(ByVal lClientId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT COUNT(*) AS Expr1 FROM Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id " &
                                      "WHERE (ISNULL(Invoices.AmountDue, 0) > 0) AND Jobs.Client=" & lClientId.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientNoCollectedInvoiceNumber = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetInvoiceEmmited(ByVal lJob As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT TOP 1 ISNULL(Emitted,0) FROM Invoices WHERE JobId=" & lJob & " AND ISNULL(AmountDue, 0) > 0 ORDER BY InvoiceDate, Id", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetInvoiceEmmited = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    ' ................................................................................................................................
    ' Funcion: GetEmployeeNoCollectedInvoiceNumber
    '          IMPORTE de Invoices No Collected  
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientNoCollectedInvoice(ByVal nYear As Int16, ByVal companyId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim sWhere As String = "WHERE Jobs.companyId=" & companyId & " AND (ISNULL(Invoices.AmountDue, 0) > 0) "
            If nYear > 0 Then sWhere = sWhere & " AND YEAR(InvoiceDate)=" & nYear
            Dim cmd As New SqlCommand("SELECT SUM(ISNULL(Amount,0)) AS Expr1 FROM Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id " &
                                      sWhere, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientNoCollectedInvoice = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetClientNoEmittedInvoiceNumber
    '          Leer cantidad de Invoices No Collected para el Empleado 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientNoEmittedInvoiceNumber(ByVal lClientId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT COUNT(*) AS Expr1 FROM Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id " &
                                      "WHERE (ISNULL(Invoices.Emitted,0) = 0) AND Jobs.Client=" & lClientId.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientNoEmittedInvoiceNumber = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: ActualizarTime
    '          Actualizar registro en la tabla 'Employees_time' 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function ActualizarTime(ByVal lId As Integer,
                                        ByVal lEmployee As Integer, ByVal lJob As Integer, ByVal sFecha As String,
                                        ByVal nTime As String,
                                        ByVal sDescription As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            Dim sTime As String = FormatearNumero2Tsql(nTime.ToString)

            ' ClienteEmail
            cmd.CommandText = "UPDATE [Employees_time] SET Employee=" & lEmployee.ToString & ", " &
                                                "Job=" & lJob.ToString & ", " &
                                                "Fecha=" & GetFecha_102(sFecha) & ", " &
                                                "Time=" & sTime & "," &
                                                "Description='" & sDescription & "'" &
                                                " WHERE Id=" & lId.ToString

            cmd.ExecuteNonQuery()

            cnn1.Close()
            ActualizarTime = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: EliminarTime
    '          Elimina un registro en la tabla 'Employees_time' 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function EliminarTime(ByVal lId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            cmd.CommandText = "DELETE FROM [Employees_time] WHERE Id=" & lId.ToString
            cmd.ExecuteNonQuery()

            cnn1.Close()
            EliminarTime = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: NuevoCliente
    '          Nuevo client en la tabla 'Clients' 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function Client_INSERT(ByVal sName As String, ByVal sEmail As String, ByVal sInitials As String,
                                        ByVal companyId As Integer,
                                        Optional ByVal sCompany As String = "",
                                        Optional ByVal sAddress As String = "",
                                        Optional ByVal sAddress2 As String = "",
                                        Optional ByVal sCity As String = "",
                                        Optional ByVal sState As String = "",
                                        Optional ByVal sZipCode As String = "",
                                        Optional ByVal sPhone As String = "",
                                        Optional ByVal sCellular As String = "",
                                        Optional ByVal sFax As String = "",
                                        Optional ByVal sWeb As String = "",
                                        Optional ByVal sStartingDate As String = "",
                                        Optional ByVal sPosition As String = "",
                                        Optional ByVal sBillingContact As String = "",
                                        Optional ByVal sBillingTelephone As String = "",
                                        Optional ByVal sNotes As String = "",
                                        Optional ByVal Type As Integer = 0,
                                        Optional ByVal Subtype As Integer = 0,
                                        Optional ByVal TAGs As String = "",
                                        Optional ByVal Billing_Email As String = "",
                                        Optional ByVal Source As String = "",
                                        Optional ByVal NAICS_code As String = "",
                                        Optional ByVal employeeId As Integer = 0) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Client_v20_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Name", sName)
            cmd.Parameters.AddWithValue("@Position", sPosition)
            cmd.Parameters.AddWithValue("@Email", sEmail)
            cmd.Parameters.AddWithValue("@Initials", sInitials)
            cmd.Parameters.AddWithValue("@Phone", sPhone)
            cmd.Parameters.AddWithValue("@Cellular", sCellular)
            cmd.Parameters.AddWithValue("@Fax", sFax)
            cmd.Parameters.AddWithValue("@Web", sWeb)
            cmd.Parameters.AddWithValue("@StartingDate", sStartingDate)
            cmd.Parameters.AddWithValue("@Company", sCompany)
            cmd.Parameters.AddWithValue("@Address", sAddress)
            cmd.Parameters.AddWithValue("@Address2", sAddress2)
            cmd.Parameters.AddWithValue("@City", sCity)
            cmd.Parameters.AddWithValue("@State", sState)
            cmd.Parameters.AddWithValue("@ZipCode", sZipCode)
            cmd.Parameters.AddWithValue("@Billing_contact", sBillingContact)
            cmd.Parameters.AddWithValue("@Billing_Telephone", sBillingTelephone)
            cmd.Parameters.AddWithValue("@Billing_Email", Billing_Email)
            cmd.Parameters.AddWithValue("@Notes", sNotes)
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@Type", Type)
            cmd.Parameters.AddWithValue("@Subtype", Subtype)
            cmd.Parameters.AddWithValue("@TAGs", TAGs)
            cmd.Parameters.AddWithValue("@Source", Source)
            cmd.Parameters.AddWithValue("@NAICS_code", NAICS_code)
            cmd.Parameters.AddWithValue("@employeeId", employeeId)

            ' Execute the stored procedure.
            Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            Dim clientId As Integer = parOUT_ID.Value
            cnn1.Close()

            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewClient, companyId, sName)

            ' Update Latitude, Longitude
            LocalAPI.ClientGeolocationUpdate(clientId)

            Return clientId
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetClientId
    '          Leer Id del client desde su email 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientId(ByVal sEmail As String, ByVal companyId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Id FROM [Clients] WHERE companyId=" & companyId & " AND [Email]='" & sEmail & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientId = rdr("Id").ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetClientName
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientName(ByVal sEmail As String) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Name FROM [Clients] WHERE [Email]='" & sEmail & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientName = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetClientName
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientNameFromId(ByVal sId As Integer) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Name FROM [Clients] WHERE [Id]=" & sId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientNameFromId = "" & rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetClientNameFromInitial
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientNameFromInitial(ByVal companyId As Integer, ByVal sInitials As String) As String
        Try
            Dim sParam As String = "" & sInitials
            If Len(sParam) > 0 Then

                Dim cnn1 As SqlConnection = GetConnection()
                Dim cmd As New SqlCommand("SELECT [Name]+',('+CAST([Phone] AS NVARCHAR(20))+')' FROM [Clients] WHERE companyId=" & companyId & " AND [Initials]='" & sParam & "'", cnn1)
                Dim rdr As SqlDataReader
                rdr = cmd.ExecuteReader
                rdr.Read()
                If rdr.HasRows Then
                    GetClientNameFromInitial = rdr(0).ToString
                End If
                rdr.Close()
                cnn1.Close()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetClientProperty(ByVal clientId As Long, ByVal sProperty As String) As String
        Try
            Select Case sProperty
                Case "companyId", "Notification_invoiceemitted", "Notification_invoicecollected", "Notification_acceptedproposal", "Notification_declinedproposal", "ProposalPDFattached", "Type", "Subtype", "Allow_SMSnotification", "AvailabilityId", "qbCustomerId", "BillType", "Longitude", "Latitude"
                    Return GetNumericEscalar(String.Format("SELECT ISNULL([{0}],0) FROM [Clients] WHERE [Id]={1}", sProperty, clientId))
                Case Else
                    Return GetStringEscalar(String.Format("SELECT ISNULL([{0}],'') FROM [Clients] WHERE [Id]={1}", sProperty, clientId))
            End Select

        Catch ex As Exception
            Return ""
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetClientInitials
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientInitials(ByVal lClientId As Integer) As String
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT [Initials] FROM [Clients] WHERE Id=" & lClientId.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientInitials = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetClientEmail
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientEmail(ByVal lClientId As Integer) As String
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT [Email] FROM [Clients] WHERE Id=" & lClientId.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientEmail = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function GetClientIdFromGUID(clientGUID As String) As Integer
        ' inject sql ....Return GetNumericEscalar("SELECT ISNULL(Id,0) FROM [Clients] WHERE [guid]='" & clientGUID & "'")

        Dim cnn1 As SqlConnection = GetConnection()
        Dim cmd As New SqlCommand("SELECT ISNULL(Id,0) FROM [Clients] WHERE [guid]=@clientGUID", cnn1)
        cmd.Parameters.AddWithValue("@clientGUID", clientGUID)
        GetClientIdFromGUID = Convert.ToDouble(cmd.ExecuteScalar())
        cnn1.Close()

    End Function


    Public Shared Function GetSatusDescription(ByVal statusId As String) As String
        Try
            Return GetStringEscalar("SELECT [Description] FROM [Clients_status] WHERE Id=" & statusId.ToString)
        Catch ex As Exception
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: IsClientInitials
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function IsClientInitials(ByVal sInitials As String, ByVal companyId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Id FROM [Clients] WHERE [Initials]='" & sInitials & "' AND companyId='" & companyId & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            IsClientInitials = rdr.HasRows
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: IsClientId
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function IsClientId(ByVal lId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Id FROM [Clients] WHERE [Id]=" & lId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            IsClientId = rdr.HasRows
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: IsClientEmail
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function IsClientEmail(ByVal sEmail As String, ByVal companyId As Integer) As Boolean
        Return (GetNumericEscalar("SELECT COUNT(*) FROM Clients WHERE companyId=" & companyId & " AND ISNULL(Email,'')='" & sEmail & "'") > 0)
    End Function

    Public Shared Function IsClientName(ByVal sName As String, ByVal companyId As Integer) As Boolean
        Return (GetNumericEscalar("SELECT COUNT(*) FROM Clients WHERE companyId=" & companyId & " AND ISNULL(Name,'')='" & sName & "'") > 0)
    End Function


    Public Shared Function IsClientByName(ByVal sName As String, ByVal companyId As Integer) As Boolean
        Return (GetNumericEscalar("SELECT COUNT(Id) FROM Clients WHERE Name='" & sName & "' and companyId=" & companyId) > 0)
    End Function


    Public Shared Function IsCompany(ByVal sCompanyName As String) As Boolean

        Return (GetNumericEscalar("SELECT COUNT(companyId) FROM Company WHERE Name='" & sCompanyName & "'") > 0)

    End Function

    ' ................................................................................................................................
    ' Funcion: GetTypeName
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetTypeName(ByVal sType As Object) As String
        Try

            Dim sParam As String = "" & sType
            If Len(sParam) > 0 Then
                Dim cnn1 As SqlConnection = GetConnection()
                Dim cmd As New SqlCommand("SELECT Name FROM [Jobs_types] WHERE [Id]='" & sParam & "'", cnn1)
                Dim rdr As SqlDataReader
                rdr = cmd.ExecuteReader
                rdr.Read()
                If rdr.HasRows Then
                    GetTypeName = rdr(0).ToString
                End If
                rdr.Close()
                cnn1.Close()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetClientName
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientName(ByVal lClientId As Integer) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Name FROM [Clients] WHERE [Id]=" & lClientId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientName = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetClientEmailFromInvoice
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientEmailFromInvoice(ByVal lInvoice As Long) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("Select Clients.Email FROM Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id INNER JOIN Clients ON Jobs.Client = Clients.Id WHERE Invoices.Id=" & lInvoice.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientEmailFromInvoice = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetClientIdFromInvoice(ByVal lInvoice As Long) As Integer
        Try

            Return GetNumericEscalar("SELECT Jobs.Client FROM Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id WHERE Invoices.Id=" & lInvoice.ToString)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetSenderReplyFromInvoice(ByVal lInvoice As Long) As Integer
        Try

            Return GetNumericEscalar("SELECT Jobs.Client FROM Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id WHERE Invoices.Id=" & lInvoice.ToString)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetBillingContactEmailFromInvoice(ByVal lInvoice As Long) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("Select ISNULL(Clients.Billing_Email,'') FROM Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id INNER JOIN Clients ON Jobs.Client = Clients.Id WHERE Invoices.Id=" & lInvoice.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetBillingContactEmailFromInvoice = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetBillingContactFromStatement(ByVal lStatementId As Long) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("Select ISNULL(Clients.Billing_contact,'') FROM Invoices_statements INNER JOIN Clients ON Invoices_statements.clientid = Clients.Id WHERE Invoices_statements.Id=" & lStatementId.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetBillingContactFromStatement = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetBillingContactEmailFromStatement(ByVal lStatementId As Long) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("Select ISNULL(Clients.Billing_Email,'') FROM Invoices_statements INNER JOIN Clients ON Invoices_statements.clientid = Clients.Id WHERE Invoices_statements.Id=" & lStatementId.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetBillingContactEmailFromStatement = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    ' ................................................................................................................................
    ' Funcion: GetClientEmailFromProposal
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientEmailFromProposal(ByVal lProposalId As Long) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("Select Clients.Email FROM Proposal INNER JOIN Clients ON Proposal.ClientId = Clients.Id WHERE Proposal.Id=" & lProposalId.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientEmailFromProposal = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetFecha_102(ByVal sFecha As String) As String
        GetFecha_102 = "CONVERT(DATETIME, '" & Year(sFecha) & "-" & Month(sFecha) & "-" & Day(sFecha) & " 00:00:00', 102)"
        '2005-01-24 00:00:00
    End Function

    Public Shared Function GetFecha_Hora(ByVal sFechaHora As DateTime) As String
        GetFecha_Hora = "CONVERT(DATETIME, '" & Year(sFechaHora) & "-" & Month(sFechaHora) & "-" & Day(sFechaHora) &
                        " " & sFechaHora.Hour & ":" & sFechaHora.Minute & ":" & sFechaHora.Second & "', 102)"
        '2005-01-24 17:01:35
    End Function

    Public Shared Function GetFecha_Corta(ByVal sFecha As String) As String
        GetFecha_Corta = Month(sFecha) & "-" & Day(sFecha) & "-" & Right(Year(sFecha), 2)
        '01-24-08
    End Function

    Public Shared Function LinkJobFile(ByVal sFile As String) As String
        If Len(sFile) > 0 Then
            LinkJobFile = ConfigurationManager.AppSettings("FileWebPath") & "/" & sFile
        End If
    End Function

    Public Shared Function GetJobColleted(ByVal lJobId As Long) As Double
        Try
            Return GetNumericEscalar("SELECT dbo.JobCollected(" & lJobId.ToString & ")")
        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Shared Function GetJobTotalBudgetThisMonth(ByVal companyId As Integer) As Double
        Try
            Return GetNumericEscalar("select isnull(sum(Budget),0) from Jobs where companyId=" & companyId & " and year(Jobs.Open_date)=year(" & GetDateUTHlocal() & ") and month(Jobs.Open_date)=month(" & GetDateUTHlocal() & ")")
        Catch ex As Exception
            Return 0
        End Try
    End Function
    Public Shared Function GetSubcontratTotalThisMonth(ByVal companyId As Integer) As Double
        Try
            Return GetNumericEscalar("select sum(isnull(RequestForProposals_details.LineTotal,0)) from RequestForProposals LEFT OUTER JOIN RequestForProposals_details ON RequestForProposals.Id = RequestForProposals_details.rfpId where companyId=" & companyId & " and year(DateCreated)=year(" & GetDateUTHlocal() & ") and month(DateCreated)=month(" & GetDateUTHlocal() & ")")
        Catch ex As Exception
            Return 0
        End Try
    End Function
    Public Shared Function GetSubcontratTotalThisYear(ByVal companyId As Integer) As Double
        Try
            Return GetNumericEscalar(String.Format("select dbo.JobsSubContracted({0},-1,{1})", companyId, Year(GetDateTime())))
        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Shared Function GetJobTotalBudgetThisYear(ByVal companyId As Integer) As Double
        Try
            Return GetNumericEscalar(String.Format("select dbo.JobsTotal({0},{1})", companyId, Year(GetDateTime())))
        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Shared Function GetProposalBudgetThisMonth(ByVal companyId As Integer) As Double
        Try
            Dim nYear As Integer = Year(GetDateTime())
            Dim nMonth As Integer = Month(GetDateTime())
            Return GetNumericEscalar("select dbo.ProposalsTotalMonth(" & companyId & "," & nYear & "," & nMonth & ")")
        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Shared Function GetProposalBudgetThisYear(ByVal companyId As Integer) As Double
        Try
            Dim nYear As Integer = Year(GetDateTime())

            Return GetNumericEscalar("select dbo.ProposalsTotal(" & companyId & "," & nYear & ")")
        Catch ex As Exception
            Return 0
        End Try
    End Function
    Public Shared Function GetTotalPendingToCollect(ByVal companyId As Integer) As Double
        Try
            Return GetNumericEscalar("SELECT dbo.PendingToCollect(" & companyId & ")")
        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Shared Function GetJobTotalAmountPending(ByVal companyId As Integer) As Double
        Try
            Return GetNumericEscalar("SELECT dbo.JobAmountPending(" & companyId & ")")
        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Shared Function GetJobProposalCount(ByVal lJobId As Long) As Double
        Return GetNumericEscalar("SELECT COUNT(*) FROM Proposal WHERE JobId=" & lJobId.ToString)
    End Function

    Public Shared Function GetJobProposalAmount(ByVal lJobId As Long) As Double
        Try
            Return GetNumericEscalar("SELECT SUM(ISNULL(TotalRow,0)) FROM Proposal_details WHERE ProposalId IN(SELECT Id FROM Proposal WHERE JobId=" & lJobId.ToString & ")")
        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Shared Function GetProposalDetailProperty(ByVal detailId As Integer, sProperty As String) As String
        Try
            Select Case sProperty
                Case "Amount", "Hours", "Rates", "phaseId", "positionId", "TaskId", "BillType", "TotalRow"
                    ' Numeric values
                    Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],0) FROM Proposal_details WHERE Id=" & detailId)

                Case Else
                    Return GetStringEscalar("SELECT ISNULL([" & sProperty & "],'') FROM Proposal_details WHERE Id=" & detailId)

            End Select

        Catch ex As Exception
            Return 0
        End Try
    End Function



    Public Shared Function GetProposalPhaseProperty(ByVal phaseId As Integer, sProperty As String) As String
        Try
            Select Case sProperty
                Case "nOrder", "proposalId"
                    ' Numeric values
                    Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],0) FROM Proposal_phases WHERE Id=" & phaseId)

                Case "DateFrom", "DateTo"
                    ' Date values
                    Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],dbo.CurrentTime()) FROM Proposal_phases WHERE Id=" & phaseId)

                Case Else
                    Return GetStringEscalar("SELECT ISNULL([" & sProperty & "],'') FROM Proposal_phases WHERE Id=" & phaseId)

            End Select

        Catch ex As Exception
            Return 0
        End Try
    End Function



    ' ................................................................................................................................
    ' Funcion: GetClientJobNumber
    ' ................................................................................................................................
    Public Shared Function GetClientJobNumber(ByVal lClientId As Long) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT COUNT(*) AS Cantidad FROM Jobs WHERE Client=" & lClientId.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientJobNumber = rdr(0)
            Else
                GetClientJobNumber = 0
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetClientTotalBudget
    ' ................................................................................................................................
    Public Shared Function GetClientTotalBudget(ByVal lClientId As Long) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT SUM(ISNULL(Budget,0)) AS Total FROM Jobs WHERE Client=" & lClientId.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientTotalBudget = rdr(0)
            Else
                GetClientTotalBudget = 0
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetJobColleted
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetClientJobColleted(ByVal lClientId As Long) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT ISNULL(SUM(ISNULL(Amount,0)),0) AS Total FROM Invoices WHERE ISNULL(AmountDue,0)<ISNULL(Amount,0) AND JobId IN (SELECT Id FROM Jobs WHERE Client=" & lClientId.ToString & ")", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetClientJobColleted = rdr(0)
            Else
                GetClientJobColleted = 0
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetJobProfit
    '          Calcula SUM(CosteS)/Budget*100
    ' Retorno: Valor 
    ' ................................................................................................................................
    Public Shared Function GetJobProfit(ByRef lJob As Integer) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "eeg_Profit"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            Dim jobID As SqlParameter = New SqlParameter("@JobId", SqlDbType.Int)
            jobID.Value = lJob
            cmd.Parameters.Add(jobID)

            ' Set up the output parameter 
            Dim paramResult As SqlParameter =
                New SqlParameter("@dPercente", SqlDbType.Float)
            paramResult.Direction = ParameterDirection.Output
            cmd.Parameters.Add(paramResult)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            GetJobProfit = paramResult.Value

            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetBudgetUsed
    '          Calcula SUM(CosteS)/Budget*100
    '           Si lJob=-1, all jobs
    '           Si lEmployee=-1, all employees
    ' Retorno: Valor 
    ' ................................................................................................................................
    Public Shared Function GetBudgetUsed(ByVal lCompanyId As Long, ByRef lJob As Integer, ByVal lEmployee As Integer) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "eeg_BudgetUsed"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            Dim companyID As SqlParameter = New SqlParameter("@CompanyId", SqlDbType.Int)
            companyID.Value = lCompanyId
            cmd.Parameters.Add(companyID)

            Dim jobID As SqlParameter = New SqlParameter("@JobId", SqlDbType.Int)
            jobID.Value = lJob
            cmd.Parameters.Add(jobID)

            Dim EmployeeID As SqlParameter = New SqlParameter("@EmployeeId", SqlDbType.Int)
            EmployeeID.Value = lEmployee
            cmd.Parameters.Add(EmployeeID)

            ' Set up the output parameter 
            Dim paramResult As SqlParameter =
                New SqlParameter("@dPercente", SqlDbType.Float)
            paramResult.Direction = ParameterDirection.Output
            cmd.Parameters.Add(paramResult)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            GetBudgetUsed = paramResult.Value

            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetJobnameFromInvoice
    '          Leer Id del client desde su email 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetJobNameFromInvoice(ByVal lInvoice As Long) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("Select Jobs.Job FROM Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id WHERE Invoices.Id=" & lInvoice.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetJobNameFromInvoice = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetJobnameFromInvoice
    '          Leer Id del client desde su email 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetJobPropertyFromProposalId(ByVal lProposalId As Long, ByVal sProperty As String) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT " & sProperty & " FROM Jobs INNER JOIN Proposal ON Jobs.Id = Proposal.JobId WHERE Proposal.Id=" & lProposalId.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetJobPropertyFromProposalId = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    ' ................................................................................................................................
    ' Funcion: GetInvoiceAmount
    '          Leer Id del client desde su email 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetInvoiceAmount(ByVal lInvoice As Long) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("Select Amount FROM Invoices WHERE Id=" & lInvoice.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetInvoiceAmount = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobInvoicesAmountTotal(ByVal lJob As Long) As Double
        Return GetNumericEscalar("Select sum(isnull(Amount,0)) FROM Invoices WHERE JobId=" & lJob)
    End Function

    Public Shared Function GetInvoicesAmountDue(ByVal invoiceId As Integer) As Double
        Return GetNumericEscalar("Select isnull(AmountDue,0) FROM Invoices WHERE Id=" & invoiceId)
    End Function

    Public Shared Function GetInvoiceTotal(ByVal sTotalField As String, ByVal sWhere As String) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("Select ISNULL(SUM(" & sTotalField & "),0) FROM RPX_Invoice " & sWhere, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetInvoiceTotal = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            GetInvoiceTotal = 0
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: IsERmployeeWarning
    '           Averigua si el registro de warning ya existe, cuyo caso devuelve True
    '           En caso de no existir lo crea y devuelve False
    ' ................................................................................................................................
    Public Shared Function IsEmployeeWarning(ByRef lJob As Integer, ByRef lEmployee As Integer,
                                            ByVal sKey As String, ByVal sMessage As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "eeg_EmployeeWarnig"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            Dim jobID As SqlParameter = New SqlParameter("@JobId", SqlDbType.Int)
            jobID.Value = lJob
            cmd.Parameters.Add(jobID)

            Dim lEmployeeIdId As SqlParameter = New SqlParameter("@EmployeeIdId", SqlDbType.Int)
            lEmployeeIdId.Value = lEmployee
            cmd.Parameters.Add(lEmployeeIdId)

            Dim Key As SqlParameter = New SqlParameter("@Key", SqlDbType.NVarChar, 3)
            Key.Value = sKey
            cmd.Parameters.Add(Key)

            Dim Message As SqlParameter = New SqlParameter("@MESSAGE", SqlDbType.NVarChar, 256)
            Message.Value = sMessage
            cmd.Parameters.Add(Message)

            ' Set up the output parameter 
            Dim paramReturn As SqlParameter =
                New SqlParameter("@Return", SqlDbType.Int)
            paramReturn.Direction = ParameterDirection.Output
            cmd.Parameters.Add(paramReturn)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            IsEmployeeWarning = paramReturn.Value

            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function SendInvoiceToClient_obsoleto(ByVal lInvoiceId As Integer) As Boolean
        If lInvoiceId > 0 Then
            Dim sClientMail As String = LocalAPI.GetClientEmailFromInvoice(lInvoiceId)
            If Len(sClientMail) > 0 Then
                Dim sJobName As String = GetJobNameFromInvoice(lInvoiceId)
                Dim sClientName As String = GetClientName(sClientMail)
                Dim sSubject As String = ConfigurationManager.AppSettings("TituloWeb") & ". Invoice " & lInvoiceId.ToString
                Dim sPay As String = FormatNumber(LocalAPI.GetInvoiceAmount(lInvoiceId), 2)
                Dim companyId As Integer = GetCompanyIdFromClient(sClientMail)

                ' Componer el Body
                Dim sMsg As New System.Text.StringBuilder
                sMsg.Append("Dear <strong>" & sClientName & "</strong>:")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("The invoice No. " & lInvoiceId & " of the project '" & sJobName & "' has been emitted. As per contract, the amount to pay is $" & sPay)
                sMsg.Append("<br />")
                sMsg.Append("To see the details of the invoice, visit the following site: ")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("<a href=" & """" & LocalAPI.GetHostAppSite() & "/ADMCLI/Invoice.aspx?InvoiceNo=" & lInvoiceId.ToString & """" & ">" & LocalAPI.GetHostAppSite() & "/Invoice</a>")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Best regards,")
                sMsg.Append("<br />")
                sMsg.Append("<strong>" & GetCompanyProperty(companyId, "EmailSign") & "</strong>")
                sMsg.Append("<br />")
                sMsg.Append(GetCompanyProperty(companyId, "EmailSign2"))
                sMsg.Append("<br />")
                sMsg.Append(ConfigurationManager.AppSettings("TituloWeb") & ".")
                sMsg.Append("<br />")
                sMsg.Append("<a href=" & """" & GetHostAppSite() & """" & ">" & LocalAPI.GetHostAppSite() & "</a>")

                Dim sBody As String = sMsg.ToString

                SendGrid.Email.SendMail(sClientMail, "", ConfigurationManager.AppSettings("webEmailProfitWarningCC"), sSubject, sBody, companyId, 0, 0)
                SendInvoiceToClient_obsoleto = True
            End If
        End If
    End Function

    Public Shared Function DescargaHTML(ByVal url As String) As String
        Try
            DescargaHTML = Encoding.UTF8.GetString(New WebClient().DownloadData(url))
        Catch ex As Exception
            Throw ex

        End Try
    End Function

    Public Shared Function GetTaskIdFromTaskcode(ByVal tascode As String, ByVal companyId As Integer) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Id FROM [Proposal_tasks] WHERE companyId=" & companyId & " AND taskcode='" & tascode & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetTaskIdFromTaskcode = "" & rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: NewProposal
    '          Nuevo registro en la tabla 'Proposal'. Inicializacion segun su tipo 
    ' Retorno: Id del nuevo proposal. 
    ' ................................................................................................................................
    Public Shared Function Proposal_Wizard_INSERT(ByVal lType As Integer, ByVal ProjectName As String, employeeId As Integer, ByVal companyId As Integer, activeEmployeeId As Integer, ProjectSector As Integer, ProjectUse As String, ProjectUse2 As String, DepartmentId As Integer, Retainer As Boolean, ProjectLocation As String, Unit As Double, Measure As Integer, ProjectType As String, clientId As Integer, ProjectManagerId As Integer, Owner As String, TextBegin As String, TextEnd As String) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            Dim proposalId As Integer
            Dim SharePublicLinks As Boolean = IsAzureStorage(companyId)

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Proposal_Wizard_INSERT"
            cmd.CommandType = CommandType.StoredProcedure
            Dim taskId As String

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@ClientId", clientId)
            cmd.Parameters.AddWithValue("@Type", lType)
            cmd.Parameters.AddWithValue("@ProjectType", ProjectType)
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@ProjectName", ProjectName)
            cmd.Parameters.AddWithValue("@ProjectLocation", ProjectLocation)

            cmd.Parameters.AddWithValue("@EmployeeAprovedId", employeeId)
            cmd.Parameters.AddWithValue("@ProjectSector", ProjectSector)
            cmd.Parameters.AddWithValue("@ProjectUse", ProjectUse)
            cmd.Parameters.AddWithValue("@ProjectUse2", ProjectUse2)
            cmd.Parameters.AddWithValue("@DepartmentId", DepartmentId)
            cmd.Parameters.AddWithValue("@Retainer", IIf(Retainer, 1, 0))
            cmd.Parameters.AddWithValue("@Unit", FormatearNumero2Tsql(Unit))
            cmd.Parameters.AddWithValue("@Measure", Measure)
            cmd.Parameters.AddWithValue("@SharePublicLinks", IIf(SharePublicLinks, 1, 0))
            cmd.Parameters.AddWithValue("@ProjectManagerId", ProjectManagerId)
            cmd.Parameters.AddWithValue("@employeeId", activeEmployeeId)

            cmd.Parameters.AddWithValue("@Owner", Owner)
            cmd.Parameters.AddWithValue("@TextBegin", TextBegin)
            cmd.Parameters.AddWithValue("@TextEnd", TextEnd)

            ' Set up the output parameter 
            Dim parTaskIdList As SqlParameter = New SqlParameter("@TaskIdList", SqlDbType.NVarChar, 80)
            parTaskIdList.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parTaskIdList)
            Dim parPaymentsScheduleList As SqlParameter = New SqlParameter("@PaymentsScheduleList", SqlDbType.NVarChar, 80)
            parPaymentsScheduleList.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parPaymentsScheduleList)
            Dim parPaymentsTextList As SqlParameter = New SqlParameter("@PaymentsTextList", SqlDbType.NVarChar, 512)

            parPaymentsTextList.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parPaymentsTextList)
            Dim parId As SqlParameter = New SqlParameter("@ProposalId", SqlDbType.Int)

            parId.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            proposalId = parId.Value

            Dim sArr As String()

            If Len("" & parPaymentsScheduleList.Value) > 0 Then
                ' Insertar ScheduleList
                sArr = Split(parPaymentsScheduleList.Value, ",")
                If sArr.Length > 0 Then

                    Dim i As Int16
                    Dim Percent As Double
                    For i = 0 To sArr.Length - 1
                        Try
                            Percent = sArr(i)
                        Catch ex As Exception
                        End Try
                        If Percent > 0 Then
                            UpdateProposalSchedule(proposalId, i + 1, Percent)
                        End If
                        If i > MAXPaymentSchedule - 1 Then Exit For
                    Next
                End If
            End If

            If Len("" & parPaymentsTextList.Value) > 0 Then
                ' Insertar PaymentsTextList
                sArr = Split(parPaymentsTextList.Value, ",")
                If sArr.Length > 0 Then

                    Dim i As Int16
                    For i = 0 To sArr.Length - 1
                        If Len(sArr(i).ToString) > 0 Then
                            UpdatePaymentText(proposalId, i + 1, sArr(i))
                        End If
                        If i > MAXPaymentSchedule - 1 Then Exit For
                    Next
                End If
            End If

            cnn1.Close()

            Return proposalId

            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewProposal, companyId, ProjectName)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function CreateProposalFromRFP(guid As String, employeeId As Integer, companyId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            Dim proposalId As Integer

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "ProposalfromRFP_INSERT"
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@guid", guid)
            cmd.Parameters.AddWithValue("@destination_companyId", companyId)
            cmd.Parameters.AddWithValue("@destination_employeeId", employeeId)


            ' Set up the output parameter 
            Dim parId As SqlParameter = New SqlParameter("@ProposalId", SqlDbType.Int)
            parId.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            ' Comprobar que la companyId es correcta
            Dim destination_companyId As Integer = GetProposalProperty(parId.Value, "companyId")

            If destination_companyId = companyId Then
                proposalId = parId.Value
            Else
                ' Caso de que el user tiene varias Companies y la actual no es la del Proposal
                proposalId = 0
            End If
            cnn1.Close()

            Return proposalId
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function CreateProposal_OLD(ByVal lType As Integer, ByVal sName As String, employeeId As Integer, ByVal companyId As Integer,
                                       Optional ProjectSector As Integer = 0, Optional ProjectUse As String = "", Optional ProjectUse2 As String = "",
                                          Optional DepartmentId As Integer = 0, Optional Retainer As Boolean = True,
                                          Optional ProjectLocation As String = "", Optional Unit As Double = 0, Optional Measure As Integer = 0, Optional ProjectType As String = "", Optional clientId As Integer = 0) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            Dim proposalId As Integer

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "ProposalNew"
            cmd.CommandType = CommandType.StoredProcedure
            Dim taskId As String

            ' Set up the input parameter 
            Dim parType As SqlParameter = New SqlParameter("@Type", SqlDbType.Int)
            parType.Value = lType
            cmd.Parameters.Add(parType)
            Dim parCompanyId As SqlParameter = New SqlParameter("@companyId", SqlDbType.Int)
            parCompanyId.Value = companyId
            cmd.Parameters.Add(parCompanyId)

            ' Set up the output parameter 
            Dim parTaskIdList As SqlParameter = New SqlParameter("@TaskIdList", SqlDbType.NVarChar, 80)
            parTaskIdList.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parTaskIdList)
            Dim parPaymentsScheduleList As SqlParameter = New SqlParameter("@PaymentsScheduleList", SqlDbType.NVarChar, 80)
            parPaymentsScheduleList.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parPaymentsScheduleList)
            Dim parPaymentsTextList As SqlParameter = New SqlParameter("@PaymentsTextList", SqlDbType.NVarChar, 512)

            parPaymentsTextList.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parPaymentsTextList)
            Dim parId As SqlParameter = New SqlParameter("@ProposalId", SqlDbType.Int)

            parId.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            proposalId = parId.Value

            ' Insertar Detalles de Proposal
            ' Proposal name
            Dim SharePublicLinks As Boolean = IsAzureStorage(companyId)
            Dim cmd1 As SqlCommand = cnn1.CreateCommand()
            cmd1.CommandText = "UPDATE [Proposal] SET [ProjectName]='" & sName &
                                    "', EmployeeAprovedId=" & employeeId &
                                    ", ProjectSector=" & ProjectSector &
                                    ", ProjectUse='" & ProjectUse &
                                    "', ProjectUse2='" & ProjectUse2 &
                                    "', DepartmentId=" & DepartmentId &
                                    ",Retainer=" & IIf(Retainer, 1, 0) &
                                    ",SharePublicLinks=" & IIf(SharePublicLinks, 1, 0) &
                                    ",ProjectLocation='" & ProjectLocation & "'" &
                                    ",Unit=" & FormatearNumero2Tsql(Unit) &
                                    ",Measure=" & Measure &
                                    ",ProjectType='" & ProjectType & "'" &
                                    ",ClientId=" & clientId &
                                    " WHERE Id=" & parId.Value
            cmd1.ExecuteNonQuery()

            Dim sArr As String()
            If Len("" & parTaskIdList.Value) > 0 Then
                sArr = Split(Trim(parTaskIdList.Value), ",")
                If sArr.Length > 0 Then

                    Dim i As Int16
                    For i = 0 To sArr.Length - 1
                        If Len(sArr(i).ToString) > 0 Then
                            ' Limpiar caracteres no deseados
                            sArr(i) = Replace(sArr(i), vbLf, "")
                            sArr(i) = Replace(sArr(i), " ", "")
                            taskId = GetTaskIdFromTaskcode(sArr(i), companyId)
                            If Len("" & taskId) > 0 Then
                                NewDetailProposal(proposalId, taskId)
                            End If
                        End If
                    Next
                End If
            End If

            If Len("" & parPaymentsScheduleList.Value) > 0 Then
                ' Insertar ScheduleList
                sArr = Split(parPaymentsScheduleList.Value, ",")
                If sArr.Length > 0 Then

                    Dim i As Int16
                    Dim Percent As Double
                    For i = 0 To sArr.Length - 1
                        Try
                            Percent = sArr(i)
                        Catch ex As Exception
                        End Try
                        If Percent > 0 Then
                            UpdateProposalSchedule(proposalId, i + 1, Percent)
                        End If
                        If i > MAXPaymentSchedule - 1 Then Exit For
                    Next
                End If
            End If

            If Len("" & parPaymentsTextList.Value) > 0 Then
                ' Insertar PaymentsTextList
                sArr = Split(parPaymentsTextList.Value, ",")
                If sArr.Length > 0 Then

                    Dim i As Int16
                    For i = 0 To sArr.Length - 1
                        If Len(sArr(i).ToString) > 0 Then
                            UpdatePaymentText(proposalId, i + 1, sArr(i))
                        End If
                        If i > MAXPaymentSchedule - 1 Then Exit For
                    Next
                End If
            End If

            cnn1.Close()

            Return proposalId

            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewProposal, companyId, sName)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function ModifyProposalType(ProposalId As Integer, ByVal lType As Integer, companyId As Integer) As Integer
        Try

            Dim TextBegin As String = ""
            Dim TextEnd As String = ""
            Dim TaskIdList As String
            Dim PaymentsScheduleList As String
            Dim PaymentsTextList As String
            Dim Agreement As String = ""
            Dim bAbort As Boolean

            ' LEER PARAMETROS DEL TEMPLATE
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT TextBegin, TextEnd, TaskIdList, PaymentsScheduleList, PaymentsTextList, Agreement  FROM [Proposal_types] WHERE [Id]=" & lType, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                TextBegin = rdr("TextBegin").ToString
                TextEnd = rdr("TextEnd").ToString
                TaskIdList = rdr("TaskIdList").ToString
                PaymentsScheduleList = rdr("PaymentsScheduleList").ToString
                PaymentsTextList = rdr("PaymentsTextList").ToString
                Agreement = rdr("Agreement").ToString
            Else
                bAbort = True
            End If
            rdr.Close()

            If Not bAbort Then
                ' Eliminar los Proposal_details
                ExecuteNonQuery("DELETE FROM Proposal_details WHERE ProposalId=" & ProposalId)

                ' Actualizar parametros complejos que incluyen ' (comillas simples)
                Dim cmd2 As SqlCommand = cnn1.CreateCommand()

                cmd2.Parameters.AddWithValue("ProposalId", ProposalId)
                cmd2.Parameters.AddWithValue("Type", lType)
                cmd2.Parameters.AddWithValue("TextBegin", TextBegin)
                cmd2.Parameters.AddWithValue("TextEnd", TextEnd)
                cmd2.Parameters.AddWithValue("Agreement", Agreement)
                cmd2.CommandText = "UPDATE [Proposal] SET [Type]=@Type,[TextBegin]=@TextBegin,[TextEnd]=@TextEnd,[Agreements]=@Agreement WHERE Id=@ProposalId"

                cmd2.ExecuteNonQuery()

                'ExecuteNonQuery("UPDATE [Proposal] SET [Type]=" & lType & ",[TextBegin]='" & TextBegin & "',[TextEnd]='" & TextEnd & "',[Agreement]='" & Agreement & "' WHERE Id=" & ProposalId)

                ' Insertar Detalles de Proposal segun Type
                Dim taskId As String
                Dim sArr As String() = Split(Trim(TaskIdList), ",")
                If sArr.Length > 0 Then

                    Dim i As Int16
                    For i = 0 To sArr.Length - 1
                        If Len(sArr(i).ToString) > 0 Then
                            ' Limpiar caracteres no deseados
                            sArr(i) = Replace(sArr(i), vbLf, "")
                            sArr(i) = Replace(sArr(i), " ", "")
                            taskId = GetTaskIdFromTaskcode(sArr(i), companyId)
                            If Len("" & taskId) > 0 Then
                                NewDetailProposal(ProposalId, taskId)
                            End If
                        End If
                    Next
                End If

                If Len("" & PaymentsScheduleList) > 0 Then
                    ' Insertar ScheduleList
                    sArr = Split(PaymentsScheduleList, ",")
                    If sArr.Length > 0 Then

                        Dim i As Int16
                        For i = 0 To sArr.Length - 1
                            If Len(sArr(i).ToString) > 0 Then
                                UpdateProposalSchedule(ProposalId, i + 1, sArr(i))
                            End If
                            If i > MAXPaymentSchedule - 1 Then Exit For
                        Next
                    End If
                End If

                If Len("" & PaymentsTextList) > 0 Then
                    ' Insertar PaymentsTextList
                    sArr = Split(PaymentsTextList, ",")
                    If sArr.Length > 0 Then

                        Dim i As Int16
                        For i = 0 To sArr.Length - 1
                            If Len(sArr(i).ToString) > 0 Then
                                UpdatePaymentText(ProposalId, i + 1, sArr(i))
                            End If
                            If i > MAXPaymentSchedule - 1 Then Exit For
                        Next
                    End If
                End If
            End If
            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    ' ................................................................................................................................
    ' Funcion: NewProposal
    '          Nuevo registro en la tabla 'Proposal'. Inicializacion segun su tipo 
    ' Retorno: Id del nuevo proposal. 
    ' ................................................................................................................................
    Public Shared Function NewDetailProposal(ByVal ProposalId As Integer, ByVal TaskId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "ProposalNewDetail"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            Dim parProposalId As SqlParameter = New SqlParameter("@ProposalId", SqlDbType.Int)
            parProposalId.Value = ProposalId
            cmd.Parameters.Add(parProposalId)
            Dim parTaskId As SqlParameter = New SqlParameter("@TaskId", SqlDbType.Int)
            parTaskId.Value = TaskId
            cmd.Parameters.Add(parTaskId)


            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            NewDetailProposal = True

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetPhaseTemplateProperty(phaselId As Integer, sProperty As String) As String
        Return GetStringEscalar("SELECT isnull([" & sProperty & "],'') FROM Proposal_phases_template WHERE Id=" & phaselId)
    End Function

    Public Shared Function ProposalPhases_INSERT(ByVal proposalId As Integer, ByVal Order As Integer, ByVal Code As String, Name As String, Description As String, Period As String, ByVal DateFrom As DateTime, DateTo As DateTime, Progress As Double) As Boolean
        Dim cnn1 As SqlConnection = GetConnection()
        Try

            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "PROPOSAL_phases_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@proposalId", proposalId)
            cmd.Parameters.AddWithValue("@Order", Order)
            cmd.Parameters.AddWithValue("@Code", Code)
            cmd.Parameters.AddWithValue("@Name", Name)
            cmd.Parameters.AddWithValue("@Description", Description)
            cmd.Parameters.AddWithValue("@Period", Period)

            If Not (DateFrom = Nothing) Then
                cmd.Parameters.AddWithValue("@DateFrom", DateFrom)
            Else
                cmd.Parameters.AddWithValue("@DateFrom", DBNull.Value)
            End If
            If Not (DateTo = Nothing) Then
                cmd.Parameters.AddWithValue("@DateTo", DateTo)
            Else
                cmd.Parameters.AddWithValue("@DateTo", DBNull.Value)
            End If

            cmd.Parameters.AddWithValue("@Progress", Progress)

            cmd.ExecuteNonQuery()

            Return True

        Catch ex As Exception
            ' Evita tratamiento de error
            Return False
        Finally
            cnn1.Close()
        End Try

    End Function
    Public Shared Function ProposalPhases_UPDATE(ByVal phaseId As Integer, ByVal Order As Integer, ByVal Code As String, Name As String, Description As String, Period As String, ByVal DateFrom As DateTime, DateTo As DateTime, Progress As Double) As Boolean
        Dim cnn1 As SqlConnection = GetConnection()
        Try

            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "PROPOSAL_phases_UPDATE"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@Order", Order)
            cmd.Parameters.AddWithValue("@Code", Code)
            cmd.Parameters.AddWithValue("@Name", Name)
            cmd.Parameters.AddWithValue("@Description", Description)
            cmd.Parameters.AddWithValue("@Period", Period)

            If Not (DateFrom = Nothing) Then
                cmd.Parameters.AddWithValue("@DateFrom", DateFrom)
            Else
                cmd.Parameters.AddWithValue("@DateFrom", DBNull.Value)
            End If
            If Not (DateTo = Nothing) Then
                cmd.Parameters.AddWithValue("@DateTo", DateTo)
            Else
                cmd.Parameters.AddWithValue("@DateTo", DBNull.Value)
            End If
            cmd.Parameters.AddWithValue("@Progress", Progress)

            cmd.Parameters.AddWithValue("@Id", phaseId)

            cmd.ExecuteNonQuery()

            Return True

        Catch ex As Exception
            ' Evita tratamiento de error
            Return False
        Finally
            cnn1.Close()
        End Try

    End Function

    Public Shared Function GetProposalTypename(ByVal lId As Long) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("Select Proposal_types.Name As TypeName FROM Proposal LEFT OUTER JOIN Proposal_types On Proposal.Type = Proposal_types.Id WHERE Proposal.Id=" & lId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetProposalTypename = "" & rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetProposalData
    '          Leer datos del Proposal 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetProposalData(ByVal lId As Long,
                                        ByRef sProperty As String) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("Select ISNULL(" & sProperty & ",'') " &
                                        "FROM Proposal LEFT OUTER JOIN Clients ON Proposal.ClientId = Clients.Id LEFT OUTER JOIN Jobs_types ON Proposal.ProjectType = Jobs_types.Id " &
                                        "WHERE [Proposal].[Id]=" & lId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetProposalData = "" & rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Return ""
        End Try
    End Function

    Public Shared Function GetProposalProperty(proposalId As Integer, sProperty As String) As String
        Select Case sProperty
            Case "EmployeeName"
                Return GetStringEscalar("SELECT FullName FROM Employees WHERE Id=(select top 1 EmployeeAprovedId from Proposal where Id=" & proposalId & ") ")

            Case "ClientId", "Type", "EmployeeAprovedId", "JobId", "StatusId", "Unit", "ProjectSector", "ProjectEntity", "ProjectConstructionType", "ProjectConstructionSubType", "DepartmentId", "Measure", "Workdays", "ProjectManagerId", "companyId",
                 "PaymentSchedule1", "PaymentSchedule2", "PaymentSchedule3", "PaymentSchedule4", "PaymentSchedule5", "PaymentSchedule6", "PaymentSchedule7", "PaymentSchedule8", "PaymentSchedule9", "PaymentSchedule1o", "paymentscheduleId"

                ' Valores Integer
                Return GetNumericEscalar("SELECT TOP 1 isnull([" & sProperty & "],0) FROM Proposal where Id=" & proposalId)
            Case Else
                Return GetStringEscalar("SELECT TOP 1 [" & sProperty & "] FROM Proposal where Id=" & proposalId)
        End Select
    End Function
    Public Shared Function GetProposalDateTime(proposalId As Integer, sProperty As String) As DateTime
        Return GetDateTimeEscalar("SELECT TOP 1 [" & sProperty & "] FROM Proposal where Id=" & proposalId)
    End Function

    Public Shared Function GetMyProposalPending(UserEmail As String) As Integer
        Return GetNumericEscalar("SELECT COUNT(*) AS Expr1 FROM Proposal INNER JOIN Clients ON Proposal.ClientId = Clients.Id WHERE Proposal.StatusId=1 and Clients.Email='" & UserEmail & "'")
    End Function

    Public Shared Function InvoiceNumber(ByVal Id As Integer) As String
        Return GetStringEscalar("SELECT dbo.InvoiceNumber(" & Id & ")")
    End Function

    Public Shared Function GetInvoiceProperty(ByVal lId As Long, ByRef sProperty As String) As String

        Try
            Select Case sProperty
                Case "guid"
                    Return GetStringEscalar("SELECT [" & sProperty & "] FROM Invoices WHERE [Id]=" & lId)

                Case "InvoiceNumber", "Invoice Number"
                    Return InvoiceNumber(lId)

                Case "JobId", "Emitted", "InvoiceType", "Time", "Rate", "employeeTimeId", "statementId", "Amount", "AmountDue", "qbInvoiceId", "EmissionRecurrenceDays"
                    Return GetNumericEscalar("SELECT ISNULL(" & sProperty & ",0) FROM Invoices WHERE [Id]=" & lId)

                Case Else
                    Return GetStringEscalar("SELECT ISNULL(" & sProperty & ",'') FROM Jobs RIGHT OUTER JOIN Invoices ON Jobs.Id = Invoices.JobId LEFT OUTER JOIN Clients ON Jobs.Client = Clients.Id WHERE [Invoices].[Id]=" & lId)
            End Select
        Catch ex As Exception
            Return ""
        End Try

    End Function

    Public Shared Function GetInvoicePaymentsProperty(ByVal lId As Long, ByRef sProperty As String) As String

        Try
            Select Case sProperty
                Case "InvoiceId", "Method", "Amount", "qbpaymentId"
                    Return GetNumericEscalar("Select ISNULL(" & sProperty & ", 0) FROM Invoices_payments WHERE [Id]=" & lId)

                Case Else
                    Return GetStringEscalar("Select ISNULL(" & sProperty & ",'') FROM Invoices_payments WHERE [Id]=" & lId)
            End Select
        Catch ex As Exception
            Return ""
        End Try


    End Function

    ' ................................................................................................................................
    ' Funcion: GetProposalTotal
    '          Leer datos del Proposal 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetProposalTotal(ByVal propsalId As Integer) As Double
        Try
            Return GetNumericEscalar($"SELECT dbo.ProposalTotal({propsalId})")
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function GetProposalPSTotal(ByVal propsalId As Integer) As Double
        Try
            Return GetNumericEscalar($"SELECT dbo.ProposalPSTotal({propsalId})")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetProposalTotal
    '          Leer datos del Proposal 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function GetProposalTotal(ByVal nYear As Int16, ByVal nMes As Int16, ByVal nStatusId As ProposalStatus_ENUM, ByVal lClientId As Integer, ByVal companyId As Integer) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim sWhere As String = "WHERE companyId=" & companyId & " AND YEAR(Proposal.Date)=" & nYear
            If nMes > 0 Then sWhere = sWhere & " AND Month(Proposal.Date)=" & nMes
            If nStatusId >= 0 Then sWhere = sWhere & " AND ISNULL(Left([StatusId],1),0)=" & nStatusId
            If lClientId > 0 Then sWhere = sWhere & " AND ISNULL([ClientId],0)=" & lClientId

            Dim cmd As New SqlCommand("SELECT ISNULL(SUM(TotalRow),0) AS Expr1 FROM Proposal INNER JOIN Proposal_details ON Proposal.Id = Proposal_details.ProposalId " & sWhere, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetProposalTotal = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: GetProposalTotal
    '          Leer datos del Proposal 
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function MonthlyPayments(ByVal lJobId As Long, ByVal nYear As Integer, ByVal nMes As Integer) As String
        Try
            Dim sWhere As String = "WHERE [JobId]=" & lJobId.ToString
            If nYear > 1900 Then sWhere = sWhere & " AND Year(CollectedDate)=" & nYear
            If nMes > 0 Then sWhere = sWhere & " AND Month(CollectedDate)=" & nMes
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT ISNULL(SUM([Amount]),0) AS Expr1 FROM [Invoices] " & sWhere, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                MonthlyPayments = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: UpdateTimeToPropsal
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function UpdateTimeToPropsal(ByVal lTaskId As Integer, ByVal nTime As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            Dim sTime As String = FormatearNumero2Tsql(nTime.ToString)

            ' 1. Incrementar Hours en el detalle del Proposal
            cmd.CommandText = "UPDATE [Proposal_details] SET [Hours]=[Hours]+" & nTime & " WHERE [Id]=" & lTaskId.ToString
            cmd.ExecuteNonQuery()

            ' 2.- Obtener el Id del Proposal
            Dim lProposalId As Long
            cmd.CommandText = "SELECT [ProposalId] FROM [Proposal_details] WHERE [Id]=" & lTaskId.ToString
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                lProposalId = rdr(0).ToString
            End If
            rdr.Close()

            ' 3.- Obtener el nuevo Total del Proposal
            Dim dProposalTotal As Double = GetProposalTotal(lProposalId)

            ' 4.- Obtener el Job asociado
            Dim lJobId As String = GetProposalData(lProposalId, "JobId")

            ' 5.- Actualizar el Budget del Job
            If Val(lJobId) > 0 Then
                cmd.CommandText = $"UPDATE [Jobs] SET [Budget]={dProposalTotal} WHERE Id={lJobId}"
                cmd.ExecuteNonQuery()
            End If

            cnn1.Close()
            UpdateTimeToPropsal = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function GetProposalServicesTaskCount(ByVal lJobId As Long) As Long
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Count(*) FROM Proposal_tasks INNER JOIN Proposal INNER JOIN Jobs ON Proposal.JobId = Jobs.Id INNER JOIN Proposal_details ON Proposal.Id = Proposal_details.ProposalId ON Proposal_tasks.Id = Proposal_details.TaskId WHERE isnull(Proposal_tasks.HourRatesService,0) = 1 AND Jobs.[Id]=" & lJobId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetProposalServicesTaskCount = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetCategoryCount(ByVal companyId As Integer) As Long
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Count(*) FROM [Employees_time_categories] WHERE companyId=" & companyId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetCategoryCount = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetProposalNonServicesTaskCount(ByVal lJobId As Long) As Long
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Count(*) FROM Proposal_tasks INNER JOIN Proposal INNER JOIN Jobs ON Proposal.JobId = Jobs.Id INNER JOIN Proposal_details ON Proposal.Id = Proposal_details.ProposalId ON Proposal_tasks.Id = Proposal_details.TaskId WHERE isnull(Proposal_tasks.HourRatesService,0) = 0 AND Jobs.[Id]=" & lJobId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetProposalNonServicesTaskCount = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetProposalTaskRate(ByVal lTaskId As Integer) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT ISNULL(Rates,0) FROM Proposal_details WHERE Id=" & lTaskId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetProposalTaskRate = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: UpdateProposalSchedule
    '          Actualiza un ProposalSchedule 
    ' Retorno: Boolean. 
    ' ................................................................................................................................
    Public Shared Function UpdateProposalSchedule(ByVal ProposalId As Integer, ByVal ScheduleIndex As String, ByVal ScheduleValue As Double) As Boolean
        Try
            If ScheduleIndex >= 1 And ScheduleIndex <= MAXPaymentSchedule() Then
                Dim cnn1 As SqlConnection = GetConnection()
                Dim cmd As SqlCommand = cnn1.CreateCommand()

                ' ClienteEmail
                cmd.CommandText = "UPDATE [Proposal] SET [PaymentSchedule" & ScheduleIndex & "]=" & ScheduleValue &
                                                    " WHERE Id=" & ProposalId.ToString

                cmd.ExecuteNonQuery()
                cnn1.Close()
                UpdateProposalSchedule = True
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: UpdateProposalPath
    '          Actualiza el Path 
    ' Retorno: Boolean. 
    ' ................................................................................................................................
    Public Shared Function UpdateProposalPath(ByVal ProposalId As Integer, ByVal sPath As String) As String
        Try
            Dim sFinalPath As String = ValidPath(sPath)
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Path
            cmd.CommandText = "UPDATE [Proposal] SET [Path]='" & sFinalPath &
                                                "' WHERE Id=" & ProposalId.ToString

            cmd.ExecuteNonQuery()
            cnn1.Close()
            UpdateProposalPath = sFinalPath
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: UpdatePaymentText
    '          Actualiza un UpdatePaymentText 
    ' Retorno: Boolean. 
    ' ................................................................................................................................
    Public Shared Function UpdatePaymentText(ByVal ProposalId As Integer, ByVal ScheduleIndex As String, ByVal PaymentTextValue As String) As Boolean
        Try
            If ScheduleIndex >= 1 And ScheduleIndex <= MAXPaymentSchedule Then
                Dim cnn1 As SqlConnection = GetConnection()
                Dim cmd As SqlCommand = cnn1.CreateCommand()

                ' ClienteEmail
                cmd.CommandText = "UPDATE [Proposal] SET [PaymentText" & ScheduleIndex & "]='" & PaymentTextValue &
                                                    "' WHERE Id=" & ProposalId.ToString

                cmd.ExecuteNonQuery()
                cnn1.Close()
                UpdatePaymentText = True
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: AddAllClientsToUsers
    '          Inicializa los usuarios desde los clients con Email
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function AddAllClientsToUsers_ant() As Long
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT * FROM [Clients] WHERE len([Email])>5", cnn1)
            Dim rdr As SqlDataReader
            Dim username(0) As String
            Dim User As MembershipUser
            rdr = cmd.ExecuteReader
            Dim Status As MembershipCreateStatus
            Dim sUserName As String
            Dim sRole As String = "Clientes"
            Dim lPos As Integer
            While rdr.Read()
                If rdr.HasRows Then
                    lPos = InStr(rdr("Email"), "@")
                    If lPos > 1 Then
                        'sUserName = Left(rdr("Email").ToString, lPos - 1)
                        sUserName = rdr("Email").ToString
                        If (Membership.FindUsersByName(sUserName).Count = 0) Then

                            User = Membership.CreateUser(sUserName, rdr("Id").ToString, rdr("Email").ToString, "a", "b", True, Status)
                            ' A�adir el usuario a su Role
                            username(0) = sUserName

                            ' Definir el Role

                            'Roles.AddUsersToRole(username, sRole)
                            AddAllClientsToUsers_ant = AddAllClientsToUsers_ant + 1
                        End If
                    End If
                End If
            End While
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function AddEmployeeToUser(ByVal sEmail As String, ByVal companyId As Integer) As Boolean
        Try
            RefrescarUsuarioVinculadoAsync(sEmail, "Empleados")

        Catch ex As Exception

        End Try
    End Function


    Public Shared Function GetInitialClientPassword(ByVal lClient As Long) As String
        Dim l1 As Long = 901003 + lClient
        GetInitialClientPassword = "@" & l1.ToString
    End Function

    ' ................................................................................................................................
    ' Funcion: EmployeeEmailCredentials
    '          Envia mails a todos
    ' Retorno: True si tuvo exito. 
    '          False en caso contrario 
    ' ................................................................................................................................
    Public Shared Function EmployeeEmailCredentials(ByVal EmployeeId As Integer, ByVal companyId As Integer) As Boolean
        Try

            Dim sName = ""
            Dim sAddress = ""
            Dim sCity = ""
            Dim sState = ""
            Dim sZipcode = ""
            Dim sPhone = ""
            Dim sCellular = ""
            Dim sEmail = ""
            Dim sHourRate = ""
            Dim startingDate = ""
            Dim sSS = ""
            Dim sDOB = ""
            Dim bInactive As Short
            Dim userGuid = ""
            Dim data = GetEmployeeData(EmployeeId, sName, sAddress, sCity, sState, sZipcode, sPhone, sCellular, sEmail, sHourRate, startingDate, sSS, sDOB, bInactive, userGuid)

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT * FROM Employees WHERE Id=" & EmployeeId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            Dim lPos As Integer
            rdr.Read()
            If rdr.HasRows Then
                lPos = InStr(rdr("Email"), "@")
                If lPos > 1 Then
                    Dim sFullBody As New System.Text.StringBuilder
                    sFullBody.Append("Mr./Mrs. " & rdr("Name") & ":")

                    sFullBody.Append("<br />")
                    sFullBody.Append("<br />")
                    sFullBody.Append("Welcome to PASconcept!")
                    sFullBody.Append("<br />")
                    sFullBody.Append("It is with great pride and excitement that we take this time to personally welcome you to PASconcept. Please use the following links to set-up your password.")
                    sFullBody.Append("<br />")
                    sFullBody.Append("<a href=" & """" & GetHostAppSite() & "/Account/ResetPasswordConfirmation.aspx?guid=" & userGuid & """> Set-Up Password Here</a>")
                    sFullBody.Append("<br />")
                    sFullBody.Append("<br />")


                    sFullBody.Append("We strive to provide you with the necessary support and resource materials to begin utilizing the your new  platform. Should you experience any issues or have any questions, we are here to help!")
                    sFullBody.Append("<br />")
                    sFullBody.Append("<br />")
                    sFullBody.Append("Best Regards,")
                    'sFullBody.Append("<a href=" & """" & GetHostAppSite() & "/default.aspx" & """" & ">Link to Employee Site</a>")
                    sFullBody.Append("<br />")
                    sFullBody.Append("PasConcept Technical Support")

                    Try
                        SendGrid.Email.SendMail(rdr("Email").ToString, "", "", ConfigurationManager.AppSettings("Titulo") & ". Credentials", sFullBody.ToString, companyId, 0, 0)
                        EmployeeEmailCredentials = True
                    Finally
                    End Try

                End If
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Async Function EmployeeEmailResetPassword(Email As String) As Task(Of Boolean)
        Try
            Dim identityUser As pasconcept20.ApplicationUser = Await AppUserManager.FindByEmailAsync(Email)
            If identityUser IsNot Nothing Then
                Dim companyId = GetActiveCompanyIdFromEmployee(Email)
                Dim employeeId = GetEmployeeId(Email, companyId)

                Dim sName = ""
                Dim sAddress = ""
                Dim sCity = ""
                Dim sState = ""
                Dim sZipcode = ""
                Dim sPhone = ""
                Dim sCellular = ""
                Dim sEmail = ""
                Dim sHourRate = ""
                Dim startingDate = ""
                Dim sSS = ""
                Dim sDOB = ""
                Dim bInactive As Short
                Dim userGuid = ""


                Dim data = GetEmployeeData(employeeId, sName, sAddress, sCity, sState, sZipcode, sPhone, sCellular, sEmail, sHourRate, startingDate, sSS, sDOB, bInactive, userGuid)

                Dim sFullBody As New System.Text.StringBuilder

                sFullBody.Append("Hello:")
                sFullBody.Append("<br />")
                sFullBody.Append("<br />")
                sFullBody.Append("Someone recently requested a password change for your PASconcept account.")
                sFullBody.Append("<br />")
                sFullBody.Append("If this was you, you can set a new password")
                sFullBody.Append("<a href=" & """" & GetHostAppSite() & "/Account/ResetPasswordConfirmation.aspx?guid=" & userGuid & """> here</a>")
                sFullBody.Append("<br />")
                sFullBody.Append("<br />")
                sFullBody.Append("If you don't want to change your password or didn't request this, just ")
                sFullBody.Append("<br />")
                sFullBody.Append("ignore and delete this message.")
                sFullBody.Append("<br />")
                sFullBody.Append("<br />")
                sFullBody.Append("To keep your account secure, please don't forward this email to anyone.")
                sFullBody.Append("<br />")
                sFullBody.Append("<br />")
                sFullBody.Append("If you have any questions or require additional information, please ")
                sFullBody.Append("<a href=" & """" & "http://pasconcept.com/contact.html" & """" & ">contact us</a>")
                sFullBody.Append("<br />")
                sFullBody.Append("<br />")
                sFullBody.Append("Thank you,")
                sFullBody.Append("<br />")
                sFullBody.Append("<br />")
                sFullBody.Append("<a href=" & """" & GetHostAppSite() & """" & ">PASconcept</a> Notification")
                sFullBody.Append("<br />")

                Dim sbody = sFullBody.ToString()

                Try
                    If ConfigurationManager.AppSettings("Debug") = "1" Then
                        SendGrid.Email.SendMail("jcarlos@axzes.com", "fernando@easterneg.com", "", ConfigurationManager.AppSettings("Titulo") & ". Credentials", sFullBody.ToString, companyId, 0, 0)
                    Else
                        SendGrid.Email.SendMail(Email, "", "", ConfigurationManager.AppSettings("Titulo") & ". Reset Password", sFullBody.ToString, companyId, 0, 0)
                    End If
                    Return True
                Finally
                End Try
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return False
    End Function

    Public Shared Function EmployeeEmailMemory(ByVal EmployeeId As Integer, ByVal companyId As Integer, year As Integer) As Boolean
        Try
            'Response.Redirect("~/EMP/memory.aspx?companyId=" & lblCompanyId.Text & "&year=" & cboYear.SelectedValue & "&employeeId=" & cboEmployees.SelectedValue )

            Dim EmployeeName As String = GetEmployeeName(EmployeeId)
            Dim EmployeeEmail As String = GetEmployeeEmail(EmployeeId)
            Dim CompanyName As String = GetCompanyProperty(companyId, "Name")

            Dim sFullBody As New System.Text.StringBuilder
            sFullBody.Append("Dear " & EmployeeName & ",")

            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("<a href=" & """" & GetHostAppSite() & "/adm/memory.aspx?companyId=" & companyId & "&year=" & year & "&employeeId=" & EmployeeId & """" & ">Click here </a>")
            sFullBody.Append(" to view the summary page of your job as employee of " & CompanyName & " in " & year)
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("Best regards,")
            sFullBody.Append("<br />")
            sFullBody.Append("<strong>" & GetCompanyProperty(companyId, "EmailSign") & "</strong>")
            sFullBody.Append("<br />")
            sFullBody.Append(GetCompanyProperty(companyId, "EmailSign2"))

            If ConfigurationManager.AppSettings("Debug") = "1" Then
                SendGrid.Email.SendMail("jcarlos@axzes.com", "", "", CompanyName & ". Employee Memory " & year, sFullBody.ToString, companyId, 0, 0)
            Else
                SendGrid.Email.SendMail(EmployeeEmail, "", "", CompanyName & ". Employee Memory " & year, sFullBody.ToString, companyId, 0, 0)
            End If
            Return True



        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function ForgotPasswordEmail_old(ByVal sUserEmail As String, sGUID As String) As Boolean
        Try
            Dim user As MembershipUser = Membership.GetUser(Membership.GetUserNameByEmail(sUserEmail))
            Dim sPassword As String = user.GetPassword()
            Dim sFullBody As New System.Text.StringBuilder
            sFullBody.Append("Hello:")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("Someone recently requested a password change for your PASconcept account.")
            sFullBody.Append("<br />")
            sFullBody.Append("If this was you, you can set a new password")
            sFullBody.Append("<a href=" & """" & GetHostAppSite() & "/forgot.aspx?forgot_key=" & sGUID & """" & "> here</a>")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("If you don't want to change your password or didn't request this, just ")
            sFullBody.Append("<br />")
            sFullBody.Append("ignore and delete this message.")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("To keep your account secure, please don't forward this email to anyone.")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("If you have any questions or require additional information, please ")
            sFullBody.Append("<a href=" & """" & "http://pasconcept.com/contact.html" & """" & ">contact us</a>")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("Thank you,")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("<a href=" & """" & GetHostAppSite() & """" & ">PASconcept</a> Notification")
            sFullBody.Append("<br />")
            sFullBody.Append(LocalAPI.GetPASSign())

            Try
                If ConfigurationManager.AppSettings("Debug") = "1" Then
                    SendGrid.Email.SendMail("jcarlos@axzes.com", "fernando@easterneg.com", "", ConfigurationManager.AppSettings("Titulo") & " Login Information", sFullBody.ToString, -1, 0, 0, ConfigurationManager.AppSettings("FromPASconceptEmail"), "PASconcept")
                Else
                    SendGrid.Email.SendMail(sUserEmail, "", "", ConfigurationManager.AppSettings("Titulo") & " Login Information", sFullBody.ToString, -1, 0, 0, ConfigurationManager.AppSettings("FromPASconceptEmail"), "PASconcept")
                End If
                Return True
            Finally
            End Try

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function AdminTestEmail(ByVal sUserEmail As String, ByVal companyId As Integer) As Boolean
        Try
            Dim sFullBody As New System.Text.StringBuilder
            Dim companyName As String = GetCompanyProperty(companyId, "Name")
            sFullBody.Append("This is a test Email sent from Company Profile 'Email Outgoing Settings'.")
            sFullBody.Append("<br />")
            sFullBody.Append("Company Name: " & companyName)
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("Thank you,")
            sFullBody.Append("<br />")
            sFullBody.Append("<a href=" & """" & GetHostAppSite() & """" & ">PASconcept</a> Notification")

            Try
                If ConfigurationManager.AppSettings("Debug") = "1" Then
                    SendGrid.Email.SendMail("jcarlos@axzes.com", "", "", "PASconcept Email Notification Setup", sFullBody.ToString, companyId, 0, 0)
                Else
                    SendGrid.Email.SendMail(sUserEmail, "", "", ConfigurationManager.AppSettings("Titulo") & ". PASconcept test Email ", sFullBody.ToString, companyId, 0, 0)
                End If

                OneSignalNotification.SendNotification(sUserEmail, "Test Notification", "This is a test Notification sent from Company Profile", "", companyId)

                AdminTestEmail = True
            Finally
            End Try

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function PASconceptGetStartedEmail(companyId As Integer) As Boolean
        Try
            Dim CompanyObject = LocalAPI.GetRecord(companyId, "CompanyAccount_SELECT")

            Dim sMsg As New System.Text.StringBuilder
            sMsg.Append("Hi " & CompanyObject("Contact") & ",")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Thank you again for creating an account in PASconcept. We would like to know if you have been successful in getting started with your company.")
            sMsg.Append("<br />")
            sMsg.Append("Currently many companies successfully run their business with PASconcept, from customer management to online payment confirmation, but some may need a little help getting started.")
            sMsg.Append("<br />")
            sMsg.Append("If you need our help to get started, you can contact me directly, I will be happy to help.")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Best regards,")
            sMsg.Append("<br />")
            sMsg.Append("Matt Mur")
            sMsg.Append("<br />")
            sMsg.Append("Customer Service Manager")
            sMsg.Append("<br />")
            sMsg.Append("matt@axzes.com")
            sMsg.Append("<br />")
            sMsg.Append("+1 (786) 626-1611")

            SendGrid.Email.SendMail(CompanyObject("Email"), "", "jcarlos@axzes.com,matt@axzes.com", CompanyObject("Contact") & ". Help to Get Started with PASconcept", sMsg.ToString, -1, 0, 0, "matt@axzes.com", "Matt Mur", "matt@axzes.com", "Matt Mur")
            Return True
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function AdminNotificationTest(ByVal sUserEmail As String, ByVal companyId As Integer) As Boolean
        Try
            OneSignalNotification.SendNotification(sUserEmail, "Test Notification", "This Is a test Notification sent From PASconcept", "", companyId)
            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' If CopyDirectory("D:\somePath", "C:\someOtherPath") Then
    Public Shared Function CopyDirectory(ByVal Src As String, ByVal Dest As String) As Boolean
        Try

            If Directory.Exists(Src) Then
                'add Directory Seperator Character (\) for the string concatenation shown later
                If Dest.Substring(Dest.Length - 1, 1) <> Path.DirectorySeparatorChar Then
                    Dest += Path.DirectorySeparatorChar
                End If
                If Not Directory.Exists(Dest) Then
                    Directory.CreateDirectory(Dest)
                End If

                Dim Files As String()
                Files = Directory.GetFileSystemEntries(Src)
                Dim element As String
                For Each element In Files
                    If Directory.Exists(element) Then
                        'if the current FileSystemEntry is a directory,
                        'call this function recursively
                        CopyDirectory(element, Dest & Path.GetFileName(element))
                    Else
                        'the current FileSystemEntry is a file so just copy it
                        File.Copy(element, Dest & Path.GetFileName(element), True)
                    End If
                Next
                CopyDirectory = True
            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Function


    Private Shared Function ValidPath(ByVal sOriginalPath As String) As String
        Dim sResultPath As String
        '    any string containing the colon character (":") is not valid 
        'any string containing the slash character ("/") is not valid 
        'any string containing the backslash character ("\") is not valid 
        'any string starting or ending with a whitespace character is not valid 
        sResultPath = Trim(sOriginalPath)
        sResultPath = Replace(sResultPath, ":", "")
        sResultPath = Replace(sResultPath, "/", "")
        sResultPath = Replace(sResultPath, "\", "")
        sResultPath = Replace(sResultPath, " ", "_")
        ValidPath = sResultPath
    End Function

    ' ................................................................................................................................
    ' Funcion: UpdateMessageReaded
    '          Actualiza un UpdatePaymentText 
    ' Retorno: Boolean. 
    ' ................................................................................................................................
    Public Shared Function UpdateMessageReaded(ByVal Id As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            cmd.CommandText = "UPDATE Messages_Addressees SET Readed=1 WHERE Id=" & Id.ToString

            cmd.ExecuteNonQuery()
            cnn1.Close()
            UpdateMessageReaded = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Shared Function SuprimeCaracteresNoValidos(ByVal sString As String) As String
        SuprimeCaracteresNoValidos = Replace(sString, "'", "�")
    End Function

    ' ................................................................................................................................
    ' Funcion: SendMessage
    '          Envia un mensaje local 
    ' Retorno: Boolean. 
    ' ................................................................................................................................
    Public Shared Function SendMessage(ByVal sFromEmail As String, ByVal sToEmailArray As String, ByVal sSubject As String, ByVal sBody As String, ByVal sLink As String, ByVal bImportant As Boolean, ByVal companyId As Integer, clientId As Integer, jobId As Integer) As Boolean
        Dim cnn1 As SqlConnection = GetConnection()
        Try

            Dim cmd As SqlCommand = cnn1.CreateCommand()
            Dim idMessage As Integer = GetLastMessageId(cnn1, sFromEmail)

            Select Case sToEmailArray
                Case "(Add all employees...)"
                    SendMessagesAddresseesAllEmployees(cnn1, idMessage, companyId)
                Case "(Add all clients...)"
                    SendMessagesAddresseesAllClients(cnn1, idMessage, companyId)
                Case Else
                    Dim sArr As String() = Split(sToEmailArray, ";")
                    If sArr.Length > 0 Then
                        Dim i As Int16
                        For i = 0 To sArr.Length - 1
                            If Len(sArr(i).ToString) > 0 Then
                                idMessage = Message_INSERT(sFromEmail, sArr(i).ToString, SuprimeCaracteresNoValidos(sSubject), SuprimeCaracteresNoValidos(sBody), sLink, bImportant, companyId, clientId, jobId)
                                'cmd.CommandText = "INSERT INTO [Messages] ([From], CC, Subject, Received, Body, Link, Important) " &
                                '                                        "VALUES ('" & sFromEmail & "','" &
                                '                                            sArr(i).ToString & "','" &
                                '                                            SuprimeCaracteresNoValidos(sSubject) & "'," &
                                '                                            GetFecha_Hora(DateAdd(DateInterval.Hour, -4, LocalAPI.GetDateTime())) & ",'" &
                                '                                            SuprimeCaracteresNoValidos(sBody) & "','" &
                                '                                            SuprimeCaracteresNoValidos(sLink) & "'," &
                                '                                            IIf(bImportant, 1, 0) & ")"

                                'cmd.ExecuteNonQuery()
                                'idMessage = GetLastMessageId(cnn1, sFromEmail)
                                If idMessage > 0 Then
                                    SendMessagesAddressees(cnn1, idMessage, sArr(i))
                                End If

                            End If
                        Next
                    End If
            End Select


            SendMessage = True
        Catch ex As Exception
            ' Ignorar este error
        Finally
            cnn1.Close()
        End Try
    End Function
    Public Shared Function Message_INSERT(ByVal FromEmail As String, ByVal CC As String, ByVal Subject As String, Body As String, Link As String, Important As Boolean, ByVal companyId As Integer, clientId As Integer, jobId As Integer) As Integer
        Dim cnn1 As SqlConnection = GetConnection()
        Try

            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "Message_INSERT_v20"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@FromEmail", FromEmail)
            cmd.Parameters.AddWithValue("@CC", CC)
            cmd.Parameters.AddWithValue("@Subject", Subject)
            cmd.Parameters.AddWithValue("@Body", Body)
            cmd.Parameters.AddWithValue("@Link", Link)
            cmd.Parameters.AddWithValue("@Important", IIf(Important, 1, 0))
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@ClientId", clientId)
            cmd.Parameters.AddWithValue("@JobId", jobId)

            ' Execute the stored procedure.
            Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            Return parOUT_ID.Value

        Catch ex As Exception
            ' Evita tratamiento de error
            Return 0
        Finally
            cnn1.Close()
        End Try

    End Function
    ' ................................................................................................................................
    ' Funcion: SendMessagesAddressees
    '          Actualiza un UpdatePaymentText 
    ' Retorno: Boolean. 
    ' ................................................................................................................................
    Private Shared Function SendMessagesAddressees(ByVal cnn1 As SqlConnection, ByVal lIdMessage As Integer, ByVal sTo As String) As Boolean
        Try
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            cmd.CommandText = "INSERT INTO [Messages_Addressees] (IdMessage, [To], Readed, Notification) " &
                                                    "VALUES (" & lIdMessage & ",'" &
                                                        sTo & "', 0, 0)"

            cmd.ExecuteNonQuery()
            SendMessagesAddressees = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: SendMessagesAddresseesAllEmployees
    '          Actualiza un UpdatePaymentText 
    ' Retorno: Boolean. 
    ' ................................................................................................................................
    Private Shared Function SendMessagesAddresseesAllEmployees(ByVal cnn1 As SqlConnection, ByVal lIdMessage As Integer, ByVal companyId As Integer) As Boolean
        Try
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            cmd.CommandText = "INSERT INTO [Messages_Addressees] ([IdMessage],[To],[Readed], Notification)" &
                                "SELECT " & lIdMessage & " AS IdMessage, Email, 0 AS Readed, 0 as Notification FROM Employees WHERE companyId=" & companyId
            cmd.ExecuteNonQuery()
            SendMessagesAddresseesAllEmployees = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' ................................................................................................................................
    ' Funcion: SendMessagesAddresseesAllClients
    '          Actualiza un UpdatePaymentText 
    ' Retorno: Boolean. 
    ' ................................................................................................................................
    Private Shared Function SendMessagesAddresseesAllClients(ByVal cnn1 As SqlConnection, ByVal lIdMessage As Integer, ByVal companyId As Integer) As Boolean
        Try
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            cmd.CommandText = "INSERT INTO [Messages_Addressees] ([IdMessage],[To],[Readed], Notification)" &
                                "SELECT " & lIdMessage & " AS IdMessage, Email, 0 AS Readed, 0 as Notification FROM Clients WHERE companyId=" & companyId
            cmd.ExecuteNonQuery()
            SendMessagesAddresseesAllClients = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Shared Function GetLastMessageId(ByVal cnn1 As SqlConnection, ByVal sFromEmail As String) As Integer
        Try
            Dim cmd As SqlCommand
            cmd = New SqlCommand("SELECT TOP (1) Id FROM Messages WHERE [From]='" & sFromEmail & "' ORDER BY Id DESC", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetLastMessageId = rdr(0)
            End If
            rdr.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetMessageSubconsultantNoReadedCOUNT(ByVal sEmail As String) As Integer

        Return GetNumericEscalar("SELECT Count(*) FROM RPX_MessaggesBox WHERE ([To]='" & sEmail & "') AND (Role = 'Subconsultans')")

    End Function

    Public Shared Function GetMessageNoReadedCOUNT(ByVal sEmail As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT COUNT(*) FROM Messages_Addressees WHERE ([To] = '" & sEmail & "') AND Readed<>0", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetMessageNoReadedCOUNT = rdr(0)
            Else
                GetMessageNoReadedCOUNT = 0
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try

    End Function


    Public Shared Function GetMessageAddrProperty(ByVal lMsgAdrId As Integer, ByRef sFromOUTPUT As String, ByRef sSubjectOUTPUT As String) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Messages.[From], Messages.Subject FROM Messages RIGHT OUTER JOIN Messages_Addressees ON Messages.Id = Messages_Addressees.IdMessage WHERE Messages_Addressees.Id=" & lMsgAdrId.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                sFromOUTPUT = rdr(0).ToString
                sSubjectOUTPUT = rdr(1).ToString
                GetMessageAddrProperty = True
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetOnlineUsersSQL() As String
        GetOnlineUsersSQL = "SELECT aspnet_Users.UserName, RPX_Users.Email, RPX_Users.RoleName FROM aspnet_Users INNER JOIN RPX_Users ON aspnet_Users.UserName = RPX_Users.UserName WHERE (aspnet_Users.IsAnonymous = 0) AND (aspnet_Users.LastActivityDate > DATEADD(minute, - 5, " & GetDateUTHlocal() & ")) AND (RPX_Users.RoleName = N'Empleados')"
    End Function


    Public Shared Function GetNonRegularHoursTypesByweekly(ByVal nEmployee As Integer, ByVal sFechaDesde As String, ByVal sFechaHasta As String, ByVal NonRegularHoursTypeIndex As Int16, companyId As Integer) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Name FROM  Employees_NonRegularHours INNER JOIN NonRegularHours_types ON Employees_NonRegularHours.Type = NonRegularHours_types.Id " &
                                        "WHERE NonRegularHours_types.companyId=" & companyId &
                                                " And EmployeeId = " & nEmployee.ToString &
                                                " And DateFrom >= " & GetFecha_102(sFechaDesde) &
                                                " And DateTo <= " & GetFecha_102(sFechaHasta) &
                                        " GROUP BY Name", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            Dim i As Integer
            Do While rdr.Read()
                If rdr.HasRows Then
                    If i = NonRegularHoursTypeIndex Then
                        GetNonRegularHoursTypesByweekly = "" & rdr(0).ToString()
                        Exit Do
                    End If
                    i = i + 1
                End If
            Loop
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetNonRegularTypesFromName(ByVal companyId As Long, ByVal sName As String) As Integer
        Return GetNumericEscalar($"SELECT top 1 Id FROM  NonRegularHours_types WHERE companyId={companyId} And Name='{sName}'")
    End Function

    Public Shared Function GetEmployees_NonRegularHoursProperty(Id As Integer, sProperty As String) As String
        Try
            Select Case sProperty
                Case "Type", "Hours"
                    Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],0) FROM [Employees_NonRegularHours] WHERE [Id]=" & Id)

                Case Else
                    Return GetStringEscalar("SELECT ISNULL([" & sProperty & "],'') FROM [Employees_NonRegularHours] WHERE [companyId]=" & Id)

            End Select
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function NewNonJobTime_Request(ByVal lEmployee As Integer, ByVal lType As Integer, ByVal DateFrom As String,
                                            ByVal DateTo As String, ByVal nTime As String, ByVal sNotes As String, companyId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            Dim sTime As String = FormatearNumero2Tsql(nTime.ToString)
            ' ClienteEmail
            cmd.CommandText = "INSERT INTO [Employees_NonRegularHours_Request] (DateRequest, EmployeeId, Type, DateFrom, DateTo, Hours, Notes, companyId) " &
                                                    "VALUES (" & GetDateUTHlocal() & ", " & lEmployee.ToString & "," &
                                                        lType.ToString & "," &
                                                        GetFecha_102(DateFrom) & "," &
                                                        GetFecha_102(DateTo) & "," &
                                                        sTime & ",'" &
                                                        sNotes & "'," &
                                                        companyId & ")"

            cmd.ExecuteNonQuery()
            cnn1.Close()

            Dim requestId As Integer = GetNumericEscalar("select top 1 Id from [Employees_NonRegularHours_Request] where companyId=" & companyId & " and EmployeeId=" & lEmployee & " order by Id desc")
            Return requestId

            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewNonJobTime, -1, sNotes)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetNonJobTime_Request_Property(requestId As Integer, sProperty As String) As String
        Return GetStringEscalar("select top 1 [" & sProperty & "] from [Employees_NonRegularHours_Request] where Id=" & requestId)
    End Function



    Public Shared Sub TimeSheetStyle(ByVal boundColumn As GridBoundColumn)
        Try
            Select Case UCase(boundColumn.DataField)
                Case "TOTAL"
                    boundColumn.ItemStyle.Font.Bold = True
                    boundColumn.ItemStyle.ForeColor = Drawing.Color.Black
                    boundColumn.ItemStyle.BackColor = Drawing.Color.WhiteSmoke
                'boundColumn.FooterStyle.Font.Bold = True
                Case "PROJECT NAME"
                    boundColumn.ItemStyle.Font.Bold = True
                    boundColumn.ItemStyle.ForeColor = Drawing.Color.DarkBlue
            End Select

            Select Case boundColumn.DataTypeName
                Case "System.Decimal"
                    boundColumn.ItemStyle.HorizontalAlign = HorizontalAlign.Center
                    boundColumn.DataFormatString = "{0:N1}"
                    boundColumn.Aggregate = Telerik.Web.UI.GridAggregateFunction.Sum
                    boundColumn.FooterStyle.HorizontalAlign = HorizontalAlign.Center
                    boundColumn.FooterStyle.Font.Bold = True
                    boundColumn.FooterStyle.ForeColor = Drawing.Color.DarkBlue
                    boundColumn.FooterStyle.BackColor = Drawing.Color.WhiteSmoke
                    boundColumn.HeaderStyle.HorizontalAlign = HorizontalAlign.Center
            End Select

        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Public Shared Sub TimeSheetFormatCells(ByVal e As Telerik.Web.UI.GridItemEventArgs)
        Try
            Dim i As Int16
            If TypeOf e.Item Is GridDataItem Then
                Dim dataItem As GridDataItem = CType(e.Item, GridDataItem)
                For i = 0 To dataItem.Cells.Count - 1
                    Select Case dataItem.Cells(i).Text
                        Case "0.0"
                            dataItem.Cells(i).ForeColor = Drawing.Color.White
                        Case "NO JOBS TIME"
                            dataItem.Cells(i).Font.Underline = True
                            dataItem.Cells(i).ForeColor = Drawing.Color.Black
                    End Select
                Next
            End If
            'If TypeOf e.Item Is GridFooterItem Then
            '    Dim footerItem As GridFooterItem = CType(e.Item, GridFooterItem)
            '    For i = 0 To footerItem.Cells.Count - 1
            '        If footerItem.Cells(i).Text = "0.0" Then
            '            footerItem.Cells(i).ForeColor = Drawing.Color.White
            '        End If
            '    Next
            'End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Shared Function TimeSheetPivotTable(ByVal lEmployee As Integer, ByVal dDateFrom As Date, ByVal dDateTo As Date) As DataTable
        Try

            Dim dest As New DataTable("PivotTimeSheet")
            Dim companyId As Long = GetCompanyIdFromEmployee(lEmployee)
            dest.Columns.Add("Project name", Type.GetType("System.String"))

            Dim sFechaDes As String = dDateFrom
            Dim sFechaHas As String = dDateTo
            Dim sColName As String
            Dim i As Integer
            sFechaHas = sFechaDes

            ' Adicionar el resto de la columnas (Fechas)
            For i = 0 To 13
                sColName = WeekdayName(Weekday(DateAdd(DateInterval.Day, i, CDate(sFechaDes)).Date), True)
                sColName = sColName & "-" & Day(DateAdd(DateInterval.Day, i, CDate(sFechaDes)))
                dest.Columns.Add(sColName, Type.GetType("System.Decimal"))
            Next i
            sFechaHas = DateAdd(DateInterval.Day, 14, CDate(sFechaDes))
            dest.Columns.Add("Total", Type.GetType("System.Decimal"))

            ' Creando tantas filas como Jobs existan
            Dim nFilas As Int16 = 0
            Dim sJobName As String = LocalAPI.GetJobNameByweekly(lEmployee, sFechaDes, sFechaHas, nFilas)
            Do While Len(sJobName) > 0
                dest.Rows.Add(dest.NewRow())
                nFilas = nFilas + 1
                sJobName = LocalAPI.GetJobNameByweekly(lEmployee, sFechaDes, sFechaHas, nFilas)
            Loop

            ' Creando tantas filas como NonRegularHoursTypes existan
            Dim nFilasNonReg As Int16 = 0
            Dim sNonRegularHoursType As String = LocalAPI.GetNonRegularHoursTypesByweekly(lEmployee, sFechaDes, sFechaHas, nFilasNonReg, companyId)
            Do While Len(sNonRegularHoursType) > 0
                dest.Rows.Add(dest.NewRow())
                nFilasNonReg = nFilasNonReg + 1
                sNonRegularHoursType = LocalAPI.GetNonRegularHoursTypesByweekly(lEmployee, sFechaDes, sFechaHas, nFilasNonReg, companyId)
            Loop

            Dim c As Integer
            Dim dTotalFila As Double
            Dim dTime As Double
            Dim sFecha As String
            Dim JobCode As String

            'Hours de Jobs
            For i = 0 To nFilas - 1
                sFecha = sFechaDes
                For c = 0 To 15
                    Select Case c
                        Case 0  ' Columna nombre del Job
                            sJobName = LocalAPI.GetJobNameByweekly(lEmployee, sFechaDes, sFechaHas, i)
                            JobCode = LocalAPI.GetJobCodeFromName(sJobName, companyId)
                            dest.Rows(i)(c) = JobCode & " " & sJobName
                        Case 15 ' Columna de total de fila
                            dest.Rows(i)(c) = dTotalFila
                            dTotalFila = 0
                        Case Else   ' Columnas de Time
                            dTime = LocalAPI.GetEmployeeHoursPerJob(lEmployee, LocalAPI.GetJobId(sJobName, companyId), sFecha)
                            If dTime <> 0 Then
                                dest.Rows(i)(c) = dTime
                            Else
                                dest.Rows(i)(c) = 0
                            End If
                            dTotalFila = dTotalFila + dTime
                            sFecha = DateAdd(DateInterval.Day, 1, CDate(sFecha))
                    End Select
                Next c
            Next i

            ' Non Regular Hours
            Dim sNonRegularHourTypeName As String
            Dim nType As Integer
            dTotalFila = 0

            ' Creando dos fila mas
            dest.Rows.Add(dest.NewRow())
            dest.Rows(nFilas)(0) = " "
            nFilas = nFilas + 1
            dest.Rows.Add(dest.NewRow())
            dest.Rows(nFilas)(0) = "NO JOBS TIME"
            nFilas = nFilas + 1
            For i = nFilas To nFilasNonReg + nFilas - 1
                sFecha = sFechaDes
                For c = 0 To 15
                    Select Case c
                        Case 0  ' Columna nombre del Non Job Time
                            sNonRegularHourTypeName = LocalAPI.GetNonRegularHoursTypesByweekly(lEmployee, sFechaDes, sFechaHas, i - nFilas, companyId)
                            dest.Rows(i)(c) = sNonRegularHourTypeName
                            nType = LocalAPI.GetNonRegularTypesFromName(companyId, sNonRegularHourTypeName)
                        Case 15 ' Columna de total de fila
                            dest.Rows(i)(c) = dTotalFila
                            dTotalFila = 0
                        Case Else   ' Columnas de Time
                            dTime = LocalAPI.GetEmployeeNonRegularHoursType(lEmployee, nType, sFecha)
                            If dTime <> 0 Then
                                dest.Rows(i)(c) = dTime
                            Else
                                dest.Rows(i)(c) = 0
                            End If
                            dTotalFila = dTotalFila + dTime
                            sFecha = DateAdd(DateInterval.Day, 1, CDate(sFecha))
                            dTime = 0
                    End Select
                Next c
            Next i

            dest.AcceptChanges()
            Return dest

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Private Shared Function GetPainTextFromHTML(HTMLSource As String) As String
        Try
            ' Convert HTML to Plain Text...........
            Dim htmlDoc = New HtmlDocument()
            htmlDoc.LoadHtml(HTMLSource)

            'find all <a href=""></> nodes ?
            Dim hrefValue As String
            If Not IsNothing(htmlDoc.DocumentNode.SelectNodes("//a[@href]")) Then
                For Each linkNode As HtmlNode In htmlDoc.DocumentNode.SelectNodes("//a[@href]")

                    ' Get url
                    hrefValue = linkNode.GetAttributeValue("href", String.Empty)

                    ' Insert child node with plain url Text
                    If linkNode.ChildNodes.Count > 0 Then
                        linkNode.ReplaceChild(htmlDoc.CreateTextNode(" " & hrefValue), linkNode.ChildNodes.First())
                    Else
                        linkNode.AppendChild(htmlDoc.CreateTextNode(" " & hrefValue))
                    End If
                Next
            End If

            Return htmlDoc.DocumentNode.InnerText

        Catch ex As Exception
            Return HTMLSource
        End Try
    End Function

    Public Shared Function SendMail(ByVal sTo As String, ByVal sCC As String, ByVal sCCO As String, ByVal sSubtject As String, ByVal sBody As String, ByVal companyId As Integer, clientId As Integer, jobId As Integer,
                                    Optional ByVal sFromMail As String = "", Optional ByVal sFromDisplay As String = "",
                                    Optional replyToMail As String = "", Optional ByVal sReplyToDisplay As String = "") As Boolean
        Try

            Dim host As String
            Dim fromAddr As String
            Dim sUserName As String
            Dim sPassword As String
            Dim EnableSsl As Integer
            Dim Port As Integer
            Dim UseDefaultCredentials As Boolean

            If companyId > 0 Then
                ' Si existe credenciales de envio de email desde una company, se utilizan
                host = GetCompanyProperty(companyId, "webEmailSMTP")
                fromAddr = GetCompanyProperty(companyId, "webEmailUserName")
                sUserName = GetCompanyProperty(companyId, "webEmailUserName")
                sPassword = GetCompanyProperty(companyId, "webEmailPassword")
                EnableSsl = GetCompanyProperty(companyId, "webEmailEnableSsl")
                Port = GetCompanyProperty(companyId, "webEmailPort")
                UseDefaultCredentials = GetCompanyProperty(companyId, "webUseDefaultCredentials")
            End If

            If Len(host) = 0 Then
                ' Se usan las predeterminadas (info@pasconcept.com), si NO existe credenciales de envio de email desde una company
                host = ConfigurationManager.AppSettings("SMTPPASconceptEmail")
                fromAddr = ConfigurationManager.AppSettings("FromPASconceptEmail")
                sUserName = ConfigurationManager.AppSettings("UserPASconceptEmail")
                sPassword = ConfigurationManager.AppSettings("PasswordPASconceptEmail")
                sFromMail = fromAddr
                EnableSsl = ConfigurationManager.AppSettings("EnableSslPASconceptEmail")
                Port = ConfigurationManager.AppSettings("PortPASconceptEmail")
            End If

            Dim smtp As New SmtpClient(host)
            smtp.UseDefaultCredentials = UseDefaultCredentials
            smtp.Credentials = New System.Net.NetworkCredential(sUserName, sPassword)
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network
            smtp.EnableSsl = EnableSsl
            smtp.Port = Port
            'smtp.Timeout = 10000

            Dim message As New MailMessage()
            If ConfigurationManager.AppSettings("Debug") = "1" Then
                message.To.Add("jcarlos@axzes.com")  ' fernando@easterneg.com
            Else
                'message.To.Add(sTo)
                If Len(sTo) > 0 Then MessageAddEmailList(message, sTo, "To")
                If Len(sCC) > 0 Then MessageAddEmailList(message, sCC, "CC")
                If Len(sCCO) > 0 Then MessageAddEmailList(message, sCCO, "CCO")
            End If

            message.Subject = sSubtject
            message.IsBodyHtml = True

            ' Correctio for avoid spam, 8-20-2020
            ' Previuos: message.Body = sBody-----------------------------------------------------------------------
            Dim mimeTypeHtml = New System.Net.Mime.ContentType("text/html")
            Dim alternateHTML As AlternateView = AlternateView.CreateAlternateViewFromString(sBody, mimeTypeHtml)
            message.AlternateViews.Add(alternateHTML)

            ' Convert HTML to Plain Text...........
            Dim sBodyPlain As String = GetPainTextFromHTML(sBody)

            ' Second email view Plain text
            Dim mimeTypePlain = New System.Net.Mime.ContentType("text/plain")
            Dim alternatePlain As AlternateView = AlternateView.CreateAlternateViewFromString(sBodyPlain, mimeTypePlain)
            message.AlternateViews.Add(alternatePlain)
            '-------------------------------------------------------------------------------------------------

            Dim sFrom As String = sFromMail
            If sFrom.Length = 0 Then sFrom = fromAddr
            Dim sDisplay As String = sFromDisplay
            If sDisplay.Length = 0 Then sDisplay = IIf(companyId > 0, GetCompanyProperty(companyId, "Name"), "PASconcept")
            message.From = New MailAddress(sFrom, sDisplay)

            If Len(replyToMail) > 0 Then
                ' Reply-to
                message.ReplyToList.Add(New MailAddress(replyToMail, sReplyToDisplay))
            End If

            smtp.Send(message)

            SendMail = True

            If companyId > 0 Then
                Dim sAdresses As String = sTo
                If Len(sCC) > 0 And sTo <> sCC Then sAdresses = sAdresses & ";" & sCC
                SendMessage(sFrom, sAdresses, sSubtject, sBody, "", False, companyId, clientId, jobId)
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Public Shared Async Function SendGridMail(ByVal sTo As String, ByVal sCC As String, ByVal sCCO As String, ByVal sSubtject As String, ByVal sBody As String, ByVal companyId As Integer,
    '                                Optional ByVal sFromMail As String = "", Optional ByVal sFromDisplay As String = "",
    '                                Optional replyToMail As String = "", Optional ByVal sReplyToDisplay As String = "") As Task
    '    Try
    '        Dim apiKey = ConfigurationManager.AppSettings("SENDGRID_APIKEY")

    '        Dim client = New SendGridClient(apiKey)

    '        Dim msg = New SendGridMessage() With {
    '            .From = New EmailAddress("info@pasconcept.com", "PASconcept"),
    '            .Subject = sSubtject,
    '            .PlainTextContent = "",
    '            .HtmlContent = sBody
    '        }
    '        msg.AddTo(New EmailAddress(sTo))
    '        msg.AddCc(New EmailAddress(sCC))
    '        msg.AddBcc(New EmailAddress(sCCO))

    '        Dim response = Await client.SendEmailAsync(msg)

    '        If companyId > 0 Then
    '            Dim sAdresses As String = sTo
    '            If Len(sCC) > 0 And sTo <> sCC Then sAdresses = sAdresses & ";" & sCC
    '            SendMessage("info@pasconcept.com", sAdresses, sSubtject, sBody, "", False, companyId)
    '        End If
    '    Catch ex As Exception
    '        Throw ex
    '    End Try

    'End Function

    Private Shared Function MessageAddEmailList(ByRef message As MailMessage, sListEmails As String, sType As String) As Boolean
        Dim i As Integer
        Dim sArrValues As String() = Split(sListEmails, ",")
        Dim nValues As Integer = sArrValues.Length
        If nValues > 10 Then nValues = 10
        If nValues > 0 Then
            For i = 0 To nValues - 1
                If ValidEmail(sArrValues(i).ToString) Then
                    Select Case sType
                        Case "To"
                            message.To.Add(Trim(sArrValues(i)))
                        Case "CC"
                            message.CC.Add(Trim(sArrValues(i)))
                        Case "CCO"
                            message.Bcc.Add(Trim(sArrValues(i)))
                    End Select
                End If
            Next i
        End If
    End Function

    Public Shared Function SendMailAndAttachment(ByVal sTo As String,
                                ByVal sSubtject As String,
                                fileData As Byte(), sFileName As String, ByVal companyId As Integer) As Boolean
        Try


            If ValidEmail(sTo) Then

                Dim host As String
                Dim fromAddr As String
                Dim sUserName As String
                Dim sPassword As String
                Dim EnableSsl As Integer
                Dim Port As Integer

                If companyId > 0 Then
                    ' Si existe credenciales de envio de email desde una company, se utilizan
                    host = GetCompanyProperty(companyId, "webEmailSMTP")
                    fromAddr = GetCompanyProperty(companyId, "webEmailUserName")
                    sUserName = GetCompanyProperty(companyId, "webEmailUserName")
                    sPassword = GetCompanyProperty(companyId, "webEmailPassword")
                    EnableSsl = GetCompanyProperty(companyId, "webEmailEnableSsl")
                    Port = GetCompanyProperty(companyId, "webEmailPort")
                End If

                If Len(host) = 0 Then
                    ' Se usan las predeterminadas (info@pasconcept.com), si NO existe credenciales de envio de email desde una company
                    host = ConfigurationManager.AppSettings("SMTPPASconceptEmail")
                    fromAddr = ConfigurationManager.AppSettings("FromPASconceptEmail")
                    sUserName = ConfigurationManager.AppSettings("FromPASconceptEmail")
                    sPassword = ConfigurationManager.AppSettings("PasswordPASconceptEmail")
                    EnableSsl = 0
                    Port = 25
                End If

                Dim sBody As String = "Download the attached file to synchronize the pasconcept appointment  to your calendar. <br><br>"
                sBody = sBody & GetPASSign()

                Dim memoryStream As MemoryStream = New MemoryStream(fileData)
                memoryStream.Seek(0, SeekOrigin.Begin)
                Dim attachment As Mail.Attachment = New Mail.Attachment(memoryStream, sFileName)

                ' (1) Objeto MailMessage 
                Dim message As New MailMessage()
                message.Attachments.Add(attachment)

                Dim sDisplay As String = IIf(companyId > 0, GetCompanyProperty(companyId, "Name"), "PASconcept")
                message.From = New MailAddress(fromAddr, sDisplay)

                If ConfigurationManager.AppSettings("Debug") = "1" Then
                    message.To.Add("jcarlos@axzes.com")  ' fernando@easterneg.com
                Else
                    message.To.Add(sTo)
                End If
                message.Subject = sSubtject
                message.Body = sBody
                message.IsBodyHtml = True

                '(2) Create the SmtpClient object 
                Dim smtp As New SmtpClient(host)
                smtp.UseDefaultCredentials = False
                smtp.Credentials = New System.Net.NetworkCredential(sUserName, sPassword)
                smtp.DeliveryMethod = SmtpDeliveryMethod.Network
                smtp.EnableSsl = EnableSsl
                smtp.Port = Port                '25      ' o 587

                '(3) Send the MailMessage (will use the Web.config settings) 
                smtp.Send(message)

                SendMailAndAttachment = True

                memoryStream.Close()
                memoryStream.Dispose()

                If companyId > 0 Then
                    Dim sAdresses As String = sTo
                    SendMessage(fromAddr, sAdresses, sSubtject, sBody, "", False, companyId, 0, 0)
                End If


            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function CreateCalendarIcs(DateStart As DateTime, DateEnd As DateTime, Summary As String, Location As String, Description As String) As String

        Dim FileName As String = "CalendarItem"
        Dim sb As StringBuilder = New StringBuilder()
        sb.AppendLine("BEGIN:VCALENDAR")
        sb.AppendLine("VERSION:2.0")
        sb.AppendLine("PRODID:pasconcept.com")
        sb.AppendLine("CALSCALE:GREGORIAN")
        sb.AppendLine("METHOD:PUBLISH")
        'sb.AppendLine("BEGIN:VTIMEZONE")
        'sb.AppendLine("TZID:Europe/Amsterdam")
        'sb.AppendLine("BEGIN:STANDARD")
        'sb.AppendLine("TZOFFSETTO:+0100")
        'sb.AppendLine("TZOFFSETFROM:+0100")
        'sb.AppendLine("END:STANDARD")
        'sb.AppendLine("END:VTIMEZONE")
        sb.AppendLine("BEGIN:VEVENT")
        'sb.AppendLine("DTSTART;TZID=Europe/Amsterdam:" & DateStart.ToString("yyyyMMddTHHmm00"))
        'sb.AppendLine("DTEND;TZID=Europe/Amsterdam:" & DateEnd.ToString("yyyyMMddTHHmm00"))
        sb.AppendLine("DTSTART:" & DateStart.ToString("yyyyMMddTHHmm00"))
        sb.AppendLine("DTEND:" & DateEnd.ToString("yyyyMMddTHHmm00"))
        sb.AppendLine("SUMMARY:" & Summary & "")
        sb.AppendLine("LOCATION:" & Location & "")
        sb.AppendLine("DESCRIPTION:" & Description & "")
        sb.AppendLine("PRIORITY:3")
        sb.AppendLine("END:VEVENT")
        sb.AppendLine("END:VCALENDAR")
        Dim CalendarItem As String = sb.ToString()
        Return CalendarItem

    End Function
    Public Shared Function SendMailAndAttachmentExt(ByVal sTo As String, sCCO As String,
                                ByVal sSubtject As String,
                                fileData As Byte(), sFileName As String, ByVal companyId As Integer, clientId As Integer, jobId As Integer) As Boolean
        Try


            If ValidEmail(sTo) Then

                Dim host As String
                Dim fromAddr As String
                Dim sUserName As String
                Dim sPassword As String
                Dim EnableSsl As Integer
                Dim Port As Integer

                If companyId > 0 Then
                    ' Si existe credenciales de envio de email desde una company, se utilizan
                    host = GetCompanyProperty(companyId, "webEmailSMTP")
                    fromAddr = GetCompanyProperty(companyId, "webEmailUserName")
                    sUserName = GetCompanyProperty(companyId, "webEmailUserName")
                    sPassword = GetCompanyProperty(companyId, "webEmailPassword")
                    EnableSsl = GetCompanyProperty(companyId, "webEmailEnableSsl")
                    Port = GetCompanyProperty(companyId, "webEmailPort")
                End If

                If Len(host) = 0 Then
                    ' Se usan las predeterminadas (info@pasconcept.com), si NO existe credenciales de envio de email desde una company
                    host = ConfigurationManager.AppSettings("SMTPPASconceptEmail")
                    fromAddr = ConfigurationManager.AppSettings("FromPASconceptEmail")
                    sUserName = ConfigurationManager.AppSettings("FromPASconceptEmail")
                    sPassword = ConfigurationManager.AppSettings("PasswordPASconceptEmail")
                    EnableSsl = 0
                    Port = 25
                End If

                Dim sBody As String = "Download the attached file to synchronize the pasconcept appointment  to your calendar. <br><br>"
                sBody = sBody & GetPASSign()

                Dim memoryStream As MemoryStream = New MemoryStream(fileData)
                memoryStream.Seek(0, SeekOrigin.Begin)
                Dim attachment As Mail.Attachment = New Mail.Attachment(memoryStream, sFileName)

                ' (1) Objeto MailMessage 
                Dim message As New MailMessage()
                message.Attachments.Add(attachment)

                Dim sDisplay As String = IIf(companyId > 0, GetCompanyProperty(companyId, "Name"), "PASconcept")
                message.From = New MailAddress(fromAddr, sDisplay)

                If ConfigurationManager.AppSettings("Debug") = "1" Then
                    message.To.Add("jcarlos@axzes.com")  ' fernando@easterneg.com
                Else
                    message.To.Add(sTo)
                End If
                If Len(sCCO) > 0 Then MessageAddEmailList(message, sCCO, "CCO")

                message.Subject = sSubtject
                message.Body = sBody
                message.IsBodyHtml = True

                '(2) Create the SmtpClient object 
                Dim smtp As New SmtpClient(host)
                smtp.UseDefaultCredentials = False
                smtp.Credentials = New System.Net.NetworkCredential(sUserName, sPassword)
                smtp.DeliveryMethod = SmtpDeliveryMethod.Network
                smtp.EnableSsl = EnableSsl
                smtp.Port = Port                '25      ' o 587

                '(3) Send the MailMessage (will use the Web.config settings) 
                smtp.Send(message)

                SendMailAndAttachmentExt = True

                memoryStream.Close()
                memoryStream.Dispose()

                If companyId > 0 Then
                    Dim sAdresses As String = sTo
                    SendMessage(fromAddr, sAdresses, sSubtject, sBody, "", False, companyId, clientId, jobId)
                End If


            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function ValidEmail(ByVal sEmail As String) As Boolean
        Dim lPos As Integer
        If Len(Trim(sEmail)) > 5 Then
            lPos = InStr(Trim(sEmail), "@")
            If lPos > 2 Then
                ValidEmail = True
            End If
        End If
    End Function


    ' ................................................................................................................................
    ' Funcion: CompanyBilling
    '          Genera registros de Facturas
    ' Retorno: Valor 
    ' ................................................................................................................................
    Public Shared Function CompanyBilling(ByRef lCompanyId As Integer, ByVal nYear As Int16, ByVal nMesDesde As Int16, ByVal nMesHasta As Int16) As Boolean
        Try
            Dim dBillingDate As Date
            Dim i As Int16

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "CompanyBilling"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            Dim companyID As SqlParameter = New SqlParameter("@companyId", SqlDbType.Int)
            companyID.Value = lCompanyId
            cmd.Parameters.Add(companyID)

            Dim billDay As SqlParameter
            billDay = New SqlParameter("@BillingDate", SqlDbType.SmallDateTime)
            cmd.Parameters.Add(billDay)
            For i = nMesDesde To nMesHasta

                ' Calcular ultimo dia del mes
                dBillingDate = New System.DateTime(nYear, i, 1).AddMonths(1).AddDays(-1)

                ' Set up the date parameter 
                billDay.Value = Convert.ToDateTime(dBillingDate)

                ' Execute the stored procedure.
                cmd.ExecuteNonQuery()
            Next

            CompanyBilling = True

            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function CompanyEmitInvoice(ByRef lInvoiceId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "UPDATE [Company_billings] " &
                                "SET [emitted_date]=" & GetDateUTHlocal() & " " &
                                      ",[emitted]=1 " &
                                "WHERE Id=" & lInvoiceId.ToString

            cmd.ExecuteNonQuery()
            cnn1.Close()

            CompanyEmitInvoice = True

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function GetJobIdFromInvoice(ByVal lInvoice As Long) As Long
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT JobId FROM [Invoices] WHERE [Id]=" & lInvoice, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetJobIdFromInvoice = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetProposalIdFromJob(ByVal lJob As Long) As Long
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT top 1 Id FROM [Proposal] WHERE [JobId]=" & lJob, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetProposalIdFromJob = Val(rdr(0).ToString)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetTotalTimeByJob(ByVal lJob As Long, ByVal lEmploye As Long, ByVal bOthersEmployees As Boolean, Optional ByVal dDate As String = "") As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim sWhere As String = "WHERE Job=" & lJob
            If bOthersEmployees Then
                sWhere = sWhere & " AND Employee<>" & lEmploye
            Else
                If lEmploye > 0 Then
                    sWhere = sWhere & " AND Employee=" & lEmploye
                End If
            End If
            If dDate.Length > 0 Then
                sWhere = sWhere & " AND Fecha=" & GetFecha_102(dDate)
            End If

            Dim cmd As New SqlCommand("SELECT isnull(SUM(Time),0) AS TotalTime FROM Employees_time " & sWhere, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetTotalTimeByJob = rdr(0)
            Else
                GetTotalTimeByJob = 0
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetMessageTemplateSubject(ByVal sType As String, ByVal companyId As Integer) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT ISNULL([Subject],'') FROM [Messages_Templates] WHERE [Type]='" & sType & "' AND [companyId]=" & companyId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetMessageTemplateSubject = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetMessageTemplateBody(ByVal sType As String, ByVal companyId As Integer) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT ISNULL([Body],'') FROM [Messages_Templates] WHERE [Type]='" & sType & "' AND [companyId]=" & companyId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetMessageTemplateBody = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetMessageTemplateBody(ByVal sType As String, ByVal companyId As Integer, dictValues As Dictionary(Of String, String)) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "dbo.Messages_Templatet_Body_Select"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@Type", sType)

            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                Dim body As String = rdr(0)
                If Not String.IsNullOrEmpty(body) Then
                    For Each kvp As KeyValuePair(Of String, String) In dictValues
                        If Not String.IsNullOrEmpty(kvp.Value) Then
                            body = body.Replace(kvp.Key, kvp.Value)
                        Else
                            body = body.Replace(kvp.Key, "")
                        End If
                    Next
                    GetMessageTemplateBody = body
                Else
                    GetMessageTemplateBody = ""
                End If
            End If
            rdr.Close()
            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetMessageTemplateSubject(ByVal sType As String, ByVal companyId As Integer, dictValues As Dictionary(Of String, String)) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "dbo.Messages_Templatet_Subject_Select"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@Type", sType)

            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                Dim subject As String = rdr(0)
                If Not String.IsNullOrEmpty(subject) Then
                    For Each kvp As KeyValuePair(Of String, String) In dictValues
                        If Not String.IsNullOrEmpty(kvp.Value) Then
                            subject = subject.Replace(kvp.Key, kvp.Value)
                        Else
                            subject = subject.Replace(kvp.Key, "")
                        End If
                    Next
                    GetMessageTemplateSubject = subject
                Else
                    GetMessageTemplateSubject = ""
                End If
            End If
            rdr.Close()
            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function ActualizarClient(ByVal lClientId As Integer,
                                    ByVal sField As String,
                                    ByVal sValue As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            Dim parClientId As SqlParameter = New SqlParameter("@parClientId", lClientId)
            cmd.Parameters.Add(parClientId)
            Dim ParValue As SqlParameter = New SqlParameter("@ParValue", sValue)
            cmd.Parameters.Add(ParValue)

            ' Cliente
            cmd.CommandText = "UPDATE [Clients] SET [" & sField & "]=@ParValue WHERE Id=@parClientId"

            cmd.ExecuteNonQuery()

            cnn1.Close()
            ActualizarClient = True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function sys_IsLog(ByVal sEmail As String, ByVal nAccion As Integer, ByVal companyId As Integer, ByVal sNotes As String) As Boolean
        Dim query As String = String.Format("select count(*) from [sys_Log] where companyId={0} and Email='{1}' and Accion={2} and Notes='{3}'", companyId, sEmail, nAccion, sNotes)
        Return IIf(GetNumericEscalar("query") = 0, False, True)
    End Function

    Public Shared Function sys_log_Nuevo(ByVal sEmail As String, ByVal nAccion As Integer, ByVal companyId As Integer, ByVal sNotes As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            If sEmail.Length = 0 Then sEmail = Membership.GetUser.Email
            If companyId <= 0 Then companyId = GetCompanyIdFromEmployee(sEmail)
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "sys_Log_Nuevo"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            Dim parEmail As SqlParameter = New SqlParameter("@Email", sEmail)
            cmd.Parameters.Add(parEmail)
            Dim parAccion As SqlParameter = New SqlParameter("@Accion", nAccion)
            cmd.Parameters.Add(parAccion)
            Dim parcompanyId As SqlParameter = New SqlParameter("@companyId", companyId)
            cmd.Parameters.Add(parcompanyId)
            Dim parNotes As SqlParameter = New SqlParameter("@Notes", sNotes)
            cmd.Parameters.Add(parNotes)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            sys_log_Nuevo = True

            cnn1.Close()

        Catch ex As Exception
            ' Evita tratamiento de error
        End Try

    End Function

    Public Shared Function sys_log_Nuevo_Ext(ByVal sEmail As String, ByVal nAccion As Integer, ByVal companyId As Integer, ByVal sNotes As String, Amount As String) As Boolean
        Try
            ExecuteNonQuery("INSERT  dbo.sys_Log (Email, Accion, companyId, Notes, Amount) VALUES ('" & sEmail & "', " & nAccion & "," & companyId & ",'" & Left(sNotes, 80) & "'," & Amount & ")")
        Catch ex As Exception
            ' Evita tratamiento de error
        End Try

    End Function
    Public Shared Function ExisteMensajeOneTime(ByVal sEmail As String, ByVal MessageId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()


            Dim parEmail As SqlParameter = New SqlParameter("@parEmail", sEmail)
            cmd.Parameters.Add(parEmail)
            Dim ParId As SqlParameter = New SqlParameter("@ParMessageId", MessageId)
            cmd.Parameters.Add(ParId)
            Dim parRes As SqlParameter = New SqlParameter("@Res", SqlDbType.Int)
            parRes.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parRes)

            ' 
            cmd.CommandText = "SELECT @Res=COUNT(*) FROM Messages_OneTime WHERE EmailTo=@parEmail AND MessageId=@ParMessageId"
            cmd.ExecuteNonQuery()

            ExisteMensajeOneTime = (parRes.Value > 0)

            cnn1.Close()
        Catch ex As Exception

        End Try
    End Function
    Public Shared Function NuevoMensajeOneTime(ByVal sEmail As String, ByVal MessageId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()


            Dim parEmail As SqlParameter = New SqlParameter("@parEmail", sEmail)
            cmd.Parameters.Add(parEmail)
            Dim ParId As SqlParameter = New SqlParameter("@ParMessageId", MessageId)
            cmd.Parameters.Add(ParId)

            ' 
            cmd.CommandText = "INSERT INTO [Messages_OneTime] ([MessageId] ,[EmailTo]) " &
                                    "VALUES (@ParMessageId parEmail)"
            cmd.ExecuteNonQuery()

            NuevoMensajeOneTime = True

            cnn1.Close()
        Catch ex As Exception

        End Try
    End Function

    Private Shared Function UnlockUser_old(ByVal sEmail As String) As Boolean
        Try
            Dim usr As MembershipUser = Membership.GetUser(sEmail)
            If usr.IsLockedOut Then
                usr.UnlockUser()
            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function RestoreDefaultMessageTemplate(companyId As Integer) As String
        Dim companyType As Integer = GetCompanyProperty(companyId, "Type")
        ExecuteNonQuery($"delete from [Messages_Templates] where companyId={companyId}")
        ExecuteNonQuery($"INSERT INTO [Messages_Templates] ([Type],[Subject],[Body],[companyId]) SELECT [Type],[Subject],[Body],{companyId} AS CompanyId FROM [Messages_Templates] WHERE companyid={companyType} and [Type] not in(select [Type] from [Messages_Templates] where companyId={companyId})")
    End Function



    Public Shared Async Function RefrescarUsuarioVinculadoAsync(ByVal sEmail As String, ByVal sRole As String) As Task(Of String)
        Try
            Dim sMsgRes As String = ""
            Dim username(0) As String
            Dim sPassword As String = CreateUserPassword()

            ' 3 Casos
            '   1: Es usuario del portal y de la aplicacion, No hacer nada.
            '   2: Es usuairo del portal pero no de la aplicacion, Migrar a Identity
            '   3: No es usuario del Portal, Crear nuevo
            Dim UsuarioApp = LocalAPI.ExisteUserIdentity(sEmail)
            If Not UsuarioApp Then
                Dim UsuarioPortal = LocalAPI.ExisteUser(sEmail)
                If UsuarioPortal Then  ' Migrate to Identity
                    Dim password = LocalAPI.GetMembershipUserPasswod(sEmail)
                    Await LocalAPI.CreateOrUpdateUser(sEmail, password)
                Else
                    Dim password = LocalAPI.CreateUserPassword()
                    Await LocalAPI.CreateOrUpdateUser(sEmail, password)
                    sMsgRes = "Se ha creado el usuario " & sEmail
                End If
            End If

            Return sMsgRes

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function IsADMCLIuserAutorized(sEmail As String, companyId As Integer) As Boolean
        'If Roles.IsUserInRole(sEmail, "Clientes") Then
        '    If IsClientEmail(sEmail, companyId) Then
        '        Return True
        '    End If
        'End If
        'If Roles.IsUserInRole(sEmail, "Administradores") Then
        '    If IsEmployeeEmail(sEmail, companyId) Then
        '        Return True
        '    End If
        'End If
        'If Roles.IsUserInRole(sEmail, "Subconsultans") Then
        '    If IsSubconsultantEmail(sEmail, companyId) Then
        '        Return True
        '    End If
        'End If
        Return True
    End Function

    Public Shared Function CreateUserPassword() As String
        Return Membership.GeneratePassword(6, 1)
    End Function

    Public Shared Function RefrescarUsuarioVinculado_ant(ByVal sEmail As String, ByVal sRole As String, ByVal bEliminarSiExiste As Boolean) As String
        Try
            Dim i As Integer
            Dim sMsgRes As String = ""
            Dim username(0) As String
            Dim sPassword As String = CreateUserPassword()

            ' Leo la colecion de todos los usuarios con ese Email
            Dim arrUsersColleccion As MembershipUserCollection = New MembershipUserCollection()
            arrUsersColleccion = Membership.FindUsersByEmail(sEmail)
            Select Case arrUsersColleccion.Count
                Case 0
                    ' No existe usuario. Crearlo
                    Membership.CreateUser(sEmail, sPassword, sEmail)
                    username(0) = sEmail
                    'Roles.AddUsersToRole(username, sRole)
                    sMsgRes = sEmail & " user was created. Send new credentials"

                Case Else
                    If bEliminarSiExiste Then
                        ' 1� Eliminar todos los que UserName&lt;&gt;Email
                        For Each user As MembershipUser In arrUsersColleccion
                            If user.UserName <> user.Email Then
                                sMsgRes = sMsgRes & "Deleted " & user.UserName & ". "
                                Membership.DeleteUser(user.UserName, True)
                            End If
                        Next
                        '2� Si no queda ninguno Ok (UserName=Email), lo creo
                        If Membership.FindUsersByEmail(sEmail).Count = 0 Then
                            Membership.CreateUser(sEmail, sPassword, sEmail)
                            username(0) = sEmail
                            'Roles.AddUsersToRole(username, sRole)
                            sMsgRes = sMsgRes & sEmail & " user was created. Send new credentials"
                        End If
                        If sMsgRes.Length = 0 Then sMsgRes = "The user is updated"
                    Else
                        ' No eliminar ni crear, solo a�adir nuevo role
                        username(0) = sEmail
                        'Roles.AddUsersToRole(username, sRole)
                    End If
            End Select
            RefrescarUsuarioVinculado_ant = sMsgRes

        Catch ex As Exception
            RefrescarUsuarioVinculado_ant = ex.Message
        End Try
    End Function

    Public Shared Function EstaSincronizado(ByVal sEmailSource As Object) As Boolean
        Try
            If Not sEmailSource Is Nothing Then
                Dim sEmail As String = sEmailSource.ToString
                EstaSincronizado = True
                ' Leo la colecion de todos los usuarios con ese Email
                Dim arrUsersColleccion As MembershipUserCollection = New MembershipUserCollection()
                arrUsersColleccion = Membership.FindUsersByEmail(sEmail)
                Select Case arrUsersColleccion.Count
                    Case 1
                        ' 1� Eliminar todos los que UserName&lt;&gt;Email
                        For Each user As MembershipUser In arrUsersColleccion
                            If user.UserName = user.Email Then
                                EstaSincronizado = False
                            End If
                        Next
                End Select
            End If
        Catch ex As Exception

        End Try

    End Function

    Private Shared Function ClientChangeEmail_ant(ByVal lClientId As Integer, ByVal sUserEmail As String, ByVal sNewUserEmail As String) As Boolean
        Try

            If sUserEmail <> sNewUserEmail Then
                ' Changing email address of user.
                ' Delete current user account and create
                ' a new one using the new email address
                ' but the same password
                If Not Membership.GetUser(sNewUserEmail) Is Nothing Then
                    ' Ya existe un user con este Email
                Else
                    ' Existe usuario actual?, rescato su password
                    Dim oldusername As String
                    Dim currentPassword As String = ""
                    If sUserEmail.Length > 0 Then
                        oldusername = Membership.GetUserNameByEmail(sUserEmail)
                        If Not oldusername Is Nothing Then
                            currentPassword = Membership.GetUser(oldusername).GetPassword
                        End If
                    End If
                    If currentPassword.Length < 6 Then
                        currentPassword = LocalAPI.GetInitialClientPassword(lClientId)
                    End If
                    ' Crear un nuevo usuario
                    Dim newUser As MembershipUser = Membership.CreateUser(sNewUserEmail, currentPassword, sNewUserEmail)
                    Dim username(0) As String
                    username(0) = sNewUserEmail
                    'Roles.AddUsersToRole(username, "Clientes")

                    ' Actualizar la Ficha del cliente
                    LocalAPI.ActualizarClient(lClientId, "Email", sNewUserEmail)
                    If Not oldusername Is Nothing Then
                        Membership.DeleteUser(sUserEmail, True)
                    End If

                End If

            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function GetProposalTemplateDescription(ByVal Id As Integer) As String
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT ISNULL([Descripction],'') FROM [Proposal_TandCtemplates] WHERE Id=" & Id.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetProposalTemplateDescription = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetCompanyProposalTemplateDescription(ByVal Id As Integer) As String
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT ISNULL([Descripction],'') FROM [Company_Proposal_TandC_TEMPLATE] WHERE templateId=" & Id.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetCompanyProposalTemplateDescription = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function GetTaskProperty(ByVal taskCode As String, ByVal sPropertyName As String, companyId As Integer) As String
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT top 1 ISNULL([" & sPropertyName & "],'') FROM [Proposal_tasks] WHERE taskCode='" & taskCode & "' AND companyId=" & companyId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetTaskProperty = "" & rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()

            ' Validaciones finales
            If GetTaskProperty.Length = 0 Then
                Select Case sPropertyName
                    Case "Hours", "Rates"
                        GetTaskProperty = 0
                End Select
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function GetTaskProperty(ByVal taskId As Integer, ByVal sProperty As String) As String

        Select Case sProperty
            Case "Hours", "Rates", "disciplineId", "HourRatesService"
                ' Valores Numeric
                Return GetNumericEscalar("SELECT top 1 ISNULL([" & sProperty & "],0) FROM [Proposal_tasks] WHERE Id=" & taskId)
            Case Else
                Return GetStringEscalar("SELECT top 1 ISNULL([" & sProperty & "],'') FROM [Proposal_tasks] WHERE Id=" & taskId)
        End Select

    End Function



    Public Shared Function GetStatementProperty(ByVal statementId As Integer, ByVal sPropertyName As String) As String
        Try

            Select Case sPropertyName
                Case "clientId", "companyId", "Emitted", "Contador"
                    ' Valores Numeric
                    Return GetNumericEscalar("SELECT top 1 ISNULL([" & sPropertyName & "],0) FROM [Invoices_statements] WHERE Id=" & statementId)
                Case "guid"
                    Return GetStringEscalar("SELECT top 1 [" & sPropertyName & "] FROM [Invoices_statements] WHERE Id=" & statementId)
                Case Else
                    Return GetStringEscalar("SELECT ISNULL(" & sPropertyName & ",'') FROM Invoices_statements INNER JOIN Clients ON Invoices_statements.clientId = Clients.Id WHERE Invoices_statements.Id=" & statementId.ToString)
            End Select
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function SetInvoiceStatement(ByVal invoiceId As Integer, ByVal statementId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' 9-3-2020
            ' No add invoices with Amount=0
            cmd.CommandText = $"UPDATE [Invoices] SET [statementId]={statementId} WHERE Id={invoiceId} and Amount<>0"

            cmd.ExecuteNonQuery()
            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function GetStatementNumber(ByVal Id As Integer) As String
        Return GetStringEscalar("SELECT dbo.StatementNumber(" & Id & ")")
    End Function

    Public Shared Function SetInvoiceEmittedFromStatement(ByVal statementId As Integer) As Boolean
        Try

            ExecuteNonQuery("UPDATE [Invoices] SET [FirstEmission]=" & GetDateUTHlocal() & " WHERE statementId=" & statementId & " AND ISNULL(Emitted,0)=0")
            ExecuteNonQuery("UPDATE [Invoices] SET Emitted=ISNULL(Emitted,0)+1, [LatestEmission]=" & GetDateUTHlocal() & " WHERE statementId=" & statementId)
            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function SetNotificado(ByVal MessagesAddresseesId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "UPDATE dbo.Messages_Addressees SET Notification=1 WHERE Id=" & MessagesAddresseesId

            cmd.ExecuteNonQuery()
            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetNotificationPending(ByVal sEmail As String, ByRef AsuntoOUTPUT As String, ByRef IdMessageOUTPUT As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT TOP 1 Messages_Addressees.Id, Messages_Addressees.IdMessage, Messages.Subject FROM Messages_Addressees INNER JOIN Messages ON Messages_Addressees.IdMessage = Messages.Id " &
                                      "WHERE Messages_Addressees.[To] = '" & sEmail & "' AND ISNULL(Messages_Addressees.Notification,0) = 0 " &
                                      "ORDER BY Messages_Addressees.Id", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                SetNotificado(rdr("Id"))
                AsuntoOUTPUT = "" & rdr("Subject").ToString
                IdMessageOUTPUT = rdr("IdMessage")
                GetNotificationPending = True
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function RFP_GeneratePaymentSchedules(rfpId As Integer, psId As Integer) As Boolean
        Try
            Dim psValues As String = GetStringEscalar("SELECT PaymentsScheduleList FROM Invoices_types WHERE [Id]=" & psId)
            Dim psText As String = GetStringEscalar("SELECT PaymentsTextList FROM Invoices_types WHERE [Id]=" & psId)

            Dim sArrValues As String() = Split(psValues, ",")
            Dim sArrText As String() = Split(psText, ",")
            Dim i As Int16, j As Int16
            Dim nValues As Integer = sArrValues.Length
            If nValues > 10 Then nValues = 10
            If sArrValues.Length > 0 Then
                For i = 0 To nValues - 1
                    If Len(sArrValues(i).ToString) > 0 Then
                        ExecuteNonQuery("UPDATE RequestForProposals SET " &
                                        "[PaymentSchedule" & i + 1 & "]=" & sArrValues(i) & "," &
                                        "[PaymentText" & i + 1 & "]='" & sArrText(i) & "' " &
                                        "WHERE [Id]=" & rfpId
                                        )
                    End If
                Next
            End If
            For j = i To MAXPaymentSchedule - 1
                ExecuteNonQuery("UPDATE RequestForProposals SET " &
                                    "[PaymentSchedule" & j + 1 & "]=NULL," &
                                    "[PaymentText" & j + 1 & "]=NULL " &
                                    "WHERE [Id]=" & rfpId
                                    )
            Next


        Catch ex As Exception

        End Try


    End Function

#End Region

#Region "GettingStarted"
    Public Shared Function start_CompanyInfoReady(companyId As Integer) As Boolean
        Return GetStringEscalar("SELECT dbo.start_CompanyInfo(" & companyId & ")")
    End Function
    Public Shared Function start_EmployeeInfoReady(companyId As Integer) As Boolean
        Return GetStringEscalar("SELECT COUNT(*) from Employees where companyId=" & companyId)
    End Function
    Public Shared Function start_ClientsInfoReady(companyId As Integer) As Boolean
        Return GetStringEscalar("SELECT COUNT(*) from Clients where companyId=" & companyId)
    End Function
    Public Shared Function start_Proposal_TandCtemplatesInfoReady(companyId As Integer) As Boolean
        Return GetStringEscalar("SELECT COUNT(*) from Proposal_TandCtemplates where companyId=" & companyId)
    End Function
    Public Shared Function start_PaymentSchedulesInfoReady(companyId As Integer) As Boolean
        Return GetStringEscalar("SELECT COUNT(*) from Invoices_types where companyId=" & companyId)
    End Function
    Public Shared Function start_ProposalInfoReady(companyId As Integer) As Boolean
        Return GetStringEscalar("SELECT COUNT(*) from Proposal where companyId=" & companyId)
    End Function
    Public Shared Function start_JobCodesInfoReady(companyId As Integer) As Boolean
        Return GetStringEscalar("SELECT COUNT(*) from Jobs_types where companyId=" & companyId)
    End Function
    Public Shared Function start_JobInfoReady(companyId As Integer) As Boolean
        Return GetStringEscalar("SELECT COUNT(*) from Jobs where companyId=" & companyId)
    End Function
    Public Shared Function start_SubconsultantsInfoReady(companyId As Integer) As Boolean
        Return GetStringEscalar("SELECT COUNT(*) from Subconsultans where companyId=" & companyId)
    End Function
    Public Shared Function start_RequestForProposalsInfoReady(companyId As Integer) As Boolean
        Return GetStringEscalar("SELECT COUNT(*) from RequestForProposals where companyId=" & companyId)
    End Function
#End Region

#Region "TermAndConditios"

    Public Shared Function IAgree(ByVal userEmail As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "sys_IAgree"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@userEmail", userEmail)
            cmd.Parameters.Add("@RETURN_VALUE", SqlDbType.Int).Direction = ParameterDirection.ReturnValue

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            Dim Ret As Integer = cmd.Parameters("@RETURN_VALUE").Value

            cnn1.Close()

            Return Ret
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function SetIAgree(ByVal userEmail As String) As Boolean
        ExecuteNonQuery("UPDATE [UserAgree] SET Agree=1, [DateSet]=" & GetDateUTHlocal() & " WHERE userEmail='" & userEmail & "'")
    End Function

    Public Shared Function SetIDisagree(ByVal userEmail As String) As Boolean
        ExecuteNonQuery("UPDATE [UserAgree] SET DisAgree=1, [Times]=[Times]+1 WHERE userEmail='" & userEmail & "'")
    End Function

    Public Shared Function SetIReadLater(ByVal userEmail As String) As Boolean
        ExecuteNonQuery("UPDATE [UserAgree] SET [Times]=[Times]+1 WHERE userEmail='" & userEmail & "'")
    End Function

    Public Shared Function GetIReadLater(ByVal userEmail As String) As Integer
        Try
            Return GetNumericEscalar("SELECT ISNULL([Times],0) FROM UserAgree WHERE userEmail='" & userEmail & "'")

        Catch ex As Exception
            Throw ex
        End Try
    End Function


#End Region

#Region "Company"
    Public Shared Function GetCompanyGUID(ByVal Id As Integer) As String
        Return GetStringEscalar($"SELECT [guId] FROM [Company] WHERE [companyId]={Id}")
    End Function

    Public Shared Function GetCompanyIdFromGUID(ByVal gu_id As String) As Integer
        'Inject SQL!!!!! Return GetNumericEscalar($"SELECT [companyId] FROM [Company] WHERE [guId]='{gu_id}'")
        Dim cnn1 As SqlConnection = GetConnection()
        Dim cmd As New SqlCommand("SELECT [companyId] FROM [Company] WHERE [guId]=@guid", cnn1)
        cmd.Parameters.AddWithValue("@guid", gu_id)
        GetCompanyIdFromGUID = Convert.ToDouble(cmd.ExecuteScalar())
        cnn1.Close()

    End Function

    Public Shared Function GetLastCompanyCreated(sCompanyName As String, sEmail As String) As Integer
        Return GetNumericEscalar($"SELECT TOP 1 [companyId] FROM Company WHERE [Name]='{sCompanyName}' AND Email='{sEmail}' ORDER BY StartDate DESC")
    End Function

    Public Shared Function GetCompanyId(ByVal lEmployee As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand($"SELECT [companyId] FROM [Employees] WHERE [Id]={lEmployee}", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetCompanyId = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetCompanyIdFromJob(ByVal lJobId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand($"SELECT [companyId] FROM [Jobs] WHERE [Id]={lJobId}", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetCompanyIdFromJob = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetCompanyIdFromClient(ByVal sClientEmail As String) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand($"SELECT TOP 1 [companyId] FROM [Clients] WHERE [Email]='{sClientEmail}'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetCompanyIdFromClient = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetCompanyIdFromEmployee(ByVal sEmployeeEmail As String) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand($"SELECT TOP 1 [companyId] FROM [Employees] WHERE [Email]='{sEmployeeEmail}' order by companyId", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetCompanyIdFromEmployee = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetActiveCompanyIdFromEmployee(ByVal sEmployeeEmail As String) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand($"SELECT TOP 1 [companyId] FROM [Employees] WHERE [Email]='{sEmployeeEmail}' and Inactive=0 order by companyId", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetActiveCompanyIdFromEmployee = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetCompanyIdFromEmployee(ByVal employeeId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand($"SELECT [companyId] FROM [Employees] WHERE [Id]={employeeId}", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetCompanyIdFromEmployee = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetCompanyIdFromProposal(ByVal lProposalId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand($"SELECT [companyId] FROM [Proposal] WHERE [Id]={lProposalId}", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetCompanyIdFromProposal = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetCompanyIdFromRFP(ByVal lRFPId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand($"SELECT [companyId] FROM [RequestForProposals] WHERE [Id]={lRFPId}", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetCompanyIdFromRFP = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetCompanyIdFromInvoice(ByVal invoiceId As Integer) As Integer
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand($"SELECT Jobs.companyId FROM Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id WHERE Invoices.Id={invoiceId}", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetCompanyIdFromInvoice = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetCompanyIdFromStatement(ByVal statementId As Integer) As Integer
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand($"SELECT [companyId] FROM [Invoices_statements] WHERE [Id]={statementId}", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetCompanyIdFromStatement = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function Company_Init_TEMPLATES(ByVal companyId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Company_Init_TEMPLATES"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@companyId", companyId)

            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True

        Catch ex As Exception
            Throw ex
        End Try
    End Function


#End Region

#Region "Departments"

    Public Shared Function GetDepartmentsProperty(ByRef departmentId As Integer, ByVal sProperty As String) As String
        Select Case sProperty
            Case "ParentID", "Head", "Productive"
                Return GetNumericEscalar("SELECT TOP 1 [" & sProperty & "] FROM [Company_Department] where [Id]=" & departmentId)
            Case "TagCategoryLabel0"
                Return GetStringEscalar("SELECT TOP 1 isnull(TagCategoryLabel0,'CategoryLabel0') FROM [Company_Department] where [Id]=" & departmentId)
            Case "TagCategoryLabel1"
                Return GetStringEscalar("SELECT TOP 1 isnull(TagCategoryLabel1,'CategoryLabel1') FROM [Company_Department] where [Id]=" & departmentId)
            Case "TagCategoryLabel2"
                Return GetStringEscalar("SELECT TOP 1 isnull(TagCategoryLabel2,'CategoryLabel2') FROM [Company_Department] where [Id]=" & departmentId)
            Case "TagCategoryLabel3"
                Return GetStringEscalar("SELECT TOP 1 isnull(TagCategoryLabel3,'CategoryLabel3') FROM [Company_Department] where [Id]=" & departmentId)
            Case "TagCategoryLabel4"
                Return GetStringEscalar("SELECT TOP 1 isnull(TagCategoryLabel4,'CategoryLabel4') FROM [Company_Department] where [Id]=" & departmentId)
            Case "TagCategoryLabel5"
                Return GetStringEscalar("SELECT TOP 1 isnull(TagCategoryLabel5,'CategoryLabel5') FROM [Company_Department] where [Id]=" & departmentId)
            Case "TagCategoryLabel6"
                Return GetStringEscalar("SELECT TOP 1 isnull(TagCategoryLabel6,'CategoryLabel6') FROM [Company_Department] where [Id]=" & departmentId)
            Case "TagCategoryLabel7"
                Return GetStringEscalar("SELECT TOP 1 isnull(TagCategoryLabel7,'CategoryLabel7') FROM [Company_Department] where [Id]=" & departmentId)
            Case "TagCategoryLabel8"
                Return GetStringEscalar("SELECT TOP 1 isnull(TagCategoryLabel8,'CategoryLabel8') FROM [Company_Department] where [Id]=" & departmentId)
            Case Else
                Return GetStringEscalar("SELECT TOP 1 [" & sProperty & "] FROM [Company_Department] where [Id]=" & departmentId)
        End Select

    End Function


    Public Shared Function IsOrgChar(ByVal companyId As Integer) As Boolean

        Return (GetNumericEscalar("select count(*) from Company_Department where companyId=" & companyId & " and isnull(ParentID,0)>0") > 0)
    End Function

    Public Shared Function DepartmentCount(ByVal companyId As Integer) As Integer

        Return GetNumericEscalar("select count(*) from Company_Department where companyId=" & companyId)
    End Function

    Public Shared Sub FirstDeparment(ByVal companyId As Integer)
        If DepartmentCount(companyId) = 0 Then
            ExecuteNonQuery("INSERT INTO [Company_Department] ([Name],[Productive],[companyId]) VALUES('Department 1',1," & companyId & ")")
        End If
    End Sub
    Public Shared Function DeparmentDistribuyeBudget(ByVal Id As Integer, total As Double) As Boolean
        Try
            Return ExecuteNonQuery("UPDATE [Company_Department_Budget] set " &
                                            "[Jan]=" & FormatearNumero2Tsql(total / 12) &
                                            ",[Feb]=" & FormatearNumero2Tsql(total / 12) &
                                            ",[Mar]=" & FormatearNumero2Tsql(total / 12) &
                                            ",[Apr]=" & FormatearNumero2Tsql(total / 12) &
                                            ",[May]=" & FormatearNumero2Tsql(total / 12) &
                                            ",[Jun]=" & FormatearNumero2Tsql(total / 12) &
                                            ",[Jul]=" & FormatearNumero2Tsql(total / 12) &
                                            ",[Aug]=" & FormatearNumero2Tsql(total / 12) &
                                            ",[Sep]=" & FormatearNumero2Tsql(total / 12) &
                                            ",[Oct]=" & FormatearNumero2Tsql(total / 12) &
                                            ",[Nov]=" & FormatearNumero2Tsql(total / 12) &
                                            ",[Dec]=" & FormatearNumero2Tsql(total / 12) &
                                   " WHERE Id=" & Id)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function DeparmentBudgetByBaseSalaryForMultiplierFullYear(companyId As Integer, Multiplier As Double, year As Integer) As Boolean

        'ExecuteNonQuery("UPDATE [Company] SET Multiplier=" & Multiplier & " WHERE companyId=" & companyId)

        ' Inicializo Table
        ExecuteNonQuery("DELETE FROM Company_Department_Budget WHERE companyId=" & companyId & " and [Year]=" & year)

        ' Recorrer todos los departamentos
        Dim cnn1 As SqlConnection = GetConnection()
        Dim cmd As New SqlCommand("SELECT Id, isnull(Productive,0) as Productive FROM Company_Department WHERE companyId=" & companyId, cnn1)
        Dim rdr As SqlDataReader
        rdr = cmd.ExecuteReader
        Dim dMonthyValue As Double
        While rdr.Read()
            If rdr.HasRows Then
                If rdr("Productive") Then
                    dMonthyValue = GetDepartmentProductiveSalary(rdr("Id"), year) * Multiplier / 12
                Else
                    dMonthyValue = 0
                End If
                ExecuteNonQuery("INSERT INTO [Company_Department_Budget] ([departmentId],[companyId],[Year],[Jan],[Feb],[Mar],[Apr],[May],[Jun],[Jul],[Aug],[Sep],[Oct],[Nov],[Dec])" &
                                    "VALUES (" & rdr("Id") & "," & companyId & "," & year &
                                                "," & FormatearNumero2Tsql(dMonthyValue) &
                                                "," & FormatearNumero2Tsql(dMonthyValue) &
                                                "," & FormatearNumero2Tsql(dMonthyValue) &
                                                "," & FormatearNumero2Tsql(dMonthyValue) &
                                                "," & FormatearNumero2Tsql(dMonthyValue) &
                                                "," & FormatearNumero2Tsql(dMonthyValue) &
                                                "," & FormatearNumero2Tsql(dMonthyValue) &
                                                "," & FormatearNumero2Tsql(dMonthyValue) &
                                                "," & FormatearNumero2Tsql(dMonthyValue) &
                                                "," & FormatearNumero2Tsql(dMonthyValue) &
                                                "," & FormatearNumero2Tsql(dMonthyValue) &
                                                "," & FormatearNumero2Tsql(dMonthyValue) &
                                            ")")
            End If
        End While
        rdr.Close()
        cnn1.Close()

    End Function

    Public Shared Function DeparmentBudgetByBaseSalaryForMultiplierFromThisMonth(companyId As Integer, Multiplier As Double, year As Integer, Month As Integer) As Boolean
        ' Recorrer todos los departamentos
        Dim cnn1 As SqlConnection = GetConnection()
        Dim cmd As New SqlCommand("SELECT Id, isnull(Productive,0) as Productive FROM Company_Department WHERE companyId=" & companyId, cnn1)
        Dim rdr As SqlDataReader
        Dim i As Integer
        rdr = cmd.ExecuteReader
        Dim dMonthyValue As Double
        While rdr.Read()
            If rdr.HasRows Then
                For i = Month To 12
                    If rdr("Productive") Then
                        dMonthyValue = GetDepartmentMonthProductiveSalary(rdr("Id"), year, i) * Multiplier
                    Else
                        dMonthyValue = 0
                    End If
                    Company_Department_Budget_UPDATE(rdr("Id"), year, i, dMonthyValue)
                Next

            End If
        End While
        rdr.Close()
        cnn1.Close()

    End Function

    Public Shared Function Company_Department_Budget_UPDATE(ByRef departmentId As Integer, year As Integer, Month As Integer, Amount As Double) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Company_Department_Budget_UPDATE"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@departmentId", departmentId)
            cmd.Parameters.AddWithValue("@year", year)
            cmd.Parameters.AddWithValue("@Month", Month)
            cmd.Parameters.AddWithValue("@Amount", Amount)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function EmployeesHourlyWage_INSERT(year As Integer, companyId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Employee_HourlyWageInitializeYear_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@year", year)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function AllCompaniesEmployeesHourlyWage_INSERT(year As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "AllCompaniesEmployee_HourlyWageInitializeYear_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@year", year)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception

        End Try
    End Function
    Public Shared Function GetCompanyProductiveSalary(companyId As Integer, year As Integer) As Double
        Return GetNumericEscalar("select dbo.CompanyProductiveSalary(" & year & "," & companyId & ")")
    End Function

    Private Shared Function GetEmployeeProductiveSalary(employeeId As Integer, year As Integer) As Double
        Return GetNumericEscalar("select dbo.EmployeeProductiveSalary(" & year & "," & employeeId & ")")
    End Function
    Private Shared Function GetDepartmentProductiveSalary(departmentId As Integer, year As Integer) As Double
        Return GetNumericEscalar("select dbo.DepartmentProductiveSalary(" & year & "," & departmentId & ")")
    End Function
    Private Shared Function GetDepartmentMonthProductiveSalary(departmentId As Integer, year As Integer, month As Integer) As Double
        Return GetNumericEscalar("select dbo.DepartmentMonthProductiveSalary(" & year & "," & month & "," & departmentId & ")")
    End Function

#End Region

#Region "Employees"

    Public Shared Function GetEmployeesSign(ByVal employeeId As Integer) As String
        Dim sSuffix As String = GetEmployeeProperty(employeeId, "Suffix")
        sSuffix = IIf(Len(sSuffix) > 0, ", ", "") & sSuffix
        Dim sSign As New System.Text.StringBuilder
        sSign.Append("<br />")
        sSign.Append("<strong>" & LocalAPI.GetEmployeeName(employeeId) & sSuffix & "</strong>")
        sSign.Append("<br />")
        sSign.Append(GetEmployeePosition(employeeId))

        Return sSign.ToString
    End Function

    Public Shared Function EmailToEmployee(ByVal nEmployee As Integer, ByVal sSubject As String, ByVal sBody As System.Text.StringBuilder, ByVal companyId As Integer) As Long
        Try
            Dim EmailTo As String = GetEmployeeEmail(nEmployee)
            Task.Run(Function() SendGrid.Email.SendMail(EmailTo, "", "", sSubject, sBody.ToString, companyId, 0, 0))
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetEmployee_HourlyWageHistoryProperty(ByRef Employee_HourlyWageHistoryId As Integer, ByVal sProperty As String) As String
        Return GetStringEscalar("SELECT TOP 1 [" & sProperty & "] FROM [Employee_HourlyWageHistory] where [Id]=" & Employee_HourlyWageHistoryId)
    End Function
    Public Shared Function GetEmployee_HourlyWageHistoryPreviousPeriodProperty(ByRef Employee_HourlyWageHistoryId As Integer, ByVal sProperty As String) As String
        Return GetStringEscalar($"SELECT TOP 1 {sProperty} FROM [Employee_HourlyWageHistory] HW where [Id]<{Employee_HourlyWageHistoryId} and HW.employeeId=(select employeeId from [Employee_HourlyWageHistory] where Id={Employee_HourlyWageHistoryId}) order by Date desc")
    End Function

    Public Shared Function GetHourlyWageHistoryLastRecord(ByRef EmployeeId As Integer, ByVal year As Integer) As Integer
        Return GetNumericEscalar(String.Format("SELECT TOP 1 Id FROM [Employee_HourlyWageHistory] where [employeeId]={0} And Year([Date])={1} order by [Date] desc", EmployeeId, year))
    End Function
    Public Shared Function GetHoursEmployeeTimeCheckIn(ByRef EmployeeId As Integer, ByVal DateEntry As DateTime) As Double
        Return GetNumericEscalar($"select dbo.EmployeeTimeCheckIn({EmployeeId},'{DateEntry}')")
    End Function


    Public Shared Function EmployeeAddUpdatePhoto(Email As String, PhotoURL As String, ContentType As String, sDate As DateTime) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Employee_AddUpdatePhoto"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Email", Email)
            cmd.Parameters.AddWithValue("@PhotoURL", PhotoURL)
            cmd.Parameters.AddWithValue("@ContentType", ContentType)
            cmd.Parameters.AddWithValue("@Date", sDate)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function GetEmployeePhotoURL(employeeId As Integer) As String
        Try
            Dim email As String = GetEmployeeEmail(employeeId)
            Return GetEmployeePhotoURL(Email:=email)
        Catch ex As Exception
        End Try
    End Function
    Public Shared Function GetEmployeePhotoURL(Email As String) As String
        Try
            Dim PhotoURL As String = GetStringEscalar($"SELECT isnull(PhotoURL,'') FROM [Employees_Photo] WHERE Email='{Email}'")

            Return IIf(Len(PhotoURL) > 0, PhotoURL, "~/Images/Employees/nophoto.jpg")
        Catch ex As Exception
        End Try
    End Function

    Public Shared Function NewPayroll(ByRef employeeId As Integer, SalaryDate As DateTime, NetAmount As Double, Hours As Double, GrossAmount As Double, TotalCost As Double, OriginalReference As String, companyId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "EmployeePayroll_v20_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@employeeId", employeeId)
            cmd.Parameters.AddWithValue("@SalaryDate", SalaryDate)
            cmd.Parameters.AddWithValue("@NetAmount", NetAmount)
            cmd.Parameters.AddWithValue("@Hours", Hours)
            cmd.Parameters.AddWithValue("@GrossAmount", GrossAmount)
            cmd.Parameters.AddWithValue("@TotalCost", TotalCost)
            cmd.Parameters.AddWithValue("@OriginalReference", OriginalReference)
            cmd.Parameters.AddWithValue("@companyId", companyId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function ActivateTechnicalSupportEmployee(UserEmail As String, companyId As Integer) As Boolean
        Try
            'InicializeEmployeeOfJob(lEmployee, lJob)

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "ActivateTechnicalSupportEmployee"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@companyId", companyId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            sys_log_Nuevo(UserEmail, LocalAPI.sys_log_AccionENUM.NewEmployee, companyId, "Activate Technical Support Employee")

            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function DeactivateTechnicalSupportEmployee(UserEmail As String, companyId As Integer) As Boolean
        Try
            'InicializeEmployeeOfJob(lEmployee, lJob)

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "DeactivateTechnicalSupportEmployee"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@companyId", companyId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            sys_log_Nuevo(UserEmail, LocalAPI.sys_log_AccionENUM.InactiveEmployee, companyId, "Dectivate Technical Support Employee")

            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function IsTechnicalSupportEmployee(ByVal companyId As Integer) As Boolean
        Return (GetNumericEscalar($"SELECT count(*) FROM Employees WHERE companyId={companyId} AND Email='support@pasconcept.com' and isnull(Inactive,0)=0") > 0)
    End Function

    Public Shared Function NewExpense(ByRef companyId As Integer, ExpDate As DateTime, ExpType As String, Reference As String, Amount As Double, Category As String, Vendor As String, Memo As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Company_Expenses_v20_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@ExpDate", ExpDate)
            cmd.Parameters.AddWithValue("@Type", ExpType)
            cmd.Parameters.AddWithValue("@Reference", Reference)
            cmd.Parameters.AddWithValue("@Amount", Amount)
            cmd.Parameters.AddWithValue("@Category", Left(Category, 50))
            cmd.Parameters.AddWithValue("@Vendor", Vendor)
            cmd.Parameters.AddWithValue("@Memo", Memo)
            cmd.Parameters.AddWithValue("@companyId", companyId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception

        End Try
    End Function
    Public Shared Async Function NewEmployeeAsync(ByVal sName As String, sLastName As String, ByVal PositionId As Integer, ByVal sEmployee_Code As String,
                                         ByVal sAddress As String, ByVal sAddress2 As String, ByVal sCity As String, ByVal sSate As String,
                                            ByVal sZipCode As String, ByVal sPhone As String, ByVal sCellular As String,
                                            ByVal sEmail As String, ByVal sHourRate As String, ByVal sNotes As String,
                                            ByVal companyId As Integer) As Task(Of Integer)
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "EMPLOYEE_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Email", sEmail)
            cmd.Parameters.AddWithValue("@Name", sName)
            cmd.Parameters.AddWithValue("@LastName", sLastName)
            cmd.Parameters.AddWithValue("@Address", sAddress)
            cmd.Parameters.AddWithValue("@Address2", sAddress2)
            cmd.Parameters.AddWithValue("@City", sCity)
            cmd.Parameters.AddWithValue("@State", sSate)
            cmd.Parameters.AddWithValue("@ZipCode", sZipCode)
            cmd.Parameters.AddWithValue("@Phone", sPhone)
            cmd.Parameters.AddWithValue("@Cellular", sCellular)
            cmd.Parameters.AddWithValue("@starting_Date", Date.Now)
            cmd.Parameters.AddWithValue("@HourRate", sHourRate)
            cmd.Parameters.AddWithValue("@ProducerRate", 1)
            cmd.Parameters.AddWithValue("@Notes", sNotes)
            cmd.Parameters.AddWithValue("@PositionId", PositionId)
            cmd.Parameters.AddWithValue("@companyId", companyId)

            ' Valores Nulos
            cmd.Parameters.AddWithValue("@SS", "")
            cmd.Parameters.AddWithValue("@DOB", DBNull.Value)
            cmd.Parameters.AddWithValue("@Gender", "")
            cmd.Parameters.AddWithValue("@DepartmentId", 0)
            cmd.Parameters.AddWithValue("@Benefits_vacations", 0)
            cmd.Parameters.AddWithValue("@Benefits_personals", 0)

            ' Execute the stored procedure.
            Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            Dim employeeId As Integer = parOUT_ID.Value
            cnn1.Close()

            If Len(sEmployee_Code) > 0 Then
                ExecuteNonQuery(String.Format("UPDATE Employees Set [Employee_Code]= '{0}' WHERE Id={1}", sEmployee_Code, employeeId))
            End If

            Await RefrescarUsuarioVinculadoAsync(sEmail, "Empleados")
            ' Set algunos perminos de inicio
            ExecuteNonQuery("UPDATE [Employees] SET [Allow_OtherEmployeeJobs]=1 WHERE Id=" & employeeId)

            sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewEmployee, companyId, sName)

            Return employeeId
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function NewEmployee(ByVal sName As String, sLastName As String, ByVal PositionId As Integer, ByVal sEmployee_Code As String,
                                         ByVal sAddress As String, ByVal sAddress2 As String, ByVal sCity As String, ByVal sSate As String,
                                            ByVal sZipCode As String, ByVal sPhone As String, ByVal sCellular As String,
                                            ByVal sEmail As String, ByVal sHourRate As String, ByVal sNotes As String,
                                            ByVal companyId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "EMPLOYEE_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Email", sEmail)
            cmd.Parameters.AddWithValue("@Name", sName)
            cmd.Parameters.AddWithValue("@LastName", sLastName)
            cmd.Parameters.AddWithValue("@Address", sAddress)
            cmd.Parameters.AddWithValue("@Address2", sAddress2)
            cmd.Parameters.AddWithValue("@City", sCity)
            cmd.Parameters.AddWithValue("@State", sSate)
            cmd.Parameters.AddWithValue("@ZipCode", sZipCode)
            cmd.Parameters.AddWithValue("@Phone", sPhone)
            cmd.Parameters.AddWithValue("@Cellular", sCellular)
            cmd.Parameters.AddWithValue("@starting_Date", Date.Now)
            cmd.Parameters.AddWithValue("@HourRate", sHourRate)
            cmd.Parameters.AddWithValue("@ProducerRate", 1)
            cmd.Parameters.AddWithValue("@Notes", sNotes)
            cmd.Parameters.AddWithValue("@PositionId", PositionId)
            cmd.Parameters.AddWithValue("@companyId", companyId)

            ' Valores Nulos
            cmd.Parameters.AddWithValue("@SS", "")
            cmd.Parameters.AddWithValue("@DOB", DBNull.Value)
            cmd.Parameters.AddWithValue("@Gender", "")
            cmd.Parameters.AddWithValue("@DepartmentId", 0)
            cmd.Parameters.AddWithValue("@Benefits_vacations", 0)
            cmd.Parameters.AddWithValue("@Benefits_personals", 0)

            ' Execute the stored procedure.
            Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            Dim employeeId As Integer = parOUT_ID.Value
            cnn1.Close()

            If Len(sEmployee_Code) > 0 Then
                ExecuteNonQuery(String.Format("UPDATE Employees Set [Employee_Code]= '{0}' WHERE Id={1}", sEmployee_Code, employeeId))
            End If

            ' Set algunos perminos de inicio
            ExecuteNonQuery("UPDATE [Employees] SET [Allow_OtherEmployeeJobs]=1 WHERE Id=" & employeeId)

            sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewEmployee, companyId, sName)

            Return employeeId
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function IsEmployeeEmail(ByVal sEmail As String, ByVal companyId As Integer) As Boolean
        Return (GetNumericEscalar("SELECT COUNT(*) FROM Employees WHERE companyId=" & companyId & " AND ISNULL(Email,'')='" & sEmail & "'") > 0)
    End Function
    Public Shared Function IsEmployeeEmail(ByVal sEmail As String) As Boolean
        Return (GetNumericEscalar("SELECT COUNT(*) FROM Employees WHERE ISNULL(Email,'')='" & sEmail & "'") > 0)
    End Function

    Public Shared Function IsEmployeeInactive(ByVal sEmail As String, companyId As Integer) As Boolean
        Try
            'If sEmail = "jcarlos@axzes.com" Then
            '    Return False
            'Else
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT ISNULL(Inactive,0) FROM [Employees] WHERE companyId=" & companyId & " and ISNULL(Email,'')='" & sEmail & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                IsEmployeeInactive = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
            'End If

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function IsEmployeeAssignedToJob(jobId As Integer, employeeId As Integer) As Boolean
        Return (GetNumericEscalar("SELECT COUNT(*) FROM Jobs_Employees_assigned WHERE jobId=" & jobId & " and employeeId=" & employeeId) > 0)
    End Function


    Public Shared Function GetEmployeeData(ByVal lId As Long,
                                        ByRef sName As String, ByRef sAddress As String, ByRef sCity As String, ByRef sState As String,
                                            ByRef sZipCode As String, ByRef sPhone As String, ByRef sCellular As String,
                                            ByRef sEmail As String, ByRef sHourRate As String, ByRef sSartingDate As String,
                                            ByRef sSS As String, ByRef sDOB As String, ByRef bInactive As Boolean, ByRef guid As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT * FROM [Employees] WHERE [Id]=" & lId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                sName = rdr("Name").ToString
                sAddress = rdr("Address").ToString
                sCity = rdr("City").ToString
                sState = rdr("Estate").ToString
                sZipCode = rdr("ZipCode").ToString
                sPhone = rdr("Phone").ToString
                sCellular = rdr("Cellular").ToString
                sEmail = rdr("Email").ToString
                sHourRate = rdr("HourRate").ToString
                sSartingDate = "" & rdr("starting_Date").ToString
                sSS = "" & rdr("SS").ToString
                sDOB = "" & rdr("DOB").ToString
                guid = rdr("guid").ToString
                If Len("" & rdr("Inactive")) > 0 Then
                    bInactive = rdr("Inactive")
                Else
                    bInactive = 0
                End If
                GetEmployeeData = True
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetLastCompanyId(ByVal lId As Long) As Double
        Return GetNumericEscalar("SELECT isnull(LastCompanyId,0) as hr FROM [Employees] WHERE [Id]=" & lId)
    End Function

    Public Shared Function SetLastCompanyId(ByVal employeeId As Long, ByRef companyId As String) As Boolean
        Try
            Return ExecuteNonQuery("UPDATE [Employees] SET [LastCompanyId]=" & companyId & " WHERE Id=" & employeeId)
        Catch ex As Exception
        End Try
    End Function

    Public Shared Function GetCompanyDefault(email As String) As String

        Try
            Using conn As SqlConnection = GetConnection()
                Using comm As New SqlCommand("dbo.Company_default_SELECT", conn)
                    comm.CommandType = CommandType.StoredProcedure

                    Dim p0 As New SqlParameter("@Email", SqlDbType.NVarChar)
                    p0.Direction = ParameterDirection.Input
                    p0.Value = email
                    comm.Parameters.Add(p0)

                    Dim reader = comm.ExecuteReader()
                    While reader.Read()
                        If reader.HasRows Then
                            Return reader("companyId").ToString()
                        End If
                    End While
                End Using
            End Using
            Return 0
        Catch e As Exception
            Return 0
        End Try

    End Function

    Public Shared Function GetPositionProperty(positionId As Integer, sProperty As String) As String
        Select Case sProperty
            Case "HourRate"
                ' Valores Numeric
                Return GetNumericEscalar("SELECT isnull([" & sProperty & "],0) FROM Employees_Position where Id=" & positionId)
            Case Else
                Return GetStringEscalar("SELECT isnull([" & sProperty & "],'') FROM Proposal where Id=" & positionId)
        End Select
    End Function

    Public Shared Function GetEmployeeNonRegularHours_count(ByVal employeeId As Integer, NonRegularType As Integer, dateFrom As DateTime, dateTo As DateTime) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "SELECT @Result=isnull(dbo.NonRegularHours_count(@employeeId,@Type,@From,@To),0)"
            cmd.CommandType = CommandType.Text


            ' Set up the input parameter 
            '@objType:  1:Proposal;   1:Job;   3:RFP;    4:Invpoce
            cmd.Parameters.AddWithValue("@employeeId", employeeId)
            cmd.Parameters.AddWithValue("@Type", NonRegularType)
            cmd.Parameters.AddWithValue("@From", dateFrom)
            cmd.Parameters.AddWithValue("@To", dateTo)

            ' Set up the output parameter 
            Dim paramResult As SqlParameter = New SqlParameter("@Result", SqlDbType.Float)
            paramResult.Direction = ParameterDirection.Output
            cmd.Parameters.Add(paramResult)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            Return paramResult.Value.ToString

            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try



    End Function

    Public Shared Function GetEmployeesNumbers(ByVal companyId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT ISNULL(COUNT(*), 0) As Cantidad  FROM [Employees] WHERE companyId=" & companyId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetEmployeesNumbers = rdr("Cantidad")
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetEmployeeId(ByVal sEmail As String, ByVal companyId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim sql As String

            'If sEmail = "jcarlos@axzes.com" Then
            '    'jcarlos@axzes.com PUEDE VER TODAS LAS COMPANIA POR RAZONES DE SOPORTE
            '    sql = "SELECT top 1 Id FROM [Employees] WHERE companyId=" & companyId
            'Else
            sql = "SELECT Id FROM [Employees] WHERE companyId=" & companyId & " AND [Email]='" & sEmail & "'"
            ' End If

            Dim cmd As New SqlCommand(sql, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetEmployeeId = rdr("Id").ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetEmployeeIdFromGUID(EmployeeGUID As String) As Integer
        Dim cnn1 As SqlConnection = GetConnection()
        Dim cmd As New SqlCommand("SELECT ISNULL(Id,0) FROM [Employees] WHERE [guid]=@guid", cnn1)
        cmd.Parameters.AddWithValue("@guid", EmployeeGUID)
        GetEmployeeIdFromGUID = Convert.ToDouble(cmd.ExecuteScalar())
        cnn1.Close()
    End Function


    Public Shared Function GetEmployeeIdFromLastFirstName(ByVal FirstName As String, ByVal LastName As String, ByVal companyId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Id FROM [Employees] WHERE companyId=" & companyId & " and Name='" & FirstName & "' and LastName='" & LastName & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetEmployeeIdFromLastFirstName = rdr("Id").ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function GetEmployeeIdFromLastNameCommaFirstName(ByVal LastNameCommaFirstName As String, ByVal companyId As Integer) As Integer
        'Try
        '    Dim cnn1 As SqlConnection = GetConnection()
        '    Dim cmd As New SqlCommand("SELECT Id FROM [Employees] WHERE companyId=" & companyId & " and [LastName]+', '+[Name]='" & LastNameCommaFirstName & "'", cnn1)
        '    Dim rdr As SqlDataReader
        '    rdr = cmd.ExecuteReader
        '    rdr.Read()
        '    If rdr.HasRows Then
        '        GetEmployeeIdFromLastNameCommaFirstName = rdr("Id").ToString
        '    End If
        '    rdr.Close()
        '    cnn1.Close()
        'Catch ex As Exception
        '    Throw ex
        'End Try
        'LastNameCommaFirstName = Replace(LastNameCommaFirstName, ".", "")
        Return GetNumericEscalar($"SELECT Id FROM [Employees] WHERE companyId={companyId} and [LastName]+', '+[Name]='{LastNameCommaFirstName}'")

    End Function

    Public Shared Function GetEmployeeFullName(ByVal sEmail As String, scompanyId As String) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand($"SELECT [FullName] FROM [Employees] WHERE [Email]='{sEmail}' and companyId = {scompanyId}", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetEmployeeFullName = "" & rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetEmployeeName(ByVal lId As Integer) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT [FullName] FROM [Employees] WHERE [Id]=" & lId, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetEmployeeName = "" & rdr("FullName").ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetEmployeePermission(ByVal EmployeesId As Integer, sOpcion As String) As Boolean
        Try
            Dim Val As Boolean = LocalAPI.GetNumericEscalar($"select isnull([{sOpcion}],0) from [Employees] where [Id]={EmployeesId}")

            If sOpcion.Contains("Deny_") Then
                Return Not Val
            Else
                Return Val
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ''' <summary>
    ''' Dynamically builds a SQL query to fetch permissions columns and map them
    ''' into a Dictionary for further usage. This function is meant to save multiple
    ''' DB calls and therefore boost whole performance.
    ''' </summary>
    ''' <param name="employeeId">Employee's Identifier</param>
    ''' <returns>Dictionary with ("ColumnName", bool) representing employee's permissions</returns>
    Public Shared Function GetEmployeePermissions(ByVal employeeId As Integer) As Dictionary(Of String, Boolean)
        Try

            Dim result = New Dictionary(Of String, Boolean)()

            Dim query = "
            DECLARE @query NVARCHAR(4000);
            DECLARE @parmDefinition NVARCHAR(500);

            SET @parmDefinition = N'@id int';

            SELECT
                @query = CONCAT(
                            'SELECT ',
                            STRING_AGG(CONCAT('[', COLUMN_NAME, ']'), ', '),
                            ' FROM [dbo].[Employees] WHERE [ID] = @id')
            FROM 
                INFORMATION_SCHEMA.COLUMNS
            WHERE 
                TABLE_SCHEMA = 'dbo'
                AND TABLE_NAME = 'Employees'
                AND (COLUMN_NAME LIKE 'Deny%' OR COLUMN_NAME LIKE 'Allow%')


            EXECUTE sp_executesql @query, @parmDefinition, @id=@employeeId
            "
            Using cnn As SqlConnection = GetOpenConnection()
                Try
                    cnn.Open()
                    Dim cmd = New SqlCommand(query, cnn)
                    cmd.Parameters.AddWithValue("@employeeId", employeeId)
                    Using rdr As SqlDataReader = cmd.ExecuteReader()
                        rdr.Read()
                        If rdr.HasRows Then
                            result = Enumerable.Range(0, rdr.FieldCount).ToDictionary(Of String, Boolean)(Function(i) rdr.GetName(i), Function(i) IIf(TypeOf rdr.GetValue(i) Is DBNull, 0, rdr.GetValue(i)))
                        End If
                    End Using
                Catch e As Exception
                    Throw e
                End Try
            End Using

            Return result
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function EmployeePageTracking(ByVal EmployeeId As Integer, ByVal Page As String) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "sys_EmployeePageTracking_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@employeeId", EmployeeId)
            cmd.Parameters.AddWithValue("@Page", Page)

            cmd.ExecuteNonQuery()

            cnn1.Close()
            Return True
        Catch ex As Exception

        End Try
    End Function
    Public Shared Function GetEmployeeEmail(ByVal lId As Integer) As String
        Return GetStringEscalar("SELECT Email FROM [Employees] WHERE [Id]=" & lId.ToString)
    End Function

    Public Shared Function GetEmployeeEmail(ByVal sName As String) As String
        Return GetStringEscalar("SELECT Email FROM [Employees] WHERE [Name]='" & sName & "'")
    End Function

    Public Shared Function GetEmployeeHoursPerJob(ByVal sEmail As String, ByVal lJob As Integer) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT SUM(Employees_time.Time) AS TotalTime  " &
                                            "FROM Employees_time INNER JOIN Employees ON Employees_time.Employee = Employees.Id " &
                                        "WHERE Employees.Email='" & sEmail & "' AND Employees_time.Job=" & lJob.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                If Len(rdr("TotalTime").ToString) > 0 Then GetEmployeeHoursPerJob = rdr("TotalTime").ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetEmployeeHoursPerJob(ByVal EmployeeId As Integer, ByVal lJob As Integer, ByVal sFecha As String) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT isnull(SUM(Time),0) as Total FROM Employees_time " &
                                        "WHERE Employee=" & EmployeeId.ToString &
                                        " AND job=" & lJob.ToString &
                                        " AND Fecha=" & GetFecha_102(sFecha), cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetEmployeeHoursPerJob = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetEmployeeHoursDay(ByVal lEmployeeId As Integer, ByVal sFecha As String, ByVal bQuincena As Boolean, ByRef sRangoFechas As String) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand
            If bQuincena Then
                Dim sFecDes As String, sFecHas As String
                Dim companyId As Integer = GetEmployeeProperty(lEmployeeId, "companyId")
                GetWeeklyDates(cnn1, sFecha, sFecDes, sFecHas, companyId)
                cmd = New SqlCommand("SELECT SUM(Employees_time.Time) AS TotalTime FROM Employees_time " &
                                          "WHERE Employee=" & lEmployeeId &
                                               " AND Fecha>=" & GetFecha_102(sFecDes) & " AND Fecha<=" & GetFecha_102(sFecHas), cnn1)
                sRangoFechas = "'" & GetFechaCorta(sFecDes) & "' to '" & GetFechaCorta(sFecHas) & "'"
            Else
                cmd = New SqlCommand("SELECT SUM(Employees_time.Time) AS TotalTime FROM Employees_time " &
                                            "WHERE Employee=" & lEmployeeId &
                                               " AND Fecha=" & GetFecha_102(sFecha), cnn1)
                sRangoFechas = GetFechaCorta(sFecha)
            End If
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                If Len(rdr("TotalTime").ToString) > 0 Then GetEmployeeHoursDay = FormatNumber(rdr("TotalTime").ToString, 2)
            End If
            rdr.Close()
            cnn1.Close()
            If Len(GetEmployeeHoursDay) = 0 Then GetEmployeeHoursDay = "0"
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetEmployeeNoCollectedInvoiceNumber(ByVal lEmployeeId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT COUNT(*) AS Expr1 FROM Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id " &
                                      "WHERE (ISNULL(Invoices.AmountDue, 0) > 0) AND Jobs.Employee=" & lEmployeeId.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetEmployeeNoCollectedInvoiceNumber = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Shared Function GetEmployeePassword(ByVal sUserEmail As String) As String
        Try
            'Dim user As MembershipUser = Membership.GetUser(Membership.GetUserNameByEmail(sUserEmail))
            'Dim sUserName As String = user.UserName
            'Dim cnn1 As SqlConnection = GetUsersConnection()
            'Dim sPassword As String = ""
            'Dim cmd As New SqlCommand("SELECT TOP 1 PasswordFormat FROM aspnet_Membership WHERE Email='" & sUserEmail & "'", cnn1)
            'Dim rdr As SqlDataReader
            'rdr = cmd.ExecuteReader
            'rdr.Read()
            'If rdr.HasRows Then
            '    If rdr("PasswordFormat").ToString = MembershipPasswordFormat.Encrypted Then
            '        ' El usuario ya tiene el Password tipo "Encrypted", podemos leerlo
            '        sPassword = user.GetPassword()
            '    Else
            '        sPassword = CreateUserPassword()
            '    End If
            'End If
            'rdr.Close()
            'cnn1.Close()

            GetEmployeePassword = "Password de Prueba"
        Catch ex As Exception
            ' Si hay error, en ultima instancia devolver el Id como password.
            Throw ex
        End Try
    End Function

    Public Shared Function GetEmployeeNonRegularHoursType(ByVal EmployeeId As Integer, ByVal lType As Integer, ByVal sFecha As String) As Double
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT isnull(SUM(Hours),0) as Total FROM  Employees_NonRegularHours " &
                                        "WHERE EmployeeId=" & EmployeeId.ToString &
                                        " AND " & GetFecha_102(sFecha) & ">=DateFrom " &
                                        " AND " & GetFecha_102(sFecha) & "<=DateTo " &
                                        " AND Type=" & lType, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetEmployeeNonRegularHoursType = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetJobs_Employees_Hours_assigned(ByVal jobId As Long) As Double
        Return GetNumericEscalar("SELECT sum(ISNULL(Hours,0)) FROM [Jobs_Employees_assigned] WHERE [jobId]=" & jobId)
    End Function
    Public Shared Function GetJobs_Employees_HoursXHourRate_assigned(ByVal jobId As Long) As Double
        Return GetNumericEscalar("SELECT sum(ISNULL(Hours,0)*isnull(HourRate,0)) FROM [Jobs_Employees_assigned] WHERE [jobId]=" & jobId)
    End Function
    Public Shared Function GetEmployeeHourRate(ByVal employeeId As Long) As Double
        Try
            '************COSTE POR HORA DEL EMPLOYEE x MULTIPLIER ************************
            Return GetNumericEscalar(String.Format("select dbo.EmployeeHourRate({0})", employeeId))

        Catch ex As Exception

        End Try
    End Function

    Public Shared Function GetEmployeeAssignedHourRate(jobId As Integer, ByVal employeeId As Long) As Double
        Try
            '************ Rate of Position of Employee in Job ************************
            Return GetNumericEscalar($"select dbo.EmployeeAssignedHourRate({jobId},{employeeId})")

        Catch ex As Exception

        End Try
    End Function

    Public Shared Function GetEmployeeJobPositionHourRate(jobId As Integer, ByVal employeeId As Long) As Double
        Try
            '************ Rate of Position of Employee in Job ************************
            Return GetNumericEscalar($"select dbo.EmployeeJobPositionHourRate({jobId},{employeeId})")

        Catch ex As Exception

        End Try
    End Function

    Public Shared Function GetWeeklyHoursByEmp(ByVal employeeId As Integer, companyId As Integer) As Double
        Return GetNumericEscalar($"SELECT dbo.WeeklyHoursByEmp({employeeId},{companyId},dbo.CurrentTimeZone({companyId}))")
    End Function
    Public Shared Function GetWeeklyHoursByEmpExt(ByVal employeeId As Integer, companyId As Integer, DateInWeek As Date) As Double
        Return GetNumericEscalar("Select dbo.WeeklyHoursByEmp(" & employeeId & "," & companyId & "," & GetFecha_102(DateInWeek) & ")")
    End Function
    Public Shared Function GetBiWeeklyHoursByEmp(ByVal employeeId As Integer, companyId As Integer) As Double
        Return GetNumericEscalar($"Select dbo.BiWeeklyHoursByEmp({employeeId},{companyId},dbo.CurrentTimeZone({companyId}))")
    End Function

    Public Shared Function GetEmployeeRoleId(ByVal RoleName As String, companyId As Integer) As Integer
        Return GetNumericEscalar("Select top 1 Id from [Employees_roles] where [Name]='" & RoleName & "' and companyId=" & companyId)
    End Function

    Public Shared Function SetEmployee_IPv4_UPDATE(ByVal lId As Long, IPv4 As String) As Boolean
        Return ExecuteNonQuery($"UPDATE [Employees] SET [URLFirewall]='{IPv4}' WHERE Id={lId}")
    End Function


    Public Shared Function GetEmployeeProperty(ByVal lId As Long, ByRef sProperty As String) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim sSQL As String
            Dim ret As String = ""

            ' Analisis del tipo de dato de retorno
            Select Case sProperty
                Case "DepartmentId", "companyId", "Inactive", "HourRate", "Benefits_vacations", "Benefits_personals", "PositionId"
                    'Enteros
                    sSQL = "SELECT ISNULL(" & sProperty & ",0) FROM [Employees] WHERE [Id]=" & lId

                Case "RadScheduler_Default_View", "RadScheduler_JobEdit_View", "FilterJob_Employee", "FilterJob_Department", "FilterProposal_Department",
                     "Benefits_vacations", "Benefits_personals"
                    ' Enteros  Null es -1
                    sSQL = "SELECT ISNULL(" & sProperty & ",-1) FROM [Employees] WHERE [Id]=" & lId
                Case "FilterJob_Year", "FilterProposal_Year"
                    ' Enteros Null es 0
                    sSQL = "SELECT ISNULL(" & sProperty & "," & GetDateTime().Year & ") FROM [Employees] WHERE [Id]=" & lId
                Case "FilterJob_Month", "FilterProposal_Month"
                    ' Enteros Null es 30
                    sSQL = "SELECT ISNULL(" & sProperty & "," & GetDateTime().Month & ") FROM [Employees] WHERE [Id]=" & lId
                Case Else
                    ' String
                    sSQL = "SELECT ISNULL(" & sProperty & ",'') FROM [Employees] WHERE [Id]=" & lId
            End Select

            Dim cmd As New SqlCommand(sSQL, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                Select Case sProperty
                    Case "RadScheduler_Default_View", "RadScheduler_JobEdit_View"
                        Select Case rdr(0)
                            Case 0
                                ret = SchedulerViewType.DayView
                            Case 1
                                ret = SchedulerViewType.WeekView
                            Case 2
                                ret = SchedulerViewType.MonthView
                            Case 3
                                ret = SchedulerViewType.TimelineView
                            Case 4
                                ret = SchedulerViewType.MultiDayView
                            Case 5
                                ret = SchedulerViewType.AgendaView
                            Case Else
                                ret = rdr(0).ToString()
                        End Select


                    Case Else

                        ret = rdr(0).ToString
                End Select
            End If
            rdr.Close()
            cnn1.Close()

            Return ret

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetRoleProperty(ByVal lId As Long, ByRef sProperty As String) As String
        Try
            Select Case sProperty
                Case "companyId"
                    'Enteros
                    Return GetNumericEscalar("SELECT ISNULL(" & sProperty & ",0) FROM [Employees_roles] WHERE [Id]=" & lId)
                Case Else
                    ' String
                    Return GetStringEscalar("SELECT ISNULL(" & sProperty & ",'') FROM [Employees_roles] WHERE [Id]=" & lId)
            End Select

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function GetEmployeeDockCollapsed(ByVal lId As Long, DockProperty As String) As Boolean
        Return GetNumericEscalar("SELECT ISNULL(" & DockProperty & ",0) FROM [Employees] WHERE [Id]=" & lId)
    End Function
    Public Shared Function SetEmployeeDockCollapsed(ByVal lId As Long, DockProperty As String, Value As Boolean) As Boolean
        Return ExecuteNonQuery("UPDATE [Employees] SET [" & DockProperty & "]=" & IIf(Value, 1, 0) & " WHERE Id=" & lId)
    End Function

    Public Shared Function SetEmployeeIntegerProperty(ByVal lId As Long, ByRef sProperty As String, nValue As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "UPDATE [Employees] SET [" & sProperty & "]=" & nValue & " WHERE Id=" & lId.ToString
            cmd.ExecuteNonQuery()
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function GetEmployeeHomePage(ByVal employeeId As Long) As String
        Try
            Return GetStringEscalar("SELECT ISNULL([MyHomePage],'Default.aspx') FROM [Employees] WHERE Id=" & employeeId)
        Catch ex As Exception
        End Try
    End Function

    Public Shared Function GetEmployeePosition(ByVal employeeId As Long) As String
        Try
            Return GetStringEscalar("SELECT Employees_Position.Name FROM Employees inner join Employees_Position on Employees.PositionId=Employees_Position.Id  WHERE Employees.Id=" & employeeId)
        Catch ex As Exception
        End Try
    End Function

    Public Shared Function SetEmployeeHomePage(ByVal employeeId As Long, ByRef sPage As String) As Boolean
        Try
            Return ExecuteNonQuery("UPDATE [Employees] SET [MyHomePage]='" & sPage & "' WHERE Id=" & employeeId)
        Catch ex As Exception
        End Try
    End Function
    ' #Region End ###########################################################################################

    Public Shared Function UpdateEmployeeTAGS(contactId As Integer, NewTag As String) As Boolean
        Dim sTags As String = GetStringEscalar("select top 1 isnull(TAGS,'') from [Employees] where Id=" & contactId)
        If Len(sTags) = 0 Then
            sTags = NewTag
        Else
            sTags = Left(sTags & "," & NewTag, 80)
        End If
        ExecuteNonQuery("UPDATE Employees SET TAGS='" & sTags & "' WHERE Id=" & contactId)
    End Function

#End Region

#Region "MarketingCampaign"
    Public Shared Function IsCampaign(ByVal Name As String, ByVal companyId As Integer) As Boolean
        Return (GetNumericEscalar("SELECT COUNT(*) FROM Clients_MarketingCampaign WHERE companyId=" & companyId & " AND ISNULL(Name,'')='" & Name & "'") > 0)
    End Function

    Public Shared Function GetMarketingCampaignProperty(ByRef MarketingCampaignId As Integer, ByVal sProperty As String) As String
        Return GetStringEscalar("SELECT TOP 1 [" & sProperty & "] FROM [Clients_MarketingCampaign] where [Id]=" & MarketingCampaignId)
    End Function

#End Region

#Region "Clients"

    Public Shared Function IsClientNotification(ByVal clientId As Integer, NotificationField As String) As Boolean
        Try

            Return GetNumericEscalar("SELECT ISNULL(" & NotificationField & ",0) FROM [Clients] WHERE Id=" & clientId)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function ClientFilesCount(clientId As Integer) As String
        Dim nRecs As Integer = GetNumericEscalar("select dbo.ClientFilesCount(" & clientId & ")")
        Return IIf(nRecs = 0, "", nRecs)
    End Function
    Public Shared Function IsClientAllowSMS(ByVal clientId As Integer) As Boolean
        Try

            Return GetNumericEscalar("SELECT ISNULL(Allow_SMSnotification,0) FROM [Clients] WHERE Id=" & clientId)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function SetClientCollectionCloseOpen(ByVal clientcollectionId As Integer) As Boolean
        Return ExecuteNonQuery(String.Format("update Clients_collection set DateOut = case when DateOut Is Null then dbo.CurrentTime() else Null end where Id={0}", clientcollectionId))
    End Function

    Public Shared Function Clients_activities_INSERT(ByVal clientId As Integer, CRUD As String, SourceTable As String, sourceId As Integer, employeeId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "Clients_activities_INSERT"
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@clientId", clientId)
            cmd.Parameters.AddWithValue("@CRUD", CRUD)
            cmd.Parameters.AddWithValue("@SourceTable", SourceTable)
            cmd.Parameters.AddWithValue("@sourceId", sourceId)
            cmd.Parameters.AddWithValue("@employeeId", employeeId)

            cmd.ExecuteNonQuery()

            cnn1.Close()
            Return True
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function SetClientAvailability(ByVal clientId As Integer, AvailabilityId As Integer) As Boolean
        Return ExecuteNonQuery("UPDATE [Clients] SET [AvailabilityId]=" & AvailabilityId & " WHERE Id=" & clientId)
    End Function


    Public Shared Function GetClientTypeId(sTypeName As String, companyId As Integer) As Integer
        Try
            Return GetNumericEscalar("select top 1 Id from [Clients_types] where Name='" & sTypeName & "' and companyId=" & companyId)

        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Shared Function ClientAddUpdatePhoto(ClientId As Integer, PhotoURL As String, ContentType As String, sDate As DateTime) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Clients_AddUpdatePhoto"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@ClientId", ClientId)
            cmd.Parameters.AddWithValue("@PhotoURL", PhotoURL)
            cmd.Parameters.AddWithValue("@ContentType", ContentType)
            cmd.Parameters.AddWithValue("@Date", sDate)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function NewClients_visitslog(entityTypeId As String, entityId As Integer, IP As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Clients_visitslog_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@entityType", entityTypeId)
            cmd.Parameters.AddWithValue("@entityId", entityId)
            cmd.Parameters.AddWithValue("IP", IP)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function GetClientPhotoURL(ClientId As Integer) As String
        Try
            Dim sQuery = "SELECT PhotoURL FROM [dbo].[Clients_Photo] WHERE ClientId=" & ClientId
            Dim url = GetStringEscalar(sQuery)
            If IsNothing(url) Or Len(url) = 0 Then
                Return "~/Images/Clients/nophoto.jpg"
            End If
            Return url
        Catch ex As Exception
        End Try
    End Function

    Public Shared Function GetClientSubtypeId(sSubtypeName As String, companyId As Integer) As Integer
        Try
            Return GetNumericEscalar("select top 1 Id from [Clients_subtypes] where Name='" & sSubtypeName & "' and typeId in (select Id from Clients_types where companyId=" & companyId & ")")

        Catch ex As Exception
            Return 0
        End Try
    End Function
    Public Shared Function ExportClients(context As HttpContext, FileName As String, Separator As String) As Integer
        Try
            Dim myCsv As New StringBuilder()
            Dim sRow As String

            context.Response.Clear()
            context.Response.ContentType = "text/csv"
            context.Response.Charset = "UTF-8"
            context.Response.ContentEncoding = Encoding.UTF8
            context.Response.AddHeader("Content-Disposition", "attachment; filename=" & FileName)

            ' Cabeceras
            myCsv.AppendFormat("Name" & Separator & "Company" & Separator & "Email" & Separator & "Phone" & Separator & "Mobile" & Separator & "Fax" & Separator & "Website" & Separator & "Street" & Separator & "City" & Separator & "State" & Separator & "ZIP" & Separator & "Country")
            myCsv.Append(vbCrLf)

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Name, ISNULL(Company,' ') AS Company, ISNULL(Email,' ') AS Email, ISNULL(Phone,' ') AS Phone, ISNULL(Cellular,' ') AS Mobile, ISNULL(Fax,' ') AS Fax, ISNULL(Web,' ') AS Website, ISNULL(Address,' ') AS Street, ISNULL(City,' ') AS City, ISNULL(State,' ') AS State, ISNULL(ZipCode,' ') AS Zip, 'United States' AS Country FROM Clients where companyId=" & context.Session("companyId"), cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            While rdr.Read()
                sRow = ""
                If rdr.HasRows Then
                    sRow = sRow & Replace(rdr("Name"), Separator, "") & Separator
                    sRow = sRow & Replace(rdr("Company"), Separator, "") & Separator
                    sRow = sRow & Replace(rdr("Email"), Separator, "") & Separator
                    sRow = sRow & Replace(rdr("Phone"), Separator, "") & Separator
                    sRow = sRow & Replace(rdr("Mobile"), Separator, "") & Separator
                    sRow = sRow & Replace(rdr("Fax"), Separator, "") & Separator
                    sRow = sRow & Replace(rdr("Website"), Separator, "") & Separator
                    sRow = sRow & Replace(rdr("Street"), Separator, "") & Separator
                    sRow = sRow & Replace(rdr("City"), Separator, "") & Separator
                    sRow = sRow & Replace(rdr("State"), Separator, "") & Separator
                    sRow = sRow & Replace(rdr("Zip"), Separator, "") & Separator
                    sRow = sRow & Replace(rdr("Country"), Separator, "")
                    myCsv.AppendFormat(sRow)
                    myCsv.Append(vbCrLf)
                End If
            End While
            context.Response.Write(myCsv.ToString())
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try


        context.Response.End()
    End Function


    Public Shared Function UpdateClientTAGS(contactId As Integer, NewTag As String) As Boolean
        Dim sTags As String = GetStringEscalar("select top 1 isnull(TAGS,'') from [Clients] where Id=" & contactId)
        If Len(sTags) = 0 Then
            sTags = NewTag
        Else
            sTags = Left(sTags & "," & NewTag, 80)
        End If
        ExecuteNonQuery("UPDATE Clients SET TAGS='" & sTags & "' WHERE Id=" & contactId)
    End Function

#End Region

#Region "SubConsultants"

    Public Shared Function GetCompanyIdFromSubconsultan(ByVal sSubConsultanEmail As String) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT TOP 1 [companyId] FROM [SubConsultans] WHERE [Email]='" & sSubConsultanEmail & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetCompanyIdFromSubconsultan = rdr(0)
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function IsSubConsultanEmail(ByVal sEmail As String, ByVal companyId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Id FROM [SubConsultans] WHERE companyId=" & companyId & " AND  ISNULL(Email,'')='" & sEmail & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            IsSubConsultanEmail = rdr.HasRows
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetSubConsultanName(ByVal sEmail As String) As String
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT top 1 Name FROM [SubConsultans] WHERE [Email]='" & sEmail & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetSubConsultanName = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetSubConsultanId(ByVal sEmail As String, ByVal companyId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Id FROM [SubConsultans] WHERE companyId=" & companyId & " AND [Email]='" & sEmail & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetSubConsultanId = rdr("Id").ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetSubConsultanId(ByVal sEmail As String) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT top 1 Id FROM [SubConsultans] WHERE [Email]='" & sEmail & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetSubConsultanId = rdr("Id").ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function SubConsultanEmailPrivateLink(ByVal SubConsultanId As Integer, ByVal companyId As Integer) As Boolean
        Try
            Dim SunconsultantObject = GetRecord(SubConsultanId, "SUBCONSULTANT_Form_SELECT")


            Dim sFullBody As New System.Text.StringBuilder
            sFullBody.Append("Dear " & SunconsultantObject("Name"))
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("This Email contains a private link for access to your PASconcept Subconsultant Portal, where you will be able to receive and respond to Requests For Proposals as a potential Subconsultant to <strong>" & LocalAPI.GetCompanyProperty(companyId, "Name") & "</strong>.")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("To access your private Portal, ")
            sFullBody.Append("<a href=" & """" & GetSharedLink_URL(2001, SubConsultanId) & """" & ">click here</a>")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("Please consider bookmarking the page for future use. ")
            sFullBody.Append("<br />")
            sFullBody.Append("If you have any questions or require additional information, please contact us.")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("Thank you,")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("<a href=" & """" & GetHostAppSite() & """" & ">PASconcept</a> Notification")
            sFullBody.Append("<br />")
            sFullBody.Append(LocalAPI.GetPASSign())
            Try
                SendGrid.Email.SendMail(SunconsultantObject("Email").ToString, "", "", "PASconcept Private Portal", sFullBody.ToString, companyId, 0, 0, LocalAPI.GetCompanyProperty(companyId, "Email"), LocalAPI.GetCompanyProperty(companyId, "Name"))
            Finally
            End Try

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetSubConsultanPassword_old(ByVal sUserEmail As String) As String
        Try
            Dim user As MembershipUser = Membership.GetUser(Membership.GetUserNameByEmail(sUserEmail))
            Dim sUserName As String = user.UserName
            Dim cnn1 As SqlConnection = GetUsersConnection()
            Dim sPassword As String = ""
            Dim cmd As New SqlCommand("SELECT TOP 1 PasswordFormat FROM aspnet_Membership WHERE Email='" & sUserEmail & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                If rdr("PasswordFormat").ToString = MembershipPasswordFormat.Encrypted Then
                    ' El usuario tiene el Password tipo "Encrypted", podemos leerlo
                    sPassword = user.GetPassword()
                End If
            End If
            rdr.Close()
            cnn1.Close()

            Return sPassword

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function IsSubConsultanInitials(ByVal sInitials As String, ByVal companyId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT Id FROM [SubConsultans] WHERE [Code]='" & sInitials & "' AND companyId='" & companyId & "'", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            IsSubConsultanInitials = rdr.HasRows
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function Subconsultant_INSERT(ByVal sName As String, ByVal sEmail As String, ByVal sInitials As String,
                                        ByVal companyId As Integer,
                                        Optional ByVal disciplineId As Integer = 0,
                                        Optional ByVal sOrganization As String = "",
                                        Optional ByVal sAddress As String = "",
                                        Optional ByVal sAddress2 As String = "",
                                        Optional ByVal sCity As String = "",
                                        Optional ByVal sState As String = "",
                                        Optional ByVal sZipCode As String = "",
                                        Optional ByVal sPhone As String = "",
                                        Optional ByVal sCellular As String = "",
                                        Optional ByVal sFax As String = "",
                                        Optional ByVal sWeb As String = "",
                                        Optional ByVal sStartingDate As String = "",
                                        Optional ByVal sPosition As String = "",
                                        Optional ByVal sBillingContact As String = "",
                                        Optional ByVal sBillingTelephone As String = "",
                                        Optional ByVal sNotes As String = "",
                                        Optional ByVal NAICS_code As String = "") As Integer
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Subconsultant_v20_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Name", sName)
            cmd.Parameters.AddWithValue("@Position", sPosition)
            cmd.Parameters.AddWithValue("@Email", sEmail)
            cmd.Parameters.AddWithValue("@Initials", sInitials)
            cmd.Parameters.AddWithValue("@disciplineId", disciplineId)
            cmd.Parameters.AddWithValue("@Organization", sOrganization)
            cmd.Parameters.AddWithValue("@Phone", sPhone)
            cmd.Parameters.AddWithValue("@Cellular", sCellular)
            cmd.Parameters.AddWithValue("@Fax", sFax)
            cmd.Parameters.AddWithValue("@Web", sWeb)
            cmd.Parameters.AddWithValue("@StartingDate", sStartingDate)
            cmd.Parameters.AddWithValue("@Address", sAddress)
            cmd.Parameters.AddWithValue("@Address2", sAddress2)
            cmd.Parameters.AddWithValue("@City", sCity)
            cmd.Parameters.AddWithValue("@State", sState)
            cmd.Parameters.AddWithValue("@ZipCode", sZipCode)
            cmd.Parameters.AddWithValue("@Billing_contact", sBillingContact)
            cmd.Parameters.AddWithValue("@Billing_Telephone", sBillingTelephone)
            cmd.Parameters.AddWithValue("@Notes", sNotes)
            cmd.Parameters.AddWithValue("@NAICS_code", NAICS_code)

            cmd.Parameters.AddWithValue("@companyId", companyId)

            ' Execute the stored procedure.
            Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            Return parOUT_ID.Value
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try

    End Function
    Public Shared Function NuevoSubConsultan_olg(ByVal sName As String, ByVal sEmail As String, ByVal sInitials As String,
                                        ByVal companyId As Integer,
                                        Optional ByVal disciplineId As Integer = 0,
                                        Optional ByVal sOrganization As String = "",
                                        Optional ByVal sAddress As String = "",
                                        Optional ByVal sAddress2 As String = "",
                                        Optional ByVal sCity As String = "",
                                        Optional ByVal sState As String = "",
                                        Optional ByVal sZipCode As String = "",
                                        Optional ByVal sPhone As String = "",
                                        Optional ByVal sCellular As String = "",
                                        Optional ByVal sFax As String = "",
                                        Optional ByVal sWeb As String = "",
                                        Optional ByVal sStartingDate As String = "",
                                        Optional ByVal sPosition As String = "",
                                        Optional ByVal sBillingContact As String = "",
                                        Optional ByVal sBillingTelephone As String = "",
                                        Optional ByVal sNotes As String = "") As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' SubConsultanEmail
            If Len(sStartingDate) = 0 Then sStartingDate = Today.Date
            cmd.CommandText = "INSERT INTO [SubConsultans] ([Name], [Position], [Email], [Code], [disciplineId], [Organization], [Address], [Address2], [City], [State], [ZipCode], [Telephone], [CellPhone], [Fascimile], [WebPage], [DateCreated],[companyId], [Billing_contact], [Billing_Telephone], [Notes]) " &
                                                    "VALUES ('" &
                                                        sName & "','" &
                                                        sPosition & "','" &
                                                        sEmail & "','" &
                                                        sInitials & "'," &
                                                        disciplineId & ",'" &
                                                        sOrganization & "','" &
                                                        sAddress & "','" &
                                                        sAddress2 & "','" &
                                                        sCity & "','" &
                                                        sState & "','" &
                                                        sZipCode & "','" &
                                                        sPhone & "','" &
                                                        sCellular & "','" &
                                                        sFax & "','" &
                                                        sWeb & "'," &
                                                        GetFecha_102(sStartingDate) & "," &
                                                        companyId & ",'" &
                                                        sBillingContact & "','" &
                                                        sBillingTelephone & "','" &
                                                        sNotes & "')"

            cmd.ExecuteNonQuery()
            cnn1.Close()

            RefrescarUsuarioVinculadoAsync(sEmail, "Subconsultans")

            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewSubconsultan, companyId, sName)

            Return GetSubConsultanId(sEmail, companyId)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function IsSubconsultantEmail(ByVal sEmail As String, ByVal companyId As Integer) As Boolean
        Return (GetNumericEscalar("SELECT COUNT(*) FROM SubConsultans WHERE companyId=" & companyId & " AND ISNULL(Email,'')='" & sEmail & "'") > 0)
    End Function

    Public Shared Function GetSubconsultantProperty(ByVal subconsultantId As Long, ByVal sProperty As String) As String
        Try
            Select Case sProperty
                Case "disciplineId", "companyId"
                    Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],0) FROM [SubConsultans] WHERE [Id]=" & subconsultantId)

                Case Else
                    Return GetStringEscalar("SELECT ISNULL([" & sProperty & "],'') FROM [SubConsultans] WHERE [Id]=" & subconsultantId)

            End Select
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetSubconsultantIdFromGUID(SubConsultantGUID As String) As Integer
        'Inject SQL!!!!Return GetNumericEscalar("SELECT ISNULL(Id,0) FROM [SubConsultans] WHERE [guid]='" & SubConsultantGUID & "'")
        Dim cnn1 As SqlConnection = GetConnection()
        Dim cmd As New SqlCommand("SELECT ISNULL(Id,0) FROM [SubConsultans] WHERE [guid]=@guid", cnn1)
        cmd.Parameters.AddWithValue("@guid", SubConsultantGUID)
        GetSubconsultantIdFromGUID = Convert.ToDouble(cmd.ExecuteScalar())
        cnn1.Close()

    End Function

    Public Shared Function GetSubConsultanEmail(ByVal lSubConsultanId As Integer) As String
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("SELECT [Email] FROM [SubConsultans] WHERE Id=" & lSubConsultanId.ToString, cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            rdr.Read()
            If rdr.HasRows Then
                GetSubConsultanEmail = rdr(0).ToString
            End If
            rdr.Close()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function IsSubconsultantNotification(ByVal subconsultatId As Integer, NotificationField As String) As Boolean
        Try

            Return GetNumericEscalar("SELECT ISNULL(" & NotificationField & ",0) FROM [SubConsultans] WHERE Id=" & subconsultatId)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function UpdateSubConsultanTAGS(contactId As Integer, NewTag As String) As Boolean
        Dim sTags As String = GetStringEscalar("select top 1 isnull(TAGS,'') from [SubConsultans] where Id=" & contactId)
        If Len(sTags) = 0 Then
            sTags = NewTag
        Else
            sTags = Left(sTags & "," & NewTag, 80)
        End If
        ExecuteNonQuery("UPDATE SubConsultans SET TAGS='" & sTags & "' WHERE Id=" & contactId)
    End Function


#End Region

#Region "Appointments"
    Public Shared Function GetAppointmentsProperty(ByVal lId As Long, ByRef sProperty As String) As String
        Try
            Select Case sProperty
                Case "ClientId", "JobId", "EmployeeId", "companyId", "proposaldetalleId"
                    ' Valores Integer
                    Return GetNumericEscalar("Select ISNULL(" & sProperty & ",0) FROM Appointments WHERE Id=" & lId)
                Case Else
                    Return GetStringEscalar("Select ISNULL(" & sProperty & ",'') FROM Appointments WHERE Id=" & lId)
            End Select

        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function UpdateProposaltaskIdAppointment(ByVal lId As Integer, proposaldetalleId As Integer) As Boolean
        Return ExecuteNonQuery("UPDATE [Appointments] SET proposaldetalleId=" & proposaldetalleId & " WHERE Id=" & lId)
    End Function
#End Region

#Region "Version"

    Public Shared Function sys_VersionId(ByVal companyId As Integer) As Integer
        Return GetNumericEscalar("Select ISNULL(version,0) FROM Company WHERE companyId=" & companyId)
    End Function

    Public Shared Function sys_VersionName(versionId As Integer) As String
        Return (GetStringEscalar("Select Name FROM sys_Versiones WHERE Id=" & versionId)).ToUpper
    End Function

    Public Shared Function sys_VersionName() As String
        Return sys_VersionName(HttpContext.Current.Session("Version"))
    End Function

    Public Shared Function sys_CaracteristicaVisible(ByVal caracteristicaId As Integer, versionId As Integer) As Boolean
        Return GetStringEscalar("Select dbo.VisibleCaracteristica(" & versionId & "," & caracteristicaId & ")")
    End Function

    Public Shared Function sys_CaracteristicaCantidad(ByVal companyId As Integer, ByVal caracteristicaId As Integer, versionId As Integer, ByRef CantidadPermitida As Double, ByRef CantidadActual As Double) As Boolean
        Dim bRet As Boolean
        CantidadPermitida = GetNumericEscalar("Select dbo.CantidadCaracteristica(" & versionId & "," & caracteristicaId & ")")
        If CantidadPermitida > 0 Then
            Select Case caracteristicaId
                Case 102    'New Job
                    CantidadActual = GetNumericEscalar("Select count(*) FROM Jobs WHERE companyId=" & companyId & " And Year(Open_date)=Year(" & GetDateUTHlocal() & ")")
                    bRet = CantidadActual > CantidadPermitida
                Case 202    'New Proposal
                    CantidadActual = GetNumericEscalar("Select count(*) FROM Proposal WHERE companyId=" & companyId & " And Year(Date)=Year(" & GetDateUTHlocal() & ")")
                    bRet = CantidadActual > CantidadPermitida
                Case 402    'New Client
                    CantidadActual = GetNumericEscalar("Select count(*) FROM Clients WHERE companyId=" & companyId)
                    bRet = CantidadActual > CantidadPermitida
                Case 602    'New Employee
                    CantidadActual = GetNumericEscalar("Select count(*) FROM Employees WHERE companyId=" & companyId)
                    bRet = CantidadActual > CantidadPermitida
                Case Else
                    bRet = False
            End Select
        Else
            bRet = False
        End If
        Return bRet
    End Function

#End Region

#Region "Users"
    Public Shared Function ExisteUser(email As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetUsersConnection()
            Dim cmd As New SqlCommand("Select count(*) from [dbo].[aspnet_Membership] where Email = '" & email & "'", cnn1)
            Dim count = cmd.ExecuteScalar()
            cnn1.Close()
            Return count > 0
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function ExisteUserIdentity(email As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetUsersConnection()
            Dim cmd As New SqlCommand("Select count(*) from [dbo].[AspNetUsers] where Email = '" & email & "'", cnn1)
            Dim count = cmd.ExecuteScalar()
            cnn1.Close()
            Return count > 0
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function IsUserIdentityMigrated(email As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetUsersConnection()
            Dim cmd As New SqlCommand($"select count(*) from [dbo].[AspNetUsers] where Email='{email}'", cnn1)
            Dim count = cmd.ExecuteScalar()
            cnn1.Close()
            Return count > 0
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Shared Function GetUserEmailByGuid(guid As String) As String
        Return GetStringEscalar("Select TOP 1 Email FROM Employees where [guid]='" & guid & "'")
    End Function

    Public Shared Function GetMembershipUserPasswod(sEmail As String) As String
        Dim password As String = Nothing
        Dim PasswordHasher = New SqlMembershipProviderHelper()

        Dim cnnUsers = GetUsersConnection()
        Dim cmd As SqlCommand = cnnUsers.CreateCommand()
        ' get user
        cmd.CommandText = "select * from [dbo].[aspnet_Membership] where email  = '" & sEmail & "'"
        Dim rdr As SqlDataReader
        rdr = cmd.ExecuteReader
        rdr.Read()
        If rdr.HasRows Then
            Dim passHash = rdr("Password")
            password = PasswordHasher.GetClearTextPassword(passHash)
        End If
        cnnUsers.Close()
        Return password
    End Function

    Public Shared Async Function CreateOrUpdateUser(email As String, password As String) As Task(Of pasconcept20.ApplicationUser)
        If IsNothing(password) Then
            password = "ValidPassword@#$<GDE45"
        End If
        If Not (Await AppUserManager.PasswordValidator.ValidateAsync(password)).Succeeded Then
            password = "ValidPassword@#$<GDE45"
        End If

        Dim identityUser As pasconcept20.ApplicationUser = Await AppUserManager.FindByEmailAsync(email)
        If identityUser IsNot Nothing Then
            Dim token = Await AppUserManager.GeneratePasswordResetTokenAsync(identityUser.Id)
            Dim passwordHasher = New pasconcept20.PASPasswordHasher()
            identityUser.PasswordHash = passwordHasher.HashPassword(password)
            Await AppUserManager.UpdateAsync(identityUser)
            Return identityUser
        Else
            Dim user = New pasconcept20.ApplicationUser With {
                .Email = email,
                .UserName = email,
                .EmailConfirmed = True
            }

            Dim result = Await AppUserManager.CreateAsync(user, password)
            If result.Succeeded Then
                LocalAPI.NormalizeUser(email)
            End If
            Return user
        End If
        Return identityUser
    End Function

    Public Shared Sub NormalizeUser(email As String)
        Try
            Dim cnn1 As SqlConnection = GetUsersConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "AspNetUsers_Normalized"
            cmd.CommandType = CommandType.StoredProcedure
            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Email", email)
            cmd.ExecuteNonQuery()

            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Shared Sub UnlockUser(email As String)
        Try
            Dim cnn1 As SqlConnection = GetUsersConnection()
            Dim cmd As New SqlCommand("update [dbo].[AspNetUsers] set LockoutEnabled = 1, AccessFailedCount = 0, LockoutEnd = null where Email = '" & email & "'", cnn1)
            cmd.ExecuteNonQuery()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Shared Sub ConfirmEmailUser(email As String)
        Try
            Dim cnn1 As SqlConnection = GetUsersConnection()
            Dim cmd As New SqlCommand("update [dbo].[AspNetUsers] set EmailConfirmed = 1 where Email = '" & email & "'", cnn1)
            cmd.ExecuteNonQuery()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Shared Function IsMasterUser(email As String, companyId As String) As Boolean
        If ConfigurationManager.AppSettings("Debug") <> "1" Then
            Dim sMasterEmail As String = LocalAPI.GetCompanyProperty(companyId, "Email")
            Dim empId = GetEmployeeId(email, companyId)
            Return ((email.ToLower = sMasterEmail.ToLower) Or GetEmployeePermission(empId, "Allow_EmployeesPermissions"))
        Else
            Return True
        End If
    End Function

#End Region

#Region "PreUse"
    Public Shared Function preUserEmail(sGUID As String) As String
        Return GetStringEscalar("SELECT Email FROM sys_preUser WHERE GUID='" & sGUID & "'")
    End Function

    Public Shared Function EliminarpreUser(sEmail As String) As Boolean
        ExecuteNonQuery("DELETE FROM sys_preUser WHERE Email='" & sEmail & "'")
    End Function

#End Region

#Region "SharedLink"
    Public Shared Function IsValidGuid(ByVal guiId As String) As Boolean
        Try
            Dim instance As New Guid(guiId) 'Causes CA1806: DoNotIgnoreMethodResults
            Return True
        Catch e As ArgumentNullException
        Catch e As OverflowException
        Catch e As FormatException
        End Try

        Return False
    End Function

    Public Shared Function GetSharedLink_Id_injectsql(ByVal objType As Integer, ByVal guiId As String) As Integer
        If IsValidGuid(guiId) Then

            Select Case objType
                Case 1, 11, 111
                    Return GetNumericEscalar("SELECT [Id] FROM [Proposal] WHERE [guid]='" & guiId & "'")
                Case 3
                    Return GetNumericEscalar("SELECT [Id] FROM [RequestForProposals] WHERE [guid]='" & guiId & "'")
                Case 4
                    Return GetNumericEscalar("SELECT [Id] FROM [Invoices] WHERE [guid]='" & guiId & "'")
                Case 5
                    Return GetNumericEscalar("SELECT [Id] FROM [Invoices_statements] WHERE [guid]='" & guiId & "'")
                Case 6, 22, 30
                    Return GetNumericEscalar("SELECT [Id] FROM [Transmittals] WHERE [guid]='" & guiId & "'")
                Case 7
                    Return GetNumericEscalar("SELECT [Id] FROM [Jobs] WHERE [guid]='" & guiId & "'")
            End Select
        End If
    End Function

    Public Shared Function GetSharedLink_Id(ByVal objType As Integer, ByVal guiId As String) As Integer
        If IsValidGuid(guiId) Then
            Dim sSelectCommand As String
            Select Case objType
                Case 1, 11, 111
                    sSelectCommand = "SELECT [Id] FROM [Proposal] WHERE [guid]=@guid"
                Case 3
                    sSelectCommand = "SELECT [Id] FROM [RequestForProposals] WHERE [guid]=@guid"
                Case 4
                    sSelectCommand = "SELECT [Id] FROM [Invoices] WHERE [guid]=@guid"
                Case 5
                    sSelectCommand = "SELECT [Id] FROM [Invoices_statements] WHERE [guid]=@guid"
                Case 6, 22, 30
                    sSelectCommand = "SELECT [Id] FROM [Transmittals] WHERE [guid]=@guid"
                Case 7
                    sSelectCommand = "SELECT [Id] FROM [Jobs] WHERE [guid]=@guid"
            End Select

            Try
                Dim cnn1 As SqlConnection = GetConnection()
                Dim cmd As New SqlCommand(sSelectCommand, cnn1)
                cmd.Parameters.AddWithValue("@guid", guiId)
                GetSharedLink_Id = Convert.ToDouble(cmd.ExecuteScalar())
                cnn1.Close()
            Catch ex As Exception
                Return 0
            End Try
        End If
    End Function


    Public Shared Function GetSharedLink_guiId(ByVal objType As Integer, objId As Integer) As String
        Try
            Select Case objType
                Case 1, 11, 111
                    Return GetProposalProperty(objId, "guid")
                Case 3
                    Return GetRFPProperty(objId, "guid")
                Case 4
                    Return GetInvoiceProperty(objId, "guid")
                Case 5
                    Return GetStatementProperty(objId, "guid")
                Case 6, 22
                    Return GetTransmittalProperty(objId, "guid")
                Case Else
                    ' codigo obsoleto.................
                    Dim cnn1 As SqlConnection = GetConnection()
                    Dim cmd As SqlCommand = cnn1.CreateCommand()

                    ' Setup the command to execute the stored procedure.
                    cmd.CommandText = "Shared_links_INSERT"
                    cmd.CommandType = CommandType.StoredProcedure


                    ' Set up the input parameter 
                    '@objType:  1:Proposal;   1:Job;   3:RFP;    4:Invpoce
                    cmd.Parameters.AddWithValue("@objType", objType)
                    cmd.Parameters.AddWithValue("@objId", objId)

                    ' Set up the output parameter 
                    Dim paramResult As SqlParameter =
                        New SqlParameter("@guiId_OUT", SqlDbType.UniqueIdentifier)
                    paramResult.Direction = ParameterDirection.Output
                    cmd.Parameters.Add(paramResult)

                    ' Execute the stored procedure.
                    cmd.ExecuteNonQuery()

                    Return paramResult.Value.ToString

                    cnn1.Close()

            End Select

        Catch ex As Exception

        End Try
    End Function

    Public Shared Function GetSharedLink_URL(ByVal objType As Integer, objId As Integer, Optional PrintParameter As Boolean = False) As String
        '@objType:  1:Proposal;   2:Job;   3:RFP;    4:Invoice;    5:Statement  55: Statement in /e2103445_8a47_49ff_808e_6008c0fe13a1
        Try
            Dim url As String = ""
            If objId > 0 Then

                Select Case objType
                    Case 1, 11 ' Firmar/Ver Proposal from client
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/SingProposalSign.aspx?GuiId=" & LocalAPI.GetProposalProperty(objId, "guid")
                    Case 111 ' Firmar/Ver Proposal from /adm/proposals
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/SingProposalSign.aspx?GuiId=" & LocalAPI.GetProposalProperty(objId, "guid") & "&source=111"
                    Case 1111 ' URL to client for visilog
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/SingProposalSign.aspx?GuiId=" & LocalAPI.GetProposalProperty(objId, "guid") & "&entityType=1"
                    Case 2
                        ' Tratamiento especifico de Job(Projects) para paginas publicas
                        Dim companyId As Integer = GetJobProperty(objId, "companyId")
                        Dim guId As String = LocalAPI.GetCompanyGUID(companyId)
                        url = LocalAPI.GetHostAppSite() & "/ope/ope_project.aspx?guId=" & guId & "&Id=" & objId
                    Case 3
                        'url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/RequestForProposal.aspx?GuiId=" & LocalAPI.GetSharedLink_guiId(objType, objId)
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/RequestForProposal.aspx?GuiId=" & LocalAPI.GetRFPProperty(objId, "guid")
                    Case 4, 44
                        'url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Invoice.aspx?GuiId=" & LocalAPI.GetSharedLink_guiId(objType, objId)
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Invoice.aspx?GuiId=" & LocalAPI.GetInvoiceProperty(objId, "guid")
                    Case 4444
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Invoice.aspx?GuiId=" & LocalAPI.GetInvoiceProperty(objId, "guid") & "&entityType=2"
                    Case 5, 55
                        'url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Statement.aspx?GuiId=" & LocalAPI.GetSharedLink_guiId(objType, objId)
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Statement.aspx?GuiId=" & LocalAPI.GetStatementProperty(objId, "guid")
                    Case "5555"
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Statement.aspx?GuiId=" & LocalAPI.GetStatementProperty(objId, "guid") & "&entityType=3"
                    Case 6
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Transmittal.aspx?GuiId=" & LocalAPI.GetTransmittalProperty(objId, "guid")
                    Case 66
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/mtransmittal.aspx?GuiId=" & LocalAPI.GetTransmittalProperty(objId, "guid")
                    Case 6666
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Transmittal.aspx?GuiId=" & LocalAPI.GetTransmittalProperty(objId, "guid") & "&entityType=4"
                    Case 7  ' jobprogressrollup from jobId
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/jobprogressrollup.aspx?jobguid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 8  ' jobprogressrollup from invoiceId
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/jobprogressrollup.aspx?invoiceguiId=" & LocalAPI.GetInvoiceProperty(objId, "guid")
                    Case 9  ' CP_jobs Client Portal
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/CP_jobs.aspx?clientguid=" & LocalAPI.GetClientProperty(objId, "guid")
                    Case 91  ' paymenthistory Client Portal
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/paymenthistory.aspx?clientguid=" & LocalAPI.GetClientProperty(objId, "guid")

                    Case 1204  ' Private Link Tickets from jobId
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/tickets.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 1205  ' Private Link Ticket from ticketId
                        Dim jobId As Integer = GetTicketProperty(objId, "jobId")
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/ticket.aspx?guid=" & LocalAPI.GetJobProperty(jobId, "guid") & "&TicketId=" & objId
                    Case 1206  ' EMP/Ticket from ticketId
                        Dim jobId As Integer = GetTicketProperty(objId, "jobId")
                        url = LocalAPI.GetHostAppSite() & "/adm/ticket.aspx?JobId=" & jobId & "&TicketId=" & objId


                    Case 2001  ' Subconsultant Portal
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/SUB/rfps.aspx?subconsultantguid=" & LocalAPI.GetSubconsultantProperty(objId, "guid")

                    Case 2002  ' Gest Subconsultant Portal
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/SUB/rfp.aspx?GuiId=" & LocalAPI.GetRFPProperty(objId, "guid")
                    Case 2003  ' RFP to Proposal
                        url = LocalAPI.GetHostAppSite() & "/adm/Proposals.aspx?rfpGUID=" & LocalAPI.GetRFPProperty(objId, "guid")

                    Case 3001  'Client Acknowledgment Page
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/acknowledgment.aspx?clientguid=" & LocalAPI.GetClientProperty(objId, "guid")


                    ' Job_ pages............................................
                    Case 8001
                        url = LocalAPI.GetHostAppSite() & "/adm/job_job.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 8002
                        url = LocalAPI.GetHostAppSite() & "/adm/job_accounting.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 8003
                        url = LocalAPI.GetHostAppSite() & "/adm/job_employees.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 8004
                        url = LocalAPI.GetHostAppSite() & "/adm/job_proposals.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 8005
                        url = LocalAPI.GetHostAppSite() & "/adm/job_rfps.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 8006
                        url = LocalAPI.GetHostAppSite() & "/adm/job_notes.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 8007
                        url = LocalAPI.GetHostAppSite() & "/adm/job_times.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 8008
                        url = LocalAPI.GetHostAppSite() & "/adm/job_links.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 8009
                        url = LocalAPI.GetHostAppSite() & "/adm/job_schedule.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 8010
                        url = LocalAPI.GetHostAppSite() & "/adm/job_reviews.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 8011
                        url = LocalAPI.GetHostAppSite() & "/adm/job_tags.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 8012
                        url = LocalAPI.GetHostAppSite() & "/adm/job_transmittals.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")
                    Case 8014
                        url = LocalAPI.GetHostAppSite() & "/adm/job_addemployee.aspx?guid=" & LocalAPI.GetJobProperty(objId, "guid")

                    ' Proposal_ pages............................................
                    Case 11001
                        url = LocalAPI.GetHostAppSite() & "/adm/pro_proposal.aspx?guid=" & LocalAPI.GetProposalProperty(objId, "guid")
                    Case 11002
                        url = LocalAPI.GetHostAppSite() & "/adm/pro_paymentschedules.aspx?guid=" & LocalAPI.GetProposalProperty(objId, "guid")
                    Case 11003
                        url = LocalAPI.GetHostAppSite() & "/adm/pro_openingclosing.aspx?guid=" & LocalAPI.GetProposalProperty(objId, "guid")
                    Case 11004
                        url = LocalAPI.GetHostAppSite() & "/adm/pro_termandconditions.aspx?guid=" & LocalAPI.GetProposalProperty(objId, "guid")
                    Case 11005
                        url = LocalAPI.GetHostAppSite() & "/adm/pro_files.aspx?guid=" & LocalAPI.GetProposalProperty(objId, "guid")
                    Case 11006
                        url = LocalAPI.GetHostAppSite() & "/adm/pro_phases.aspx?guid=" & LocalAPI.GetProposalProperty(objId, "guid")
                    Case 11007
                        url = LocalAPI.GetHostAppSite() & "/adm/pro_notes.aspx?guid=" & LocalAPI.GetProposalProperty(objId, "guid")
                    Case 11008
                        url = LocalAPI.GetHostAppSite() & "/adm/pro_preview.aspx?guid=" & LocalAPI.GetProposalProperty(objId, "guid")

                End Select
                If PrintParameter Then
                    url = url & "&Print=1"
                End If
            End If

            Return url
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function GetSharedLink_URL_ByGuid(ByVal objType As Integer, objGuid As String, Optional objId As Integer = 0) As String
        '@objType:  1:Proposal;   2:Job;   3:RFP;    4:Invoice;    5:Statement  55: Statement in /e2103445_8a47_49ff_808e_6008c0fe13a1
        Try
            Dim url As String = ""
            If Not (objGuid Is Nothing) Then
                Select Case objType
                    Case 1, 11 ' Firmar/Ver Proposal from client
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/SingProposalSign.aspx?GuiId=" & objGuid
                    Case 111 ' Firmar/Ver Proposal from /adm/proposals
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/SingProposalSign.aspx?GuiId=" & objGuid & "&source=111"
                    Case 2
                        ' Tratamiento especifico de Job(Projects) para paginas publicas
                        url = LocalAPI.GetHostAppSite() & "/ope/ope_project.aspx?guId=" & objGuid & "&Id=" & objId
                    Case 3
                        'url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/RequestForProposal.aspx?GuiId=" & LocalAPI.GetSharedLink_guiId(objType, objId)
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/RequestForProposal.aspx?GuiId=" & objGuid
                    Case 4, 44
                        'url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Invoice.aspx?GuiId=" & LocalAPI.GetSharedLink_guiId(objType, objId)
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Invoice.aspx?GuiId=" & objGuid
                    Case 5, 55
                        'url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Statement.aspx?GuiId=" & LocalAPI.GetSharedLink_guiId(objType, objId)
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Statement.aspx?GuiId=" & objGuid
                    Case 6
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Transmittal.aspx?GuiId=" & objGuid
                    Case 66
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/mtransmittal.aspx?GuiId=" & objGuid
                    Case 7  ' jobprogressrollup from jobId
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/jobprogressrollup.aspx?jobguid=" & objGuid
                    Case 8  ' jobprogressrollup from invoiceId
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/jobprogressrollup.aspx?invoiceguiId=" & objGuid
                    Case 9  ' CP_jobs Client Portal
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/CP_jobs.aspx?clientguid=" & objGuid
                    Case 91  ' paymenthistory Client Portal
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/paymenthistory.aspx?clientguid=" & objGuid

                    Case 1204  ' Private Link Tickets from jobId
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/tickets.aspx?guid=" & objGuid
                    Case 1205  ' Private Link Ticket from ticketId
                        Dim jobId As Integer = GetTicketProperty(objId, "jobId")
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/ticket.aspx?guid=" & objGuid & "&TicketId=" & objId
                    Case 1206  ' EMP/Ticket from ticketId
                        Dim jobId As Integer = GetTicketProperty(objId, "jobId")
                        url = LocalAPI.GetHostAppSite() & "/adm/ticket.aspx?JobId=" & jobId & "&TicketId=" & objId


                    Case 2001  ' Subconsultant Portal
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/SUB/rfps.aspx?subconsultantguid=" & objGuid

                    Case 2002  ' Gest Subconsultant Portal
                        url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/SUB/rfp.aspx?GuiId=" & objGuid
                    Case 2003  ' RFP to Proposal
                        url = LocalAPI.GetHostAppSite() & "/adm/Proposals.aspx?rfpGUID=" & objGuid

                End Select
            End If

            Return url
        Catch ex As Exception

        End Try
    End Function


#End Region

#Region "Images"

    Private Shared Sub ForceJobImage(ByVal JobId As Integer)
        If GetNumericEscalar("SELECT COUNT(*) FROM Jobs_photos WHERE [Job]=" & JobId) = 0 Then
            ExecuteNonQuery("INSERT INTO [Jobs_photos] ([Job]) VALUES(" & JobId & ")")
        End If
    End Sub

    Public Shared Function IsJobPhoto(ByVal JobId As Integer) As Boolean
        Return (GetNumericEscalar("select case when NOT (select top (1) Photo from Jobs_photos where Job=" & JobId & ") is null then 1 else 0 end"))
    End Function

    Public Shared Function JobGetImage(ByVal JobId As Integer) As Byte()
        Try
            ForceJobImage(JobId)
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = New SqlCommand("SELECT TOP 1 Photo FROM [Jobs_photos] WHERE [Job]=@JobId", cnn1)
            cmd.Parameters.AddWithValue("@JobId", JobId)

            Return cmd.ExecuteScalar
            cnn1.Close()

        Catch ex As Exception
            'Throw ex
        End Try
    End Function

    Public Shared Function JobSetImage(ByVal JobId As Integer, imgData As Byte()) As Boolean
        Try
            ForceJobImage(JobId)
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = New SqlCommand("UPDATE [Jobs_photos] SET Photo=@Photo WHERE [Job]=@JobId", cnn1)
            cmd.Parameters.AddWithValue("@JobId", JobId)
            Dim parImg As New SqlParameter("@Photo", SqlDbType.Image)
            parImg.Value = imgData
            cmd.Parameters.Add(parImg)

            cmd.ExecuteNonQuery()

            cnn1.Close()
            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function JobDeleteImages(ByVal JobId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = New SqlCommand("UPDATE [Jobs_photos] SET Photo=NULL WHERE [Job]=@JobId", cnn1)
            cmd.Parameters.AddWithValue("@JobId", JobId)

            cmd.ExecuteNonQuery()

            cnn1.Close()
            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

#End Region

#Region "Proposal"
    Public Shared Function IsProposalOrJobName(ByVal sName As String, ByVal companyId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim query As String = String.Format("SELECT [Id] FROM [Jobs] WHERE [companyId]={0} AND [Job]=@ProjectName", companyId, sName)
            Dim cmd As New SqlCommand(query, cnn1)
            Dim rdr As SqlDataReader

            cmd.Parameters.AddWithValue("@ProjectName", sName)

            rdr = cmd.ExecuteReader
            rdr.Read()
            IsProposalOrJobName = rdr.HasRows
            rdr.Close()
            If Not IsProposalOrJobName Then
                query = String.Format("SELECT [Id] FROM [Proposal] WHERE [companyId]={0} AND [ProjectName]=@ProjectName", companyId, sName)
                Dim cmd1 As New SqlCommand(query, cnn1)
                cmd1.Parameters.AddWithValue("@ProjectName", sName)
                rdr = cmd1.ExecuteReader
                rdr.Read()
                IsProposalOrJobName = rdr.HasRows
                rdr.Close()
            End If
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetProposalStatusLabelCSS(ByVal statusId As Integer) As String
        Select Case statusId
            Case 0  'Not Emitted
                Return "badge badge-secondary statuslabel"
            Case 1  'Emitted
                Return "badge badge-warning statuslabel"
            Case 2  'Accepted
                Return "badge badge-success statuslabel"
            Case Else
                Return "badge badge-danger statuslabel"
        End Select

    End Function

    Public Shared Function GetProposalIdFromGUID(ByVal guid As String) As Integer
        Dim cnn1 As SqlConnection = GetConnection()
        Dim cmd As New SqlCommand("SELECT [Id] FROM [Proposal] where [guid]=@guid", cnn1)
        cmd.Parameters.AddWithValue("@guid", guid)
        GetProposalIdFromGUID = Convert.ToDouble(cmd.ExecuteScalar())
        cnn1.Close()

    End Function


    Public Shared Function ProposalStatus2Emitted(ByVal proposald As Integer) As Boolean
        'Return ExecuteNonQuery("UPDATE [Proposal] SET Emitted=ISNULL(Emitted,0)+1, EmailDate=" & GetDateUTHlocal() & ", [StatusId]=1 WHERE Id=" & lId.ToString & " AND ISNULL([StatusId],0) in(0,1,4)")

        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "ProposalEmittedStatus_UPDATE"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@proposald", proposald)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function ProposalStatus2Accepted(ByVal proposald As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "ProposalAcceptedStatus_UPDATE"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@proposalId", proposald)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function SetProposalProjectManagerId(ByVal lId As Integer, ProjectManagerId As Integer) As Boolean
        Return ExecuteNonQuery("UPDATE [Proposal] SET [ProjectManagerId]=" & ProjectManagerId & " WHERE Id=" & lId)
    End Function

    Public Shared Function ProposalDetail_OrderBy_UPDATE(detailId As Integer, OrderDirection As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "ProposalDetail_OrderBy_UPDATE"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@ProposalDetailId", detailId)
            cmd.Parameters.AddWithValue("@OrderDirection", OrderDirection)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            ' evitar error por posible duplicado
            'Throw ex
        End Try
    End Function



    Public Shared Function SetProposalStatus(ByVal lId As Integer, statusId As Integer) As Boolean
        '0:	    Not Emitted
        '1:     Pending
        '2:     Accepted
        '3:     Declined
        Return ExecuteNonQuery("UPDATE [Proposal] SET EmailDate=" & GetDateUTHlocal() & ", [StatusId]=" & statusId & " WHERE Id=" & lId.ToString)
    End Function

    Public Shared Function ProposalStatus2Declined(ByVal proposald As Integer, ByVal sStatus_notes As String, statusId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            'cmd.CommandText = "UPDATE [Proposal] SET AceptedDate=" & GetDateUTHlocal() & ", [StatusId]=" & statusId & ", [Status_notes]=@parStatus_notes WHERE  Id=" & lId.ToString
            cmd.CommandText = "ProposalStatus2Declined"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@proposalId", proposald)
            cmd.Parameters.AddWithValue("@statusId", statusId)
            cmd.Parameters.AddWithValue("@parStatus_notes", sStatus_notes)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            ' TAGuear al cliente en Agile
            Dim companyId As Integer = GetProposalProperty(proposald, "companyId")
            If companyId = 260962 Then
                ProposalTAGAgile(proposald, companyId, "Declined")
            End If

            Return True

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function ProposalStatus2Hold(ByVal lId As Integer) As Boolean
        Try
            Dim companyId As Integer = GetProposalProperty(lId, "companyId")

            ExecuteNonQuery("UPDATE [Proposal] SET EmailDate=" & GetDateUTHlocal() & ", [StatusId]=4 WHERE Id=" & lId.ToString)

            ' TAGuear al cliente en Agile
            If companyId = 260962 Then
                Task.Run(Function() ProposalTAGAgile(lId, companyId, "Hold"))
            End If

            ProposalStatus2Hold = True

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function GetProjectManagerEmailFromProposal(lProposalId As Integer) As String
        Dim sCC As String = ""
        Dim ProjectManagerId As Integer = LocalAPI.GetProposalProperty(lProposalId, "ProjectManagerId")
        If ProjectManagerId > 0 Then
            sCC = LocalAPI.GetEmployeeEmail(ProjectManagerId)
        End If
        Return sCC
    End Function

    Public Shared Function GetHeadDepartmentEmailFromProposal(lProposalId As Integer) As String
        Dim Bcc As String = ""
        Dim departmentId As Integer = LocalAPI.GetProposalProperty(lProposalId, "DepartmentId")
        If departmentId > 0 Then
            Dim emplHeadId As Integer = LocalAPI.GetDepartmentsProperty(departmentId, "Head")
            If emplHeadId > 0 Then
                Bcc = LocalAPI.GetEmployeeEmail(emplHeadId)
            End If
            Bcc = Bcc & IIf(Len(Bcc) > 0, ",", "") & GetDepartmentsProperty(departmentId, "ProposalStatusTrackingEmail")
        End If
        Return Bcc
    End Function

    Public Shared Function GetHeadDepartmentEmailFromJob(jobId As Integer) As String
        Dim Bcc As String = ""
        Dim departmentId As Integer = LocalAPI.GetJobProperty(jobId, "DepartmentId")
        If departmentId > 0 Then
            Dim emplHeadId As Integer = LocalAPI.GetDepartmentsProperty(departmentId, "Head")
            If emplHeadId > 0 Then
                Bcc = LocalAPI.GetEmployeeEmail(emplHeadId)
            End If
            Bcc = Bcc & IIf(Len(Bcc) > 0, ",", "") & GetDepartmentsProperty(departmentId, "ProposalStatusTrackingEmail")
        End If
        Return Bcc
    End Function

    Public Shared Function ProposalStatus2Acept(ByVal proposalId As Long, ByVal companyId As Integer) As Integer
        Dim jobId As Integer = GetProposalProperty(proposalId, "JobId")
        Try
            If GetProposalProperty(proposalId, "StatusId") < 2 Then

                '1.- Pasarlo a statusId=2 para que no vuelva por esta rama
                ProposalStatus2Accepted(proposalId)

                '0.- Es un primer Proposal o es un Change Order (ya tiene JobId)
                Dim dProposalTotal As Double = GetProposalTotal(proposalId)

                Dim statusId As Integer = GetProposalProperty(proposalId, "StatusId")
                Dim bRetainer As Boolean

                If jobId <= 0 Then
                    '2.1 -  Crear job Asociado
                    ' No Aceptado y sin JobId creado

                    ' Leer Otros datos para el Job
                    Dim ProposalObject = LocalAPI.GetRecord(proposalId, "PROPOSAL_FOR_Aceptance_SELECT")

                    '.....................................Aceprtar Proposal inicial, (No tiene Job asignado, hay que crearlo.....................)
                    '2.2 - Obtener datos del Proposal
                    Dim sJobCode As String = GetNextJobCode(Right(Year(GetDateTime()), 2), companyId)

                    If Len(sJobCode) > 0 Then
                        Dim sJobName As String = ProposalObject("ProjectName")
                        Dim sClientId As String = ProposalObject("ClientId")
                        Dim ProjectManagerId As String = "0"
                        Dim sJobType As String = ProposalObject("ProjectType")
                        Dim nJobSector As Integer = ProposalObject("ProjectSector")
                        Dim sJobUse As String = ProposalObject("ProjectUse")
                        Dim sJobUse2 As String = ProposalObject("ProjectUse2")
                        Dim sProjLocation As String = ProposalObject("ProjectLocation")
                        Dim sProjArea As String = ProposalObject("ProjectArea")
                        Dim sOwner As String = ProposalObject("Owner")
                        Dim Dpto As String = ProposalObject("DepartmentId")
                        Dim sProposalType As String = ProposalObject("Type")
                        Dim nWorkingDays As Integer = ProposalObject("Workdays")
                        Dim DeadLine As DateTime = ProposalObject("Deadline")
                        Dim StartDay As DateTime

                        bRetainer = ProposalObject("Retainer")

                        '2.3 -.- Get Job Code
                        ' Verificar que no existe el Nombre
                        jobId = GetJobId(sJobName, companyId)
                        Dim i As Integer = 0
                        While jobId > 0
                            i = i + 1
                            sJobName = sJobName & " (" & i & ")"
                            jobId = GetJobId(sJobName, companyId)
                        End While

                        '2.4 - Crear Job asociado
                        jobId = NuevoJob(sJobCode, sJobName, GetDateTime(), sClientId, dProposalTotal, sProposalType, sJobType, ProjectManagerId, sProjLocation, sProjArea, nJobSector, sJobUse, sJobUse2, Dpto, sOwner, 0, 0, companyId)

                        '2.5 - Update parametros del Proposal
                        ExecuteNonQuery($"UPDATE [Proposal] Set JobId={jobId} WHERE Id={proposalId}")

                        '2.6 - New Job Note acceptande
                        NewJobNote(jobId, "Log: Job created by the acceptance of the Proposal " & ProposalNumber(proposalId), 0)

                        '2.7 - Setting Dates attributes of Job
                        If Year(DeadLine) = 1980 Then
                            ' Fecha de fin sin definir, se calcula a partir de los WorkinDays
                            If nWorkingDays = 0 Then
                                nWorkingDays = 1
                            End If
                            ' Un dia mas, pues se supon que no se empieza a trabajar el mismo dia de aceptacion
                            DeadLine = AddWorkDays(GetDateTime(), nWorkingDays + 1)
                        End If
                        StartDay = AddWorkDays(GetDateTime(), 1)
                        ExecuteNonQuery("UPDATE [Jobs] set [StartDay]=" & GetFecha_102(StartDay) & ", [EndDay]=" & GetFecha_102(DeadLine) & ", Workdays=" & nWorkingDays & " WHERE Id=" & jobId)
                        ' Otros atributos del Proposal->Job
                        ExecuteNonQuery($"UPDATE [Jobs] set [Unit]=(select Unit from Proposal where Id={proposalId}), [Measure]=(select Measure from Proposal where Id={proposalId}) WHERE Id={jobId}")

                        If Len(sProjLocation) > 2 Then
                            Dim Latitude As String = ""
                            Dim Longitude As String = ""
                            LocalAPI.GetLatitudeLongitude(sProjLocation, Latitude, Longitude)
                            LocalAPI.SetJobLatitudeLongitude(jobId, Latitude, Longitude)
                        End If

                    End If
                Else
                    '2.1 -Proposal Change Order
                    ' Ya existe JobId, es un Aditional change.......................................................................................
                    If dProposalTotal <> 0 Then
                        '2.2.- Incrementar el Jobs.Budget=+Proposal.Total)
                        ExecuteNonQuery($"UPDATE [Jobs] SET Budget=Budget+{dProposalTotal} WHERE Id={jobId}")
                        NewJobNote(jobId, "$Log: job Budget modified (+" & dProposalTotal & ") by the acceptance of the Proposal (Aditional Change): " & ProposalNumber(proposalId), 0)

                        ''2.3 Simple Charge, and ..., se esta duplicando en 3. - Invoices from PaymentSchedule
                        'NuevoInvoiceSimpleCharge(jobId, GetDateTime(), dProposalTotal, "Proposal (Additional Charge): " & ProposalNumber(proposalId))

                        '2.4 Mandatory Retainer
                        bRetainer = True
                    End If

                    '2.2 - Update parametros del Proposal
                    ExecuteNonQuery("UPDATE [Proposal] SET AceptedDate=" & GetFecha_102(Today.Date) & ", [StatusId]=2 WHERE Id=" & proposalId.ToString)
                End If

                '3. - Invoices from PaymentSchedule
                If jobId > 0 And dProposalTotal > 0 Then CreateInvoicesFromPaymentSchedule(proposalId, jobId)

                '4. -' Retainer..............
                If jobId > 0 And bRetainer Then
                    ' Se emite el Invoice por 100% al client
                    Dim invoiceId As Integer = GetNumericEscalar($"select top 1 Id from Invoices where JobId={jobId} and [Emitted]=0 order by Number")
                    If invoiceId > 0 Then
                        InvoiceAutomatictToClient(invoiceId, companyId)
                        NewJobNote(jobId, "Log: New Automatic Invoice for Reatiner by the acceptance of the Proposal : " & ProposalNumber(proposalId), 0)
                    End If
                End If

                '5. - TAGuear al cliente en Agile
                If companyId = 260962 Then
                    Task.Run(Function() ProposalTAGAgile(proposalId, companyId, "Accepted"))
                End If

                '6. - Log................... End
                LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.AceptProposal, companyId, proposalId)

                '7. Create Signed PDF
                'Dim pdf As PdfApi = New PdfApi()
                'Dim newName = "Companies/" & companyId & $"/{Guid.NewGuid().ToString()}.pdf"
                'Task.Run(Function() pdf.CreateProposalSignedPdfAsync(proposalId, newName))
                'pdfUrl = "https://pasconceptstorage.blob.core.windows.net/documents/" & newName
                Return jobId
            Else
                Return jobId
            End If

        Catch ex As Exception
            Return jobId
            Throw ex
        End Try
    End Function


    Public Shared Function ProposalCreateJob(ByVal proposalId As Long, ByVal companyId As Integer) As Integer
        Dim jobId As Integer = 0
        Try

            'If GetProposalProperty(proposalId, "StatusId") < 2 Then

            '1.- Pasarlo a statusId=2 para que no vuelva por esta rama
            'ProposalStatus2Accepted(proposalId)

            '0.- Es un primer Proposal o es un Change Order (ya tiene JobId)
            Dim dProposalTotal As Double = GetProposalTotal(proposalId)

            jobId = GetProposalProperty(proposalId, "JobId")
            Dim statusId As Integer = GetProposalProperty(proposalId, "StatusId")
            Dim bRetainer As Boolean

            If jobId <= 0 Then
                '2.1 -  Crear job Asociado
                ' No Aceptado y sin JobId creado

                ' Leer Otros datos para el Job
                Dim ProposalObject = LocalAPI.GetRecord(proposalId, "PROPOSAL_FOR_Aceptance_SELECT")

                '.....................................Aceprtar Proposal inicial, (No tiene Job asignado, hay que crearlo.....................)
                '2.2 - Obtener datos del Proposal
                Dim sJobCode As String = GetNextJobCode(Right(Year(GetDateTime()), 2), companyId)

                If Len(sJobCode) > 0 Then
                    Dim sJobName As String = ProposalObject("ProjectName")
                    Dim sClientId As String = ProposalObject("ClientId")
                    Dim ProjectManagerId As String = "0"
                    Dim sJobType As String = ProposalObject("ProjectType")
                    Dim nJobSector As Integer = ProposalObject("ProjectSector")
                    Dim sJobUse As String = ProposalObject("ProjectUse")
                    Dim sJobUse2 As String = ProposalObject("ProjectUse2")
                    Dim sProjLocation As String = ProposalObject("ProjectLocation")
                    Dim sProjArea As String = ProposalObject("ProjectArea")
                    Dim sOwner As String = ProposalObject("Owner")
                    Dim Dpto As String = ProposalObject("DepartmentId")
                    Dim sProposalType As String = ProposalObject("Type")
                    Dim nWorkingDays As Integer = ProposalObject("Workdays")
                    Dim DeadLine As DateTime = ProposalObject("Deadline")
                    Dim StartDay As DateTime

                    bRetainer = ProposalObject("Retainer")

                    '2.3 -.- Get Job Code
                    ' Verificar que no existe el Nombre
                    jobId = GetJobId(sJobName, companyId)
                    Dim i As Integer = 0
                    While jobId > 0
                        i = i + 1
                        sJobName = sJobName & " (" & i & ")"
                        jobId = GetJobId(sJobName, companyId)
                    End While

                    '2.4 - Crear Job asociado
                    jobId = NuevoJob(sJobCode, sJobName, GetDateTime(), sClientId, dProposalTotal, sProposalType, sJobType, ProjectManagerId, sProjLocation, sProjArea, nJobSector, sJobUse, sJobUse2, Dpto, sOwner, 0, 0, companyId)

                    '2.5 - Update parametros del Proposal
                    ExecuteNonQuery($"UPDATE [Proposal] Set JobId={jobId} WHERE Id={proposalId}")

                    '2.6 - New Job Note acceptande
                    NewJobNote(jobId, "Log: Job created by the acceptance of the Proposal " & ProposalNumber(proposalId), 0)

                    '2.7 - Setting Dates attributes of Job
                    If Year(DeadLine) = 1980 Then
                        ' Fecha de fin sin definir, se calcula a partir de los WorkinDays
                        If nWorkingDays = 0 Then
                            nWorkingDays = 1
                        End If
                        ' Un dia mas, pues se supon que no se empieza a trabajar el mismo dia de aceptacion
                        DeadLine = AddWorkDays(GetDateTime(), nWorkingDays + 1)
                    End If
                    StartDay = AddWorkDays(GetDateTime(), 1)
                    ExecuteNonQuery("UPDATE [Jobs] set [StartDay]=" & GetFecha_102(StartDay) & ", [EndDay]=" & GetFecha_102(DeadLine) & ", Workdays=" & nWorkingDays & " WHERE Id=" & jobId)
                    ' Otros atributos del Proposal->Job
                    ExecuteNonQuery($"UPDATE [Jobs] set [Unit]=(select Unit from Proposal where Id={proposalId}), [Measure]=(select Measure from Proposal where Id={proposalId}) WHERE Id={jobId}")

                    If Len(sProjLocation) > 2 Then
                        Dim Latitude As String = ""
                        Dim Longitude As String = ""
                        LocalAPI.GetLatitudeLongitude(sProjLocation, Latitude, Longitude)
                        LocalAPI.SetJobLatitudeLongitude(jobId, Latitude, Longitude)
                    End If

                End If
            Else
                '2.1 -Proposal Change Order
                ' Ya existe JobId, es un Aditional change.......................................................................................
                If dProposalTotal <> 0 Then
                    '2.2.- Incrementar el Jobs.Budget=+Proposal.Total)
                    ExecuteNonQuery($"UPDATE [Jobs] SET Budget=Budget+{dProposalTotal} WHERE Id={jobId}")
                    NewJobNote(jobId, "$Log: job Budget modified (+" & dProposalTotal & ") by the acceptance of the Proposal (Aditional Change): " & ProposalNumber(proposalId), 0)

                    ''2.3 Simple Charge, and ..., se esta duplicando en 3. - Invoices from PaymentSchedule
                    'NuevoInvoiceSimpleCharge(jobId, GetDateTime(), dProposalTotal, "Proposal (Additional Charge): " & ProposalNumber(proposalId))

                    '2.4 Mandatory Retainer
                    bRetainer = True
                End If

                '2.2 - Update parametros del Proposal
                ExecuteNonQuery("UPDATE [Proposal] SET AceptedDate=" & GetFecha_102(Today.Date) & ", [StatusId]=2 WHERE Id=" & proposalId.ToString)
            End If

            '3. - Invoices from PaymentSchedule
            If jobId > 0 And dProposalTotal > 0 Then CreateInvoicesFromPaymentSchedule(proposalId, jobId)

            '4. -' Retainer..............
            If jobId > 0 And bRetainer Then
                ' Se emite el Invoice por 100% al client
                Dim invoiceId As Integer = GetNumericEscalar($"select top 1 Id from Invoices where JobId={jobId} and [Emitted]=0 order by Number")
                If invoiceId > 0 Then
                    InvoiceAutomatictToClient(invoiceId, companyId)
                    NewJobNote(jobId, "Log: New Automatic Invoice for Reatiner by the acceptance of the Proposal : " & ProposalNumber(proposalId), 0)
                End If
            End If

            '5. - TAGuear al cliente en Agile
            If companyId = 260962 Then
                Task.Run(Function() ProposalTAGAgile(proposalId, companyId, "Accepted"))
            End If

            '6. - Log................... End
            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.AceptProposal, companyId, proposalId)

            '7. Create Signed PDF
            'Dim pdf As PdfApi = New PdfApi()
            'Dim newName = "Companies/" & companyId & $"/{Guid.NewGuid().ToString()}.pdf"
            'Task.Run(Function() pdf.CreateProposalSignedPdfAsync(proposalId, newName))
            'pdfUrl = "https://pasconceptstorage.blob.core.windows.net/documents/" & newName
            Return jobId
            'End If

        Catch ex As Exception
            Return jobId
            Throw ex
        End Try
    End Function

    Public Shared Function GetProposal_TandCtemplatesId(ByVal Name As String, companyId As Integer) As Integer
        Return GetNumericEscalar(String.Format("SELECT top 1 Id FROM [Proposal_TandCtemplates] WHERE companyId={0} and [Name]='{1}' order by Id desc", companyId, Name))
    End Function
    Public Shared Function GetProposal_Proposal_typesId(ByVal Name As String, companyId As Integer) As Double
        Return GetNumericEscalar(String.Format("SELECT top 1 Id FROM [Proposal_types] WHERE companyId={0} and [Name]='{1}' order by Id desc", companyId, Name))
    End Function



    Private Shared Function CreateInvoicesFromPaymentSchedule(ByVal proposalId As Integer, jobId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            cmd.CommandText = "InvoicesFromProposalPS_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            'cmd.Parameters.AddWithValue("@ID", ContactObject.ID)
            cmd.Parameters.AddWithValue("@ProposalId", proposalId)
            cmd.Parameters.AddWithValue("@JobId", jobId)

            cmd.ExecuteNonQuery()

            cnn1.Close()
            Return 1

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Shared Function CreateInvoicesFromPaymentSchedule_old(ByVal proposalId As Integer, jobId As Integer, dTotal As Double, bRetainer As Boolean, companyId As Integer) As Boolean
        Try

            Dim i As Integer
            Dim PaymentValue As Double
            Dim PaymentText As String
            Dim dAmount As Double
            Dim invoiceId As Integer
            For i = 1 To 10
                PaymentValue = GetProposalProperty(proposalId, "PaymentSchedule" & i)
                If PaymentValue = 0 Then Exit For
                PaymentText = GetProposalProperty(proposalId, "PaymentText" & i)
                ' Crear Invoice por el Porciento especificado

                dAmount = dTotal * PaymentValue / 100.0
                invoiceId = NuevoInvoiceSimpleCharge(jobId, GetDateTime(), dAmount, PaymentText)
                NewJobNote(jobId, "Log: New Invoice (+" & dAmount & ") by the acceptance of the Proposal PaymentSchedule", 0)
                If i = 1 And bRetainer Then
                    InvoiceAutomatictToClient(invoiceId, companyId)
                End If
            Next
            Return True
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function InvoiceMessage(invoiceId As Integer, companyId As Integer) As Boolean
        Try

            Dim clientId As Integer = LocalAPI.GetClientIdFromInvoice(invoiceId)
            Dim sInvoiceNumber As String = LocalAPI.InvoiceNumber(invoiceId)

            Dim sClientEmail As String = LocalAPI.GetClientEmailFromInvoice(invoiceId)

            If LocalAPI.IsClientNotification(clientId, "Notification_invoiceemitted") Or Not LocalAPI.ExisteUser(sClientEmail) Then

                Dim sJobCode As String = LocalAPI.GetInvoiceProperty(invoiceId, "[Jobs].[Code]")
                Dim sJobName As String = LocalAPI.GetInvoiceProperty(invoiceId, "[Jobs].[Job]")
                Dim sSubject As String = "Invoice " & sInvoiceNumber & " Has Been Emitted To Your Attention. Job " & sJobCode & ". " & sJobName
                Dim sJobId As String = LocalAPI.GetInvoiceProperty(invoiceId, "[Jobs].[Id]")

                Dim sMsg As New System.Text.StringBuilder

                sMsg.Append("Greetings,")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Invoice " & sInvoiceNumber & " Has Been Emitted to your attention on " & LocalAPI.GetInvoiceProperty(invoiceId, "LatestEmission"))
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Times Emitted: " & LocalAPI.GetInvoiceProperty(invoiceId, "Emitted"))
                sMsg.Append("<br />")
                sMsg.Append("Job: " & sJobCode & ", " & sJobName)
                sMsg.Append("<br />")
                sMsg.Append("Date Created: " & LocalAPI.GetInvoiceProperty(invoiceId, "InvoiceDate"))
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("To see the details of the invoice, visit the following site: ")
                sMsg.Append("<br />")
                sMsg.Append("<br />")

                ' Crear enlace SharedLink.............................................................
                sMsg.Append("<a href=" & """" & LocalAPI.GetSharedLink_URL(4, invoiceId) & """" & ">Invoice " & sInvoiceNumber & "</a>")

                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Thank you.")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("PASconcept Notifications")
                sMsg.Append("<br />")
                sMsg.Append(LocalAPI.GetPASSign())

                Dim sBody As String = sMsg.ToString
                Dim sCC As String = ""
                Dim sCCO As String = ""
                If LocalAPI.IsCompanyNotification(companyId, "Notification_EmittedInvoice") Then
                    sCC = LocalAPI.GetCompanyProperty(companyId, "webEmailProfitWarningCC")
                    sCCO = LocalAPI.GetCompanyProperty(companyId, "webEmailProfitWarningCCO")
                End If

                SendGrid.Email.SendMail(sClientEmail, sCC, sCCO, sSubject, sBody, companyId, clientId, sJobId)
            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function InvoiceAutomatictToClient(invoiceId As Integer, companyId As Integer) As Boolean
        Try

            Dim sSubject As String = ""
            Dim sBody As String = ""
            Dim emailTo As String = LocalAPI.GetClientEmailFromInvoice(invoiceId)

            LocalAPI.LeerInvoiceTemplate(invoiceId, companyId, sSubject, sBody)

            ' Tratamiento de accounting by department
            Dim SenderDisplay As String = ""
            Dim ReplyEmail As String = ""
            Dim departmentId As String = Val("" & LocalAPI.GetInvoiceProperty(invoiceId, "Jobs.departmentId"))
            If departmentId > 0 Then
                SenderDisplay = GetDepartmentsProperty(departmentId, "BillingContactName")
                ReplyEmail = GetDepartmentsProperty(departmentId, "BillingContactEmail")
                sBody = Replace(sBody, "[Sign]", SenderDisplay)
            End If

            Dim clientID = LocalAPI.GetClientIdFromInvoice(invoiceId)
            Dim jobId = LocalAPI.GetJobIdFromInvoice(invoiceId)

            Task.Run(Function() SendGrid.Email.SendMail(emailTo, "", "", sSubject, sBody, companyId, clientID, jobId,, SenderDisplay, ReplyEmail, SenderDisplay))

            ActualizarEmittedInvoice(invoiceId, 0)

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function AceptProposal(Id As Integer, AceptanceName As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("update Proposal set AceptanceName=@name where Id=@Id", cnn1)
            cmd.CommandType = CommandType.Text
            cmd.Parameters.AddWithValue("@name", Left(AceptanceName, 80))
            cmd.Parameters.AddWithValue("@Id", Id)

            cmd.ExecuteNonQuery()

            cnn1.Close()
            Return True

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function SignProposal(Id As Integer, AceptanceName As String, img64 As String) As Boolean
        Try
            ' Convertir a image
            'Dim img As System.Drawing.Image = Base64ToImage(img64.Replace("data:image/png;base64,", ""))

            'Convert Image to Byte Array
            Dim imgBytes As Byte() = Convert.FromBase64String(img64.Replace("data:image/png;base64,", ""))

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("update Proposal set AceptanceName=@name,AceptanceSignature=@img where Id=@Id", cnn1)
            cmd.CommandType = CommandType.Text
            cmd.Parameters.AddWithValue("@name", Left(AceptanceName, 80))
            cmd.Parameters.AddWithValue("@Id", Id)
            cmd.Parameters.Add("@img", Data.SqlDbType.Image).Value = imgBytes

            cmd.ExecuteNonQuery()

            cnn1.Close()
            Return True

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function ProposalAcceptedEmail(ByVal lProposalId As Integer, ByVal companyid As Integer) As Boolean
        Try
            Dim ProposalObject = LocalAPI.GetRecord(lProposalId, "ProposalRecord_SELECT")
            Dim sClientEmail As String = ProposalObject("ClientEmail")
            Dim ClientId = ProposalObject("ClientId")
            If Not LocalAPI.sys_IsLog(sClientEmail, LocalAPI.sys_log_AccionENUM.AceptProposal, companyid, "Proposal ID: " & lProposalId) Then
                LocalAPI.sys_log_Nuevo(sClientEmail, LocalAPI.sys_log_AccionENUM.AceptProposal, companyid, "Proposal ID: " & lProposalId)

                Dim CompanyName As String = LocalAPI.GetCompanyProperty(companyid, "Name")

                Dim sSubject As String = "Proposal Acceptance Confirmation: " & ProposalObject("ProjectName")
                Dim sMsg As New System.Text.StringBuilder

                sMsg.Append("Greetings,")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Thank you for choosing " & CompanyName & " and accepting the proposal for ")
                sMsg.Append("<a href=" & """" & ProposalObject("ProposalURL") & """" & ">" & ProposalObject("ProjectName") & "</a>.")
                sMsg.Append("<br />")
                sMsg.Append("We look forward to working with you on this project. Should you have any questions, feel free to contact me, " & ProposalObject("ProposalBy") & " at the contact information below.")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Thank you,")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append(ProposalObject("ProposalBy"))
                sMsg.Append("<br />")
                sMsg.Append(CompanyName)
                sMsg.Append("<br />")
                sMsg.Append(ProposalObject("ProposalByEmail"))
                sMsg.Append("<br />")
                sMsg.Append(LocalAPI.GetCompanyProperty(companyid, "Phone"))

                Dim sBody As String = sMsg.ToString
                Dim sCC As String = ""
                Dim sProjectManagerEmail As String = ""
                Dim sCCO As String = ""
                If LocalAPI.IsCompanyNotification(companyid, "Notification_AceptedProposal") Then
                    sProjectManagerEmail = LocalAPI.GetProjectManagerEmailFromProposal(lProposalId)
                    sCC = sProjectManagerEmail & IIf(Len(sProjectManagerEmail) > 0, ", ", "") & LocalAPI.GetCompanyProperty(companyid, "webEmailProfitWarningCC")
                    sCCO = LocalAPI.GetHeadDepartmentEmailFromProposal(lProposalId)
                End If


                If companyid = 260962 Then
                    ' !!! Parche1, copia a Raissa
                    Dim departmentId As Integer = LocalAPI.GetProposalProperty(lProposalId, "DepartmentId")
                    Select Case departmentId
                        Case 3, 4, 5, 12
                            sCC = sCC & IIf(Len(sCC) > 0, ", ", "") & "raissa@easterneg.com"
                    End Select
                End If


                Dim sProjectManagerName As String = ""
                If Len(sProjectManagerEmail) > 0 Then
                    sProjectManagerName = LocalAPI.GetEmployeeFullName(sProjectManagerEmail, companyid)
                End If
                Task.Run(Function() SendGrid.Email.SendMail(sClientEmail, sCC, sCCO, sSubject, sBody, companyid, ClientId, 0,,, sProjectManagerEmail, sProjectManagerName))


                Dim recipientEmailSent As String = sCC & IIf(Len(sCCO) > 0, "," & sCCO, "")
                OneSignalNotification.SendNotification(recipientEmailSent, "Proposal Accepted", "Proposal " & ProposalObject("ProposalNumber") & " from " & ProposalObject("ClientName") & " has been accepted. Click here to view.", ProposalObject("ProposalURL"), companyid)

            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function NewJobEmail(lProposalId As Integer, ByVal JobId As Integer, ByVal companyid As Integer) As Boolean
        Try
            Dim sCC As String = ""
            Dim nClientId As Integer = LocalAPI.GetProposalData(lProposalId, "ClientId")

            Dim sAceptedDate As String = LocalAPI.GetProposalData(lProposalId, "AceptedDate")
            Dim ProposalNumber As String = LocalAPI.ProposalNumber(lProposalId)
            Dim JobCodeName As String = LocalAPI.GetJobCodeName(JobId)
            Dim JobGUID As String = LocalAPI.GetJobProperty(JobId, "guid")
            Dim guid As String = LocalAPI.GetJobCodeName(JobId)
            Dim sClientName As String = LocalAPI.GetClientName(nClientId)

            Dim sSubject As String = "New Job: " & JobCodeName
            Dim sMsg As New System.Text.StringBuilder

            sMsg.Append("Greetings,")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append(sClientName & " has accepted the Proposal " & ProposalNumber & " and has been created the Job: " & JobCodeName)
            sMsg.Append("<br />")
            sMsg.Append("Date: " & sAceptedDate)
            sMsg.Append("<br />")
            sMsg.Append("<br />")

            If companyid = 260962 Then
                Try
                    sCC = "mayte@easterneg.com,"
                    'Number,Name,Location,Client,Employee,Department,Type 
                    '18 605,Sloans Curve Cabana ,2100 S Ocean Blvd Parking, South Ocean Boulevard, Palm Beach, FL 33480, USA,The Windows guys of Florida,Celia Maria Suarez Quintas,Spec. Eng. WD,Shop Dwgs
                    sMsg.Append("<br />")
                    sMsg.Append("<b>Titleblock</b>")
                    sMsg.Append("<br />")
                    sMsg.Append("Click here to")
                    sMsg.Append("<a href=" & """" & LocalAPI.GetHostAppSite() & "/adm/titleblock.aspx?guid=" & JobGUID & """" & "> download Titleblock </a> csv file")
                    sMsg.Append("<br />")

                    sMsg.Append("<br />")
                    sMsg.Append("-------------------------------------------------------------------------------------------------------")
                    sMsg.Append("<br />")
                    sMsg.Append("<br />")
                    sMsg.Append("<b>Scope of Work</b>")
                    sMsg.Append("<br />")
                    sMsg.Append("Click here to ")
                    sMsg.Append("<a href=" & """" & LocalAPI.GetHostAppSite() & "/adm/scopeofwork.aspx?guid=" & JobGUID & """" & "> view Scope of Work </a> from Proposal Page")
                    sMsg.Append("<br />")

                Catch ex As Exception

                End Try
            End If

            sMsg.Append("<br />")
            sMsg.Append("Thank you.")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("PASconcept Notifications")
            sMsg.Append("<br />")
            sMsg.Append(LocalAPI.GetPASSign())

            Dim sBody As String = sMsg.ToString
            Dim sProjectManagerEmail As String = LocalAPI.GetProjectManagerEmailFromProposal(lProposalId)

            If Len(sProjectManagerEmail) > 0 Then
                sCC = sCC & LocalAPI.GetHeadDepartmentEmailFromProposal(lProposalId)
                Dim sProjectManagerName As String = LocalAPI.GetProjectManagerEmailFromProposal(lProposalId)
                If Len(sProjectManagerEmail) > 0 Then
                    sProjectManagerName = LocalAPI.GetEmployeeFullName(sProjectManagerEmail, companyid)
                End If

                Dim ProposalObject = LocalAPI.GetRecord(lProposalId, "ProposalRecord_SELECT")
                Dim ClientId = ProposalObject("ClientId")
                Task.Run(Function() SendGrid.Email.SendMail(sProjectManagerEmail, sCC, "", sSubject, sBody, companyid, ClientId, 0,,, sProjectManagerEmail, sProjectManagerName))

                Dim sProposalURL As String = "https://www.pasconcept.com/e2103445_8a47_49ff_808e_6008c0fe13a1/SingProposalSign.aspx?GuiId=" & LocalAPI.GetProposalProperty(lProposalId, "guid")
                Dim recipientEmailSent As String = sCC & IIf(Len(sProjectManagerEmail) > 0, "," & sProjectManagerEmail, "")
                OneSignalNotification.SendNotification(recipientEmailSent, "Proposal Accepted -> Job created", sClientName & " has accepted the Proposal " & ProposalNumber & " and has been created the Job: " & JobCodeName, sProposalURL, companyid)
            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function NoJobEmail(lProposalId As Integer, ByVal companyid As Integer) As Boolean
        Try
            '
            Dim sAceptedDate As String = LocalAPI.GetProposalData(lProposalId, "AceptedDate")
            Dim ProposalNumber As String = LocalAPI.ProposalNumber(lProposalId)

            Dim sSubject As String = "Alert. Proposal accepted " & ProposalNumber & ", And no Job created!!!"
            Dim sMsg As New System.Text.StringBuilder

            sMsg.Append("PASconcept Alert!!!,")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("The Proposal (<strong>" & ProposalNumber & "</strong>) has been acepted and a Job was not created!!!")
            sMsg.Append("<br />")
            sMsg.Append("Date: " & sAceptedDate)
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Thank you.")

            Dim sBody As String = sMsg.ToString
            Dim sCC As String = ""
            Dim sProjectManagerEmail As String = ""
            Dim sCCO As String = ""
            sProjectManagerEmail = LocalAPI.GetProjectManagerEmailFromProposal(lProposalId)
            sCC = sProjectManagerEmail & IIf(Len(sProjectManagerEmail) > 0, ",", "") & LocalAPI.GetCompanyProperty(companyid, "webEmailProfitWarningCC")
            sCCO = "jcarlos@axzes.com," & LocalAPI.GetHeadDepartmentEmailFromProposal(lProposalId)

            Dim sProjectManagerName As String = ""
            If Len(sProjectManagerEmail) > 0 Then
                sProjectManagerName = LocalAPI.GetEmployeeFullName(sProjectManagerEmail, companyid)
            End If

            Dim ProposalObject = LocalAPI.GetRecord(lProposalId, "ProposalRecord_SELECT")
            Dim ClientId = ProposalObject("ClientId")

            Task.Run(Function() SendGrid.Email.SendMail(sProjectManagerEmail, sCC, sCCO, sSubject, sBody, companyid, ClientId, 0,,, sProjectManagerEmail, sProjectManagerName))

            Dim sProposalURL As String = "https://www.pasconcept.com/e2103445_8a47_49ff_808e_6008c0fe13a1/SingProposalSign.aspx?GuiId=" & LocalAPI.GetProposalProperty(lProposalId, "guid")
            Dim recipientEmailSent As String = sCC & IIf(Len(sProjectManagerEmail) > 0, "," & sProjectManagerEmail, "")
            recipientEmailSent = recipientEmailSent & "," & sCCO
            OneSignalNotification.SendNotification(recipientEmailSent, "Proposal accepted Alert!!!", "Proposal " & ProposalNumber & " has accepted and Job was not created!!!", sProposalURL, companyid)

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function GetSignProposal(ByVal Id As Integer) As Byte()
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = New SqlCommand("SELECT AceptanceSignature FROM [Proposal] WHERE [Id]=@Id", cnn1)
            cmd.Parameters.AddWithValue("@Id", Id)

            Return cmd.ExecuteScalar
            cnn1.Close()

        Catch ex As Exception
            'Throw ex
            Return Nothing
        End Try
    End Function
    Public Shared Function AceptRFP(Id As Integer, AceptanceName As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("update RequestForProposals set AceptanceName=@name where Id=@Id", cnn1)
            cmd.CommandType = CommandType.Text
            cmd.Parameters.AddWithValue("@name", Left(AceptanceName, 80))
            cmd.Parameters.AddWithValue("@Id", Id)

            cmd.ExecuteNonQuery()

            cnn1.Close()
            Return True

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function SignRFP(Id As Integer, AceptanceName As String, img64 As String) As Boolean
        Try
            ' Convertir a image
            'Dim img As System.Drawing.Image = Base64ToImage(img64.Replace("data:image/png;base64,", ""))

            'Convert Image to Byte Array
            Dim imgBytes As Byte() = Convert.FromBase64String(img64.Replace("data:image/png;base64,", ""))

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("update RequestForProposals set AceptanceName=@name,AceptanceSignature=@img where Id=@Id", cnn1)
            cmd.CommandType = CommandType.Text
            cmd.Parameters.AddWithValue("@name", Left(AceptanceName, 80))
            cmd.Parameters.AddWithValue("@Id", Id)
            cmd.Parameters.Add("@img", Data.SqlDbType.Image).Value = imgBytes

            cmd.ExecuteNonQuery()

            cnn1.Close()
            Return True

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function ProposalNumber(ByVal Id As Integer) As String
        Return GetStringEscalar("SELECT dbo.ProposalNumber(" & Id & ")")
    End Function

    Public Shared Function IsPhases(ByVal proposalId As Integer) As Integer
        Return GetNumericEscalar($"select count(*) from Proposal_phases where proposalId={proposalId}")
    End Function


    Public Shared Function Proposal_GeneratePaymentSchedules(proposalId As Integer, psId As Integer) As Boolean
        Try
            Dim psValues As String = GetStringEscalar("SELECT PaymentsScheduleList FROM Invoices_types WHERE [Id]=" & psId)
            Dim psText As String = GetStringEscalar("SELECT PaymentsTextList FROM Invoices_types WHERE [Id]=" & psId)

            Dim sArrValues As String() = Split(psValues, ",")
            Dim sArrText As String() = Split(psText, ",")
            Dim i As Int16, j As Int16
            Dim nValues As Integer = sArrValues.Length
            If nValues > 10 Then nValues = 10
            If nValues > 0 Then
                For i = 0 To nValues - 1
                    If Len(sArrValues(i).ToString) > 0 Then
                        ExecuteNonQuery("UPDATE Proposal SET " &
                                        "[PaymentSchedule" & i + 1 & "]=" & sArrValues(i) & "," &
                                        "[PaymentText" & i + 1 & "]='" & sArrText(i) & "' " &
                                        "WHERE [Id]=" & proposalId
                                        )
                    Else
                        ExecuteNonQuery("UPDATE Proposal SET " &
                                       "[PaymentSchedule" & i + 1 & "]=Null," &
                                       "[PaymentText" & i + 1 & "]='" & sArrText(i) & "' " &
                                       "WHERE [Id]=" & proposalId
                                       )
                    End If
                Next
            End If
            For j = i To 9
                ExecuteNonQuery("UPDATE Proposal SET " &
                                    "[PaymentSchedule" & j + 1 & "]=NULL," &
                                    "[PaymentText" & j + 1 & "]=NULL " &
                                    "WHERE [Id]=" & proposalId
                                    )
            Next


        Catch ex As Exception

        End Try


    End Function

    Public Shared Function SetProposalRetainer(ByVal proposalId As Long, RetainerValue As Integer) As Boolean
        Return ExecuteNonQuery($"UPDATE [Proposal] SET [Retainer]={RetainerValue} WHERE Id={proposalId}")
    End Function
    Public Shared Function SetProposalLumpSum(ByVal proposalId As Long, LumpSumValue As Integer) As Boolean
        Return ExecuteNonQuery($"UPDATE [Proposal] SET [LumpSum]={LumpSumValue} WHERE Id={proposalId}")
    End Function
#End Region

#Region "Transmittal"
    Public Shared Function GetTransmittalProperty(transmittalId As Integer, sProperty As String) As String
        Select Case sProperty
            Case "guid"
                Return GetStringEscalar("SELECT TOP 1 [" & sProperty & "] FROM Transmittals where Id=" & transmittalId)

            Case "JobId", "Number", "Status"
                ' Valores Integer
                Return GetNumericEscalar("SELECT TOP 1 isnull([" & sProperty & "],0) FROM Transmittals where Id=" & transmittalId)

            Case "ClientId", "Client"
                Return GetNumericEscalar("SELECT TOP 1 Jobs.Client FROM Transmittals inner join Jobs on Transmittals.JobId = Jobs.Id where Transmittals.Id=" & transmittalId)
            Case Else
                Return GetStringEscalar("SELECT TOP 1 [" & sProperty & "] FROM Transmittals INNER JOIN Jobs ON Transmittals.JobId = Jobs.Id where Transmittals.Id=" & transmittalId)
        End Select
    End Function

    Public Shared Function GetTransmittalDigitalFilesCount(transmittalId As Integer) As Integer
        Return GetNumericEscalar(String.Format($"select count(*) from (select Id FROM [dbo].[Azure_Uploads] WHERE EntityType='Transmittal' AND EntityId={transmittalId} AND isnull([Public],0)=1	union all select Id FROM [Jobs_links] where isnull(TransmittalId,0)={transmittalId})T"))
    End Function

    Public Shared Function SetTransmittalStatusClientVisited(ByVal transmittalId As Long) As Boolean
        ExecuteNonQuery($"UPDATE [Transmittals] SET [PickUpDate]=dbo.CurrentTime() WHERE Id={transmittalId} and [PickUpDate]Is Null")
        Return ExecuteNonQuery($"UPDATE [Transmittals] SET [Status]=2 WHERE Id={transmittalId} and [Status]<>2")
    End Function
    Public Shared Function SetTransmittalEmailSent(transmittalId As Long, Notes As String, ReceiveBy As String) As Boolean
        Try
            Return ExecuteNonQuery($"UPDATE [Transmittals] SET [Notes]=isnull([Notes],'') + ' ' +'{Notes}', ReceiveBy='{ReceiveBy}'  WHERE Id={transmittalId} and [Status]<>2")
        Catch ex As Exception
        End Try
    End Function


    Public Shared Function TransmittalNumber(ByVal Id As Integer) As String
        Return GetStringEscalar("SELECT dbo.TransmittalNumber(" & Id & ")")
    End Function
    Public Shared Function SetTransmittalJobToDoneStatus(Id As Integer) As Boolean
        Dim jobId As Integer = GetTransmittalProperty(Id, "JobId")
        Dim companyId As Integer = GetJobProperty(jobId, "companyId")
        Dim employeeId As Integer = GetJobProperty(jobId, "Employee")
        ' Ultimo parametro no se va a usar
        SetJobStatus(jobId, 7, employeeId, companyId, 0)

    End Function

    Public Shared Function GetTransmittalStatusLabelCSS(ByVal statusId As Integer) As String
        Select Case statusId
            Case 0  'Not Ready
                Return "badge badge-warning statuslabel"
            Case 1  'Ready for Pick Up
                Return "badge badge-danger statuslabel"
            Case 2  'Picked Up
                Return "badge badge-success statuslabel"
            Case Else
                Return "badge badge-secondary statuslabel"
        End Select

    End Function
    Public Shared Function GetRevisionsStatusLabelCSS(ByVal statusId As String) As String
        Select Case statusId
            Case 0, "Under Revision"
                Return "badge badge-danger statuslabel"
            Case 1, "Approved"
                Return "badge badge-success statuslabel"
            Case Else
                Return "badge badge-secondary statuslabel"
        End Select

    End Function


    Public Shared Function EmailJobInactive(ByVal jobId As Integer, employeeId As Integer, ByVal companyId As Integer) As Boolean
        Try
            '
            Dim nClientId As Integer = LocalAPI.GetJobProperty(jobId, "Client")

            If LocalAPI.IsClientNotification(nClientId, "Notification_invoicecollected") Then


                Dim sJobName As String = LocalAPI.GetJobName(jobId)
                Dim sSubject As String = "Project [" & sJobName & "] has been done. " & LocalAPI.GetCompanyProperty(companyId, "Name")
                Dim sClientEmail As String = LocalAPI.GetClientEmail(nClientId)
                Dim sEmployeeEmail As String = LocalAPI.GetEmployeeEmail(employeeId)
                Dim sClientName As String = LocalAPI.GetClientName(nClientId)
                Dim sMsg As New System.Text.StringBuilder

                sMsg.Append("Dear " & sClientName)
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("It is our pleasure to inform you that our work on the " & sJobName & " project has been completed. We greatly value your trust and confidence and sincerely appreciate your loyalty to our business. We know you have a world full of choices. We appreciate the confidence you have placed in us and we look forward to providing you with the best possible service in the future.")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Thank you,")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("<strong>" & GetCompanyProperty(companyId, "EmailSign") & "</strong>")
                sMsg.Append("<br />")
                sMsg.Append(GetCompanyProperty(companyId, "EmailSign2"))
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append(LocalAPI.GetPASShortSign())

                Dim sBody As String = sMsg.ToString

                Task.Run(Function() SendGrid.Email.SendMail(sClientEmail, "", sEmployeeEmail, sSubject, sBody, companyId, nClientId, jobId))

                OneSignalNotification.SendNotification(sEmployeeEmail, "Project has been completed", sSubject, "", companyId)

            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function SetTransmittalJobToSubmitted(Id As Integer) As Boolean
        Dim jobId As Integer = GetTransmittalProperty(Id, "JobId")
        Dim companyId As Integer = GetJobProperty(jobId, "companyId")
        Dim employeeId As Integer = GetJobProperty(jobId, "Employee")
        ' Ultimo parametro no se va a usar
        SetJobStatus(jobId, 4, employeeId, companyId, 0)
    End Function

    Public Shared Function SignTransmittal(Id As Integer, SignName As String, img64 As String) As Boolean
        Try
            ' Convertir a image
            'Dim img As System.Drawing.Image = Base64ToImage(img64.Replace("data:image/png;base64,", ""))

            'Convert Image to Byte Array
            Dim imgBytes As Byte() = Convert.FromBase64String(img64.Replace("data:image/png;base64,", ""))

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("update Transmittals set ReceiveBy=@name,SignImage=@img, PickUpDate=" & GetDateUTHlocal() & ", Status=2 where Id=@Id", cnn1)
            cmd.CommandType = CommandType.Text
            cmd.Parameters.AddWithValue("@name", Left(SignName, 80))
            cmd.Parameters.AddWithValue("@Id", Id)
            cmd.Parameters.Add("@img", Data.SqlDbType.Image).Value = imgBytes

            cmd.ExecuteNonQuery()

            cnn1.Close()

            SetTransmittalJobToSubmitted(Id)
            Return True

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function IsTransmittalReadyToSigned(transmittalId As Integer) As Boolean
        Dim sSignedName As String = LocalAPI.GetTransmittalProperty(transmittalId, "ReceiveBy")
        Dim Status As Integer = LocalAPI.GetTransmittalProperty(transmittalId, "Transmittals].[Status")
        Return (Len(sSignedName) = 0) And (Status = 1)
    End Function

    Public Shared Function EmailReadyToPickUp(ByVal transmittalId As Integer, ByVal companyid As Integer, replyEmail As String, replyDisplay As String) As Boolean
        Try
            '
            Dim nClientId As Integer = LocalAPI.GetTransmittalProperty(transmittalId, "Client")

            Dim JobId As Integer = LocalAPI.GetTransmittalProperty(transmittalId, "JobId")
            Dim sJobName As String = LocalAPI.GetTransmittalProperty(transmittalId, "Job")
            Dim sJobCode As String = LocalAPI.GetTransmittalProperty(transmittalId, "Code")
            Dim sReadyDate As String = LocalAPI.GetTransmittalProperty(transmittalId, "ReadyDate")
            Dim sSubject As String = "The Transmittal Letter for Project [" & sJobName & "] has been emitted by " & LocalAPI.GetCompanyProperty(companyid, "Name")
            Dim sClientEmail As String = LocalAPI.GetClientEmail(nClientId)
            Dim sMsg As New System.Text.StringBuilder

            sMsg.Append("Greetings,")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("The Project <strong>[" & sJobCode & "]. " & sJobName & "</strong> is ready to be picked up at our office.")
            sMsg.Append("<br />")
            sMsg.Append("As of: " & sReadyDate)
            sMsg.Append("<br />")
            sMsg.Append("If there is any pending balance as per contract, please bring the amount due.")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("To see package content click ")
            ' Crear enlace SharedLink.............................................................
            sMsg.Append("<a href=" & """" & LocalAPI.GetSharedLink_URL(6, transmittalId) & """" & ">here</a>")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<a href=" & """" & LocalAPI.GetSharedLink_URL(7, JobId) & """" & ">Click here</a>")
            sMsg.Append(" to view additional information associated to " & sJobName)
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Thank you,")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<strong>" & GetCompanyProperty(companyid, "EmailSign") & "</strong>")
            sMsg.Append("<br />")
            sMsg.Append(GetCompanyProperty(companyid, "EmailSign2"))
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append(LocalAPI.GetPASSign())

            Dim sBody As String = sMsg.ToString
            Dim clientid = LocalAPI.GetJobProperty(JobId, "Client")
            Return SendGrid.Email.SendMail(sClientEmail, "", "", sSubject, sBody, companyid, clientid, JobId,,, replyEmail, replyDisplay)

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function GetProposalPhasesCount(proposalId As Integer) As Integer
        Return GetNumericEscalar(String.Format("select count(*) from [Proposal_phases] where proposalId={0}", proposalId))
    End Function
    Public Shared Function GetCompanyPhasesCount(companyId As Integer) As Integer
        Return GetNumericEscalar($"select count(*) from [Proposal_phases_template] where companyId={companyId}")
    End Function

    Public Shared Function GetScopeOfWork(proposalId As Integer, ByRef sb As StringBuilder) As Boolean
        Dim cnn1 As SqlConnection = GetConnection()
        Dim cmd As New SqlCommand("SELECT Proposal_details.Description, ISNULL(Proposal_details.DescriptionPlus, '') AS DescriptionPlus, Proposal_phases.Code as PhaseCode, Proposal_phases.Name as PhaseName FROM Proposal_details INNER JOIN Proposal_tasks ON Proposal_details.TaskId = Proposal_tasks.Id LEFT OUTER JOIN Proposal_phases ON Proposal_details.phaseId = Proposal_phases.Id WHERE (Proposal_details.ProposalId = " & proposalId & ") AND (Proposal_tasks.taskcode<>'999') AND (Proposal_details.taskId<>3457) ORDER BY Proposal_phases.nOrder, Proposal_details.OrderBy", cnn1)
        Dim rdr As SqlDataReader
        rdr = cmd.ExecuteReader
        Do While rdr.Read()
            Try
                If rdr.HasRows Then
                    sb.AppendLine(rdr("Description"))
                    sb.AppendLine(rdr("DescriptionPlus"))
                    sb.AppendLine("<br/>")
                End If
            Catch ex As Exception
                ' Pasar del error
            End Try
        Loop
        rdr.Close()
        cnn1.Close()


    End Function
#End Region

#Region "Contacts"
    Public Shared Function GetContactProperty(contactId As Integer, sProperty As String) As String
        Return GetStringEscalar("SELECT isnull([" & sProperty & "],'') FROM Contacts where Id=" & contactId)
    End Function

    Public Shared Function GetContactId(Email As String) As Integer
        Return GetNumericEscalar("SELECT top 1 Id FROM Contacts where Email='" & Email & "' order by id desc")
    End Function

    Public Shared Function IsContactByEmail(ByVal Email As String, ByVal companyId As Integer) As Boolean
        Return (GetNumericEscalar("SELECT COUNT(*) FROM Contacts WHERE companyId=" & companyId & " AND ISNULL(Email,'')='" & Email & "'") > 0)
    End Function

    Public Shared Function GetContactTypeId(sTypeName As String, companyId As Integer) As Integer
        Try
            Return GetNumericEscalar("select top 1 Id from [Clients_types] where Name='" & sTypeName & "' and companyId=" & companyId)

        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Shared Function GetContactClassLabelCSS(ByVal contactTypeName As String) As String
        Select Case contactTypeName
            Case "SubConsultant"
                Return "badge badge-dark"
            Case "Employee"
                Return "badge badge-info"
            Case "Contact"
                Return "badge badge-secondary"
            Case "Client"
                Return "badge badge-success"
            Case "Vendor"
                Return "badge badge-warning"
        End Select
    End Function


    Public Shared Function DeleteContact(contactId As Integer) As Boolean
        ExecuteNonQuery("DELETE FROM Contacts WHERE Id=" & contactId)
    End Function
    Public Shared Function UpdateContactTAGS(contactId As Integer, NewTag As String) As Boolean
        Dim sTags As String = GetStringEscalar("select top 1 isnull(TAGS,'') from [Contacts] where Id=" & contactId)
        If Len(sTags) = 0 Then
            sTags = NewTag
        Else
            sTags = Left(sTags & "," & NewTag, 80)
        End If
        ExecuteNonQuery("UPDATE Contacts SET TAGS='" & sTags & "' WHERE Id=" & contactId)
    End Function

    Public Shared Function GetContactClassId(sClassName As String) As Integer
        Try
            Return GetNumericEscalar("select top 1 Id from [Contacts_class] where Name='" & sClassName & "'")

        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Shared Function ExportedContacts_UPDATE(ContactObject As LocalAPI.ContactStruct, CompanyId As Integer) As Integer
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            cmd.CommandText = "ContactExportedCSV_UPDATE"
            cmd.CommandType = CommandType.StoredProcedure

            'cmd.Parameters.AddWithValue("@ID", ContactObject.ID)
            cmd.Parameters.AddWithValue("@FirstName", ContactObject.FirstName)
            cmd.Parameters.AddWithValue("@LastName", ContactObject.LastName)
            cmd.Parameters.AddWithValue("@Company", ContactObject.Company)
            cmd.Parameters.AddWithValue("@Position", ContactObject.Position)
            cmd.Parameters.AddWithValue("@Address", ContactObject.Address)
            cmd.Parameters.AddWithValue("@Address2", ContactObject.Address2)
            cmd.Parameters.AddWithValue("@City", ContactObject.City)
            cmd.Parameters.AddWithValue("@State", ContactObject.State)
            cmd.Parameters.AddWithValue("@ZipCode", ContactObject.ZipCode)
            cmd.Parameters.AddWithValue("@Country", ContactObject.Country)
            cmd.Parameters.AddWithValue("@Phone", ContactObject.Phone)
            cmd.Parameters.AddWithValue("@BusinessPhone", ContactObject.BusinessPhone)
            cmd.Parameters.AddWithValue("@Fax", ContactObject.Fax)
            cmd.Parameters.AddWithValue("@Cellular", ContactObject.Cellular)
            cmd.Parameters.AddWithValue("@Email", ContactObject.Email)
            cmd.Parameters.AddWithValue("@BusinessEmail", ContactObject.BusinessEmail)
            cmd.Parameters.AddWithValue("@Web", ContactObject.WebPage)
            cmd.Parameters.AddWithValue("@Notes", ContactObject.Notes)

            cmd.Parameters.AddWithValue("@ContactType", ContactObject.ContactType)
            cmd.Parameters.AddWithValue("@ContactSubtype", ContactObject.ContactSubtype)
            cmd.Parameters.AddWithValue("@ReferredBy", ContactObject.ReferredBy)

            cmd.Parameters.AddWithValue("@CompanyId", CompanyId)

            cmd.ExecuteNonQuery()

            cnn1.Close()
            Return 1

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function ContactFromOutlook_INSERT(ContactObject As LocalAPI.ContactStruct, UpdateFlag As Boolean, CompanyId As Integer) As Integer
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()
            cmd.CommandText = "ContactFromOutlookCSV_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@FirstName", ContactObject.FirstName)
            cmd.Parameters.AddWithValue("@LastName", ContactObject.LastName)
            cmd.Parameters.AddWithValue("@Company", ContactObject.Company)
            cmd.Parameters.AddWithValue("@Position", ContactObject.Position)
            cmd.Parameters.AddWithValue("@Address", ContactObject.Address)
            cmd.Parameters.AddWithValue("@Address2", ContactObject.Address2)
            cmd.Parameters.AddWithValue("@City", ContactObject.City)
            cmd.Parameters.AddWithValue("@State", ContactObject.State)
            cmd.Parameters.AddWithValue("@ZipCode", ContactObject.ZipCode)
            cmd.Parameters.AddWithValue("@Country", "" & ContactObject.Country)
            cmd.Parameters.AddWithValue("@Phone", ContactObject.Phone)
            cmd.Parameters.AddWithValue("@BusinessPhone", "" & ContactObject.BusinessPhone)
            cmd.Parameters.AddWithValue("@Fax", ContactObject.Fax)
            cmd.Parameters.AddWithValue("@Cellular", ContactObject.Cellular)
            cmd.Parameters.AddWithValue("@Email", ContactObject.Email)
            cmd.Parameters.AddWithValue("@BusinessEmail", "" & ContactObject.BusinessEmail)
            cmd.Parameters.AddWithValue("@Web", ContactObject.WebPage)
            cmd.Parameters.AddWithValue("@Notes", ContactObject.Notes)

            cmd.Parameters.AddWithValue("@FullHomeAddress", "" & ContactObject.FullHomeAddress)
            cmd.Parameters.AddWithValue("@ContactType", Trim(ContactObject.ContactType))
            cmd.Parameters.AddWithValue("@ContactSubtype", Trim(ContactObject.ContactSubtype))
            cmd.Parameters.AddWithValue("@ReferredBy", ContactObject.ReferredBy)

            cmd.Parameters.AddWithValue("@CompanyId", CompanyId)
            cmd.Parameters.AddWithValue("@UpdateFlag", IIf(UpdateFlag, 1, 0))

            Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            cnn1.Close()
            Return parOUT_ID.Value

        Catch ex As Exception
            Throw ex
        End Try
    End Function

#End Region

#Region "AXZES_Billing_Comm"
    Public Shared Function AXZES_BillClient(cliId As Integer, InvoiceDate As String, jobId As Integer, Total As String, InvoiceNotes As String) As Integer
        Try


            Dim invoiceId As Integer = NuevoInvoiceSimpleCharge(jobId, InvoiceDate, Total, InvoiceNotes)

            ActualizarEmittedInvoice(invoiceId, 0)

            Return invoiceId
        Catch ex As Exception
            Throw ex
        End Try

    End Function
    Public Shared Function NewBilling_plan(ByRef Billing_planName As String, billing_baseprice As Double, billing_baseusers As Integer, billing_otheruser As Double) As Integer
        Try
            ExecuteNonQuery("INSERT INTO Billing_plans(Name, billing_baseprice, billing_baseusers, billing_otheruser) " &
                                   "VALUES ('" & Billing_planName & "'," & FormatearNumero2Tsql(billing_baseprice) & "," & billing_baseusers & "," & FormatearNumero2Tsql(billing_otheruser) & ")")
        Catch ex As Exception
        End Try
        Return GetNumericEscalar("SELECT TOP 1 [Id] FROM [Billing_plans] where [Name]='" & Billing_planName & "'")

    End Function

    Public Shared Function Axzes_Job_001() As Integer

        Dim axzesCompanyId As Integer = 260973
        Dim cnn1 As SqlConnection = GetConnection()
        Dim cmd As New SqlCommand("SELECT Id, isnull(Company,Name) as Company from Clients where companyId=260973 and Id not in (select client from jobs where Type='001' and companyId=260973) and email in(select Email from company where version in(1,2))", cnn1)
        Dim rdr As SqlDataReader
        rdr = cmd.ExecuteReader
        Dim Code As String
        Dim jcarlosEmployeeId As Integer = 149
        Dim nRecs As Integer
        Do While rdr.Read()
            Try
                If rdr.HasRows Then
                    '7.- Crear Job Type 001
                    Code = GetNextJobCode(Right(Year(GetDateTime()), 2), axzesCompanyId)
                    'Code = Right(GetDateTime().Year, 2) & "-" & LocalAPI.GetNewJobCode(Right(GetDateTime().Year, 2), axzesCompanyId)

                    If LocalAPI.NuevoJob(Code, "M. " & rdr("Company"), GetDateTime(), rdr("Id"), 0, 0, "001", jcarlosEmployeeId, "3401 NW 82nd Ave Suite 370", "", 2, "B", "", 23, "", 0, 0, axzesCompanyId, False) > 0 Then
                        nRecs = nRecs = 1
                    End If
                End If
            Catch ex As Exception
                ' Pasar del error
            End Try
        Loop
        rdr.Close()
        cnn1.Close()
        Return nRecs


    End Function

    Public Shared Function MasterMassCommunication(ByVal ToType As Integer, Subject As String, Body As String, Optional EmailTo As String = "") As Integer
        Try
            Dim res As Integer
            Dim sSQL As String
            Dim FinalBody As String
            Select Case ToType
                Case 0  ' Email directos
                    If Len(EmailTo) > 0 Then
                        FinalBody = Replace(Body, "[UserName]", "User Name Replaced")
                        SendGrid.Email.SendMail(EmailTo, "", "", Subject, FinalBody, 260973, 0, 0,, "Matt Mur", "matt@axzes.com")
                        res = 1
                    End If

                Case 1 'Active Users (Employees) 
                    sSQL = "select Id, Email, FullName from Employees where isnull(Inactive,0)=0"
                Case 2 'Inactive Users (Employees)
                    sSQL = "select Id, Email, FullName from Employees where isnull(Inactive,0)=1"
                Case 3 'Active/Inactive Users (Employees)
                    sSQL = "select Id, Email, FullName from Employees "

                Case 4 'Active Company (Master Contact)
                    sSQL = "select Id=CompanyId, Email, FullName=Contact+' ('+Name+')'  from Company where billingExpirationDate>dbo.CurrentTime()"
                Case 5 'Inactive Company (Master Contact)
                    sSQL = "select Id=CompanyId, Email, FullName=Contact+' ('+Name+')'  from Company where billingExpirationDate<=dbo.CurrentTime()"
                Case 6 'All Active/Inactive Company (Master Contact)
                    sSQL = "select Id=CompanyId, Email, FullName=Contact+' ('+Name+')' from Company"

            End Select

            If ToType > 0 Then
                Dim cnn1 As SqlConnection = GetConnection()
                Dim cmd As New SqlCommand(sSQL, cnn1)
                Dim rdr As SqlDataReader
                rdr = cmd.ExecuteReader
                Do While rdr.Read()
                    If rdr.HasRows Then
                        Try
                            FinalBody = Replace(Body, "[UserName]", rdr("FullName"))
                            SendGrid.Email.SendMail(rdr("Email"), "", "", Subject, FinalBody, 260973, 0, 0, , "Matt Mur", "matt@axzes.com")
                        Catch ex As Exception
                        End Try
                    End If
                Loop
                rdr.Close()
                cnn1.Close()

            End If

            Return res

        Catch ex As Exception
            Throw ex
        End Try
    End Function

#End Region

#Region "googleapis"
    Public Shared Function GetLatitudeLongitude(sAddress As String, ByRef Latitude As String, ByRef Longitude As String) As Boolean
        Try
            Dim APYKEY As String = "AIzaSyA2t_qhTxDXHZGWGGh1634BZZtWrtauIKY"
            'Google APIs & Services (PASconcept api geocode)  https://console.cloud.google.com/apis/credentials?project=pas-geo-service
            Latitude = ""
            Longitude = ""
            Dim encodedAddress As String = HttpUtility.UrlEncode(sAddress).Replace("+", "%20")
            Dim googleApiURL As String = "https://maps.googleapis.com/maps/api/geocode/" + "xml?address=" + encodedAddress + "&sensor=false" + "&key=" + APYKEY
            Dim client As New WebClient()
            client.Headers.Add("geocode", "GetAddress")
            Dim data As Stream = client.OpenRead(googleApiURL)
            Dim reader As New StreamReader(data)
            Dim xmlRes As String = reader.ReadToEnd().Trim()
            data.Close()
            reader.Close()
            Dim posIni As Integer = InStr(xmlRes, "<lat>")
            Dim posFin As Integer = InStr(xmlRes, "</lat>")
            If posIni > 0 Then
                Latitude = Mid(xmlRes, posIni + 5, posFin - posIni - 5)
                posIni = InStr(xmlRes, "<lng>")
                posFin = InStr(xmlRes, "</lng>")
                Longitude = Mid(xmlRes, posIni + 5, posFin - posIni - 5)
                Return True
            End If

        Catch ex As Exception

        End Try

    End Function

    Public Shared Sub JobGeolocationUpdate(JobId As Integer)
        Try
            Dim Latitude As String = ""
            Dim Longitude As String = ""
            Dim sFullAddress As String = LocalAPI.GetJobProperty(JobId, "ProjectLocation")
            If Len(sFullAddress) > 2 Then
                If GetLatitudeLongitude(sFullAddress, Latitude, Longitude) Then
                    SetJobLatitudeLongitude(JobId, Latitude, Longitude)
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    Public Shared Sub ClientGeolocationUpdate(ClientId As Integer)
        Try

            Dim Latitude As String = ""
            Dim Longitude As String = ""
            Dim sFullAddress As String = LocalAPI.GetClientProperty(ClientId, "FullAddress")
            If Len(sFullAddress) > 2 Then
                If GetLatitudeLongitude(sFullAddress, Latitude, Longitude) Then
                    SetClientLatitudeLongitude(ClientId, Latitude, Longitude)
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    Public Shared Function SetJobLatitudeLongitude(ByVal lJob As Integer, Latitude As String, Longitude As String) As Boolean
        Try
            If Len(Latitude) > 0 And Len(Longitude) > 0 Then
                Return ExecuteNonQuery("UPDATE Jobs Set Latitude=" & Latitude & ",Longitude=" & Longitude & "  WHERE Id=" & lJob)
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function SetClientLatitudeLongitude(ByVal clientId As Integer, Latitude As String, Longitude As String) As Boolean
        Try
            If Len(Latitude) > 0 And Len(Longitude) > 0 Then
                Return ExecuteNonQuery("UPDATE Clients Set Latitude=" & Latitude & ",Longitude=" & Longitude & "  WHERE Id=" & clientId)
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function UpdateJobGeocodes() As Integer
        Try
            Dim Latitude As String
            Dim Longitude As String
            Dim res As Integer
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("Select Id, ProjectLocation FROM [Jobs] WHERE len(isnull(ProjectLocation,''))>3 and isnull(Latitude,0)=0 order by Id", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            Do While rdr.Read()
                If rdr.HasRows Then
                    Try
                        If GetLatitudeLongitude(rdr("ProjectLocation"), Latitude, Longitude) Then
                            SetJobLatitudeLongitude(rdr("Id"), Latitude, Longitude)
                            res = res + 1
                            'Else
                            '    SetJobLocationError(rdr("Id"))
                        End If
                    Catch ex As Exception
                    End Try
                End If
            Loop
            rdr.Close()
            cnn1.Close()
            Return res

        Catch ex As Exception
            Throw ex
        End Try
    End Function

#End Region

#Region "GridExcelLikeFiltering"
    Public Shared Function GetDataTable(Table As String, FieldAs As String) As DataTable
        Dim query As String = String.Format("SELECT DISTINCT Name FROM [{0}] AS {1} ORDER BY Name", Table, FieldAs)

        Dim cnn1 As SqlConnection = GetConnection()
        Dim adapter As New SqlDataAdapter()
        adapter.SelectCommand = New SqlCommand(query, cnn1)

        Dim myDataTable As New DataTable()
        Try
            adapter.Fill(myDataTable)
        Finally
            cnn1.Close()
        End Try

        Return myDataTable
    End Function


#End Region

#Region "Intuit.QuickBook"
    Public Shared Function IsQuickBookModule(companyId As Integer) As Boolean
        Return GetNumericEscalar("SELECT isnull([qbModule],0) FROM Company where companyId=" & companyId)
    End Function
    Public Shared Function IsQuickBookClients(companyId As Integer) As Boolean
        Return GetNumericEscalar("SELECT isnull([qbSynchronizeClients],0) FROM Company where companyId=" & companyId)
    End Function
    Public Shared Function IsQuickBookOnlinePayment(companyId As Integer) As Boolean
        Return GetNumericEscalar("SELECT isnull([qbOnlinePayment],0) FROM Company where companyId=" & companyId)
    End Function
    Public Shared Function IsQuickBookEmployees(companyId As Integer) As Boolean
        Return GetNumericEscalar("SELECT isnull([qbSynchronizeEmployees],0) FROM Company where companyId=" & companyId)
    End Function
    Public Shared Function IsQuickBookInvoices(companyId As Integer) As Boolean
        Return GetNumericEscalar("SELECT isnull([qbSynchronizeInvoices],0) FROM Company where companyId=" & companyId)
    End Function
    Public Shared Function GetqbAccessToken(companyId As Integer) As String
        Return GetStringEscalar("SELECT isnull([qbAccessToken],'') FROM Company where companyId=" & companyId)
    End Function
    Public Shared Function GetqbAccessTokenSecret(companyId As Integer) As String
        Return GetStringEscalar("SELECT isnull([qbAccessTokenSecret],'') FROM Company where companyId=" & companyId)
    End Function
    Public Shared Function GetqbCompanyID(companyId As Integer) As String
        Return GetStringEscalar("SELECT isnull([qbCompnyID],'') FROM Company where companyId=" & companyId)
    End Function

    Public Shared Function IsQuickBookDesckModule(companyId As Integer) As Boolean
        Return GetNumericEscalar("SELECT isnull([qbDesktopModule],0) FROM Company where companyId=" & companyId)
    End Function

    Public Shared Function GetqbCustomer(QBId As Integer) As Dictionary(Of String, Object)

        Dim result = New Dictionary(Of String, Object)()
        Try
            Using conn As SqlConnection = GetConnection()
                Using comm As New SqlCommand("select * from [Clients_SyncQB] where [QBId] = " & QBId, conn)
                    comm.CommandType = CommandType.Text

                    Dim reader = comm.ExecuteReader()
                    If reader.HasRows Then
                        ' We only read one time (of course, its only one result :p)
                        reader.Read()
                        For lp As Integer = 0 To reader.FieldCount - 1
                            Dim val = reader.GetValue(lp)
                            If TypeOf val Is DBNull Then
                                val = ""
                            End If
                            result.Add(reader.GetName(lp), val)
                        Next
                    End If
                End Using
            End Using
            Return result
        Catch e As Exception
            Return result
        End Try
    End Function

    Public Shared Function Vendor_INSERT(ByVal sName As String,
                                        ByVal companyId As Integer,
                                        Optional ByVal sEmail As String = "",
                                        Optional ByVal sCompany As String = "",
                                        Optional ByVal sAddress As String = "",
                                        Optional ByVal sAddress2 As String = "",
                                        Optional ByVal sCity As String = "",
                                        Optional ByVal sState As String = "",
                                        Optional ByVal sZipCode As String = "",
                                        Optional ByVal sPhone As String = "",
                                        Optional ByVal sCellular As String = "",
                                        Optional ByVal sFax As String = "",
                                        Optional ByVal sWeb As String = "",
                                        Optional ByVal sPosition As String = "",
                                        Optional ByVal sNotes As String = "",
                                        Optional ByVal Type As Integer = 0,
                                        Optional ByVal Subtype As Integer = 0,
                                        Optional ByVal NAICS_code As String = "") As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Vendor_v20_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Name", sName)
            cmd.Parameters.AddWithValue("@Position", sPosition)
            cmd.Parameters.AddWithValue("@Company", sCompany)
            cmd.Parameters.AddWithValue("@Type", Type)
            cmd.Parameters.AddWithValue("@Subtype", Subtype)
            cmd.Parameters.AddWithValue("@Address", sAddress)
            cmd.Parameters.AddWithValue("@Address2", sAddress2)
            cmd.Parameters.AddWithValue("@City", sCity)
            cmd.Parameters.AddWithValue("@State", sState)
            cmd.Parameters.AddWithValue("@ZipCode", sZipCode)
            cmd.Parameters.AddWithValue("@Phone", sPhone)
            cmd.Parameters.AddWithValue("@Cellular", sCellular)
            cmd.Parameters.AddWithValue("@Fax", sFax)
            cmd.Parameters.AddWithValue("@Email", sEmail)
            cmd.Parameters.AddWithValue("@Web", sWeb)
            cmd.Parameters.AddWithValue("@Notes", sNotes)
            cmd.Parameters.AddWithValue("@NAICS_code", NAICS_code)
            cmd.Parameters.AddWithValue("@companyId", companyId)

            ' Execute the stored procedure.
            Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            Dim clientId As Integer = parOUT_ID.Value
            cnn1.Close()

            LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewClient, companyId, sName)

            ' Update Latitude, Longitude
            LocalAPI.ClientGeolocationUpdate(clientId)

            Return clientId
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetqbVendors(QBId As Integer) As Dictionary(Of String, Object)

        Dim result = New Dictionary(Of String, Object)()
        Try
            Using conn As SqlConnection = GetConnection()
                Using comm As New SqlCommand("select * from [Vendors_SyncQB] where [QBId] = " & QBId, conn)
                    comm.CommandType = CommandType.Text

                    Dim reader = comm.ExecuteReader()
                    If reader.HasRows Then
                        ' We only read one time (of course, its only one result :p)
                        reader.Read()
                        For lp As Integer = 0 To reader.FieldCount - 1
                            Dim val = reader.GetValue(lp)
                            If TypeOf val Is DBNull Then
                                val = ""
                            End If
                            result.Add(reader.GetName(lp), val)
                        Next
                    End If
                End Using
            End Using
            Return result
        Catch e As Exception
            Return result
        End Try
    End Function
    Public Shared Function SetqbAccessToken(companyId As Integer, AccessToken As String, AccessTokenExpiresIn As Long) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "UPDATE Company Set qbAccessToken=@qbAccessToken, qbAccessTokenExpire =  DATEADD (ss, @AccessTokenExpiresIn, dbo.CurrentTime()) WHERE companyId=@companyId"

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@qbAccessToken", AccessToken)
            cmd.Parameters.AddWithValue("@AccessTokenExpiresIn", AccessTokenExpiresIn)

            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function SetqbRefreshToken(companyId As Integer, RefreshToken As String, RefreshTokenExpiresIn As Long) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "UPDATE Company Set qbAccessTokenSecret=@RefreshToken, qbRefreshTokenExpire =  DATEADD (ss, @RefreshTokenExpiresIn, dbo.CurrentTime()) WHERE companyId=@companyId"

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@RefreshToken", RefreshToken)
            cmd.Parameters.AddWithValue("@RefreshTokenExpiresIn", RefreshTokenExpiresIn)

            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function SetqbCompanyID(companyId As Integer, qbCompanyID As String) As Boolean
        Return ExecuteNonQuery("UPDATE [Company] SET [qbCompnyID]='" & qbCompanyID & "' WHERE companyId=" & companyId)
    End Function

    Public Shared Function IsQBEmployeeConnected(employeeId As Integer) As Boolean
        Return IIf(GetNumericEscalar("SELECT isnull([qbEmployeeId],0) FROM Employees where Id=" & employeeId) = 0, False, True)
    End Function
    Public Shared Function IsQBClientConnected(clientId As Integer) As Boolean
        Return IIf(GetNumericEscalar("SELECT isnull([qbCustomerId],0) FROM Clients where Id=" & clientId) = 0, False, True)
    End Function

#End Region

#Region "Ebillity Time Entries"
    Public Shared Function IsEbilityModule(companyId As Integer) As Boolean
        Return GetNumericEscalar("SELECT isnull([IsEbilityModule],0) FROM Company where companyId=" & companyId)
    End Function

    Public Shared Function GetEabillityAccessToken(companyId As Integer) As String
        Return GetStringEscalar("SELECT isnull([EbillityAccessToken],'') FROM Company where companyId=" & companyId)
    End Function
    Public Shared Function GetEbillityClientLastSyncDate(companyId As Integer) As String
        Return GetStringEscalar("SELECT isnull([EbillityClientLastSyncDate],0) FROM Company where companyId=" & companyId)
    End Function
    Public Shared Function SetEbillityClientLastSyncDate(companyId As Integer, LastSyncDate As Int64) As String
        Return GetStringEscalar($"update Company set [EbillityClientLastSyncDate] = {LastSyncDate} where companyId=" & companyId)
    End Function

    Public Shared Function Client_Sync_Ebillity_Clone(companyId As Integer, ClientId As Integer) As Integer
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "CLIENT_Sync_Ebillity_Clone"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter )
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@ClientId", ClientId)

            ' Execute the stored procedure.
            Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            Dim NewClientId As Integer = parOUT_ID.Value
            cnn1.Close()


            Return NewClientId
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Sub CLIENT_Sync_Ebillity_Link(companyId As Integer, ClientId As Integer, PC_Clientid As Integer)
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "CLIENT_Sync_Ebillity_Link"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter )
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@ClientId", ClientId)
            cmd.Parameters.AddWithValue("@PC_CLientId", PC_Clientid)

            ' Execute the stored procedure.

            cmd.ExecuteNonQuery()
            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Shared Sub CloneJobEbillity(ByRef ClientId As Integer, ByVal companyId As Integer)
        Try
            Dim record = LocalAPI.GetRecordFromQuery($"Select PC_ClientId, Case When (CHARINDEX(':', ClientName) > 0 ) then SUBSTRING(ClientName, CHARINDEX(':', ClientName)+1, 100 ) else ClientName end as ProjectName from [dbo].Clients_Sync_Ebillity where companyId = {companyId} and PC_ClientId is not null and ClientId = {ClientId}")
            Dim JobId = LocalAPI.NuevoJobEbillity(record("ProjectName"), record("PC_ClientId"), companyId)
            LocalAPI.ExecuteNonQuery($"update Clients_Sync_Ebillity set PC_JobId = {JobId} where ClientId = {ClientId}  and companyId={companyId}")
            LocalAPI.Ebillity_Run_After_Sync(companyId)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Shared Function NuevoJobEbillity(
                                        ByRef sJob As String,
                                        ByRef ClientId As Integer,
                                        ByVal companyId As Integer) As Long
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "JOB_EBillity_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@JobName", sJob)
            cmd.Parameters.AddWithValue("@ClientId", ClientId)
            cmd.Parameters.AddWithValue("@companyId", companyId)

            ' Execute the stored procedure.
            Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            Dim lJobId As Integer = parOUT_ID.Value
            cnn1.Close()


            Return lJobId

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Sub Activity_Sync_Ebillity_Clone(companyId As Integer, ActivityId As Integer)
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Time_Categories_Sync_Ebillity_Clone"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter )
            cmd.Parameters.AddWithValue("@companyId", companyId)
            cmd.Parameters.AddWithValue("@ActivityId", ActivityId)

            cmd.ExecuteNonQuery()

            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Shared Sub Ebillity_Run_After_Sync(companyId As Integer)
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Ebillity_Run_Sync"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter )
            cmd.Parameters.AddWithValue("@companyId", companyId)

            cmd.ExecuteNonQuery()

            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Shared Sub JobTimeEntries_Ebillity_Import(companyId As Integer)
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "JobTimeEntries_Ebillity_Import"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter )
            cmd.Parameters.AddWithValue("@companyId", companyId)

            cmd.ExecuteNonQuery()

            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Sub


#End Region

#Region "FilterClipboard"
    Public Shared Function IsFilterClipboard(employeeId As Integer, companyId As Integer) As Boolean
        Dim nRecs As Integer = GetNumericEscalar("SELECT count(*) FROM [Employee_Filterclipboard] WHERE companyId=" & companyId & " and employeeId=" & employeeId)
        Return IIf(nRecs = 0, False, True)
    End Function
    Public Shared Function ClearFilterClipboard(employeeId As Integer, companyId As Integer) As Boolean
        Return ExecuteNonQuery("DELETE FROM [Employee_Filterclipboard] WHERE companyId=" & companyId & " and employeeId=" & employeeId)
    End Function
    Public Shared Function CopyIntFilterClipboard(employeeId As Integer, fileldId As Integer, ValueInt As Integer, companyId As Integer) As Boolean
        Return ExecuteNonQuery("INSERT INTO [dbo].[Employee_Filterclipboard] ([employeeId],[fileldId],[ValueInt], companyId) VALUES(" & employeeId & "," & fileldId & "," & ValueInt & "," & companyId & ")")
    End Function
    Public Shared Function CopyTextFilterClipboard(employeeId As Integer, fileldId As Integer, ValueText As String, companyId As Integer) As Boolean
        Return ExecuteNonQuery("INSERT INTO [dbo].[Employee_Filterclipboard] ([employeeId],[fileldId],[ValueText], companyId) VALUES(" & employeeId & "," & fileldId & ",'" & ValueText & "'," & companyId & ")")
    End Function
    Public Shared Function GetIntFilterClipboard(employeeId As Integer, fileldId As Integer, companyId As Integer) As Integer
        Return GetNumericEscalar("SELECT isnull([ValueInt],0) FROM [Employee_Filterclipboard] WHERE companyId=" & companyId & " and employeeId=" & employeeId & " and fileldId=" & fileldId)
    End Function
    Public Shared Function GetTextFilterClipboard(employeeId As Integer, fileldId As Integer, companyId As Integer) As String
        Return GetStringEscalar("SELECT isnull([ValueText],'') FROM [Employee_Filterclipboard] WHERE companyId=" & companyId & " and employeeId=" & employeeId & " and fileldId=" & fileldId)
    End Function
#End Region

#Region "AzureStorage"
    Public Shared Function IsAzureStorage(companyId As Integer) As Boolean
        'Return IIf(GetNumericEscalar("SELECT isnull([azureStorage],0) FROM Company where companyId=" & companyId) = 0, False, True)
        Return True
    End Function

    Public Shared Function GetEntityAzureFilesCount(entityId As Integer, EntityLabel As String) As Integer
        Return GetNumericEscalar($"SELECT count(*) FROM [Azure_Uploads] where EntityType= '{EntityLabel}' and EntityId={entityId}")
    End Function
    Public Shared Function GetAzureFilesCount(clientId As Integer, proposalId As Integer, jobId As Integer) As Integer
        Return GetNumericEscalar($"SELECT count(*) FROM (select au.Id from Azure_Uploads au where [Deleted] = 0 and {clientId}>0 and au.EntityType='Clients' and au.EntityId = {clientId}
			union all
			select au.Id from [Azure_Uploads] au where  {proposalId}>0 and au.EntityType='Proposal' and au.EntityId = {proposalId} 
			union all
			select au.Id from [Azure_Uploads] au where {jobId}>0 and au.EntityType='Jobs' and au.EntityId = {jobId})F")
    End Function


    Public Shared Function GetAzureFileKeyName(Id As Integer) As String
        Return GetStringEscalar("SELECT isnull([KeyName],'') FROM [Azure_Uploads] where Id=" & Id)
    End Function

    Public Shared Function DeleteAzureFile(Id As Integer) As String
        Return ExecuteNonQuery("Delete FROM [Azure_Uploads] where Id=" & Id)
    End Function

    Public Shared Function DeleteAzureFileGuid(GUID As String) As Boolean
        Return ExecuteNonQuery(String.Format("DELETE FROM [Azure_Uploads] WHERE [guid]='{0}' and EntityId=0", GUID))
    End Function

    Private Shared Function ExistAzureFile(EntityId As Integer, EntityType As String, FileName As String, ContentBytes As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Azure_Uploads_Exist"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@EntityId", EntityId)
            cmd.Parameters.AddWithValue("@EntityType", EntityType)
            cmd.Parameters.AddWithValue("@OriginalFileName", FileName)
            cmd.Parameters.AddWithValue("@ContentBytes", ContentBytes)
            Dim value = cmd.ExecuteScalar()
            ExistAzureFile = (value > 0)
            cnn1.Close()
            Exit Function
        Catch ex As Exception
            Throw ex
        End Try
        ExistAzureFile = False
    End Function


    Public Shared Function AzureStorage_Insert(EntityId As Integer, EntityType As String, Type As Integer, FileName As String, KeyName As String, bPublic As Boolean, ContentBytes As Integer, ContentType As String, companyId As Integer) As Boolean
        Try
            If Not ExistAzureFile(EntityId, EntityType, FileName, ContentBytes) Then

                ' Analisis de type en funcion del ContentType 
                'Type = 9  Images
                'If ContentType = "image/jpeg" Or ContentType = "image/png" Then
                '    Type = 9
                'End If

                Dim splublic = IIf(bPublic, 1, 0)
                Dim fileType = System.IO.Path.GetExtension(FileName)

                Dim cnn1 As SqlConnection = GetConnection()
                Dim cmd As SqlCommand = cnn1.CreateCommand()

                ' Setup the command to execute the stored procedure.
                cmd.CommandText = "Azure_Entity_Uploads_INSERT"
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@EntityId", EntityId)
                cmd.Parameters.AddWithValue("@Type", Type)
                cmd.Parameters.AddWithValue("@FileName", FileName)
                cmd.Parameters.AddWithValue("@KeyName", KeyName)
                cmd.Parameters.AddWithValue("@Public", bPublic)
                cmd.Parameters.AddWithValue("@ContentType", ContentType)
                cmd.Parameters.AddWithValue("@ContentBytes", ContentBytes)
                cmd.Parameters.AddWithValue("@EntityType", EntityType)
                cmd.Parameters.AddWithValue("@FileType", fileType)
                cmd.Parameters.AddWithValue("@companyId", companyId)

                cmd.ExecuteNonQuery()

                cnn1.Close()

                Return True
            Else
                Return False
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function AzureStorage_Insert_Transmittal(EntityId As Integer, EntityType As String, Type As Integer, FileName As String, KeyName As String, bPublic As Boolean, ContentBytes As Integer, ContentType As String, companyId As Integer, maxDownload As Integer, ExpirationDate As DateTime) As Boolean
        Try
            If Not ExistAzureFile(EntityId, EntityType, FileName, ContentBytes) Then

                ' Analisis de type en funcion del ContentType 
                'Type = 9  Images
                'If ContentType = "image/jpeg" Or ContentType = "image/png" Then
                '    Type = 9
                'End If

                Dim splublic = IIf(bPublic, 1, 0)
                Dim fileType = System.IO.Path.GetExtension(FileName)

                Dim cnn1 As SqlConnection = GetConnection()
                Dim cmd As SqlCommand = cnn1.CreateCommand()

                ' Setup the command to execute the stored procedure.
                cmd.CommandText = "Transmital_azureuploads_v20_INSERT"
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@EntityId", EntityId)
                cmd.Parameters.AddWithValue("@Type", Type)
                cmd.Parameters.AddWithValue("@FileName", FileName)
                cmd.Parameters.AddWithValue("@KeyName", KeyName)
                cmd.Parameters.AddWithValue("@Public", bPublic)
                cmd.Parameters.AddWithValue("@ContentType", ContentType)
                cmd.Parameters.AddWithValue("@ContentBytes", ContentBytes)
                cmd.Parameters.AddWithValue("@EntityType", EntityType)
                cmd.Parameters.AddWithValue("@FileType", fileType)
                cmd.Parameters.AddWithValue("@companyId", companyId)
                cmd.Parameters.AddWithValue("@MaxDownload", maxDownload)
                If Not (ExpirationDate = Nothing) Then
                    cmd.Parameters.AddWithValue("@ExpirationDate", ExpirationDate)
                Else
                    cmd.Parameters.AddWithValue("@ExpirationDate", DBNull.Value)
                End If

                cmd.ExecuteNonQuery()

                cnn1.Close()

                Return True
            Else
                Return False
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function AzureStorageGuid_Insert(EntityId As Integer, EntityType As String, Type As Integer, FileName As String, KeyName As String, bPublic As Boolean, ContentBytes As Integer, ContentType As String, companyId As Integer, guid As String) As Boolean
        Try
            If Not ExistAzureFile(EntityId, EntityType, FileName, ContentBytes) Then

                ' Analisis de type en funcion del ContentType 
                'Type = 9  Images
                'If ContentType = "image/jpeg" Or ContentType = "image/png" Then
                '    Type = 9
                'End If

                Dim splublic = IIf(bPublic, 1, 0)
                Dim fileType = System.IO.Path.GetExtension(FileName)

                Dim cnn1 As SqlConnection = GetConnection()
                Dim cmd As SqlCommand = cnn1.CreateCommand()

                ' Setup the command to execute the stored procedure.
                cmd.CommandText = "Azure_Entity_Uploads_Guid_INSERT"
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@EntityId", EntityId)
                cmd.Parameters.AddWithValue("@Type", Type)
                cmd.Parameters.AddWithValue("@FileName", FileName)
                cmd.Parameters.AddWithValue("@KeyName", KeyName)
                cmd.Parameters.AddWithValue("@Public", bPublic)
                cmd.Parameters.AddWithValue("@ContentType", ContentType)
                cmd.Parameters.AddWithValue("@ContentBytes", ContentBytes)
                cmd.Parameters.AddWithValue("@EntityType", EntityType)
                cmd.Parameters.AddWithValue("@FileType", fileType)
                cmd.Parameters.AddWithValue("@companyId", companyId)
                cmd.Parameters.AddWithValue("@Guid", guid)

                cmd.ExecuteNonQuery()

                cnn1.Close()

                Return True
            Else
                Return False
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function RequestForProposals_azureuploads_CLONE(requestforproposalId As Integer, GUID As String) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "RequestForProposals_azureuploads_CLONE"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@requestforproposalId", requestforproposalId)
            cmd.Parameters.AddWithValue("@guid", GUID)
            cmd.ExecuteNonQuery()
            cnn1.Close()

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function UpdateAzureUploads(Id As Integer, Type As Integer, Name As String, sPublic As Boolean) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "AzureUploads_UPDATE"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@Name", Name)
            cmd.Parameters.AddWithValue("@Type", Type)
            cmd.Parameters.AddWithValue("@Public", sPublic)
            cmd.Parameters.AddWithValue("@Id", Id)
            cmd.ExecuteNonQuery()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function UpdateTransmittalAzureUploads(Id As Integer, Type As Integer, sPublic As Boolean, MaxDownload As Integer, ExpirationDate As DateTime) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Transmital_AzureUploads_UPDATE"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@Type", Type)
            cmd.Parameters.AddWithValue("@Public", sPublic)
            cmd.Parameters.AddWithValue("@MaxDownload", MaxDownload)
            If Not (ExpirationDate = Nothing) Then
                cmd.Parameters.AddWithValue("@ExpirationDate", ExpirationDate)
            Else
                cmd.Parameters.AddWithValue("@ExpirationDate", DBNull.Value)
            End If

            cmd.Parameters.AddWithValue("@Id", Id)
            cmd.ExecuteNonQuery()
            cnn1.Close()
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function GetJobAzureDocumentLinks(ByVal jobId As Integer, ByRef sMsg As System.Text.StringBuilder) As Integer
        Try
            Dim JobName As String = GetJobName(jobId)
            Dim sSubject As String = ConfigurationManager.AppSettings("TituloWeb") & ". Documents of " & JobName

            ' Componer el Body
            Dim cnn1 As SqlConnection = GetConnection()
            Dim nDocs As Integer
            Dim TypeDoc As String = ""
            sMsg.Append("<strong>Documents of " & JobName & "</strong>")
            Dim cmd As New SqlCommand("SELECT [Azure_Uploads].Name, 'https://pasconcept.blob.core.windows.net/documents/'+[KeyName] as url, Jobs_azureuploads_types.Name as nType FROM [Azure_Uploads] LEFT OUTER JOIN Jobs_azureuploads_types ON [Azure_Uploads].type = Jobs_azureuploads_types.Id where [Azure_Uploads].EntityId=" & jobId & " and EntityType= 'Jobs'  and [Public]=1 Order By [Type], Name", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            Do While rdr.Read()
                If rdr.HasRows Then
                    If TypeDoc <> rdr("nType") Then
                        sMsg.Append("<br />")
                        sMsg.Append("<br />")
                        TypeDoc = rdr("nType")
                        sMsg.Append("<strong>" & rdr("nType") & "</strong>")
                        sMsg.Append("<br />")
                    End If
                    sMsg.Append("<li><a href=" & """" & rdr("url") & """" & ">" & rdr("Name") & "</a></li>")
                    nDocs = nDocs + 1
                End If
            Loop
            rdr.Close()
            cnn1.Close()

            Return nDocs

        Catch ex As Exception

        End Try
    End Function

    Public Shared Function SendJobAzureDocumentsLink(ByVal jobId As Integer, EmailTo As String, EmailCC As String, companyId As Integer) As Boolean
        Try

            Dim JobName As String = GetJobName(jobId)
            Dim sSubject As String = ConfigurationManager.AppSettings("TituloWeb") & ". Documents of " & JobName
            Dim sMsg As New System.Text.StringBuilder

            If GetJobAzureDocumentLinks(jobId, sMsg) > 0 Then
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Best regards,")
                sMsg.Append("<br />")
                sMsg.Append("<strong>" & GetCompanyProperty(companyId, "Name") & "</strong>")
                sMsg.Append("<br />")
                sMsg.Append(LocalAPI.GetPASShortSign())
                Dim clientid = LocalAPI.GetJobProperty(jobId, "Client")
                SendGrid.Email.SendMail(EmailTo, EmailCC, ConfigurationManager.AppSettings("webEmailProfitWarningCC"), sSubject, sMsg.ToString, companyId, clientid, jobId)
                Return True

            End If

        Catch ex As Exception

        End Try

    End Function


    Public Shared Function CreateIcon(sContentType As String, sUrl As String, FileName As String, IconPixelsHeihgt As Integer)
        Dim FileExtention As String = ""
        Dim FontSizeStyle As String = IIf(IconPixelsHeihgt > 16, $"font-size:{IconPixelsHeihgt}px;", "")

        Select Case sContentType
            Case "application/pdf"
                FileExtention = ".pdf"
            Case "application/zip", "application/x-tar", "application/x-rar"
                FileExtention = ".zip"

            Case "application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                FileExtention = ".xls"

            Case "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                FileExtention = ".doc"

            Case "image/tiff", "image/bmp", "image/jpeg", "image/gif", "Image/jpg", "image/png"
                FileExtention = ".png"
            Case Else
                FileExtention = LCase(System.IO.Path.GetExtension(FileName))
        End Select

        Select Case LCase(FileExtention)
            Case ".pdf"
                Return $"<a title=""{FileName}"" class=""far fa-file-pdf"" style=""{FontSizeStyle} color: darkred"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
            Case ".zip"
                Return $"<a title=""{FileName}"" class=""far fa-file-archive"" style=""{FontSizeStyle} color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
            Case ".xls", ".xlsx", ".csv"
                Return $"<a title=""{FileName}"" class=""far fa-file-excel"" style=""{FontSizeStyle} color: darkgreen"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
            Case ".doc", ".docx"
                Return $"<a title=""{FileName}"" class=""far fa-file-word"" style=""{FontSizeStyle} color: darkblue"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
            Case ".txt"
                Return $"<a title=""{FileName}"" class=""far fa-file-alt"" style=""{FontSizeStyle} color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
            Case ".dwg"
                Return $"<a title=""{FileName}"" class=""fas fa-drafting-compass"" style=""{FontSizeStyle} color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
            Case ".msg"
                Return $"<a title=""{FileName}"" class=""far fa-envelope"" style=""{FontSizeStyle} color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
            Case ".xmcd"
                Return $"<a title=""{FileName}"" class=""fas fa-equals"" style=""{FontSizeStyle} color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"

            Case ".tiff", ".bmp", ".jpeg", ".gif", ".jpg", ".png"
                If IconPixelsHeihgt > 16 Then
                    Return $"<div class=""container-fluid px-0""><div class=""row""><div class=""col-md-12""><img src=""{sUrl}"" class=""img-fluid w-100"" style=""object-fit: cover;"" /></div></div></div>"
                Else
                    Return $"<a class=""far fa-file-image"" style=""color: red"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
                End If
            Case Else
                Return $"<a title=""{FileName}"" class=""far fa-file"" style=""color: darkgray"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
        End Select

    End Function


#End Region

#Region "AzureWebServices"
    Public Shared Function DailyRecurrenceTasks() As Boolean
        ' Tarea "PostEmissionRecurrenceEmails" tipo "Scheduler Job Collections" lanzada desde Azure 
        '[WebHook URL] "https://app.pasconcept.com/api/webhooks/post"
        '[Authorization Token] = "Bearer 7497EE20-6811-4405-A2EE-471A8BFE3682"
        '[HttpMethod] = "POST"

        sys_log_Nuevo("jcarlos@axzes.com", LocalAPI.sys_log_AccionENUM.azure_post, 260973, "POST DailyRecurrenceTasks")

        RefreshYearsList()

        SendRecurrenceInvoices()

        SendDueDateInvoices()

        SendEEGProposalsNotEmitted()

        Return DeletePendingAzureFiles()
    End Function

    Public Shared Sub RefreshYearsList()
        Try
            Dim CurrentYear As Integer = Today.Year
            Dim bExisteAnoaActual As Boolean = (GetNumericEscalar($"select isnull(count(*), 0) from [Years] where [Year]= {CurrentYear}") > 0)

            If Not bExisteAnoaActual Then
                ExecuteNonQuery($"INSERT INTO [Years] ([Year], [nYear]) VALUES ({CurrentYear}, '{CurrentYear}')")
                sys_Webhooks_INSERT("RefreshYearsList", 1, "")

                AllCompanyPayrollCallendar_InitYear(CurrentYear)

            Else
                sys_Webhooks_INSERT("RefreshYearsList", 0, "")
            End If

            ' Update employees in year hourly wage table
            AllCompaniesEmployeesHourlyWage_INSERT(CurrentYear)

            '

        Catch ex As Exception
            sys_Webhooks_INSERT("RefreshYearsList", 0, ex.Message)
        End Try

    End Sub

    Public Shared Function SendRecurrenceInvoices() As Boolean
        ' Company.billingModule 
        '   and EmissionRecurrenceDays>0 
        '   and AmountDue>0 
        '   and BadDebt=0 
        '   and statementId = 0
        '   and EmissionRecurrenceDays<=DateDiff(day,LatestEmission,dbo.CurrentTime())
        Dim cnn1 As SqlConnection = GetConnection()
        Try
            Dim nRecs As Integer = 0

            Dim cmd As New SqlCommand("SELECT Invoices.Id, Jobs.companyId FROM Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id INNER JOIN Company ON Jobs.companyId = Company.companyId WHERE isnull(Company.billingModule,0)=1 and ISNULL(Invoices.EmissionRecurrenceDays, 0) > 0 and Invoices.AmountDue>0 and isnull(BadDebt,0)=0 and isnull(statementId,0)=0 and ISNULL(Invoices.EmissionRecurrenceDays, 0)<=DateDiff(day,Invoices.LatestEmission,dbo.CurrentTime())", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            Do While rdr.Read()
                If rdr.HasRows Then

                    InvoiceAutomatictToClient(rdr("Id"), rdr("companyId"))
                    nRecs = nRecs + 1
                End If
            Loop
            rdr.Close()

            sys_Webhooks_INSERT("SendRecurrenceInvoices", nRecs, "")

        Catch ex As Exception
            sys_Webhooks_INSERT("SendRecurrenceInvoices", 0, ex.Message)
        Finally
            cnn1.Close()
        End Try
    End Function

    Public Shared Function SendDueDateInvoices() As Boolean
        ' Automatic Emmit Invoice at Due Date...........................
        ' Emision automatica de Invoices para planes periodicos (mensuales)
        ' Company.billingModule 
        '   Invoices.MaturityDate <= dbo.CurrentTime()    TIENE DEFINIDO "Due Date" y ya esta vencido
        '   and AmountDue>0 
        '   and BadDebt=0 
        '   and statementId = 0
        '   and Emitted=0
        Dim cnn1 As SqlConnection = GetConnection()
        Try
            Dim nRecs As Integer = 0

            Dim cmd As New SqlCommand("SELECT Invoices.Id, Jobs.companyId FROM Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id INNER JOIN Company ON Jobs.companyId = Company.companyId WHERE isnull(Company.billingModule,0)=1 and Invoices.MaturityDate <= dbo.CurrentTime() and Invoices.AmountDue>0 and isnull(BadDebt,0)=0 and isnull(statementId,0)=0 and ISNULL(Invoices.Emitted, 0)=0", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            Do While rdr.Read()
                If rdr.HasRows Then
                    InvoiceAutomatictToClient(rdr("Id"), rdr("companyId"))
                    nRecs = nRecs + 1
                End If
            Loop
            rdr.Close()

            sys_Webhooks_INSERT("SendDueDateInvoices", nRecs, "")

        Catch ex As Exception
            sys_Webhooks_INSERT("SendDueDateInvoices", 0, ex.Message)
        Finally
            cnn1.Close()
        End Try
    End Function

    Public Shared Function SendEEGProposalsNotEmitted() As Boolean
        ' Proposals de EEG que se mantienen en status NotEmmitted 
        Dim cnn1 As SqlConnection = GetConnection()
        Try
            Dim nRecs As Integer = 0
            Dim Subject As String
            Dim Body As String
            Dim emailTo As String
            Dim emailBcc As String

            Dim cmd As New SqlCommand("SELECT Proposal.Id,Proposal.DepartmentId, dbo.ProposalNumber(Proposal.Id) AS ProposalNumber,Proposal.[Date],Proposal.ProjectName, ProposalBy=isnull(Employees.FullName,''),ProposalByEmail=isnull(Employees.Email,''),[Days]=DATEDIFF(DAY,Proposal.[Date],dbo.CurrentTime()) FROM Proposal LEFT OUTER JOIN Employees ON Proposal.ProjectManagerId=Employees.Id WHERE Proposal.companyId=260962 and StatusId=0 and DATEDIFF(DAY,Proposal.[Date],dbo.CurrentTime())>0 and isnull(Proposal.DepartmentId,0)>0 order by id", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            Do While rdr.Read()
                If rdr.HasRows Then
                    Subject = "Reminder for Not Emitted Proposal [" & rdr("ProposalNumber") & "], " & rdr("Days") & " days ago"
                    Body = LeerProposalNotEmittedTemplate(rdr("Id"))
                    Body = Replace(Body, "[ProposalBy]", rdr("ProposalBy"))
                    Body = Replace(Body, "[ProposalNumber]", rdr("ProposalNumber"))
                    Body = Replace(Body, "[ProjectName]", rdr("ProjectName"))
                    emailTo = IIf(Len(rdr("ProposalByEmail")) > 0, rdr("ProposalByEmail"), LocalAPI.GetHeadDepartmentEmailFromProposal(rdr("Id")))

                    emailBcc = IIf(rdr("Days") > 1, "yanaisy@easterneg.com", "")

                    SendGrid.Email.SendMail(emailTo, "", emailBcc, Subject, Body, 260962, 0, 0)

                    OneSignalNotification.SendNotification(emailTo, "Not Emitted Proposal", Subject, "", 260962)
                    nRecs = nRecs + 1
                End If

            Loop
            rdr.Close()

            sys_Webhooks_INSERT("SendEEGProposalsNotEmitted", nRecs, "")

        Catch ex As Exception
            sys_Webhooks_INSERT("SendEEGProposalsNotEmitted", 0, ex.Message)
        Finally
            cnn1.Close()
        End Try
    End Function

    Public Shared Function DeletePendingAzureFiles() As Boolean
        ' Delete from Azure all files Mark as Deleted
        Dim cnn1 As SqlConnection = GetConnection()
        Try
            ' Marca files colgados (se elimino su EntityId)
            Azure_Uploads_Deleted_UPDATE()

            Dim nRecs As Integer = 0

            Dim cmd As New SqlCommand("select Id, isnull([KeyName],'') as KeyName from [Azure_Uploads] where Deleted=1", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            Do While rdr.Read()
                If rdr.HasRows Then
                    If Len(rdr("KeyName")) > 0 Then
                        ' Delete file from Azure
                        AzureStorageApi.DeleteFile(rdr("KeyName"))
                    End If
                    ' Delete record
                    ExecuteNonQuery(String.Format("DELETE FROM [Azure_Uploads] WHERE Id={0}", rdr("Id")))
                    nRecs = nRecs + 1
                End If
            Loop
            rdr.Close()

            sys_Webhooks_INSERT("DeletePendingAzureFiles", nRecs, "")

        Catch ex As Exception
            sys_Webhooks_INSERT("DeletePendingAzureFiles", 0, ex.Message)
        Finally
            cnn1.Close()
        End Try
    End Function

    Public Shared Function Azure_Uploads_Deleted_UPDATE() As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Azure_Uploads_Deleted_UPDATE"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
        End Try
    End Function

    Private Shared Sub sys_Webhooks_INSERT(FunctionName As String, Records As Integer, ErrorMessage As String)
        Try
            Dim sQuery As String = String.Format("INSERT INTO [sys_Webhooks] ([DateIn],[FunctionName],[Records],[ErrorMessage]) " &
                "VALUES(dbo.CurrentTime(), '{0}',{1},'{2}')", FunctionName, Records, ErrorMessage)
            ExecuteNonQuery(sQuery)
        Catch ex As Exception

        End Try

    End Sub
    Public Shared Function EmployeeWeeklyTimesheetNotification() As Boolean
        ' Notificar a los employees sobre su Timesheet esta semana 
        Try
            Dim Subject As String = "[CompanyName] Timesheets Due: PASconcept Automated Message"
            Dim companyName As String
            Dim sEmailTemplate As New System.Text.StringBuilder
            Dim Body As String
            Dim SMSText As String
            Dim SMSTemplate As String = "This week you have submitted [enteredhours] hours for [CompanyName], please log into PASconcept and submit your remaining hours. "
            SMSTemplate = SMSTemplate & vbCrLf & "https://www.pasconcept.com/EMP/Default.aspx "
            SMSTemplate = SMSTemplate & vbCrLf & "This message was auto generated by pasconcept. Please do not respond."

            sEmailTemplate.Append("Dear <strong>[EmployeeFirstName]</strong>,")
            sEmailTemplate.Append("<br />")
            sEmailTemplate.Append("<br />")
            sEmailTemplate.Append("This is a reminder that timesheets are due today Friday " & FormatDateTime(GetDateTime(), DateFormat.ShortDate) & ". ")
            sEmailTemplate.Append("Timesheets are to be entered on a weekly basis and completed by Friday of every week. ")
            sEmailTemplate.Append("This week you have submitted [enteredhours] hours, please log into PASconcept and submit your remaining hours. ")
            sEmailTemplate.Append("Failure to submit your timesheets may result in errors reflected in your paycheck or loss of accrued leave.")
            sEmailTemplate.Append("<br />")
            sEmailTemplate.Append("<br />")
            sEmailTemplate.Append("<a href=" & """" & "https://www.pasconcept.com/EMP/Default.aspx" & """" & ">Access PASconcept HERE.</a>")
            sEmailTemplate.Append("<br />")
            sEmailTemplate.Append("<br />")
            sEmailTemplate.Append("If you have any questions regarding your timesheet in general, then please contact your supervisor, [HRname].")
            sEmailTemplate.Append("<br />")
            sEmailTemplate.Append("<br />")
            sEmailTemplate.Append("Best Regards,")
            sEmailTemplate.Append("<br />")
            sEmailTemplate.Append("<br />")
            sEmailTemplate.Append("PASconcept Automated Messaging")
            sEmailTemplate.Append("<br />")
            sEmailTemplate.Append("<br />")
            sEmailTemplate.Append("<br />")
            sEmailTemplate.Append("This email was auto generated. Please do not respond. ")

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As New SqlCommand("select Id, WeeklyHous=dbo.WeeklyHoursByEmp(Id,dbo.CurrentTime()), Name, Email, Cellular, companyId from employees where isnull(Inactive,0)=0 and isnull(WeeklyTimesheetNotification,0)=1 order by companyId, Id", cnn1)
            Dim rdr As SqlDataReader
            rdr = cmd.ExecuteReader
            Do While rdr.Read()
                If rdr.HasRows Then
                    companyName = GetCompanyProperty(rdr("companyId"), "Name")
                    If Len(rdr("Email")) > 3 Then
                        Body = sEmailTemplate.ToString
                        Body = Replace(Body, "[EmployeeFirstName]", rdr("Name"))
                        Body = Replace(Body, "[enteredhours]", rdr("WeeklyHous"))
                        Body = Replace(Body, "[HRname]", GetCompanyHRname(rdr("companyId")))
                        Subject = Replace("[CompanyName] Timesheets Due: PASconcept Automated Message", "[CompanyName]", companyName)
                        SendGrid.Email.SendMail(rdr("Email"), "", "", Subject, Body, 0, 0, 0)

                        OneSignalNotification.SendNotification(rdr("Email"), "Timesheets Alert!!!", "This is a reminder that timesheets are due today Friday " & FormatDateTime(GetDateTime(), DateFormat.ShortDate) & ". ", "", rdr("companyId"))

                    End If

                    'If IsCompanySMSservice(rdr("companyId")) And Len(rdr("Cellular")) > 9 Then
                    '    Dim sCellPhone As String = rdr("Cellular")
                    '    If SMS.IsValidPhone(sCellPhone) Then
                    '        SMSText = SMSTemplate
                    '        SMSText = Replace(SMSText, "[enteredhours]", rdr("WeeklyHous"))
                    '        SMSText = Replace(SMSText, "[CompanyName]", companyName)
                    '        SMS.SendSMS(sCellPhone, SMSText, rdr("companyId"))
                    '    End If
                    'End If
                End If
            Loop
            rdr.Close()
            cnn1.Close()

        Catch ex As Exception

        End Try
    End Function
    Public Shared Function LeerInvoiceTemplate(invoiceId As Integer, companyId As Integer, ByRef Subject As String, ByRef Body As String) As Boolean
        Try
            ' Diferentes niveles de PasDue pueden generar Emails diferentes. Ver ejemplo:
            'http://blog.fundinggates.com/2015/06/how-to-word-your-past-due-letter/

            Dim sProjectName As String = LocalAPI.GetInvoiceProperty(invoiceId, "[Jobs].[Job]")
            Dim sClienteName = LocalAPI.GetInvoiceProperty(invoiceId, "[Clients].[Name]")
            Dim sSign = LocalAPI.GetCompanySign(companyId)
            Dim sInvoiceNumber As String = LocalAPI.InvoiceNumber(invoiceId)
            ' Leer subjet y body template
            Subject = LocalAPI.GetMessageTemplateSubject("Invoice", companyId)
            Body = LocalAPI.GetMessageTemplateBody("Invoice", companyId)

            ' sustituir variables
            Subject = Replace(Subject, "[Invoice Number]", sInvoiceNumber)
            Subject = Replace(Subject, "[Project Name]", sProjectName)


            Body = Replace(Body, "[Invoice Number]", sInvoiceNumber)
            Body = Replace(Body, "[Project Name]", sProjectName)
            Body = Replace(Body, "[Client Name]", sClienteName)
            Body = Replace(Body, "[Sign]", sSign)

            ' Enlace al Invoice
            Dim sURL As String = LocalAPI.GetSharedLink_URL(4, invoiceId)
            Body = Replace(Body, "[PASconceptLink]", sURL)

            sURL = LocalAPI.GetSharedLink_URL(8, invoiceId)
            Body = Replace(Body, "[JobLink]", sURL)

            Return True
        Catch ex As Exception

        End Try
    End Function
    'Public Shared Function LeerStatementTemplate(statementId As Integer, companyId As Integer, ByRef Subject As String, ByRef Body As String) As Boolean
    '    Try
    '        ' Variables
    '        Dim sClienteName = LocalAPI.GetStatementProperty(statementId, "[Clients].[Name]")
    '        'Dim sSign = LocalAPI.GetCompanySign(companyId)
    '        Dim statementNumber As String = LocalAPI.GetStatementNumber(statementId)

    '        Subject = "Statement of Invoices Number [Statement Number]"
    '        Subject = Replace(Subject, "[Statement Number]", statementNumber)

    '        If Body.Length = 0 Then
    '            Dim sBody As New System.Text.StringBuilder
    '            sBody.Append("Dear <strong>[Client Name]</strong>,")
    '            sBody.Append("<br />")
    '            sBody.Append("<br />")
    '            sBody.Append("<a href=" & """" & "[StatementUrl]" & """" & ">Click here</a> to review statement [Statement Number] for Services rendered in the project(s) referenced within.")
    '            sBody.Append("<br />")
    '            sBody.Append("If you have any inquiries concerning it, please do not hesitate to contact our office.")
    '            sBody.Append("<br />")
    '            sBody.Append("<br />")
    '            sBody.Append("Thank you very much,")
    '            sBody.Append("<br />")
    '            sBody.Append("[Sign]")
    '            Body = sBody.ToString
    '        End If

    '        Body = Replace(Body, "[Statement Number]", statementNumber)
    '        Body = Replace(Body, "[Client Name]", sClienteName)
    '        'Body = Replace(Body, "[Sign]", sSign)

    '        Dim sURL As String = LocalAPI.GetSharedLink_URL(5555, statementId)
    '        Body = Replace(Body, "[StatementUrl]", sURL)

    '        Return True
    '    Catch ex As Exception

    '    End Try
    'End Function
    Public Shared Function LeerInvoiceRemainderTemplate(invoiceId As Integer) As String
        Try
            Dim sMsg As New System.Text.StringBuilder

            sMsg.Append("Dear [RemainderContactName],")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Thank you for taking our call to discuss the payment of Invoice #")
            sMsg.Append("<a href=" & """" & LocalAPI.GetSharedLink_URL(4, invoiceId) & """" & ">[InvoiceNumber]</a>")
            sMsg.Append(" related to Project [ProjectName].")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<a href=" & """" & LocalAPI.GetSharedLink_URL(8, invoiceId) & """" & ">Click here</a>")
            sMsg.Append(" to view additional information associated to [ProjectName]")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            'sMsg.Append("As per our conversation, with reminder for [Remainder]:")
            sMsg.Append("Notes:")
            sMsg.Append("<br />")
            sMsg.Append("<p><i>[Notes]</i></p>")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("If you have any inquiries, please do not hesitate to contact me.")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Regards")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("[EmployeeName]")
            sMsg.Append("<br />")
            sMsg.Append("Billing Department")

            ' Retorno de valores.....
            Return sMsg.ToString

        Catch ex As Exception

        End Try
    End Function

    Public Shared Function LeerStatementRemainderTemplate(statementId As Integer) As String
        Try
            Dim sMsg As New System.Text.StringBuilder

            sMsg.Append("Dear [RemainderContactName],")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Thank you for taking our call to discuss the payment of Statement #")
            sMsg.Append("<a href=" & """" & LocalAPI.GetSharedLink_URL(5, statementId) & """" & ">[StatementNumber]</a>")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("As per our conversation, with reminder for [Remainder]:")
            sMsg.Append("<br />")
            sMsg.Append("<p><i>[Notes]</i></p>")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("If you have any inquiries, please do not hesitate to contact me.")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Regards")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("[EmployeeName]")
            sMsg.Append("<br />")
            sMsg.Append("Billing Department")

            ' Retorno de valores.....
            Return sMsg.ToString

        Catch ex As Exception

        End Try
    End Function

    Public Shared Function LeerProposalNotEmittedTemplate(proposalId As Integer) As String
        Try
            Dim sMsg As New System.Text.StringBuilder

            sMsg.Append("Dear [ProposalBy],")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Reminder to please finish the not emitted proposal ")
            sMsg.Append("<br />")
            sMsg.Append("<br />")

            sMsg.Append("<a href=" & """" & LocalAPI.GetSharedLink_URL(11001, proposalId.ToString) & """" & ">[ProposalNumber], [ProjectName]</a>")

            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Please keep in mind that having the proposal sent over to our client at a timely manner is crucial to obtaining the projects approval. This notification will continue to be sent over until proposal is emitted and pending for client approval.")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Thank you")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Admin Department")
            ' Retorno de valores.....
            Return sMsg.ToString

        Catch ex As Exception

        End Try
    End Function
#End Region

#Region "Jobs_tags"
    Public Shared Function GetJobs_tagsCount(jobId As Integer) As Integer
        Return GetNumericEscalar("SELECT count(*) FROM Jobs_tags where jobId=" & jobId)
    End Function
    Public Shared Function GetJobsTagsList(jobId As Integer) As String
        Return GetStringEscalar("SELECT dbo.GetJobTAGsList(" & jobId & ")")
    End Function

#End Region

#Region "PayPal"
    Public Shared Function IsPayPalModule(companyId As Integer) As Boolean
        Return GetNumericEscalar("SELECT isnull([PayPalModule],0) FROM Company where companyId=" & companyId)
    End Function

    ''' <summary>
    ''' Adds a new record of Executed Agreement in DB
    ''' </summary>
    ''' <param name="token">Agreement Token</param>
    ''' <param name="agrId">Agreement Id</param>
    ''' <param name="planId">Plan Id</param>
    ''' <param name="companyId">CapaBiz CompanyId</param>
    ''' <returns></returns>
    Public Shared Function AddExecutedPayPalAgreement(token As String, agrId As String, planId As String, companyId As Integer) As Integer
        Try
            ' Creates Agreement
            Dim query = "INSERT INTO [PayPalAgreements] (PayPalToken, PayPalAgreementId, PayPalPlanId, companyId, statusId) output INSERTED.ID VALUES('" & token & "', '" & agrId & "', '" & planId & "', " & companyId & ", " & Convert.ToInt32(PayPalAgreementStatus.Active) & ")"
            Return GetNumericEscalar(query)
        Catch e As Exception
            Throw e
        End Try
    End Function

    ''' <summary>
    ''' Returns the existing plan ID for a given PasConcept Billing Plan Id
    ''' </summary>
    ''' <param name="billingPlanId"></param>
    ''' <returns></returns>
    Public Shared Function GetPayPalPlanId(billingPlanId As Integer) As String
        Try
            Dim query = "SELECT TOP 1 PayPalPlanId FROM [PayPalPlans] WHERE [billingPlanId]=" & billingPlanId
            Return GetStringEscalar(query)
        Catch e As Exception
            Throw e
        End Try
    End Function

    ''' <summary>
    ''' Adds a new record of a PayPal Plan in DB
    ''' </summary>
    ''' <param name="planId"></param>
    ''' <param name="planName"></param>
    ''' <param name="planDesc"></param>
    ''' <returns></returns>
    Public Shared Function AddPayPalPlan(planId As String, planName As String, planDesc As String, billingPlanId As Integer) As Integer
        Try
            ' Creates Plan
            Dim query = "INSERT INTO [PayPalPlans] (PayPalPlanId, PayPalName, PayPalDescription, billingPlanId) output INSERTED.ID VALUES('" & planId & "', '" & planName & "', '" & planDesc & "', " & billingPlanId & ")"
            Return GetNumericEscalar(query)
        Catch e As Exception
            Throw e
        End Try
    End Function

    ''' <summary>
    ''' Returns the existing Pay Pal Subscription ID for a given company
    ''' </summary>
    ''' <param name="companyId"></param>
    ''' <returns></returns>
    Public Shared Function GetPayPalSubscriptionId(companyId As Integer) As String
        Try
            Dim query = "SELECT TOP 1 PayPalAgreementId FROM [PayPalAgreements] WHERE [companyId]=" & companyId & " And ISNULL([statusId], 0) = " & Convert.ToInt32(PayPalAgreementStatus.Active)
            Return GetStringEscalar(query)
        Catch e As Exception
            Throw e
        End Try
    End Function

    ''' <summary>
    ''' Cancels a subscription from DB based on a PayPalId
    ''' </summary>
    ''' <param name="subsId"></param>
    Public Shared Sub CancelPayPalSubscription(subsId As String)
        Try
            Dim q = "UPDATE [PayPalAgreements] Set [statusId] = " & Convert.ToInt32(PayPalAgreementStatus.Canceled) & "WHERE [PayPalAgreementId]='" & subsId & "'"
            ExecuteNonQuery(q)
        Catch e As Exception
            Throw e
        End Try
    End Sub
    ''' <summary>
    ''' Adds a new record of a Webhook in DB
    ''' </summary>
    ''' <param name="webhookId"></param>
    ''' <param name="webhookType"></param>
    ''' <returns></returns>
    Public Shared Function AddPayPalWebhook(webhookId As String, webhookType As PayPalWebhookType) As Integer
        Try
            ' Creates Webhook
            Dim query = "INSERT INTO [PayPalWebhooks] (PayPalWebhookId, PayPalWebhookTypeId) output INSERTED.ID VALUES('" & webhookId & "'," & Convert.ToInt32(webhookType) & ")"
            Return GetNumericEscalar(query)
        Catch e As Exception
            Throw e
        End Try
    End Function

    ''' <summary>
    ''' Returns the existing webhook ID for a given webhookType 
    ''' </summary>
    ''' <param name="webhookType"></param>
    ''' <returns></returns>
    Public Shared Function GetPayPalWebhookId(webhookType As PayPalWebhookType) As String
        Try
            Dim query = "Select TOP 1 PayPalWebhookId FROM [PayPalWebhooks] WHERE [PayPalWebhookTypeId]=" & Convert.ToInt32(webhookType)
            Return GetStringEscalar(query)
        Catch e As Exception
            Throw e
        End Try

    End Function

    ''' <summary>
    ''' Creates a new instance of a PayPalPayment in the DB
    ''' </summary>
    ''' <param name="paymentId"></param>
    ''' <param name="subsId"></param>
    ''' <param name="total"></param>
    ''' <param name="currency"></param>
    ''' <param name="createdAt"></param>
    ''' <returns></returns>
    Public Shared Function AddPayPalPayment(paymentId As String, subsId As String, total As String, currency As String, createdAt As String) As Integer
        Try
            Dim columnName = "[PayPalPayments]"
            ' Get companyId first
            If [String].IsNullOrEmpty(subsId) Then
                Return -1
            End If
            Dim cQuery = "Select [companyId] FROM [PayPalAgreements] WHERE [PayPalAgreementId]='" & subsId & "'"
            Dim companyId As Integer = GetNumericEscalar(cQuery)
            Dim eQuery = "SELECT count(*) FROM " & columnName & " WHERE [PayPalPaymentId] = '" & paymentId & "'"
            Dim count = GetNumericEscalar(eQuery)
            If count > 0 Then
                Return -1
            End If
            Dim dt = DateTime.ParseExact(createdAt, "yyyy-MM-ddTHH:mm:ssZ", Nothing)
            Dim query = "INSERT INTO" & columnName & "(PayPalPaymentId, Total, Currency, PayPalAgreementId, createdAt, companyId) output INSERTED.ID VALUES ('" & paymentId & "','" & total & "', '" & currency & "', '" & subsId & "', '" & dt.ToString("yyyy-MM-dd HH:mm:ss") & "', " & companyId & ")"
            Return GetNumericEscalar(query)
        Catch e As Exception
            Throw e
        End Try
    End Function

    ''' <summary>
    ''' Log all events recieved in Agreement's Webhook
    ''' </summary>
    ''' <param name="id"></param>
    ''' <param name="event_type"></param>
    ''' <param name="summary"></param>
    ''' <param name="create_time"></param>
    Public Shared Function LogPayPalAgreement(id As String, event_type As String, summary As String, create_time As String) As Integer
        Try
            Dim columnName = "[PayPalAgreementsLog]"
            ' Get companyId first
            If [String].IsNullOrEmpty(id) Then
                Return -1
            End If
            Dim cQuery = "Select [companyId] FROM [PayPalAgreements] WHERE [PayPalAgreementId]='" & id & "'"
            Dim companyId As Integer = GetNumericEscalar(cQuery)
            Dim eQuery = "SELECT count(*) FROM " & columnName & " WHERE [PayPalAgreementId] = '" & id & "' AND [Event] = '" & event_type & "'"
            Dim count = GetNumericEscalar(eQuery)
            If count > 0 Then
                Return -1
            End If
            ' Updating company billing plan depending on event_type
            If event_type = "BILLING.SUBSCRIPTION.CANCELLED" OrElse event_type = "BILLING.SUBSCRIPTION.SUSPENDED" Then
                UpdateCompanyBillingPlan(companyId, 18) ' PayPal Canceled
            ElseIf event_type = "BILLING.SUBSCRIPTION.RE-ACTIVATED" Then
                UpdateCompanyBillingPlan(companyId, 0) ' Pro
            End If
            Dim dt = DateTime.ParseExact(create_time, "yyyy-MM-ddTHH:mm:ssZ", Nothing)
            Dim query = "INSERT INTO" & columnName & "(PayPalAgreementId, Event, Summary, createdAt, companyId) output INSERTED.ID VALUES ('" & id & "','" & event_type & "', '" & summary & "', '" & dt.ToString("yyyy-MM-dd HH:mm:ss") & "', " & companyId & ")"
            Return GetNumericEscalar(query)
        Catch e As Exception
            Throw e
        End Try
    End Function

    ''' <summary>
    ''' Creates a new instance of log payment in the DB
    ''' </summary>
    ''' <param name="paymentId"></param>
    ''' <param name="subsId"></param>
    ''' <param name="eventType"></param>
    ''' <param name="summary"></param>
    ''' <param name="createdAt"></param>
    ''' <returns></returns>
    Public Shared Function LogPayPalPayment(paymentId As String, subsId As String, eventType As String, summary As String, createdAt As String) As Integer
        Try
            Dim columnName = "[PayPalPaymentsLog]"
            ' Get companyId first
            If [String].IsNullOrEmpty(subsId) Then
                Return -1
            End If
            Dim cQuery = "Select [companyId] FROM [PayPalAgreements] WHERE [PayPalAgreementId]='" & subsId & "'"
            Dim companyId As Integer = GetNumericEscalar(cQuery)
            Dim eQuery = "SELECT count(*) FROM " & columnName & " WHERE [PayPalPaymentId] = '" & paymentId & "' AND [Event] = '" & eventType & "'"
            Dim count = GetNumericEscalar(eQuery)
            If count > 0 Then
                Return -1
            End If
            Dim dt = DateTime.ParseExact(createdAt, "yyyy-MM-ddTHH:mm:ssZ", Nothing)
            Dim query = "INSERT INTO" & columnName & "(PayPalPaymentId, Event, Summary, PayPalAgreementId, createdAt, companyId) output INSERTED.ID VALUES ('" & paymentId & "','" & eventType & "', '" & summary & "', '" & subsId & "', '" & dt.ToString("yyyy-MM-dd HH:mm:ss") & "', " & companyId & ")"
            Return GetNumericEscalar(query)
        Catch e As Exception
            Throw e
        End Try
    End Function

    ''' <summary>
    ''' Updates Billing Plan for a given company
    ''' </summary>
    ''' <param name="companyId"></param>
    ''' <param name="billingPlanId"></param>
    Public Shared Sub UpdateCompanyBillingPlan(companyId As Integer, billingPlanId As Integer)
        Try
            Dim query = "UPDATE [Company] SET [Billing_plan]=" & billingPlanId & "WHERE [companyId]=" & companyId
            ExecuteNonQuery(query)
        Catch e As Exception
            Throw e
        End Try
    End Sub

    Public Shared Function IsCompanyPro(companyId As Integer) As Object
        Try
            Dim billPlanId = GetCompanyProperty(companyId, "Billing_plan")
            Return Convert.ToInt32(billPlanId) = 0
        Catch ex As Exception
            Throw ex
        End Try
    End Function

#End Region

#Region "Stadistic"
    Public Shared Function Stadistic_DepartmentFTE(ByVal dptoId As Integer, Year As Integer, companyId As Integer) As String
        Return GetNumericEscalar("SELECT dbo.DepartmentFTE(" & dptoId & "," & Year & "," & companyId & ")")
    End Function
    Public Shared Function Stadistic_CompanyFTE(Year As Integer, companyId As Integer) As String
        Return GetNumericEscalar("SELECT dbo.CompanyFTE(" & Year & "," & companyId & ")")
    End Function

    Public Shared Function Stadistic_DepartmentSalary(ByVal dptoId As Integer, Year As Integer, companyId As Integer) As String
        Return GetNumericEscalar("SELECT dbo.DepartmentSalary(" & dptoId & "," & Year & "," & companyId & ")")
    End Function

    Public Shared Function Stadistic_CompanyOverhead(Year As Integer, companyId As Integer) As String
        Return GetNumericEscalar("SELECT dbo.CompanyOverhead(" & Year & "," & companyId & ")")
    End Function

    Public Shared Function Stadistic_DepartmentROI(ByVal dptoId As Integer, Year As Integer, companyId As Integer) As Double
        Return GetNumericEscalar("SELECT dbo.DepartmentROI(" & dptoId & "," & Year & "," & companyId & ")")
    End Function

    Public Shared Function Stadistic_DepartmentCustomer_AverageValue(ByVal dptoId As Integer, Year As Integer, companyId As Integer) As Double
        Return GetNumericEscalar("SELECT dbo.DepartmentCustomer_AverageValue(" & companyId & "," & dptoId & "," & Year & ")")
    End Function
    Public Shared Function Stadistic_DepartmentCustomer_AverageRevenue(ByVal dptoId As Integer, Year As Integer, companyId As Integer) As Double
        Return GetNumericEscalar("SELECT dbo.DepartmentCustomer_AverageRevenue(" & companyId & "," & dptoId & "," & Year & ")")
    End Function

    Public Shared Function Stadistic_DepartmentCustomer_Count(ByVal dptoId As Integer, Year As Integer, companyId As Integer) As Integer
        Return GetNumericEscalar("SELECT dbo.DepartmentCustomer_Count(" & companyId & "," & dptoId & "," & Year & ")")
    End Function

    Public Shared Function Stadistic_DepartmentCustomerNew_Count(ByVal dptoId As Integer, Year As Integer, companyId As Integer) As Integer
        Return GetNumericEscalar("SELECT dbo.DepartmentCustomerNew_Count(" & companyId & "," & dptoId & "," & Year & ")")
    End Function
    Public Shared Function Stadistic_DepartmentSalarySum(ByVal dptoId As Integer, Year As Integer, MonthId As Integer) As Integer
        Return GetNumericEscalar("SELECT dbo.DepartmentSalarySum(" & dptoId & "," & Year & "," & MonthId & ")")
    End Function
    Public Shared Function Stadistic_DepartmentSalaryAvg(ByVal dptoId As Integer, Year As Integer, MonthId As Integer) As Integer
        Return GetNumericEscalar("SELECT dbo.DepartmentSalaryAvg(" & dptoId & "," & Year & "," & MonthId & ")")
    End Function
    Public Shared Function Stadistic_DepartmentOverhead_Direct(dptoId As Integer, Year As Integer, companyId As Integer) As String
        Return GetNumericEscalar("SELECT dbo.DepartmentOverhead_Direct(" & companyId & "," & dptoId & "," & Year & ")")
    End Function

#End Region

#Region "Reminder"

    Public Shared Function IsReminderInvoice(reminderId As Integer) As Boolean
        Return IIf(GetNumericEscalar("SELECT COUNT(*) FROM [Invoices_remainders] WHERE Id=" & reminderId) > 0, True, False)
    End Function

    Public Shared Function GetReminderInvoiceProperty(ByVal reminderId As Long, ByVal sProperty As String) As String
        Try
            Select Case sProperty
                Case "InvoiceId"
                    Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],0) FROM [Invoices_remainders] WHERE Id=" & reminderId)

                Case Else
                    Return GetStringEscalar("SELECT ISNULL([" & sProperty & "],'') FROM [Invoices_remainders] WHERE Id=" & reminderId)

            End Select
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetReminderStatementProperty(ByVal reminderId As Long, ByVal sProperty As String) As String
        ' Available "int" type columns
        Dim intKW = New List(Of String)() From
                            {
                                "statementId",
                                "employeeId",
                                "companyId"
                            }
        Try
            If intKW.Contains(sProperty) Then
                Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],0) FROM [Invoices_statements_remainders] WHERE Id=" & reminderId)
            End If
            Return GetStringEscalar("SELECT ISNULL([" & sProperty & "],'') FROM [Invoices_statements_remainders] WHERE Id=" & reminderId)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

#End Region

#Region "CompanyPayments"
    Public Shared Function GetCompanyPaymentsPendingId(ByVal companyId As Long) As Integer
        Try

            Return GetNumericEscalar("SELECT Top 1 Id FROM [Company_Payments] WHERE companyId=" & companyId & " and PaidDate Is Null Order By Id")

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Shared Function GetCompanyPaymentsProperty(ByVal companypaymentId As Long, ByVal sProperty As String) As String
        Try
            Select Case sProperty
                Case "PaymentNumber"
                    GetNumericEscalar("SELECT dbo.CompanyPaymentNumber(Id) FROM [Company_Payments] WHERE Id=" & companypaymentId)

                Case "Amount", "Method", "AxzesInvoiceId", "companyId"
                    Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],0) FROM [Company_Payments] WHERE Id=" & companypaymentId)

                Case Else
                    Return GetStringEscalar("SELECT ISNULL([" & sProperty & "],'') FROM [Company_Payments] WHERE Id=" & companypaymentId)

            End Select
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function SetCompanyPaymentsPlan(billingPlanId As Integer, companyId As Integer) As Boolean
        Try
            ExecuteNonQuery("UPDATE [Company_Payments] set [Company_Payments].Billing_plan = [Billing_plans].Id, [Company_Payments].Amount = [Billing_plans].[billing_baseprice], [Company_Payments].Notes =[Billing_plans].[Name] from [Company_Payments] INNER JOIN [dbo].[Billing_plans] on [Billing_plans].Id=" & billingPlanId & " WHERE [Company_Payments].companyId=" & companyId & " and [Company_Payments].PaidDate Is Null")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

#End Region

#Region "Agile CRM"
    Public Shared Function GetContactJson(Email As String, ContactName As String, CompanyName As String, tag1 As String) As String
        Try
            Dim jsonContactTemplate As String = "{""tags"":[""tag1""], ""properties"":[{""type"":""SYSTEM"", ""name"":""first_name"", ""value"":""first_name_value""}," &
                                                            "{""type"":""SYSTEM"", ""name"":""company"", ""value"":""company_value""}," &
                                                            "{""type"":""SYSTEM"", ""name"":""email"",""value"":""email_value""}]}"
            jsonContactTemplate = Replace(jsonContactTemplate, "tag1", tag1)
            jsonContactTemplate = Replace(jsonContactTemplate, "first_name_value", ContactName)
            jsonContactTemplate = Replace(jsonContactTemplate, "company_value", CompanyName)
            jsonContactTemplate = Replace(jsonContactTemplate, "email_value", Email)

            Return jsonContactTemplate
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function ProposalToAgile(ProposalId As Integer, companyId As Integer) As Boolean

        Try

            If Not IsOtherProposalInStatus(ProposalId, "Pending") Then

                Dim guid As String = LocalAPI.GetProposalProperty(ProposalId, "guid")

                ProposalRemoveFromAgile(ProposalId, companyId)

                If Not Agile.IsContact(guid, companyId) Then
                    Dim AgileRet As String
                    Dim jsonProposalInfo As String = "{""tags"":[""tag1""], ""properties"":[{""type"":""SYSTEM"", ""name"":""first_name"", ""value"":""first_name_value""}," &
                                                                "{""type"":""SYSTEM"", ""name"":""company"", ""value"":""company_value""}," &
                                                                "{""type"":""SYSTEM"", ""name"":""email"",""value"":""guid_value""}," &
                                                                "{""type"":""SYSTEM"", ""name"":""Phone"", ""value"":""client_Phone_value""}," &
                                                                "{""type"":""CUSTOM"", ""name"":""ProposalNumber"", ""value"":""ProposalNumber_value""}," &
                                                                "{""type"":""CUSTOM"", ""name"":""ProjectName"", ""value"":""ProjectName_value""}," &
                                                                "{""type"":""CUSTOM"", ""name"":""ProjectLocation"", ""value"":""ProjectLocation_value""}," &
                                                                "{""type"":""CUSTOM"", ""name"":""Total"", ""value"":""Total_value""}," &
                                                                "{""type"":""CUSTOM"", ""name"":""clientemail"", ""value"":""clientemail_value""}," &
                                                                "{""type"":""CUSTOM"", ""name"":""clientphone"", ""value"":""customclientphone_value""}," &
                                                                "{""type"":""CUSTOM"", ""name"":""Department"", ""value"":""Department_value""}," &
                                                                "{""type"":""CUSTOM"", ""name"":""ProposalBy"", ""value"":""ProposalBy_value""}," &
                                                                "{""type"":""CUSTOM"", ""name"":""ProposalByEmail"", ""value"":""ProposalByEmail_value""}]}"
                    ' Leer datos del Proposal
                    Dim ProposalObject = LocalAPI.GetRecord(ProposalId, "PROPOSAL_FOR_AGILECRM_SELECT")

                    ' -- Proposal
                    jsonProposalInfo = Replace(jsonProposalInfo, "guid_value", ProposalObject("guid"))
                    jsonProposalInfo = Replace(jsonProposalInfo, "tag1", "PROPOSAL_" & ProposalObject("Status"))
                    jsonProposalInfo = Replace(jsonProposalInfo, "ProposalNumber_value", ProposalObject("ProposalNumber"))
                    jsonProposalInfo = Replace(jsonProposalInfo, "ProjectLocation_value", ProposalObject("ProjectLocation"))
                    jsonProposalInfo = Replace(jsonProposalInfo, "ProjectName_value", ProposalObject("ProjectName"))
                    jsonProposalInfo = Replace(jsonProposalInfo, "Total_value", FormatCurrency(ProposalObject("Total")))

                    ' Client
                    jsonProposalInfo = Replace(jsonProposalInfo, "first_name_value", ProposalObject("FirstName"))
                    jsonProposalInfo = Replace(jsonProposalInfo, "company_value", ProposalObject("Company"))
                    jsonProposalInfo = Replace(jsonProposalInfo, "clientemail_value", ProposalObject("ClientEmail"))
                    'jsonProposalInfo = Replace(jsonProposalInfo, "client_Phone_value", ProposalObject("ClientPhone"))
                    jsonProposalInfo = Replace(jsonProposalInfo, "client_Phone_value", GetPhoneNumber(ProposalObject("ClientPhone")))
                    jsonProposalInfo = Replace(jsonProposalInfo, "customclientphone_value", GetPhoneNumber(ProposalObject("ClientPhone")))

                    ' Department
                    jsonProposalInfo = Replace(jsonProposalInfo, "Department_value", ProposalObject("Department"))

                    ' Proposal By
                    jsonProposalInfo = Replace(jsonProposalInfo, "ProposalBy_value", ProposalObject("ProposalBy"))
                    jsonProposalInfo = Replace(jsonProposalInfo, "ProposalByEmail_value", ProposalObject("ProposalByEmail"))

                    AgileRet = Agile.CreateContact(jsonProposalInfo, companyId)
                End If

                Return True
            End If
        Catch ex As Exception

        End Try

    End Function

    Public Shared Function ProposalRemoveFromAgile(ProposalId As Integer, companyId As Integer) As Boolean
        Try

            Dim guid As String = LocalAPI.GetProposalProperty(ProposalId, "guid")
            Agile.DeleteContact2(guid, companyId)

        Catch ex As Exception

        End Try
    End Function

    Private Shared Function IsOtherProposalInStatus(ProposalId As Integer, statusName As String) As Boolean
        Dim sSQL As String
        Dim clientId As Integer = GetProposalProperty(ProposalId, clientId)
        Select Case statusName
            Case "Pending"
                sSQL = "select count(*) from Proposal where ClientId=" & clientId & " and statusId=1"
            Case "Accepted"
                sSQL = "select count(*) from Proposal where ClientId=" & clientId & " and statusId=2"
            Case "Declined"
                sSQL = "select count(*) from Proposal where ClientId=" & clientId & " and statusId in(3,31,32)"
            Case "Hold"
                sSQL = "select count(*) from Proposal where ClientId=" & clientId & " and statusId=4"
            Case Else
                Return False
        End Select

        Return IIf(GetNumericEscalar(sSQL) > 0, True, False)
    End Function

    Public Shared Function ProposalTAGAgile(ProposalId As Integer, companyId As Integer, TAG As String) As Boolean
        Try
            If Not IsOtherProposalInStatus(ProposalId, TAG) Then
                Dim guid As String = LocalAPI.GetProposalProperty(ProposalId, "guid")

                If Agile.IsContact(guid, companyId) Then
                    Agile.AddTags(guid, TAG, companyId)
                End If
            End If

        Catch ex As Exception

        End Try
    End Function
#End Region

#Region "Pre_Projects"
    Public Shared Function IsPreProject(ByVal Name As String, ByVal clientId As Integer) As Boolean
        Return (GetNumericEscalar("SELECT COUNT(*) FROM [Clients_pre_projects] WHERE clientId=" & clientId & " AND ISNULL(Name,'')='" & Name & "'") > 0)
    End Function

    Public Shared Function GetLastPreProjectInsertedId(ByVal Name As String) As Double
        Return GetNumericEscalar("SELECT top 1 Id FROM [Clients_pre_projects] WHERE [Name]='" & Name & "' order by Id desc")
    End Function

    Public Shared Function GetPre_ProjectsStatusLabelCSS(ByVal statusId As Integer) As String
        '        0   Pending		"warning"
        '        1   Processed		"default"
        Select Case statusId
            Case 0  'Pending
                Return "badge badge-warning statuslabel"
            Case 1  'Processed
                Return "badge badge-dark statuslabel"
        End Select
    End Function

    Public Shared Function SetPreProject_proposalId(ByVal Id As Integer, proposalId As Integer) As Boolean
        Try
            ExecuteNonQuery("UPDATE [Clients_pre_projects] SET proposalId=" & proposalId & ",statusId=1  WHERE Id=" & Id)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetPreProjectProperty(ByVal Id As Integer, sProperty As String) As String
        Try
            Select Case sProperty
                Case "clientId", "DepartmentId", "PreparedBy", "ProposalBy", "statusId", "proposalId"
                    ' Numeric values
                    Return GetNumericEscalar("SELECT ISNULL([" & sProperty & "],0) FROM Clients_pre_projects WHERE Id=" & Id)

                Case Else
                    Return GetStringEscalar("SELECT ISNULL([" & sProperty & "],'') FROM Clients_pre_projects WHERE Id=" & Id)

            End Select

        Catch ex As Exception
            Return 0
        End Try
    End Function

#End Region

#Region "OneSignal_Notifications"
    Public Shared Function PushNotification_INSERT(OriginApp As String, Recipients As String, Heading As String, Body As String, WebUrl As String, Parameters As String, companyId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "PushNotification_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@OriginApp", OriginApp)
            cmd.Parameters.AddWithValue("@Recipients", Recipients)
            cmd.Parameters.AddWithValue("@Heading", Heading)
            cmd.Parameters.AddWithValue("@Body", Body)
            cmd.Parameters.AddWithValue("@WebUrl", WebUrl)
            cmd.Parameters.AddWithValue("@Parameters", Parameters)
            cmd.Parameters.AddWithValue("@companyId", companyId)

            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

#End Region

#Region "Tickets"

    Public Shared Function GetTicketProperty(ByVal ticketId As Integer, ByRef sProperty As String) As String
        Try
            Select Case sProperty
                Case "employeeId", "InvoiceId"
                    'Enteros
                    Return GetNumericEscalar("SELECT ISNULL(" & sProperty & ",0) FROM [Jobs_tickets] WHERE [Id]=" & ticketId)
                Case Else
                    ' String
                    Return GetStringEscalar("SELECT ISNULL(" & sProperty & ",'') FROM [Jobs_tickets] WHERE [Id]=" & ticketId)
            End Select

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function Jobs_ticket_INSERT(JobTicketObject As JobTicketStruct) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Jobs_ticket_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@jobId", JobTicketObject.jobId)
            cmd.Parameters.AddWithValue("@ExpectedStartDate", JobTicketObject.ExpectedStartDate)
            cmd.Parameters.AddWithValue("@LocationModule", JobTicketObject.LocationModule)
            cmd.Parameters.AddWithValue("@AppName", JobTicketObject.AppName)
            cmd.Parameters.AddWithValue("@Title", JobTicketObject.Title)
            cmd.Parameters.AddWithValue("@ClientDescription", JobTicketObject.ClientDescription)
            cmd.Parameters.AddWithValue("@CompanyDescription", JobTicketObject.CompanyDescription)
            cmd.Parameters.AddWithValue("@Notes", JobTicketObject.Notes)
            cmd.Parameters.AddWithValue("@Type", JobTicketObject.Type)
            cmd.Parameters.AddWithValue("@Priority", JobTicketObject.Priority)
            cmd.Parameters.AddWithValue("@Status", JobTicketObject.Status)
            cmd.Parameters.AddWithValue("@ApprovedStatus", JobTicketObject.ApprovedStatus)
            cmd.Parameters.AddWithValue("@StagingDate", JobTicketObject.StagingDate)
            cmd.Parameters.AddWithValue("@ProductionDate", JobTicketObject.ProductionDate)
            cmd.Parameters.AddWithValue("@employeeId", JobTicketObject.employeeId)
            cmd.Parameters.AddWithValue("@NotificationClientName", JobTicketObject.NotificationClientName)
            cmd.Parameters.AddWithValue("@NotificationClientEmail", JobTicketObject.NotificationClientEmail)
            cmd.Parameters.AddWithValue("@NotificationBCClientEmail", JobTicketObject.NotificationBCClientEmail)
            cmd.Parameters.AddWithValue("@trelloURL", JobTicketObject.trelloURL)
            cmd.Parameters.AddWithValue("@jiraURL", JobTicketObject.jiraURL)
            cmd.Parameters.AddWithValue("@Tags", JobTicketObject.Tags)
            cmd.Parameters.AddWithValue("@EstimatedHours", JobTicketObject.EstimatedHours)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            ' evitar error por posible duplicado
            'Throw ex
        End Try
    End Function

    Public Shared Function Jobs_ticket_Status_UPDATE(ByVal ticketId As Integer, ByRef Status As String) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Jobs_ticket_Status_UPDATE"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Id", ticketId)
            cmd.Parameters.AddWithValue("@Status", Status)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            ' evitar error por posible duplicado
            'Throw ex
        End Try
    End Function
    Public Shared Function Jobs_ticket_IMPORT(JobTicketObject As JobTicketStruct) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Jobs_ticket_IMPORT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@jobId", JobTicketObject.jobId)
            cmd.Parameters.AddWithValue("@TicketId", JobTicketObject.TicketId)
            cmd.Parameters.AddWithValue("@LocationModule", JobTicketObject.LocationModule)
            cmd.Parameters.AddWithValue("@AppName", JobTicketObject.AppName)
            cmd.Parameters.AddWithValue("@Title", JobTicketObject.Title)
            cmd.Parameters.AddWithValue("@ClientDescription", JobTicketObject.ClientDescription)
            cmd.Parameters.AddWithValue("@CompanyDescription", JobTicketObject.CompanyDescription)
            cmd.Parameters.AddWithValue("@Notes", JobTicketObject.Notes)
            cmd.Parameters.AddWithValue("@Type", JobTicketObject.Type)
            cmd.Parameters.AddWithValue("@Priority", JobTicketObject.Priority)
            cmd.Parameters.AddWithValue("@Status", JobTicketObject.Status)
            cmd.Parameters.AddWithValue("@ApprovedStatus", JobTicketObject.ApprovedStatus)
            cmd.Parameters.AddWithValue("@employeeId", JobTicketObject.employeeId)
            cmd.Parameters.AddWithValue("@NotificationClientName", JobTicketObject.NotificationClientName)
            cmd.Parameters.AddWithValue("@NotificationClientEmail", JobTicketObject.NotificationClientEmail)
            cmd.Parameters.AddWithValue("@NotificationBCClientEmail", JobTicketObject.NotificationBCClientEmail)
            cmd.Parameters.AddWithValue("@trelloURL", JobTicketObject.trelloURL)
            cmd.Parameters.AddWithValue("@jiraURL", JobTicketObject.jiraURL)
            cmd.Parameters.AddWithValue("@Tags", JobTicketObject.Tags)

            ' Date parameters Null?
            cmd.Parameters.AddWithValue("@ExpectedStartDate", IIf(Len(JobTicketObject.ExpectedStartDate) = 0, DBNull.Value, JobTicketObject.ExpectedStartDate))
            cmd.Parameters.AddWithValue("@StagingDate", IIf(Len(JobTicketObject.StagingDate) = 0, DBNull.Value, JobTicketObject.StagingDate))
            cmd.Parameters.AddWithValue("@ProductionDate", IIf(Len(JobTicketObject.ProductionDate) = 0, DBNull.Value, JobTicketObject.ProductionDate))


            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception
            ' evitar error por posible duplicado
            Throw ex
        End Try
    End Function

    Public Shared Function Jobs_ticket_Delete(ByVal ticketId As Integer) As Boolean
        Return ExecuteNonQuery(String.Format("DELETE FROM Jobs_tickets WHERE Id={0} and Status='Pending Approval'", ticketId))
    End Function
    Public Shared Function GetTickectTypeLabelCSS(ByVal TypeValue As String) As String
        Select Case TypeValue
            Case "Question"
                Return "badge badge-info"
            Case "Enhancement"
                Return "badge badge-success"
            Case "Defect"
                Return "badge badge-danger"
            Case "Change Order"
                Return "badge badge-warning"
            Case "Epic"
                Return "badge badge-primary"
            Case Else
                Return "badge badge-secondary"
        End Select
    End Function

    Public Shared Function GetCollectionStatusLabelCSS(ByVal StatusValue As String) As String
        Select Case StatusValue
            Case "Active"
                Return "badge badge-danger statuslabel"
            Case "Closed"
                Return "badge badge-secondary statuslabel"
        End Select
    End Function

    Public Shared Function GetTickectStatusLabelCSS(ByVal StatusValue As String) As String
        Select Case StatusValue
            Case "Pending Approval"
                Return "badge badge-warning"
            Case "Blocked", "Dismissed"
                Return "badge badge-danger"

            Case "Ready for Development"
                Return "badge badge-info"
            Case "In Progress"
                Return "badge badge-success"
            Case "Ready for Staging"
                Return "badge badge-primary"
            Case "In Staging", "In Production"
                Return "badge badge-secondary"
            Case "Closed"
                Return "badge badge-dark"
            Case Else
                Return "badge badge-light"
        End Select
    End Function

    Public Shared Function GetTickectApprovedStatusLabelCSS(ByVal ApprovedStatus As String) As String
        Select Case ApprovedStatus
            Case "Approved"
                Return "badge badge-success"
            Case "Rejected"
                Return "badge badge-danger"
            Case "Pending"
                Return "badge badge-warning"
            Case Else
                Return "badge badge-secondary"
        End Select
    End Function

    Public Shared Function SendTicketNotificationToClient(jobId As Integer, ticketId As Integer, employeeId As Integer, companyId As Integer) As Boolean
        Try
            Dim Subject As String
            Dim Body As String

            Dim sProjectName As String = LocalAPI.GetJobCodeName(jobId)
            Dim NotificationClientName As String = LocalAPI.GetTicketProperty(ticketId, "NotificationClientName")
            Dim NotificationClientEmail As String = LocalAPI.GetTicketProperty(ticketId, "NotificationClientEmail")

            Dim sSign = LocalAPI.GetCompanySign(companyId)

            ' Leer subjet y body template
            Subject = LocalAPI.GetMessageTemplateSubject("TicketNotification", companyId)
            Body = LocalAPI.GetMessageTemplateBody("TicketNotification", companyId)

            ' sustituir variables
            Subject = Replace(Subject, "[Project Name]", sProjectName)
            Subject = Replace(Subject, "[Ticket ID]", ticketId)


            Body = Replace(Body, "[NotificationClientName]", NotificationClientName)
            Body = Replace(Body, "[Project Name]", sProjectName)
            Body = Replace(Body, "[Ticket ID]", ticketId)
            Body = Replace(Body, "[Sign]", sSign)

            ' Enlace al Ticket
            Dim sURL As String = LocalAPI.GetSharedLink_URL(1205, ticketId)
            Body = Replace(Body, "[TicketLink]", sURL)


            Dim SenderEmail As String = LocalAPI.GetEmployeeEmail(lId:=employeeId)
            Dim SenderDisplay As String = LocalAPI.GetEmployeeName(employeeId)
            SendGrid.Email.SendMail(NotificationClientEmail, SenderEmail, "", Subject, Body, companyId, 0, 0, SenderEmail, SenderDisplay, SenderEmail, SenderDisplay)

            Return True
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function GetActiveJobTicketsCount(jobId As Integer) As Integer
        Return GetNumericEscalar("SELECT COUNT(*) FROM Jobs_tickets WHERE jobId=" & jobId & " and status not in('Closed','Dismissed')")
    End Function

    Public Shared Function IsTicketInJob(jobId As Integer, ticketId As Integer) As Boolean
        Return (GetNumericEscalar("SELECT COUNT(*) FROM Jobs_tickets WHERE jobId=" & jobId & " AND Id=" & ticketId) > 0)
    End Function

    Public Shared Function GetTicketId(jobId As Integer, Title As String) As Integer
        'Return GetNumericEscalar("SELECT top 1 Id FROM Jobs_tickets WHERE jobId=" & jobId & " AND Title='" & Title & "' order by id desc")

        Dim cnn1 As SqlConnection = GetConnection()
        Dim cmd As New SqlCommand("SELECT top 1 Id FROM Jobs_tickets WHERE jobId=@jobId AND Title=@Title order by id desc", cnn1)
        cmd.Parameters.AddWithValue("@jobId", jobId)
        cmd.Parameters.AddWithValue("@Title", Title)
        GetTicketId = Convert.ToDouble(cmd.ExecuteScalar())
        cnn1.Close()

    End Function
    Public Shared Function SendTicketNotificationToEmployee(jobId As Integer, ticketId As Integer, companyId As Integer, UpdateFor As String) As Boolean
        Try
            Dim Subject As String
            Dim Body As String

            Dim sProjectName As String = LocalAPI.GetJobCodeName(jobId)
            Dim NotificationClientName As String = LocalAPI.GetTicketProperty(ticketId, "NotificationClientName")
            Dim NotificationClientEmail As String = LocalAPI.GetTicketProperty(ticketId, "NotificationClientEmail")
            Dim ticketRecord = LocalAPI.GetRecord(ticketId, "Jobs_ticket_SELECT")

            ' Leer subjet y body template
            Subject = "Ticket [Ticket ID] was updated " & UpdateFor
            ' sustituir variables
            Subject = Replace(Subject, "[Project Name]", sProjectName)
            Subject = Replace(Subject, "[Ticket ID]", ticketId)

            Dim sFullBody As New System.Text.StringBuilder
            sFullBody.Append("Ticket <b>[Ticket ID]</b> of project <b>[Project Name]</b> was updated " & UpdateFor)
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("Title: </b>" & ticketRecord("Title") & "</b>")
            sFullBody.Append("<br />")
            sFullBody.Append("Client Description:" & ticketRecord("ClientDescription"))
            sFullBody.Append("<br />")
            sFullBody.Append("Type: " & ticketRecord("Type"))
            sFullBody.Append("<br />")
            sFullBody.Append("Status :</b> " & ticketRecord("Status") & "</b>")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("<a href=[TicketLink]>Click here </a> to view all details.")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("<a href=" & """" & GetHostAppSite() & """" & ">PASconcept</a> Notification")

            Body = sFullBody.ToString
            Body = Replace(Body, "[Project Name]", sProjectName)
            Body = Replace(Body, "[Ticket ID]", ticketId)

            ' Enlace al Ticket
            Dim sURL As String = LocalAPI.GetSharedLink_URL(1206, ticketId)
            Body = Replace(Body, "[TicketLink]", sURL)

            Dim PMEmail As String = GetEmployeeEmail(lId:=LocalAPI.GetTicketProperty(ticketId, "employeeId"))
            Dim OtherEmplEmais As String = LocalAPI.GetTicketProperty(ticketId, "NotificationBCClientEmail")
            Dim clientid = LocalAPI.GetJobProperty(jobId, "Client")

            SendGrid.Email.SendMail(PMEmail, OtherEmplEmais, "jcarlos@axzes.com", Subject, Body, companyId, clientid, jobId)

            Return True
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function IsTicketEditable(Status As String) As Boolean
        Select Case Status
            Case "Closed", "Answered"
                Return False
            Case Else
                Return True
        End Select

    End Function

    Public Shared Function Invoice_FromTicket(ByVal ticketId As Integer) As Integer
        Dim cnn1 As SqlConnection = GetConnection()
        Try

            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "INVOICE_FROM_TICKET_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@TicketId", ticketId)
            ' Execute the stored procedure.
            Dim parOUT_ID As New SqlParameter("@Id_OUT", SqlDbType.Int)
            parOUT_ID.Direction = ParameterDirection.Output
            cmd.Parameters.Add(parOUT_ID)

            cmd.ExecuteNonQuery()

            Return parOUT_ID.Value

        Catch ex As Exception
            Throw ex
        Finally
            cnn1.Close()
        End Try
    End Function
#End Region

#Region "ClientPortal & Acknowledgments"
    Public Shared Function sys_Log_clients_INSERT(IP_Address As String, clientId As Integer, ActionId As Integer, DocumentId As Integer, companyId As Integer) As Boolean
        Try
            ' ActionId codes
            '   1:  Proposal visit page

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "sys_Log_clients_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@IP_Address", IP_Address)
            cmd.Parameters.AddWithValue("@clientId", clientId)
            cmd.Parameters.AddWithValue("@ActionId", ActionId)
            cmd.Parameters.AddWithValue("@DocumentId", DocumentId)
            cmd.Parameters.AddWithValue("@companyId", companyId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function GetClientAcknowledgments(clientId As Integer) As Boolean
        Return IIf(GetNumericEscalar($"select count(*) from Clients_acknowledgments where clientId={clientId} and EndDate Is Null") = 0, False, True)
    End Function

    Public Shared Function ClientAcknowledgment_INSERT(clientId As Integer, Acknowledment As String, Initials As String, IP_Address As String) As Boolean
        Try
            ' ActionId codes
            '   1:  Proposal visit page

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Clients_acknowledgments_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@clientId", clientId)
            cmd.Parameters.AddWithValue("@Acknowledment", Acknowledment)
            cmd.Parameters.AddWithValue("@Initials", Initials)
            cmd.Parameters.AddWithValue("@IP_Address", IP_Address)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function SendClientAcknowledmentEmail(ByVal clientId As Integer, employeeId As Integer, ByVal companyId As Integer) As Boolean

        Try
            Dim employeeEmail As String = GetEmployeeEmail(employeeId)
            Dim ClientObject = GetRecord(clientId, "Client_v20_SELECT")
            Dim sFullBody As New System.Text.StringBuilder
            sFullBody.Append("Mr./Mrs. " & ClientObject("Name") & ":")

            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("In order to improve our communication, we ask for your authorization to send you text messages about Proposals, Invoices and Statements.")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("<a href=" & """" & LocalAPI.GetSharedLink_URL(3001, clientId) & """> Click to Authorize SMS Messages</a>")

            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append("Thank you,")
            sFullBody.Append("<br />")
            sFullBody.Append("<br />")
            sFullBody.Append(GetEmployeesSign(employeeId))

            Try
                SendClientAcknowledmentEmail = SendGrid.Email.SendMail(ClientObject("Email"), employeeEmail, "", "Get SMS updates from " & GetCompanyName(companyId), sFullBody.ToString, companyId, ClientObject("Id"), 0, employeeEmail,, employeeEmail, employeeEmail)
            Finally
            End Try

        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

#Region "Propsal Payment Sschedule"
    Public Shared Function IsGeneralPS(ByVal ProposalId As Integer) As Boolean
        Dim Value = GetNumericEscalar($"select count(*) from Proposal_details where ProposalId={ProposalId} and isnull(paymentscheduleId,0)>0")

        Return IIf(Value = 0, True, False)

    End Function

#End Region

#Region "PASconcept Leads"
    Private Shared Function GetConnection_axzescrmDB() As SqlConnection
        Try
            Dim cnn1 As SqlConnection
            ' Connect to the source
            cnn1 = New SqlConnection(ConfigurationManager.ConnectionStrings("cnnAxzesLeads").ToString)
            ' Open the database
            cnn1.Open()
            ' Return the object
            Return cnn1

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function GetAxzescrmDBRecord(Id As Integer, StoreProcedureName As String) As Dictionary(Of String, Object)
        Dim result = New Dictionary(Of String, Object)()
        Try
            Using conn As SqlConnection = GetConnection_axzescrmDB()
                Using comm As New SqlCommand(StoreProcedureName, conn)
                    comm.CommandType = CommandType.StoredProcedure

                    Dim p0 As New SqlParameter("@Id", SqlDbType.Int)
                    p0.Direction = ParameterDirection.Input
                    p0.Value = Id
                    comm.Parameters.Add(p0)

                    Dim reader = comm.ExecuteReader()
                    If reader.HasRows Then
                        ' We only read one time (of course, its only one result :p)
                        reader.Read()
                        For lp As Integer = 0 To reader.FieldCount - 1
                            result.Add(reader.GetName(lp), reader.GetValue(lp))
                        Next
                    End If
                End Using
            End Using
            Return result
        Catch e As Exception
            Return result
        End Try
    End Function

    Public Shared Function NewPASconceptLead(LaedObject As LeadStruct) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection_axzescrmDB()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = "Leads_Contacs_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            ' Set up the input parameter 
            cmd.Parameters.AddWithValue("@Company", LaedObject.Company)
            cmd.Parameters.AddWithValue("@FirstName", LaedObject.FirstName)
            cmd.Parameters.AddWithValue("@LastName", LaedObject.LastName)
            cmd.Parameters.AddWithValue("@Email", LaedObject.Email)
            cmd.Parameters.AddWithValue("@Phone", LaedObject.Phone)
            cmd.Parameters.AddWithValue("@Cellular", LaedObject.Cellular)
            cmd.Parameters.AddWithValue("@WebSite", LaedObject.Website)
            cmd.Parameters.AddWithValue("@AddressLine1", LaedObject.AddressLine1)
            cmd.Parameters.AddWithValue("@AddressLine2", LaedObject.AddressLine2)
            cmd.Parameters.AddWithValue("@City", LaedObject.City)
            cmd.Parameters.AddWithValue("@State", LaedObject.State)
            cmd.Parameters.AddWithValue("@ZipCode", LaedObject.ZipCode)
            cmd.Parameters.AddWithValue("@JobTitle", LaedObject.JobTitle)
            cmd.Parameters.AddWithValue("@Position", LaedObject.Position)
            cmd.Parameters.AddWithValue("@Tags", LaedObject.Tags)
            cmd.Parameters.AddWithValue("@SourceId", LaedObject.SourceId)

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function SetLeadAgileDate(LaedId As Integer) As Boolean
        Try
            Dim cnn1 As SqlConnection = GetConnection_axzescrmDB()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' Setup the command to execute the stored procedure.
            cmd.CommandText = $"UPDATE [Leads_Contacs] SET AgileDate=GetDate() WHERE Id={LaedId}"

            ' Execute the stored procedure.
            cmd.ExecuteNonQuery()

            cnn1.Close()

            Return True
        Catch ex As Exception

        End Try
    End Function

    Public Shared Function PASconceptLeadToAgile(LeadId As Integer, Tag As String) As Boolean

        Try
            Dim companyId As Integer = 260973     ' Axzes
            Dim LeadObject = GetAxzescrmDBRecord(LeadId, "Lead_SELECT")

            If Not Agile.IsContact(LeadObject("Email"), companyId) Then
                Dim AgileRet As String
                'Dim jsonContactInfo As String = "{""tags"":[""tag_value""], ""properties"":[" &
                '                                                "{""type"":""SYSTEM"", ""name"":""email"",""value"":""email_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"":""first_name"", ""value"":""first_name_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"":""last_name"", ""value"":""last_name_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"":""company"", ""value"":""company_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"":""phone"", ""value"":""phone_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"":""website"", ""value"":""website_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"":""title"", ""value"":""title_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"": ""address"", ""value"":" & "{\""address\"":\""address_value\"",\""city\"":\""city_value\"",\""state\"":\""state_value\"",\""zip\"":\""zip_value\"",\""country\"":\""US\""}}," &
                '                                                "{""type"":""CUSTOM"", ""name"":""Source"", ""value"":""source_value""}" &
                '                                                "]}"

                '{"subtype":null,"name":"address","type":"SYSTEM","value":"{\"country\":\"US\",\"city\":\"doral\",\"latitude\":\"25.819542\",\"countryname\":\"United States\",\"state\":\"fl\",\"longitude\":\"-80.355330\"}"}
                Dim jsonContactInfo As String = "{""tags"":[""tag_value""], ""properties"":[" &
                    "{""type"":""SYSTEM"", ""name"":""email"",""value"":""email_value""}," &
                    "{""type"":""SYSTEM"", ""name"":""first_name"", ""value"":""first_name_value""}," &
                    "{""type"":""SYSTEM"", ""name"":""last_name"", ""value"":""last_name_value""}," &
                    "{""type"":""SYSTEM"", ""name"":""company"", ""value"":""company_value""}," &
                    "{""type"":""SYSTEM"", ""name"":""phone"", ""value"":""phone_value""}," &
                    "{""type"":""SYSTEM"", ""name"":""website"", ""value"":""website_value""}," &
                    "{""type"":""SYSTEM"", ""name"":""title"", ""value"":""title_value""}," &
                    "{""type"":""CUSTOM"", ""name"":""Source"", ""value"":""source_value""}," &
                    "{""type"":""CUSTOM"", ""name"":""Notes"", ""value"":""notes_value""}," &
                    "{""subtype"":null,""name"":""address"",""type"":""SYSTEM"",""value"":""{\""zip\"":\""zip_value\"",\""country\"":\""US\"",\""address\"":\""address_value\"",\""city\"":\""city_value\"",\""countryname\"":\""United States\"",\""state\"":\""state_value\""}""}" &
                    "]}"

                ' -- SYSTEM FIELDS

                jsonContactInfo = Replace(jsonContactInfo, "email_value", LeadObject("Email"))
                jsonContactInfo = Replace(jsonContactInfo, "first_name_value", LeadObject("FirstName"))
                jsonContactInfo = Replace(jsonContactInfo, "last_name_value", LeadObject("LastName"))
                jsonContactInfo = Replace(jsonContactInfo, "company_value", LeadObject("Company"))
                jsonContactInfo = Replace(jsonContactInfo, "phone_value", LeadObject("Phone"))
                jsonContactInfo = Replace(jsonContactInfo, "website_value", LeadObject("WebSite"))
                jsonContactInfo = Replace(jsonContactInfo, "title_value", LeadObject("Position"))
                jsonContactInfo = Replace(jsonContactInfo, "address_value", LeadObject("AddressLine1"))
                jsonContactInfo = Replace(jsonContactInfo, "city_value", LeadObject("City"))
                jsonContactInfo = Replace(jsonContactInfo, "state_value", LeadObject("State"))
                jsonContactInfo = Replace(jsonContactInfo, "zip_value", LeadObject("ZipCode"))

                jsonContactInfo = Replace(jsonContactInfo, "source_value", LeadObject("Source"))
                jsonContactInfo = Replace(jsonContactInfo, "notes_value", LeadObject("JobTitle"))

                jsonContactInfo = Replace(jsonContactInfo, "tag_value", Tag)

                ' Others...........................
                'InAgile Check Column No visible por defecto
                '"Off" Field No visible por defecto
                'Agile Custom Field "Source"
                'Agile Custom Field "Notes" <- JobTitle/Capabilities
                'Agile Standard ?Field "WebSite"
                'Agile Custom Field "State"
                'Agile Custom Field "City"
                'Agile Custom Field "ZipCode"


                AgileRet = Agile.CreateContact(jsonContactInfo, companyId)

            Else
                ' Add new Tag only
                Agile.AddTags(LeadObject("Email"), Tag, companyId)

            End If
            SetLeadAgileDate(LeadId)

            Return True

        Catch ex As Exception

        End Try

    End Function

    Public Shared Function PASconceptClientToAgile(clientId As Integer, Tag As String, employeeId As Integer) As Boolean

        Try
            Dim companyId As Integer = 260973     ' Axzes
            Dim LeadObject = GetRecord(clientId, "ClientForAgile_SELECT")

            If Not Agile.IsContact(LeadObject("Email"), companyId) Then
                Dim AgileRet As String
                'Dim jsonContactInfo As String = "{""tags"":[""tag_value""], ""properties"":[" &
                '                                                "{""type"":""SYSTEM"", ""name"":""email"",""value"":""email_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"":""first_name"", ""value"":""first_name_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"":""last_name"", ""value"":""last_name_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"":""company"", ""value"":""company_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"":""phone"", ""value"":""phone_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"":""website"", ""value"":""website_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"":""title"", ""value"":""title_value""}," &
                '                                                "{""type"":""SYSTEM"", ""name"": ""address"", ""value"":" & "{\""address\"":\""address_value\"",\""city\"":\""city_value\"",\""state\"":\""state_value\"",\""zip\"":\""zip_value\"",\""country\"":\""US\""}}," &
                '                                                "{""type"":""CUSTOM"", ""name"":""Source"", ""value"":""source_value""}" &
                '                                                "]}"

                '{"subtype":null,"name":"address","type":"SYSTEM","value":"{\"country\":\"US\",\"city\":\"doral\",\"latitude\":\"25.819542\",\"countryname\":\"United States\",\"state\":\"fl\",\"longitude\":\"-80.355330\"}"}
                Dim jsonContactInfo As String = "{""tags"":[""tag_value""], ""properties"":[" &
                    "{""type"":""SYSTEM"", ""name"":""email"",""value"":""email_value""}," &
                    "{""type"":""SYSTEM"", ""name"":""first_name"", ""value"":""first_name_value""}," &
                    "{""type"":""SYSTEM"", ""name"":""last_name"", ""value"":""last_name_value""}," &
                    "{""type"":""SYSTEM"", ""name"":""company"", ""value"":""company_value""}," &
                    "{""type"":""SYSTEM"", ""name"":""phone"", ""value"":""phone_value""}," &
                    "{""type"":""SYSTEM"", ""name"":""website"", ""value"":""website_value""}," &
                    "{""type"":""SYSTEM"", ""name"":""title"", ""value"":""title_value""}," &
                    "{""type"":""CUSTOM"", ""name"":""Source"", ""value"":""source_value""}," &
                    "{""type"":""CUSTOM"", ""name"":""Notes"", ""value"":""notes_value""}," &
                    "{""subtype"":null,""name"":""address"",""type"":""SYSTEM"",""value"":""{\""zip\"":\""zip_value\"",\""country\"":\""US\"",\""address\"":\""address_value\"",\""city\"":\""city_value\"",\""countryname\"":\""United States\"",\""state\"":\""state_value\""}""}" &
                    "]}"

                ' -- SYSTEM FIELDS

                jsonContactInfo = Replace(jsonContactInfo, "email_value", LeadObject("Email"))
                jsonContactInfo = Replace(jsonContactInfo, "first_name_value", LeadObject("FirstName"))
                jsonContactInfo = Replace(jsonContactInfo, "last_name_value", LeadObject("LastName"))
                jsonContactInfo = Replace(jsonContactInfo, "company_value", LeadObject("Company"))
                jsonContactInfo = Replace(jsonContactInfo, "phone_value", LeadObject("Phone"))
                jsonContactInfo = Replace(jsonContactInfo, "website_value", LeadObject("WebSite"))
                jsonContactInfo = Replace(jsonContactInfo, "title_value", LeadObject("Position"))
                jsonContactInfo = Replace(jsonContactInfo, "address_value", LeadObject("AddressLine1"))
                jsonContactInfo = Replace(jsonContactInfo, "city_value", LeadObject("City"))
                jsonContactInfo = Replace(jsonContactInfo, "state_value", LeadObject("State"))
                jsonContactInfo = Replace(jsonContactInfo, "zip_value", LeadObject("ZipCode"))

                jsonContactInfo = Replace(jsonContactInfo, "source_value", LeadObject("Source"))
                jsonContactInfo = Replace(jsonContactInfo, "notes_value", LeadObject("JobTitle"))

                jsonContactInfo = Replace(jsonContactInfo, "tag_value", Tag)

                ' Others...........................
                'InAgile Check Column No visible por defecto
                '"Off" Field No visible por defecto
                'Agile Custom Field "Source"
                'Agile Custom Field "Notes" <- JobTitle/Capabilities
                'Agile Standard ?Field "WebSite"
                'Agile Custom Field "State"
                'Agile Custom Field "City"
                'Agile Custom Field "ZipCode"


                AgileRet = Agile.CreateContact(jsonContactInfo, companyId)

            Else
                ' Add new Tag only
                Agile.AddTags(LeadObject("Email"), Tag, companyId)

            End If

            LocalAPI.Clients_activities_INSERT(clientId, "A", "Clients", "Clients", employeeId)

            Return True

        Catch ex As Exception

        End Try

    End Function
#End Region


#Region "40 years app"
    Public Shared Function SendMail40year(ByVal sTo As String, ByVal sCC As String, ByVal sCCO As String, ByVal sSubtject As String, ByVal sBody As String,
                                    Optional ByVal sFromMail As String = "", Optional ByVal sFromDisplay As String = "") As Boolean
        Try

            Dim host As String
            Dim fromAddr As String
            Dim sUserName As String
            Dim sPassword As String
            Dim EnableSsl As Integer
            Dim Port As Integer

            ' Si existe credenciales de envio de email desde una company, se utilizan
            host = "smtp.office365.com"
            fromAddr = "admin@easterneg.com"
            sUserName = "admin@easterneg.com"
            sPassword = "ViejaLind@"
            EnableSsl = "1"
            Port = 587

            Dim smtp As New SmtpClient(host)
            smtp.UseDefaultCredentials = False
            smtp.Credentials = New System.Net.NetworkCredential(sUserName, sPassword)
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network
            smtp.EnableSsl = EnableSsl
            smtp.Port = Port
            'smtp.Timeout = 10000

            Dim message As New MailMessage()
            'message.To.Add(sTo)
            If Len(sTo) > 0 Then MessageAddEmailList(message, sTo, "To")
            If Len(sCC) > 0 Then MessageAddEmailList(message, sCC, "CC")
            If Len(sCCO) > 0 Then MessageAddEmailList(message, sCCO, "CCO")

            message.Subject = sSubtject
            message.IsBodyHtml = True
            message.Body = sBody

            Dim sFrom As String = sFromMail
            If sFrom.Length = 0 Then sFrom = fromAddr
            message.From = New MailAddress(sFrom, "Eastern Engineering Group")

            smtp.Send(message)


            Dim sAdresses As String = sTo
            If Len(sCC) > 0 And sTo <> sCC Then
                sAdresses = sAdresses & ";" & sCC
            End If

            Return True

        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

#Region "Progress Invoices"
    Public Shared Function GetInvoices_progress_detailsProperty(Invoices_progress_detailsId As Integer, sProperty As String) As String
        Return GetStringEscalar($"SELECT isnull([" & sProperty & "],'') FROM Invoices_progress_details WHERE Id={Invoices_progress_details}")
    End Function

    Public Shared Function NuevoInvoiceProgress(ByVal lJob As Integer,
                                    ByVal sInvoiceDate As DateTime,
                                    ByVal dAmount As Double,
                                    ByVal sInvoiceNotes As String,
                                    Optional employeeId As Integer = 0) As Integer
        Try

            Dim Number As Integer = GetInvoiceNumber(lJob)

            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "INVOICE_Progress_v20_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@JobId", lJob)
            cmd.Parameters.AddWithValue("@InvoiceDate", sInvoiceDate)
            cmd.Parameters.AddWithValue("@Amount", FormatearNumero2Tsql(dAmount))
            cmd.Parameters.AddWithValue("@InvoiceNotes", sInvoiceNotes)
            cmd.Parameters.AddWithValue("@Number", Number)
            cmd.Parameters.AddWithValue("@employeeId", employeeId)

            cmd.ExecuteNonQuery()

            cnn1.Close()


            Return GetNumericEscalar("SELECT TOP 1 [Id] FROM [Invoices] where [JobId]=" & lJob & " order by Id desc")

            'Dim companyId As Integer = GetCompanyIdFromJob(lJob)
            'LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.NewInvoice, companyId, sInvoiceNotes)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function ProgressInvoices_INSERT(ByVal jobId As Integer, ByVal SourceId As Integer, InvoiceDate As DateTime, MaturityDate As DateTime, InvoiceNotes As String, employeeId As Integer) As Integer
        Dim cnn1 As SqlConnection = GetConnection()
        Try

            Dim cmd As SqlCommand = cnn1.CreateCommand()
            Dim Number As Integer = GetInvoiceNumber(jobId)

            cmd.CommandText = "INVOICE_Progress_v20_INSERT"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@JobId", jobId)
            cmd.Parameters.AddWithValue("@InvoiceDate", InvoiceDate)
            If Not (MaturityDate = Nothing) Then
                cmd.Parameters.AddWithValue("@MaturityDate", MaturityDate)
            Else
                cmd.Parameters.AddWithValue("@MaturityDate", DBNull.Value)
            End If
            cmd.Parameters.AddWithValue("@InvoiceNotes", InvoiceNotes)
            cmd.Parameters.AddWithValue("@Number", Number)
            cmd.Parameters.AddWithValue("@employeeId", employeeId)
            cmd.Parameters.AddWithValue("@sourceId", SourceId)

            cmd.ExecuteNonQuery()

            Return GetNumericEscalar($"SELECT TOP 1 [Id] FROM [Invoices] where [JobId]={jobId} and InvoiceType=3 order by Id desc")

        Catch ex As Exception
            ' Evita tratamiento de error
            Return 0
        Finally
            cnn1.Close()
        End Try

    End Function

    Public Shared Sub INVOICE_PAYMENTS_QB_INSERT(InvoiceId As Integer, CollectedDate As DateTime, Method As Integer, Amount As Double, CollectedNotes As String, qbPaymentId As Integer)
        Try
            Dim cnn1 As SqlConnection = GetConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            cmd.CommandText = "INVOICE_PAYMENTS_QB_INSERT"
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@InvoiceId", InvoiceId)
            cmd.Parameters.AddWithValue("@CollectedDate", CollectedDate)
            cmd.Parameters.AddWithValue("@Method", Method)
            cmd.Parameters.AddWithValue("@Amount", Amount)
            cmd.Parameters.AddWithValue("@CollectedNotes", CollectedNotes)
            cmd.Parameters.AddWithValue("@qbPaymentId", qbPaymentId)

            cmd.ExecuteNonQuery()

            cnn1.Close()
        Catch ex As Exception

        End Try
    End Sub


#End Region
End Class

