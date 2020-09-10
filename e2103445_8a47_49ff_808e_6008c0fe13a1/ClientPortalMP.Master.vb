Public Class ClientPortalMP1
    Inherits System.Web.UI.MasterPage

    Public WriteOnly Property Company() As String
        Set(ByVal value As String)
            lblCompanyId.Text = value
            FormViewCompany.DataBind()
            Panels()
        End Set
    End Property

    Public WriteOnly Property Guid() As String
        Set(ByVal value As String)
            lblGuid.Text = value
        End Set
    End Property

    Public WriteOnly Property Type() As String
        Set(ByVal value As String)
            lblType.Text = value
        End Set
    End Property

    Private Sub Panels()
        'CType(FormViewCompany.FindControl("pnl_advertising"), Panel).Visible = False '(lblCompanyId.Text = 260962)
        pnl_reviews.Visible = (lblCompanyId.Text = 260962)
    End Sub



    Public Sub ErrorMessage(ByVal sText As String, Optional ByVal SecondsAutoCloseDelay As Integer = 0)
        If sText.Length > 0 Then
            RadNotificationError.Title = "Error message"
            RadNotificationError.Text = sText
            RadNotificationError.AutoCloseDelay = SecondsAutoCloseDelay * 1000
            RadNotificationError.Show()
        End If
    End Sub

    Public Sub InfoMessage(ByVal sText As String, Optional ByVal SecondsAutoCloseDelay As Integer = 3)
        If sText.Length > 0 Then
            RadNotificationWarning.Title = "Info message"
            RadNotificationWarning.Text = sText
            RadNotificationWarning.AutoCloseDelay = SecondsAutoCloseDelay * 1000
            RadNotificationWarning.Show()
        End If
    End Sub

    Protected Async Sub Print_ServerClick(sender As Object, e As EventArgs)
        If lblType.Text = "Invoice" Then
            Dim pdf As PdfApi = New PdfApi()
            Dim InvoiceId = LocalAPI.GetSharedLink_Id(4, lblGuid.Text)
            Dim companyId = LocalAPI.GetCompanyIdFromInvoice(InvoiceId)
            Dim pdfBytes = Await pdf.CreateInvoicePdfBytes(companyId, InvoiceId)
            Dim response As HttpResponse = HttpContext.Current.Response
            response.ContentType = "application/pdf"
            response.AddHeader("Content-Disposition", "attachment; filename=Invoice.pdf")
            response.ClearContent()
            response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length)
            response.Flush()
        End If

        If lblType.Text = "Statement" Then
            Dim pdf As PdfApi = New PdfApi()
            Dim statementId = LocalAPI.GetSharedLink_Id(5, lblGuid.Text)
            Dim companyId = LocalAPI.GetCompanyIdFromStatement(statementId)
            Dim pdfBytes = Await pdf.CreateStatementsPdfBytes(companyId, statementId)
            Dim response As HttpResponse = HttpContext.Current.Response
            response.ContentType = "application/pdf"
            response.AddHeader("Content-Disposition", "attachment; filename=statement.pdf")
            response.ClearContent()
            response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length)
            response.Flush()
        End If

    End Sub
End Class

