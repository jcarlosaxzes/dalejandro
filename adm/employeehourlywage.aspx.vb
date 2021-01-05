Public Class employeehourlywage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            lblCompanyId.Text = Session("companyId")
            lblEmployeeId.Text = LocalAPI.GetEmployeeIdFromGUID(Request.QueryString("guid"))
            lblYear.Text = Request.QueryString("year")
            lblDepartmentId.Text = Request.QueryString("departmentId")

            lblEmployeeEmail.Text = LocalAPI.GetEmployeeEmail(lId:=lblEmployeeId.Text)
            lblEmployeeName.Text = LocalAPI.GetEmployeeFullName(lblEmployeeEmail.Text, lblCompanyId.Text)

        End If

    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect($"~/adm/companymultiplier.aspx?year={lblYear.Text}&departmentId={lblDepartmentId.Text}")
    End Sub

    Private Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        ' Read Last Record
        lblHourlyWageHistoryId.Text = LocalAPI.GetHourlyWageHistoryLastRecord(lblEmployeeId.Text, lblYear.Text)
        Dim HourlyWageObject = LocalAPI.GetRecord(lblHourlyWageHistoryId.Text, "Employee_HourlyWageHistory_SELECT")
        RadDatePickerFrom.DbSelectedDate = Date.Today
        txtHourlyRate.DbValue = HourlyWageObject("Amount")
        RadNumericHour.DbValue = HourlyWageObject("HourPerWeek")
        RadNumericProducer.DbValue = HourlyWageObject("Producer")
        txtBenefits_vacations.DbValue = HourlyWageObject("Benefits_vacations")
        txtBenefits_personals.DbValue = HourlyWageObject("Benefits_personals")

        ' Show Dialog
        RadToolTipReview.Visible = True
        RadToolTipReview.Show()
    End Sub

    Private Sub btnInsert_Click(sender As Object, e As EventArgs) Handles btnInsert.Click
        Try
            SqlDataSource1.Insert()
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        RadHtmlChart1.DataBind()
        RadGrid1.DataBind()
        Master.InfoMessage("The record were inserted successfully!")
    End Sub

    Private Sub SqlDataSource1_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Deleted
        RadHtmlChart1.DataBind()
        RadGrid1.DataBind()
    End Sub

    Private Sub SqlDataSource1_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Updated
        RadHtmlChart1.DataBind()
        RadGrid1.DataBind()
    End Sub
End Class