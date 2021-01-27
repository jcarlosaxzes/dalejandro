Public Class pro_paymentschedules
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try

            If (Not Page.IsPostBack) Then

                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Master.UserId

                lblProposalId.Text = LocalAPI.GetProposalIdFromGUID(Request.QueryString("guid"))

                lblOriginalStatus.Text = LocalAPI.GetProposalProperty(lblProposalId.Text, "statusId")
                cboPaymentSchedules.DataBind()
                cboPaymentSchedules.SelectedValue = LocalAPI.GetProposalProperty(lblProposalId.Text, "paymentscheduleId")
                If lblOriginalStatus.Text > 1 Then
                    cboPaymentSchedules.Enabled = False
                    btnGeneratePaymentSchedules.Visible = False
                Else
                    cboPaymentSchedules.Enabled = True
                    btnGeneratePaymentSchedules.Visible = True
                End If
                TotalsAnalisis()

                Master.ActiveTab(1)


            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Private Sub btnGeneratePaymentSchedules_Click(sender As Object, e As EventArgs) Handles btnGeneratePaymentSchedules.Click

        If cboPaymentSchedules.SelectedValue > 0 Then
            SqlDataSourceProposalPSUpdate.Update()

            RadGridPS.DataBind()
            TotalsAnalisis()
            Master.InfoMessage("Proposal Payment Schedules Successfully Updated")
        End If

    End Sub

    Private Function TotalsAnalisis() As Boolean
        Try
            Dim dTotal As Double = LocalAPI.GetProposalTotal(lblProposalId.Text)
            Dim dPSTotal As Double = LocalAPI.GetProposalPSTotal(lblProposalId.Text)

            lblProposalTotal.Text = FormatCurrency(dTotal)
            lblScheduleTotal.Text = FormatCurrency(dPSTotal)

            If dTotal = 0 Then
                lblTotalAlert.Text = "Alert. The Project Total is zero !"
                Return False
            Else
                If dPSTotal > 0 And (Math.Round(dTotal, 0) <> Math.Round(dPSTotal, 0)) Then
                    lblTotalAlert.Text = $"Your Project Total ({dTotal}) and your Payment Schedule Total ({dPSTotal}) do not match !"
                    Return False
                Else
                    lblTotalAlert.Text = ""
                    Return True
                End If
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Function
End Class