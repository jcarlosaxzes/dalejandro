Imports Telerik.Web.UI
Public Class newclient
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            lblCompanyId.Text = Session("companyId")

            ' Analisis de Cantidad en esta Caracteristica¡¡¡
            Dim CantidadPermitida As Double, CantidadActual As Double
            If LocalAPI.sys_CaracteristicaCantidad(lblCompanyId.Text, 402, Session("Version"), CantidadPermitida, CantidadActual) Then
                Response.RedirectPermanent("~/ADM/VersionFeatures.aspx?Feature=Client Quantity (" & CantidadPermitida & ")")
            End If

            If Not Request.QueryString("fromcontacts") Is Nothing Then
                lblBackSource.Text = 1
            End If


            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewClient") Then Response.RedirectPermanent("~/ADM/Default.aspx")

                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". New Client"
                Master.PageTitle = "Clients/New Client"
                lblEmployeeEmail.Text = Master.UserEmail
                lblEmployeeId.Text = Master.UserId
                RadDatePickerStartingDate.MaxDate = Today.Date
                RadDatePickerStartingDate.SelectedDate = Today.Date
                cboSource.DataBind()
                cboSource.SelectedValue = 0
                cboSource.Focus()
            End If
    End Sub
    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        Try
            If Not LocalAPI.IsClientName(txtName.Text, lblCompanyId.Text) Then
                Dim clientId As Integer = LocalAPI.Client_INSERT(txtName.Text, txtEmail.Text, txtInitials.Text, lblCompanyId.Text, txtCompany.Text,
                                          txtAdress.Text, txtDireccion2.Text, txtCity.Text, txtState.Text, txtZipCode.Text, txtPhone.Text, txtCellular.Text,
                                          "", txtWeb.Text, RadDatePickerStartingDate.SelectedDate, txtPosition.Text, txtBillingContact.Text, txtBillingTelephone.Text, "",
                                          cboType.SelectedValue, cboSubtype.SelectedValue, cboTags.Text, txtBillingEmail.Text, cboSource.Text, cboNAICS.SelectedValue, lblEmployeeId.Text)

                Back()
            Else
                Master.ErrorMessage("There is already an client with Name: " & txtName.Text)
                txtName.Focus()
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub cboType_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboType.SelectedIndexChanged
        cboSubtype.Items.Clear()
        cboSubtype.Items.Insert(0, New RadComboBoxItem("(Subtypes Not Defined...)", 0))
        cboSubtype.DataBind()
        cboSubtype.SelectedValue = 0

    End Sub
    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Back()
    End Sub

    Private Sub Back()
        If lblBackSource.Text = 1 Then
            Response.Redirect("~/adm/contacts.aspx")
        Else
            Response.Redirect("~/adm/clients.aspx")
        End If

    End Sub
End Class
