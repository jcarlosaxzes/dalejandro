Imports Telerik.Web.UI
Public Class managementrequest
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Master.PageTitle = "Management Request"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Management Request"
            lblEmployeeEmail.Text = Master.UserEmail

            '!!!lblRequestId.Text = 1066
            If Not Request.QueryString("Id") Is Nothing Then
                lblRequestId.Text = Request.QueryString("Id")
                If Not Request.QueryString("guid") Is Nothing Then
                    lblCompanyId.Text = LocalAPI.GetCompanyIdFromGUID(Request.QueryString("guid"))
                End If
            End If
        End If

    End Sub

    Protected Sub btnAccept_Click(sender As Object, e As EventArgs)
        Try
            SqlDataSource1.Insert()
            SqlDataSource1.DataBind()
            RadDataForm1.DataBind()
            ResponseRequest("accepted")
            Master.InfoMessage("Time off request has been reviewed and processed.")
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try

    End Sub

    Protected Sub btnDecline_Click(sender As Object, e As EventArgs)
        Try
            SqlDataSource1.Update()
            SqlDataSource1.DataBind()
            RadDataForm1.DataBind()
            ResponseRequest("declined")
            Master.InfoMessage("Time off request has been reviewed and processed.")

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try

    End Sub

    Private Function ResponseRequest(ResponseType As String) As Boolean
        Try
            Dim sMsg As New System.Text.StringBuilder

            Dim EmployeeId As Integer = LocalAPI.GetNonJobTime_Request_Property(lblRequestId.Text, "EmployeeId")
            Dim EmployeeFullName As String = LocalAPI.GetEmployeeName(EmployeeId)
            Dim EmployeeEmail As String = LocalAPI.GetEmployeeEmail(EmployeeId)
            Dim DateRequest As String = LocalAPI.GetNonJobTime_Request_Property(lblRequestId.Text, "DateFrom")
            Dim ResponseExplanation As String = LocalAPI.GetNonJobTime_Request_Property(lblRequestId.Text, "NotesResponse")

            sMsg.Append("Mr./Mrs. <b>" & EmployeeFullName & "</b>")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Your time off request has been reviewed and processed. Your request for time off on <b>" & DateRequest & "</b> was <b>" & ResponseType & "</b> ")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Notes:")
            sMsg.Append("<br />")
            sMsg.Append(ResponseExplanation)
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
            Dim sSubject As String = "PASconcept. Request has been reviewed and processed"

            Return LocalAPI.SendMail(EmployeeEmail, "", "", sSubject, sBody, lblCompanyId.Text)

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Function

    Private Sub SqlDataSource1_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource1.Inserting
        e.Command.Parameters(2).Value = CType(RadDataForm1.Items(0).FindControl("txtExplanation"), RadTextBox).Text
    End Sub

    Private Sub SqlDataSource1_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource1.Updating
        e.Command.Parameters(2).Value = CType(RadDataForm1.Items(0).FindControl("txtExplanation"), RadTextBox).Text
    End Sub
End Class
