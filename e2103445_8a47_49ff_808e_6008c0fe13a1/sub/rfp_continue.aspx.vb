Imports Telerik.Web.UI

Public Class rfp_continue
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Try
                If Not Request.QueryString("rfpId") Is Nothing Then
                    ' valid Parameter.......
                    lblRFPId.Text = Request.QueryString("rfpId")
                    txtRFPurl.Text = "https://www.pasconcept.com//e2103445_8a47_49ff_808e_6008c0fe13a1/SUB/rfp.aspx?GuiId=" & LocalAPI.GetRFPProperty(lblRFPId.Text, "guid")
                    ' Fix Company to Master Page header
                    lblCompanyId.Text = LocalAPI.GetRFPProperty(lblRFPId.Text, "companyId")

                    txtSubconsultaTandC.Content = LocalAPI.GetRFPProperty(lblRFPId.Text, "Agreements")
                    txtSubconsultantNotes.Text = LocalAPI.GetRFPProperty(lblRFPId.Text, "SubconsultantNotes")
                End If

            Catch generatedExceptionName As Exception
                Throw New HttpException(404, "RFP not found")
            End Try
        End If

    End Sub

    Private Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        RadGridRFPDet.MasterTableView.InsertItem()
    End Sub

    Private Sub RadWizard1_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.FinishButtonClick
        lblValidate.Text = ""
        If opcUpdate.Checked Then
            ' Save and Complete
            SqlDataSourceRFPReview.Update()
            lblComplete.Text = "Your proposal has been saved successfully. <br/><br/>Please save this link for future changes."
        Else
            If opcUpdateAndSubmit.Checked Then
                ' Save/Submit and Complete
                SqlDataSourceRFPReview.Update()
                EmailSubmitted(lblRFPId.Text)
                lblComplete.Text = "Thank you, your changes have been saved and the Proposal has been submitted to the Primary. <br/><br/>For your reference, please save this link for your records."
            Else
                e.CurrentStep.Active = True
                lblValidate.Text = "Select 'Save Chnges' or 'Save Chnges And Submit' Option"
            End If
        End If
    End Sub

    Private Sub SqlDataSourceRFPdetalles_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceRFPdetalles.Inserted
        FormViewReview.DataBind()
    End Sub

    Private Sub SqlDataSourceRFPdetalles_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceRFPdetalles.Updated
        FormViewReview.DataBind()
    End Sub

    Private Sub SqlDataSourceRFPdetalles_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceRFPdetalles.Deleted
        FormViewReview.DataBind()
    End Sub

    Private Sub RadWizard1_CancelButtonClick(sender As Object, e As WizardEventArgs) Handles RadWizard1.CancelButtonClick
        Response.Redirect("~/e2103445_8a47_49ff_808e_6008c0fe13a1/SUB/rfp.aspx?GuiId=" & LocalAPI.GetRFPProperty(lblRFPId.Text, "guid"))
    End Sub

    Private Sub SqlDataSourceRFPReview_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceRFPReview.Updating
        e.Command.Parameters("@Agreements").Value = txtSubconsultaTandC.Content
        e.Command.Parameters("@Notes").Value = txtSubconsultantNotes.Text
        e.Command.Parameters("@Submitted").Value = IIf(opcUpdateAndSubmit.Checked, 1, 0)
        e.Command.Parameters("@Id").Value = lblRFPId.Text

    End Sub

    Private Sub btnViewProposal_Click(sender As Object, e As EventArgs) Handles btnViewProposal.Click
        Response.Redirect("~/e2103445_8a47_49ff_808e_6008c0fe13a1/SUB/rfp.aspx?GuiId=" & LocalAPI.GetRFPProperty(lblRFPId.Text, "guid"))
    End Sub

    Private Function EmailSubmitted(ByVal rfpId As Integer) As Boolean
        Try

            Dim RFPObject = LocalAPI.GetRecord(rfpId, "RFP_SELECT")

            Dim sSubject As String = "RFP " & RFPObject("ProjectName") & " have been Submitted from " & RFPObject("SubconsultantName")
            Dim sMsg As New System.Text.StringBuilder

            sMsg.Append("Dear " & RFPObject("Sender") & ",")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Review Request For Proposal " & RFPObject("ProjectName") & " submitted from " & RFPObject("SubconsultantName"))
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append(LocalAPI.GetPASSign())
            Dim sBody As String = sMsg.ToString

            SendGrid.Email.SendMail(RFPObject("SenderEmail"), RFPObject("SubConsultanstEmail"), "", sSubject, sBody, lblCompanyId.Text, RFPObject("SubConsultanstEmail"), RFPObject("SubconsultantName"), RFPObject("SubConsultanstEmail"))
            Return True

        Catch ex As Exception
        End Try
    End Function
End Class
