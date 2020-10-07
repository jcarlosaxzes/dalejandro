Public Class sendtransmittal
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Title = "Transmittal" & lblTransmittalId.Text
        If (Not Page.IsPostBack) Then

            lblTransmittalId.Text = Request.QueryString("TransmittalId")
            lblCompanyId.Text = Session("companyId")

            lblEmployeeEmail.Text = Master.UserEmail
            lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)

            txtBody.DisableFilter(Telerik.Web.UI.EditorFilters.ConvertFontToSpan)  ' Evita un error de ConvertFontToSpan
            If lblTransmittalId.Text > 0 Then
                LeerTransmittalTemplate()
            End If

            If Not Request.QueryString("BackPage") Is Nothing Then
                lblBackPage.Text = Request.QueryString("BackPage")
                btnBack.Visible = True
            Else
                btnBack.Visible = False
            End If

        End If
    End Sub
    Private Sub LeerTransmittalTemplate()
        Try
            ' Variables
            Dim TansmittalObject = LocalAPI.GetRecord(lblTransmittalId.Text, "Transmittal_v20_SELECT")

            Dim sSign As String = LocalAPI.GetEmployeesSign(lblEmployeeId.Text)

            ' Leer subjet y body template
            txtSubject.Text = LocalAPI.GetMessageTemplateSubject("DeliveryTransmittalDigital", lblCompanyId.Text)
            Dim sBody As String = LocalAPI.GetMessageTemplateBody("DeliveryTransmittalDigital", lblCompanyId.Text)

            txtTo.Text = TansmittalObject("Email")
            txtCC.Text = lblEmployeeEmail.Text
            ' sustituir variables
            txtSubject.Text = Replace(txtSubject.Text, "[Transmittal Number]", TansmittalObject("TransmittalID"))
            txtSubject.Text = Replace(txtSubject.Text, "[Project Name]", TansmittalObject("JobName"))


            sBody = Replace(sBody, "[Transmittal Number]", TansmittalObject("TransmittalID"))
            sBody = Replace(sBody, "[Project Name]", TansmittalObject("JobName"))
            sBody = Replace(sBody, "[Client Name]", TansmittalObject("ClientNameAndCompany"))
            sBody = Replace(sBody, "[Sign]", sSign)

            ' Enlace al Transmittal with EntityTyp=4
            Dim sURL As String = LocalAPI.GetSharedLink_URL(6666, lblTransmittalId.Text)
            sBody = Replace(sBody, "[PASconceptLink]", sURL)

            txtBody.Content = sBody

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnEnviar_Click(sender As Object, e As EventArgs) Handles btnEnviar.Click
        Try


            If txtTo.Text.Length > 0 Then

                Dim TansmittalObject = LocalAPI.GetRecord(lblTransmittalId.Text, "Transmittal_v20_SELECT")

                txtBody.Content = txtBody.Content & LocalAPI.GetPASSign()
                'LocalAPI.SetTransmittalEmittedFromTransmittal(lblTransmittalId.Text)

                Dim SenderDisplay = LocalAPI.GetEmployeeName(lblEmployeeId.Text)

                If SendGrid.Email.SendMail(txtTo.Text, txtCC.Text, "", txtSubject.Text, txtBody.Content, lblCompanyId.Text, TansmittalObject("ClientId"), TansmittalObject("JobId"),, SenderDisplay, lblEmployeeEmail.Text, SenderDisplay) Then
                    lblMailResult.Text = "Transmittal successfully sent"
                    LocalAPI.SetTransmittalEmailSent(lblTransmittalId.Text, "Sent via Email on " & LocalAPI.GetDateTime(), txtTo.Text)
                    btnEnviar.Enabled = False
                End If

            Else
                lblMailResult.Text = "Email of '" & txtTo.Text & "' is nothing"
            End If

        Catch ex As Exception
            lblMailResult.Text = "Email sending error." & ex.Message
        End Try
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Select Case lblBackPage.Text
            Case "transmittal"
                Response.RedirectPermanent("~/adm/Transmittal.aspx?transmittalId=" & lblTransmittalId.Text & "&BackPage=transmittals")
            Case "job_transmittals"
                Dim JobId As Integer = LocalAPI.GetTransmittalProperty(lblTransmittalId.Text, "JobId")
                Dim sUrl As String = LocalAPI.GetSharedLink_URL(8012, JobId)
                Response.Redirect(sUrl)

            Case Else
                Response.RedirectPermanent("~/adm/Transmittal.aspx?transmittalId=" & lblTransmittalId.Text)
        End Select
    End Sub
End Class