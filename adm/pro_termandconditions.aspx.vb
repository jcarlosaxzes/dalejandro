Public Class pro_termandconditions
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then

                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Master.UserId

                lblProposalId.Text = LocalAPI.GetProposalIdFromGUID(Request.QueryString("guid"))

                Master.ActiveTab(3)


            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Private Sub btnGenerateTandC_Click(sender As Object, e As EventArgs) Handles btnGenerateTandC.Click
        If cboTandCtemplates.SelectedValue > 0 Then
            SqlDataSourceProposalTCUpdate.Update()

            FormView1.DataBind()

            Master.InfoMessage("Proposal Term and Conditions Successfully Updated")
        End If

    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        FormView1.UpdateItem(True)
        Master.InfoMessage("Proposal Updated!")
    End Sub
End Class