Public Class employees1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If Request.QueryString("companyId") <> Nothing Then
                lblCompanyId.Text = Request.QueryString("companyId")
                cboRoles.DataBind()
                SqlDataSource1.DataBind()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsert.Click
        Try
            SqlDataSource1.Insert()
            SqlDataSource1.DataBind()

        Catch ex As Exception
            lblMsg.Text = ex.Message
        End Try
    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        Dim employeeId As Integer = e.Command.Parameters("@Id_OUT").Value
        If employeeId = 0 Then
            lblMsg.Text = "No employee Inserted. Review valid Email!!!"
        Else
            lblMsg.Text = "New employee inserted. ID= " & employeeId
        End If

    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/master/company.aspx?companyId=" & lblCompanyId.Text)
    End Sub
End Class