Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Borrar todas las variables de sesion
            Session.Abandon()

            If Not Request.QueryString("IPAddress") Is Nothing Then
                lblIPAddress.Text = Request.QueryString("IPAddress")
            Else
                If Request.QueryString("LoginRole") Is Nothing Then
                    Response.RedirectPermanent("~/adm/schedule.aspx")
                End If
            End If

        End If
    End Sub

End Class