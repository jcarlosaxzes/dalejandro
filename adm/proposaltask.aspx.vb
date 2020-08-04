Imports Telerik.Web.UI
Public Class proposaltask
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                lblCompanyId.Text = Session("companyId")
                lblproposalId.Text = Request.QueryString("proposalId")

                If Not Request.QueryString("detailId") Is Nothing Then
                    ' Edicion
                    lbldetailId.Text = Request.QueryString("detailId")
                    Title = "Edit Proposal Task"
                    btnUpdate.Text = "Update"
                    btnUpdateAndBack.Text = "Update and Back"
                    ReadDetails()
                    ' Ocultar el panel de select new task template
                    pnlTemplate.Visible = False
                    lblTaskList.Visible = False

                    PanelEstimatorVisible()

                Else
                    ' Insert
                    lbldetailId.Text = "0"
                    Title = "New Proposal Task"
                    btnUpdate.Text = "Insert"
                    btnUpdateAndBack.Text = "Insert and Back"
                    PanelEstimator.Visible = False
                End If
                If Not Request.QueryString("fromwizard") Is Nothing Then
                    lblBackSource.Text = 1
                End If

                cboPhase.Visible = IIf(LocalAPI.GetProposalPhasesCount(lblproposalId.Text) = 0, False, True)

                btnUpdate.Visible = EnabledProposal()
                btnUpdateAndBack.Visible = btnUpdate.Visible
            End If

        Catch ex As Exception

        End Try
    End Sub

    Private Sub PanelEstimatorVisible()
        If lblCompanyId.Text = 260962 Then
            ' 6/9/2020 Fernando y Raissa ddefinen que no es visible en EEG
            PanelEstimator.Visible = False
        Else
            PanelEstimator.Visible = True
        End If

    End Sub

    Private Function EnabledProposal() As Boolean
        Dim Allow_EditAcceptedProposal As Boolean = LocalAPI.GetEmployeePermission(Master.UserId, "Allow_EditAcceptedProposal")
        If Allow_EditAcceptedProposal Then
            Return True
        Else
            Dim sStatus As Integer = LocalAPI.GetProposalData(lblproposalId.Text, "statusId")
            Return (sStatus <> 4 And sStatus <> 2) ' diferente de Revised
        End If
    End Function

    Private Sub ReadDetails()
        Try

            Dim detailObject = LocalAPI.GetRecord(lbldetailId.Text, "PROPOSAL_detail_SELECT")

            Dim taskId As Integer = detailObject("TaskId")
            SqlDataSource1.DataBind()
            cboMulticolumnTask.DataBind()
            cboMulticolumnTask.Value = taskId

            SqlDataSourcePhases.DataBind()
            cboPhase.DataBind()
            cboPhase.SelectedValue = detailObject("phaseId")

            SqlDataSourcePositions.DataBind()
            cboPosition.DataBind()
            cboPosition.SelectedValue = detailObject("positionId")

            txtName.Text = detailObject("Description")
            txtDescriptionPlus.Content = detailObject("DescriptionPlus")
            txtRates.Text = "" & detailObject("Rates")
            txtTimeSel.Text = "" & detailObject("Hours")
            'txtAmount.Text = "" & LocalAPI.GetProposalDetailProperty(lbldetailId.Text, "Amount")
            txtAmount.Text = "" & detailObject("Amount")

            cboPaymentSchedulesEdit.SelectedValue = detailObject("paymentscheduleId")

            cboBillType.SelectedValue = detailObject("BillType")

            lblTotalLine.Text = FormatCurrency(detailObject("TotalRow"))
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        If Val(lbldetailId.Text) > 0 Then
            ' Edit
            SqlDataSource1.Update()
            Master.InfoMessage("Record updated!")
        Else
            ' Insert
            SqlDataSource1.Insert()
            btnUpdate.Text = "Update"
            btnUpdateAndBack.Text = "Update and Back"
            Master.InfoMessage("New Task inserted!")
        End If
        lblTotalLine.Text = FormatCurrency(LocalAPI.GetProposalDetailProperty(lbldetailId.Text, "TotalRow"))
        PanelEstimatorVisible()

    End Sub
    Private Sub btnUpdateAndBack_Click(sender As Object, e As EventArgs) Handles btnUpdateAndBack.Click
        If Val(lbldetailId.Text) > 0 Then
            ' Update and Back
            SqlDataSource1.Update()
            Master.InfoMessage("Record updated!")
        Else
            ' Insert
            SqlDataSource1.Insert()
            Master.InfoMessage("New Task inserted!")
        End If

        Back()

    End Sub


    Protected Sub cboPosition_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles cboPosition.SelectedIndexChanged
        If cboPosition.SelectedValue > 0 Then
            txtRates.DbValue = LocalAPI.GetPositionProperty(cboPosition.SelectedValue, "HourRate")
        End If

    End Sub

    Private Sub cboMulticolumnTask_SelectedIndexChanged(sender As Object, e As RadMultiColumnComboBoxSelectedIndexChangedEventArgs) Handles cboMulticolumnTask.SelectedIndexChanged
        If cboMulticolumnTask.Value > 0 Then
            Dim taskId As Integer = cboMulticolumnTask.Value
            txtName.Text = LocalAPI.GetTaskProperty(taskId, "Description")
            txtDescriptionPlus.Content = LocalAPI.GetTaskProperty(taskId, "DescriptionPlus")
            txtTimeSel.Text = LocalAPI.GetTaskProperty(taskId, "Hours")
            txtRates.Text = LocalAPI.GetTaskProperty(taskId, "Rates")
            cboBillType.SelectedValue = IIf(LocalAPI.GetTaskProperty(taskId, "HourRatesService") = 0, 1, 2)
        End If

    End Sub
    Private Sub Back()
        If lblBackSource.Text = 1 Then
            Response.Redirect("~/adm/proposalnewwizard.aspx?proposalId=" & lblproposalId.Text & "&FeesTab=1")
        Else
            Response.Redirect("~/adm/proposal.aspx?proposalId=" & lblproposalId.Text)
        End If
    End Sub
    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Back()
    End Sub

    Private Sub btnNewEstimator_Click(sender As Object, e As EventArgs) Handles btnNewEstimator.Click
        SqlDataSourceEstimator.Insert()
        RadGridEstaimator.DataBind()
        cboPositionForEstimator.SelectedValue = 0
        txtHoursForEstimate.Value = 0
        cboPositionForEstimator.Focus()
    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        lbldetailId.Text = e.Command.Parameters("@Id_OUT").Value
        RadGridEstaimator.DataBind()
        ReadDetails()
    End Sub
End Class
