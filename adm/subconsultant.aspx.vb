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

    Protected Sub FormView1_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles FormView1.ItemUpdating
        lblStatus.Text = ""
    End Sub
End Class
