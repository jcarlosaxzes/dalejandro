Imports Telerik.Web.UI

Public Class proposaltemplate
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then

            lblCompanyId.Text = Session("companyId")

            If Request.QueryString("templateId") Is Nothing Then
                ' Mode NEW
                btnUpdate.Text = "Insert"
            Else
                ' Mode EDIT
                btnUpdate.Text = "Update"
                lblTemplateId.Text = Request.QueryString("templateId")

                cboTandCtemplates.DataBind()
                cboPaymentSchedules.DataBind()
                ReadTemplate()

            End If

        End If
    End Sub

    Private Sub ReadTemplate()
        Dim PreProjectInfo = LocalAPI.GetRecord(lblTemplateId.Text, "Proposal_type_SELECT")

        NameTextBox.Text = PreProjectInfo("Name")
        TaskIdListTextBox.Text = PreProjectInfo("TaskIdList")
        PaymentsScheduleListTextBox.Text = PreProjectInfo("PaymentsScheduleList")
        PaymentsTextListTextBox.Text = PreProjectInfo("PaymentsTextList")
        TextBeginTextBox.Text = PreProjectInfo("TextBegin")
        TextEndTextBox.Text = PreProjectInfo("TextEnd")

        cboTandCtemplates.SelectedValue = PreProjectInfo("tandcId")
        cboPaymentSchedules.SelectedValue = PreProjectInfo("paymentscheduleId")
        Try

        Catch ex As Exception
        End Try
    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        If lblTemplateId.Text > 0 Then
            SqlDataSource1.Update()
            Master.InfoMessage("Template was updated!")
        Else
            SqlDataSource1.Insert()
            btnUpdate.Text = "Update"
            Master.InfoMessage("Template was Inserted!")
        End If
    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        Back()
    End Sub

    Private Sub btnAddTaskID_Click(sender As Object, e As EventArgs) Handles btnAddTaskID.Click
        Try
            TaskIdListTextBox.Text = ""
            Dim collection2 As IList(Of RadComboBoxItem) = cboTask.CheckedItems
            If (collection2.Count <> 0) Then

                For Each item As RadComboBoxItem In collection2
                    TaskIdListTextBox.Text = TaskIdListTextBox.Text + item.Value + ","
                Next
                ' Quitar la ultima coma
                TaskIdListTextBox.Text = Left(TaskIdListTextBox.Text, Len(TaskIdListTextBox.Text) - 1)
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub btnGeneratePaymentSchedules_Click(sender As Object, e As EventArgs) Handles btnGeneratePaymentSchedules.Click
        Try

            If cboPaymentSchedules.SelectedValue > 0 Then
                PaymentsScheduleListTextBox.Text = LocalAPI.GetStringEscalar("SELECT PaymentsScheduleList FROM Invoices_types WHERE [Id]=" & cboPaymentSchedules.SelectedValue)
                PaymentsTextListTextBox.Text = LocalAPI.GetStringEscalar("SELECT PaymentsTextList FROM Invoices_types WHERE [Id]=" & cboPaymentSchedules.SelectedValue)
            End If

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Back()
    End Sub
    Private Sub Back()
        Response.Redirect("~/adm/proposal_types.aspx")
    End Sub
End Class
