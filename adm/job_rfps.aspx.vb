Imports Telerik.Web.UI
Public Class job_rfps
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblJobId.Text = Request.QueryString("JobId")
                lblCompanyId.Text = Session("companyId")
                lblJob.Text = LocalAPI.GetJobCodeName(lblJobId.Text)

                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_RequestsProposalsList") Then Response.RedirectPermanent("~/adm/job_job.aspx?JobId=" & lblJobId.Text)

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
                RefreshGrids()
        End Select
    End Sub

    Private Sub SqlDataSourceRFPpayments_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceRFPpayments.Inserted
        RefreshGrids()
    End Sub

    Private Sub SqlDataSourceRFPpayments_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceRFPpayments.Updated
        RefreshGrids()
    End Sub

    Private Sub SqlDataSourceRFPpayments_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceRFPpayments.Deleted
        RefreshGrids()
    End Sub

    Private Sub btnSelectRFP_Click(sender As Object, e As EventArgs) Handles btnSelectRFP.Click
        cboRFP.DataBind()
        RadToolTipSelectExistinRFP.Visible = True
        RadToolTipSelectExistinRFP.Show()

    End Sub

    Private Sub btnAcceptConfirm_Click(sender As Object, e As EventArgs) Handles btnAcceptConfirm.Click
        Try
            SqlDataSourceSelectRFP.Update()
            RefreshGrids()
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub SqlDataSourceJobsExpenses_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceJobsExpenses.Selecting
        e.Command.Parameters("@code").Value = LocalAPI.GetJobProperty(lblJobId.Text, "Code")
        e.Command.Parameters("@DateFrom").Value = LocalAPI.GetJobProperty(lblJobId.Text, "Open_date")
        e.Command.Parameters("@DateTo").Value = DateAdd(DateInterval.Year, 1, Date.Today)
    End Sub

    Private Sub RefreshGrids()
        SqlDataSourceRFPpayments.DataBind()
        SqlDataSourceRFP.DataBind()
        RadGridRFP.DataBind()
        RadGridReport.DataBind()
    End Sub


    Protected Sub RadGridReport_ColumnCreated(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridColumnCreatedEventArgs) Handles RadGridReport.ColumnCreated
        Try
            Dim boundColumn As GridBoundColumn = CType(e.Column, GridBoundColumn)

            boundColumn.HeaderStyle.HorizontalAlign = HorizontalAlign.Center
            boundColumn.AllowFiltering = False

            Select Case boundColumn.DataTypeName
                Case "System.Double", "System.Decimal"
                    boundColumn.ItemStyle.HorizontalAlign = HorizontalAlign.Right
                    boundColumn.DataFormatString = "{0:N2}"
                    boundColumn.Aggregate = Telerik.Web.UI.GridAggregateFunction.Sum
                    boundColumn.FooterStyle.HorizontalAlign = HorizontalAlign.Right
                    boundColumn.HeaderStyle.Width = "120"
                Case "System.Int32"
                    boundColumn.ItemStyle.HorizontalAlign = HorizontalAlign.Right
                    boundColumn.DataFormatString = "{0:N0}"
                    boundColumn.HeaderStyle.Width = "100"
                    'boundColumn.Aggregate = Telerik.Web.UI.GridAggregateFunction.Sum
                Case "System.DateTime"
                    boundColumn.ItemStyle.HorizontalAlign = HorizontalAlign.Right
                    boundColumn.DataFormatString = "{0:d}"
                    boundColumn.HeaderStyle.Width = "100"

                Case Else
                    'boundColumn.ItemStyle.HorizontalAlign = HorizontalAlign.Left

            End Select

        Catch ex As Exception
        End Try
    End Sub

End Class
