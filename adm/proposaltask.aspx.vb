Imports Telerik.Web.UI
Public Class proposaltask
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                lblCompanyId.Text = Session("companyId")
                lblproposalId.Text = Request.QueryString("Id")

                If Not Request.QueryString("detailId") Is Nothing Then
                    ' Edicion
                    lbldetailId.Text = Request.QueryString("detailId")
                    Title = "Edit Proposal Task"
                    btnUpdate.Text = "Update Task"
                    ReadDetails()
                    ' Ocultar el panel de select new task template
                    pnlTemplate.Visible = False
                    lblTaskList.Visible = False
                Else
                    ' Insert
                    lbldetailId.Text = "0"
                    Title = "New Proposal Task"
                    btnUpdate.Text = "Insert Task"
                End If

                cboPhase.Visible = IIf(LocalAPI.GetProposalPhasesCount(lblproposalId.Text) = 0, False, True)

                btnUpdate.Visible = EnabledProposal()

            End If

        Catch ex As Exception

        End Try
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
        Dim taskId As Integer = LocalAPI.GetProposalDetailProperty(lbldetailId.Text, "TaskId")
        SqlDataSource1.DataBind()
        'cboTaskTemplate.DataBind()
        'cboTaskTemplate.SelectedValue = taskId
        cboMulticolumnTask.DataBind()
        cboMulticolumnTask.Value = taskId

        SqlDataSourcePhases.DataBind()
        cboPhase.DataBind()
        cboPhase.SelectedValue = LocalAPI.GetProposalDetailProperty(lbldetailId.Text, "phaseId")

        SqlDataSourcePositions.DataBind()
        cboPosition.DataBind()
        cboPosition.SelectedValue = LocalAPI.GetProposalDetailProperty(lbldetailId.Text, "positionId")

        txtName.Text = LocalAPI.GetProposalDetailProperty(lbldetailId.Text, "Description")
        txtDescriptionPlus.Content = LocalAPI.GetProposalDetailProperty(lbldetailId.Text, "DescriptionPlus")
        txtTimeSel.Text = LocalAPI.GetProposalDetailProperty(lbldetailId.Text, "Hours")
        txtRates.Text = LocalAPI.GetProposalDetailProperty(lbldetailId.Text, "Rates")
        txtAmount.Text = LocalAPI.GetProposalDetailProperty(lbldetailId.Text, "Amount")

    End Sub

    Protected Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        If Val(lbldetailId.Text) > 0 Then
            ' Edit
            SqlDataSource1.Update()
            Master.InfoMessage("Record updated!")
        Else
            ' Insert
            SqlDataSource1.Insert()
            Master.InfoMessage("New Task inserted!")
        End If

        Response.Redirect("~/ADM/Proposal.aspx?Id=" & lblproposalId.Text)

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
        End If

    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/proposal.aspx?Id=" & lblproposalId.Text)
    End Sub
End Class
