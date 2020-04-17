Imports System.Data.SqlClient
Imports Microsoft.VisualBasic

Public Class eeg360
    Private Shared Function GetcnnEEG360DBConnection() As SqlConnection
        Try
            Dim cnn1 As SqlConnection
            ' Connect to the source
            cnn1 = New SqlConnection(ConfigurationManager.ConnectionStrings("cnnEEG360").ToString)
            ' Open the database
            cnn1.Open()
            ' Return the object
            Return cnn1

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function EmployeeStatus_UPDATE(Email As String, StatusId As Integer) As Boolean
        Try

            Dim cnn1 As SqlConnection = GetcnnEEG360DBConnection()
            Dim cmd As SqlCommand = cnn1.CreateCommand()

            ' ClienteEmail
            cmd.CommandText = String.Format("UPDATE [Employees] SET StatusId={0}, InactiveDate=case when {0}=0 then GetDate() else Null end WHERE [Email]='{1}'", StatusId, Email)
            cmd.ExecuteNonQuery()

        Catch ex As Exception

        End Try
    End Function
End Class
