Imports Microsoft.VisualBasic.FileIO
Imports System.IO
Public Class importtickets
    Inherits System.Web.UI.Page

    Protected Property SuccessMessageText() As String
        Get
            Return m_SuccessMessage
        End Get
        Private Set(value As String)
            m_SuccessMessage = value
            successMessage.Visible = Not [String].IsNullOrEmpty(value)
        End Set
    End Property
    Private m_SuccessMessage As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")

                lblJobId.Text = Request.QueryString("JobId")
                lblJob.Text = LocalAPI.GetJobCodeName(lblJobId.Text)

                Master.PageTitle = "Job/Import Tickets"

            End If

        Catch ex As Exception
        End Try
    End Sub

    Private Function Import_TicketsFromJiraCSV() As Integer
        Try
            If RadUpload1.UploadedFiles.Count = 0 Then
                SuccessMessageText = "Select valid csv file!!!"
            Else
                SuccessMessageText = ""
                ' declare CsvDataReader object which will act as a source for data for SqlBulkCopy
                Dim StreamerObject As Stream = RadUpload1.UploadedFiles(0).InputStream
                Dim nRecs As Integer

                Using parser As TextFieldParser = New TextFieldParser(StreamerObject)

                    ' 1ra fila es cabecera 
                    'Summary,Issue key,Issue id,Issue Type,Status,Project key,Project name,Project type,Project lead,Project description,Project url,Priority,Resolution,Assignee,Reporter,Creator,Created,Updated,Last Viewed,Resolved,Fix versions,Components,Components,Due date,Votes,Labels,Description,Environment,Watchers,Watchers,Watchers,Log Work,Original Estimate,Remaining Estimate,Time Spent,Work Ratio,Σ Original Estimate,Σ Remaining Estimate,Σ Time Spent,Security Level,Attachment,Attachment,Attachment,Attachment,Attachment,Attachment,Custom field (Change completion date),Custom field (Change reason),Custom field (Change risk),Custom field (Change start date),Custom field (Change type),Custom field (Development),Custom field (Epic Color),Custom field (Epic Link),Custom field (Epic Name),Custom field (Epic Status),Custom field (Impact),Custom field (Issue color),Custom field (Location),Custom field (Rank),Custom field (Request Type),Sprint,Custom field (Start date),Custom field (Story Points),Custom field (Story point estimate),Custom field ([CHART] Date of First Response),Comment,Comment,Comment,Comment,Comment,Comment,Comment,Comment,Comment,Comment,Comment,Comment,Comment,Comment,Comment,Comment,Comment

                    parser.TextFieldType = FieldType.Delimited
                    parser.SetDelimiters(",")
                    Dim iField As Integer
                    Dim fields As String() = parser.ReadFields()
                    Dim currentRow As String()
                    Dim JobTicketObject As LocalAPI.JobTicketStruct

                    ' Initial values
                    JobTicketObject.jobId = lblJobId.Text
                    JobTicketObject.TicketId = 0
                    JobTicketObject.employeeId = LocalAPI.GetJobProperty(lblJobId.Text, "Employee")
                    JobTicketObject.CompanyDescription = ""
                    JobTicketObject.ApprovedStatus = "Approved"
                    JobTicketObject.NotificationClientName = ""
                    JobTicketObject.NotificationClientEmail = ""
                    JobTicketObject.NotificationBCClientEmail = ""
                    JobTicketObject.trelloURL = ""
                    JobTicketObject.Tags = ""

                    If Not fields Is Nothing Then
                        While Not parser.EndOfData
                            currentRow = parser.ReadFields()
                            iField = 0
                            Dim currentField As String
                            For Each currentField In currentRow

                                Select Case fields(iField)

                                    Case "Summary"
                                        JobTicketObject.Title = "" & currentField
                                        If Len(JobTicketObject.Title) = 0 Then Exit For

                                    Case "Issue key"
                                        JobTicketObject.Title = JobTicketObject.Title & " (" & currentField & ")"

                                    Case "Issue Type"
                                        If lblCompanyId.Text = 260973 Then
                                            Select Case "" & currentField
                                                Case "Bug"
                                                    JobTicketObject.Type = "Defect"
                                                Case "Story"
                                                    JobTicketObject.Type = "Epic"
                                                Case "Task"
                                                    JobTicketObject.Type = "Enhancement"
                                                Case Else
                                                    JobTicketObject.Type = "Undefined"
                                            End Select
                                        End If

                                    Case "Status"
                                        If lblCompanyId.Text = 260973 Then
                                            Select Case "" & currentField
                                                Case "Staging"
                                                    JobTicketObject.Status = "In Staging"
                                                Case "To Do"
                                                    JobTicketObject.Status = "Ready for Development"
                                                Case "In Progress"
                                                    JobTicketObject.Status = "In Progress"
                                                Case "Blocked/Po Review"
                                                    JobTicketObject.Status = "Blocked"
                                                Case "Production"
                                                    JobTicketObject.Status = "In Production"
                                                Case Else
                                                    JobTicketObject.Status = "Pending Approval"
                                            End Select
                                        End If

                                    Case "Project name"
                                        JobTicketObject.AppName = "" & currentField

                                    Case "Project url"
                                        JobTicketObject.jiraURL = "" & currentField

                                    Case "Priority"
                                        Select Case "" & currentField
                                            Case "Highest", "High"
                                                JobTicketObject.Priority = "High"
                                            Case "Medium"
                                                JobTicketObject.Priority = "Medium"
                                            Case Else
                                                JobTicketObject.Priority = "Low"
                                        End Select

                                    Case "Assignee"
                                        JobTicketObject.Notes = "" & currentField

                                    Case "Created"
                                        JobTicketObject.ExpectedStartDate = currentField
                                        JobTicketObject.StagingDate = JobTicketObject.ExpectedStartDate
                                        JobTicketObject.ProductionDate = JobTicketObject.ExpectedStartDate

                                    Case "Components"
                                        JobTicketObject.LocationModule = "" & currentField

                                    Case "Due date"
                                        If Len("" & currentField) > 0 Then
                                            JobTicketObject.StagingDate = "" & currentField
                                            JobTicketObject.ProductionDate = "" & currentField
                                        End If
                                    Case "Description"
                                        JobTicketObject.ClientDescription = "" & currentField
                                        Exit For
                                End Select

                                iField = iField + 1
                            Next


                            If Len(JobTicketObject.Title) > 0 Then

                                If LocalAPI.Jobs_ticket_IMPORT(JobTicketObject) Then
                                    nRecs = nRecs + 1
                                End If

                            End If

                        End While
                    End If
                End Using

                If Len(SuccessMessageText) = 0 Then SuccessMessageText = "'" & nRecs & "' Imported records. "
                Return nRecs
            End If
        Catch ex As Exception
            RadUpload1.UploadedFiles.Clear()
            SuccessMessageText = "Error " & ex.Message

        End Try
    End Function

    Private Function Import_TicketsFromPASCSV() As Integer
        Try
            If RadUpload1.UploadedFiles.Count = 0 Then
                SuccessMessageText = "Select valid csv file!!!"
            Else
                SuccessMessageText = ""
                ' declare CsvDataReader object which will act as a source for data for SqlBulkCopy
                Dim StreamerObject As Stream = RadUpload1.UploadedFiles(0).InputStream
                Dim nRecs As Integer

                Using parser As TextFieldParser = New TextFieldParser(StreamerObject)

                    ' 1ra fila es cabecera 
                    '"Ticket#","App Name","Location/Module","Title","Tags","Due Date","ClientDescription","Type","Priority","Status","ApprovedStatus","CompanyDescription","ExpectedStartDate","LastStatusDate","StagingDate","ProductionDate","Notes","Hours"


                    parser.TextFieldType = FieldType.Delimited
                    parser.SetDelimiters(",")
                    Dim iField As Integer
                    Dim fields As String() = parser.ReadFields()
                    Dim currentRow As String()
                    Dim JobTicketObject As LocalAPI.JobTicketStruct

                    ' Initial values
                    JobTicketObject.jobId = lblJobId.Text
                    JobTicketObject.employeeId = LocalAPI.GetJobProperty(lblJobId.Text, "Employee")
                    JobTicketObject.CompanyDescription = ""

                    JobTicketObject.NotificationClientName = ""
                    JobTicketObject.NotificationClientEmail = ""
                    JobTicketObject.NotificationBCClientEmail = ""
                    JobTicketObject.trelloURL = ""
                    JobTicketObject.Tags = ""

                    If Not fields Is Nothing Then
                        While Not parser.EndOfData
                            currentRow = parser.ReadFields()
                            iField = 0
                            Dim currentField As String
                            For Each currentField In currentRow

                                Select Case fields(iField)

                                    Case "Ticket#", "#", "ID"
                                        JobTicketObject.TicketId = Val("" & currentField)

                                    Case "App Name"
                                        JobTicketObject.AppName = "" & currentField

                                    Case "Location/Module"
                                        JobTicketObject.LocationModule = "" & currentField

                                    Case "Title"
                                        JobTicketObject.Title = "" & currentField
                                        If Len(JobTicketObject.Title) = 0 Then Exit For

                                    Case "Tags"
                                        JobTicketObject.Tags = "" & currentField

                                    Case "Due Date", "StagingDate"
                                        JobTicketObject.StagingDate = "" & currentField

                                    Case "ClientDescription"
                                        JobTicketObject.ClientDescription = "" & currentField

                                    Case "Type"
                                        JobTicketObject.Type = "" & currentField

                                    Case "Priority"
                                        JobTicketObject.Priority = "" & currentField

                                    Case "Status"
                                        JobTicketObject.Status = "" & currentField

                                    Case "ApprovedStatus"
                                        JobTicketObject.ApprovedStatus = "" & currentField

                                    Case "CompanyDescription"
                                        JobTicketObject.CompanyDescription = "" & currentField

                                    Case "ExpectedStartDate"
                                        JobTicketObject.ExpectedStartDate = "" & currentField

                                    Case "ProductionDate"
                                        JobTicketObject.ProductionDate = "" & currentField

                                    Case "Notes"
                                        JobTicketObject.Notes = "" & currentField
                                    Case "trelloURL"
                                        JobTicketObject.trelloURL = "" & currentField
                                    Case "jiraURL"
                                        JobTicketObject.jiraURL = "" & currentField


                                        Exit For
                                End Select

                                iField = iField + 1
                            Next


                            If Len(JobTicketObject.Title) > 0 Then

                                If LocalAPI.Jobs_ticket_IMPORT(JobTicketObject) Then
                                    nRecs = nRecs + 1
                                End If

                            End If

                        End While
                    End If
                End Using

                If Len(SuccessMessageText) = 0 Then SuccessMessageText = "'" & nRecs & "' Imported records. "
                Return nRecs
            End If
        Catch ex As Exception
            RadUpload1.UploadedFiles.Clear()
            SuccessMessageText = "Error " & ex.Message

        End Try
    End Function
    Private Sub btnImport_Click(sender As Object, e As EventArgs) Handles btnImport.Click
        Select Case cboSource.SelectedText
            Case "Jira Cards CSV"
                Import_TicketsFromJiraCSV()
            Case "PASconcept Tickets CSV"
                Import_TicketsFromPASCSV()
        End Select


    End Sub
End Class

