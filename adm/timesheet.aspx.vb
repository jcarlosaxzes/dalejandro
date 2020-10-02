Imports Telerik.Web.UI
Imports Telerik.Web.UI.Calendar
Public Class timesheet
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Timesheet"
            If (Not Page.IsPostBack) Then
                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Timesheet") Then Response.RedirectPermanent("~/adm/default.aspx")

                Master.PageTitle = "Employees/Timesheet"
                Master.Help = "http://blog.pasconcept.com/2012/07/employees-periodic-timesheet.html"
                lblCompanyId.Text = Session("companyId")

                Dim lEmplId As Integer = Val("" & Request.QueryString("EmployeeId"))
                cboEmployee.DataBind()
                If lEmplId = 0 Then
                    cboEmployee.SelectedValue = Master.UserId
                Else
                    cboEmployee.SelectedValue = lEmplId
                End If
                cboEmployee.Enabled = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_EmployeesList")

                Dim sFecha As String = Request.QueryString("From")
                Dim sFechaDes As String
                Dim sFechaHas As String
                If Len(sFecha) = 0 Then
                    sFecha = Date.Today
                    LocalAPI.GetWeeklyDates(sFecha, sFechaDes, sFechaHas, lblCompanyId.Text)
                Else
                    sFechaDes = sFecha
                    sFechaHas = DateAdd(DateInterval.Day, 14, CDate(sFechaDes))
                End If
                EstablecerFechas(sFechaDes, sFechaHas)

                RefreshDataSource()

            End If
            If RadWindowManagerJob.Windows.Count > 0 Then
                RadWindowManagerJob.Windows.Clear()
            End If
        Catch ex As Exception
        End Try

    End Sub

    Private Sub EstablecerFechas(sFechaDes As String, sFechaHas As String)
        RadDatePickerFrom.SelectedDate = sFechaDes
        RadDatePickerTo.SelectedDate = sFechaHas
        If RadDatePickerFrom.SelectedDate.Value.Month = RadDatePickerTo.SelectedDate.Value.Month Then
            RadGrid1.MasterTableView.Caption = RadDatePickerFrom.SelectedDate.Value.ToString("MMMM")
        Else
            RadGrid1.MasterTableView.Caption = RadDatePickerFrom.SelectedDate.Value.ToString("MMMM") &
                        " -- " & RadDatePickerTo.SelectedDate.Value.ToString("MMMM")
        End If
    End Sub

    Private Sub RefreshDataSource()
        RadGrid1.DataBind()
    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        Dim sFecha As String = DateAdd(DateInterval.Day, -7, RadDatePickerFrom.SelectedDate.Value)
        Dim sFechaDes As String
        Dim sFechaHas As String

        LocalAPI.GetWeeklyDates(sFecha, sFechaDes, sFechaHas, lblCompanyId.Text)

        EstablecerFechas(sFechaDes, sFechaHas)
        RefreshDataSource()
    End Sub

    Protected Sub btnNext_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNext.Click
        Dim sFecha As String = DateAdd(DateInterval.Day, 7, RadDatePickerTo.SelectedDate.Value)
        Dim sFechaDes As String
        Dim sFechaHas As String

        LocalAPI.GetWeeklyDates(sFecha, sFechaDes, sFechaHas, lblCompanyId.Text)

        EstablecerFechas(sFechaDes, sFechaHas)
        RefreshDataSource()
    End Sub
    Protected Sub cboEmployee_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles cboEmployee.SelectedIndexChanged
        RefreshDataSource()
    End Sub
    Private Sub RadGrid1_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles RadGrid1.ItemDataBound
        Dim D0 As DateTime = RadDatePickerTo.SelectedDate
        Dim Day As Integer = D0.Day
        If TypeOf e.Item Is GridHeaderItem Then
            Dim header As GridHeaderItem = CType(e.Item, GridHeaderItem)
            For i = 0 To 13
                Dim sDay As String = WeekdayName(Weekday(D0), True, 1)
                header("D" & i).Text = sDay & "-" & Day
                D0 = DateAdd(DateInterval.Day, -1, D0)
                Day = D0.Day
            Next
        End If
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditJob"
                sUrl = LocalAPI.GetSharedLink_URL(8001, e.CommandArgument)
                Response.Redirect(sUrl)

        End Select
    End Sub

    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean, bRefreshOnClose As Boolean)
        Try

            RadWindowManagerJob.Windows.Clear()
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
            RadWindowManagerJob.Windows.Add(window1)
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub RadGrid1_PreRender(sender As Object, e As EventArgs) Handles RadGrid1.PreRender
        Dim D0 As DateTime = RadDatePickerTo.SelectedDate
        For i = 0 To 13
            Dim sDay As String = WeekdayName(Weekday(D0), True, 1)
            RadGrid1.MasterTableView.GetColumn("D" & i).HeaderText = sDay
            D0 = DateAdd(DateInterval.Day, -1, D0)
        Next
    End Sub

    Private Sub RadDatePickerFrom_SelectedDateChanged(sender As Object, e As SelectedDateChangedEventArgs) Handles RadDatePickerFrom.SelectedDateChanged
        EstablecerFechas(RadDatePickerFrom.DbSelectedDate, DateAdd(DateInterval.Day, 14, RadDatePickerFrom.DbSelectedDate))
        RefreshDataSource()
    End Sub

End Class
