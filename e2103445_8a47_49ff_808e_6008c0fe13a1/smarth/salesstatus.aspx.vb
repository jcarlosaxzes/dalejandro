Public Class salesstatus
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Sales Status"

            If (Not Page.IsPostBack) Then
                If Not Request.QueryString("GuiId") Is Nothing Then
                    Session("CompanyGUID") = Request.QueryString("GuiId")
                    'Session("CompanyGUID") = "a454d8ed-d27d-4d12-88fa-426a02615e1a"  '!!!!EEG  
                End If
                lblCompanyId.Text = LocalAPI.GetCompanyIdFromGUID("" & Session("CompanyGUID"))
                TotalesPage()
            End If

        Catch ex As Exception

        End Try
    End Sub
    Private Sub TotalesPage()
        Try
            Dim DateNow As Date = LocalAPI.GetDateTime()
            Dim Mes As String = MonthName(DateNow.Month, False)
            Dim Year As String = DateNow.Year

            lblMonthYear.Text = Mes & ", " & Year
            lblNow.Text = LocalAPI.GetDateTime()
            lblMonthTargetLabel.Text = "Target"
            lblMonthCurrentLabel.Text = "Current"
            lblMonthBalanceLabel.Text = "Balance"
            lblYearCurrent.Text = Year & " Current"
            lblMonthBilledLabel.Text = "Billed"
            lblMonthCollectedLabel.Text = "Collected"
            lblMonthProposalLabel.Text = "Proposal"
            lblYearProposalLabel.Text = Year & " Proposal"

            Dim dMonthTarget As Double = LocalAPI.GetDepartmentTargetThisMonth(lblCompanyId.Text, -1)
            Dim dMonthCurrent As Double = LocalAPI.GetJobTotalBudgetThisMonth(lblCompanyId.Text)
            Dim dYearCurrent As Double = LocalAPI.GetJobTotalBudgetThisYear(lblCompanyId.Text)
            Dim dAccumulatedBalance As Double = LocalAPI.GetDepartmentAccumulatedBalance(lblCompanyId.Text, -1)

            Dim dSubcontratMonthCurrent As Double = LocalAPI.GetSubcontratTotalThisMonth(lblCompanyId.Text)
            Dim dSubcontratYearCurrent As Double = LocalAPI.GetSubcontratTotalThisYear(lblCompanyId.Text)

            lblTotalTargetMonth.Text = FormatCurrency(dMonthTarget, 0)

            lblTotalCurrentMonth.Text = FormatCurrency(dMonthCurrent - dSubcontratMonthCurrent, 0)
            lblTotalCurrentYear.Text = FormatCurrency(dYearCurrent - dSubcontratYearCurrent, 0)

            lblTotalBalanceMonth.Text = FormatCurrency(dMonthCurrent - dMonthTarget, 0,, TriState.False)
            lblTotalBalanceMonth.ForeColor = IIf(dMonthCurrent - dMonthTarget > 0, Drawing.Color.Black, Drawing.Color.Red)

            lblBalanceYear.Text = FormatCurrency(dAccumulatedBalance, 0,, TriState.False)
            lblBalanceYear.ForeColor = IIf(dAccumulatedBalance > 0, Drawing.Color.Black, Drawing.Color.Red)

            lblMonthBilled.Text = FormatCurrency(LocalAPI.GetInvoiceEmmittedMonth(lblCompanyId.Text), 0)
            lblMonthCollected.Text = FormatCurrency(LocalAPI.GetInvoiceCollectedMonth(lblCompanyId.Text), 0)

            lblMonthProposal.Text = FormatCurrency(LocalAPI.GetProposalBudgetThisMonth(lblCompanyId.Text), 0)
            lblYearProposal.Text = FormatCurrency(LocalAPI.GetProposalBudgetThisYear(lblCompanyId.Text), 0)
        Catch ex As Exception

        End Try
    End Sub
End Class