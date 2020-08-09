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
End Class