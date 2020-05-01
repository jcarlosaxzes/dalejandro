Public Class thank_you_proposal
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblClientId.Text = Session("CLIENTPORTAL_clientId")

            lblCompanyId.Text = LocalAPI.GetClientProperty(lblClientId.Text, "companyId")
            'lblCompanyId.Text =260973
            Master.Company = lblCompanyId.Text

        End If

    End Sub

End Class
