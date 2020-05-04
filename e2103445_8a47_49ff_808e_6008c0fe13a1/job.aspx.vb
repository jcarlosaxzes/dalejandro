Public Class job
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then

            If Not Request.QueryString("guid") Is Nothing Then
                Dim guid As String = Request.QueryString("guid")
                lblJobId.Text = LocalAPI.GetJobIdFromGUID(guid)
                lblCompanyId.Text = LocalAPI.GetJobProperty(lblJobId.Text, "companyId")

                imgGoogleStreetview.DataBind()

                Me.Title = LocalAPI.GetJobCode(lblJobId.Text)
            End If
        End If
    End Sub
End Class
