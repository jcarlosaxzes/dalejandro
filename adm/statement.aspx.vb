Imports Telerik.Web.UI
Public Class statement
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If Not IsPostBack Then
                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_StatementList") Then Response.RedirectPermanent("~/ADM/Default.aspx")

                Master.PageTitle = "Billing/Statements"
                Master.Help = "http://blog.pasconcept.com/2012/06/billing-statements-list.html"
                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Statements"
                lblEmployee.Text = Master.UserEmail
                lblCompanyId.Text = Session("companyId")

                spanViewSummary.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Allow_PrivateMode")

                cboPeriod.DataBind()
                IniciaPeriodo(14)

                FormViewViewSummary.DataBind()

            End If

            RadWindowManager1.EnableViewState = False

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub IniciaPeriodo(nPeriodo As Integer)

        Select Case nPeriodo
            Case 13  ' All Years...
                RadDatePickerFrom.DbSelectedDate = "01/01/2000"
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

            Case 14  ' This year...
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Date.Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Date.Today.Year

            Case Is > 29   ' Last 60, 90 days....
                ' Rectifico filtro de Year a all

                RadDatePickerTo.DbSelectedDate = Date.Today
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Day, 0 - nPeriodo, RadDatePickerTo.DbSelectedDate)


        End Select
        cboPeriod.SelectedValue = nPeriodo
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub

    Protected Sub RadGrid1_ItemCommand(ByVal sender As Object, ByVal e As GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Try
            Dim sUrl As String

            Select Case e.CommandName
                Case "Edit"
                    lblStatementId.Text = e.CommandArgument
                    lblStatementClientId.Text = LocalAPI.GetStatementProperty(lblStatementId.Text, "clientId")
                Case "AddInvoices"
                    lblStatementId.Text = e.CommandArgument
                Case "EmailPrint"
                    sUrl = "~/ADM/SendStatement.aspx?StatementNo=" & e.CommandArgument
                    CreateRadWindows(e.CommandName, sUrl, 960, 680, False)

                Case "GetSharedLink"
                    Dim ObjGuid As String = LocalAPI.GetStatementProperty(e.CommandArgument, "guid")
                    sUrl = "~/adm/sharelink.aspx?ObjType=5&ObjGuid=" & ObjGuid
                    CreateRadWindows(e.CommandName, sUrl, 520, 400, False)

                Case "RecivePayment"
                    RadDatePickerPayment2.DbSelectedDate = LocalAPI.GetDateTime()
                    txtPaymentNotes2.Text = ""
                    lblStatementId.Text = e.CommandArgument
                    RadToolTipStatementsPayment.Visible = True
                    RadToolTipStatementsPayment.Show()

                Case "PDF"
                    lblStatementId.Text = e.CommandArgument
                    Dim url = LocalAPI.GetSharedLink_URL(5, lblStatementId.Text)
                    Session("PrintName") = "Statement_" & LocalAPI.GetStatementNumber(lblStatementId.Text) & ".pdf"
                    Session("PrintUrl") = url
                    Response.Redirect("~/ADM/pdf_print.aspx")


            End Select
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnInsertStatementPayments_Click(sender As Object, e As EventArgs) Handles btnInsertStatementPayments.Click
        Try

            SqlDataSourcePayments.Insert()
            RadToolTipStatementsPayment.Visible = False
            RadGrid1.DataBind()
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub btnCancelStatementPayments_Click(sender As Object, e As EventArgs) Handles btnCancelStatementPayments.Click
        RadToolTipStatementsPayment.Visible = False
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
        window1.OnClientClose = "OnClientClose"
        window1.DestroyOnClose = True
        RadWindowManager1.Windows.Add(window1)
    End Sub


    Protected Sub btnNewSelectedInvoices_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try

            'get a reference to the row
            Dim item As GridEditFormItem = CType(sender, LinkButton).NamingContainer
            Dim radGridInterno As RadGrid = CType(item.FindControl("RadGridInvoicesClient"), RadGrid)
            If radGridInterno.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In radGridInterno.SelectedItems
                    If dataItem.Selected Then
                        LocalAPI.SetInvoiceStatement(dataItem("Id").Text, lblStatementId.Text)
                    End If
                Next
                'SqlDataSourceInvoicesClient.DataBind()
                CType(item.FindControl("SqlDataSourceInvoicesClient"), SqlDataSource).DataBind()

                radGridInterno.DataBind()
                SqlDataSourceInvoicesSelected.DataBind()
                CType(item.FindControl("RadGridInvoicesSelected"), RadGrid).DataBind()
            End If

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub RadGrid1_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles RadGrid1.ItemDataBound
        If TypeOf e.Item Is GridEditFormInsertItem OrElse TypeOf e.Item Is GridDataInsertItem Then
            ' insert item
            Dim item As GridEditFormInsertItem = CType(e.Item, GridEditFormInsertItem)
            CType(item.FindControl("RadDatePicker1"), RadDateInput).SelectedDate = Date.Today
        Else
            ' edit item
        End If
    End Sub

    Private Sub SqlDataSourceInvoicesSelected_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceInvoicesSelected.Deleted
        Try
            Dim item As GridEditFormItem = CType(RadGrid1.EditItems(0), Telerik.Web.UI.GridDataItem).EditFormItem
            CType(item.FindControl("RadGridInvoicesClient"), RadGrid).DataBind()
        Catch ex As Exception

        End Try
    End Sub

    Private Sub SqlDataSource1_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSource1.Selecting
        Dim e1 As String = e.Command.Parameters(0).Value

    End Sub

    Private Sub cboPeriod_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboPeriod.SelectedIndexChanged
        IniciaPeriodo(cboPeriod.SelectedValue)
    End Sub

    Private Sub SqlDataSource1_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource1.Updating
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub

    Private Sub SqlDataSource1_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource1.Inserting
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub
End Class
