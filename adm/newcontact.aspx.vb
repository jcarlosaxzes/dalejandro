Public Class newcontact
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            lblCompanyId.Text = Session("companyId")

            ' Analisis de Cantidad en esta Caracteristica¡¡¡
            Dim CantidadPermitida As Double, CantidadActual As Double
            If LocalAPI.sys_CaracteristicaCantidad(lblCompanyId.Text, 402, Session("Version"), CantidadPermitida, CantidadActual) Then
                Response.RedirectPermanent("~/ADM/VersionFeatures.aspx?Feature=Contact Quantity (" & CantidadPermitida & ")")
            End If

            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewClient") Then Response.RedirectPermanent("~/adm/default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". New Contact"
            lblEmployee.Text = Master.UserEmail
            txtName.Focus()
        End If
    End Sub
    Private Function Validate() As Boolean
        If Len(txtName.Text) = 0 Then
            Master.ErrorMessage("Fill the name of Contact", 0)
            txtName.Focus()
        Else
            Validate = True
            'If Len(txtEmail.Text) = 0 Then
            '    Master.ErrorMessage("Fill the email of Contact", 0)
            '    txtEmail.Focus()
            'Else


            'End If
        End If
    End Function

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        Try
            If Validate() Then
                SqlDataSource1.Insert()

                If Len(txtEmail.Text) > 0 Then
                    Dim ContactId As Integer = LocalAPI.GetContactId(txtEmail.Text)
                    Response.Redirect("~/ADM/Contact.aspx?ContactId=" & ContactId)
                Else
                    Response.Redirect("~/ADM/NewContact.aspx")
                End If

            Else
                Master.ErrorMessage("There is already an Contact with Name: " & txtName.Text)
                txtName.Focus()
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub
End Class