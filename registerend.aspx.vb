Imports Microsoft.AspNet.Identity.Owin

Public Class registerend
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim sGUID As String = Request.QueryString("Id")     '"3be6a355-1b34-44a3-94d2-44840a7e1a9e" 
            txtEmail.Text = LocalAPI.preUserEmail(sGUID)
        End If
    End Sub

    Protected Async Sub btnOk_Click(sender As Object, e As EventArgs) Handles btnOk.Click
        Await CreateCompanyAndUserAsync()
    End Sub

    Private Function ValidateRegister() As Boolean
        Dim bValidate As Boolean = True
        ' 1. Ya existe una empresa con ese nombre
        If LocalAPI.IsCompany(txtCompanyName.Text) Then
            lblMsg.Text = "There is already a company with the same name"
            bValidate = False
        End If
        Return bValidate
    End Function

    Private Async Function CreateCompanyAndUserAsync() As Threading.Tasks.Task(Of Boolean)
        Try
            ' Validacion previa
            If Not ValidateRegister() Then Return False

            ' Paso 1. ¿Usuario ya existe?
            LocalAPI.AppUserManager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim existUser = LocalAPI.ExisteUserIdentity(txtEmail.Text)
            If Not existUser Then
                Dim user = New pasconcept20.ApplicationUser With {
                .Email = txtEmail.Text,
                .UserName = txtEmail.Text,
                .EmailConfirmed = True}

                Dim resutl = Await LocalAPI.AppUserManager.CreateAsync(user)
                If Not resutl.Succeeded Then
                    lblMsg.Text = resutl.Errors(0)
                    Return False
                Else
                    LocalAPI.NormalizeUser(txtEmail.Text)
                End If
            End If

            ' Paso 3 . Creamos COMPANY
            Dim companyId = SqlDataSource1.Insert()

            Return True

        Catch ex As Exception
            lblMsg.Text = ex.Message
        End Try
    End Function

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

    Protected Async Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        Try

            ' Confirmar que la company se ha creado OK
            Dim companyId As Integer = LocalAPI.GetLastCompanyCreated(txtCompanyName.Text, txtEmail.Text)
            If companyId > 0 Then

                ' Inicializar templates segun su Type
                'LocalAPI.Company_Init_TEMPLATES(companyId)

                ' Crear este usuario como Employee de la company
                'LocalAPI.NuevoEmpleado_obsolete(txtContact.Text, "Admin", 0, "", "", "", "", "", "", PhoneTextBox.Text, "", txtEmail.Text, "", "", companyId)

                Dim employeeId = Await LocalAPI.NewEmployeeAsync(txtContact.Text, "Admin", 0, "", "", "", "", "", "", PhoneTextBox.Text, "", txtEmail.Text, "", "", companyId)
                ' Eliminar PreUser
                LocalAPI.EliminarpreUser(txtEmail.Text)

                SendRegisterEndEmail(employeeId)

                Response.RedirectPermanent("~/RegisterConfirm.aspx?Step=4")
            End If

        Catch ex As Exception

        End Try
    End Sub


    Private Sub SendRegisterEndEmail(employeeId As Integer)
        Try

            Dim sName = ""
            Dim sAddress = ""
            Dim sCity = ""
            Dim sState = ""
            Dim sZipcode = ""
            Dim sPhone = ""
            Dim sCellular = ""
            Dim sEmail = ""
            Dim sHourRate = ""
            Dim startingDate = ""
            Dim sSS = ""
            Dim sDOB = ""
            Dim bInactive As Short
            Dim userGuid = ""


            Dim data = LocalAPI.GetEmployeeData(employeeId, sName, sAddress, sCity, sState, sZipcode, sPhone, sCellular, sEmail, sHourRate, startingDate, sSS, sDOB, bInactive, userGuid)


            ' Componer el Body
            Dim sMsg As New System.Text.StringBuilder
            sMsg.Append("PASconcept New Registered User")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("User: ")
            sMsg.Append(txtEmail.Text)
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Company Name: ")
            sMsg.Append(txtCompanyName.Text)
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Company Type: ")
            sMsg.Append(cboType.Text)
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Contact Name: ")
            sMsg.Append(txtContact.Text)
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Phone: ")
            sMsg.Append(PhoneTextBox.Text)
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<a href=" & """" & LocalAPI.GetHostAppSite() & "/Account/ResetPasswordConfirmation.aspx?guid=" & userGuid & """> click here to finish your account setup</a>")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append(LocalAPI.GetPASShortSign())

            SendGrid.Email.SendMail(txtEmail.Text, "", "jcarlos@axzes.com,matt@axzes.com", "PASconcept. New Registered User", sMsg.ToString, -1, 0, 0)

        Catch ex As Exception

        End Try
    End Sub

    Private Sub SqlDataSource1_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource1.Inserting
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub
End Class
