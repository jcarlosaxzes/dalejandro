Imports Microsoft.AspNet.Identity.Owin
Imports Telerik.Web.UI

Public Class CreateCompany
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Master.PageTitle = "Create Company Account"
            lblCompanyId.Text = "-1"

            SqlDataSourceVersion.DataBind()
            cboVersion.DataBind()
            cboVersion.SelectedValue = 2
        End If
    End Sub

    'Protected Sub btnCredentials_Click(ByVal sender As Object, ByVal e As System.EventArgs)
    '    Dim companyId As String = CType(sender, ImageButton).CommandArgument
    '    SendMasterCredentilas(Val(companyId))

    'End Sub

    Protected Sub RadWizard1_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.FinishButtonClick
        Try
            ' Crear la compania en la tabla Company
            SqlDataSource1.Insert()

            ' Resto de acciones en Inserted....event
        Catch ex As Exception
            'lblMsg.Text = "Error. " & ex.Message

        End Try
    End Sub

    Protected Async Function SqlDataSource1_InsertedAsync(sender As Object, e As SqlDataSourceStatusEventArgs) As Threading.Tasks.Task Handles SqlDataSource1.Inserted
        Try
            '1.- Recibimos nuevo companyId
            lblCompanyId.Text = e.Command.Parameters("@OUT_companylId").Value
            If Val(lblCompanyId.Text) > 0 Then

                lblCompanyRegistred.Text = "Congratulations " & txtContact.Text & ", the company '" & txtCompanyName.Text & "' was registered successfully! . ID=" & lblCompanyId.Text


                '2.- Crear este usuario como Employee de la company
                LocalAPI.NewEmployee(txtContact.Text, "Admin", 0, "", "", "", "", "", "", txtTelephone.Text, txtCellPhone.Text, txtEmail.Text, "", "", lblCompanyId.Text)

                '3.- Eliminar PreUser
                LocalAPI.EliminarpreUser(txtEmail.Text)


                Dim sEmail As String = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Email")
                If sEmail.Length > 0 Then

                    ' ¿Usuario ya existe?
                    LocalAPI.AppUserManager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
                    Dim existUser = LocalAPI.ExisteUserIdentity(sEmail)
                    If Not existUser Then
                        Dim user = New pasconcept20.ApplicationUser With {
                        .Email = txtEmail.Text,
                        .UserName = txtEmail.Text,
                        .EmailConfirmed = True}
                        Dim resutl = Await LocalAPI.AppUserManager.CreateAsync(user)
                        If Not resutl.Succeeded Then
                            lblMsg.Text = resutl.Errors(0)
                        Else
                            LocalAPI.NormalizeUser(txtEmail.Text)
                        End If
                    End If

                    If chkSendGetStarted.Checked Then
                        If LocalAPI.PASconceptGetStartedEmail(lblCompanyId.Text) Then
                            LocalAPI.ExecuteNonQuery("UPDATE [Company] SET [GetStartedEmailDate]=dbo.CurrentTime() WHERE companyId=" & lblCompanyId.Text)
                            lblGetStartedEmail.Text = "The Email to Get Started was sent successfully!"
                        End If
                    End If
                End If

            End If
        Catch ex As Exception
            lblMsg.Text = "Error. " & ex.Message
        End Try

    End Function

    Private Sub cboClient_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboClient.SelectedIndexChanged
        cboJob.Items.Clear()
        cboJob.Items.Insert(0, New RadComboBoxItem("(Create NEW Axzes Job...)", 0))

        cboJob.DataBind()
    End Sub

    Private Sub btnBindCompanyToAxzes_Click(sender As Object, e As EventArgs) Handles btnBindCompanyToAxzes.Click
        '6.- Crear/seleccionar cliente equivalente en AXZES, companyId=260973
        Dim clientId As Integer = LocalAPI.BindCompanyToAxzesClient(lblCompanyId.Text, cboClient.SelectedValue)
        cboClient.Enabled = False

        '7.- Crear cliente equivalente en AXZES, companyId=260973
        LocalAPI.BindCompanyToAxzesJob(lblCompanyId.Text, clientId, cboJob.SelectedValue)
        cboJob.Enabled = True

        lblBinding.Text = "The Company has been linked to a Client and Job of Axzes successfully!!!"
        btnBindCompanyToAxzes.Visible = False
        btnGoCompanyList.Visible = True
    End Sub

    Private Sub btnGoCompanyList_Click(sender As Object, e As EventArgs) Handles btnGoCompanyList.Click
        Response.Redirect("~/MASTER/CompanyList.aspx")
    End Sub
End Class

