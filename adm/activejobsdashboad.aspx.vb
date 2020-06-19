Imports Telerik.Web.UI

Public Class activejobsdashboad
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Home"
            Master.PageTitle = "Home"
            If Not IsPostBack Then
                lblLogedEmployeeId.Text = Master.UserId
                lblUserEmail.Text = Master.UserEmail

                If Session("employeefortime") Is Nothing Then
                    Session("employeefortime") = lblLogedEmployeeId.Text
                End If
                cboEmployee.DataBind()
                cboEmployee.SelectedValue = Session("employeefortime")

                lblCompanyId.Text = Session("companyId")
                cboStatus.DataBind()
                RefrescarDatos()
            End If
            RadWindowManager1.EnableViewState = False

        Catch ex As Exception
            Beep()
        End Try
    End Sub

    Protected Sub cboStatus_ItemDataBound(sender As Object, e As RadComboBoxItemEventArgs) Handles cboStatus.ItemDataBound
        e.Item.Checked = IIf(e.Item.Value = 0 Or e.Item.Value = 2, True, False)
    End Sub
    Private Sub cboEmployee_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboEmployee.SelectedIndexChanged
        RefrescarDatos()
    End Sub

    Private Sub RefrescarDatos()
        lblStatusIdIN_List.Text = ""
        Dim collection As IList(Of RadComboBoxItem) = cboStatus.CheckedItems
        If (collection.Count <> 0) Then
            For Each item As RadComboBoxItem In collection
                lblStatusIdIN_List.Text = lblStatusIdIN_List.Text + item.Value + ","
            Next
            ' Quitar la ultima coma
            lblStatusIdIN_List.Text = Left(lblStatusIdIN_List.Text, Len(lblStatusIdIN_List.Text) - 1)
        End If

        RadListView1.DataBind()

        RadGridFooter.DataBind()
        PanelLegend.DataBind()
        Dim dValue As Double = LocalAPI.GetWeeklyHoursByEmp(cboEmployee.SelectedValue, lblCompanyId.Text)
        lblTotalWeekHours.Text = FormatNumber(dValue, 1)
        lblRemaining.Text = FormatNumber(40 - dValue, 1)

        '----------------------------------
        Session("employeefortime") = cboEmployee.SelectedValue

    End Sub

    Protected Sub cboJobs_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboJobs.SelectedIndexChanged
        btnNew.Enabled = True
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        Try
            ' Anadir Employee al Job
            LocalAPI.Jobs_Employees_assigned_INSERT(cboJobs.SelectedValue, cboEmployee.SelectedValue)
            RadListView1.DataBind()
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RefrescarDatos()
    End Sub

    Private Sub RadListView1_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles RadListView1.ItemCommand
        Select Case e.CommandName

            Case "AddNewTime"
                Response.Redirect("~/adm/employeenewtime.aspx?JobId=" & e.CommandArgument & "&employeenewbackpage=activejobsdashboad")

            Case "AddReview"
                lblSelectedJob.Text = e.CommandArgument
                ShowNewReviewDlg()

            Case "EditReviews"
                If LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Type") = 16 Then
                    ' Programmers/Computer/IT
                    Response.Redirect("~/ADM/JobTickets.aspx?JobId=" & e.CommandArgument)
                Else
                    CreateRadWindows("NewJob", "~/ADM/Reviews.aspx?JobId=" & e.CommandArgument, 960, 600, False, True)
                End If

                lblSelectedJob.Text = e.CommandArgument
        End Select
    End Sub

    Protected Sub btnNewMiscellaneousTime_Click(sender As Object, e As EventArgs) Handles btnNewMiscellaneousTime.Click
        ShowNewMiscellaneousTimeDlg(Date.Today, -1)
    End Sub

    Private Sub ShowNewMiscellaneousTimeDlg(TimeDate As DateTime, nType As Integer)

        ' Init fields
        If nType > 0 Then
            cboType.SelectedValue = nType
        End If

        txtMiscellaneousHours.Text = 1

        RadDatePickerFrom.DbSelectedDate = TimeDate
        RadDatePickerTo.DbSelectedDate = TimeDate

        txtNotes.Text = ""

        Dim dFrom As DateTime = Year(RadDatePickerFrom.DbSelectedDate) & "-01-01"
        Dim dTo As DateTime = Year(RadDatePickerFrom.DbSelectedDate) & "-12-31 23:59"
        Dim dPermited As Double
        Dim dHours As Double
        ' Benefits_vacations
        dHours = LocalAPI.GetEmployeeNonRegularHours_count(cboEmployee.SelectedValue, 7, dFrom, dTo)
        lblVac2.Text = dHours
        dPermited = LocalAPI.GetEmployeeProperty(cboEmployee.SelectedValue, "Benefits_vacations")
        If dPermited >= 0 Then
            lblVac1.Text = dPermited
            lblVac3.Text = dPermited - dHours
        Else
            lblVac1.Text = ""
            lblVac3.Text = ""
        End If

        ' Benefits_personals Se suman 5 y 6 
        dHours = LocalAPI.GetEmployeeNonRegularHours_count(cboEmployee.SelectedValue, 5, dFrom, dTo)
        dHours = dHours + LocalAPI.GetEmployeeNonRegularHours_count(cboEmployee.SelectedValue, 6, dFrom, dTo)
        lblPer2.Text = dHours
        dPermited = LocalAPI.GetEmployeeProperty(cboEmployee.SelectedValue, "Benefits_personals")
        If dPermited >= 0 Then
            lblPer1.Text = dPermited
            lblPer3.Text = dPermited - dHours
        Else
            lblPer1.Text = ""
            lblPer3.Text = ""
        End If

        RadToolTipMiscellaneous.Visible = True
        RadToolTipMiscellaneous.Show()
        cboType.Focus()

    End Sub

    Protected Sub btnOkNewMiscellaneousTime_Click(sender As Object, e As EventArgs) Handles btnOkNewMiscellaneousTime.Click
        Try
            If LocalNewTMiscellaneousTime() Then
                RefrescarDatos()
                Master.InfoMessage("New time inserted")
                RadToolTipMiscellaneous.Visible = False
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Function LocalNewTMiscellaneousTime() As Boolean
        Try

            Dim bRet As Boolean
            If AnalisisDeBenefits() Then
                Select Case cboType.SelectedValue
                    Case 5, 6, 7
                        Dim requestId As Integer = LocalAPI.NewNonJobTime_Request(cboEmployee.SelectedValue, cboType.SelectedValue, RadDatePickerFrom.SelectedDate, RadDatePickerTo.SelectedDate, txtMiscellaneousHours.Text, txtNotes.Text, lblCompanyId.Text)
                        If requestId > 0 Then
                            bRet = True
                            MessageRequest(requestId)
                            Master.InfoMessage("Your request for " & cboType.Text & " has been sended to HR Manager and is currently in progress. Thank you for your patience as your request is reviewed for approval", 10)
                        End If
                    Case Else
                        bRet = LocalAPI.NewNonJobTime(cboEmployee.SelectedValue, cboType.SelectedValue, RadDatePickerFrom.SelectedDate, RadDatePickerTo.SelectedDate, txtMiscellaneousHours.Text, txtNotes.Text)
                        If bRet Then Master.InfoMessage(cboType.Text & " time inserted")

                End Select

                Return bRet
            End If

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Function

    Private Function AnalisisDeBenefits() As Boolean
        Dim dHours As Double
        Dim dPermited As Double
        Dim dSaldoFinal As String = 0
        Dim EntryTotalHours As Double = txtMiscellaneousHours.DbValue
        If RadDatePickerFrom.DbSelectedDate <> RadDatePickerTo.DbSelectedDate Then
            EntryTotalHours = 8 * DateDiff(DateInterval.Day, RadDatePickerFrom.DbSelectedDate, RadDatePickerTo.DbSelectedDate)
        End If
        Select Case cboType.SelectedValue
            Case 7  ' Vacations
                If lblVac1.Text <> "" Then
                    dHours = lblVac2.Text
                    dSaldoFinal = lblVac1.Text - lblVac2.Text - EntryTotalHours
                End If

            Case 5, 6  ' Personal, Sick, 
                If lblPer1.Text <> "" Then
                    dSaldoFinal = lblPer1.Text - lblPer2.Text - EntryTotalHours
                End If
        End Select

        If dSaldoFinal < 0 Then
            Master.ErrorMessage("Outstanding " & cboType.Text & " hours are " & dPermited - dHours, 0)
            Return False
        Else
            Return True

        End If
    End Function

    Private Function MessageRequest(requestId As Integer) As Boolean
        Try
            Dim sMsg As New System.Text.StringBuilder
            Dim HRname As String = LocalAPI.GetCompanyHRname(lblCompanyId.Text)
            Dim sTo As String = LocalAPI.GetCompanyHRemail(lblCompanyId.Text)

            sMsg.Append("Dear " & HRname)
            sMsg.Append("<br />")
            sMsg.Append("<br />")

            sMsg.Append("This message is to notify you that " & LocalAPI.GetEmployeeFullName(lblUserEmail.Text, lblCompanyId.Text) & " has requested " & cboType.Text)
            sMsg.Append("<br />")
            sMsg.Append("Date Request: " & Date.Today)
            sMsg.Append("<br />")
            sMsg.Append("From: " & RadDatePickerFrom.SelectedDate & "   To " & RadDatePickerTo.SelectedDate)
            sMsg.Append("<br />")
            sMsg.Append("Time: " & txtMiscellaneousHours.Text & " Hours")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Notes:")
            sMsg.Append("<br />")
            sMsg.Append(txtNotes.Text)
            sMsg.Append("<br />")
            sMsg.Append("<br />")

            sMsg.Append("<a href=" & """" & LocalAPI.GetHostAppSite() & "/ADM/ManagementRequest.aspx?Id=" & requestId & "&guid=" & LocalAPI.GetCompanyGUID(lblCompanyId.Text) & """" & "> Please click the following link to view all details and accept or decline the request</a>")

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



            Dim sSubject As String = "Request " & cboType.Text

            Return SendGrid.Email.SendMail(sTo, "", "", sSubject, sBody, lblCompanyId.Text)

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Function

    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean, bRefreshOnClose As Boolean)
        Try

            RadWindowManager1.Windows.Clear()
            Dim window1 As RadWindow = New RadWindow()
            window1.NavigateUrl = sUrl
            window1.VisibleOnPageLoad = True
            window1.VisibleStatusbar = False
            window1.ID = WindowsID
            If Maximize Then window1.InitialBehaviors = WindowBehaviors.Maximize
            window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
            window1.Width = Width
            window1.Height = Height
            window1.Modal = True
            window1.DestroyOnClose = True
            If bRefreshOnClose Then window1.OnClientClose = "OnClientClose"
            window1.ShowOnTopWhenMaximized = Maximize
            RadWindowManager1.Windows.Add(window1)
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub


#Region "Review"
    Private Sub ShowNewReviewDlg()
        ' Init fields
        txtReviewCode.Text = ""
        txtReviewURL.Text = ""
        cboReviewCity.SelectedValue = 0
        cboReviewDepartment.SelectedValue = 0
        RadDatePickerReviewSubmit.DbSelectedDate = Date.Today
        cboPlanReview_status.SelectedValue = 0
        cboReviewer.SelectedValue = 0
        txtRewiewNotes.Text = ""

        RadToolTipReview.Visible = True
        RadToolTipReview.Show()
        txtReviewCode.Focus()

    End Sub

    Private Sub btnNewReview_Click(sender As Object, e As EventArgs) Handles btnNewReview.Click
        RadToolTipReview.Visible = False
        SqlDataSourceJobsReviews.Insert()
        RadListView1.DataBind()

    End Sub

    Public Function GetDateOfWeekStyle(Date1 As DateTime) As String
        Select Case Date1.DayOfWeek
            Case 1, 2, 3, 4, 5 ' Monday to Friday
                If DateTime.Compare(Date1.Date, Date.Today.Date) = 0 Then
                    Return "font-style:normal;color:black;font-weight:bold;font-size:Small"
                Else
                    Return "font-style:normal;color:black;font-size:Small"
                End If

            Case Else ' Saturday, Sunday
                Return "font-style:italic;color:lightgray"
        End Select
    End Function

    Private Sub SqlDataSourceJobs_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceJobs.Selecting
        Dim e1 As String = e.Command.Parameters("@StatusIdIN_List").Value
    End Sub
    Public Function GetRevisionOrTicketLabel() As String
        If LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Type") = 16 Then
            ' Programmers/Computer/IT
            Return "View Tickets"
        Else
            Return "View Revisions"
        End If
    End Function

    Public Function GetAddRevisionToolTip() As String
        If LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Type") = 16 Then
            ' Programmers/Computer/IT
            Return "Add New Ticket"
        Else
            Return "Add New Revision Record"
        End If
    End Function
    Public Function GetViewEditRevisionToolTip() As String
        If LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Type") = 16 Then
            ' Programmers/Computer/IT
            Return "View/Edit Ticket List. The amount represents the tickets in status 'Ready for Development', 'In Progress' or 'Development Closed"
        Else
            Return "View/Edit Revisions List"
        End If
    End Function


#End Region

End Class


