﻿Imports Telerik.Web.UI
Public Class Job_times
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblJobId.Text = Request.QueryString("JobId")
            End If


        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Private Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.ItemCommand

        Select Case e.CommandName

            Case "NewHrInvoice"
                lblTimeId.Text = e.CommandArgument
                txtTimeSel.DbValue = LocalAPI.GetTimeProperty(lblTimeId.Text, "Time")
                txtRate.DbValue = LocalAPI.GetTimeProperty(lblTimeId.Text, "HourRate")
                txtTimeDescription.Text = LocalAPI.GetTimeProperty(lblTimeId.Text, "Description")
                ConfirmInsertDlg("New Invoice", "Create New (hr) Invoice from Time record")

            Case "DeleteHrInvoice"
                lblInvoiceSelected.Text = e.CommandArgument
                ConfirmDeleteDlg("Delete Invoice", "Delete (hr) Invoice Number " & LocalAPI.GetInvoiceProperty(e.CommandArgument, "InvoiceNumber"))

        End Select

    End Sub

    Private Sub ConfirmInsertDlg(Title As String, Text As String)
        RadToolTipConfirmInsert.Title = Title
        lblActionMesage.Text = Text & "<br /><br />Are you sure to do this action?<br /><br />"
        btnOk.Text = Title
        RadToolTipConfirmInsert.Visible = True
        RadToolTipConfirmInsert.Show()
    End Sub

    Private Sub ConfirmDeleteDlg(Title As String, Text As String)
        RadToolTipConfirmDelete.Title = Title
        lblActionMesage2.Text = Text & "<br /><br />Are you sure to do this action?<br /><br />"
        btnOk2.Text = Title
        RadToolTipConfirmDelete.Visible = True
        RadToolTipConfirmDelete.Show()
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        RadToolTipConfirmInsert.Visible = False
    End Sub
    Protected Sub btnCancel2_Click(sender As Object, e As EventArgs) Handles btnCancel2.Click
        RadToolTipConfirmDelete.Visible = False
    End Sub

    Protected Sub btnOk_Click(sender As Object, e As EventArgs) Handles btnOk.Click
        Try

            Dim jobId As Integer = LocalAPI.GetTimeProperty(lblTimeId.Text, "Job")
            LocalAPI.NuevoInvoiceHourlyRate(lblTimeId.Text, jobId, txtTimeSel.DbValue, txtRate.DbValue, txtTimeDescription.Text)
            SqlDataSource1.DataBind()

            RadGrid1.DataBind()

            RadToolTipConfirmInsert.Visible = False

        Catch ex As Exception
            RadToolTipConfirmInsert.Visible = False
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub btnOk2_Click(sender As Object, e As EventArgs) Handles btnOk2.Click
        Try

            SqlDataSource1.Delete()
            SqlDataSource1.DataBind()

            RadGrid1.DataBind()

            RadToolTipConfirmDelete.Visible = False

        Catch ex As Exception
            RadToolTipConfirmDelete.Visible = False
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub


    Private Sub ConfigureExport(sFileName As String)
        RadGridExportData.ExportSettings.FileName = sFileName & "_Times_" & DateTime.Today.ToString("yyyy-MM-dd")
        RadGridExportData.ExportSettings.ExportOnlyData = True
        RadGridExportData.ExportSettings.IgnorePaging = True
        RadGridExportData.ExportSettings.OpenInNewWindow = True
        RadGridExportData.ExportSettings.UseItemStyles = False
        RadGridExportData.ExportSettings.HideStructureColumns = True
        RadGridExportData.MasterTableView.ShowFooter = True
    End Sub

    Private Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
        ConfigureExport(LocalAPI.GetJobCodeName(lblJobId.Text))
        RadGridExportData.MasterTableView.ExportToCSV()
    End Sub
End Class
