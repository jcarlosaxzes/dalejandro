﻿Imports Telerik.Web.UI

Public Class newclientcollection
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            lblCompanyId.Text = Session("companyId")
            lblEmployeeEmail.Text = Master.UserEmail

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
        Dim CollectionInfo = LocalAPI.GetRecord(lblCompanyId.Text, "Company_collection_Init_SELECT")

        Try
            txtAttorneyFirm.Text = CollectionInfo("AttorneyFirm")
            txtAttorneyName.Text = CollectionInfo("AttorneyName")
            txtAttorneyPhone.Text = CollectionInfo("AttorneyPhone")
            txtAttorneyEmail.Text = CollectionInfo("AttorneyEmail")

            ' Next Step
            txtClientCC.Text = lblEmployeeEmail.Text
            txtAttorneyTo.Text = CollectionInfo("AttorneyEmail")
            txtAttorneyCC.Text = lblEmployeeEmail.Text

            RadDatePickerDateofContract.DbSelectedDate = "1-1-2020"
            txtDaysPastDue.DbValue = 1
            txtPastDueBalance.DbValue = 0
        Catch ex As Exception
        End Try
    End Sub

    Private Sub ReadCollectionRecord()
        Dim CollectionInfo = LocalAPI.GetRecord(lblCollectionId.Text, "Clients_collection_Form_SELECT")

        Try
            cboClients.DataBind()
            cboClients.SelectedValue = CollectionInfo("clientId")
            cboClients.Enabled = cboClients.SelectedValue > 0
            txtNotes.Text = CollectionInfo("Notes")
            txtAttorneyFirm.Text = CollectionInfo("AttorneyFirm")
            txtAttorneyName.Text = CollectionInfo("AttorneyName")
            txtAttorneyPhone.Text = CollectionInfo("AttorneyPhone")
            txtAttorneyEmail.Text = CollectionInfo("AttorneyEmail")

            ' Next Step
            txtClientCC.Text = CollectionInfo("clientEmail")
            txtClientCC.Text = lblEmployeeEmail.Text
            txtAttorneyTo.Text = CollectionInfo("AttorneyEmail")
            txtAttorneyCC.Text = lblEmployeeEmail.Text

            txtPastDueBalance.DbValue = CollectionInfo("PastDueBalance")
            txtDaysPastDue.DbValue = CollectionInfo("DaysPastDue")
            RadDatePickerDateofContract.DbSelectedDate = CollectionInfo("DateofContract")

            ' Message Template 
            Dim sSign As String = LocalAPI.GetEmployeesSign(lblEmployeeId.Text)
            Dim sMsg As New System.Text.StringBuilder
            'Attorney Message
            txtAttorneySubject.Text = "New Matter for Collection"
            sMsg.Append("Creditor/Client Name: " & CollectionInfo("Name") & ", " & CollectionInfo("Company"))
            sMsg.Append("Debtor Name: " & CollectionInfo("Name") & ", " & CollectionInfo("Company"))
            sMsg.Append("Debtor Address, " & CollectionInfo("FullAddress"))

            sMsg.Append("Past Due Balance: " & CollectionInfo("PastDueBalance"))
            sMsg.Append("Amount of Days Past Due: " & CollectionInfo("DaysPastDue"))
            sMsg.Append("Date of Contract: " & CollectionInfo("DateofContract"))
            txtAttorneyBody.Content = sMsg.ToString & "<br /><br />" & sSign


            sMsg.Append("Law Firm Name: " & CollectionInfo("AttorneyFirm"))
            sMsg.Append("Law Firm Contact: " & CollectionInfo("AttorneyName"))
            sMsg.Append("Law Firm Phone: " & CollectionInfo("AttorneyPhone"))
            sMsg.Append("Law Firm Email: " & CollectionInfo("AttorneyEmail"))
            txtClientBody.Content = sMsg.ToString & "<br /><br />" & sSign

            'Client Message
            txtClientSubject.Text = "New Matter for Collection"

        Catch ex As Exception
        End Try
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/clientscolletion.aspx")
    End Sub

    Protected Sub RadWizard1_NextButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.NextButtonClick

        Select Case e.CurrentStep.ID
            Case "RadWizardStepClient"
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
        ' Send Notifications...

    End Sub
End Class