﻿Imports Intuit.Ipp.Core
Imports Intuit.Ipp.Data
Imports Intuit.Ipp.DataService
Imports Intuit.Ipp.QueryFilter
Imports Intuit.Ipp.LinqExtender
Imports Intuit.Ipp.Core.Configuration
Imports System.Linq
Imports Intuit.Ipp.Security
Imports Newtonsoft.Json
Imports System.Data.SqlClient
Imports Intuit.Ipp.OAuth2PlatformClient

Public Class qbAPI

    Public Shared Function GetServiceContext(companyId As String) As ServiceContext
        Try
            Dim accessToken = LocalAPI.GetqbAccessToken(companyId)
            Dim qbComapny = LocalAPI.GetqbCompanyID(companyId)
            Dim oauthValidator = New OAuth2RequestValidator(accessToken)

            'Create a ServiceContext with Auth tokens And realmId
            Dim serviceContext = New ServiceContext(qbComapny, IntuitServicesType.QBO, oauthValidator)
            serviceContext.IppConfiguration.MinorVersion.Qbo = "23"
            serviceContext.IppConfiguration.BaseUrl.Qbo = "https://sandbox-quickbooks.api.intuit.com/"
            Return serviceContext

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function IsValidAccessToken(companyId As String) As Boolean
        Try
            Dim valid = LocalAPI.GetScalar(Of Integer)("SELECT  case when isnull(qbAccessTokenExpire,dbo.CurrentTime()) > DATEADD (ss, 600, dbo.CurrentTime())  then 1 else 0 end FROM Company where companyId=" & companyId)
            IsValidAccessToken = (valid > 0)
            Exit Function
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try
        IsValidAccessToken = False
    End Function

    Public Shared Function IsValidRefreshToken(companyId As String) As Boolean
        Try
            Dim valid = LocalAPI.GetScalar(Of Integer)("SELECT  case when isnull(qbRefreshTokenExpire,dbo.CurrentTime()) > DATEADD (ss, 600, dbo.CurrentTime())  then 1 else 0 end FROM Company where companyId=" & companyId)
            IsValidRefreshToken = (valid > 0)
            Exit Function
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try
        IsValidRefreshToken = False
    End Function

    Public Shared Async Function UpdateAccessTokenAsync(companyId As String) As Threading.Tasks.Task(Of Boolean)
        Try
            Dim clientid = ConfigurationManager.AppSettings("clientid")
            Dim clientsecret = ConfigurationManager.AppSettings("clientsecret")
            Dim redirectUrl = ConfigurationManager.AppSettings("redirectUrl")
            Dim environment = ConfigurationManager.AppSettings("appEnvironment")
            Dim auth2Client As OAuth2Client = New OAuth2Client(clientid, clientsecret, redirectUrl, environment)

            Dim tokenResp = Await auth2Client.RefreshTokenAsync(LocalAPI.GetqbAccessTokenSecret(companyId))

            LocalAPI.SetqbAccessToken(companyId, tokenResp.AccessToken, tokenResp.AccessTokenExpiresIn)

            Return True
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try
        Return False
    End Function

    Public Shared Function GetDataService(companyID As String, accessToken As String, accessTokenSecret As String) As DataService
        Try
            Return New DataService(GetServiceContext(companyID))

        Catch ex As Exception
            Throw ex
        End Try

    End Function
    Public Shared Function GetDataService(ServiceContext1 As ServiceContext) As DataService
        Try
            Return New DataService(ServiceContext1)

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function GetQueryService(Of T As IEntity)(companyID As String, accessToken As String, accessTokenSecret As String) As QueryService(Of T)
        Try

            Return New QueryService(Of T)(GetServiceContext(companyID))

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetQueryService(Of T As IEntity)(ServiceContext1 As ServiceContext) As QueryService(Of T)
        Try

            Return New QueryService(Of T)(ServiceContext1)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Shared Function qqValidName(OriginalName As String) As String
        Return Trim(Left(Replace(OriginalName, ",", ""), 25))
    End Function
    Private Shared Function qqValidWeb(OriginalWeb As String) As String
        If Left(LCase(OriginalWeb), 4) = "http" Then
            Return OriginalWeb
        Else
            Return "http://" & OriginalWeb
        End If
    End Function

    'Private Shared Function IsQBEmployee(queryService As QueryService(Of employee), entity As employee) As String
    '    Try

    '        If queryService.Where(Function(i) i.GivenName = entity.GivenName And i.FamilyName = entity.FamilyName).Count > 0 Then
    '            Return queryService.Where(Function(i) i.GivenName = entity.GivenName And i.FamilyName = entity.FamilyName).FirstOrDefault().Id
    '        End If
    '    Catch ex As Exception
    '        '!!! Error Could not load file or assembly ' Newtonsoft. Json, Version 4.5.0.0, Culture = neutral, PublicKeyToken = 30ad4fe6b2a6aeed ' or one of its dependencie
    '        ' Error producto de la version de Json 8.000, funciona con la 5.6
    '        Throw ex
    '    End Try
    'End Function
    'Private Shared Function IsQBEmployeeId(queryService As QueryService(Of employee), qbEmployeeId As String) As String
    '    Try

    '        If queryService.Where(Function(i) i.Id = qbEmployeeId).Count > 0 Then
    '            Return qbEmployeeId
    '        End If
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function

    'Private Shared Function IsQBCustomer(queryService As QueryService(Of Customer), entity As Customer) As String
    '    Try
    '        Dim nCustomers As Integer = queryService.Where(Function(i) i.GivenName = entity.GivenName And i.FamilyName = entity.FamilyName).Count
    '        If nCustomers > 0 Then
    '            Return queryService.Where(Function(i) i.GivenName = entity.GivenName And i.FamilyName = entity.FamilyName).FirstOrDefault().Id
    '        End If
    '    Catch ex As Exception
    '        ' Error Could not load file or assembly ' Newtonsoft. Json, Version 4.5.0.0, Culture = neutral, PublicKeyToken = 30ad4fe6b2a6aeed ' or one of its dependencie
    '        ' Error producto de la version de Json 8.000, funciona con la 5.6
    '        Throw ex
    '    End Try
    'End Function

    'Private Shared Function IsQBCustomerId(queryService As QueryService(Of Customer), qbCustomerId As String) As String
    '    Try
    '        Dim nCustomers As Integer = queryService.Where(Function(i) i.Id = qbCustomerId).Count

    '        If nCustomers > 0 Then
    '            Return qbCustomerId
    '        End If
    '    Catch ex As Exception
    '        ' Error Could not load file or assembly ' Newtonsoft. Json, Version 4.5.0.0, Culture = neutral, PublicKeyToken = 30ad4fe6b2a6aeed ' or one of its dependencie
    '        ' Error producto de la version de Json 8.000, funciona con la 5.6
    '        Throw ex
    '    End Try
    'End Function

    'Public Shared Function CreateUpdateQBEmployee(employeeId As Integer, companyId As Integer, userEmail As String) As String
    '    Try
    '        Dim resultEmployee As employee
    '        Dim qbCompanyID As String = LocalAPI.GetqbCompanyID(companyId)
    '        If Len(qbCompanyID) > 0 Then
    '            Dim accessToken As String = LocalAPI.GetqbAccessToken(companyId)
    '            Dim accessTokenSecret As String = LocalAPI.GetqbAccessTokenSecret(companyId)

    '            ' Leer Reader con los datos del Employee...
    '            Dim cnn1 As SqlConnection = LocalAPI.GetConnection()
    '            Dim cmd As New SqlCommand("SELECT [Id], [Name], isnull(LastName,'') as LastName, " &
    '                                            "[Email], isnull(Phone,'') as Phone, isnull(Cellular,'') as Cellular, " &
    '                                            "isnull(Address,'') as Address, isnull(Address2,'') as Address2, isnull(City,'') as City, isnull(Estate,'') as Estate, isnull(ZipCode,'') as ZipCode, " &
    '                                            "isnull(qbEmployeeId,0) as qbEmployeeId, isnull(SS,'') as SS, isnull([DOB],'1900-01-01') as [DOB], isnull(Gender,'') as Gender  " &
    '                                      "FROM [Employees] WHERE [Id]=" & employeeId, cnn1)
    '            Dim rdr As SqlDataReader
    '            rdr = cmd.ExecuteReader
    '            rdr.Read()
    '            If rdr.HasRows Then
    '                Dim qbEmployeeId As Integer = rdr("qbEmployeeId")
    '                Dim ServiceContext1 As ServiceContext = GetServiceContext(qbCompanyID, accessToken, accessTokenSecret)
    '                Dim service As DataService = GetDataService(ServiceContext1)
    '                Dim queryService As QueryService(Of employee) = GetQueryService(Of employee)(ServiceContext1)
    '                Dim entity As employee

    '                If qbEmployeeId > 0 Then
    '                    ' Comprobar que no se ha borrado
    '                    qbEmployeeId = IsQBEmployeeId(queryService, qbEmployeeId)
    '                End If

    '                If qbEmployeeId > 0 Then
    '                    entity = queryService.Where(Function(i) i.Id = qbEmployeeId).FirstOrDefault()
    '                Else
    '                    ' Name
    '                    entity = New employee()
    '                    entity.GivenName = qqValidName(rdr("Name"))
    '                    If Len(rdr("LastName")) > 0 Then
    '                        entity.FamilyName = qqValidName(rdr("LastName"))
    '                    Else
    '                        entity.FamilyName = "?"
    '                    End If
    '                End If

    '                ' Email
    '                Dim emailAddress As New EmailAddress()
    '                emailAddress.Address = rdr("Email")
    '                entity.PrimaryEmailAddr = emailAddress

    '                ' Address
    '                If Len(rdr("Address")) > 0 Then
    '                    Dim physicalAddress As New PhysicalAddress()
    '                    physicalAddress.Line1 = rdr("Address")
    '                    physicalAddress.Line2 = rdr("Address2")
    '                    physicalAddress.City = rdr("City")
    '                    physicalAddress.CountrySubDivisionCode = rdr("Estate")
    '                    physicalAddress.PostalCode = rdr("ZipCode")
    '                    entity.PrimaryAddr = physicalAddress
    '                End If

    '                ' Phone and Cellular
    '                If Len(rdr("Phone")) > 0 Then
    '                    Dim PhoneNumber As New TelephoneNumber()
    '                    PhoneNumber.FreeFormNumber = rdr("Phone")
    '                    entity.PrimaryPhone = PhoneNumber
    '                End If
    '                If Len(rdr("Cellular")) > 0 Then
    '                    Dim CellularNumber As New TelephoneNumber()
    '                    CellularNumber.FreeFormNumber = rdr("Cellular")
    '                    entity.Mobile = CellularNumber
    '                End If

    '                'SSN
    '                If Len(rdr("SS")) > 0 Then entity.SSN = rdr("SS")
    '                ' DOB
    '                If Year(rdr("DOB")) > 1901 Then
    '                    entity.BirthDate = rdr("DOB")
    '                End If

    '                ' Gender
    '                If Len(rdr("Gender")) > 0 Then
    '                    If rdr("Gender") = "M" Then
    '                        entity.Gender = Intuit.Ipp.Data.gender.Male
    '                    Else
    '                        entity.Gender = Intuit.Ipp.Data.gender.Female
    '                    End If
    '                End If

    '                If qbEmployeeId = 0 Then
    '                    ' No sincronizado todavia. Preguntar si ya existe antes de crearlo?
    '                    qbEmployeeId = IsQBEmployee(queryService, entity)

    '                    If qbEmployeeId = 0 Then
    '                        ' New en QB
    '                        resultEmployee = service.Add(entity)
    '                        ' Leer Guardar qbEmployeeId en Employee
    '                        qbEmployeeId = resultEmployee.ID
    '                    End If
    '                    LocalAPI.ExecuteNonQuery("UPDATE [Employees] SET qbEmployeeId=" & qbEmployeeId & " WHERE Id=" & rdr("Id"))
    '                Else
    '                    ' Update
    '                    ' Genera error. Jorgito!!!
    '                    'resultEmployee = service.Update(entity)
    '                End If

    '                LocalAPI.sys_log_Nuevo(userEmail, LocalAPI.sys_log_AccionENUM.PAS_IntuitQB, companyId, "Client: " & rdr("Name"))

    '                Return JsonConvert.SerializeObject(resultEmployee)

    '            End If
    '            rdr.Close()


    '        End If
    '    Catch ex As Exception
    '        ' Posibles causas
    '        'BadRequest(400). Another employee, vendor, or customer is already using this name.  Please enter a different name.
    '        Throw ex
    '    End Try
    'End Function

    'Public Shared Function CreateUpdateQBCustomer(clientId As Integer, companyId As Integer, userEmail As String) As String
    '    Try
    '        Dim resultCustomer As Customer
    '        Dim qbCompanyID As String = LocalAPI.GetqbCompanyID(companyId)
    '        If Len(qbCompanyID) > 0 Then
    '            Dim accessToken As String = LocalAPI.GetqbAccessToken(companyId)
    '            Dim accessTokenSecret As String = LocalAPI.GetqbAccessTokenSecret(companyId)

    '            ' Leer Reader con los datos del Customer...
    '            Dim cnn1 As SqlConnection = LocalAPI.GetConnection()
    '            Dim cmd As New SqlCommand("SELECT [Id], [Name], SUBSTRING([Name], 1, CHARINDEX(' ', [Name]) - 1) AS FirstName, SUBSTRING([Name], CHARINDEX(' ', [Name]) + 1, 8000) AS LastName, isnull([Company],'') as Company, " &
    '                                            "[Email], isnull(Phone,'') as Phone, isnull(Cellular,'') as Cellular, isnull(Fax,'') as Fax, isnull(Web,'') as Web, " &
    '                                            "isnull(Address,'') as Address, isnull(Address2,'') as Address2, isnull(City,'') as City, isnull(State,'') as State, isnull(ZipCode,'') as ZipCode, " &
    '                                            "isnull(qbCustomerId,0) as qbCustomerId " &
    '                                      "FROM [Clients] WHERE [Id]=" & clientId, cnn1)
    '            Dim rdr As SqlDataReader
    '            rdr = cmd.ExecuteReader
    '            rdr.Read()
    '            If rdr.HasRows Then
    '                Dim qbCustomerId As String = rdr("qbCustomerId")
    '                Dim ServiceContext1 As ServiceContext = GetServiceContext(qbCompanyID, accessToken, accessTokenSecret)
    '                Dim service As DataService = GetDataService(ServiceContext1)
    '                Dim queryService As QueryService(Of Customer) = GetQueryService(Of Customer)(ServiceContext1)
    '                Dim entity As Customer

    '                If qbCustomerId > 0 Then
    '                    ' Comprobar que no se ha borrado
    '                    qbCustomerId = IsQBCustomerId(queryService, qbCustomerId)
    '                End If

    '                If qbCustomerId > 0 Then
    '                    entity = queryService.Where(Function(i) i.Id = qbCustomerId).FirstOrDefault()
    '                Else
    '                    ' Name
    '                    entity = New Customer()
    '                    If Len(rdr("FirstName")) > 0 Then
    '                        entity.GivenName = qqValidName(rdr("FirstName"))
    '                        If Len(rdr("LastName")) > 0 Then
    '                            entity.FamilyName = qqValidName(rdr("LastName"))
    '                        Else
    '                            entity.FamilyName = "?"
    '                        End If
    '                    Else
    '                        entity.GivenName = qqValidName(rdr("Name"))
    '                        entity.FamilyName = "?"
    '                    End If
    '                End If

    '                ' Email
    '                Dim emailAddress As New EmailAddress()
    '                emailAddress.Address = rdr("Email")
    '                entity.PrimaryEmailAddr = emailAddress

    '                ' Company
    '                If Len(rdr("Company")) > 0 Then
    '                    entity.CompanyName = Left(rdr("Company"), 50)
    '                End If

    '                ' Address
    '                If Len(rdr("Address")) > 0 Then
    '                    Dim physicalAddress As New PhysicalAddress()
    '                    physicalAddress.Line1 = rdr("Address")
    '                    physicalAddress.Line2 = rdr("Address2")
    '                    physicalAddress.City = rdr("City")
    '                    physicalAddress.CountrySubDivisionCode = rdr("State")
    '                    physicalAddress.PostalCode = rdr("ZipCode")
    '                    entity.BillAddr = physicalAddress
    '                End If

    '                ' Phone, Fax and Cellular
    '                If Len(rdr("Phone")) > 0 Then
    '                    Dim PhoneNumber As New TelephoneNumber()
    '                    PhoneNumber.FreeFormNumber = rdr("Phone")
    '                    entity.PrimaryPhone = PhoneNumber
    '                End If
    '                If Len(rdr("Fax")) > 0 Then
    '                    Dim FaxNumber As New TelephoneNumber
    '                    FaxNumber.FreeFormNumber = rdr("Fax")
    '                    entity.Fax = FaxNumber
    '                End If
    '                If Len(rdr("Cellular")) > 0 Then
    '                    Dim CellularNumber As New TelephoneNumber()
    '                    CellularNumber.FreeFormNumber = rdr("Cellular")
    '                    entity.Mobile = CellularNumber
    '                End If

    '                If Len(rdr("Web")) > 0 Then
    '                    Dim Web As New WebSiteAddress()
    '                    Web.URI = qqValidWeb(rdr("Web"))
    '                    entity.WebAddr = Web
    '                End If

    '                entity.Job = False

    '                If qbCustomerId = 0 Then
    '                    ' No sincronizado todavia. Preguntar si ya existe antes de crearlo?
    '                    qbCustomerId = IsQBCustomer(queryService, entity)
    '                    If qbCustomerId = 0 Then
    '                        ' New
    '                        resultCustomer = service.Add(entity)
    '                        ' Leer Guardar qbCustomerId en Customer
    '                        qbCustomerId = resultCustomer.Id
    '                    End If
    '                    LocalAPI.ExecuteNonQuery("UPDATE [Clients] SET qbCustomerId=" & qbCustomerId & " WHERE Id=" & rdr("Id"))
    '                Else
    '                    ' Update
    '                    ' Genera error. Jorgito!!!
    '                    'resultCustomer = service.Update(entity)
    '                End If

    '                LocalAPI.sys_log_Nuevo(userEmail, LocalAPI.sys_log_AccionENUM.PAS_IntuitQB, companyId, "Client: " & rdr("FirstName"))

    '                Return JsonConvert.SerializeObject(resultCustomer)

    '            End If
    '            rdr.Close()


    '        End If
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function

    'Private Shared Function CreateUpdateQBJob(JobId As Integer, companyId As Integer, userEmail As String) As String
    '    Try

    '        Dim clientId As Integer = LocalAPI.GetJobProperty(JobId, "Client")
    '        Dim qbCustomerId As Integer
    '        If clientId > 0 Then
    '            qbCustomerId = LocalAPI.GetClientProperty(clientId, "qbCustomerId")
    '            If qbCustomerId = 0 Then
    '                ' 1.- Crear cliente en QB...................si no existe
    '                CreateUpdateQBCustomer(clientId, companyId, userEmail)
    '                qbCustomerId = LocalAPI.GetClientProperty(clientId, "qbCustomerId")
    '            End If
    '        End If

    '        Dim resultJob As Customer
    '        Dim qbCompanyID As String = LocalAPI.GetqbCompanyID(companyId)
    '        If Len(qbCompanyID) > 0 Then
    '            Dim accessToken As String = LocalAPI.GetqbAccessToken(companyId)
    '            Dim accessTokenSecret As String = LocalAPI.GetqbAccessTokenSecret(companyId)

    '            ' Leer Reader con los datos del Customer...
    '            Dim cnn1 As SqlConnection = LocalAPI.GetConnection()
    '            Dim cmd As New SqlCommand("SELECT Jobs.Id, Jobs.Code,Jobs.Job, Clients.[Email], " &
    '                                            "isnull(qbJobId,0) as qbJobId, " &
    '                                            "isnull(Address,'') as Address, isnull(Address2,'') as Address2, isnull(City,'') as City, isnull(State,'') as State, isnull(ZipCode,'') as ZipCode " &
    '                                        "FROM Jobs LEFT OUTER JOIN Clients ON Jobs.Client = Clients.Id WHERE Jobs.Id=" & JobId, cnn1)
    '            Dim rdr As SqlDataReader
    '            rdr = cmd.ExecuteReader
    '            rdr.Read()
    '            If rdr.HasRows Then
    '                Dim qbJobId As Integer = rdr("qbJobId")
    '                Dim service As DataService = GetDataService(qbCompanyID, accessToken, accessTokenSecret)
    '                Dim entity As Customer

    '                If qbJobId > 0 Then
    '                    Dim queryService As QueryService(Of Customer) = GetQueryService(Of Customer)(qbCompanyID, accessToken, accessTokenSecret)
    '                    entity = queryService.Where(Function(i) i.Id = qbJobId).FirstOrDefault()
    '                Else
    '                    ' Name
    '                    entity = New Customer()
    '                    entity.Title = rdr("Code")
    '                    entity.GivenName = qqValidName(rdr("Job"))
    '                End If

    '                ' Propiedades heredadas del Parent
    '                ' Email
    '                Dim emailAddress As New EmailAddress()
    '                emailAddress.Address = rdr("Email")
    '                entity.PrimaryEmailAddr = emailAddress
    '                ' Address
    '                If Len(rdr("Address")) > 0 Then
    '                    Dim physicalAddress As New PhysicalAddress()
    '                    physicalAddress.Line1 = rdr("Address")
    '                    physicalAddress.Line2 = rdr("Address2")
    '                    physicalAddress.City = rdr("City")
    '                    physicalAddress.CountrySubDivisionCode = rdr("State")
    '                    physicalAddress.PostalCode = rdr("ZipCode")
    '                    entity.BillAddr = physicalAddress
    '                End If


    '                ' Propiedades especificas de un subcustomer
    '                Dim parentRefCustomer As New ReferenceType
    '                parentRefCustomer.Value = qbCustomerId
    '                entity.ParentRef = parentRefCustomer
    '                entity.Job = True
    '                entity.JobSpecified = True
    '                entity.BillWithParent = True
    '                entity.Level = 1

    '                If qbJobId = 0 Then
    '                    ' New
    '                    resultJob = service.Add(entity)
    '                    ' Leer Guardar qbJobId en Job
    '                    qbJobId = resultJob.Id
    '                    LocalAPI.ExecuteNonQuery("UPDATE [Jobs] SET qbJobId=" & qbJobId & " WHERE Id=" & rdr("Id"))
    '                Else
    '                    ' Update
    '                    ' Genera error. Jorgito!!!
    '                    'resultCustomer = service.Update(entity)
    '                End If

    '                Return JsonConvert.SerializeObject(resultJob)

    '            End If
    '            rdr.Close()


    '        End If
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function

    'Public Shared Function CreateUpdateQBInvoice(invoiceId As Integer, companyId As Integer, userEmail As String) As String
    '    Try
    '        ' Invoices to QB
    '        Dim JobId As Integer = LocalAPI.GetInvoiceProperty(invoiceId, "JobId")
    '        Dim qbJobId As Integer = LocalAPI.GetJobProperty(JobId, "qbJobId")
    '        If qbJobId = 0 Then
    '            ' 1.- Crear Job (subCustomer) en QB...................si no existe
    '            CreateUpdateQBJob(JobId, companyId, userEmail)
    '            qbJobId = LocalAPI.GetJobProperty(JobId, "qbJobId")
    '        End If

    '        Dim resultInvoice As invoice
    '        Dim qbCompanyID As String = LocalAPI.GetqbCompanyID(companyId)
    '        If Len(qbCompanyID) > 0 Then
    '            Dim accessToken As String = LocalAPI.GetqbAccessToken(companyId)
    '            Dim accessTokenSecret As String = LocalAPI.GetqbAccessTokenSecret(companyId)

    '            ' Leer Reader con los datos del Customer...
    '            Dim cnn1 As SqlConnection = LocalAPI.GetConnection()
    '            Dim cmd As New SqlCommand("SELECT Invoices.Id, dbo.InvoiceNumber(Invoices.Id) AS InvoiceNumber, Clients.Email, InvoiceDate, Invoices.InvoiceNotes, Invoices.Amount, isnull(qbInvoiceId,0) as qbInvoiceId " &
    '                                      "FROM Jobs RIGHT OUTER JOIN Invoices ON Jobs.Id = Invoices.JobId LEFT OUTER JOIN Clients ON Jobs.Client = Clients.Id " &
    '                                      "WHERE Invoices.Id=" & invoiceId, cnn1)
    '            Dim rdr As SqlDataReader
    '            rdr = cmd.ExecuteReader
    '            rdr.Read()
    '            If rdr.HasRows Then
    '                Dim bOnlinePayment As Boolean = LocalAPI.IsQuickBookOnlinePayment(companyId)
    '                Dim qbInvoiceId As Integer = rdr("qbInvoiceId")
    '                Dim service As DataService = GetDataService(qbCompanyID, accessToken, accessTokenSecret)
    '                Dim entity As invoice

    '                ' QueryService<Item> itemQueryService = new QueryService<Item>(context);
    '                ' Item item = itemQueryService.ExecuteIdsQuery("Select * From Item StartPosition 1 MaxResults 1").FirstOrDefault<Item>();
    '                'Dim queryItems As QueryService(Of Item) = GetQueryService(Of Item)(qbCompanyID, accessToken, accessTokenSecret)
    '                'Dim item As Item = queryItems.Where(Function(i) i.Id > 0).FirstOrDefault()
    '                Dim ServiceContext1 As ServiceContext = GetServiceContext(qbCompanyID, accessToken, accessTokenSecret)
    '                Dim queryItems As QueryService(Of Item) = New QueryService(Of Item)(ServiceContext1)
    '                Dim item As Item = queryItems.ExecuteIdsQuery("Select * From Item StartPosition 1 MaxResults 1").FirstOrDefault


    '                If qbInvoiceId > 0 Then
    '                    Dim queryService As QueryService(Of invoice) = GetQueryService(Of invoice)(qbCompanyID, accessToken, accessTokenSecret)
    '                    entity = queryService.Where(Function(i) i.Id = qbInvoiceId).FirstOrDefault()
    '                Else
    '                    ' Name
    '                    entity = New invoice()
    '                    entity.DocNumber = rdr("InvoiceNumber")
    '                End If
    '                entity.BillEmail = New EmailAddress()
    '                entity.BillEmail.Address = rdr("Email")
    '                entity.AutoDocNumberSpecified = True
    '                entity.DueDate = rdr("InvoiceDate")
    '                entity.CustomerRef = New ReferenceType() With {.Value = qbJobId}

    '                If bOnlinePayment Then
    '                    ' AllowOnlinePayment
    '                    entity.AllowIPNPayment = True
    '                    entity.AllowIPNPaymentSpecified = True
    '                    entity.AllowOnlinePayment = True
    '                    entity.AllowOnlinePaymentSpecified = True

    '                    entity.AllowOnlineCreditCardPayment = True
    '                    entity.AllowOnlineCreditCardPaymentSpecified = True
    '                    entity.AllowOnlineACHPayment = True
    '                End If

    '                Dim invLine As New Line()
    '                'invLine.Id = rdr("Id")
    '                'invLine.LineNum = 1
    '                invLine.Description = rdr("InvoiceNotes")
    '                invLine.Amount = rdr("Amount")
    '                invLine.AmountSpecified = True
    '                invLine.DetailType = LineDetailTypeEnum.SalesItemLineDetail
    '                invLine.DetailTypeSpecified = True

    '                invLine.AnyIntuitObject = New SalesItemLineDetail With {
    '                    .ItemElementName = ItemChoiceType.UnitPrice,
    '                    .AnyIntuitObject = rdr("Amount"), .Qty = 1D, .ItemRef = New ReferenceType() With {.name = item.Name, .Value = item.Id}}

    '                entity.Line = New Line() {invLine}

    '                If qbInvoiceId = 0 Then
    '                    ' New
    '                    resultInvoice = service.Add(entity)
    '                    ' Leer Guardar qbInvoiceId en Customer
    '                    qbInvoiceId = resultInvoice.ID
    '                    LocalAPI.ExecuteNonQuery("UPDATE [Invoices] SET qbInvoiceId=" & qbInvoiceId & " WHERE Id=" & rdr("Id"))

    '                    'service.SendEmail(resultInvoice)
    '                    ' Pendiente de subir versiones
    '                    LocalAPI.ActualizarEmittedInvoice(rdr("Id"), 0)

    '                Else
    '                    ' Update
    '                    ' Genera error. Jorgito!!!
    '                    'resultInvoice = service.Update(entity)
    '                    'service.SendEmail(resultInvoice)
    '                End If

    '                LocalAPI.sys_log_Nuevo(userEmail, LocalAPI.sys_log_AccionENUM.PAS_IntuitQB, companyId, "Invoice: " & rdr("InvoiceNumber"))

    '                Return JsonConvert.SerializeObject(resultInvoice)

    '            End If
    '            rdr.Close()

    '        End If
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function

    'Public Shared Function CreateUpdateQBCashInvoice(paymentId As Integer, companyId As Integer, userEmail As String) As String
    '    Try
    '        ' Invoices payments to QB
    '        Dim invoiceId As Integer = LocalAPI.GetInvoicePaymentsProperty(paymentId, "InvoiceId")
    '        Dim JobId As Integer = LocalAPI.GetInvoiceProperty(invoiceId, "JobId")
    '        Dim qbJobId As Integer = LocalAPI.GetJobProperty(JobId, "qbJobId")
    '        If qbJobId = 0 Then
    '            ' 1.- Crear Job (subCustomer) en QB...................si no existe
    '            CreateUpdateQBJob(JobId, companyId, userEmail)
    '            qbJobId = LocalAPI.GetJobProperty(JobId, "qbJobId")
    '        End If

    '        Dim resultInvoice As Invoice
    '        Dim qbCompanyID As String = LocalAPI.GetqbCompanyID(companyId)
    '        If Len(qbCompanyID) > 0 Then
    '            Dim accessToken As String = LocalAPI.GetqbAccessToken(companyId)
    '            Dim accessTokenSecret As String = LocalAPI.GetqbAccessTokenSecret(companyId)

    '            ' Leer Reader con los datos del Customer...
    '            Dim cnn1 As SqlConnection = LocalAPI.GetConnection()
    '            Dim cmd As New SqlCommand("SELECT Invoices_payments.Id, Jobs.Code as JobCode, Clients.Email, ISNULL(Invoices_payments.qbpaymentId, 0) AS qbpaymentId, Invoices_payments.CollectedDate, isnull(Invoices_payments.CollectedNotes,'') as CollectedNotes, Invoices_payments.Amount, isnull(Invoices.InvoiceNotes,'') as InvoiceNotes " &
    '                                      "FROM Invoices_payments LEFT OUTER JOIN Invoices ON Invoices_payments.InvoiceId = Invoices.Id LEFT OUTER JOIN Jobs ON Invoices.JobId = Jobs.Id LEFT OUTER JOIN Clients ON Jobs.Client = Clients.Id " &
    '                                      "WHERE Invoices_payments.Id=" & paymentId, cnn1)
    '            Dim rdr As SqlDataReader
    '            rdr = cmd.ExecuteReader
    '            rdr.Read()
    '            If rdr.HasRows Then
    '                Dim qbpaymentId As Integer = rdr("qbpaymentId")
    '                Dim service As DataService = GetDataService(qbCompanyID, accessToken, accessTokenSecret)
    '                Dim entity As Invoice

    '                ' QueryService<Item> itemQueryService = new QueryService<Item>(context);
    '                ' Item item = itemQueryService.ExecuteIdsQuery("Select * From Item StartPosition 1 MaxResults 1").FirstOrDefault<Item>();
    '                'Dim queryItems As QueryService(Of Item) = GetQueryService(Of Item)(qbCompanyID, accessToken, accessTokenSecret)
    '                'Dim item As Item = queryItems.Where(Function(i) i.Id > 0).FirstOrDefault()
    '                Dim ServiceContext1 As ServiceContext = GetServiceContext(qbCompanyID, accessToken, accessTokenSecret)
    '                Dim queryItems As QueryService(Of Item) = New QueryService(Of Item)(ServiceContext1)
    '                Dim item As Item = queryItems.ExecuteIdsQuery("Select * From Item StartPosition 1 MaxResults 1").FirstOrDefault
    '                If qbpaymentId > 0 Then
    '                    Dim queryService As QueryService(Of Invoice) = GetQueryService(Of Invoice)(qbCompanyID, accessToken, accessTokenSecret)
    '                    entity = queryService.Where(Function(i) i.Id = qbpaymentId).FirstOrDefault()
    '                Else
    '                    ' Name
    '                    entity = New Invoice()
    '                    entity.DocNumber = rdr("JobCode") & "-" & Right("0000" + rdr("Id"), 4)
    '                End If
    '                entity.BillEmail = New EmailAddress()
    '                entity.BillEmail.Address = rdr("Email")
    '                entity.AutoDocNumberSpecified = True
    '                entity.DueDate = rdr("CollectedDate")
    '                entity.CustomerRef = New ReferenceType() With {.Value = qbJobId}

    '                Dim invLine As New Line()
    '                'invLine.Id = rdr("Id")
    '                'invLine.LineNum = 1
    '                invLine.Description = rdr("InvoiceNotes") & ". " & rdr("CollectedNotes")
    '                invLine.Amount = rdr("Amount")
    '                invLine.AmountSpecified = True
    '                invLine.DetailType = LineDetailTypeEnum.SalesItemLineDetail
    '                invLine.DetailTypeSpecified = True

    '                invLine.AnyIntuitObject = New SalesItemLineDetail With {
    '                    .ItemElementName = ItemChoiceType.UnitPrice,
    '                    .AnyIntuitObject = rdr("Amount"), .Qty = 1D, .ItemRef = New ReferenceType() With {.name = item.Name, .Value = item.Id}}

    '                entity.Line = New Line() {invLine}

    '                If qbpaymentId = 0 Then
    '                    ' New
    '                    resultInvoice = service.Add(entity)
    '                    ' Leer Guardar qbpaymentId en Customer
    '                    qbpaymentId = resultInvoice.Id
    '                    LocalAPI.ExecuteNonQuery("UPDATE [Invoices_payments] SET qbpaymentId=" & qbpaymentId & " WHERE Id=" & rdr("Id"))

    '                Else
    '                    ' Update
    '                    ' Genera error. Jorgito!!!
    '                    'resultInvoice = service.Update(entity)
    '                    'service.SendEmail(resultInvoice)
    '                End If

    '                LocalAPI.sys_log_Nuevo(userEmail, LocalAPI.sys_log_AccionENUM.PAS_IntuitQB, companyId, "Invoice: " & rdr("InvoiceNumber"))

    '                Return JsonConvert.SerializeObject(resultInvoice)

    '            End If
    '            rdr.Close()

    '        End If
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function


End Class
