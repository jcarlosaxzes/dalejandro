Public Class cp_jobs
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            If Not IsPostBack Then

                If Not Request.QueryString("clientguid") Is Nothing Then
                    Dim clientguid As String = Request.QueryString("clientguid")
                    lblClientId.Text = LocalAPI.GetClientIdFromGUID(clientguid)
                    Session("CLIENTPORTAL_clientId") = LocalAPI.GetClientIdFromGUID(clientguid)
                Else
                    lblClientId.Text = Session("CLIENTPORTAL_clientId")
                End If

                lblCompanyId.Text = LocalAPI.GetClientProperty(lblClientId.Text, "companyId")
                Master.Company = lblCompanyId.Text

            End If
        Catch ex As Exception

        End Try

    End Sub


End Class
