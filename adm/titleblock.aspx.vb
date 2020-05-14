Public Class titleblock
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Not Request.QueryString("guid") Is Nothing Then
                Dim jobId As Integer = LocalAPI.GetJobIdFromGUID(Request.QueryString("guid"))
                'Dim jobId As Integer = LocalAPI.GetJobIdFromGUID("1662DA14-75DB-4D5E-8699-7689940C6310")

                DownloadTitleblock(jobId)

            End If
        End If
    End Sub
    Private Sub DownloadTitleblock(jobId As Integer)
        Try

            Dim JobObject = LocalAPI.GetRecord(jobId, "JOB_TBtxt_SELECT")
            Dim attachment As String = "attachment; filename=" & JobObject("Code") & "_TB.txt"
            HttpContext.Current.Response.Clear()
            HttpContext.Current.Response.ClearHeaders()
            HttpContext.Current.Response.ClearContent()
            HttpContext.Current.Response.AddHeader("Content-Disposition", attachment)
            HttpContext.Current.Response.ContentType = "text/csv"
            HttpContext.Current.Response.AddHeader("axzes", "public")
            Dim sb = New StringBuilder()

            ' Header row
            sb.AppendLine("Number;Name;Location;Client;Employee;Department;Type;FolderTemplate")
            ' Content row
            sb.AppendLine(JobObject("Code") & ";" & JobObject("Job") & ";" & JobObject("ProjectLocation") & ";" & JobObject("ClientName") & ";" & JobObject("EmployeeName") & ";" & JobObject("DepartmentName") & ";" & JobObject("JobType") & ";" & JobObject("FolderTemplate"))

            HttpContext.Current.Response.Write(sb.ToString())
            HttpContext.Current.Response.End()

        Catch ex As Exception

        End Try
    End Sub

End Class
