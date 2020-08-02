Imports System.IO
Imports Microsoft.VisualBasic.FileIO
Imports Telerik.Web.UI
Public Class paiddaylist
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_PayrollCalendar") Then Response.RedirectPermanent("~/ADM/Default.aspx")

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
                SqlDataSource5.DataBind()
                RadGrid1.DataBind()
                Master.InfoMessage("Payroll Closing Date inserted")
                RadDatePicker1.Clear()
            Else
                Master.ErrorMessage("Select a Payroll Closing Date", 0)
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnAddHourlyWage_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddHourlyWage.Click
        RadGridHourlyWage.MasterTableView.InsertItem()
    End Sub

    Protected Sub btnImport_Click(sender As Object, e As EventArgs) Handles btnImport.Click

        ImportData()

    End Sub

    Private Sub ImportData()
        Try

            If RadUpload1.UploadedFiles.Count > 0 Then
                Dim SalaryDate As String
                Dim SalaryNet As Double
                Dim SalaryGross As Double = 0
                Dim TotalCost As Double = 0
                Dim Hours As Double = 0
                Dim employeeId As Integer
                Dim EmployeeRef As String
                Dim StreamerObject As Stream = RadUpload1.UploadedFiles(0).InputStream
                Using parser As TextFieldParser = New TextFieldParser(StreamerObject)

                    ' 1ra fila es cabecera "Check Date,Name,Net Amount,Total Hours,Gross Amount"
                    parser.TextFieldType = FieldType.Delimited
                    parser.SetDelimiters(",")
                    Dim iField As Integer
                    Dim fields As String() = parser.ReadFields()
                    Dim currentRow As String()

                    If Not fields Is Nothing Then
                        While Not parser.EndOfData
                            currentRow = parser.ReadFields()
                            iField = 0
                            SalaryGross = 0
                            Dim currentField As String
                            For Each currentField In currentRow

                                Select Case iField
                                    Case 0
                                        SalaryDate = currentField
                                    Case 1
                                        ' Employee Name
                                        EmployeeRef = "" & currentField
                                        employeeId = LocalAPI.GetEmployeeIdFromLastNameCommaFirstName(EmployeeRef, lblCompanyId.Text)
                                    Case 2
                                        ' Net Amount
                                        SalaryNet = LocalAPI.GetAmount(currentField)
                                    Case 3
                                        ' Total Hours
                                        Hours = currentField
                                    Case 4
                                        ' Gross Amount
                                        SalaryGross = LocalAPI.GetAmount(currentField)
                                    Case 5
                                        ' Total Cost
                                        TotalCost = LocalAPI.GetAmount(currentField)
                                End Select
                                iField = iField + 1
                            Next
                            If employeeId > 0 Then
                                ' Insert Line
                                LocalAPI.NewPayroll(employeeId, SalaryDate, SalaryNet, Hours, SalaryGross, TotalCost, EmployeeRef, lblCompanyId.Text)
                            End If

                        End While
                    End If
                End Using

                RadGridPayroll.DataBind()
                RadUpload1.UploadedFiles.Clear()

            End If
        Catch ex As Exception
            RadUpload1.UploadedFiles.Clear()
        End Try

    End Sub

    Private Sub RadScheduler1_NavigationCommand(sender As Object, e As SchedulerNavigationCommandEventArgs) Handles RadScheduler1.NavigationCommand
        If e.Command = SchedulerNavigationCommand.SwitchToSelectedDay Then
            RadDatePicker1.DbSelectedDate = RadScheduler1.SelectedDate
            btnImport.Focus()
            e.Cancel = True
        End If
    End Sub

    Private Sub RadGridHourlyWage_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles RadGridHourlyWage.ItemDataBound
        Try

            'If e.Item.ItemType = GridItemType.Item OrElse e.Item.ItemType = GridItemType.AlternatingItem Then
            '    Dim item As GridDataItem = TryCast(e.Item, GridDataItem)
            '    Dim chart As RadHtmlChart = TryCast(item("ChartColumn").FindControl("RadHtmlChart1"), RadHtmlChart)
            '    Dim Id As Integer = item.GetDataKeyValue("Id").ToString()
            '    SqlDataSourceChart.SelectParameters("employeeId").DefaultValue = LocalAPI.GetEmployee_HourlyWageHistoryProperty(Id, "employeeId")
            '    chart.DataSource = SqlDataSourceChart.[Select](DataSourceSelectArguments.Empty)
            '    If (TryCast(chart.DataSource, DataView)).Count > 0 Then
            '        'If SqlDataSourceChart.SelectParameters("departmentId").DefaultValue>0 And employeeId>0 then
            '        chart.DataBind()
            '    Else
            '        chart.Visible = False
            '        item("ChartColumn").Controls.Add(New LiteralControl("This employee has no info."))
            '    End If
            'End If
        Catch ex As Exception

        End Try
    End Sub

    Private Sub cboDepartments_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboDepartments.SelectedIndexChanged
        cboEmployees.Items.Clear()
        cboEmployees.Items.Insert(0, New RadComboBoxItem("(Select Employee...)", -1))
        cboEmployees.DataBind()
    End Sub

    Private Sub btnInitialize_Click(sender As Object, e As EventArgs) Handles btnInitialize.Click
        SqlDataSource1.Insert()
        RadGridHourlyWage.DataBind()
    End Sub
    Private Sub btnInicializeCalendar_Click(sender As Object, e As EventArgs) Handles btnInicializeCalendar.Click
        Dim dDate As DateTime = LocalAPI.GetLastPaidDay(lblCompanyId.Text)

        While dDate.Year <= cboYear.SelectedValue
            dDate = DateAdd(DateInterval.Day, 14, dDate)
            LocalAPI.NuevoPaidDay(dDate, lblCompanyId.Text)
        End While
        RadGrid1.DataBind()
        Master.InfoMessage("Payroll Calendar was Inicialized!!!")

    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        RadGridHourlyWage.DataBind()
        Master.InfoMessage("Payroll Initialized")
    End Sub
End Class
