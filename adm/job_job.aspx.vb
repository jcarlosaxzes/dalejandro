Imports Microsoft.AspNet.Identity

Public Class Job_job
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")

                lblEmployeeEmail.Text = Master.UserEmail
                lblEmployeeId.Text = Master.UserId

                lblJobId.Text = Request.QueryString("JobId")

                btnUpdate.Visible = LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Deny_NewJob")

                FormView1.DataBind()

                lblTags.Text = LocalAPI.ConvertSpanTags(LocalAPI.GetJobsTagsList(lblJobId.Text))
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        Try
            FormView1.UpdateItem(True)
            FormView1.DataBind()
            Master.InfoMessage("Job updated!")
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub FormView1_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormView1.ItemUpdated
        Try
            LocalAPI.JobGeolocationUpdate(lblJobId.Text)
        Catch ex As Exception

        End Try

    End Sub
End Class
