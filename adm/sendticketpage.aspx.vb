Public Class sendticketpage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblJobId.Text = Request.QueryString("JobId")
                lblEmployeeId.Text = Request.QueryString("employeeId")
                lblJob.Text = LocalAPI.GetJobCodeName(lblJobId.Text)

                MessageTemplate()

            End If

        Catch ex As Exception

        End Try
    End Sub

    Private Sub MessageTemplate()
        Try
            lblClientId.Text = LocalAPI.GetJobProperty(lblJobId.Text, "Client")
            txtTo.Text = LocalAPI.GetClientEmail(lblClientId.Text)
            Dim sClienteName As String = LocalAPI.GetClientName(lClientId:=lblClientId.Text)
            Dim sSign As String = LocalAPI.GetEmployeesSign(lblEmployeeId.Text)

            ' Leer subjet y body template
            txtSubject.Text = LocalAPI.GetMessageTemplateSubject("Tickets", lblCompanyId.Text)
            Dim sBody As String = LocalAPI.GetMessageTemplateBody("Tickets", lblCompanyId.Text)

            ' sustituir variables
            txtSubject.Text = Replace(txtSubject.Text, "[Project Name]", lblJob.Text)

            sBody = Replace(sBody, "[Project Name]", lblJob.Text)
            sBody = Replace(sBody, "[Client Name]", sClienteName)
            sBody = Replace(sBody, "[Sign]", sSign)

            ' Enlace al Invoice
            Dim sURL As String = LocalAPI.GetSharedLink_URL(1204, lblJobId.Text)
            sBody = Replace(sBody, "[link below url]", sURL)
            sBody = Replace(sBody, "[Project Name url]", sURL)

            txtBody.Content = sBody

        Catch ex As Exception

        End Try
    End Sub

    Private Sub btnSent_Click(sender As Object, e As EventArgs) Handles btnSent.Click
        Try
            Dim SenderEmail As String = LocalAPI.GetEmployeeEmail(lId:=lblEmployeeId.Text)
            Dim SenderDisplay As String = LocalAPI.GetEmployeeName(lblEmployeeId.Text)
            SendGrid.Email.SendMail(txtTo.Text, txtBCC.Text, SenderEmail, txtSubject.Text, txtBody.Content, lblCompanyId.Text,, SenderDisplay, SenderEmail, SenderDisplay)

        Catch ex As Exception

        End Try

    End Sub
End Class

