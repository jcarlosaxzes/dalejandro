Public Class vendor
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblVendorId.Text = Request.QueryString("VendorId")

                If LocalAPI.IsCompanyViolation(lblVendorId.Text, "Vendors", lblCompanyId.Text) Then Response.RedirectPermanent("~/adm/schedule.aspx")

                If Not Request.QueryString("fromcontacts") Is Nothing Then
                    lblBackSource.Text = 1
                End If

                Master.PageTitle = "Contacts/Edit Vendor"
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Public Sub btnBack_Click(sender As Object, e As EventArgs)
        Back()
    End Sub
    Protected Sub FormView1_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormView1.ItemUpdated
        Master.InfoMessage("Updated Vendor Record")
    End Sub
    Private Sub Back()
        If lblBackSource.Text = 1 Then
            Response.Redirect("~/adm/contacts.aspx")
        Else
            Response.Redirect("~/adm/vendors.aspx")
        End If

    End Sub
End Class
