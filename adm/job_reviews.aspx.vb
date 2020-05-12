Public Class job_reviews
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblJobId.Text = Request.QueryString("JobId")

                If LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Type") = 16 Then
                    ' Programmers/Computer/IT
                    Panel16Type.Visible = True
                Else
                    ' Engieniering Co...
                    Panel16Type.Visible = False
                End If

                PanelNo16Type.Visible = Not Panel16Type.Visible

            End If


        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub
    Protected Sub btnNewReview_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewReview.Click
        Try
            SqlDataSourceReviewsPermits.Insert()
            RadGridReviewsPermits.DataBind()
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub btnAddAppName_Click(sender As Object, e As EventArgs) Handles btnAddAppName.Click
        RadGridAppName.MasterTableView.InsertItem()
    End Sub

    Private Sub btnAddModule_Click(sender As Object, e As EventArgs) Handles btnAddModule.Click
        RadGridLocationModule.MasterTableView.InsertItem()
    End Sub
End Class
