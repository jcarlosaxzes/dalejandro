Imports Intuit.Ipp.Core
Imports Intuit.Ipp.Data
Imports Intuit.Ipp.DataService
Imports Intuit.Ipp.QueryFilter
Imports Intuit.Ipp.LinqExtender
Imports Intuit.Ipp.Core.Configuration
Imports System.Linq
Imports Intuit.Ipp.Security
Imports Newtonsoft.Json
Imports System.Data.SqlClient
Imports System.Data
Imports Intuit.Ipp.OAuth2PlatformClient
Imports Intuit.Ipp.ReportService

Public Class qbAPI
    Public Shared Function GetAppEnvironment(Optional companyId As Integer = 0) As String
        If companyId = 0 Then
            If Not IsNothing(HttpContext.Current) Then
                companyId = Val(HttpContext.Current.Session("companyId"))
            End If
        End If
        If companyId = 99 Then
            Return "sandbox"
        End If
        Return ConfigurationManager.AppSettings("appEnvironment")
    End Function

    Public Shared Function GetClientId(Optional companyId As Integer = 0) As String
        If companyId = 0 Then
            If Not IsNothing(HttpContext.Current) Then
                companyId = Val(HttpContext.Current.Session("companyId"))
            End If
        End If
        If companyId = 99 Then
            Return "ABwMje9uSyeIpk7Xpeuovbn9SqhDWRkZ6HG3tt6aiNpLutuyGV"
        End If
        Return ConfigurationManager.AppSettings("clientid")
    End Function

    Public Shared Function GetClientSecret(Optional companyId As Integer = 0) As String
        If companyId = 0 Then
            If Not IsNothing(HttpContext.Current) Then
                companyId = Val(HttpContext.Current.Session("companyId"))
            End If
        End If
        If companyId = 99 Then
            Return "jUCh3Wu32CB3l0oqGJ9L2Pqs2Hpd2EUgEPBwWXmc"
        End If
        Return ConfigurationManager.AppSettings("clientsecret")
    End Function

    Public Shared Function GetRedirectUrl(Optional companyId As Integer = 0) As String
        If companyId = 0 Then
            If Not IsNothing(HttpContext.Current) Then
                companyId = Val(HttpContext.Current.Session("companyId"))
            End If
        End If
        If companyId = 99 Then
            Return LocalAPI.GetHostAppSite() & "/adm/qb_refreshtoken.aspx"
        End If
        Return ConfigurationManager.AppSettings("redirectUrl")
    End Function

    Public Shared Function GetBaseURL(Optional companyId As Integer = 0) As String
        If companyId = 0 Then
            If Not IsNothing(HttpContext.Current) Then
                companyId = Val(HttpContext.Current.Session("companyId"))
            End If
        End If
        If companyId = 99 Then
            Return "https://sandbox-quickbooks.api.intuit.com/"
        End If
        Return ConfigurationManager.AppSettings("QB_Base_URL")
    End Function



    Public Shared Function GetServiceContext(companyId As String) As ServiceContext
        Try
            Dim accessToken = LocalAPI.GetqbAccessToken(companyId)
            Dim qbComapny = LocalAPI.GetqbCompanyID(companyId)
            Dim oauthValidator = New OAuth2RequestValidator(accessToken)

            'Create a ServiceContext with Auth tokens And realmId
            Dim serviceContext = New ServiceContext(qbComapny, IntuitServicesType.QBO, oauthValidator)
            serviceContext.IppConfiguration.MinorVersion.Qbo = "23"
            serviceContext.IppConfiguration.BaseUrl.Qbo = qbAPI.GetBaseURL()
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
            Throw ex
        End Try
        IsValidAccessToken = False
    End Function

    Public Shared Function IsValidRefreshToken(companyId As String) As Boolean
        Try
            Dim valid = LocalAPI.GetScalar(Of Integer)("SELECT  case when isnull(qbRefreshTokenExpire,dbo.CurrentTime()) > DATEADD (ss, 600, dbo.CurrentTime())  then 1 else 0 end FROM Company where companyId=" & companyId)
            IsValidRefreshToken = (valid > 0)
            Exit Function
        Catch ex As Exception
            Throw ex
        End Try
        IsValidRefreshToken = False
    End Function

    Public Shared Function IsValidAccessOrRefreshToken(companyId As String) As Boolean
        If qbAPI.IsValidAccessToken(companyId) Then
            Return True
        ElseIf qbAPI.IsValidRefreshToken(companyId) Then
            Threading.Tasks.Task.Run(Function() qbAPI.UpdateAccessTokenAsync(companyId))
            Return True
        End If

        Return False
    End Function

    Public Shared Async Function UpdateAccessTokenAsync(companyId As String) As Threading.Tasks.Task(Of Boolean)
        Try
            Dim clientid = qbAPI.GetClientId()
            Dim clientsecret = qbAPI.GetClientSecret()
            Dim redirectUrl = qbAPI.GetRedirectUrl()
            Dim environment = qbAPI.GetAppEnvironment()
            Dim auth2Client As OAuth2Client = New OAuth2Client(clientid, clientsecret, redirectUrl, environment)

            Dim tokenResp = Await auth2Client.RefreshTokenAsync(LocalAPI.GetqbAccessTokenSecret(companyId))
            If tokenResp.IsError Or IsNothing(tokenResp.AccessToken) Then 'If RefreshTokenAsync fail the RefreshToken is revke or pas 100 day 
                LocalAPI.SetqbRefreshToken(companyId, "", -1000)
            Else
                LocalAPI.SetqbAccessToken(companyId, tokenResp.AccessToken, tokenResp.AccessTokenExpiresIn)
                LocalAPI.SetqbRefreshToken(companyId, tokenResp.RefreshToken, tokenResp.RefreshTokenExpiresIn)
            End If

            Return True
        Catch ex As Exception
            Throw ex
        End Try
        Return False
    End Function

    Public Shared Async Function RevokeDisconnectTokenAsync(companyId As String) As Threading.Tasks.Task(Of Boolean)
        Try
            Dim clientid = qbAPI.GetClientId()
            Dim clientsecret = qbAPI.GetClientSecret()
            Dim redirectUrl = qbAPI.GetRedirectUrl()
            Dim environment = qbAPI.GetAppEnvironment()
            Dim auth2Client As OAuth2Client = New OAuth2Client(clientid, clientsecret, redirectUrl, environment)
            Dim qbCurrentToken As String = LocalAPI.GetCompanyProperty(companyId, "qbAccessToken")
            Dim tokenResp = Await auth2Client.RevokeTokenAsync(qbCurrentToken)

            LocalAPI.SetqbAccessToken(companyId, "", -1000)
            LocalAPI.SetqbRefreshToken(companyId, "", -1000)

            Return True
        Catch ex As Exception
            LocalAPI.SetqbAccessToken(companyId, "", -1000)
            LocalAPI.SetqbRefreshToken(companyId, "", -1000)
            Throw ex
        End Try

    End Function

    Public Shared Sub LoadQBCustomers(comapyId As String)


        Dim qbCompanyId = LocalAPI.GetqbCompanyID(comapyId)
        Try
            Dim serviceContext = qbAPI.GetServiceContext(comapyId)
            Dim customerQueryService As QueryService(Of Customer) = New QueryService(Of Customer)(serviceContext)

            LocalAPI.ExecuteNonQuery(" delete [dbo].[Clients_SyncQB] where companyId = " & comapyId)

            Dim Rows = customerQueryService.ExecuteIdsQuery("SELECT COUNT(*) FROM Customer")
            Dim countRows As Integer = Rows.Count
            Dim startPos As Integer = 1
            Dim MaxResult As Integer = 500

            While countRows >= startPos

                Dim dt As New DataTable()
                dt.Columns.Add(New DataColumn("companyId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("QBId", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("QBCompany", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("DisplayName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("Email", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("Title", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("GivenName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("MiddleName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("FamilyName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("PrintOnCheckName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("CompanyName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("City", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("CountrySubDivisionCode", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("PostalCode", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("Addr_Line1", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("Addr_Line2", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("Addr_Line3", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("Mobile", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("PrimaryPhone", Type.GetType("System.String")))

                Dim PrimaryKeyColumns As DataColumn() = New DataColumn(0) {}
                PrimaryKeyColumns(0) = dt.Columns("DisplayName")
                dt.PrimaryKey = PrimaryKeyColumns

                Dim Customers = customerQueryService.ExecuteIdsQuery($"Select * From Customer STARTPOSITION {startPos} MAXRESULTS {MaxResult}")


                For Each customerObj As Customer In Customers

                    Dim row As DataRow = dt.NewRow()
                    row("companyId") = comapyId
                    row("QBId") = customerObj.Id
                    row("QBCompany") = qbCompanyId
                    row("DisplayName") = customerObj.DisplayName
                    row("Email") = customerObj.PrimaryEmailAddr?.Address
                    row("Title") = customerObj.Title
                    row("GivenName") = customerObj.GivenName
                    row("MiddleName") = customerObj.MiddleName
                    row("FamilyName") = customerObj.FamilyName
                    row("PrintOnCheckName") = customerObj.PrintOnCheckName
                    row("CompanyName") = customerObj.CompanyName
                    row("City") = customerObj.BillAddr?.City
                    row("CountrySubDivisionCode") = customerObj.BillAddr?.CountrySubDivisionCode
                    row("PostalCode") = customerObj.BillAddr?.PostalCode
                    row("Addr_Line1") = customerObj.BillAddr?.Line1
                    row("Addr_Line2") = customerObj.BillAddr?.Line2
                    row("Addr_Line3") = customerObj.BillAddr?.Line3
                    row("Mobile") = customerObj.Mobile?.FreeFormNumber
                    row("PrimaryPhone") = customerObj.PrimaryPhone?.FreeFormNumber

                    dt.Rows.Add(row)

                Next


                'insert into SQL

                Dim objbulk As SqlBulkCopy = New SqlBulkCopy(LocalAPI.GetConnection())
                objbulk.ColumnMappings.Add("companyId", "companyId")
                objbulk.ColumnMappings.Add("QBId", "QBId")
                objbulk.ColumnMappings.Add("QBCompany", "QBCompany")
                objbulk.ColumnMappings.Add("DisplayName", "DisplayName")
                objbulk.ColumnMappings.Add("Email", "Email")
                objbulk.ColumnMappings.Add("Title", "Title")
                objbulk.ColumnMappings.Add("GivenName", "GivenName")
                objbulk.ColumnMappings.Add("MiddleName", "MiddleName")
                objbulk.ColumnMappings.Add("FamilyName", "FamilyName")
                objbulk.ColumnMappings.Add("PrintOnCheckName", "PrintOnCheckName")
                objbulk.ColumnMappings.Add("CompanyName", "CompanyName")
                objbulk.ColumnMappings.Add("City", "City")
                objbulk.ColumnMappings.Add("CountrySubDivisionCode", "CountrySubDivisionCode")
                objbulk.ColumnMappings.Add("PostalCode", "PostalCode")
                objbulk.ColumnMappings.Add("Addr_Line1", "Addr_Line1")
                objbulk.ColumnMappings.Add("Addr_Line2", "Addr_Line2")
                objbulk.ColumnMappings.Add("Addr_Line3", "Addr_Line3")
                objbulk.ColumnMappings.Add("Mobile", "Mobile")
                objbulk.ColumnMappings.Add("PrimaryPhone", "PrimaryPhone")

                objbulk.DestinationTableName = "Clients_SyncQB"
                objbulk.WriteToServer(dt)

                startPos += MaxResult

            End While


        Catch ex As Exception
            Throw ex
        End Try


    End Sub

    Public Shared Sub LoadQBEmployees(comapyId As String)



        Dim qbCompanyId = LocalAPI.GetqbCompanyID(comapyId)
        Try
            Dim serviceContext = qbAPI.GetServiceContext(comapyId)
            Dim employeeQueryService As QueryService(Of Intuit.Ipp.Data.Employee) = New QueryService(Of Intuit.Ipp.Data.Employee)(serviceContext)
            Dim Rows = employeeQueryService.ExecuteIdsQuery("SELECT COUNT(*) FROM Employee")
            Dim countRows As Integer = Rows.Count
            Dim startPos As Integer = 1
            Dim MaxResult As Integer = 500

            LocalAPI.ExecuteNonQuery("delete [dbo].[Employees_SyncQB] where companyId = " & comapyId)

            While countRows >= startPos
                Dim Employees = employeeQueryService.ExecuteIdsQuery($"Select * From Employee STARTPOSITION {startPos} MAXRESULTS {MaxResult}")


                Dim dt As New DataTable()
                dt.Columns.Add(New DataColumn("companyId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("QBId", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("DisplayName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("MiddleName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("FamilyName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("PrimaryEmailAddr", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("GivenName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("PrintOnCheckName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("Mobile", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("PrimaryPhone", Type.GetType("System.String")))

                dt.Columns.Add(New DataColumn("Address", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("Address2", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("City", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("Estate", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("ZipCode", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("starting_Date", Type.GetType("System.DateTime")))
                dt.Columns.Add(New DataColumn("HourRate", Type.GetType("System.Double")))
                dt.Columns.Add(New DataColumn("SS", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("DOB", Type.GetType("System.DateTime")))
                dt.Columns.Add(New DataColumn("Gender", Type.GetType("System.String")))



                Dim PrimaryKeyColumns As DataColumn() = New DataColumn(0) {}
                PrimaryKeyColumns(0) = dt.Columns("DisplayName")
                dt.PrimaryKey = PrimaryKeyColumns

                For Each Obj As Intuit.Ipp.Data.Employee In Employees

                    'Obj.PrimaryAddr.CountrySubDivisionCode
                    'PostalCode'City'Line1    'WebAddr'Title'SSN'PrimaryPhone'PrimaryEmailAddr'PrimaryAddr'OtherAddr'Mobile'HiredDate 'Gender'Fax


                    Dim row As DataRow = dt.NewRow()
                    row("companyId") = comapyId
                    row("QBId") = Obj.Id
                    row("DisplayName") = Obj.DisplayName
                    row("MiddleName") = Obj.MiddleName
                    row("FamilyName") = Obj.FamilyName
                    row("PrintOnCheckName") = Obj.PrintOnCheckName
                    row("GivenName") = Obj.GivenName
                    row("PrimaryEmailAddr") = Obj.PrimaryEmailAddr?.Address
                    row("Mobile") = Obj.Mobile?.FreeFormNumber
                    row("PrimaryPhone") = Obj.PrimaryPhone?.FreeFormNumber


                    row("Address") = Obj.PrimaryAddr?.Line1
                    row("Address2") = Obj.PrimaryAddr?.Line2
                    row("City") = Obj.PrimaryAddr?.City
                    row("Estate") = Obj.PrimaryAddr?.CountrySubDivisionCode
                    row("ZipCode") = Obj.PrimaryAddr?.PostalCode
                    row("starting_Date") = IIf(IsNothing(Obj.HiredDate) Or Obj.HiredDate.Year < 1900, DBNull.Value, Obj.HiredDate)
                    row("HourRate") = Obj.BillRate
                    row("SS") = Obj.SSN
                    row("DOB") = IIf(IsNothing(Obj.BirthDate) Or Obj.BirthDate.Year < 1900, DBNull.Value, Obj.BirthDate)
                    row("Gender") = Obj.Gender

                    dt.Rows.Add(row)

                Next


                'insert into SQL

                Dim objbulk As SqlBulkCopy = New SqlBulkCopy(LocalAPI.GetConnection())
                objbulk.ColumnMappings.Add("companyId", "companyId")
                objbulk.ColumnMappings.Add("QBId", "QBId")
                objbulk.ColumnMappings.Add("DisplayName", "DisplayName")
                objbulk.ColumnMappings.Add("MiddleName", "MiddleName")
                objbulk.ColumnMappings.Add("FamilyName", "FamilyName")
                objbulk.ColumnMappings.Add("PrintOnCheckName", "PrintOnCheckName")
                objbulk.ColumnMappings.Add("GivenName", "GivenName")
                objbulk.ColumnMappings.Add("PrimaryEmailAddr", "PrimaryEmailAddr")
                objbulk.ColumnMappings.Add("Mobile", "Mobile")
                objbulk.ColumnMappings.Add("PrimaryPhone", "PrimaryPhone")

                objbulk.ColumnMappings.Add("Address", "Address")
                objbulk.ColumnMappings.Add("Address2", "Address2")
                objbulk.ColumnMappings.Add("City", "City")
                objbulk.ColumnMappings.Add("Estate", "Estate")
                objbulk.ColumnMappings.Add("ZipCode", "ZipCode")
                objbulk.ColumnMappings.Add("starting_Date", "starting_Date")
                objbulk.ColumnMappings.Add("HourRate", "HourRate")
                objbulk.ColumnMappings.Add("SS", "SS")
                objbulk.ColumnMappings.Add("DOB", "DOB")
                objbulk.ColumnMappings.Add("Gender", "Gender")

                objbulk.DestinationTableName = "Employees_SyncQB"
                objbulk.WriteToServer(dt)

                startPos += MaxResult

            End While

        Catch ex As Exception
            Throw ex
        End Try


    End Sub

    Public Shared Sub LoadQBVendors(comapyId As String)



        Dim qbCompanyId = LocalAPI.GetqbCompanyID(comapyId)
        Try
            Dim serviceContext = qbAPI.GetServiceContext(comapyId)
            Dim VendorsQueryService As QueryService(Of Intuit.Ipp.Data.Vendor) = New QueryService(Of Intuit.Ipp.Data.Vendor)(serviceContext)

            Dim Rows = VendorsQueryService.ExecuteIdsQuery("SELECT COUNT(*) FROM vendor")
            Dim countRows As Integer = Rows.Count
            Dim startPos As Integer = 1
            Dim MaxResult As Integer = 500


            LocalAPI.ExecuteNonQuery("delete Vendors_SyncQB where companyId = " & comapyId)

            While countRows >= startPos

                Dim dt As New DataTable()
                dt.Columns.Add(New DataColumn("companyId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("QBId", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("DisplayName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("MiddleName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("FamilyName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("PrimaryEmailAddr", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("GivenName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("CompanyName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("Mobile", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("PrimaryPhone", Type.GetType("System.String")))

                Dim PrimaryKeyColumns As DataColumn() = New DataColumn(0) {}
                PrimaryKeyColumns(0) = dt.Columns("DisplayName")
                dt.PrimaryKey = PrimaryKeyColumns

                Dim Vendors = VendorsQueryService.ExecuteIdsQuery($"Select * From vendor STARTPOSITION {startPos} MAXRESULTS {MaxResult}")

                For Each Obj As Intuit.Ipp.Data.Vendor In Vendors

                    Dim row As DataRow = dt.NewRow()
                    row("companyId") = comapyId
                    row("QBId") = Obj.Id
                    row("DisplayName") = Obj.DisplayName
                    row("MiddleName") = Obj.MiddleName
                    row("FamilyName") = Obj.FamilyName
                    row("CompanyName") = Obj.CompanyName
                    row("GivenName") = Obj.GivenName
                    row("PrimaryEmailAddr") = Obj.PrimaryEmailAddr?.Address
                    row("Mobile") = Obj.Mobile?.FreeFormNumber
                    row("PrimaryPhone") = Obj.PrimaryPhone?.FreeFormNumber
                    dt.Rows.Add(row)

                Next


                'insert into SQL

                Dim objbulk As SqlBulkCopy = New SqlBulkCopy(LocalAPI.GetConnection())
                objbulk.ColumnMappings.Add("companyId", "companyId")
                objbulk.ColumnMappings.Add("QBId", "QBId")
                objbulk.ColumnMappings.Add("DisplayName", "DisplayName")
                objbulk.ColumnMappings.Add("MiddleName", "MiddleName")
                objbulk.ColumnMappings.Add("FamilyName", "FamilyName")
                objbulk.ColumnMappings.Add("GivenName", "GivenName")
                objbulk.ColumnMappings.Add("CompanyName", "CompanyName")
                objbulk.ColumnMappings.Add("PrimaryEmailAddr", "PrimaryEmailAddr")
                objbulk.ColumnMappings.Add("Mobile", "Mobile")
                objbulk.ColumnMappings.Add("PrimaryPhone", "PrimaryPhone")

                objbulk.DestinationTableName = "Vendors_SyncQB"
                objbulk.WriteToServer(dt)
                startPos += MaxResult

            End While

        Catch ex As Exception
            Throw ex
        End Try


    End Sub

    Public Shared Function GetPayment(companyId As String, paymentId As String) As Intuit.Ipp.Data.Payment

        Dim qbCompanyId = LocalAPI.GetqbCompanyID(companyId)

        Try
            Dim serviceContext = qbAPI.GetServiceContext(companyId)
            Dim ObjQueryService As QueryService(Of Intuit.Ipp.Data.Payment) = New QueryService(Of Intuit.Ipp.Data.Payment)(serviceContext)
            Dim objects = ObjQueryService.ExecuteIdsQuery($"select * from Payment Where Id= '{paymentId}'")

            For Each Obj As Intuit.Ipp.Data.Payment In objects
                Return Obj
            Next
            Return Nothing
        Catch ex As Exception
            Throw ex
        End Try


    End Function

    Public Shared Sub SyncInvoicesPayment(companyId As String)

        Dim qbCompanyId = LocalAPI.GetqbCompanyID(companyId)
        Dim qbInvoiceSyncDate As DateTime = LocalAPI.GetDateTimeEscalar("SELECT ISNULL(qbInvoiceSyncDate,dbo.CurrentTime()) as qbInvoiceSyncDate FROM [Company] WHERE [companyId] =" & companyId)

        Try
            Dim serviceContext = qbAPI.GetServiceContext(companyId)
            Dim ObjQueryService As QueryService(Of Intuit.Ipp.Data.Invoice) = New QueryService(Of Intuit.Ipp.Data.Invoice)(serviceContext)

            Dim Rows = ObjQueryService.ExecuteIdsQuery($"SELECT COUNT(*) from Invoice where MetaData.LastUpdatedTime >= '{qbInvoiceSyncDate.ToString("yyyy-MM-dd")}'")
            Dim countRows As Integer = Rows.Count
            Dim startPos As Integer = 1
            Dim MaxResult As Integer = 500

            While countRows >= startPos
                Dim objects = ObjQueryService.ExecuteIdsQuery($"select * from Invoice where MetaData.LastUpdatedTime >= '{qbInvoiceSyncDate.ToString("yyyy-MM-dd")}'  STARTPOSITION {startPos} MAXRESULTS {MaxResult}")


                For Each Obj As Intuit.Ipp.Data.Invoice In objects
                    'Check if this invoice was send from PASconcept
                    Dim invoiceId = LocalAPI.GetNumericEscalar($"Select isnull(max(Invoices.Id), 0) as Id from Invoices inner join Jobs on Invoices.JobId = Jobs.Id where Jobs.companyId = {companyId} and ISNULL(Invoices.qbInvoiceId, 0) = {Obj.Id}")
                    If invoiceId > 0 Then
                        ' loop over all linked objet to this QB Invoices
                        For Each link In Obj.LinkedTxn
                            If link.TxnType = "Payment" Then
                                Dim existPayment = LocalAPI.GetNumericEscalar($"select count(ivp.id) as total from Invoices_payments ivp inner join Invoices iv on (iv.Id= ivp.InvoiceId) inner join Jobs on iv.JobId = Jobs.Id where Jobs.companyId = {companyId} and ivp.qbpaymentId = {link.TxnId}")
                                ' If not Exist Payment Insert payment from QB
                                If existPayment = 0 Then
                                    Dim qbPayment = GetPayment(companyId, link.TxnId)
                                    If Not IsNothing(qbPayment) Then
                                        Dim notes = "QuickBooks Payment -> " & IIf(IsNothing(qbPayment.DocNumber), "", "Doc Number:" & qbPayment.DocNumber) & " "
                                        notes &= IIf(IsNothing(qbPayment.HeaderFull), "", " Header:" & qbPayment.HeaderFull) & " "
                                        notes &= IIf(IsNothing(qbPayment.PaymentType), "", " Payment Type:" & qbPayment.PaymentType.ToString("F"))
                                        notes &= IIf(IsNothing(qbPayment.PaymentRefNum), "", " Payment Ref Num:" & qbPayment.PaymentRefNum) & " "
                                        notes &= IIf(IsNothing(qbPayment.PrivateNote), "", " Notes:" & qbPayment.PrivateNote) & " "

                                        LocalAPI.INVOICE_PAYMENTS_QB_INSERT(invoiceId, qbPayment.TxnDate, 13, qbPayment.TotalAmt, notes, qbPayment.Id)
                                        LocalAPI.ExecuteNonQuery("update Company set qbInvoiceSyncDate = DATEADD(Day, -1, dbo.CurrentTime())  WHERE [companyId] =" & companyId)
                                    End If
                                End If
                            End If
                        Next
                    End If
                Next
                startPos += MaxResult
            End While

        Catch ex As Exception
            Throw ex
        End Try


    End Sub


    Public Shared Function CreatePayment(companyId As String, TotalAmt As Double, qbCustomerId As Integer, qbInvoiceId As String, paymentType As PaymentTypeEnum, TxnDate As DateTime, note As String) As String

        Dim qbCompanyId = LocalAPI.GetqbCompanyID(companyId)

        Try
            Dim serviceContext = qbAPI.GetServiceContext(companyId)

            Dim ObjPayment As Payment = New Payment()
            ObjPayment.PaymentTypeSpecified = True
            ObjPayment.PaymentType = paymentType

            ObjPayment.TotalAmtSpecified = True
            ObjPayment.TotalAmt = TotalAmt
            ObjPayment.CustomerRef = New ReferenceType()
            ObjPayment.CustomerRef.Value = qbCustomerId
            ObjPayment.TxnDateSpecified = True
            ObjPayment.TxnDate = TxnDate
            ObjPayment.CurrencyRef = New ReferenceType With {.name = "US Dollar", .Value = "USD"}
            Dim link As LinkedTxn = New LinkedTxn With {
                .TxnId = qbInvoiceId, .TxnType = "Invoice"
                }

            ObjPayment.LinkedTxn = New LinkedTxn() {link}

            Dim li = New Line With {.Amount = TotalAmt,
                              .AmountSpecified = True,
                              .DetailType = LineDetailTypeEnum.PaymentLineDetail,
                              .DetailTypeSpecified = True
            }
            Dim linkLIne As LinkedTxn = New LinkedTxn With {.TxnId = qbInvoiceId, .TxnType = "Invoice"}
            li.LinkedTxn = New LinkedTxn() {linkLIne}
            ObjPayment.Line = New Line() {li}

            ObjPayment.PrivateNote = note

            Dim dataSrv = New DataService(serviceContext)
            Dim itemAdded = dataSrv.Add(Of Payment)(ObjPayment)

            Return itemAdded.Id


        Catch ex As Exception
            Throw ex
        End Try

        Return "0"

    End Function

    Public Shared Sub LoadQBExpenses(companyId As String, dateFrom As DateTime, dateTo As DateTime, ignoreCategory As String)
        Dim dt As New DataTable()

        dt.Columns.Add(New DataColumn("companyId", Type.GetType("System.Int32")))
        dt.Columns.Add(New DataColumn("QBId", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("ExpDate", Type.GetType("System.DateTime")))
        dt.Columns.Add(New DataColumn("Type", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("Reference", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("Amount", Type.GetType("System.Double")))
        dt.Columns.Add(New DataColumn("Category", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("VendorId", Type.GetType("System.Int32")))
        dt.Columns.Add(New DataColumn("Memo", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("OriginalReference", Type.GetType("System.String")))

        Dim PrimaryKeyColumns As DataColumn() = New DataColumn(0) {}
        PrimaryKeyColumns(0) = dt.Columns("DisplayName")
        dt.PrimaryKey = PrimaryKeyColumns

        Dim qbCompanyId = LocalAPI.GetqbCompanyID(companyId)
        Try
            Dim serviceContext = qbAPI.GetServiceContext(companyId)
            Dim employeeQueryService As QueryService(Of Intuit.Ipp.Data.Purchase) = New QueryService(Of Intuit.Ipp.Data.Purchase)(serviceContext)

            Dim objects = employeeQueryService.ExecuteIdsQuery($"Select * From Purchase where TxnDate >= '{dateFrom.ToString("yyyy-MM-dd")}' and TxnDate <= '{dateTo.ToString("yyyy-MM-dd")}' MAXRESULTS 500")

            LocalAPI.ExecuteNonQuery($"delete Company_Expenses where companyId = {companyId} and ExpDate >= '{dateFrom.ToString("yyyy-MM-dd")}' and ExpDate <= '{dateTo.ToString("yyyy-MM-dd")}' and isnull([QBId], 0 ) >  0")

            For Each Obj As Intuit.Ipp.Data.Purchase In objects

                Dim row As DataRow = dt.NewRow()
                row("companyId") = companyId
                row("QBId") = Obj.Id
                row("ExpDate") = Obj.TxnDate
                If IsNothing(Obj.EntityRef) Then
                    row("Type") = ""
                    row("OriginalReference") = ""
                Else
                    row("Type") = Obj.EntityRef.type
                    row("OriginalReference") = Obj.EntityRef.name
                    row("Reference") = Obj.EntityRef.Value
                    If Obj.EntityRef.type = "Vendor" Then
                        Dim qbVendorId = Val(Obj.EntityRef.Value)
                        row("VendorId") = LocalAPI.GetNumericEscalar($"select id from Vendors where CompanyId = {companyId} and qbVendorsId = {qbVendorId}")
                    End If
                End If




                Dim category As String = ""
                Dim ignore As Boolean = False
                For Each line In Obj.Line
                    If line.DetailType = LineDetailTypeEnum.AccountBasedExpenseLineDetail Then
                        Dim detail As AccountBasedExpenseLineDetail = CType(line.AnyIntuitObject, AccountBasedExpenseLineDetail)
                        If Not String.IsNullOrEmpty(detail.AccountRef.name) AndAlso detail.AccountRef.name = ignoreCategory Then
                            ignore = True
                        End If

                        category &= detail.AccountRef.name
                    End If

                    If line.DetailType = LineDetailTypeEnum.ItemBasedExpenseLineDetail Then
                        Dim detail As ItemBasedExpenseLineDetail = CType(line.AnyIntuitObject, ItemBasedExpenseLineDetail)
                        category &= detail.ItemRef.name
                    End If

                Next

                row("Category") = category

                row("Amount") = Obj.TotalAmt
                row("Memo") = "Payment Type: " & Obj.PaymentType.ToString("F") & " " & Obj.Memo

                row("Reference") = Obj.PrivateNote
                If Not ignore Then
                    dt.Rows.Add(row)
                End If

            Next


            'insert into SQL

            Dim objbulk As SqlBulkCopy = New SqlBulkCopy(LocalAPI.GetConnection())
            objbulk.ColumnMappings.Add("companyId", "companyId")
            objbulk.ColumnMappings.Add("QBId", "QBId")
            objbulk.ColumnMappings.Add("ExpDate", "ExpDate")
            objbulk.ColumnMappings.Add("Type", "Type")
            objbulk.ColumnMappings.Add("OriginalReference", "OriginalReference")
            objbulk.ColumnMappings.Add("Reference", "Reference")
            objbulk.ColumnMappings.Add("VendorId", "VendorId")
            objbulk.ColumnMappings.Add("Amount", "Amount")
            objbulk.ColumnMappings.Add("Memo", "Memo")
            objbulk.ColumnMappings.Add("Category", "Category")

            objbulk.DestinationTableName = "Company_Expenses"
            objbulk.WriteToServer(dt)


        Catch ex As Exception
            Throw ex
        End Try


    End Sub



    Public Shared Sub LoadQBTransactionList(comapyId As String, dateFrom As DateTime, dateTo As DateTime)
        Dim dt As New DataTable()

        dt.Columns.Add(New DataColumn("companyId", Type.GetType("System.Int32")))
        dt.Columns.Add(New DataColumn("QBId", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("ExpDate", Type.GetType("System.DateTime")))
        dt.Columns.Add(New DataColumn("Type", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("Reference", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("Amount", Type.GetType("System.Double")))
        dt.Columns.Add(New DataColumn("Category", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("VendorId", Type.GetType("System.Int32")))
        dt.Columns.Add(New DataColumn("Memo", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("OriginalReference", Type.GetType("System.String")))

        Dim PrimaryKeyColumns As DataColumn() = New DataColumn(0) {}
        PrimaryKeyColumns(0) = dt.Columns("DisplayName")
        dt.PrimaryKey = PrimaryKeyColumns

        Dim qbCompanyId = LocalAPI.GetqbCompanyID(comapyId)
        Try
            Dim serviceContext = qbAPI.GetServiceContext(comapyId)
            Dim employeeQueryService As QueryService(Of Intuit.Ipp.Data.TransactionList) = New QueryService(Of Intuit.Ipp.Data.TransactionList)(serviceContext)
            Dim Vendors = employeeQueryService.ExecuteIdsQuery($"Select * From TransactionList")

            'LocalAPI.ExecuteNonQuery($"delete Company_Expenses where companyId = {comapyId} and ExpDate >= '{dateFrom.ToString("yyyy-MM-dd")}' and ExpDate <= '{dateTo.ToString("yyyy-MM-dd")}'")



            For Each Obj As Intuit.Ipp.Data.TransactionList In Vendors

                Dim row As DataRow = dt.NewRow()
                row("companyId") = comapyId
                row("QBId") = Obj.VendorField
                'row("ExpDate") = Obj.TxnDate
                'If IsNothing(Obj.EntityRef) Then
                '    row("Type") = ""
                '    row("OriginalReference") = ""
                'Else
                '    row("Type") = Obj.EntityRef.type
                '    row("OriginalReference") = Obj.EntityRef.name
                '    row("Reference") = Obj.EntityRef.Value
                '    If Obj.EntityRef.type = "Vendor" Then
                '        row("VendorId") = Val(Obj.EntityRef.Value)
                '    End If
                'End If

                'row("Amount") = Obj.TotalAmt
                'row("Memo") = Obj.PrivateNote
                'row("Category") = Obj.PaymentType
                'dt.Rows.Add(row)

            Next


            'insert into SQL

            Dim objbulk As SqlBulkCopy = New SqlBulkCopy(LocalAPI.GetConnection())
            objbulk.ColumnMappings.Add("companyId", "companyId")
            objbulk.ColumnMappings.Add("QBId", "QBId")
            objbulk.ColumnMappings.Add("ExpDate", "ExpDate")
            objbulk.ColumnMappings.Add("Type", "Type")
            objbulk.ColumnMappings.Add("OriginalReference", "OriginalReference")
            objbulk.ColumnMappings.Add("Reference", "Reference")
            objbulk.ColumnMappings.Add("VendorId", "VendorId")
            objbulk.ColumnMappings.Add("Amount", "Amount")
            objbulk.ColumnMappings.Add("Memo", "Memo")
            objbulk.ColumnMappings.Add("Category", "Category")

            objbulk.DestinationTableName = "Company_Expenses"
            objbulk.WriteToServer(dt)


        Catch ex As Exception
            Throw ex
        End Try


    End Sub

    Public Shared Sub LoadQBReport(comapyId As String, dateFrom As DateTime, dateTo As DateTime)
        Dim dt As New DataTable()

        dt.Columns.Add(New DataColumn("companyId", Type.GetType("System.Int32")))
        dt.Columns.Add(New DataColumn("QBId", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("ExpDate", Type.GetType("System.DateTime")))
        dt.Columns.Add(New DataColumn("Type", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("Reference", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("Amount", Type.GetType("System.Double")))
        dt.Columns.Add(New DataColumn("Category", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("VendorId", Type.GetType("System.Int32")))
        dt.Columns.Add(New DataColumn("Memo", Type.GetType("System.String")))
        dt.Columns.Add(New DataColumn("OriginalReference", Type.GetType("System.String")))

        Dim PrimaryKeyColumns As DataColumn() = New DataColumn(0) {}
        PrimaryKeyColumns(0) = dt.Columns("DisplayName")
        dt.PrimaryKey = PrimaryKeyColumns

        Dim qbCompanyId = LocalAPI.GetqbCompanyID(comapyId)
        Try
            Dim serviceContext = qbAPI.GetServiceContext(comapyId)
            Dim service As ReportService = New ReportService(serviceContext)
            service.start_date = "2020-01-01"
            service.end_date = "2020-12-31"


            Dim report As Report = service.ExecuteReport("ProfitAndLossDetail")

            Dim json = report.ToString()

            For index = 0 To report.Rows.Length - 1
                Dim row = report.Rows(index)
                Dim value = row.AnyIntuitObjects(0)
            Next





        Catch ex As Exception
            Throw ex
        End Try


    End Sub


    Public Shared Function GetCustomer(comapyId As String, CustomerId As String) As Customer
        Try

            Dim serviceContext = qbAPI.GetServiceContext(comapyId)
            Dim customerQueryService As QueryService(Of Customer) = New QueryService(Of Customer)(serviceContext)
            Dim Result = customerQueryService.ExecuteIdsQuery("SELECT * FROM Customer WHERE Id = '" & CustomerId & "'").First()

            Return Result
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function LinkCustomer(companyId As Integer, ClientId As Integer, QBId As Integer) As Boolean
        If ClientId > 0 And QBId > 0 Then
            If (LocalAPI.IsQuickBookDesckModule(companyId)) Then
                Dim QBCustomer = LocalAPI.GetqbCustomer(QBId)
                LocalAPI.ActualizarClient(ClientId, "qbListID", QBCustomer("ListID"))
            End If
            Return LocalAPI.ActualizarClient(ClientId, "qbCustomerId", QBId)
        End If
    End Function
    Public Shared Function CopyCustomer(companyId As Integer, QBId As Integer) As Boolean
        If QBId > 0 Then
            Dim QBCustomer = LocalAPI.GetqbCustomer(QBId)
            Dim ClientId = LocalAPI.Client_INSERT(QBCustomer("DisplayName"), QBCustomer("Email"), QBCustomer("Title"), companyId, QBCustomer("CompanyName"), QBCustomer("Addr_Line1"), QBCustomer("Addr_Line2"), QBCustomer("City"), QBCustomer("CountrySubDivisionCode"), QBCustomer("PostalCode"), QBCustomer("PrimaryPhone"), QBCustomer("Mobile"), "", "")
            If (LocalAPI.IsQuickBookDesckModule(companyId)) Then
                LocalAPI.ActualizarClient(ClientId, "qbListID", QBCustomer("ListID"))
            End If
            Return LocalAPI.ActualizarClient(ClientId, "qbCustomerId", QBId)
        End If
    End Function

    Public Shared Function CopyVendor(companyId As Integer, QBId As Integer) As Boolean
        If QBId > 0 Then
            Dim QBVendors = LocalAPI.GetqbVendors(QBId)
            Dim VendorId = LocalAPI.Vendor_INSERT(QBVendors("DisplayName"), companyId, QBVendors("CompanyName"), QBVendors("PrimaryEmailAddr"), sCellular:=QBVendors("Mobile"), sPhone:=QBVendors("PrimaryPhone"))
            LocalAPI.ExecuteNonQuery($"update Vendors set [qbVendorsId] = {QBId} where Id = " & VendorId)
            Return True
        End If
    End Function


    Public Shared Function GetQBCompany(comapyId As String) As CompanyInfo
        Try
            Dim serviceContext = qbAPI.GetServiceContext(comapyId)
            Dim CompanyQueryService As QueryService(Of CompanyInfo) = New QueryService(Of CompanyInfo)(serviceContext)
            Dim Result = CompanyQueryService.ExecuteIdsQuery("SELECT * FROM CompanyInfo").First()

            Return Result
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function GetOrCreateItem(comapyId As String, CustomerName As String, CustomerId As String) As Item
        Try
            ' PASconcept Profesional Services
            Dim serviceContext = qbAPI.GetServiceContext(comapyId)
            Dim customerQueryService As QueryService(Of Item) = New QueryService(Of Item)(serviceContext)
            Dim itemExist = customerQueryService.ExecuteIdsQuery("Select * From Item where Name = 'Professional Services'").FirstOrDefault()
            If Not IsNothing(itemExist) AndAlso itemExist.Name = "Professional Services" Then
                Return itemExist
            End If

            Dim item As Item = New Item()
            item.Name = "Professional Services"
            item.Description = ""
            item.Type = ItemTypeEnum.Service
            item.TypeSpecified = True
            item.Active = True
            item.ActiveSpecified = True
            item.Taxable = False
            item.TaxableSpecified = True
            item.TrackQtyOnHand = False
            item.TrackQtyOnHandSpecified = True
            item.IncomeAccountRef = New ReferenceType() With
            {
            .name = CustomerName,
            .Value = CustomerId
            }
            'item.ExpenseAccountRef = New ReferenceType() With
            '    {
            '    .name = CustomerName,
            '    .Value = CustomerId
            '    }

            Dim dataSrv = New DataService(serviceContext)
            Dim itemAdded = dataSrv.Add(Of Item)(item)

            Return itemAdded
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function CreateInvoice(comapyId As String, InvoiceObject As Dictionary(Of String, Object), ItemObj As Item, CustomerObj As Customer) As Intuit.Ipp.Data.Invoice
        Try
            ' PASconcept Profesional Services
            Dim serviceContext = qbAPI.GetServiceContext(comapyId)
            Dim lineList As List(Of Line) = New List(Of Line)()
            Dim LineObj = New Line()
            LineObj.Description = InvoiceObject("InvoiceNumber") & "  " & InvoiceObject("Notes")
            LineObj.Amount = Decimal.Parse(InvoiceObject("InvoicePaid").ToString())
            LineObj.AmountSpecified = True
            Dim itemDetail = New SalesItemLineDetail()
            If InvoiceObject("InvoiceType") = 1 Then
                itemDetail.Qty = Decimal.Parse(InvoiceObject("Time"))
                itemDetail.QtySpecified = True
                itemDetail.AnyIntuitObject = CType(Math.Round(Decimal.Parse(InvoiceObject("Rate")), 2), Decimal)
                itemDetail.ItemElementName = Intuit.Ipp.Data.ItemChoiceType.UnitPrice
            Else
                itemDetail.Qty = New Decimal(1.0)
                itemDetail.QtySpecified = True
            End If
            itemDetail.ItemRef = New ReferenceType() With
                    {
                        .Value = ItemObj.Id
                    }
            LineObj.AnyIntuitObject = itemDetail
            LineObj.DetailType = LineDetailTypeEnum.SalesItemLineDetail
            LineObj.DetailTypeSpecified = True
            lineList.Add(LineObj)
            Dim newInvoices = New Intuit.Ipp.Data.Invoice()
            newInvoices.CustomerRef = New ReferenceType() With
                    {
                        .name = CustomerObj.DisplayName,
                        .Value = CustomerObj.Id
                    }
            newInvoices.Line = lineList.ToArray()
            ''Step 5: Set other properties such as Total Amount, Due Date, Email status and Transaction Date
            newInvoices.DueDate = DateTime.UtcNow.Date.AddMonths(1)
            newInvoices.DueDateSpecified = True
            newInvoices.TotalAmt = Decimal.Parse(InvoiceObject("InvoicePaid").ToString())
            newInvoices.TotalAmtSpecified = True
            newInvoices.EmailStatus = EmailStatusEnum.NotSet
            newInvoices.EmailStatusSpecified = True
            newInvoices.Balance = Decimal.Parse(InvoiceObject("InvoicePaid").ToString())
            newInvoices.BalanceSpecified = True
            newInvoices.TxnDate = DateTime.UtcNow.Date
            newInvoices.TxnDateSpecified = True
            newInvoices.TxnTaxDetail = New TxnTaxDetail() With
                    {
                        .TotalTax = Convert.ToDecimal(10),
                        .TotalTaxSpecified = True
                    }
            Dim dataSrv = New DataService(serviceContext)
            Dim addedInvoice = dataSrv.Add(Of Intuit.Ipp.Data.Invoice)(newInvoices)
            Return addedInvoice
        Catch ex As Exception
            Throw ex
        End Try
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

    Public Shared Function SendInvoiceToQuickBooks(InvoiceId As Integer, qbCustomerId As Integer, employeeId As Integer, companyId As Integer) As Integer
        Try

            Dim CustomerObj = qbAPI.GetCustomer(companyId, qbCustomerId)
            Dim InvoiceObject = LocalAPI.GetInvoiceInfo(InvoiceId)
            Dim ItemObj = qbAPI.GetOrCreateItem(companyId, CustomerObj.DisplayName, CustomerObj.Id)
            Dim addedInvoice = qbAPI.CreateInvoice(companyId, InvoiceObject, ItemObj, CustomerObj)
            Dim qbInvoceId As Integer = addedInvoice.Id
            LocalAPI.SetInvoiceQBRef(InvoiceId, qbInvoceId, employeeId)

            Return qbInvoceId

        Catch ex As Exception
            Throw ex
        End Try
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
