Imports Microsoft.AspNet.Identity
Imports Newtonsoft.Json
Imports PASconcept.DataAccess.Repositories.Abstract
Imports PASconcept.Domain.Model
Imports Telerik.Web.UI
Public Class Job_accounting
    Inherits System.Web.UI.Page


    Private ReadOnly qbOperationLogRepository As IQBOperationLogRepository

    Private ReadOnly invoiceRepository As IInvoiceRepository

    Public Sub New(ByVal qbOperationLogRepository As IQBOperationLogRepository, ByVal invoiceRepo As IInvoiceRepository)
        Me.qbOperationLogRepository = qbOperationLogRepository
        Me.invoiceRepository = invoiceRepo
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then

                lblCompanyId.Text = Session("companyId")

                lblEmployeeEmail.Text = Master.UserEmail
                lblEmployeeId.Text = Master.UserId

                lblJobId.Text = LocalAPI.GetJobIdFromGUID(Request.QueryString("guid"))

                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_BillingMenu") Then
                    Dim sUrl As String = LocalAPI.GetSharedLink_URL(8001, lblJobId.Text)
                    Response.Redirect(sUrl)
                End If


                lblClientId.Text = LocalAPI.GetJobProperty(lblJobId.Text, "Client")

                FormViewStatus.Enabled = LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Allow_InactivateJob")

                Master.ActiveTab(1)

                RadCloudUpload1.MaxFileSize = LocalAPI.GetCompanyMaxFileSizeForUpload(lblCompanyId.Text)
                lblMaxSize.Text = $"[Maximum upload size per file: {LocalAPI.FormatByteSize(RadCloudUpload1.MaxFileSize)}]"

            End If
            RadWindowManager1.EnableViewState = False

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

#Region "Invoices"
    Protected Sub btnInvoice_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInvoice.Click
        Try
            If cboInvoicesType.SelectedValue > 0 Then
                If LocalAPI.GenerateInvoicesSchedules(lblJobId.Text, cboInvoicesType.SelectedValue, lblEmployeeId.Text) Then
                    Master.InfoMessage("The Invoice(s) was inserted.")
                    ' Refrescar el grid
                    cboInvoiceFilterCode.SelectedValue = 0
                    RadGridIncoices.DataBind()
                    UpdateValues()
                Else
                    Master.InfoMessage("The Invoice(s) was not inserted.")
                End If
            Else
                Master.InfoMessage("Select Payment Schedules!!!")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub btnNewInvoice_Click(sender As Object, e As EventArgs) Handles btnNewInvoice.Click
        lblInvoiceId.Text = LocalAPI.NuevoInvoiceSimpleCharge(lblJobId.Text, Date.Today, 0, "", lblEmployeeId.Text)
        InvoiceDlg()
    End Sub

    Protected Sub RadGridIncoices_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridIncoices.ItemCommand
        Try
            Dim sUrl As String = ""
            Select Case e.CommandName

                Case "SendInvoice"
                    sUrl = "~/ADM/SendInvoice.aspx?InvoiceNo=" & e.CommandArgument & "&Origen=1103"
                    CreateRadWindows(e.CommandName, sUrl, 960, 790, False, "OnClientIncoicesClose")


                Case "GetSharedLink"
                    Dim ObjGuid As String = LocalAPI.GetInvoiceProperty(e.CommandArgument, "guid")
                    sUrl = "~/adm/sharelink.aspx?ObjType=4&ObjGuid=" & ObjGuid
                    CreateRadWindows(e.CommandName, sUrl, 520, 400, False, "")

                Case "EditInvoice"
                    lblInvoiceId.Text = e.CommandArgument
                    InvoiceDlg()

                Case "RecivePayment"
                    lblInvoiceId.Text = e.CommandArgument
                    txtAmountPayment.MaxValue = LocalAPI.GetInvoicesAmountDue(lblInvoiceId.Text)
                    txtAmountPayment.DbValue = txtAmountPayment.MaxValue
                    RadDatePickerPayment.DbSelectedDate = LocalAPI.GetDateTime()
                    txtPaymentNotes.Text = ""
                    RadToolTipInsertPayment.Visible = True
                    RadToolTipInsertPayment.Show()

                Case "BadDebt"
                    If LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Allow_BadDebt") Then
                        sUrl = "~/ADM/BadDebt.aspx?invoiceId=" & e.CommandArgument
                        CreateRadWindows(e.CommandName, sUrl, 520, 600, False, "OnClientIncoicesClose")
                    Else
                        Master.ErrorMessage("You do not have permission to Invoice BadDebt!!!")
                    End If

                Case "Duplicate"
                    lblInvoiceId.Text = LocalAPI.Invoice_Duplicate(e.CommandArgument)
                    InvoiceDlg()

                Case "PDF"
                    lblInvoiceId.Text = e.CommandArgument
                    Dim url = LocalAPI.GetSharedLink_URL(4, lblInvoiceId.Text)
                    Session("PrintUrl") = url
                    Session("PrintName") = "Invoice_" & LocalAPI.InvoiceNumber(lblInvoiceId.Text) & ".pdf"
                    Response.Redirect("~/ADM/pdf_print.aspx")

                Case "SendQB"
                    If (LocalAPI.IsQuickBookDesckModule(lblCompanyId.Text)) Then
                        'Mark this Invoice to be Sync with QuickBooks Desktop Web Connector
                        Dim ids As String() = CType(e.CommandArgument, String).Split(",")
                        lblInvoiceId.Text = ids(0)
                        LocalAPI.SetInvoiceQBRef(lblInvoiceId.Text, -1, lblEmployeeId.Text)

                        'Save QB Operation Log
                        Dim invoiceEntity = invoiceRepository.SingleOrDefault(lblInvoiceId.Text)
                        Dim operation As QBOperationLog = New QBOperationLog() With {
                            .LogDate = DateTime.Now,
                            .OperationData = JsonConvert.SerializeObject(invoiceEntity),
                            .OperationType = "Desktop:SyncInvoice",
                            .ResutlStatus = ""
                         }
                        qbOperationLogRepository.Add(operation)
                        qbOperationLogRepository.SaveChanges()

                        RadGridIncoices.Rebind()
                    Else
                        If qbAPI.IsValidAccessToken(lblCompanyId.Text) Then
                            Dim ids As String() = CType(e.CommandArgument, String).Split(",")
                            Dim qbCustomerId As Integer = ids(1)
                            lblInvoiceId.Text = ids(0)
                            qbAPI.SendInvoiceToQuickBooks(lblInvoiceId.Text, qbCustomerId, lblEmployeeId.Text, lblCompanyId.Text)

                            'Save QB Operation Log
                            Dim invoiceEntity = invoiceRepository.SingleOrDefault(lblInvoiceId.Text)
                            Dim operation As QBOperationLog = New QBOperationLog() With {
                                .LogDate = DateTime.Now,
                                .OperationData = JsonConvert.SerializeObject(invoiceEntity),
                                .OperationType = "Online:SyncInvoice",
                                .ResutlStatus = ""
                             }
                            qbOperationLogRepository.Add(operation)
                            qbOperationLogRepository.SaveChanges()

                            RadGridIncoices.Rebind()
                        Else
                            Response.Redirect("~/adm/qb_refreshtoken.aspx?QBAuthBackPage=job_accounting&JobId=" & lblJobId.Text)
                        End If

                    End If
            End Select

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub InvoiceDlg()
        If LocalAPI.GetInvoiceProperty(lblInvoiceId.Text, "InvoiceType") = 3 Then
            ' Progress Invoice
            Response.Redirect($"~/adm/invoicesprogress?jobId={lblJobId.Text}&invoiceId={lblInvoiceId.Text}&backpage=job_accounting")
        Else
            FormViewInvoice.DataBind()
            RadToolTipEditInvoice.Visible = True
            RadToolTipEditInvoice.Show()
        End If
    End Sub

    Private Sub SqlDataSourceInvoices_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceInvoices.Deleting
        Try
            LocalAPI.sys_log_Nuevo(Master.UserEmail, LocalAPI.sys_log_AccionENUM.DeleteInvoice, lblCompanyId.Text, "Delete Invoice: " & LocalAPI.InvoiceNumber(e.Command.Parameters("@Id").Value))
        Catch ex As Exception
        End Try

    End Sub

    Protected Sub SqlDataSourceInvoices_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceInvoices.Deleted
        RadGridIncoices.DataBind()
        UpdateValues()
    End Sub

    Private Sub btnUpdateInvoice_Click(sender As Object, e As EventArgs) Handles btnUpdateInvoice.Click
        RadToolTipEditInvoice.Visible = False
        FormViewInvoice.UpdateItem(True)

        UpdateValues()
        Master.InfoMessage("Invoice updated!")

    End Sub

    Private Sub SqlDataSourceInvoice_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceInvoice.Updated
        RadGridIncoices.DataBind()
        FormViewInvoice.DataBind()

        UpdateValues()

    End Sub

    Private Sub btnCancelInvoice_Click(sender As Object, e As EventArgs) Handles btnCancelInvoice.Click
        RadToolTipEditInvoice.Visible = False
        CleanForm()
    End Sub
    Protected Sub btnInvoice2QB_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim id As Integer = CType(sender, ImageButton).CommandArgument
            If Val(id) > 0 Then
                Master.InfoMessage("Invoice successfully synchronized with QuickBook", 0)
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub RadCloudUpload1_FileUploaded(sender As Object, e As Telerik.Web.UI.CloudFileUploadedEventArgs)
        Try
            Dim tempName = e.FileInfo.KeyName
            Dim fileExt = IO.Path.GetExtension(tempName)
            Dim newName = "Companies/" & lblCompanyId.Text & $"/{Guid.NewGuid().ToString()}" & fileExt
            AzureStorageApi.CopyFile(tempName, newName, lblCompanyId.Text)
            AzureStorageApi.DeleteFile(tempName)

            lblOriginalFileName.Text = e.FileInfo.OriginalFileName
            lblKeyName.Text = newName
            lblContentBytes.Text = e.FileInfo.ContentLength
            lblContentType.Text = e.FileInfo.ContentType
        Catch ex As Exception
            e.IsValid = False
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub CleanForm()
        txtAmountPayment.Value = 0
        txtPaymentNotes.Text = ""
        RadCloudUpload1.UploadedFiles.Clear()
        lblOriginalFileName.Text = ""
        lblKeyName.Text = ""
        lblContentBytes.Text = "0"
        lblContentType.Text = ""
    End Sub

    Private Sub btnDiscount_Click(sender As Object, e As EventArgs) Handles btnDiscount.Click
        RadToolTipInvoicesDiscount.Visible = True
        RadToolTipInvoicesDiscount.Show()
    End Sub

    Private Sub btnApplyDiscount_Click(sender As Object, e As EventArgs) Handles btnApplyDiscount.Click
        If txtDiscountPercent.Value <> 0 Or txtDiscountAmount.Value <> 0 Then
            SqlDataSourceInvoices.Update()
            RadGridIncoices.DataBind()

            UpdateValues()

            Master.InfoMessage("The discount was applied successfully!")
        Else
            Master.ErrorMessage("The discount could not be applied. The Amount or Percent must be different from zero!")
        End If

    End Sub
    Private Sub btnNewProgressInvoice_Click(sender As Object, e As EventArgs) Handles btnNewProgressInvoice.Click
        Response.Redirect("~/adm/invoicesprogress?jobId=" & lblJobId.Text)
    End Sub

#End Region

#Region "Payments"
    Protected Sub btnInsertPayment_Click(sender As Object, e As EventArgs) Handles btnInsertPayment.Click
        SqlDataSourcePayment.Insert()
        UpdateValues()
    End Sub

    Protected Sub RadGridPayments_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridPayments.ItemCommand
        Select Case e.CommandName

            Case "EditPayment"
                lblPaymentId.Text = e.CommandArgument
                FormViewPayment.DataBind()
                RadToolTipEditPayment.Visible = True
                RadToolTipEditPayment.Show()


        End Select

    End Sub
    Protected Sub SqlDataSourcePayments_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourcePayments.Deleted
        SqlDataSourceInvoices.DataBind()
        RadGridIncoices.DataBind()
        UpdateValues()
    End Sub

    Protected Sub SqlDataSourcePayments_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourcePayments.Updated
        RadGridIncoices.DataBind()
        UpdateValues()
    End Sub
    Private Sub SqlDataSourcePayment_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourcePayment.Inserted
        Try
            RadGridIncoices.DataBind()
            UpdateValues()
            CleanForm()
            Master.InfoMessage("Payment insertd!")
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub
    Protected Sub btnCancelPayment_Click(sender As Object, e As EventArgs) Handles btnCancelPayment.Click
        RadToolTipInsertPayment.Visible = False
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
    Private Sub SqlDataSourcePayment_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourcePayment.Updating
        Dim e1 As String = e.Command.Parameters("@Method").Value
    End Sub

#End Region

#Region "Comun"
    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean, OnClientCloseFn As String)
        RadWindowManager1.Windows.Clear()
        Dim window1 As RadWindow = New RadWindow()
        window1.NavigateUrl = sUrl
        window1.VisibleOnPageLoad = True
        window1.VisibleStatusbar = False
        window1.ID = WindowsID
        If Maximize Then window1.InitialBehaviors = WindowBehaviors.Maximize
        window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
        If Width = -1 Then
            window1.AutoSize = True
        Else
            window1.AutoSize = False
            window1.Width = Width
            window1.Height = Height
        End If
        window1.Modal = True
        window1.OnClientClose = OnClientCloseFn
        RadWindowManager1.Windows.Add(window1)
    End Sub
    Public Function GetColor(ByVal Amount As Double) As System.Drawing.Color
        If Amount <> 0 Then
            GetColor = System.Drawing.Color.Black
        Else
            GetColor = System.Drawing.Color.Red
        End If

    End Function

    Private Sub SqlDataSourceJobStatus_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceJobStatus.Updated
        FormViewStatus.DataBind()
    End Sub

    Private Sub SqlDataSourceInvoice_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceInvoice.Updating
        Dim e1 As String = e.Command.Parameters(5).Value
    End Sub
    Private Sub SqlDataSourcePayments_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourcePayments.Deleting
        Try
            LocalAPI.sys_log_Nuevo(Master.UserEmail, LocalAPI.sys_log_AccionENUM.DeletePaid, lblCompanyId.Text, "Delete Payment: " & e.Command.Parameters("@Id").Value)
        Catch ex As Exception
        End Try
    End Sub
    Private Sub SqlDataSourcePayment_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourcePayment.Deleted
        UpdateValues()
    End Sub
    Private Sub SqlDataSourceInvoice_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceInvoice.Inserted
        UpdateValues()
    End Sub

    Private Function UpdateValues()
        RadGridPayments.DataBind()
        FormViewStatus.DataBind()
        SqlDataSourceClientBalance.DataBind()
        FormViewClientBalance.DataBind()
    End Function


#End Region
End Class
