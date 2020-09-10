Public Class acknowledgment
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            '!!!!test
            'Session("CLIENTPORTAL_clientId") = 8506
            ' Posible entrada, client-GUID 
            If Not Request.QueryString("clientguid") Is Nothing Then
                Dim clientguid As String = Request.QueryString("clientguid")
                Session("CLIENTPORTAL_clientId") = LocalAPI.GetClientIdFromGUID(clientguid)
            End If

            ' Para navegar en CLIENT PORTAL.....................................
            lblClientId.Text = Session("CLIENTPORTAL_clientId")

            lblCompanyId.Text = LocalAPI.GetClientProperty(lblClientId.Text, "companyId")
            Master.Company = lblCompanyId.Text

            lblAcknowledgment.Text = Replace(lblAcknowledgment.Text, "[CompanyName]", LocalAPI.GetCompanyName(lblCompanyId.Text))

            PanelAcknowledgment.DataBind()
            FormViewCancel.DataBind()
            PanelAlert.Visible = False
        End If

    End Sub

    Private Sub btnAccept_Click(sender As Object, e As EventArgs) Handles btnAccept.Click
        LocalAPI.ClientAcknowledgment_INSERT(lblClientId.Text, lblAcknowledgment.Text, txtInitials.Text, Request.UserHostAddress())
        txtInitials.Text = ""
        PanelAcknowledgment.DataBind()
        FormViewCancel.DataBind()
        SowPanelAlert("Your request to Accept the Acknowledgment Form has been successfully completed. Thank you")
    End Sub

    Protected Sub SowPanelAlert(Text As String)
        PanelAlert.Visible = True
        lblAlert.Text = Text
    End Sub
    Private Sub SqlDataSourceAcknowledgment_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceAcknowledgment.Updated
        PanelAcknowledgment.DataBind()
        FormViewCancel.DataBind()
        SowPanelAlert("Your request to Cancel the Acknowledgment Form has been successfully completed. Thank you")
    End Sub
End Class