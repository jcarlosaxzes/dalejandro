Public Class subconsultant
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblSubconsultantId.Text = Request.QueryString("SubconsultantId")
                Master.PageTitle = "Subconsultants/Edit Subconsultant: " & LocalAPI.GetSubConsultanName(lblSubconsultantId.Text)

            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Protected Sub FormView1_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormView1.ItemUpdated
        lblStatus.Text = "Updated Subconsultant Details"
    End Sub
    Private Sub btnTotals_Click(sender As Object, e As EventArgs) Handles btnTotals.Click
        FormViewSubconsultBalance.Visible = Not FormViewSubconsultBalance.Visible
    End Sub
    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/subconsultants.aspx")
    End Sub

End Class
