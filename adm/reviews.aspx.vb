Public Class reviews
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblJobId.Text = Request.QueryString("JobId")

            End If


        Catch ex As Exception

        End Try
    End Sub
End Class

