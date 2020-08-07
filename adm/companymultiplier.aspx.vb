Imports Telerik.Web.UI
Public Class companymultiplier
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If Not IsPostBack() Then
                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Multiplier") Then Response.RedirectPermanent("~/adm/default.aspx")

                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Company Multiplier"
                Master.PageTitle = "Company/Multiplier"
                lblCompanyId.Text = Session("companyId")

                cboYear.DataBind()
                cboYear.SelectedValue = Year(Now())

                SqlDataSourceDptoTarget.DataBind()
                'ReadCompanyRates()
                cboMonthSalary.DataBind()
                cboMonthSalary.SelectedValue = Month(Today)

            End If
            RadWindowManager1.EnableViewState = False
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub btnCalculateMultiplier_Click(sender As Object, e As EventArgs) Handles btnCalculateMultiplier.Click
        txtMultiplierYear.Text = cboYear.SelectedValue
        If cboYear.SelectedValue = Year(Today) Then
            cboMonth.SelectedValue = Month(Today)
        Else
            cboMonth.SelectedValue = 1
        End If

        RadToolTipCalculateMultiplier.Visible = True
        RadToolTipCalculateMultiplier.Show()
    End Sub

    Private Sub btnNewMultiplier_Click(sender As Object, e As EventArgs) Handles btnNewMultiplier.Click
        RadGridMultiplier.MasterTableView.InsertItem()
    End Sub

    Private Sub btnInitialize_Click(sender As Object, e As EventArgs) Handles btnInitialize.Click
        txtInitializeYear.Text = cboYear.SelectedValue
        RadToolTipInitialize.Visible = True
        RadToolTipInitialize.Show()
    End Sub

    Private Sub btnInitializeOk_Click(sender As Object, e As EventArgs) Handles btnInitializeOk.Click
        Try
            SqlDataSourceEmployees.Insert()
            cboYear.SelectedValue = txtInitializeYear.Text
            Master.InfoMessage("Hourly Wage for Selected Year Updated for " & txtInitializeYear.Text)
            RadGridHourlyWage.DataBind()
        Catch ex As Exception

        End Try
    End Sub

    Private Sub btnCalculateMultiplierOk_Click(sender As Object, e As EventArgs) Handles btnCalculateMultiplierOk.Click
        If txtMultiplierYear.Text > 1999 Then
            LocalAPI.CompanyCalculateMultiplier(lblCompanyId.Text, txtMultiplierYear.Text)
            Dim dbMultiplier As Double = LocalAPI.GetCompanyMultiplier(lblCompanyId.Text, cboYear.SelectedValue)
            LocalAPI.DeparmentBudgetByBaseSalaryForMultiplierFromThisMonth(lblCompanyId.Text, dbMultiplier, cboYear.SelectedValue, cboMonth.SelectedValue)
            RadGridMultiplier.DataBind()
            RadGridDptoTarget.DataBind()
            Master.InfoMessage("Multiplier Updated for " & txtMultiplierYear.Text)
        Else
            Master.ErrorMessage("Define Year before Calculate")
        End If
    End Sub

    Private Sub RadGridHourlyWage_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridHourlyWage.ItemCommand
        Select Case e.CommandName
            Case "EditHourlyWage"
                CreateRadWindows(e.CommandName, "~/ADM/Employee_HourlyWageHistory.aspx?employeeId=" & e.CommandArgument & "&year=" & cboYear.SelectedValue, 850, 700, "OnClientClose")
        End Select

    End Sub
    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, onClose As String)
        RadWindowManager1.Windows.Clear()
        Dim window1 As RadWindow = New RadWindow()
        window1.NavigateUrl = sUrl
        window1.VisibleOnPageLoad = True
        window1.VisibleStatusbar = False
        window1.ID = WindowsID
        'window1.InitialBehaviors = WindowBehaviors.Maximize
        window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
        window1.Width = Width
        window1.Height = Height
        window1.Modal = True
        If Len(onClose) > 0 Then window1.OnClientClose = onClose
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Private Sub RadGridMonthlySalaryCalculation_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridMonthlySalaryCalculation.ItemCommand
        Select Case e.CommandName
            Case "EditHourlyWage"
                CreateRadWindows(e.CommandName, "~/ADM/Employee_HourlyWageHistory.aspx?employeeId=" & e.CommandArgument & "&year=" & cboYear.SelectedValue, 850, 700, "OnClientClose1")
        End Select
    End Sub

    Private Sub Refresh()
        RadGridMultiplier.DataBind()
        RadGridDptoTarget.DataBind()
        RadGridHourlyWage.DataBind()
    End Sub

    Private Sub btnFind_Click(sender As Object, e As EventArgs) Handles btnFind.Click
        Refresh()
    End Sub
End Class
