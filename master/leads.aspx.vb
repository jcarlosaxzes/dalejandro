﻿Public Class leads
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
            txtExportTag.Text = txtState.Text & txtZipCode.Text & txtZipCode.Text & txtPhone.Text & txtCity.Text
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
End Class