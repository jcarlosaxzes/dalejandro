﻿Public Class payments
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_BillingManager") Then Response.RedirectPermanent("~/ADM/Default.aspx")
                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Payments"
                Master.PageTitle = "Billing/Payments"

                lblCompanyId.Text = Session("companyId")

                RadDatePickerFrom.DbSelectedDate = Date.Today.Month & "/01/" & Date.Today.Year
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, RadDatePickerTo.DbSelectedDate)

                PanelUpload.Visible = LocalAPI.IsAzureStorage(lblCompanyId.Text)

            End If

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub RadGridPayments_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridPayments.ItemCommand
        Select Case e.CommandName

            Case "EditPayment"
                lblPaymentId.Text = e.CommandArgument
                If lblPaymentId.Text > 0 Then
                    FormViewPayment.DataBind()
                    RadToolTipEditPayment.Visible = True
                    RadToolTipEditPayment.Show()
                End If

            Case "DeletePayment"
                lblPaymentId.Text = e.CommandArgument
                If lblPaymentId.Text > 0 Then
                    SqlDataSourcePayment.Delete()
                    RadGridPayments.DataBind()
                    Master.InfoMessage("Payment deleted!")
                End If
        End Select

    End Sub
    Private Sub btnUpdatePayment_Click(sender As Object, e As EventArgs) Handles btnUpdatePayment.Click
        FormViewPayment.UpdateItem(True)
        RadGridPayments.DataBind()
        RadToolTipEditPayment.Visible = False
        Master.InfoMessage("Payment updated!")
    End Sub

    Private Sub btnCancelUpdatePayment_Click(sender As Object, e As EventArgs) Handles btnCancelUpdatePayment.Click
        RadToolTipEditPayment.Visible = False
    End Sub

    Protected Sub RadCloudUpload1_FileUploaded(sender As Object, e As Telerik.Web.UI.CloudFileUploadedEventArgs)
        Try
            lblOriginalFileName.Text = e.FileInfo.OriginalFileName
            lblKeyName.Text = e.FileInfo.KeyName
            lblContentBytes.Text = e.FileInfo.ContentLength
            lblContentType.Text = e.FileInfo.ContentType
        Catch ex As Exception
            e.IsValid = False
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub
End Class
