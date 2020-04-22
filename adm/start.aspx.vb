Public Class start
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Master.PageTitle = "Getting Started with PASconcept"
            Master.Help = "http://blog.pasconcept.com/2015/04/using-pasconcept-step-by-step.html"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Getting Started"
            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")
            If Not Request.QueryString("source") Is Nothing Then
                CheckStartList(True)
            Else
                CheckStartList(False)
            End If

        End If

    End Sub

    Private Sub CheckStartList(bFromMenu As Boolean)
        lblCompanyInfo.Font.Strikeout = LocalAPI.start_CompanyInfoReady(lblCompanyId.Text)
        chkCompanyInfo.Checked = lblCompanyInfo.Font.Strikeout
        lblCompanyInfo.Enabled = Not chkCompanyInfo.Checked

        lnkEmployee.Font.Strikeout = LocalAPI.start_EmployeeInfoReady(lblCompanyId.Text)
        chkEmployee.Checked = lnkEmployee.Font.Strikeout
        lnkEmployee.Enabled = Not chkEmployee.Checked

        lblClient.Font.Strikeout = LocalAPI.start_ClientsInfoReady(lblCompanyId.Text)
        chkClient.Checked = lblClient.Font.Strikeout
        lblClient.Enabled = Not chkClient.Checked

        lblTyC.Font.Strikeout = LocalAPI.start_Proposal_TandCtemplatesInfoReady(lblCompanyId.Text)
        chkTyC.Checked = lblTyC.Font.Strikeout
        lblTyC.Enabled = Not chkTyC.Checked

        lblPaymentSch.Font.Strikeout = LocalAPI.start_PaymentSchedulesInfoReady(lblCompanyId.Text)
        chkPaymentSch.Checked = lblPaymentSch.Font.Strikeout
        lblPaymentSch.Enabled = Not chkPaymentSch.Checked

        lblProposal.Font.Strikeout = LocalAPI.start_ProposalInfoReady(lblCompanyId.Text)
        chkProposal.Checked = lblProposal.Font.Strikeout
        lblProposal.Enabled = Not chkProposal.Checked

        lblJobsCodes.Font.Strikeout = LocalAPI.start_JobCodesInfoReady(lblCompanyId.Text)
        chkJobsCodes.Checked = lblJobsCodes.Font.Strikeout
        lblJobsCodes.Enabled = Not chkJobsCodes.Checked

        lblJob.Font.Strikeout = LocalAPI.start_JobInfoReady(lblCompanyId.Text)
        chkJob.Checked = lblJob.Font.Strikeout
        lblJob.Enabled = Not chkJob.Checked
        If Not bFromMenu Then
            If lblCompanyInfo.Font.Strikeout _
                And lnkEmployee.Font.Strikeout _
                And lblClient.Font.Strikeout _
                And lblTyC.Font.Strikeout _
                And lblPaymentSch.Font.Strikeout _
                And lblProposal.Font.Strikeout _
                And lblJobsCodes.Font.Strikeout _
                And lblJob.Font.Strikeout Then
                ' o navegar a otra pagina
                Dim employeeId As Integer = LocalAPI.GetEmployeeId(lblEmployee.Text, lblCompanyId.Text)
                Dim sHomeEmployeePage As String = LocalAPI.GetEmployeeHomePage(employeeId)
                'Dim companyId As Integer = LocalAPI.GetLastCompanyId(employeeId)
                'If companyId > 0 Then
                '    Session("companyId")=companyId
                '    Session("companyId") =companyId
                'End If
                Response.Redirect("~/ADM/" & sHomeEmployeePage)
            End If
        End If
    End Sub

    Private Sub btnSettingStatus_Click(sender As Object, e As EventArgs) Handles btnSettingStatus.Click
        Response.Redirect("~/ADM/settingstatus.aspx")
    End Sub
End Class

