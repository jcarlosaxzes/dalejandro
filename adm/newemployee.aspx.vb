Public Class newemployee
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")

            ' Analisis de Cantidad en esta Caracteristica¡¡¡
            Dim CantidadPermitida As Double, CantidadActual As Double
            If LocalAPI.sys_CaracteristicaCantidad(lblCompanyId.Text, 602, Session("Version"), CantidadPermitida, CantidadActual) Then
                Response.RedirectPermanent("~/ADM/VersionFeatures.aspx?Feature=Employee Quantity (" & CantidadPermitida & ")")
            End If

            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewEmployee") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Master.PageTitle = "Employees/New Employee"
            Title = ConfigurationManager.AppSettings("Titulo") & ". New Employee"
            RadDatePickerStartingDate.MaxDate = Today.Date
            RadDatePickerDOB.MinDate = "01/01/1930"
            InicializarFormulario()
        End If

    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        Try

            Dim employeeId As Integer = e.Command.Parameters("@Id_OUT").Value
            If employeeId > 0 Then

                ' En cualquier caso, le rectifico como employee.
                LocalAPI.RefrescarUsuarioVinculado(employeeId, "Empleados")
                Try
                Catch ex As Exception
                End Try


                'If chkAdmin.Checked Then
                '    ' Administrator
                '    Roles.AddUserToRole(employeeId, "Administradores")
                'Else
                '    ' Only Employee
                '    Roles.RemoveUserFromRole(employeeId, "Administradores")
                'End If

                ' Employee Role
                If cboSourceRole.SelectedValue > 0 Then
                    lblNewEmployeeInsertedId.Text = employeeId
                    SqlDataSource1.Update()
                End If

                ' Afectaciones al Multiplier y Department Target
                LocalAPI.CompanyCalculateMultiplier(lblCompanyId.Text, Year(Today))
                Dim dbMultiplier As Double = LocalAPI.GetCompanyMultiplier(lblCompanyId.Text, Year(Today))
                LocalAPI.DeparmentBudgetByBaseSalaryForMultiplierFromThisMonth(lblCompanyId.Text, dbMultiplier, Year(Today), Month(Today))

                ' Parasa a Edit....
                Response.RedirectPermanent("~/ADM/Employee.aspx?employeeId=" & employeeId)
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNuevo.Click
        Try
            If Not LocalAPI.IsEmployeeEmail(txtEmail.Text, lblCompanyId.Text) Then
                SqlDataSource1.Insert()
            Else
                Master.ErrorMessage("There is already an employee with email: " & txtEmail.Text)
                txtEmail.Focus()
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Sub
    Protected Function GetErrorMessage(ByVal status As MembershipCreateStatus) As String

        Select Case status
            Case MembershipCreateStatus.DuplicateUserName
                Return "Username already exists. Please enter a different user na"

            Case MembershipCreateStatus.DuplicateEmail
                Return "A username for that e-mail address already exists. Please enter a different e-mail address."

            Case MembershipCreateStatus.InvalidPassword
                Return "The password provided is invalid. Please enter a valid password value."

            Case MembershipCreateStatus.InvalidEmail
                Return "The e-mail address provided is invalid. Please check the value and try again."

            Case MembershipCreateStatus.InvalidAnswer
                Return "The password retrieval answer provided is invalid. Please check the value and try again."

            Case MembershipCreateStatus.InvalidQuestion
                Return "The password retrieval question provided is invalid. Please check the value and try again."

            Case MembershipCreateStatus.InvalidUserName
                Return "The user name provided is invalid. Please check the value and try again."

            Case MembershipCreateStatus.ProviderError
                Return "The authentication provider Returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator."

            Case MembershipCreateStatus.UserRejected
                Return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator."

            Case Else
                Return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator."
        End Select
    End Function

    Private Sub InicializarFormulario()
        ' Inicializar formulario
        txtName.Text = ""
        txtDireccion.Text = ""
        txtCiudad.Text = ""
        txtState.Text = ""
        txtZipCode.Text = ""
        txtTelefono.Text = ""
        txtCellular.Text = ""
        txtEmail.Text = ""
        txtHourRate.Text = "0"
        RadDatePickerStartingDate.SelectedDate = Today.Date
        'RadDatePickerDOB.SelectedDate = RadDatePickerDOB.MinDate
    End Sub

End Class
