Imports Telerik.Web.UI

Public Class employeereport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Allow_DepartmentReport") Then Response.RedirectPermanent("~/adm/default.aspx")

            Master.PageTitle = "Analytics/Employee Report"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Employee Report"
            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")

            cboYear.DataBind()
            cboEmployees.DataBind()

            RefreshPage()
        End If
    End Sub
    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RefreshPage()
    End Sub

    Private Sub RefreshPage()
        FormView1.DataBind()
        RadGridDepartmentFTE.DataBind()
        RadGridEfficiency.DataBind()
        btnView.DataBind()
        SqlDataSourceEfficiencyHistory.DataBind()
        RadHtmlChart1.DataBind()
    End Sub

    Protected Sub btnMemory_Click(sender As Object, e As EventArgs) Handles btnMemory.Click
        LocalAPI.EmployeeEmailMemory(cboEmployees.SelectedValue, lblCompanyId.Text, cboYear.SelectedValue)
    End Sub

    Private Sub SqlDataSourceReportByDepartment_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceReportByDepartment.Selecting
        e.Command.Parameters("@JobStatusIN_List").Value = GetMultiCheckInList(cboJobStatus)
    End Sub

    Private Sub SqlDataSourceReportByJobs_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceReportByJobs.Selecting
        e.Command.Parameters("@JobStatusIN_List").Value = GetMultiCheckInList(cboJobStatus)
    End Sub

    Private Sub SqlDataSourceEmployee_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceEmployee.Selecting
        e.Command.Parameters("@JobStatusIN_List").Value = GetMultiCheckInList(cboJobStatus)
    End Sub

    Public Function GetMultiCheckInList(Combo1 As RadComboBox) As String
        ' Companies...............................
        Dim ResultList As String = ""
        Dim collection As IList(Of RadComboBoxItem) = Combo1.CheckedItems
        If (collection.Count <> 0) Then

            For Each item As RadComboBoxItem In collection
                ResultList = ResultList + item.Value + ","
            Next
            ' Quitar la ultima coma
            ResultList = Left(ResultList, Len(ResultList) - 1)
            Return ResultList
        End If
    End Function

    Private Sub SqlDataSourceEfficiencyHistory_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceEfficiencyHistory.Selecting
        e.Command.Parameters("@JobStatusIN_List").Value = GetMultiCheckInList(cboJobStatus)
    End Sub
End Class
