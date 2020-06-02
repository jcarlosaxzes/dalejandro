﻿Public Class vendor
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblVendorId.Text = Request.QueryString("VendorId")
                If LocalAPI.IsCompanyViolation(lblVendorId.Text, "Vendors", lblCompanyId.Text) Then Response.RedirectPermanent("~/ADM/Default.aspx")
                Master.PageTitle = "Contacts/Edit Vendor"
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/vendors")
    End Sub
    Protected Sub FormView1_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormView1.ItemUpdated
        Master.InfoMessage("Updated Vendor Record")
    End Sub

End Class
