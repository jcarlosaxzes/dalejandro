Imports System.IO
Imports Microsoft.VisualBasic.FileIO
Imports Telerik.Web.UI
Public Class monthlyexpenses
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Expenses") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Company Expenses"
            Master.PageTitle = "Expenses/Company Expenses"


            lblCompanyId.Text = Session("companyId")
            SqlDataSourceYear.DataBind()
            cboYear.DataBind()
            cboYear.SelectedValue = Date.Today.Year
            txtYear.Value = Date.Today.Year
        End If
    End Sub

    Protected Sub btnExpensesImport_Click(sender As Object, e As EventArgs) Handles btnExpensesImport.Click

        If cboImportMode.SelectedValue = 0 Then
            'DELETE before all records for the selected year, and then Import
            SqlDataSourceExpensesUtility.Delete()
        End If

        ImportExpenses()
        Refresh()
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
                                iField = iField + 1
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

        End Try
    End Sub

    Private Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        RadGridExpenses.MasterTableView.InsertItem()
    End Sub

    Private Sub btnFind_Click(sender As Object, e As EventArgs) Handles btnFind.Click
        Refresh()
    End Sub
    Private Sub Refresh()
        Try

            RadGridExpenses.DataBind()
            RadGridMonthly.DataBind()

            'SqlDataSourceGroupByCategory.DataBind()
            'FloatedTilesListView.DataBind()

            If cboYear.SelectedValue > 0 Then
                RadHtmlChartYearly.Visible = False
                RadHtmlChartMonthly.DataBind()
                RadGridMonthly.Visible = True
                RadHtmlChartMonthly.Visible = True
            Else
                RadGridMonthly.Visible = False
                RadHtmlChartMonthly.Visible = False
                RadHtmlChartYearly.DataBind()
                RadHtmlChartYearly.Visible = True
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub SqlDataSourceGroupByCategory_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceGroupByCategory.Selecting
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub



End Class
