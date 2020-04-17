﻿Public Class newvendor
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewContact") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". New Vendor"
            Master.PageTitle = "Contacts/New Vendor"
            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")
            txtName.Focus()
        End If
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        Try
            SqlDataSource1.Insert()
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btbParseAddress_Click(sender As Object, e As EventArgs) Handles btbParseAddress.Click
        Try
            Dim sFullAddress As String = txtFullAddress.Text
            If Len(sFullAddress) > 0 Then
                Dim address1 As String
                Dim address2 As String
                Dim city As String
                Dim state As String
                Dim zip As String
                If LocalAPI.parseAddress(sFullAddress, address1, address2, city, state, zip) Then
                    txtAdress.Text = address1
                    txtDireccion2.Text = address2
                    txtCity.Text = city
                    txtState.Text = state
                    txtZipCode.Text = zip
                End If
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        Dim vendorId As Integer = e.Command.Parameters("@Id_OUT").Value
        Response.Redirect("~/ADM/Vendor.aspx?vendorId=" & vendorId)
    End Sub
End Class
