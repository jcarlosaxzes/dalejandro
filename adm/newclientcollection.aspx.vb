Imports Telerik.Web.UI

Public Class newclientcollection
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            lblCompanyId.Text = Session("companyId")
            lblEmployeeEmail.Text = Master.UserEmail
            lblEmployeeId.Text = Master.UserId
            If Request.QueryString("collectionId") Is Nothing Then
                ' New Collection.....................
                lblCollectionId.Text = 0
                ReadCompanyCollectionSetting()
            Else
                ' Edit Collection.....................
                lblCollectionId.Text = Request.QueryString("collectionId")
                ReadCollectionRecord()
            End If
        End If

    End Sub

    Private Sub ReadCompanyCollectionSetting()
        Try

            txtAttorneyFirm.Text = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "AttorneyFirm")
            txtAttorneyName.Text = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "AttorneyName")
            txtAttorneyPhone.Text = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "AttorneyPhone")
            txtAttorneyEmail.Text = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "AttorneyEmail")


            RadDatePickerDateofContract.DbSelectedDate = "1-1-2020"
            txtDaysPastDue.DbValue = 1
            txtPastDueBalance.DbValue = 0
        Catch ex As Exception
        End Try
    End Sub
    Private Sub cboClients_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboClients.SelectedIndexChanged
        lblClientAddress.Text = LocalAPI.GetClientProperty(cboClients.SelectedValue, "FullAddress")
    End Sub

    Private Sub ReadCollectionRecord()
        Dim CollectionInfo = LocalAPI.GetRecord(lblCollectionId.Text, "Clients_collection_Form_SELECT")

        Try
            cboClients.DataBind()
            cboClients.SelectedValue = CollectionInfo("clientId")
            lblClientAddress.Text = CollectionInfo("FullAddress")
            cboClients.Enabled = cboClients.SelectedValue = 0
            txtNotes.Text = CollectionInfo("Notes")
            txtAttorneyFirm.Text = CollectionInfo("AttorneyFirm")
            txtAttorneyName.Text = CollectionInfo("AttorneyName")
            txtAttorneyPhone.Text = CollectionInfo("AttorneyPhone")
            txtAttorneyEmail.Text = CollectionInfo("AttorneyEmail")

            txtPastDueBalance.DbValue = CollectionInfo("PastDueBalance")
            txtDaysPastDue.DbValue = CollectionInfo("DaysPastDue")
            RadDatePickerDateofContract.DbSelectedDate = CollectionInfo("DateofContract")


        Catch ex As Exception
        End Try
    End Sub

    Private Sub InitMessages()
        Try

            ' Message Template 
            Dim sSign As String = LocalAPI.GetEmployeesSign(lblEmployeeId.Text)
            Dim sMsg As New System.Text.StringBuilder

            txtClientCC.Text = lblEmployeeEmail.Text
            txtAttorneyCC.Text = lblEmployeeEmail.Text

            'Attorney Message
            txtAttorneySubject.Text = "New Matter for Collection"
            sMsg.Append("Creditor/Client Name: <b>" & cboClients.Text & "</b><br />")
            sMsg.Append("Debtor Name: <b>" & cboClients.Text & "</b><br />")
            sMsg.Append("Debtor Address: <b>" & lblClientAddress.Text & "</b><br />")

            sMsg.Append("Past Due Balance: <b>" & txtPastDueBalance.Text & "</b><br />")
            sMsg.Append("Amount of Days Past Due: <b>" & txtDaysPastDue.Text & "</b><br />")
            sMsg.Append("Date of Contract: <b>" & RadDatePickerDateofContract.SelectedDate & "</b><br />")
            txtAttorneyBody.Content = sMsg.ToString & "<br />" & sSign


            sMsg.Append("Law Firm Name: <b>" & txtAttorneyFirm.Text & "</b><br />")
            sMsg.Append("Law Firm Contact: <b>" & txtAttorneyName.Text & "</b><br />")
            sMsg.Append("Law Firm Phone: <b>" & txtAttorneyPhone.Text & "</b><br />")
            sMsg.Append("Law Firm Email: <b>" & txtAttorneyEmail.Text & "</b><br />")
            txtClientBody.Content = sMsg.ToString & "<br />" & sSign

            'Client Message
            txtClientSubject.Text = "New Matter for Collection"

            txtClientTo.Text = LocalAPI.GetClientEmail(cboClients.SelectedValue)
            txtClientCC.Text = lblEmployeeEmail.Text
            txtAttorneyTo.Text = txtAttorneyEmail.Text
            txtAttorneyCC.Text = lblEmployeeEmail.Text

        Catch ex As Exception

        End Try
    End Sub
    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/clientscolletion.aspx?restoreFilter=true")
    End Sub

    Protected Sub RadWizard1_NextButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.NextButtonClick

        Select Case e.CurrentStep.ID
            Case "RadWizardStepClient"
                InitMessages()
                RadWizard1.WizardSteps(1).Enabled = (cboClients.SelectedValue) > 0

        End Select
    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        lblCollectionId.Text = Val("" & e.Command.Parameters("@Id_OUT").Value)
        ReadCollectionRecord()
    End Sub

    Private Sub SqlDataSource1_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource1.Inserting
        Dim e1 As String = e.Command.Parameters("@clientId").Value
    End Sub

    Private Sub RadWizard1_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.FinishButtonClick
        If lblCollectionId.Text = 0 Then
            SqlDataSource1.Insert()
        Else
            SqlDataSource1.Update()
        End If
        Dim SenderDisplay As String = LocalAPI.GetEmployeeName(lblEmployeeId.Text)
        If SendClientNotification(SenderDisplay) Then
            SendAttorneyNotification(SenderDisplay)
        End If

    End Sub
    Private Function SendClientNotification(SenderDisplay As String) As Boolean
        Try
            Dim bRes As Boolean = SendGrid.Email.SendMail(txtClientTo.Text, txtClientCC.Text, "", txtClientSubject.Text, txtClientBody.Content, lblCompanyId.Text,, SenderDisplay, lblEmployeeEmail.Text, SenderDisplay)
            If bRes Then
                Master.InfoMessage("Client notification sent!")
                Return True
            End If
        Catch ex As Exception
        End Try
    End Function
    Private Function SendAttorneyNotification(SenderDisplay As String) As Boolean
        Try
            Dim bRes As Boolean = SendGrid.Email.SendMail(txtAttorneyTo.Text, txtAttorneyCC.Text, "", txtAttorneySubject.Text, txtAttorneyBody.Content, lblCompanyId.Text,, SenderDisplay, lblEmployeeEmail.Text, SenderDisplay)
            If bRes Then
                Master.InfoMessage("Attorney notification sent!")
                Return True
            End If
        Catch ex As Exception
        End Try
    End Function

End Class