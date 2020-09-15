Public Class sendstatement
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Me.Title = "Statement Invoice" & lblStatementId.Text
            If (Not Page.IsPostBack) Then

                lblStatementId.Text = Request.QueryString("StatementNo")
                lblCompanyId.Text = LocalAPI.GetCompanyIdFromStatement(lblStatementId.Text)

                lblEmployeeEmail.Text = Master.UserEmail
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)

                txtBody.DisableFilter(Telerik.Web.UI.EditorFilters.ConvertFontToSpan)  ' Evita un error de ConvertFontToSpan
                If lblStatementId.Text > 0 Then
                    lblOrigen.Text = "" & Request.QueryString("Origen")
                    If Len(lblOrigen.Text) = 0 Then lblOrigen.Text = "1"

                    Select Case lblOrigen.Text
                        Case 5, 6, 7   ' Desde Perfil Client, no hay opciones de Mail
                            PanelEmail.Visible = False
                        Case Else   ' Desde Admin
                            Dim clientId As Integer = LocalAPI.GetStatementProperty(lblStatementId.Text, "clientId")
                            txtTo.Text = LocalAPI.GetClientEmail(clientId)

                            txtCC.Text = LocalAPI.GetBillingContactEmailFromStatement(lblStatementId.Text)

                            LeerStatementTemplate()
                    End Select


                End If
            End If
        Catch ex As Exception
            lblMailResult.Text = ex.Message
        End Try
    End Sub


    Private Sub LeerStatementTemplate()

        Dim sClienteName = LocalAPI.GetStatementProperty(lblStatementId.Text, "[Clients].[Name]")
        Dim sSign As String = LocalAPI.GetEmployeesSign(lblEmployeeId.Text)
        Dim statementNumber As String = LocalAPI.GetStatementNumber(lblStatementId.Text)

        Dim DictValues As Dictionary(Of String, String) = New Dictionary(Of String, String)
        DictValues.Add("[Project_Name]", sClienteName)
        DictValues.Add("[Sign]", sSign)
        DictValues.Add("[Statement_Number]", statementNumber)
        DictValues.Add("[PASSign]", LocalAPI.GetPASSign())

        ' Leer subjet y body template
        txtSubject.Text = LocalAPI.GetMessageTemplateSubject("Statement", lblCompanyId.Text, DictValues)
        txtBody.Content = LocalAPI.GetMessageTemplateBody("Statement", lblCompanyId.Text, DictValues)

    End Sub
    Protected Sub btnEnviar_Click(sender As Object, e As EventArgs) Handles btnEnviar.Click
        Try


            If txtTo.Text.Length > 0 Then
                If cboEmittingStatement.SelectedValue = 1 Then
                    LocalAPI.ActualizarEmittedStatetment(lblStatementId.Text)
                End If

                txtBody.Content = txtBody.Content & LocalAPI.GetPASSign()
                LocalAPI.SetInvoiceEmittedFromStatement(lblStatementId.Text)

                Dim SenderDisplay = LocalAPI.GetEmployeeName(lblEmployeeId.Text)
                Dim AccountantEmail As String = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "AccountantEmail")
                If Not LocalAPI.ValidEmail(AccountantEmail) Then
                    AccountantEmail = AccountantEmail
                End If

                Dim clientId As Integer = LocalAPI.GetStatementProperty(lblStatementId.Text, "clientId")
                If SendGrid.Email.SendMail(txtTo.Text, txtCC.Text, AccountantEmail, txtSubject.Text, txtBody.Content, lblCompanyId.Text, clientId, 0,, SenderDisplay, lblEmployeeEmail.Text, SenderDisplay) Then
                    lblMailResult.Text = "Statement successfully sent"

                    btnEnviar.Enabled = False
                End If

                LocalAPI.NewAutomaticStatementReminderFromEmitted(lblStatementId.Text, lblEmployeeId.Text, lblCompanyId.Text)

            Else
                lblMailResult.Text = "Email of '" & txtTo.Text & "' is nothing"
            End If

        Catch ex As Exception
            lblMailResult.Text = "Email sending error." & ex.Message
        End Try
    End Sub

End Class
