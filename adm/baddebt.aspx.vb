Public Class baddebt
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            lblCompanyId.Text = Session("companyId")
            lblInvoiceId.Text = Request.QueryString("invoiceId")
            'lblInvoiceId.Text = "31495"
            Title = "BadDebt: " & LocalAPI.GetInvoiceProperty(lblInvoiceId.Text, "InvoiceNumber")
        End If

    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        'btnUpdate.Visible=True
        'btnUpdate.DataBind
        divBtn.Style.Add("display", "none")

        SqlDataSourceInvoice.Update()
        lblMsg.Text = "Invoiced saved as BadDebt!"
        lblMsg.Visible = True
    End Sub
End Class
