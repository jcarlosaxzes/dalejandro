Public Class editproposalphase
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                lblphaseId.Text = Request.QueryString("Id")

                ReadDetails()

            End If

        Catch ex As Exception

        End Try
    End Sub

    Private Sub ReadDetails()
        txtOrder.Text = LocalAPI.GetProposalPhaseProperty(lblphaseId.Text, "nOrder")
        txtPhaseCode.Text = LocalAPI.GetProposalPhaseProperty(lblphaseId.Text, "Code")
        txtName.Text = LocalAPI.GetProposalPhaseProperty(lblphaseId.Text, "Name")
        txtDescription.Content = LocalAPI.GetProposalPhaseProperty(lblphaseId.Text, "Description")
        txtPeriod.Text = LocalAPI.GetProposalPhaseProperty(lblphaseId.Text, "Period")
        RadDatePickerFrom.DbSelectedDate = LocalAPI.GetProposalPhaseProperty(lblphaseId.Text, "DateFrom")
        RadDatePickerTo.DbSelectedDate = LocalAPI.GetProposalPhaseProperty(lblphaseId.Text, "DateTo")

    End Sub
    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Dim proposalId As Integer = LocalAPI.GetProposalPhaseProperty(lblphaseId.Text, "proposalId")
        Response.Redirect("~/ADM/Proposal.aspx?Id=" & proposalId)
    End Sub

    Protected Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        SqlDataSource1.Update()
    End Sub

    Private Sub SqlDataSource1_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Updated
        Dim proposalId As Integer = LocalAPI.GetProposalPhaseProperty(lblphaseId.Text, "proposalId")
        Response.Redirect("~/adm/proposal.aspx?proposalId=" & proposalId)
    End Sub
End Class
