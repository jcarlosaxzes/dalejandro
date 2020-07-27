Public Class pdf_print
    Inherits System.Web.UI.Page

    Protected Async Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim pdf As PdfApi = New PdfApi()
        Dim url = Session("PrintUrl")
        Dim Name = Session("PrintName")
        Dim pdfBytes = Await pdf.GetConvertApiPdf(url)
        Response.ContentType = "application/pdf"
        Response.AddHeader("Content-Disposition", $"attachment; filename={Name}")
        Response.ClearContent()
        Response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length)
        Response.Flush()
    End Sub

End Class