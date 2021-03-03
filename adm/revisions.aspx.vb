Public Class revisions
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Revisions"
            If (Not Page.IsPostBack) Then

                '' Si no tiene permiso, la dirijo a message
                'If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_TransmittalList") Then Response.RedirectPermanent("~/adm/schedule.aspx")

                lblCompanyId.Text = Session("companyId")

                lblEmployeeId.Text = Master.UserId

                cboPeriod.DataBind()
                IniciaPeriodo(cboPeriod.SelectedValue)

                cboStatus.DataBind()
                cboStatus.SelectedValue = 0

            End If

        Catch ex As Exception

        End Try
    End Sub
    Private Sub IniciaPeriodo(nPeriodo As Integer)
        cboPeriod.SelectedValue = nPeriodo
        Select Case nPeriodo
            Case 13  ' (All Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/2000"
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

            Case 15  ' (Last Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Today.Year - 1
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year - 1

            Case 16  ' (This Month)
                RadDatePickerFrom.DbSelectedDate = Today.Month & "/01/" & Today.Year
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate))
            Case 17  ' (Past Month)
                RadDatePickerFrom.DbSelectedDate = Today.Month & "/01/" & Today.Year
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Month, -1, RadDatePickerFrom.DbSelectedDate)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate))

            Case 30, 60, 90, 120, 180, 365 '   days....
                RadDatePickerTo.DbSelectedDate = Date.Today
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Day, 0 - nPeriodo, RadDatePickerTo.DbSelectedDate)

            Case 99   'Custom
                RadDatePickerFrom.Focus()
                ' Allow RadDatePicker user Values...

            Case 14  '14 and any other old setting (This Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

            Case 99   'Custom
                RadDatePickerFrom.Focus()
                ' Allow RadDatePicker user Values...
        End Select
    End Sub

    Private Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RadGrid1.DataBind()
    End Sub
End Class