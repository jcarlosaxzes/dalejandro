Imports Telerik.Web.UI
Public Class bill_collected_employees
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ClientAccountsReport") Then Response.RedirectPermanent("~/adm/default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Bill vs Collected  by Employee"
            Master.PageTitle = "Billing/Bill vs Collected by Employee"
            Master.Help = "http://blog.pasconcept.com/2015/04/billing-bill-vs-collected.html"
            lblCompanyId.Text = Session("companyId")

            cboYear.DataBind()
            cboYear.SelectedValue = Date.Today.Year

        End If
    End Sub

    Private Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        Refresh()
    End Sub
    Private Sub Refresh()
        ShowCheckedOneItem(lblDepartmentIdIN_List, cboMultiDepartments)
        ShowCheckedOneItem(lblEmployeeIdIN_List, cboMultiEmployees)
        RadHtmlChart1.DataBind()
    End Sub

    Private Sub btnRefresh2_Click(sender As Object, e As EventArgs) Handles btnRefresh2.Click
        Refresh2()
    End Sub

    Private Sub Refresh2()
        RadHtmlChart2.DataBind()
    End Sub

    Private Sub ShowCheckedOneItem(LabelIN_List As Label, Combo1 As RadComboBox)
        ' Companies...............................
        LabelIN_List.Text = ""
        Dim collection As IList(Of RadComboBoxItem) = Combo1.CheckedItems
        If (collection.Count <> 0) Then

            For Each item As RadComboBoxItem In collection
                LabelIN_List.Text = LabelIN_List.Text + item.Value + ","
            Next
            ' Quitar la ultima coma
            LabelIN_List.Text = Left(LabelIN_List.Text, Len(LabelIN_List.Text) - 1)
        End If
    End Sub

    Private Sub SqlDataSourceChart_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceChart.Selecting
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub

    Private Sub cboMultiDepartments_ItemChecked(sender As Object, e As RadComboBoxItemEventArgs) Handles cboMultiDepartments.ItemChecked
        ShowCheckedOneItem(lblDepartmentIdIN_List, cboMultiDepartments)
        cboMultiEmployees.Items.Clear()
        cboMultiEmployees.DataBind()
    End Sub

    Protected Sub cboMultiEmployees_ItemDataBound(sender As Object, e As RadComboBoxItemEventArgs) Handles cboMultiEmployees.ItemDataBound
        e.Item.Checked = True
    End Sub

    Private Sub cboMultiDepartments_CheckAllCheck(sender As Object, e As RadComboBoxCheckAllCheckEventArgs) Handles cboMultiDepartments.CheckAllCheck
        ShowCheckedOneItem(lblDepartmentIdIN_List, cboMultiDepartments)
        cboMultiEmployees.Items.Clear()
        cboMultiEmployees.DataBind()
    End Sub

    Private Sub cboEmployeeStatus_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboEmployeeStatus.SelectedIndexChanged
        cboMultiEmployees.DataBind()
    End Sub
    Private Sub cboEmployeeStatus2_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboEmployeeStatus2.SelectedIndexChanged
        cboEmployees.Items.Clear()
        cboEmployees.Items.Insert(0, New RadComboBoxItem("(Select Employees...)", -1))
        cboEmployees.DataBind()
    End Sub

    Private Sub cboDepartments2_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboDepartments2.SelectedIndexChanged
        cboEmployees.Items.Clear()
        cboEmployees.Items.Insert(0, New RadComboBoxItem("(Select Employee...)", -1))
        cboEmployees.DataBind()
    End Sub

End Class
