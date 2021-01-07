Imports Telerik.Web.UI

Public Class companySubscriptionInvoices
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            If Not IsPostBack Then

                ' Posible entrada, client-GUID 
                If Not Request.QueryString("companyId") Is Nothing Then
                    lblCompanyId.Text = Request.QueryString("companyId")

                End If

                lblEmployeeId.Text = Master.UserId

                Dim record = LocalAPI.GetRecordFromQuery($"select company.[companyId],company.[Name],company.[Contact],company.[AxzesJobId],company.[Email], company.billingExpirationDate , Billing_plans.Name AS BillingPlan ,Billing_plans.billing_baseprice,Billing_plans.billing_baseusers,Billing_periods.Name As BillingPeriod, Billing_plans.billing_period_Id from company LEFT OUTER JOIN  Billing_plans ON Company.Billing_plan = Billing_plans.Id LEFT  OUTER JOIN Billing_periods on Billing_periods.Id = Billing_plans.billing_period_Id where companyId = {lblCompanyId.Text}")

                lblJobId.Text = If(record.ContainsKey("AxzesJobId"), record("AxzesJobId"), 0)
                dpFrom.SelectedDate = If(record.ContainsKey("billingExpirationDate"), record("billingExpirationDate"), DateTime.Now)
                dpTo.SelectedDate = dpFrom.SelectedDate.Value.AddYears(1)
                txtyearAmount.Text = If(record.ContainsKey("billing_baseprice"), record("billing_baseprice"), 0)
                cboBillingPeriod.DataBind()
                cboBillingPeriod.SelectedValue = If(record.ContainsKey("billing_period_Id"), record("billing_period_Id"), 0)
                txtperiodAmount.Text = txtyearAmount.Text
                txtInvoiceNotes.Text = "PASconcept Annual Supscription"


            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub btnCreateInvoice_Click(sender As Object, e As EventArgs) Handles btnCreateInvoice.Click
        RadToolTipCreateInvoice.Visible = True
        RadToolTipCreateInvoice.Show()
    End Sub

    Private Sub btnSaveInvoice_Click(sender As Object, e As EventArgs) Handles btnSaveInvoice.Click
        'one year
        If cboBillingPeriod.SelectedValue = 0 Then
            LocalAPI.Invoice_INSERT(lblJobId.Text, DateTime.Now, txtperiodAmount.Text, txtInvoiceNotes.Text, dpFrom.DbSelectedDate)
        End If

        If cboBillingPeriod.SelectedValue = 1 Then
            Dim dueDate As DateTime = dpFrom.DbSelectedDate
            While dueDate < dpTo.DbSelectedDate
                LocalAPI.Invoice_INSERT(lblJobId.Text, DateTime.Now, txtperiodAmount.Text, $"{txtInvoiceNotes.Text} {dueDate.ToString("MMMM")}-{dueDate.Year}", dueDate)
                dueDate = dueDate.AddMonths(3)
            End While
        End If

        If cboBillingPeriod.SelectedValue = 2 Then
            Dim dueDate As DateTime = dpFrom.DbSelectedDate
            While dueDate < dpTo.DbSelectedDate
                LocalAPI.Invoice_INSERT(lblJobId.Text, DateTime.Now, txtperiodAmount.Text, $"{txtInvoiceNotes.Text} {dueDate.ToString("MMMM")}-{dueDate.Year}", dueDate)
                dueDate = dueDate.AddMonths(1)
            End While
        End If


    End Sub

    Private Sub cboBillingPeriod_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboBillingPeriod.SelectedIndexChanged
        If cboBillingPeriod.SelectedValue = 0 Then

            txtperiodAmount.Text = txtyearAmount.Text
            txtInvoiceNotes.Text = "PASconcept Annual Supscription"
            RadToolTipCreateInvoice.Visible = True
            RadToolTipCreateInvoice.Show()
        End If

        If cboBillingPeriod.SelectedValue = 1 Then

            txtperiodAmount.Text = Val(txtyearAmount.Text) / 4
            txtInvoiceNotes.Text = "PASconcept Quarterly Supscription"
            RadToolTipCreateInvoice.Visible = True
            RadToolTipCreateInvoice.Show()
        End If

        If cboBillingPeriod.SelectedValue = 2 Then

            txtperiodAmount.Text = Val(txtyearAmount.Text) / 12
            txtInvoiceNotes.Text = "PASconcept Monthly Supscription"
            RadToolTipCreateInvoice.Visible = True
            RadToolTipCreateInvoice.Show()
        End If
    End Sub
End Class