Imports System.IO
Imports Microsoft.VisualBasic.FileIO
Imports Telerik.Web.UI
Public Class monthlyexpenses
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Expenses") Then Response.RedirectPermanent("~/adm/schedule.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Company Expenses"
            Master.PageTitle = "Expenses/Company Expenses"


            lblCompanyId.Text = Session("companyId")
            SqlDataSourceYear.DataBind()
            cboYear.DataBind()
            cboYear.SelectedValue = Date.Today.Year
            txtYear.Value = Date.Today.Year
            txtYearPayroll.Value = Date.Today.Year
            cboCategory.DataBind()
            cboCategory.SelectedValue = -1
            cboVendors.DataBind()
            DPFrom.DbSelectedDate = Date.Today.Month & "/01/" & Date.Today.Year
            DPTo.DbSelectedDate = DateAdd(DateInterval.Month, 1, DPFrom.DbSelectedDate)
            DPTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, DPTo.DbSelectedDate)
            btnExpensesImportQb.Visible = LocalAPI.IsQuickBookModule(lblCompanyId.Text)
            Refresh()
        End If
    End Sub
    Private Sub btnFind_Click(sender As Object, e As EventArgs) Handles btnFind.Click
        Refresh()
    End Sub
    Private Sub Refresh()
        Try

            RadGridExpenses.DataBind()
            RadGridPayroll.DataBind()
            RadGridMonthly.DataBind()

            ' Genera error on Binding.... FloatedTilesListView.DataBind()

            RadHtmlChartMonthly.DataBind()
            RadHtmlChartYearly.DataBind()

            cboImportMode.SelectedValue = -1
            cboImportPayrollMode.SelectedValue = -1

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub



#Region "Expenses"
    Protected Sub btnExpensesImport_Click(sender As Object, e As EventArgs) Handles btnExpensesImport.Click
        Try
            If cboImportMode.SelectedValue <> -1 Then

                If cboImportMode.SelectedValue = 0 Then
                    'DELETE before all records for the selected year, and then Import
                    SqlDataSourceExpensesUtility.Delete()
                End If

                ImportExpenses()
                cboYear.SelectedValue = txtYear.Text
                Refresh()

            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub ImportExpenses()
        Try
            'Company Expenses
            If RadUploadExpenses1.UploadedFiles.Count > 0 Then

                ' declare CsvDataReader object which will act as a source for data for SqlBulkCopy
                Dim StreamerObject As Stream = RadUploadExpenses1.UploadedFiles(0).InputStream
                Dim nRecs As Integer

                Using parser As TextFieldParser = New TextFieldParser(StreamerObject)

                    ' 1ra fila es cabecera 
                    ' Date,Type,No.,Payee,Category,Memo,Total
                    parser.TextFieldType = FieldType.Delimited
                    parser.SetDelimiters(",")
                    Dim iField As Integer
                    Dim fields As String() = parser.ReadFields()
                    Dim currentRow As String()
                    Dim bIsValidDataRow As Boolean
                    Dim ExpDate As Date
                    Dim ExpType As String
                    Dim Reference As String
                    Dim Amount As Double
                    Dim Category As String
                    Dim Memo As String
                    Dim Vendor As String

                    If Not fields Is Nothing Then
                        While Not parser.EndOfData
                            currentRow = parser.ReadFields()
                            iField = 0
                            Dim currentField As String
                            For Each currentField In currentRow

                                Select Case iField

                                    Case 0  'Date
                                        If Len("" & currentField) > 0 Then
                                            ExpDate = currentField
                                            bIsValidDataRow = True
                                        Else
                                            bIsValidDataRow = False
                                        End If

                                    Case 1  'Type
                                        ExpType = "" & currentField

                                    Case 2  'No.
                                        Reference = "" & currentField

                                    Case 3  ' Payee
                                        Vendor = "" & currentField

                                    Case 4  ' Category
                                        Category = "" & currentField

                                    Case 5  'Memo
                                        Memo = "" & currentField

                                    Case 6 'Total
                                        Amount = LocalAPI.GetAmount(currentField)
                                        Exit For
                                End Select
                                If bIsValidDataRow Then
                                    iField = iField + 1
                                Else
                                    Exit For
                                End If
                            Next

                            If bIsValidDataRow Then
                                LocalAPI.NewExpense(lblCompanyId.Text, ExpDate, ExpType, Reference, Amount, Category, Vendor, Memo)
                                nRecs = nRecs + 1

                            End If

                        End While
                    End If
                End Using

                RadUploadExpenses1.UploadedFiles.Clear()

            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub btnAddExpense_Click(sender As Object, e As EventArgs) Handles btnAddExpense.Click
        RadWizardStepExpenses.Active = True
        RadGridExpenses.MasterTableView.InsertItem()
    End Sub

    Private Sub SqlDataSourceExpenses_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceExpenses.Updated
        Refresh()
    End Sub

    Private Sub SqlDataSourceExpenses_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceExpenses.Inserted
        Refresh()
    End Sub

    Private Sub SqlDataSourceExpenses_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceExpenses.Deleted
        Refresh()
    End Sub

#End Region

#Region "Payroll"
    Private Sub btnImportPayroll_Click(sender As Object, e As EventArgs) Handles btnImportPayroll.Click
        Try
            If cboImportPayrollMode.SelectedValue <> -1 Then
                If cboImportPayrollMode.SelectedValue = 0 Then
                    'DELETE before all records for the selected year, and then Import
                    SqlDataSourceExpensesUtility.Update()
                End If

                ImportPayroll()
                cboYear.SelectedValue = txtYearPayroll.Text
                Refresh()
                If RadListBoxImportError.Items.Count > 0 Then
                    RadToolTipImport.Visible = True
                    RadToolTipImport.Show()
                End If
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub ImportPayroll()
        Try
            'Company Expenses
            RadListBoxImportError.Items.Clear()

            If RadAsyncUploadPayroll.UploadedFiles.Count > 0 Then

                ' declare CsvDataReader object which will act as a source for data for SqlBulkCopy
                Dim StreamerObject As Stream = RadAsyncUploadPayroll.UploadedFiles(0).InputStream
                Dim nRecs As Integer

                Using parser As TextFieldParser = New TextFieldParser(StreamerObject)

                    ' 1ra fila es cabecera 
                    ' Check Date,Name,Net Amount,,Total Hours,Taxes Withheld,Total Deductions,Total Pay,Employer Taxes,Company Contributions,Total Cost,Check Num
                    parser.TextFieldType = FieldType.Delimited
                    parser.SetDelimiters(",")
                    Dim iField As Integer
                    Dim fields As String() = parser.ReadFields()
                    Dim currentRow As String()
                    Dim bIsValidDataRow As Boolean
                    Dim CheckDate As Date
                    Dim EmployeeName As String
                    Dim employeeId As Integer
                    Dim NetAmount As Double
                    Dim TotalHours As Double
                    Dim TotalPay As Double
                    Dim TotalCost As Double

                    If Not fields Is Nothing Then
                        While Not parser.EndOfData
                            currentRow = parser.ReadFields()
                            iField = 0
                            Dim currentField As String
                            For Each currentField In currentRow

                                Select Case iField

                                    Case 0  'Check Date
                                        If Len("" & currentField) > 0 Then
                                            CheckDate = currentField
                                            bIsValidDataRow = True
                                        Else
                                            bIsValidDataRow = False
                                        End If

                                    Case 1  'Name
                                        EmployeeName = "" & currentField
                                        employeeId = LocalAPI.GetEmployeeIdFromLastNameCommaFirstName(EmployeeName, lblCompanyId.Text)
                                    Case 2 'NetAmount
                                        NetAmount = LocalAPI.GetAmount(currentField)

                                    Case 4  'Total Hours
                                        TotalHours = LocalAPI.GetAmount(currentField)

                                    Case 7  ' TotalPay (Gross)
                                        TotalPay = LocalAPI.GetAmount(currentField)

                                    Case 10 'Total Cost
                                        TotalCost = LocalAPI.GetAmount(currentField)
                                        Exit For
                                End Select
                                If bIsValidDataRow Then
                                    iField = iField + 1
                                Else
                                    Exit For
                                End If

                            Next

                            If bIsValidDataRow Then
                                If employeeId > 0 Then
                                    LocalAPI.NewPayroll(employeeId, CheckDate, NetAmount, TotalHours, TotalPay, TotalCost, EmployeeName, lblCompanyId.Text)
                                    nRecs = nRecs + 1
                                Else
                                    Dim item1 As RadListBoxItem = New RadListBoxItem(EmployeeName & "  Date: " & CheckDate)
                                    RadListBoxImportError.Items.Add(item1)
                                End If

                            End If

                        End While
                    End If
                End Using

                RadAsyncUploadPayroll.UploadedFiles.Clear()

            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub SqlDataSourceExpenses_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceExpenses.Selecting
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub

    Private Sub btbAddPayroll_Click(sender As Object, e As EventArgs) Handles btbAddPayroll.Click
        RadWizardStepPayroll.Active = True
        RadGridPayroll.MasterTableView.InsertItem()
    End Sub

    Private Sub SqlDataSourcePayroll_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourcePayroll.Inserted
        Refresh()
    End Sub

    Private Sub SqlDataSourcePayroll_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourcePayroll.Updated
        Refresh()
    End Sub

    Private Sub SqlDataSourcePayroll_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourcePayroll.Deleted
        Refresh()
    End Sub


#End Region

    Private Sub btnExpensesImportQb_Click(sender As Object, e As EventArgs) Handles btnExpensesImportQb.Click
        RadToolTipQBExpenses.Visible = True
        RadToolTipQBExpenses.Show()
    End Sub

    Private Sub btnImportExpensesQB_Click(sender As Object, e As EventArgs) Handles btnImportExpensesQB.Click
        If qbAPI.IsValidAccessOrRefreshToken(lblCompanyId.Text) Then
            System.Threading.Thread.Sleep(3000)
            If Not IsNothing(DPFrom.DbSelectedDate) And Not IsNothing(DPTo.DbSelectedDate) Then
                qbAPI.LoadQBExpenses(lblCompanyId.Text, DPFrom.DbSelectedDate, DPTo.DbSelectedDate, IIf(chIgnore.Checked, txtIgnore.Text, "IncludeAllNotIgnore"))
                Refresh()
            End If
        Else
            ' New Tab for QB Authentication
            Response.Redirect("~/adm/qb_refreshtoken.aspx?QBAuthBackPage=monthlyexpenses")
        End If
    End Sub

End Class
