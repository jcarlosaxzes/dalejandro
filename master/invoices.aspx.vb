Public Class invoices1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            If Request.QueryString("StatusId") <> Nothing Then
                cboStatus.DataBind()
                cboStatus.SelectedValue = Request.QueryString("StatusId")
            End If
        End If
    End Sub
    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Select Case e.CommandName
            Case "BindAxzesInvoice"
                lblSelectedInvoiceId.Text = e.CommandArgument
                Dim companyId As Integer = LocalAPI.GetCompanyPaymentsProperty(lblSelectedInvoiceId.Text, "companyId")
                lblCompanyName.Text = LocalAPI.GetCompanyName(companyId)
                lblJobId.Text = LocalAPI.GetCompanyProperty(companyId, "AxzesJobId")
                cboAxzesInvoices.DataBind()
                cboAxzesInvoices.SelectedValue = LocalAPI.GetCompanyPaymentsProperty(lblSelectedInvoiceId.Text, "AxzesInvoiceId")

                RadToolTipBindAxzesClient.Visible = True
                RadToolTipBindAxzesClient.Show()
        End Select
    End Sub

    Private Sub btnBindAxzesInvoice_Click(sender As Object, e As EventArgs) Handles btnBindAxzesInvoice.Click
        ' Binding Invoice
        Dim clientId As Integer = LocalAPI.BindCompanyToAxzesInvoice(lblJobId.Text, lblSelectedInvoiceId.Text, cboAxzesInvoices.SelectedValue)
        RadGrid1.DataBind()
    End Sub
End Class
