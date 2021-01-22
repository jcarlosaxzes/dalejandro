Imports Telerik.Web.UI
Public Class managementrequest
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblCompanyId.Text = Session("companyId")
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

            Dim DictValues As Dictionary(Of String, String) = New Dictionary(Of String, String)
            DictValues.Add("[EmployeeFullName]", EmployeeFullName)
            DictValues.Add("[DateRequest]", DateRequest)
            DictValues.Add("[ResponseType]", ResponseType)
            DictValues.Add("[ResponseExplanation]", ResponseExplanation)
            DictValues.Add("[PASSign]", LocalAPI.GetPASSign())

            Dim sSubject As String = LocalAPI.GetMessageTemplateSubject("Manager_Response_Request", lblCompanyId.Text, DictValues)
            Dim sBody As String = LocalAPI.GetMessageTemplateBody("Manager_Response_Request", lblCompanyId.Text, DictValues)

            Return SendGrid.Email.SendMail(EmployeeEmail, "", "", sSubject, sBody, lblCompanyId.Text, 0, 0)

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

    Protected Sub RadScheduler1_AppointmentDataBound(sender As Object, e As SchedulerEventArgs)
        Select Case e.Appointment.Description
            Case "Request Time"
                e.Appointment.CssClass = "rsCategoryBlue"
                e.Appointment.Font.Size = 10
                e.Appointment.ForeColor = System.Drawing.Color.White
            Case "Non Productive Time"
                e.Appointment.CssClass = "rsCategoryPink"
                e.Appointment.Font.Size = 10
                e.Appointment.ForeColor = System.Drawing.Color.White

            Case "Holiday"
                e.Appointment.CssClass = "rsCategoryGreen"
                e.Appointment.Font.Size = 10
                e.Appointment.ForeColor = System.Drawing.Color.White
        End Select
    End Sub

    Private Sub RadDataForm1_ItemCreated(sender As Object, e As RadDataFormItemEventArgs) Handles RadDataForm1.ItemCreated

        If e.Item.ItemType = RadDataFormItemType.DataItem Then
            Dim item As RadDataFormDataItem = TryCast(e.Item, RadDataFormDataItem)
            Dim scheduler As RadScheduler = CType(item.FindControl("RadScheduler1"), RadScheduler)
            If Not Request.QueryString("Id") Is Nothing Then
                Dim timeRequest = LocalAPI.GetRecordFromQuery($"select * from Employees_NonRegularHours_Request where Id = {Request.QueryString("Id")}")
                Dim dateFrom As DateTime = timeRequest("DateFrom")
                scheduler.SelectedDate = dateFrom
            End If



        End If
    End Sub
End Class
