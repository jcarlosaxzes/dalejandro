Imports System.Data.SqlClient
Imports System.Net.Http
Imports System.Threading.Tasks
Imports Newtonsoft.Json.Linq
Imports System.Data

Public Class EbillityApi
    Public Shared ConvertApi_BaseUrl As String = "https://api.ebillity.com/restservice/"

    Public Shared Async Function GetClientsRequestAsync(comapyId As String, page_ As Integer, limit_ As Integer, LastSyncDate As Int64) As Task(Of String)

        Dim AccessToken = LocalAPI.GetEabillityAccessToken(comapyId)
        Try
            Dim httpClient = New HttpClient()
            httpClient.SetBearerToken(AccessToken)
            httpClient.BaseAddress = New Uri(ConvertApi_BaseUrl)
            Dim httpRequestMessage As HttpRequestMessage = New HttpRequestMessage(HttpMethod.Get, $"thirdparty/clients?page={page_}&limit={limit_}&lastsyncdate={LastSyncDate}")
            Dim response = Await httpClient.SendAsync(httpRequestMessage)
            Dim ByteArray = Await response.Content.ReadAsByteArrayAsync()
            Dim json = Text.Encoding.Default.GetString(ByteArray)
            Return json
        Catch ex As Exception
            Throw ex
        End Try


    End Function

    Public Shared Async Function GetTimeEntriesRequestAsync(comapyId As String, page_ As Integer, limit_ As Integer) As Task(Of String)

        Dim AccessToken = LocalAPI.GetEabillityAccessToken(comapyId)
        Try
            Dim httpClient = New HttpClient()
            httpClient.SetBearerToken(AccessToken)
            httpClient.BaseAddress = New Uri(ConvertApi_BaseUrl)
            Dim httpRequestMessage As HttpRequestMessage = New HttpRequestMessage(HttpMethod.Get, $"thirdparty/timeentries?page={page_}&limit={limit_}")
            Dim response = Await httpClient.SendAsync(httpRequestMessage)
            Dim ByteArray = Await response.Content.ReadAsByteArrayAsync()
            Dim json = Text.Encoding.Default.GetString(ByteArray)
            Return json
        Catch ex As Exception
            Throw ex
        End Try


    End Function

    Public Shared Async Function GetRequestAsync(comapyId As String, query_url As String) As Task(Of String)

        Dim AccessToken = LocalAPI.GetEabillityAccessToken(comapyId)
        Try
            Dim httpClient = New HttpClient()
            httpClient.SetBearerToken(AccessToken)
            httpClient.BaseAddress = New Uri(ConvertApi_BaseUrl)
            Dim httpRequestMessage As HttpRequestMessage = New HttpRequestMessage(HttpMethod.Get, query_url)
            Dim response = Await httpClient.SendAsync(httpRequestMessage)
            Dim ByteArray = Await response.Content.ReadAsByteArrayAsync()
            Dim json = Text.Encoding.Default.GetString(ByteArray)
            Return json
        Catch ex As Exception
            Throw ex
        End Try


    End Function


    Public Shared Async Function GetClientsAsync(companyId As String) As Task(Of Boolean)

        Try
            Dim page_ = 1
            Dim limit = 100

            Dim successfull = True
            Dim LastSyncDateNew As Int64 = 0
            Dim LastSyncDate = LocalAPI.GetEbillityClientLastSyncDate(companyId)
            While successfull
                Dim json_s = Await GetClientsRequestAsync(companyId, page_, limit, LastSyncDate)
                Dim jsonObj As JObject = JObject.Parse(json_s)
                LastSyncDateNew = jsonObj.GetValue("ServerTime")
                Dim jsonClients = jsonObj("Clients")
                successfull = jsonClients.Count > 0

                Dim dt As New DataTable()
                dt.Columns.Add(New DataColumn("companyId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("ClientId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("ProjectId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("ClientName", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("IsActive", Type.GetType("System.Boolean")))

                Dim PrimaryKeyColumns As DataColumn() = New DataColumn(0) {}
                PrimaryKeyColumns(0) = dt.Columns("ClientId")
                dt.PrimaryKey = PrimaryKeyColumns


                For Each client As JObject In jsonClients
                    Dim dictObj As Dictionary(Of String, String) = client.ToObject(Of Dictionary(Of String, String))()
                    Dim row As DataRow = dt.NewRow()
                    row("companyId") = companyId
                    row("ClientId") = dictObj("ClientId")
                    row("ProjectId") = dictObj("ProjectId")
                    row("ClientName") = dictObj("ClientName")
                    row("IsActive") = dictObj("IsActive")
                    dt.Rows.Add(row)
                Next


                'insert into SQL

                Dim objbulk As SqlBulkCopy = New SqlBulkCopy(LocalAPI.GetConnection())
                objbulk.ColumnMappings.Add("companyId", "companyId")
                objbulk.ColumnMappings.Add("ClientId", "ClientId")
                objbulk.ColumnMappings.Add("ProjectId", "ProjectId")
                objbulk.ColumnMappings.Add("ClientName", "ClientName")
                objbulk.ColumnMappings.Add("IsActive", "IsActive")

                objbulk.DestinationTableName = "Clients_Sync_Ebillity"
                objbulk.WriteToServer(dt)


                page_ += 1

            End While

            'update last Sync 
            LocalAPI.SetEbillityClientLastSyncDate(companyId, LastSyncDateNew)
            'Remuve Inactive
            LocalAPI.ExecuteNonQuery($"delete [Clients_Sync_Ebillity] where companyId = {companyId} and IsActive = 0")
            'Remove duplicate
            LocalAPI.ExecuteNonQuery($"delete Clients_Sync_Ebillity where companyId = {companyId} and PC_ClientId is null and ClientId in ( select ClientId FROM [dbo].[Clients_Sync_Ebillity]  where companyId = {companyId} and PC_ClientId is not null )")

        Catch ex As Exception
            Throw ex
        End Try


    End Function


    Public Shared Async Function GetEmployeeAsync(comapyId As String) As Task(Of Boolean)

        Try

            Dim json_s = Await GetRequestAsync(comapyId, "thirdparty/employees")
            Dim jsonObj As JObject = JObject.Parse(json_s)
            Dim jsonEmployees = jsonObj("Employees")

            Dim dt As New DataTable()

            dt.Columns.Add(New DataColumn("companyId", Type.GetType("System.Int32")))
            dt.Columns.Add(New DataColumn("EmployeeId", Type.GetType("System.Int32")))
            dt.Columns.Add(New DataColumn("FirstName", Type.GetType("System.String")))
            dt.Columns.Add(New DataColumn("LastName", Type.GetType("System.String")))
            dt.Columns.Add(New DataColumn("DefaultPayrollId", Type.GetType("System.Int32")))
            dt.Columns.Add(New DataColumn("UseTimeEntry", Type.GetType("System.Int32")))
            dt.Columns.Add(New DataColumn("EmployeeTypeId", Type.GetType("System.Int32")))
            dt.Columns.Add(New DataColumn("IsAutoApproveTimeEntry", Type.GetType("System.Boolean")))
            dt.Columns.Add(New DataColumn("IsAutoApproveExpenseEntry", Type.GetType("System.Boolean")))
            dt.Columns.Add(New DataColumn("KioskPIN", Type.GetType("System.String")))
            dt.Columns.Add(New DataColumn("CreatedDate", Type.GetType("System.DateTime")))
            dt.Columns.Add(New DataColumn("ModifiedDate", Type.GetType("System.DateTime")))
            dt.Columns.Add(New DataColumn("IsActive", Type.GetType("System.Boolean")))
            dt.Columns.Add(New DataColumn("IsInvited", Type.GetType("System.Boolean")))

            Dim PrimaryKeyColumns As DataColumn() = New DataColumn(0) {}
            PrimaryKeyColumns(0) = dt.Columns("EmployeeId")
            dt.PrimaryKey = PrimaryKeyColumns


            For Each Emp As JObject In jsonEmployees
                Dim dictObj As Dictionary(Of String, String) = Emp.ToObject(Of Dictionary(Of String, String))()
                Dim row As DataRow = dt.NewRow()
                row("companyId") = comapyId
                row("EmployeeId") = dictObj("EmployeeId")
                row("FirstName") = dictObj("FirstName")
                row("LastName") = dictObj("LastName")
                row("DefaultPayrollId") = dictObj("DefaultPayrollId")
                row("UseTimeEntry") = dictObj("UseTimeEntry")
                row("EmployeeTypeId") = dictObj("EmployeeTypeId")
                row("IsAutoApproveTimeEntry") = dictObj("IsAutoApproveTimeEntry")
                row("IsAutoApproveExpenseEntry") = dictObj("IsAutoApproveExpenseEntry")
                row("KioskPIN") = dictObj("KioskPIN")
                row("CreatedDate") = dictObj("CreatedDate")
                row("ModifiedDate") = dictObj("ModifiedDate")
                row("IsActive") = dictObj("IsActive")
                row("IsInvited") = dictObj("IsInvited")
                dt.Rows.Add(row)
            Next


            'insert into SQL

            Dim objbulk As SqlBulkCopy = New SqlBulkCopy(LocalAPI.GetConnection())

            objbulk.ColumnMappings.Add("companyId", "companyId")
            objbulk.ColumnMappings.Add("EmployeeId", "EmployeeId")
            objbulk.ColumnMappings.Add("FirstName", "FirstName")
            objbulk.ColumnMappings.Add("LastName", "LastName")
            objbulk.ColumnMappings.Add("DefaultPayrollId", "DefaultPayrollId")
            objbulk.ColumnMappings.Add("UseTimeEntry", "UseTimeEntry")
            objbulk.ColumnMappings.Add("EmployeeTypeId", "EmployeeTypeId")
            objbulk.ColumnMappings.Add("IsAutoApproveTimeEntry", "IsAutoApproveTimeEntry")
            objbulk.ColumnMappings.Add("IsAutoApproveExpenseEntry", "IsAutoApproveExpenseEntry")
            objbulk.ColumnMappings.Add("KioskPIN", "KioskPIN")
            objbulk.ColumnMappings.Add("CreatedDate", "CreatedDate")
            objbulk.ColumnMappings.Add("ModifiedDate", "ModifiedDate")
            objbulk.ColumnMappings.Add("IsActive", "IsActive")
            objbulk.ColumnMappings.Add("IsInvited", "IsInvited")


            objbulk.DestinationTableName = "Employees_Sync_Ebillity"
            objbulk.WriteToServer(dt)





        Catch ex As Exception
            Throw ex
        End Try


    End Function


    Public Shared Async Function GetActivitiesAsync(comapyId As String) As Task(Of Boolean)

        Try

            Dim json_s = Await GetRequestAsync(comapyId, "thirdparty/activities")
            Dim jsonObj As JObject = JObject.Parse(json_s)
            Dim jsonEmployees = jsonObj("Activities")

            Dim dt As New DataTable()

            dt.Columns.Add(New DataColumn("companyId", Type.GetType("System.Int32")))
            dt.Columns.Add(New DataColumn("ActivityId", Type.GetType("System.Int32")))
            dt.Columns.Add(New DataColumn("ActivityName", Type.GetType("System.String")))
            dt.Columns.Add(New DataColumn("IsActive", Type.GetType("System.Boolean")))

            Dim PrimaryKeyColumns As DataColumn() = New DataColumn(0) {}
            PrimaryKeyColumns(0) = dt.Columns("ActivityId")
            dt.PrimaryKey = PrimaryKeyColumns


            For Each Emp As JObject In jsonEmployees
                Dim dictObj As Dictionary(Of String, String) = Emp.ToObject(Of Dictionary(Of String, String))()
                Dim row As DataRow = dt.NewRow()
                row("companyId") = comapyId
                row("ActivityId") = dictObj("ActivityId")
                row("ActivityName") = dictObj("ActivityName")
                row("IsActive") = dictObj("IsActive")
                dt.Rows.Add(row)
            Next


            'insert into SQL

            Dim objbulk As SqlBulkCopy = New SqlBulkCopy(LocalAPI.GetConnection())

            objbulk.ColumnMappings.Add("companyId", "companyId")
            objbulk.ColumnMappings.Add("ActivityId", "ActivityId")
            objbulk.ColumnMappings.Add("ActivityName", "ActivityName")
            objbulk.ColumnMappings.Add("IsActive", "IsActive")


            objbulk.DestinationTableName = "Activity_Sync_Ebillity"
            objbulk.WriteToServer(dt)



            Return True

        Catch ex As Exception
            Throw ex
        End Try


    End Function


    Public Shared Async Function GetTimeEntriesAsync(compayId As String) As Task(Of Boolean)

        Try
            Dim page_ = 1
            Dim limit = 100

            Dim successfull = True

            While successfull
                Dim json_s = Await GetTimeEntriesRequestAsync(compayId, page_, limit)
                Dim jsonObj As JObject = JObject.Parse(json_s)
                Dim jsonClients = jsonObj("TimeEntries")
                successfull = jsonClients.Count > 0

                Dim dt As New DataTable()
                dt.Columns.Add(New DataColumn("companyId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("TimeEntryId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("ReferenceId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("TimeEntryDateEpoc", Type.GetType("System.Int64")))
                dt.Columns.Add(New DataColumn("EmployeeId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("ClientId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("ProjectId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("ActivityId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("ClassId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("PayrollId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("LocationId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("TimeEntryTypeId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("BillableTypeId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("IsBillable", Type.GetType("System.Boolean")))
                dt.Columns.Add(New DataColumn("FromHour", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("FromMinute", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("ToHour", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("ToMinute", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("TotalHour", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("TotalMinute", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("InvoiceDescription", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("InternalDescription", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("Rate", Type.GetType("System.Decimal")))
                dt.Columns.Add(New DataColumn("IsoverrideRate", Type.GetType("System.Boolean")))
                dt.Columns.Add(New DataColumn("TimeEntryStatusId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("RejectionNote", Type.GetType("System.String")))
                dt.Columns.Add(New DataColumn("CreatedDate", Type.GetType("System.DateTime")))
                dt.Columns.Add(New DataColumn("ModifiedDate", Type.GetType("System.DateTime")))
                dt.Columns.Add(New DataColumn("TimerId", Type.GetType("System.Int32")))
                dt.Columns.Add(New DataColumn("IsActive", Type.GetType("System.Boolean")))
                dt.Columns.Add(New DataColumn("IsBreakEntry", Type.GetType("System.Boolean")))
                dt.Columns.Add(New DataColumn("IsDuration", Type.GetType("System.Boolean")))
                dt.Columns.Add(New DataColumn("DateFromEpoc", Type.GetType("System.Int64")))
                dt.Columns.Add(New DataColumn("DateToEpoc", Type.GetType("System.Int64")))
                dt.Columns.Add(New DataColumn("IsLocked", Type.GetType("System.Boolean")))


                Dim PrimaryKeyColumns As DataColumn() = New DataColumn(0) {}
                PrimaryKeyColumns(0) = dt.Columns("TimeEntryId")
                dt.PrimaryKey = PrimaryKeyColumns


                For Each client As JObject In jsonClients

                    If Val(client.GetValue("TotalHour")) = 0 AndAlso Val(client.GetValue("TotalHour")) = 0 Then
                        Continue For
                    End If

                    Dim row As DataRow = dt.NewRow()
                    row("companyId") = compayId
                    row("TimeEntryId") = client.GetValue("TimeEntryId")
                    row("ReferenceId") = client.GetValue("ReferenceId")
                    row("TimeEntryDateEpoc") = client.GetValue("TimeEntryDateEpoc")
                    row("EmployeeId") = client.GetValue("EmployeeId")
                    row("ClientId") = client.GetValue("ClientId")
                    row("ProjectId") = client.GetValue("ProjectId")
                    row("ActivityId") = client.GetValue("ActivityId")
                    row("ClassId") = client.GetValue("ClassId")
                    row("PayrollId") = client.GetValue("PayrollId")
                    row("LocationId") = client.GetValue("LocationId")
                    row("TimeEntryTypeId") = client.GetValue("TimeEntryTypeId")
                    row("BillableTypeId") = client.GetValue("BillableTypeId")
                    row("IsBillable") = client.GetValue("IsBillable")
                    row("FromHour") = client.GetValue("FromHour")
                    row("FromMinute") = client.GetValue("FromMinute")
                    row("ToHour") = client.GetValue("ToHour")
                    row("ToMinute") = client.GetValue("ToMinute")
                    row("TotalHour") = client.GetValue("TotalHour")
                    row("TotalMinute") = client.GetValue("TotalMinute")
                    row("InvoiceDescription") = client.GetValue("InvoiceDescription")
                    row("InternalDescription") = client.GetValue("InternalDescription")
                    row("Rate") = client.GetValue("Rate")
                    row("IsoverrideRate") = client.GetValue("IsoverrideRate")
                    row("TimeEntryStatusId") = client.GetValue("TimeEntryStatusId")
                    row("RejectionNote") = client.GetValue("RejectionNote")
                    row("CreatedDate") = client.GetValue("CreatedDate")
                    row("ModifiedDate") = client.GetValue("ModifiedDate")
                    row("TimerId") = client.GetValue("TimerId")
                    row("IsActive") = client.GetValue("IsActive")
                    row("IsBreakEntry") = client.GetValue("IsBreakEntry")
                    row("IsDuration") = client.GetValue("IsDuration")
                    row("DateFromEpoc") = client.GetValue("DateFromEpoc")
                    row("DateToEpoc") = client.GetValue("DateToEpoc")
                    row("IsLocked") = client.GetValue("IsLocked")
                    dt.Rows.Add(row)
                Next


                'insert into SQL

                Dim objbulk As SqlBulkCopy = New SqlBulkCopy(LocalAPI.GetConnection())
                objbulk.ColumnMappings.Add("companyId", "companyId")
                objbulk.ColumnMappings.Add("TimeEntryId", "TimeEntryId")
                objbulk.ColumnMappings.Add("ReferenceId", "ReferenceId")
                objbulk.ColumnMappings.Add("TimeEntryDateEpoc", "TimeEntryDateEpoc")
                objbulk.ColumnMappings.Add("EmployeeId", "EmployeeId")
                objbulk.ColumnMappings.Add("ClientId", "ClientId")
                objbulk.ColumnMappings.Add("ProjectId", "ProjectId")
                objbulk.ColumnMappings.Add("ActivityId", "ActivityId")
                objbulk.ColumnMappings.Add("ClassId", "ClassId")
                objbulk.ColumnMappings.Add("PayrollId", "PayrollId")
                objbulk.ColumnMappings.Add("LocationId", "LocationId")
                objbulk.ColumnMappings.Add("TimeEntryTypeId", "TimeEntryTypeId")
                objbulk.ColumnMappings.Add("BillableTypeId", "BillableTypeId")
                objbulk.ColumnMappings.Add("IsBillable", "IsBillable")
                objbulk.ColumnMappings.Add("FromHour", "FromHour")
                objbulk.ColumnMappings.Add("FromMinute", "FromMinute")
                objbulk.ColumnMappings.Add("ToHour", "ToHour")
                objbulk.ColumnMappings.Add("ToMinute", "ToMinute")
                objbulk.ColumnMappings.Add("TotalHour", "TotalHour")
                objbulk.ColumnMappings.Add("TotalMinute", "TotalMinute")
                objbulk.ColumnMappings.Add("InvoiceDescription", "InvoiceDescription")
                objbulk.ColumnMappings.Add("InternalDescription", "InternalDescription")
                objbulk.ColumnMappings.Add("Rate", "Rate")
                objbulk.ColumnMappings.Add("IsoverrideRate", "IsoverrideRate")
                objbulk.ColumnMappings.Add("TimeEntryStatusId", "TimeEntryStatusId")
                objbulk.ColumnMappings.Add("RejectionNote", "RejectionNote")
                objbulk.ColumnMappings.Add("CreatedDate", "CreatedDate")
                objbulk.ColumnMappings.Add("ModifiedDate", "ModifiedDate")
                objbulk.ColumnMappings.Add("TimerId", "TimerId")
                objbulk.ColumnMappings.Add("IsActive", "IsActive")
                objbulk.ColumnMappings.Add("IsBreakEntry", "IsBreakEntry")
                objbulk.ColumnMappings.Add("IsDuration", "IsDuration")
                objbulk.ColumnMappings.Add("DateFromEpoc", "DateFromEpoc")
                objbulk.ColumnMappings.Add("DateToEpoc", "DateToEpoc")
                objbulk.ColumnMappings.Add("IsLocked", "IsLocked")

                objbulk.DestinationTableName = "TimeEntries_Sync_Ebillity"
                objbulk.WriteToServer(dt)


                page_ += 1

            End While


            LocalAPI.JobTimeEntries_Ebillity_Import(compayId)


            Return True

        Catch ex As Exception
            Throw ex
        End Try


    End Function

End Class
