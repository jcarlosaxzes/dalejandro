Imports Telerik.Web.UI

Public Class avgeemployeesprofit
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not IsPostBack Then
                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_EmployeesEfficiencyGraphic") Then Response.RedirectPermanent("~/adm/default.aspx")

                Master.PageTitle = "Employees/Employees Efficiency Graphic"
                Master.Help = "http://blog.pasconcept.com/2012/07/employees-efficiency-chart.html"
                lblCompanyId.Text = Session("companyId")
                Me.Title = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Name") & ". Employees Efficiency Graphic"

                SqlDataSourceYear.DataBind()
                cboYear.DataBind()
                cboYear.SelectedValue = Date.Today.Year

                cboDepartments.DataBind()
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub cboDepartments_ItemDataBound(sender As Object, e As RadComboBoxItemEventArgs) Handles cboDepartments.ItemDataBound
        e.Item.Checked = True
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RadGrid1.DataBind()
        RadHtmlChart1.DataBind()
    End Sub

    Private Sub SqlDataSource1_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSource1.Selecting
        e.Command.Parameters("@DepartmentIdIN_List").Value = GetMultiCheckInList(cboDepartments)
        e.Command.Parameters("@JobStatusIN_List").Value = GetMultiCheckInList(cboJobStatus)
    End Sub
    Private Function GetMultiCheckInList(Combo1 As RadComboBox) As String
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

End Class
