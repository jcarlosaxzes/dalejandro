Public Class employee_hourlywagehistory
    Inherits System.Web.UI.Page

    Protected Property SuccessMessageText() As String
        Get
            Return m_SuccessMessage
        End Get
        Private Set(value As String)
            m_SuccessMessage = value
            successMessage.Visible = Not [String].IsNullOrEmpty(value)
        End Set
    End Property
    Private m_SuccessMessage As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            lblCompanyId.Text = Session("companyId")
            lblEmployeeId.Text = Request.QueryString("employeeId")
            lblYear.Text = Request.QueryString("year")

            ''!!!
            'lblEmployeeId.Text = 2566
            'lblYear.Text = 2019

            lblEmployeeEmail.Text = LocalAPI.GetEmployeeEmail(lId:=lblEmployeeId.Text)
            lblEmployeeName.Text = LocalAPI.GetEmployeeFullName(lblEmployeeEmail.Text)

            ReadLastRecord()
        End If

    End Sub

    'Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
    '    Try
    '        SqlDataSource1.Update()
    '        SuccessMessageText = "The changes were saved successfully!"
    '        RadGrid1.DataBind()
    '    Catch ex As Exception
    '    SuccessMessageText = "Error. " & ex.Message
    '    End Try
    'End Sub
    Private Sub ReadLastRecord()
        lblHourlyWageHistoryId.Text = LocalAPI.GetHourlyWageHistoryLastRecord(lblEmployeeId.Text, lblYear.Text)
        FormView1.DataBind()
        Dim HourlyWageObject = LocalAPI.GetRecord(lblHourlyWageHistoryId.Text, "Employee_HourlyWageHistory_SELECT")
        RadDatePickerFrom.DbSelectedDate = Date.Today
        'RadDatePickerTo.DbSelectedDate = 
        txtHourlyRate.DbValue = HourlyWageObject("Amount")
        RadNumericHour.DbValue = HourlyWageObject("HourPerWeek")
        RadNumericProducer.DbValue = HourlyWageObject("Producer")
        txtBenefits_vacations.DbValue = HourlyWageObject("Benefits_vacations")
        txtBenefits_personals.DbValue = HourlyWageObject("Benefits_personals")
    End Sub

    Private Sub btnInsert_Click(sender As Object, e As EventArgs) Handles btnInsert.Click
        Try
            SqlDataSource1.Insert()
            SuccessMessageText = "The record were inserted successfully!"
            btnInsert.Visible = False
            RadGrid1.DataBind()
            ReadLastRecord()
        Catch ex As Exception
            SuccessMessageText = "Error. " & ex.Message
        End Try
    End Sub

    Private Sub SqlDataSourceHourlyWageDetail_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceHourlyWageDetail.Updated
        lblMonthUpdated.Text = Month(e.Command.Parameters("@Date").Value)
        If UpdateMultiplier() Then
            SuccessMessageText = "The record were Updated.  Multiplier and Deparment Budget Updated!"
        End If
    End Sub
    Private Function UpdateMultiplier() As Boolean
        Try
            LocalAPI.CompanyCalculateMultiplier(lblCompanyId.Text, lblYear.Text)
            Dim dbMultiplier As Double = LocalAPI.GetCompanyMultiplier(lblCompanyId.Text, lblYear.Text)
            LocalAPI.DeparmentBudgetByBaseSalaryForMultiplierFromThisMonth(lblCompanyId.Text, dbMultiplier, lblYear.Text, lblMonthUpdated.Text)
            ReadLastRecord()

            Return True

        Catch ex As Exception
            SuccessMessageText = "Error." & ex.Message
        End Try
    End Function

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        lblMonthUpdated.Text = Month(e.Command.Parameters("@Date").Value)
        If UpdateMultiplier() Then
            SuccessMessageText = "The record were Inserted.  Multiplier and Deparment Budget Updated!"
        End If
    End Sub

    Private Sub SqlDataSourceHourlyWageDetail_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceHourlyWageDetail.Deleted
        lblMonthUpdated.Text = 1
        If UpdateMultiplier() Then
            SuccessMessageText = "The record were Deleted.  Multiplier and Deparment Budget Updated!"
        End If
    End Sub
End Class
