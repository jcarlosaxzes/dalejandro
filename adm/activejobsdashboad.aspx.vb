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
                If Not Request.QueryString("restoreFilter") Is Nothing Then
                    RestoreFilter()
                End If
                RefrescarDatos()
            End If
            RadWindowManager1.EnableViewState = False
        Catch ex As Exception
            Beep()
        End Try
    End Sub

    Private Sub cboEmployee_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboEmployee.SelectedIndexChanged
        ' Refresh cboJobs
        cboJobs.Items.Clear()
        cboJobs.Items.Insert(0, New RadComboBoxItem("(Other Active Jobs...)", -1))
        cboJobs.DataBind()
        RefrescarDatos()
    End Sub

    Private Sub RefrescarDatos()
        Try

            RadListViewRefresh()

            RadGridFooter.DataBind()
            PanelLegend.DataBind()
            Dim dValue As Double = LocalAPI.GetWeeklyHoursByEmp(cboEmployee.SelectedValue, lblCompanyId.Text)
            lblTotalWeekHours.Text = FormatNumber(dValue, 1)
            lblRemaining.Text = FormatNumber(40 - dValue, 1)

            '----------------------------------
            Session("employeefortime") = cboEmployee.SelectedValue

            RadHtmlChartTimeSheet.DataBind()
            RadHtmlChartTimeUsed.DataBind()

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub cboJobs_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboJobs.SelectedIndexChanged
        btnNew.Enabled = True
    End Sub

    Private Sub RadListViewRefresh()
        RadListView1.DataBind()
        RadListView2.DataBind()
        RadListView3.DataBind()
    End Sub


    Protected Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        Try
            ' Anadir Employee al Job
            LocalAPI.Jobs_Employees_assigned_INSERT(cboJobs.SelectedValue, cboEmployee.SelectedValue)
            RadListViewRefresh()
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        SaveFilter()
        RefrescarDatos()
    End Sub

    Private Sub RadListView1_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles RadListView1.ItemCommand
        Select Case e.CommandName

            Case "AddNewTime"
                Response.Redirect("~/adm/employeenewtime.aspx?JobId=" & e.CommandArgument & "&backpage=activejobsdashboad")

            Case "EditReviews"
                If LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Type") = 16 Then
                    ' Programmers/Computer/IT
                    Response.Redirect("~/adm/JobTickets.aspx?JobId=" & e.CommandArgument)
                Else
                    CreateRadWindows("NewJob", "~/adm/Reviews.aspx?JobId=" & e.CommandArgument, 960, 600, False, True)
                End If

                lblSelectedJob.Text = e.CommandArgument
        End Select
    End Sub

    Protected Sub btnNewMiscellaneousTime_Click(sender As Object, e As EventArgs) Handles btnNewMiscellaneousTime.Click
        SaveFilter()
        '!!!ShowNewMiscellaneousTimeDlg(Date.Today, -1)
        Response.Redirect("~/adm/employeenewdowntime.aspx?backpage=activejobsdashboad")
    End Sub

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

    Public Function GetDateOfWeekStyle(Date1 As DateTime) As String
        Select Case Date1.DayOfWeek
            Case 1, 2, 3, 4, 5 ' Monday to Friday
                If DateTime.Compare(Date1.Date, Date.Today.Date) = 0 Then
                    Return "font-style:normal;color:black;font-weight:bold;"
                Else
                    Return "font-style:normal;color:black;"
                End If

            Case Else ' Saturday, Sunday
                Return "font-style:italic;color:lightgray"
        End Select
    End Function

    Private Sub SaveFilter()
        Session("Filter_ActiveJobs_Employee") = cboEmployee.SelectedValue
        Session("Filter_ActiveJobs_companyId") = lblCompanyId.Text
        Session("Filter_ActiveJobs_Find") = txtFind.Text

    End Sub

    Private Sub RestoreFilter()
        Try
            Dim Filter_ActiveJobs_Employee = Session("Filter_ActiveJobs_Employee")
            If Filter_ActiveJobs_Employee IsNot Nothing Then
                cboEmployee.SelectedValue = Session("Filter_ActiveJobs_Employee")
                lblCompanyId.Text = Session("Filter_ActiveJobs_companyId")
                txtFind.Text = Session("Filter_ActiveJobs_Find")
            End If
        Catch ex As Exception
        End Try
    End Sub
End Class


