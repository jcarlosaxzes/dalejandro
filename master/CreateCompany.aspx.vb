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

    Protected Async Sub RadWizard1_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.FinishButtonClick
        Try
            LocalAPI.AppUserManager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            ' Crear la compania en la tabla Company
            SqlDataSource1.Insert()

            ' Resto de acciones en Inserted....event
        Catch ex As Exception
            'lblMsg.Text = "Error. " & ex.Message

        End Try
    End Sub

    Protected Async Sub SqlDataSource1_InsertedAsync(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        Try
            '1.- Recibimos nuevo companyId
            lblCompanyId.Text = e.Command.Parameters("@OUT_companylId").Value
            If Val(lblCompanyId.Text) > 0 Then

                lblCompanyRegistred.Text = "Congratulations " & txtContact.Text & ", the company '" & txtCompanyName.Text & "' was registered successfully! . ID=" & lblCompanyId.Text


                '2.- Crear este usuario como Employee de la company
                Await LocalAPI.NewEmployeeAsync(txtContact.Text, "Admin", 0, "", "", "", "", "", "", txtTelephone.Text, txtCellPhone.Text, txtEmail.Text, "", "", lblCompanyId.Text)

                '3.- Eliminar PreUser
                LocalAPI.EliminarpreUser(txtEmail.Text)

                Dim sEmail As String = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Email")
                If sEmail.Length > 0 Then
                    ' ¿Usuario ya existe?
                    LocalAPI.AppUserManager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()

                    If chkSendAdminCredentials.Checked Then
                        Await LocalAPI.EmployeeEmailResetPassword(sEmail)
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

    End Sub

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

