Public Class paymenthistory
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            If Not IsPostBack Then

                ' Posible entrada, client-GUID 
                If Not Request.QueryString("clientguid") Is Nothing Then
                    Dim clientguid As String = Request.QueryString("clientguid")
                    Session("CLIENTPORTAL_clientId") = LocalAPI.GetClientIdFromGUID(clientguid)
                End If

                ' Para navegar en CLIENT PORTAL.....................................
                lblClientId.Text = Session("CLIENTPORTAL_clientId")

                lblCompanyId.Text = LocalAPI.GetClientProperty(lblClientId.Text, "companyId")
                Master.Company = lblCompanyId.Text
            End If
        Catch ex As Exception

        End Try

    End Sub
End Class
