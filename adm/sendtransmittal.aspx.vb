﻿Public Class sendtransmittal
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

            ' Enlace al Transmittal
            Dim sURL As String = LocalAPI.GetSharedLink_URL(6, lblTransmittalId.Text)
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

                    btnEnviar.Enabled = False
                End If

            Else
                lblMailResult.Text = "Email of '" & txtTo.Text & "' is nothing"
            End If

        Catch ex As Exception
            lblMailResult.Text = "Email sending error." & ex.Message
        End Try
    End Sub
End Class