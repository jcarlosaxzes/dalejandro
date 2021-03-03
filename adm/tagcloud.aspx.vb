Public Class tagcloud
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then

            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_JobTagFinder") Then Response.RedirectPermanent("~/adm/schedule.aspx")

            lblCompanyId.Text = Session("companyId")
            lblEmployeeId.Text = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ".Projects Tag Search"
            Master.PageTitle = "Projects Tag Search"
            Master.Help = "http://blog.pasconcept.com/2015/03/dashboard.html"


            Dim DepartmentId As Integer = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "DepartmentId")
            If DepartmentId > 0 Then
                cboDepartments.DataBind()
                cboDepartments.SelectedValue = DepartmentId
            End If

        End If
    End Sub

    'Private Sub RadTagCloud1_ItemClick(sender As Object, e As RadTagCloudEventArgs) Handles RadTagCloud1.ItemClick
    '    lblSelectedTag.Text = e.Item.Text
    '    btnExport.Visible = True
    '    RadGridJobs.Visible = True
    '    RadGridJobs.DataBind()
    'End Sub

    Private Sub ConfigureExport_csv()
        RadGridJobs.AllowPaging = False
        RadGridJobs.ExportSettings.FileName = "Job Tags -" & Today.Date
        RadGridJobs.ExportSettings.ExportOnlyData = True
        RadGridJobs.ExportSettings.IgnorePaging = True
        RadGridJobs.ExportSettings.OpenInNewWindow = True
        'RadGridJobs.ExportSettings.UseItemStyles = False
        'RadGridJobs.ExportSettings.HideStructureColumns = True
        'RadGridJobs.MasterTableView.ShowFooter = True
    End Sub

    Private Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
        ConfigureExport_csv()
        RadGridJobs.MasterTableView.ExportToCSV()
    End Sub

    Private Sub SqlDataSourceJobs_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceJobs.Selecting
        Select Case cboMultiselectTagCONTAINS.CheckedItems.Count
            Case "0"
                e.Command.Parameters("@TagCONTAINS").Value = "EDF90DEF-7894-4E8B-9E56-AC67FC22E060"
            Case 1
                e.Command.Parameters("@TagCONTAINS").Value = Replace(cboMultiselectTagCONTAINS.Text, " ", ",")
            Case > 1
                e.Command.Parameters("@TagCONTAINS").Value = "NEAR ((" & cboMultiselectTagCONTAINS.Text & "), MAX, FALSE)"
        End Select
    End Sub

    Private Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RadGridJobs.DataBind()
    End Sub
End Class
