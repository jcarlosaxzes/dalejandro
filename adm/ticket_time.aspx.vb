Public Class ticket_time
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblTicketId.Text = Request.QueryString("JobTicketId")
                If Not Request.QueryString("JobId") Is Nothing Then
                    lblJobId.Text = Request.QueryString("JobId")
                Else
                    lblJobId.Text = "-1"
                End If
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/jobtickets.aspx" & IIf(lblJobId.Text > 0, "?JobId=" & lblJobId.Text, ""))
    End Sub
End Class
