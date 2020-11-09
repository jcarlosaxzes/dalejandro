Imports Intuit.Ipp.Data
Imports Intuit.Ipp.DataService
Imports Intuit.Ipp.QueryFilter
Imports PASconcept.DataAccess.Repositories.Abstract
Imports PASconcept.Domain.Model
Imports Telerik.Web.UI
Imports Newtonsoft.Json
Public Class invoices
    Inherits System.Web.UI.Page

    Private ReadOnly qbOperationLogRepository As IQBOperationLogRepository

    Private ReadOnly invoiceRepository As IInvoiceRepository

    Public Sub New(ByVal qbOperationLogRepository As IQBOperationLogRepository, ByVal invoiceRepo As IInvoiceRepository)
        Try

            Me.qbOperationLogRepository = qbOperationLogRepository
            Me.invoiceRepository = invoiceRepo
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Invoices"
            If (Not Page.IsPostBack) Then
                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_InvoicesList") Then Response.RedirectPermanent("~/adm/default.aspx")

                Master.PageTitle = "Billing/Invoices"
                Master.Help = "http://blog.pasconcept.com/2012/05/billing-invoices-list-page.html"
                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Master.UserId

                spanViewSummary.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Allow_PrivateMode")

                'RestoreFilters()
                cboClients.DataBind()

                PanelUpload.Visible = LocalAPI.IsAzureStorage(lblCompanyId.Text)

                cboPeriod.DataBind()
                IniciaPeriodo(cboPeriod.SelectedValue)

                ' ? Quickbooks.........................
                cboQB.DataBind()
                cboQB.Visible = LocalAPI.IsQuickBookModule(lblCompanyId.Text)
                btnBulkSentToQB.Visible = cboQB.Visible

                RefrescarRecordset()

                If lblCompanyId.Text = 260962 Then
                    ' EEG 10 Mb
                    RadCloudUpload1.MaxFileSize = 10485760
                End If

            End If

            RadWindowManager1.EnableViewState = False


            Dim valid = qbAPI.IsValidAccessToken(lblCompanyId.Text)
            If Not valid Then
                Threading.Tasks.Task.Run(Function() qbAPI.UpdateAccessTokenAsync(lblCompanyId.Text))
            End If


        Catch ex As Exception
            Dim e1 As String = ex.Message
        End Try
    End Sub

    Private Sub IniciaPeriodo(nPeriodo As Integer)

        Select Case nPeriodo
            Case 13  ' All Years...
                RadDatePickerFrom.DbSelectedDate = "01/01/2000"
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

            Case 16  ' (This Month)
                RadDatePickerFrom.DbSelectedDate = Today.Month & "/01/" & Today.Year
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate))
            Case 17  ' (Past Month)
                RadDatePickerFrom.DbSelectedDate = Today.Month & "/01/" & Today.Year
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Month, -1, RadDatePickerFrom.DbSelectedDate)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate))

            Case 30, 60, 90, 120, 180, 365 '   days....
                RadDatePickerTo.DbSelectedDate = Date.Today
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Day, 0 - nPeriodo, RadDatePickerTo.DbSelectedDate)

            Case 14  ' This year...
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Date.Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Date.Today.Year

            Case 99   'Custom
                RadDatePickerFrom.Focus()
                ' Allow RadDatePicker user Values...

        End Select
        cboPeriod.SelectedValue = nPeriodo
    End Sub
    Private Sub RefrescarRecordset()
        Try

            IniciaPeriodo(cboPeriod.SelectedValue)

            Select Case cboInvoiceStatus.SelectedValue
                Case 0 '"Not Collected"  />
                    lblStatus.Text = "Billing/Account <b>Not Collected or Partially</b>"
                Case 1 '"Not Emitted" />
                    lblStatus.Text = "Billing/Account <b>Not Emitted</b>"
                Case 2 '"Collected" Value="3" />
                    lblStatus.Text = "Billing/Account <b>Collected</b>"
                Case 3 '"Bad Debts" Value="5" />
                    lblStatus.Text = "Billing/Account <b>Bad Debts</b>"
                Case -1 '"(All Invoices...)" Value="4" />
                    lblStatus.Text = "Billing/<b>All Invoices</b>"
            End Select
            If Val(cboClients.SelectedValue) > 0 Then
                lblStatus.Text = lblStatus.Text & ". Client: " & cboClients.Text
            End If


            If Val(cboInvoiceStatus.SelectedValue) = 6 Then
                lblStatus.Text = lblStatus.Text & cboPeriod.Text
            Else
                lblStatus.Text = lblStatus.Text & cboPeriod.Text
            End If

            RadGrid1.DataBind()
            FormViewViewSummary.DataBind()

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    'Protected Sub RadGrid1_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadGrid1.Init
    '    Dim menu As GridFilterMenu = RadGrid1.FilterMenu
    '    Dim i As Integer
    '    While i < menu.Items.Count
    '        If menu.Items(i).Text <> "NoFilter" And menu.Items(i).Text <> "Contains" And menu.Items(i).Text <> "DoesNotContain" And menu.Items(i).Text <> "EqualTo" Then
    '            menu.Items.RemoveAt(i)
    '        Else
    '            i = i + 1
    '        End If
    '    End While
    'End Sub

    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean)
        RadWindowManager1.Windows.Clear()
        Dim window1 As RadWindow = New RadWindow()
        window1.NavigateUrl = sUrl
        window1.VisibleOnPageLoad = True
        window1.VisibleStatusbar = False
        window1.ID = WindowsID
        If Maximize Then window1.InitialBehaviors = WindowBehaviors.Maximize
        window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize Or WindowBehaviors.Maximize
        If Width = -1 Then
            window1.AutoSize = True
        Else
            window1.AutoSize = False
            window1.Width = Width
            window1.Height = Height
        End If
        window1.Modal = True
        window1.DestroyOnClose = True
        window1.OnClientClose = "OnClientClose"
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Protected Sub btnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        RefrescarRecordset()
        'SaveFilters()
    End Sub

    Protected Sub SqlDataSourceInvoices_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceInvoices.Selecting
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub

    Protected Sub btnInsertPayment_Click(sender As Object, e As EventArgs) Handles btnInsertPayment.Click
        SqlDataSourcePayments.Insert()
    End Sub

    Private Sub SqlDataSourcePayments_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourcePayments.Inserted
        Try
            RadGrid1.DataBind()
            RadToolTipInsertPayment.Visible = False
            Master.ErrorMessage("The payment has been confirmed successfully!!!")
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub
    Protected Sub btnCancelPayment_Click(sender As Object, e As EventArgs) Handles btnCancelPayment.Click
        RadToolTipInsertPayment.Visible = False
    End Sub

    Protected Sub RadCloudUpload1_FileUploaded(sender As Object, e As Telerik.Web.UI.CloudFileUploadedEventArgs)
        Try
            Dim tempName = e.FileInfo.KeyName
            Dim fileExt = IO.Path.GetExtension(tempName)
            Dim newName = "Companies/" & lblCompanyId.Text & $"/{Guid.NewGuid().ToString()}" & fileExt
            AzureStorageApi.CopyFile(tempName, newName, lblCompanyId.Text)

            lblOriginalFileName.Text = e.FileInfo.OriginalFileName
            lblKeyName.Text = newName
            lblContentBytes.Text = e.FileInfo.ContentLength
            lblContentType.Text = e.FileInfo.ContentType
        Catch ex As Exception
            e.IsValid = False
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub cboClients_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboClients.SelectedIndexChanged
        cboJobs.Items.Clear()
        cboJobs.Items.Insert(0, New RadComboBoxItem("(All Jobs...)", -1))
        cboJobs.DataBind()
    End Sub
    Private Sub SqlDataSourceInvoice_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceInvoice.Updated
        RefrescarRecordset()
    End Sub

    Private Sub btnNewInvoice_Click(sender As Object, e As EventArgs) Handles btnNewInvoice.Click
        cboJobNewInvoice.DataBind()
        cboJobNewInvoice.SelectedValue = cboJobs.SelectedValue
        RadToolTipNewInvoice.Visible = True
        RadToolTipNewInvoice.Show()

    End Sub

    Private Sub btnNewSimpleChargeInvoice_Click(sender As Object, e As EventArgs) Handles btnNewSimpleChargeInvoice.Click
        If cboJobNewInvoice.SelectedValue > 0 Then
            lblInvoiceId.Text = LocalAPI.NuevoInvoiceSimpleCharge(cboJobNewInvoice.SelectedValue, Date.Today, 0, "", Master.UserId)
            FormViewInvoice.DataBind()
            RadToolTipEditInvoice.Visible = True
            RadToolTipEditInvoice.Show()
        End If

    End Sub

    Private Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Try

            Dim sUrl As String = ""
            Select Case e.CommandName
                Case "EditInvoice"
                    lblInvoiceId.Text = e.CommandArgument
                    If LocalAPI.GetInvoiceProperty(lblInvoiceId.Text, "InvoiceType") = 3 Then
                        ' Progress Invoice
                        Dim JobId As Integer = LocalAPI.GetInvoiceProperty(lblInvoiceId.Text, "JobId")
                        Response.Redirect($"~/adm/invoicesprogress?jobId={JobId}&invoiceId={lblInvoiceId.Text}&backpage=invoices")
                    Else
                        FormViewInvoice.DataBind()
                        RadToolTipEditInvoice.Visible = True
                        RadToolTipEditInvoice.Show()
                    End If

                Case "InvoiceRDLC7"
                    'sUrl = "~/ADMCLI/InvoiceRDLC.aspx?InvoiceNo=" & e.CommandArgument & "&Origen=7"
                    sUrl = "~/adm/SendInvoice.aspx?InvoiceNo=" & e.CommandArgument & "&Origen=7"
                    CreateRadWindows(e.CommandName, sUrl, 960, 810, False)

                Case "SendInvoice"
                    'sUrl = "~/ADMCLI/InvoiceRDLC.aspx?InvoiceNo=" & e.CommandArgument & "&Origen=2"
                    sUrl = "~/adm/SendInvoice.aspx?InvoiceNo=" & e.CommandArgument & "&Origen=2"
                    CreateRadWindows(e.CommandName, sUrl, 960, 790, False)

                Case "RecivePayment"
                    lblInvoiceId.Text = e.CommandArgument
                    txtAmountPayment.MaxValue = LocalAPI.GetInvoicesAmountDue(lblInvoiceId.Text)
                    txtAmountPayment.DbValue = txtAmountPayment.MaxValue
                    RadDatePickerPayment.DbSelectedDate = LocalAPI.GetDateTime()
                    txtPaymentNotes.Text = ""
                    RadToolTipInsertPayment.Visible = True
                    RadToolTipInsertPayment.Show()

                Case "BadDebt"
                    If LocalAPI.GetEmployeePermission(Master.UserId, "Allow_BadDebt") Then
                        sUrl = "~/adm/BadDebt.aspx?invoiceId=" & e.CommandArgument
                        CreateRadWindows(e.CommandName, sUrl, 520, 600, False)
                    Else
                        Master.ErrorMessage("You do not have permission to Invoice BadDebt!!!")
                    End If

                Case "EditJobBilling"
                    sUrl = LocalAPI.GetSharedLink_URL(8002, e.CommandArgument) & "&backpage=invoices"
                    Response.Redirect(sUrl)

                Case "PDF"
                    lblInvoiceId.Text = e.CommandArgument
                    Dim url = LocalAPI.GetSharedLink_URL(4, lblInvoiceId.Text)
                    Session("PrintName") = "Invoice_" & LocalAPI.InvoiceNumber(lblInvoiceId.Text) & ".pdf"
                    Session("PrintUrl") = url
                    Response.Redirect("~/adm/pdf_print.aspx")

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

                        RadGrid1.Rebind()
                    Else
                        If qbAPI.IsValidAccessToken(lblCompanyId.Text) Then
                            Dim ids As String() = CType(e.CommandArgument, String).Split(",")
                            Dim qbCustomerId As Integer = ids(1)
                            lblInvoiceId.Text = ids(0)
                            qbAPI.SendInvoiceToQuickBooks(lblInvoiceId.Text, qbCustomerId, lblEmployeeId.Text, lblCompanyId.Text)

                            Dim invoiceEntity = invoiceRepository.SingleOrDefault(lblInvoiceId.Text)
                            Dim operation As QBOperationLog = New QBOperationLog() With {
                                .LogDate = DateTime.Now,
                                .OperationData = JsonConvert.SerializeObject(invoiceEntity),
                                .OperationType = "Online:SyncInvoice",
                                .ResutlStatus = ""
                             }
                            qbOperationLogRepository.Add(operation)
                            qbOperationLogRepository.SaveChanges()

                            RadGrid1.Rebind()
                        Else
                            Response.Redirect("~/adm/qb_refreshtoken.aspx?QBAuthBackPage=invoices")
                        End If

                    End If
            End Select

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Public Function IsQuickBooksEnable() As Boolean
        Return LocalAPI.IsQuickBookModule(lblCompanyId.Text)
    End Function


    Private Sub btnBulkSentToQB_Click(sender As Object, e As EventArgs) Handles btnBulkSentToQB.Click
        Try
            If RadGrid1.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In RadGrid1.SelectedItems
                    If dataItem.Selected Then
                        dataItem.Selected = False
                        qbAPI.SendInvoiceToQuickBooks(dataItem("Id").Text, dataItem("qbCustomerId").Text, lblEmployeeId.Text, lblCompanyId.Text)
                    End If
                Next
                RadGrid1.DataBind()
            Else
                Master.ErrorMessage("Select (Mark) Invoices Records to Sent to QuickBooks!")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub
End Class
