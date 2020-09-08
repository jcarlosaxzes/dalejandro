Imports Telerik.Web.UI
Public Class clientsmarketing
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not Page.IsPostBack) Then
            lblMarketingId.Text = Request.QueryString("MarketingId")
            If lblMarketingId.Text > 0 Then
                lblCompanyId.Text = Session("companyId")
                LeerDatos()
            End If
        End If
    End Sub
    Private Sub LeerDatos()
        txtCampaignName.Text = LocalAPI.GetMarketingCampaignProperty(lblMarketingId.Text, "Name")

        Dim sText As String = LocalAPI.GetMarketingCampaignProperty(lblMarketingId.Text, "Subject")
        If Len(sText) = 0 Then
            txtSubject.Text = "[Company]. Information about our Services"
        Else
            txtSubject.Text = sText
        End If

        sText = LocalAPI.GetMarketingCampaignProperty(lblMarketingId.Text, "EmailBody")
        If Len(sText) = 0 Then
            txtBody.Content = "Dear [Client Name], <br/> We in [Company] are very honored to have you as one of our loyal customers and we are happy to serve your business. <br/>Our trading volume totaled [$Jobs]<br/>The trade balance is [Balance]<br/><br/><br/>...<br/><br/><br/>Sincerely Yours,<br/><br/>[Sign]"
        Else
            txtBody.Content = sText
        End If

        sText = LocalAPI.GetMarketingCampaignProperty(lblMarketingId.Text, "SMSText")
        If Len(sText) = 0 Then
            txtSMS.Text = "[Company]" & vbCrLf & "Dear [Client Name], our trading volume totaled [$Jobs]" & vbCrLf & "The trade balance is [Balance]"
        Else
            txtSMS.Text = sText
        End If
    End Sub

    Protected Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        SqlDataSource1.Update()
    End Sub

    Protected Sub SqlDataSource1_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Updated
        Master.InfoMessage("Record Updated")
    End Sub

    Protected Sub RadGrid1_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs) Handles RadGrid1.ItemDataBound
        If TypeOf e.Item Is GridDataItem Then
            Dim dataItem As GridDataItem = DirectCast(e.Item, GridDataItem)
            dataItem.Selected = True
        End If
    End Sub

    Protected Sub RadWizard1_NextButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.NextButtonClick
        Select Case e.CurrentStepIndex
            Case 0
                lblEmailCampaign.Visible = chkEmail.Checked
            Case 1
                lblSMSCampaign.Visible = chkSMS.Checked
            Case 2
                lblEmailsResult.Text = ""
                lblSMSResult.Text = ""

                lblTargetClients.Text = RadGrid1.SelectedItems.Count & " Clients Selected"

                Dim sError As String = ""
                If ValidateRun(sError) Then
                    lblFin.Text = "Press Bottom to 'Run Campaign'"
                Else
                    lblFin.Text = sError
                End If
        End Select
    End Sub

    Private Function ValidateRun(ByRef sError As String) As Boolean
        If chkEmail.Checked = False And chkSMS.Checked = False Then
            sError = "Select Email and/or SMA Campaign"
        ElseIf RadGrid1.SelectedItems.Count = 0 Then
            sError = "Select target clients"
        Else
            Return True
        End If
    End Function

    Private Function ValidateAgree() As Boolean
        If chkAgree.Checked = False Then
            lblValidateAgree.Visible = True
        Else
            lblValidateAgree.Visible = False
            Return True
        End If
    End Function

    Protected Sub RadWizard1_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.FinishButtonClick
        Dim sError As String = ""
        If ValidateRun(sError) And ValidateAgree() Then

            ' Save Campaign
            SqlDataSource1.Update()

            Dim Val As Integer

            ' Email Campaign
            If chkEmail.Checked Then
                Val = EmailCampaign()
                lblEmailsResult.Text = Val & " Emails sended"
            End If

            ' SMS Campaign
            If chkSMS.Checked Then
                Val = SMSlCampaign()
                lblSMSResult.Text = Val & " SMS sended"
            End If

            lblFin.Text = "Campaign completed successfully"
            RadWizard1.DisplayNavigationButtons = False
            RadWizard1.Enabled = False
        Else
            lblFin.Text = sError
        End If
    End Sub

    Private Function EmailCampaign() As Integer
        Try

            Dim nRecs As Integer
            Dim Company As String = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Name")
            Dim sSign = LocalAPI.GetCompanySign(lblCompanyId.Text)

            For Each dataItem As GridDataItem In RadGrid1.SelectedItems
                If dataItem.Selected Then
                    Dim Email As String = dataItem("Email").Text
                    Dim sSubject As String = txtSubject.Text
                    '[Client Name], [Client Company], [Company], [Sign]
                    sSubject = Replace(sSubject, "[Client Name]", dataItem("Name").Text)
                    sSubject = Replace(sSubject, "[Client Company]", dataItem("Company").Text)
                    sSubject = Replace(sSubject, "[Company]", Company)

                    Dim sBody As String = txtBody.Content
                    sBody = Replace(sBody, "[Client Name]", dataItem("Name").Text)
                    sBody = Replace(sBody, "[Client Company]", dataItem("Company").Text)
                    sBody = Replace(sBody, "[Company]", Company)
                    sBody = Replace(sBody, "[Sign]", sSign)

                    ' Datos economicos
                    sBody = Replace(sBody, "[Balance]", FormatCurrency(dataItem("Balance").Text))
                    sBody = Replace(sBody, "[#Jobs]", FormatNumber(dataItem("JobAmount").Text, 0))
                    sBody = Replace(sBody, "[$Jobs]", FormatCurrency(dataItem("TotalBudget").Text))


                    sBody = sBody & "<br />"
                    sBody = sBody & LocalAPI.GetPASShortSign()
                    If SendGrid.Email.SendMail(Email, "", "", sSubject, sBody, lblCompanyId.Text, dataItem("ClientId").Text, 0) Then
                        nRecs = nRecs + 1
                    End If

                End If
            Next
            If nRecs > 0 Then
                Dim dTotal As Double = nRecs * ConfigurationManager.AppSettings("Campaign_Price")
                LocalAPI.sys_log_Nuevo_Ext(Master.UserEmail, LocalAPI.sys_log_AccionENUM.EmailCampaign, lblCompanyId.Text, txtCampaignName.Text, dTotal)
            End If

            Return nRecs

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Function

    Private Function SMSlCampaign() As Integer
        Try

            Dim nRecs As Integer
            Dim Company As String = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Name")

            For Each dataItem As GridDataItem In RadGrid1.SelectedItems
                If dataItem.Selected Then
                    Dim Cellular As String = dataItem("Cellular").Text
                    Dim clientId As Integer = dataItem("ClientId").Text
                    If SMS.IsValidPhone(Cellular) And Not LocalAPI.IsClientDenySMS(clientId) Then
                        '[Client Name], [Client Company], [Company], [Sign]
                        Dim sMessage As String = txtSMS.Text
                        sMessage = Replace(sMessage, "[Client Name]", dataItem("Name").Text)
                        sMessage = Replace(sMessage, "[Client Company]", dataItem("Company").Text)
                        sMessage = Replace(sMessage, "[Company]", Company)

                        ' Datos economicos
                        sMessage = Replace(sMessage, "[Balance]", FormatCurrency(dataItem("Balance").Text))
                        sMessage = Replace(sMessage, "[#Jobs]", FormatNumber(dataItem("JobAmount").Text, 0))
                        sMessage = Replace(sMessage, "[$Jobs]", FormatCurrency(dataItem("TotalBudget").Text))

                        sMessage = sMessage & vbCrLf & vbCrLf & "This SMS was sent using PASConcept"
                        If SMS.SendSMS(Master.UserId, Cellular, sMessage, lblCompanyId.Text) Then
                            nRecs = nRecs + 1
                        End If
                    End If
                End If
            Next

            Return nRecs

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Function

End Class
