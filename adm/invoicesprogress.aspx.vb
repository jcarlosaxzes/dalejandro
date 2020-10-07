Public Class invoicesprogress
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                lblCompanyId.Text = Session("companyId")
                lblJobId.Text = Request.QueryString("jobId")
                lblinvoicelId.Text = Request.QueryString("invoiceId")


                If Val(lblinvoicelId.Text) = 0 Then
                    ' Insert
                    panelEdit.Visible = False
                    panelInsert.Visible = True
                    btnUpdate.Visible = False
                    lblInvoiceNumber.Text = "New"
                    RadDatePicker1.DbSelectedDate = Now
                    txtInvoiceNotes.Text = "Progress Invoice"
                Else
                    'Update
                    panelInsert.Visible = False
                    panelEdit.Visible = True
                    ReadInvoice()
                End If
                lblJob.Text = LocalAPI.GetJobCodeName(lblJobId.Text)
                lblClient.Text = LocalAPI.GetClientName(lClientId:=LocalAPI.GetJobProperty(lblJobId.Text, "Client"))

                If Not Request.QueryString("backpage") Is Nothing Then
                    Session("invoicesprogressbackpage") = Request.QueryString("backpage")
                Else
                    Session("invoicesprogressbackpage") = ""
                End If

            End If

        Catch ex As Exception

        End Try
    End Sub
    Private Sub Back()
        Select Case Request.QueryString("backpage")
            Case "invoices"
                Response.Redirect("~/adm/invoices.aspx")
            Case Else
                Dim sUrl As String = LocalAPI.GetSharedLink_URL(8002, lblJobId.Text)
                Response.Redirect(sUrl)
        End Select

    End Sub
    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Back()
    End Sub

    Private Sub btnInsert_Click(sender As Object, e As EventArgs) Handles btnInsert.Click
        Try

            ' Insert Invoices and Details
            lblinvoicelId.Text = LocalAPI.ProgressInvoices_INSERT(lblJobId.Text, cboProgressRefrence.SelectedValue, RadDatePicker1.DbSelectedDate, RadDatePickerMaturityDate.DbSelectedDate, txtInvoiceNotes.Text, Master.UserId)
            If lblinvoicelId.Text > 0 Then
                Response.Redirect("~/adm/invoicesprogress.aspx?jobId=" & lblJobId.Text & "&invoiceId=" & lblinvoicelId.Text)
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub
    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub

    Protected Sub ReadInvoice()
        Try

            lblInvoiceNumber.Text = LocalAPI.InvoiceNumber(lblinvoicelId.Text)
            Dim InvoiceObject = LocalAPI.GetRecord(lblinvoicelId.Text, "Invoice_v20_SELECT")
            lblInvoiceAmount.Text = FormatCurrency(InvoiceObject("Amount"))
            txtInvoiceNotes.Text = InvoiceObject("InvoiceNotes")
            RadDatePicker1.DbSelectedDate = InvoiceObject("InvoiceDate")
            RadDatePickerMaturityDate.DbSelectedDate = InvoiceObject("MaturityDate")
        Catch ex As Exception

        End Try
    End Sub
    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        Try
            If RadDatePickerMaturityDate.DbSelectedDate = Nothing Then
                LocalAPI.ExecuteNonQuery($"UPDATE [Invoices] SET [InvoiceNotes]='{txtInvoiceNotes.Text}',InvoiceDate='{RadDatePicker1.DbSelectedDate}', [MaturityDate]=Null WHERE Id={lblinvoicelId.Text}")
            Else
                LocalAPI.ExecuteNonQuery($"UPDATE [Invoices] SET [InvoiceNotes]='{txtInvoiceNotes.Text}',InvoiceDate='{RadDatePicker1.DbSelectedDate}', [MaturityDate]='{RadDatePickerMaturityDate.DbSelectedDate}' WHERE Id={lblinvoicelId.Text}")

            End If
        Catch ex As Exception
        End Try
    End Sub
    Private Sub btnUpdateAndBack_Click(sender As Object, e As EventArgs) Handles btnUpdateAndBack.Click
        Try
            If RadDatePickerMaturityDate.DbSelectedDate = Nothing Then
                LocalAPI.ExecuteNonQuery($"UPDATE [Invoices] SET [InvoiceNotes]='{txtInvoiceNotes.Text}',InvoiceDate='{RadDatePicker1.DbSelectedDate}', [MaturityDate]=Null WHERE Id={lblinvoicelId.Text}")
            Else
                LocalAPI.ExecuteNonQuery($"UPDATE [Invoices] SET [InvoiceNotes]='{txtInvoiceNotes.Text}',InvoiceDate='{RadDatePicker1.DbSelectedDate}', [MaturityDate]='{RadDatePickerMaturityDate.DbSelectedDate}' WHERE Id={lblinvoicelId.Text}")

            End If
            Back()
        Catch ex As Exception
        End Try

    End Sub

    Private Sub SqlDataSource1_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Updated
        ReadInvoice()
    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        ReadInvoice()
    End Sub

    Private Sub SqlDataSource1_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Deleted
        ReadInvoice()
    End Sub

End Class