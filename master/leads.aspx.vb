Imports System.IO
Imports Microsoft.VisualBasic.FileIO
Imports Telerik.Web.UI

Public Class leads
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If Not IsPostBack Then
                RadGrid1.DataBind()
            End If
        Catch ex As Exception
            Master.ErrorMessage = ex.Message
        End Try
    End Sub

    Private Sub btnFind_Click(sender As Object, e As EventArgs) Handles btnFind.Click
        RadGrid1.DataBind()
    End Sub

    Private Sub SqlDataSource1_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSource1.Selecting
        ' Dim e1 As String = e.Command.Parameters(0).Value
    End Sub

    Private Sub SqlDataSource1_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Selected
        'lblSELECTed_ID.Text = e.Command.Parameters("@SELECTed_ID").Value
    End Sub
    Private Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
        Try

            RadToolTipExport.Visible = True
            'txtExportTag.Text = txtState.Text & txtZipCode.Text & txtPhone.Text & txtCity.Text
            RadToolTipExport.Show()
            txtExportTag.Focus()
        Catch ex As Exception
            Master.ErrorMessage = ex.Message
        End Try
    End Sub

    Private Sub btnConfirmExport_Click(sender As Object, e As EventArgs) Handles btnConfirmExport.Click
        ConfigureExport()
        RadGrid1.MasterTableView.ExportToCSV()

        If Len(txtExportTag.Text) > 0 Then
            ' Update
            SqlDataSource1.Update()
        End If
    End Sub

    Private Sub ConfigureExport()
        RadGrid1.AllowPaging = False
        RadGrid1.ExportSettings.FileName = "PASconcept_Leads_" & DateTime.Today.ToString("yyyy-MM-dd")
        RadGrid1.ExportSettings.ExportOnlyData = True
        RadGrid1.ExportSettings.IgnorePaging = True
        RadGrid1.ExportSettings.OpenInNewWindow = True
        RadGrid1.ExportSettings.UseItemStyles = False
        RadGrid1.ExportSettings.HideStructureColumns = True
        RadGrid1.MasterTableView.ShowFooter = True
    End Sub

    Private Sub btnBulkTag_Click(sender As Object, e As EventArgs) Handles btnBulkTag.Click
        RadToolTipTagSelected.Visible = True
        'txtBulkTag.Text = txtState.Text & txtZipCode.Text & txtPhone.Text & txtCity.Text
        RadToolTipTagSelected.Show()
        txtExportTag.Focus()

        ' Tres cambios
        '2. Clasificar SourcesId
        '3. Add Source Filter
        '4. Send Agile

    End Sub
    Private Sub btnBulkTagConfirm_Click(sender As Object, e As EventArgs) Handles btnBulkTagConfirm.Click
        If RadGrid1.SelectedItems.Count > 0 Then
            Dim nSelecteds As Integer = RadGrid1.SelectedItems.Count
            For Each dataItem As GridDataItem In RadGrid1.SelectedItems

                If dataItem.Selected Then
                    lblSelected_ID.Text = dataItem("Id").Text
                    dataItem.Selected = False
                    SqlDataSource1.Insert()
                End If
            Next
            RadGrid1.DataBind()
        Else
            Master.ErrorMessage = "You must to select records previously!"
        End If
    End Sub

    Private Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Select Case e.CommandName
            Case "EditLead"
                lblSelected_ID.Text = e.CommandArgument
                FormView1.DataBind()
                RadToolTipLead.Visible = True
                RadToolTipLead.Show()
        End Select
    End Sub

    Private Sub btnUpdateContact_Click(sender As Object, e As EventArgs) Handles btnUpdateContact.Click
        FormView1.UpdateItem(True)
        RadGrid1.DataBind()
    End Sub

    Private Sub ImportLeads()
        Try
            'Company Expenses
            If RadUpload1.UploadedFiles.Count > 0 Then

                ' declare CsvDataReader object which will act as a source for data for SqlBulkCopy
                Dim StreamerObject As Stream = RadUpload1.UploadedFiles(0).InputStream
                Dim nRecs As Integer

                Using parser As TextFieldParser = New TextFieldParser(StreamerObject)

                    ' 1ra fila es cabecera 
                    ' Company,FirstName,LastName,Email,Phone,Cellular,Website,AddressLine1,AddressLine2,City,State,ZipCode,JobTitle,Position,Tags
                    parser.TextFieldType = FieldType.Delimited
                    parser.SetDelimiters(",")
                    Dim iField As Integer
                    Dim fields As String() = parser.ReadFields()
                    Dim currentRow As String()
                    Dim bIsValidDataRow As Boolean
                    Dim LeadObject As LocalAPI.LeadStruct
                    LeadObject.SourceId = cboSourceImport.SelectedValue

                    If Not fields Is Nothing Then
                        While Not parser.EndOfData
                            currentRow = parser.ReadFields()
                            iField = 0
                            Dim currentField As String
                            For Each currentField In currentRow

                                Select Case iField

                                    Case 0  'Company
                                        LeadObject.Company = "" & currentField
                                        bIsValidDataRow = True

                                    Case 1  'FirstName
                                        If Len("" & currentField) > 0 Then
                                            LeadObject.FirstName = currentField
                                            bIsValidDataRow = True
                                        Else
                                            bIsValidDataRow = False
                                        End If

                                    Case 2  'LastName
                                        LeadObject.LastName = "" & currentField

                                    Case 3  'Email
                                        If Len("" & currentField) > 0 Then
                                            LeadObject.Email = currentField
                                            bIsValidDataRow = True
                                        Else
                                            bIsValidDataRow = False
                                        End If

                                    Case 4  'Phone
                                        LeadObject.Phone = "" & currentField
                                    Case 5  'Cellular
                                        LeadObject.Cellular = "" & currentField
                                    Case 6  'Website
                                        LeadObject.Website = "" & currentField
                                    Case 7  'AddressLine1
                                        LeadObject.AddressLine1 = "" & currentField
                                    Case 8  'AddressLine2
                                        LeadObject.AddressLine2 = "" & currentField
                                    Case 9  'City
                                        LeadObject.City = "" & currentField
                                    Case 10  'State
                                        LeadObject.State = "" & currentField
                                    Case 11  'ZipCode
                                        LeadObject.ZipCode = "" & currentField
                                    Case 12  'JobTitle
                                        LeadObject.JobTitle = "" & currentField
                                    Case 13  'Position
                                        LeadObject.Position = "" & currentField
                                    Case 14 'Tags
                                        LeadObject.Tags = "" & currentField
                                        Exit For
                                End Select
                                If bIsValidDataRow Then
                                    iField = iField + 1
                                Else
                                    Exit For
                                End If
                            Next

                            If bIsValidDataRow Then
                                LocalAPI.NewPASconceptLead(LeadObject)
                                nRecs = nRecs + 1

                            End If

                        End While
                    End If
                End Using

                RadUpload1.UploadedFiles.Clear()

            End If
        Catch ex As Exception
            Master.ErrorMessage = ex.Message
        End Try
    End Sub

    Private Sub btnConfirmImport_Click(sender As Object, e As EventArgs) Handles btnConfirmImport.Click
        ImportLeads()
        cboSource.SelectedValue = cboSourceImport.SelectedValue
        RadGrid1.DataBind()
    End Sub

    Private Sub btnImport_Click(sender As Object, e As EventArgs) Handles btnImport.Click
        RadToolTipImport.Visible = True
        RadToolTipImport.Show()
    End Sub
End Class