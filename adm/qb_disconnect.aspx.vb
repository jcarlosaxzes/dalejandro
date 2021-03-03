Public Class qb_disconnect
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            btnDisconnect.Visible = qbAPI.IsValidAccessToken(Session("companyId"))
            PanelConnected.Visible = btnDisconnect.Visible
            PanelDisconnected.Visible = Not btnDisconnect.Visible

        End If
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/" & Session("QBAuthBackPage") & IIf(Len(Session("QBAuthBackPageJobId")) > 0, "?JobId=" & Session("QBAuthBackPageJobId"), ""))
    End Sub

    Private Sub btnDisconnect_Click(sender As Object, e As EventArgs) Handles btnDisconnect.Click
        Threading.Tasks.Task.Run(Function() qbAPI.RevokeDisconnectTokenAsync(Session("companyId")))
        btnDisconnect.Visible = False
        PanelConnected.Visible = btnDisconnect.Visible
        PanelDisconnected.Visible = Not btnDisconnect.Visible
    End Sub

End Class