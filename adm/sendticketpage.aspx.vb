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
            ' Enlace al Invoice
            Dim sURL As String = LocalAPI.GetSharedLink_URL(1204, lblJobId.Text)

            Dim DictValues As Dictionary(Of String, String) = New Dictionary(Of String, String)
            DictValues.Add("[Project_Name]", lblJob.Text)
            DictValues.Add("[Client_Name]", sClienteName)
            DictValues.Add("[Sign]", sSign)
            DictValues.Add("[link_below_url]", sURL)
            DictValues.Add("[Project_Name_url]", sURL)
            DictValues.Add("[PASSign]", LocalAPI.GetPASSign())


            ' Leer subjet y body template
            txtSubject.Text = LocalAPI.GetMessageTemplateSubject("Tickets", lblCompanyId.Text, DictValues)
            Dim sBody As String = LocalAPI.GetMessageTemplateBody("Tickets", lblCompanyId.Text, DictValues)

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

