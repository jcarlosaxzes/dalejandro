﻿Public Class newsubconsultant
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewSubconsultant") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". New Subconsultant"
            Master.PageTitle = "Subconsultants/New Subconsultant"
            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")
            RadDatePickerStartingDate.MaxDate = Today.Date
            RadDatePickerStartingDate.SelectedDate = Today.Date
            txtName.Focus()
        End If
    End Sub
    Private Function Validate() As Boolean
        If Len(txtName.Text) = 0 Then
            Master.ErrorMessage("Fill the name of subconsultant", 0)
            txtName.Focus()
        Else
            If Len(txtEmail.Text) = 0 Then
                Master.ErrorMessage("Fill the email of subconsultant", 0)
                txtEmail.Focus()
            Else
                If Len(txtInitials.Text) = 0 Then
                    Master.ErrorMessage("Fill the initials of subconsultant", 0)
                    txtInitials.Focus()
                Else
                    Validate = True
                End If
            End If
        End If
    End Function

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        Try
            If Validate() Then
                If Not LocalAPI.IsSubConsultanInitials(txtInitials.Text, lblCompanyId.Text) Then
                    If Not LocalAPI.IsSubConsultanEmail(txtEmail.Text, lblCompanyId.Text) Then
                        Dim subconsultantId As Integer = LocalAPI.NewSubConsultant(txtName.Text, txtEmail.Text, txtInitials.Text, lblCompanyId.Text, cboDiscipline.SelectedValue, txtCompany.Text,
                                              txtAdress.Text, txtDireccion2.Text, txtCity.Text, txtState.Text, txtZipCode.Text, txtPhone.Text, txtCellular.Text,
                                              txtFax.Text, txtWeb.Text, RadDatePickerStartingDate.SelectedDate, txtPosition.Text, txtBillingContact.Text, txtBillingTelephone.Text, txtNotes.Text)
                        If subconsultantId > 0 Then
                            Response.Redirect("~/ADM/SubConsultant.aspx?subconsultantId=" & subconsultantId)
                        Else
                            Master.ErrorMessage("Duplicate Subconsultant Email", 0)
                            txtEmail.Focus()
                        End If
                    Else
                        Master.ErrorMessage("Duplicate Subconsultant Email", 0)
                        txtEmail.Focus()
                    End If
                Else
                    Master.ErrorMessage("Duplicate Subconsultant code", 0)
                    txtInitials.Focus()
                End If
            End If
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

End Class
