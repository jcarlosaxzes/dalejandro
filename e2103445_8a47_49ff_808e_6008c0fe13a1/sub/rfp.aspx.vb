Public Class rfp1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Try
                If Not Request.QueryString("GuiId") Is Nothing Then
                    ' valid Parameter.......
                    lblGuiId.Text = Request.QueryString("GuiId")
                    lblRFPId.Text = LocalAPI.GetRFPIdFromGUID(lblGuiId.Text)

                    ' Fix Company to Master Page header
                    lblCompanyId.Text = LocalAPI.GetRFPProperty(lblRFPId.Text, "companyId")
                    Master.Company = lblCompanyId.Text

                    ' Fix SubconsultantId to navegate inter session pages
                    Session("SUBCONSULTANT_subconsultantId") = LocalAPI.GetRFPProperty(lblRFPId.Text, "subconsultanId")

                    If Not Request.QueryString("IsReadOnly") Is Nothing Then
                        lblIsReadOnly.Text = Request.QueryString("IsReadOnly")
                    Else
                        lblIsReadOnly.Text = 0
                    End If

                End If

            Catch generatedExceptionName As Exception
                Throw New HttpException(404, "RFP not found")
            End Try
        End If

    End Sub

    Public Function IsButtonFeesVisible(statusId As Integer) As Boolean
        Return IIf(statusId = 1 And lblIsReadOnly.Text = 0, True, False)
    End Function

    Private Sub mainProposalFormView_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles mainProposalFormView.ItemCommand
        Select Case e.CommandName
            Case "Continue"
                Response.Redirect("~/e2103445_8a47_49ff_808e_6008c0fe13a1/Sub/rfp_continue.aspx?rfpId=" & lblRFPId.Text)

            Case "ContinuePAS"
                Response.Redirect("~/ADM/Proposals.aspx?rfpGUID=" & lblGuiId.Text)

            Case "Reject"
                RadToolTipReject.Visible = True
                RadToolTipReject.Show()

        End Select
    End Sub

    Private Sub btnRejectConfirm_Click(sender As Object, e As EventArgs) Handles btnRejectConfirm.Click
        LocalAPI.SetRFPStatus(lblRFPId.Text, LocalAPI.RFPStatus_ENUM.Rejected, txtReject.Text)
        EmailReject(lblRFPId.Text)
        mainProposalFormView.DataBind()
    End Sub
    Private Function EmailReject(ByVal rfpId As Integer) As Boolean
        Try

            Dim RFPObject = LocalAPI.GetRecord(rfpId, "RFP_SELECT")

            Dim sSubject As String = "Your Request For Proposal " & rfpId.ToString & " have been Rejected"
            Dim sMsg As New System.Text.StringBuilder

            sMsg.Append("Dear " & RFPObject("Sender") & ",")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append(RFPObject("Sender") & " would like to thank [sub company name] for your submission, however we have chosen not to select your company for this project. We will, however, keep " & RFPObject("Organization") & " in mind for future projects.")
            sMsg.Append("<br />")
            sMsg.Append("<br />")

            sMsg.Append("Reject notes:")
            sMsg.Append("<br />")
            sMsg.Append(txtReject.Text)

            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append(LocalAPI.GetPASSign())

            Dim sBody As String = sMsg.ToString
            Dim sCC As String = ""
            Dim sCCO As String = ""
            If LocalAPI.IsCompanyNotification(lblCompanyId.Text, "Notification_AceptedRFP") Then
                'sCCO = LocalAPI.GetCompanyProperty(companyid, "webEmailProfitWarningCCO")
            End If

            Dim jobId = LocalAPI.GetRFPProperty(rfpId, "jobId")
            Dim clientId = "0"
            If Not String.IsNullOrEmpty(jobId) Then
                clientId = LocalAPI.GetJobProperty(jobId, "Client")
            End If

            SendGrid.Email.SendMail(RFPObject("SenderEmail"), RFPObject("SubConsultanstEmail"), "", sSubject, sBody, lblCompanyId.Text, clientId, jobId, RFPObject("SubConsultanstEmail"), RFPObject("SubconsultantName"), RFPObject("SubConsultanstEmail"))
            Return True

        Catch ex As Exception
        End Try
    End Function
End Class
