Imports System.IO
Imports Microsoft.VisualBasic.FileIO
Imports Telerik.Web.UI
Public Class paiddaylist
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_PayrollCalendar") Then Response.RedirectPermanent("~/adm/default.aspx")

            Master.PageTitle = "Employees/Payroll"
            Master.Help = "http://blog.pasconcept.com/2012/07/employees-payroll-calendar.html"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Payroll"
            lblCompanyId.Text = Session("companyId")

            cboYear.DataBind()

            RadGrid1.DataBind()
        End If
    End Sub

    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsert.Click
        Try
            If RadDatePicker1.SelectedDate.HasValue Then
                LocalAPI.NuevoPaidDay(RadDatePicker1.SelectedDate, lblCompanyId.Text)
                RefreshData()
                Master.InfoMessage("Payroll Closing Date inserted")
                RadDatePicker1.Clear()
            Else
                Master.ErrorMessage("Select a Payroll Closing Date", 0)
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub RefreshData()
        RadGrid1.DataBind()
        RadScheduler1.DataBind()
        RadScheduler1.Rebind()

    End Sub

    Private Sub RadScheduler1_NavigationCommand(sender As Object, e As SchedulerNavigationCommandEventArgs) Handles RadScheduler1.NavigationCommand
        If e.Command = SchedulerNavigationCommand.SwitchToSelectedDay Then
            RadDatePicker1.DbSelectedDate = RadScheduler1.SelectedDate
            e.Cancel = True
        End If
    End Sub
    Private Sub btnInicializeCalendar_Click(sender As Object, e As EventArgs) Handles btnInicializeCalendar.Click

        If LocalAPI.CompanyPayrollCallendar_InitYear(cboYear.SelectedValue, lblCompanyId.Text) Then
            RefreshData()
            Master.InfoMessage("Payroll Calendar was Inicialized!!!")
        End If

    End Sub


End Class
