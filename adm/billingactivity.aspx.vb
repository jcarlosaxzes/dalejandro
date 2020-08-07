Public Class billingactivity
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then

            ' Si no tiene permiso, la dirijo a message
            lblEmployeeId.Text = Master.UserId
            If Not LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Deny_BillingManager") Then Response.RedirectPermanent("~/adm/default.aspx")
            Master.PageTitle = "Billing/Activity"
            Master.Help = "http://blog.pasconcept.com/2012/05/billing-invoices-list-page.html"
            lblCompanyId.Text = Session("companyId")


            cboPeriod.DataBind()
            cboPeriod.SelectedValue = Date.Today.Month
            IniciaPeriodo(cboPeriod.SelectedValue)

            RefreshPage()
        End If
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RefreshPage()
    End Sub

    Private Sub RefreshPage()

        RadChartRemainderStadistic.DataBind()
    End Sub

    Private Sub IniciaPeriodo(nPeriodo As Integer)

        Select Case nPeriodo
            Case 0  ' Today
                RadDatePickerFrom.DbSelectedDate = Date.Today
                RadDatePickerTo.DbSelectedDate = Date.Today
            Case 1 To 12 ' Meses
                RadDatePickerFrom.DbSelectedDate = nPeriodo & "/01/" & Date.Today.Year
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, RadDatePickerTo.DbSelectedDate)
            Case 13  ' Year
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Date.Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Date.Today.Year
            Case 14  ' All Years
                RadDatePickerFrom.DbSelectedDate = "01/01/2014"
                RadDatePickerTo.DbSelectedDate = "12/31/" & Date.Today.Year
        End Select

    End Sub
    Protected Sub cboPeriod_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.DropDownListEventArgs) Handles cboPeriod.SelectedIndexChanged
        IniciaPeriodo(cboPeriod.SelectedValue)
    End Sub

    Protected Sub day_CheckedChanged(sender As Object, e As EventArgs) Handles day.CheckedChanged, hour.CheckedChanged, week.CheckedChanged, weekday.CheckedChanged, month.CheckedChanged, quarter.CheckedChanged, year.CheckedChanged
        lblDatePart.Text = DirectCast(sender, CheckBox).ID
        If lblDatePart.Text = "year" Then
            IniciaPeriodo(14)
        End If
        RefreshPage()
    End Sub

End Class
