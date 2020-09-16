Imports System.Threading.Tasks
Imports Telerik.Web.UI
Public Class billingmanager
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If (Not Page.IsPostBack) Then
                ' Si no tiene permiso, la dirijo a message
                lblEmployeeId.Text = Master.UserId

                lblEmployeeEmail.Text = Master.UserEmail
                lblEmployeeName.Text = LocalAPI.GetEmployeeName(lblEmployeeId.Text)

                If Not LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Deny_BillingManager") Then Response.RedirectPermanent("~/adm/default.aspx")

                Master.PageTitle = "Billing/Assistant"
                Master.Help = "http://blog.pasconcept.com/2012/05/billing-invoices-list-page.html"
                lblCompanyId.Text = Session("companyId")

                cboClients.DataBind()

                Dim bBillingModule As Boolean = True    'LocalAPI.IsBillingModule(lblCompanyId.Text)
                btnEmail.Enabled = bBillingModule
                btnSchedule.Enabled = bBillingModule

                btnBadDebt.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Allow_BadDebt")
                btnBadDebt.Enabled = bBillingModule

                btnReceivePayment.Enabled = bBillingModule
                btnStatement.Enabled = bBillingModule

                cboDepartments.DataBind()

                If Not bBillingModule Then
                    Master.ErrorMessage("You must to hire 'Additional Billing Options' Add-On. For more info contact us in http://pasconcept.com")
                End If

                RefreshStatements()

                btnClientInvoicesUnhide.Visible = Len(lblExcludeInvoiceClientId_List.Text) > 0
                btnClientStatementsUnhide.Visible = Len(lblExcludeStatementsClientId_List.Text) > 0

            End If
            RadWindowManager1.EnableViewState = False


        Catch ex As Exception
        End Try
    End Sub

    Private Function GetMultiCheckInList(Combo1 As RadComboBox) As String
        ' Companies...............................
        Dim ResultList As String = ""
        Dim collection As IList(Of RadComboBoxItem) = Combo1.CheckedItems
        If (collection.Count <> 0) Then

            For Each item As RadComboBoxItem In collection
                ResultList = ResultList + item.Value + ","
            Next
            ' Quitar la ultima coma
            ResultList = Left(ResultList, Len(ResultList) - 1)
            Return ResultList
        End If
    End Function

    Protected Sub cboDepartments_ItemDataBound(sender As Object, e As RadComboBoxItemEventArgs) Handles cboDepartments.ItemDataBound
        Select Case lblEmployeeId.Text
            ' DIFERENCIAR A SANDRA Y ZURELYS PARCHE....
            Case 207    ' Sandra parche
                Select Case e.Item.Value
                    Case 1, 2
                        e.Item.Checked = True
                    Case Else
                        e.Item.Checked = False
                End Select
            Case 2288 ' Zurely parche
                Select Case e.Item.Value
                    Case 5, 8, 12
                        e.Item.Checked = True
                    Case Else
                        e.Item.Checked = False
                End Select
            Case Else
                e.Item.Checked = True
        End Select
    End Sub
    Private Sub ConfirmDlg(Title As String, Text As String)
        If RadGridInvoices.SelectedItems.Count > 0 Then

            RadToolBillAction.Title = "<h2>" & Title & "</h2>"
            lblActionMesage.Text = Text & "<br /><br />Are you sure to do this action?<br /><br />"
            btnOk.Text = Title
            RadToolBillAction.Visible = True
            RadToolBillAction.Show()
        Else
            Master.ErrorMessage("You must to select records previously!")
        End If
    End Sub

    Private Sub ConfirmStatementDlg(Title As String, Text As String)
        If RadGridStatements.SelectedItems.Count > 0 Then

            RadToolTipStatementAction.Title = "<h2>" & Title & "</h2>"
            lblActionMesageStatement.Text = Text & "<br /><br />Are you sure to do this action?<br /><br />"
            btnOkStatement.Text = Title
            RadToolTipStatementAction.Visible = True
            RadToolTipStatementAction.Show()
        Else
            Master.ErrorMessage("You must to select records previously!")
        End If
    End Sub

    Private Sub RadGridInvoices_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles RadGridInvoices.ItemDataBound
        Try

            If TypeOf e.Item Is GridDataItem Then
                Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
                Dim Label1 As Label = DirectCast(item.FindControl("lblAmountDue"), Label)
                If DirectCast(item.FindControl("lblAmountDue"), Label).Text > 0 Then
                    Dim jobId As Integer = item("Id").Text
                    Dim lEmitted As Integer = LocalAPI.GetInvoiceEmmited(jobId)
                    Select Case lEmitted
                        Case 0  '"~/Images/Toolbar/white_circle.png"
                            Label1.BackColor = System.Drawing.Color.Blue
                            Label1.ToolTip = "Blue. Amount Due<>0 and Emitted=0"

                        Case 1  '"~/Images/Toolbar/green_circle.png"
                            Label1.BackColor = System.Drawing.Color.Green
                            Label1.ToolTip = "Green. Amount Due<>0 and Emitted=1"

                        Case 2  '"~/Images/Toolbar/yellow_circle.png"
                            Label1.BackColor = System.Drawing.Color.Orange
                            Label1.ToolTip = "Orange. Amount Due<>0 and Emitted=2"

                        Case Else   '"~/Images/Toolbar/red_circle.png"
                            Label1.BackColor = System.Drawing.Color.OrangeRed
                            Label1.ToolTip = "OrangeRed. Amount Due<>0 and Emitted>=3"
                    End Select
                Else
                    ' AmountDue = 0
                    Label1.BackColor = System.Drawing.Color.Black
                    Label1.ToolTip = "Black. Close, Amount Due = 0"
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RefreshData()
    End Sub

    Private Sub RefreshData()

        ' DataBind del RadGrid y no del SqlDataSource para que Fire el evento SqlDataSourceMainInvoice_Selecting y llenar parametros MultiCheckSelect
        RefreshRemainder()
        RefreshInvoices()
        RefreshStatements()

    End Sub
    Private Sub RefreshRemainder()
        RadGridRemainders.DataBind()
    End Sub

    Private Sub RefreshInvoices()
        RadGridInvoices.DataBind()
    End Sub

    Private Sub RefreshStatements()
        RadGridStatements.DataBind()
    End Sub
    Protected Sub btnEmail_Click(sender As Object, e As EventArgs) Handles btnEmail.Click
        ConfirmDlg("Email", btnEmail.ToolTip)
    End Sub
    Protected Sub btnSendStatement_Click(sender As Object, e As EventArgs) Handles btnSendStatement.Click
        ConfirmStatementDlg("Email", btnSendStatement.ToolTip)
    End Sub
    Protected Sub btnSchedule_Click(sender As Object, e As EventArgs) Handles btnSchedule.Click
        ConfirmDlg("Schedule", btnSchedule.ToolTip)
    End Sub
    Protected Sub btnBadDebt_Click(sender As Object, e As EventArgs) Handles btnBadDebt.Click
        ConfirmDlg("BadDebt", btnBadDebt.ToolTip)
    End Sub
    Protected Sub btnReceivePayment_Click(sender As Object, e As EventArgs) Handles btnReceivePayment.Click
        If RadGridInvoices.SelectedItems.Count > 0 Then
            RadDatePickerPayment.DbSelectedDate = LocalAPI.GetDateTime()
            txtPaymentNotes.Text = ""
            RadToolTipInvoicesPayment.Visible = True
            RadToolTipInvoicesPayment.Show()
        Else
            Master.ErrorMessage("You must to select records previously!")
        End If
    End Sub

    Protected Sub btnReceivePaymentStatement_Click(sender As Object, e As EventArgs) Handles btnReceivePaymentStatement.Click
        If RadGridStatements.SelectedItems.Count > 0 Then
            RadDatePickerPayment2.DbSelectedDate = LocalAPI.GetDateTime()
            txtPaymentNotes2.Text = ""
            RadToolTipStatementsPayment.Visible = True
            RadToolTipStatementsPayment.Show()
        Else
            Master.ErrorMessage("You must to select records previously!")
        End If
    End Sub

    Protected Sub btnStatement_Click(sender As Object, e As EventArgs) Handles btnStatement.Click
        ConfirmDlg("Statement", btnStatement.ToolTip)
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        RadToolBillAction.Visible = False
    End Sub
    Protected Sub btnCancelStatementDlg_Click(sender As Object, e As EventArgs) Handles btnCancelStatementDlg.Click
        RadToolTipStatementAction.Visible = False
    End Sub

    Protected Sub btnCancelPayment_Click(sender As Object, e As EventArgs) Handles btnCancelPayment.Click
        RadToolTipInvoicesPayment.Visible = False
    End Sub

    Protected Sub btnOk_Click(sender As Object, e As EventArgs) Handles btnOk.Click
        Try

            For Each dataItem As GridDataItem In RadGridInvoices.SelectedItems
                If dataItem.Selected Then
                    Select Case btnOk.Text
                        Case "Email"
                            SendSelectedInvoicesEmails()

                        Case "BadDebt"
                            LocalAPI.SetInvoiceBatDebt(dataItem("Id").Text)

                        Case "Statement"
                            InsertStatement()

                        Case "Schedule"
                            LocalAPI.SetInvoiceScheduleEmail(dataItem("Id").Text, txtEmissionRecurrenceDays.DbValue)
                    End Select
                End If
            Next

            RefreshInvoices()

            RadToolBillAction.Visible = False

        Catch ex As Exception
            RadToolBillAction.Visible = False
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub btnOkStatement_Click(sender As Object, e As EventArgs) Handles btnOkStatement.Click
        Try

            For Each dataItem As GridDataItem In RadGridStatements.SelectedItems
                If dataItem.Selected Then
                    Select Case btnOkStatement.Text
                        Case "Email"
                            SendSelectedStatementEmails()

                    End Select
                End If
            Next

            RefreshStatements()

            RadToolBillAction.Visible = False

        Catch ex As Exception
            RadToolBillAction.Visible = False
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub btnInsertPayment_Click(sender As Object, e As EventArgs) Handles btnInsertPayment.Click
        For Each dataItem As GridDataItem In RadGridInvoices.SelectedItems
            If dataItem.Selected Then
                lblInvoiceId.Text = dataItem("Id").Text
                txtAmountPayment.DbValue = LocalAPI.GetInvoiceProperty(lblInvoiceId.Text, "AmountDue")
                SqlDataSourcePayments.Insert()
                dataItem.Selected = False
            End If
        Next
        RadToolTipInvoicesPayment.Visible = False
        RefreshInvoices()

    End Sub

    Protected Sub btnInsertStatementPayments_Click(sender As Object, e As EventArgs) Handles btnInsertStatementPayments.Click
        Try

            For Each dataItem As GridDataItem In RadGridStatements.SelectedItems
                If dataItem.Selected Then
                    lblStatementId.Text = dataItem("Id").Text
                    SqlDataSourceStatements.Update()
                    dataItem.Selected = False
                End If
            Next
            RadToolTipStatementsPayment.Visible = False
            RefreshStatements()

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub


    Protected Sub btnCancelStatementPayments_Click(sender As Object, e As EventArgs) Handles btnCancelStatementPayments.Click
        RadToolTipStatementsPayment.Visible = False
    End Sub

    Private Function SendSelectedInvoicesEmails() As Boolean
        Try

            Dim Subject As String
            Dim Body As String
            Dim emailTo As String
            Dim invoiceId As Integer
            For Each dataItem As GridDataItem In RadGridInvoices.SelectedItems

                If dataItem.Selected Then
                    invoiceId = dataItem("Id").Text
                    Subject = ""
                    Body = ""
                    If LocalAPI.LeerInvoiceTemplate(invoiceId, lblCompanyId.Text, Subject, Body) Then
                        LocalAPI.ActualizarEmittedInvoice(invoiceId, lblEmployeeId.Text)
                        emailTo = LocalAPI.GetClientEmailFromInvoice(invoiceId)
                        Dim clientID = LocalAPI.GetClientIdFromInvoice(invoiceId)
                        Dim jobId = LocalAPI.GetJobIdFromInvoice(invoiceId)

                        SendGrid.Email.SendMail(emailTo, "", "", Subject, Body, lblCompanyId.Text, clientID, jobId,,, lblEmployeeEmail.Text, lblEmployeeName.Text)

                        LocalAPI.NewAutomaticInvoiceReminderFromEmitted(invoiceId, lblEmployeeId.Text, lblCompanyId.Text)

                        dataItem.Selected = False
                    End If
                End If

            Next

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Function
    Private Function SendSelectedStatementEmails() As Boolean
        Try
            Dim Subject As String
            Dim Body As String
            Dim emailTo As String
            Dim statementId As Integer
            For Each dataItem As GridDataItem In RadGridStatements.SelectedItems

                If dataItem.Selected Then
                    statementId = dataItem("Id").Text
                    Subject = ""
                    Body = ""

                    Dim clientId As Integer = LocalAPI.GetStatementProperty(statementId, "clientId")
                    Dim sClienteName = LocalAPI.GetStatementProperty(statementId, "[Clients].[Name]")
                    Dim sSign As String = LocalAPI.GetEmployeesSign(lblEmployeeId.Text)
                    Dim statementNumber As String = LocalAPI.GetStatementNumber(statementId)


                    Dim DictValues As Dictionary(Of String, String) = New Dictionary(Of String, String)
                    DictValues.Add("[Client_Name]", sClienteName)
                    DictValues.Add("[Sign]", sSign)
                    DictValues.Add("[Statement_Number]", statementNumber)
                    DictValues.Add("[PASSign]", LocalAPI.GetPASSign())

                    ' Leer subjet y body template
                    Subject = LocalAPI.GetMessageTemplateSubject("Statement", lblCompanyId.Text, DictValues)
                    Body = LocalAPI.GetMessageTemplateBody("Statement", lblCompanyId.Text, DictValues)

                    LocalAPI.ActualizarEmittedStatetment(statementId)
                    LocalAPI.SetInvoiceEmittedFromStatement(statementId)


                    emailTo = LocalAPI.GetClientEmail(clientId)
                    Dim AccountantEmail As String = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "AccountantEmail")
                    If Not LocalAPI.ValidEmail(AccountantEmail) Then
                        AccountantEmail = AccountantEmail
                    End If

                    SendGrid.Email.SendMail(emailTo, "", AccountantEmail, Subject, Body, lblCompanyId.Text, clientId, 0,, lblEmployeeName.Text, lblEmployeeEmail.Text, lblEmployeeName.Text)

                    LocalAPI.NewAutomaticStatementReminderFromEmitted(statementId, lblEmployeeId.Text, lblCompanyId.Text)

                    dataItem.Selected = False


                End If

            Next

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Function

    Private Function InsertStatement() As Boolean
        Try
            lblStatementId.Text = "0"
            For Each dataItem As GridDataItem In RadGridInvoices.SelectedItems

                If lblStatementId.Text = "0" Then
                    lblInvoiceId.Text = dataItem("Id").Text
                    If LocalAPI.GetInvoiceProperty(lblInvoiceId.Text, "statementId") = 0 Then
                        SqlDataSourceStatements.Insert()
                        SqlDataSourceStatements.DataBind()
                        RefreshStatements()
                    End If
                End If
                If lblStatementId.Text > 0 Then
                    LocalAPI.SetInvoiceStatement(dataItem("Id").Text, lblStatementId.Text)
                    dataItem.Selected = False
                End If

            Next
            If lblStatementId.Text > 0 Then
                SqlDataSourceStatements.DataBind()
                RefreshStatements()
                RefreshInvoices()

                Master.InfoMessage("Statement created")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Function

    Protected Sub RadGridInvoices_PreRender(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            'RadGridInvoices.MasterTableView.Items(0).Expanded = True
        End If
    End Sub

    Protected Sub SqlDataSourceStatements_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceStatements.Inserted
        lblStatementId.Text = e.Command.Parameters("@StatementId").Value.ToString
    End Sub


    Private Sub RadGridRemainders_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridRemainders.ItemCommand
        Select Case e.CommandName
            Case "Update"
                If CType(e.CommandSource, LinkButton).ID = "btnSendRemaiderAgain" Then
                    Dim reminderId As Integer = e.CommandArgument
                    ' Send Email to client
                    If LocalAPI.IsReminderInvoice(reminderId) Then
                        ' Marco con "-" que el Remainder hay que enviarlo por Email en _Updated()
                        lblInvoiceId.Text = 0 - LocalAPI.GetReminderInvoiceProperty(reminderId, "InvoiceId")
                    Else
                        lblStatementId.Text = 0 - LocalAPI.GetReminderStatementProperty(reminderId, "statementId")
                    End If
                End If

        End Select

    End Sub

    Private Sub SqlDataSourceRemainders_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceRemainders.Updated
        If Val(lblInvoiceId.Text) < 0 Then
            lblInvoiceId.Text = 0 - lblInvoiceId.Text
            SendRemainderToClient()
            lblInvoiceId.Text = "0"
        End If
        If Val(lblStatementId.Text) < 0 Then
            lblStatementId.Text = 0 - lblStatementId.Text
            SendStatementRemainderToClient()
            lblStatementId.Text = "0"
        End If
    End Sub


    Private Sub RadGridInvoices_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridInvoices.ItemCommand
        Select Case e.CommandName
            Case "EditInvoice"
                lblInvoiceId.Text = e.CommandArgument
                SqlDataSourceEditInvoice.DataBind()
                RadToolTipEditInvoice.Visible = True
                RadToolTipEditInvoice.Show()
            Case "NewInvoiceRemaider"
                lblInvoiceId.Text = e.CommandArgument
                SqlDataSourceInvoiceRemaider.DataBind()

                Dim invoiceInfo = LocalAPI.GetInvoiceInfo(lblInvoiceId.Text)

                ' Clear and fill Form
                RadDatePickerRemaider.DbSelectedDate = DateAdd(DateInterval.Day, 7, Date.Now)
                txtRemainderContactName.Text = invoiceInfo("ClientName")
                txtRemaiderEmail.Text = invoiceInfo("Email")
                txtRemainderNotes.Text = ""

                RadToolTipInvoiceRemaider.Visible = True
                RadToolTipInvoiceRemaider.Show()

            Case "NewInvoiceEmail"
                'Dim sUrl As String = "~/ADMCLI/InvoiceRDLC.aspx?InvoiceNo=" & e.CommandArgument & "&Origen=11"
                Dim sUrl As String = "~/ADM/SendInvoice.aspx?InvoiceNo=" & e.CommandArgument & "&Origen=11"
                CreateRadWindows(e.CommandName, sUrl, 900, 750, False)

            Case "HideInvoiceClient"
                Dim ClientId As Integer = e.CommandArgument
                If ClientId > 0 Then
                    lblExcludeInvoiceClientId_List.Text = lblExcludeInvoiceClientId_List.Text & IIf(Len(lblExcludeInvoiceClientId_List.Text) > 0, ",", "") & ClientId
                    btnClientInvoicesUnhide.Visible = True
                    RefreshInvoices()
                End If

        End Select

    End Sub

    Protected Sub btnClientInvoicesUnhide_Click(sender As Object, e As EventArgs) Handles btnClientInvoicesUnhide.Click
        lblExcludeInvoiceClientId_List.Text = ""
        RefreshInvoices()
        btnClientInvoicesUnhide.Visible = False
    End Sub

    Private Sub RadGridStatements_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridStatements.ItemCommand
        Select Case e.CommandName
            Case "NewStatementReminder"
                lblStatementId.Text = e.CommandArgument
                SqlDataSourceStatementReminder.DataBind()

                Dim statementInfo = LocalAPI.GetStatementInfo(lblStatementId.Text)

                ' Clear and fill Form
                RadDatePickerReminder2.DbSelectedDate = DateAdd(DateInterval.Day, 7, Date.Now)
                txtRemainderContactName2.Text = statementInfo("ClientName")
                txtRemaiderEmail2.Text = statementInfo("Email")
                txtRemainderNotes2.Text = ""

                RadToolTipStatementReminder.Visible = True
                RadToolTipStatementReminder.Show()

            Case "NewStatementEmail"
                Dim sUrl As String = "~/ADM/SendStatement.aspx?StatementNo=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 680, False)

            Case "HideStatementClient"
                Dim ClientId As Integer = e.CommandArgument
                If ClientId > 0 Then
                    lblExcludeStatementsClientId_List.Text = lblExcludeStatementsClientId_List.Text & IIf(Len(lblExcludeStatementsClientId_List.Text) > 0, ",", "") & ClientId
                    btnClientStatementsUnhide.Visible = True
                    RefreshStatements()
                End If
        End Select
    End Sub

    Protected Sub btnClientStatementsUnhide_Click(sender As Object, e As EventArgs) Handles btnClientStatementsUnhide.Click
        lblExcludeStatementsClientId_List.Text = ""
        RefreshStatements()
        btnClientStatementsUnhide.Visible = False
    End Sub

    Protected Sub btnUpdateInvoice_Click(sender As Object, e As EventArgs) Handles btnUpdateInvoice.Click
        FormViewInvoice.UpdateItem(True)
        RadToolTipEditInvoice.Visible = False
        RefreshInvoices()

        SqlDataSourceInvoicesDetails.DataBind()
    End Sub
    Protected Sub btnCancelInvoice_Click(sender As Object, e As EventArgs) Handles btnCancelInvoice.Click
        RadToolTipEditInvoice.Visible = False
    End Sub

    Private Sub SqlDataSourceMainInvoice_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceMainInvoice.Selecting
        e.Command.Parameters("@DepartmentIdIN_List").Value = GetMultiCheckInList(cboDepartments)
        e.Command.Parameters("@PastDueStatusIN_List").Value = GetMultiCheckInList(cboPasDueStatus)
    End Sub
    Private Sub SqlDataSourceStatements_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceStatements.Selecting
        e.Command.Parameters("@PastDueStatusIN_List").Value = GetMultiCheckInList(cboPasDueStatus)
    End Sub

    Protected Sub btnInsertRemaider_Click(sender As Object, e As EventArgs) Handles btnInsertRemaider.Click
        SqlDataSourceInvoiceRemaider.Insert()

        RadToolTipInvoiceRemaider.Visible = False
    End Sub

    Protected Sub btnInsertStatementReminder_Click(sender As Object, e As EventArgs) Handles btnInsertStatementReminder.Click
        SqlDataSourceStatementReminder.Insert()

        RadToolTipStatementReminder.Visible = False
    End Sub

    Protected Sub btnCancelRemaider_Click(sender As Object, e As EventArgs) Handles btnCancelRemaider.Click
        RadToolTipInvoiceRemaider.Visible = False
    End Sub

    Protected Sub btnCancelStatementReminder_Click(sender As Object, e As EventArgs) Handles btnCancelStatementReminder.Click
        RadToolTipStatementReminder.Visible = False
    End Sub

    Private Sub SqlDataSourceInvoiceRemaider_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceInvoiceRemaider.Inserted
        ' Enviar Email al cliente
        SendRemainderToClient()
        RefreshInvoices()
        RefreshRemainder()
        lblInvoiceId.Text = "0"
    End Sub

    Private Sub SqlDataSourceStatementReminder_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceStatementReminder.Inserted
        ' Enviar Email al cliente
        SendStatementRemainderToClient()
        RefreshStatements()
        RefreshRemainder()
        lblStatementId.Text = "0"
    End Sub

    Private Sub SendRemainderToClient()
        Try

            Dim Body As String = LocalAPI.LeerInvoiceRemainderTemplate(lblInvoiceId.Text)

            If Len(Body) > 0 Then
                Dim sTo As String = ""
                Dim sCC As String = ""

                Dim invoiceInfo = LocalAPI.GetInvoiceInfo(lblInvoiceId.Text)
                Dim Subject As String = "Reminder. Invoice " & invoiceInfo("InvoiceNumber") & ", " & invoiceInfo("ProjectName")
                If LocalAPI.ValidEmail(txtRemaiderEmail.Text) Then
                    sTo = txtRemaiderEmail.Text
                    sCC = LocalAPI.GetEmployeeEmail(lId:=lblEmployeeId.Text)
                End If
                Body = Replace(Body, "[RemainderContactName]", txtRemainderContactName.Text)
                Body = Replace(Body, "[InvoiceNumber]", invoiceInfo("InvoiceNumber"))
                Body = Replace(Body, "[ProjectName]", invoiceInfo("ProjectName"))
                Body = Replace(Body, "[Remainder]", RadDatePickerRemaider.SelectedDate)
                Body = Replace(Body, "[Notes]", txtRemainderNotes.Text)
                Body = Replace(Body, "[EmployeeName]", lblEmployeeName.Text)
                Dim clientID = LocalAPI.GetClientIdFromInvoice(lblInvoiceId.Text)
                Dim jobId = LocalAPI.GetJobIdFromInvoice(lblInvoiceId.Text)

                Task.Run(Function() SendGrid.Email.SendMail(sTo, sCC, "", Subject, Body, lblCompanyId.Text, clientID, jobId,,, lblEmployeeEmail.Text, lblEmployeeName.Text))

                ' Añadir una Note al Job
                LocalAPI.NewJobNote(invoiceInfo("jobId"), Subject, lblEmployeeId.Text)
            End If

        Catch ex As Exception
        End Try

    End Sub

    Private Sub SendStatementRemainderToClient()
        Try

            Dim Body As String = LocalAPI.LeerStatementRemainderTemplate(lblStatementId.Text)

            If Len(Body) > 0 Then
                Dim sTo As String = ""
                Dim sCC As String = ""

                Dim StatementIdInfo = LocalAPI.GetStatementInfo(lblStatementId.Text)
                Dim Subject As String = "Reminder. Statement " & StatementIdInfo("StatementNumber")
                If LocalAPI.ValidEmail(txtRemaiderEmail2.Text) Then
                    sTo = txtRemaiderEmail2.Text
                    sCC = LocalAPI.GetEmployeeEmail(lId:=lblEmployeeId.Text)
                End If
                Body = Replace(Body, "[RemainderContactName]", txtRemainderContactName2.Text)
                Body = Replace(Body, "[StatementNumber]", StatementIdInfo("StatementNumber"))
                Body = Replace(Body, "[Remainder]", RadDatePickerReminder2.SelectedDate)
                Body = Replace(Body, "[Notes]", txtRemainderNotes2.Text)
                Body = Replace(Body, "[EmployeeName]", lblEmployeeName.Text)

                Dim clientId As Integer = LocalAPI.GetStatementProperty(lblStatementId.Text, "clientId")
                Task.Run(Function() SendGrid.Email.SendMail(sTo, sCC, "", Subject, Body, lblCompanyId.Text, clientId, 0,,, lblEmployeeEmail.Text, lblEmployeeName.Text))

            End If

        Catch ex As Exception
        End Try

    End Sub

    Private Sub SqlDataSourceRemainders_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceRemainders.Selecting
        e.Command.Parameters("@employeeId").Value = IIf(chkEmployeeRemaindersOnly.Checked, lblEmployeeId.Text, 0)
    End Sub

    Private Sub SqlDataSourceRemainders_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceRemainders.Deleting
        Dim e1 As String = e.Command.Parameters("@Id").Value
    End Sub

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
    Protected Sub btnExportInvoices_Click(sender As Object, e As EventArgs) Handles btnExportInvoices.Click
        lblClientToExport.Text = cboClients.SelectedValue
        'RadGridInvoiceExport.Visible = True
        RadGridInvoiceExport.DataBind()
        ConfigureExport(RadGridInvoiceExport, "Invoices")

        RadGridInvoiceExport.MasterTableView.ExportToExcel()
        'RadGridInvoiceExport.Visible = False
        lblClientToExport.Text = "999999"
    End Sub

    Private Sub ConfigureExport(RadGrid1 As RadGrid, sFileName As String)
        RadGrid1.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx
        RadGrid1.ExportSettings.FileName = sFileName & "_" & DateTime.Today.ToString("yyyy-MM-dd")
        RadGrid1.ExportSettings.ExportOnlyData = True
        RadGrid1.ExportSettings.IgnorePaging = True
        RadGrid1.ExportSettings.OpenInNewWindow = True
        RadGrid1.ExportSettings.UseItemStyles = False
        RadGrid1.ExportSettings.HideStructureColumns = True
        RadGrid1.MasterTableView.ShowFooter = True
    End Sub
End Class
