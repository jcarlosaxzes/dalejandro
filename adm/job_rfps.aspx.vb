Imports Telerik.Web.UI
Public Class job_rfps
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblJobId.Text = Request.QueryString("JobId")
                lblCompanyId.Text = Session("companyId")
                lblJob.Text = LocalAPI.GetJobCodeName(lblJobId.Text)

                RadGridReport.DataBind()

                Master.ActiveTab(4)

            End If


        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnNewSubconsultantFee_Click(sender As Object, e As EventArgs) Handles btnNewSubconsultantFee.Click
        RadGridRFP.MasterTableView.InsertItem()
    End Sub

    Protected Sub RadGridRFP_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridRFP.ItemCommand
        Select Case e.CommandName
            Case "PayBill"
                lblRFPId.Text = e.CommandArgument
                SqlDataSourceRFPpayments.Insert()
                SqlDataSourceRFPpayments.DataBind()
                SqlDataSourceRFPpayments.DataBind()
                SqlDataSourceRFP.DataBind()
                RadGridRFP.DataBind()
        End Select
    End Sub

    Private Sub SqlDataSourceRFPpayments_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceRFPpayments.Inserted
        RadGridRFP.DataBind()
    End Sub

    Private Sub SqlDataSourceRFPpayments_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceRFPpayments.Updated
        RadGridRFP.DataBind()
    End Sub

    Private Sub SqlDataSourceRFPpayments_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceRFPpayments.Deleted
        RadGridRFP.DataBind()
    End Sub

    Private Sub btnSelectRFP_Click(sender As Object, e As EventArgs) Handles btnSelectRFP.Click
        cboRFP.DataBind()
        RadToolTipSelectExistinRFP.Visible = True
        RadToolTipSelectExistinRFP.Show()

    End Sub

    Private Sub btnAcceptConfirm_Click(sender As Object, e As EventArgs) Handles btnAcceptConfirm.Click
        Try
            SqlDataSourceSelectRFP.Update()
            RadGridRFP.DataBind()
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub SqlDataSourceJobsExpenses_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceJobsExpenses.Selecting
        e.Command.Parameters("@code").Value = LocalAPI.GetJobProperty(lblJobId.Text, "Code")
        e.Command.Parameters("@DateFrom").Value = LocalAPI.GetJobProperty(lblJobId.Text, "Open_date")
        e.Command.Parameters("@DateTo").Value = DateAdd(DateInterval.Year, 1, Date.Today)
    End Sub
End Class
