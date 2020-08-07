Imports Telerik.Web.UI
Public Class timesbyperiords
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Times by Periods"
            If (Not Page.IsPostBack) Then
                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_TimesbyPeriods") Then Response.RedirectPermanent("~/adm/default.aspx")

                Master.PageTitle = "Employees/Times by Periods"
                Master.Help = "http://blog.pasconcept.com/2012/07/employees-periodic-timesheet.html"
                lblCompanyId.Text = Session("companyId")

                IniciaPeriodo(0)

                cboEmployee.DataBind()
                cboEmployee.SelectedValue = Master.UserId

            End If

        Catch ex As Exception
        End Try

    End Sub
    Private Sub EstablecerFechas(sFechaDes As String, sFechaHas As String)
        RadDatePickerFrom.SelectedDate = sFechaDes
        RadDatePickerTo.SelectedDate = sFechaHas

        Select Case cboPeriod.SelectedValue
            Case 0  ' Periods
                If RadDatePickerFrom.SelectedDate.Value.Month = RadDatePickerTo.SelectedDate.Value.Month Then
                    lblMesName.Text = RadDatePickerFrom.SelectedDate.Value.ToString("MMMM")
                Else
                    lblMesName.Text = RadDatePickerFrom.SelectedDate.Value.ToString("MMMM") &
                                " -- " & RadDatePickerTo.SelectedDate.Value.ToString("MMMM")
                End If
            Case 1  ' Meses
                lblMesName.Text = RadDatePickerFrom.SelectedDate.Value.ToString("MMMM")
            Case 2  ' Años
                lblMesName.Text = RadDatePickerFrom.SelectedDate.Value.Year
        End Select

    End Sub

    Private Sub SetFechaMes(sFecha As DateTime, ByRef sFechaDes As String, ByRef sFechaHas As String, nIncremento As Integer)
        If nIncremento = -1 Then
            ' Back
            If sFecha.Month > 1 Then
                sFechaDes = sFecha.Month + nIncremento & "/01/" & sFecha.Year
                sFechaHas = DateAdd(DateInterval.Day, nIncremento, DateAdd(DateInterval.Month, 1, CDate(sFechaDes)))
            Else
                sFechaDes = "12/01/" & sFecha.Year - 1
                sFechaHas = "12/31/" & sFecha.Year - 1
            End If
        Else
            ' Next
            If sFecha.Month < 12 Then
                sFechaDes = sFecha.Month + nIncremento & "/01/" & sFecha.Year
                sFechaHas = DateAdd(DateInterval.Day, -1, DateAdd(DateInterval.Month, 1, CDate(sFechaDes)))
            Else
                sFechaDes = "01/01/" & sFecha.Year + 1
                sFechaHas = "01/31/" & sFecha.Year + 1
            End If
        End If
    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        Dim sFecha As String
        Dim sFechaDes As String
        Dim sFechaHas As String

        Select Case cboPeriod.SelectedValue
            Case 0  ' Periods
                sFecha = DateAdd(DateInterval.Day, -1, RadDatePickerFrom.SelectedDate.Value)
                LocalAPI.GetWeeklyDates(sFecha, sFechaDes, sFechaHas, lblCompanyId.Text)
            Case 1  ' Meses
                SetFechaMes(RadDatePickerFrom.SelectedDate.Value, sFechaDes, sFechaHas, -1)
            Case 2  ' Años
                sFechaDes = "01/01/" & RadDatePickerFrom.SelectedDate.Value.Year - 1
                sFechaHas = "12/31/" & RadDatePickerFrom.SelectedDate.Value.Year - 1
        End Select
        EstablecerFechas(sFechaDes, sFechaHas)
        SqlDataSource1.DataBind()
    End Sub

    Protected Sub btnNext_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNext.Click
        Dim sFecha As String
        Dim sFechaDes As String
        Dim sFechaHas As String

        Select Case cboPeriod.SelectedValue
            Case 0  ' Periods
                sFecha = DateAdd(DateInterval.Day, 1, RadDatePickerTo.SelectedDate.Value)
                LocalAPI.GetWeeklyDates(sFecha, sFechaDes, sFechaHas, lblCompanyId.Text)
            Case 1  ' Meses
                SetFechaMes(RadDatePickerFrom.SelectedDate.Value, sFechaDes, sFechaHas, 1)
            Case 2  ' Años
                sFechaDes = "01/01/" & RadDatePickerFrom.SelectedDate.Value.Year + 1
                sFechaHas = "12/31/" & RadDatePickerFrom.SelectedDate.Value.Year + 1
        End Select

        EstablecerFechas(sFechaDes, sFechaHas)
        SqlDataSource1.DataBind()
    End Sub


    Private Sub IniciaPeriodo(nPeriodo As Integer)
        Dim sFecha As String
        Dim sFechaDes As String
        Dim sFechaHas As String

        Select Case nPeriodo
            Case 0  ' Periods
                sFecha = Date.Today
                LocalAPI.GetWeeklyDates(sFecha, sFechaDes, sFechaHas, lblCompanyId.Text)
            Case 1  ' Meses
                sFechaDes = RadDatePickerFrom.SelectedDate.Value.Month & "/01/" & RadDatePickerFrom.SelectedDate.Value.Year
                sFechaHas = DateAdd(DateInterval.Day, -1, DateAdd(DateInterval.Month, 1, CDate(sFechaDes)))
            Case 2  ' Años
                sFechaDes = "01/01/" & RadDatePickerFrom.SelectedDate.Value.Year
                sFechaHas = "12/31/" & RadDatePickerFrom.SelectedDate.Value.Year
        End Select
        EstablecerFechas(sFechaDes, sFechaHas)
        SqlDataSource1.DataBind()

    End Sub

    Protected Sub cboPeriod_SelectedIndexChanged(sender As Object, e As DropDownListEventArgs) Handles cboPeriod.SelectedIndexChanged
        IniciaPeriodo(cboPeriod.SelectedValue)
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.ItemCommand

        Select Case e.CommandName
            Case 1, 3, 4, 5, 6, 7, 8  'NonRegularHours_types Id
                cboEmployee.SelectedValue = e.CommandArgument
                ShowNewMiscellaneousTimeDlg(e.CommandName)

            Case 2  'Holiday
                '!!!! ShowNewHolidayDlg(e.CommandName)
            Case "Salary"
                cboEmployee.SelectedValue = e.CommandArgument
                ShowSalaryDlg()
        End Select
    End Sub

    Protected Sub RadGridSalary_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridSalary.ItemCommand
        Select Case e.CommandName
            Case "Update"
                SqlDataSource1.DataBind()
                RadGrid1.DataBind()
        End Select
        '
    End Sub

    Private Sub ShowSalaryDlg()
        RadToolTipSalary.Title = "Salary (<b>" & LocalAPI.GetEmployeeName(cboEmployee.SelectedValue) & "</b>)"
        RadToolTipSalary.Visible = True
        RadToolTipSalary.Show()
    End Sub

    Private Sub ShowNewMiscellaneousTimeDlg(nType As Integer)

        ' Init fields
        Try
            If nType > 0 Then
                cboType.SelectedValue = nType
            End If
        Catch ex As Exception
        End Try

        txtMiscellaneousHours.Text = 1

        RadDatePicker1.DbSelectedDate = Date.Today
        RadDatePicker2.DbSelectedDate = Date.Today

        txtNotes.Text = ""

        Dim dFrom As DateTime = Year(RadDatePicker1.DbSelectedDate) & "-01-01"
        Dim dTo As DateTime = Year(RadDatePicker1.DbSelectedDate) & "-12-31 23:59"
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
        RadToolTipMiscellaneous.Title = "New Miscellaneous Time (<b>" & LocalAPI.GetEmployeeName(cboEmployee.SelectedValue) & "</b>)"
        RadToolTipMiscellaneous.Visible = True
        RadToolTipMiscellaneous.Show()
        cboType.Focus()

    End Sub

    Protected Sub btnOkNewMiscellaneousTime_Click(sender As Object, e As EventArgs) Handles btnOkNewMiscellaneousTime.Click
        Try
            If LocalAPI.NewNonJobTime(cboEmployee.SelectedValue, cboType.SelectedValue, RadDatePicker1.SelectedDate, RadDatePicker2.SelectedDate, txtMiscellaneousHours.Text, txtNotes.Text) Then
                RadToolTipMiscellaneous.Visible = False
                SqlDataSource1.DataBind()
                RadGrid1.DataBind()
                Master.InfoMessage("New time inserted")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub SqlDataSourceSalary_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceSalary.Inserting
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub
End Class

