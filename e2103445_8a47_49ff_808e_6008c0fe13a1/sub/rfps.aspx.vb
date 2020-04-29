Public Class rfps1
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            If Not IsPostBack Then

                ' Posible entrada, subconsultant-GUID 
                If Not Request.QueryString("subconsultantguid") Is Nothing Then
                    Dim subconsultantguid As String = Request.QueryString("subconsultantguid")
                    Session("SUBCONSULTANT_subconsultantId") = LocalAPI.GetSubconsultantIdFromGUID(subconsultantguid)
                End If

                ' Para navegar en subconsultant PORTAL.....................................
                lblSubconsultantId.Text = Session("SUBCONSULTANT_subconsultantId")

                lblCompanyId.Text = LocalAPI.GetSubconsultantProperty(lblSubconsultantId.Text, "companyId")
                Master.Company = lblCompanyId.Text
            End If
        Catch ex As Exception

        End Try

    End Sub
End Class
