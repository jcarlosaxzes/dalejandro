Imports Telerik.Web.UI
Public Class employee_permissions
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            lblCompanyId.Text = Session("companyId")
            ' Si no tiene permiso, la dirijo a message

            If Not Master.IsMasterUser() Then
                Response.RedirectPermanent("~/ADM/Default.aspx")
            End If

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Employee Permissions"
            Master.PageTitle = "Employees/Employees Permissions"
        End If
        RadWindowManager1.EnableViewState = False
    End Sub

    Protected Sub btnApply_Click(sender As Object, e As EventArgs) Handles btnApply.Click
        Try
            If cboSourceRole.SelectedValue > 0 Then

                ' Parche para refrescar roleId
                lblRoleId.Text = LocalAPI.GetEmployeeRoleId(cboSourceRole.Text, lblCompanyId.Text)

                'get a reference to the row
                If RadGrid1.SelectedItems.Count > 0 Then
                    For Each dataItem As GridDataItem In RadGrid1.SelectedItems
                        If dataItem.Selected Then
                            lblSelectedEmpl.Text = dataItem("Id").Text
                            ' El SqlDataSource1 tiene asociado "empl_COPY_PERMISOS" en el INSERT
                            SqlDataSource1.Insert()
                        End If
                    Next
                    SqlDataSource1.DataBind()
                    RadGrid1.DataBind()
                    Master.InfoMessage("The Role " & cboSourceRole.Text & " was applied to the selected employees!")
                End If
            Else
                Master.ErrorMessage("Select Role!")
                cboSourceRole.Focus()
            End If


        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub


    Private Sub ConfigureExport_csv()
        RadGridToPrint.AllowPaging = False
        RadGridToPrint.ExportSettings.FileName = "PASConcept_Users_" & Format(Date.Today, "MM-dd-yyyy")
        RadGridToPrint.ExportSettings.ExportOnlyData = True
        RadGridToPrint.ExportSettings.IgnorePaging = True
        RadGridToPrint.ExportSettings.OpenInNewWindow = True
        'RadGridToPrint.ExportSettings.UseItemStyles = False
        'RadGridToPrint.ExportSettings.HideStructureColumns = True
        'RadGridToPrint.MasterTableView.ShowFooter = True
    End Sub

    Private Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
        ConfigureExport_csv()
        RadGridToPrint.MasterTableView.ExportToCSV()
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "Permits"
                sUrl = "~/ADM/Employee_Permissions_form.aspx?employeeId=" & e.CommandArgument & "&Entity=Employee"
                CreateRadWindows(e.CommandName, sUrl, 960, 800, False)
        End Select
    End Sub
    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, bRefreshOnClientClose As Boolean)
        RadWindowManager1.Windows.Clear()
        Dim window1 As RadWindow = New RadWindow()
        window1.NavigateUrl = sUrl
        window1.VisibleOnPageLoad = True
        window1.VisibleStatusbar = False
        window1.ID = WindowsID
        'window1.InitialBehaviors = WindowBehaviors.Maximize
        window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
        window1.Width = Width
        window1.Height = Height
        window1.Modal = True
        If bRefreshOnClientClose Then window1.OnClientClose = "OnClientClose"
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Private Sub btnApplyIPv4toRole_Click(sender As Object, e As EventArgs) Handles btnApplyIPv4toRole.Click
        Try
            If cboSourceRole.SelectedValue > 0 Then

                SqlDataSourceRoles.Update()
                RadGrid1.DataBind()
            Else
                Master.ErrorMessage("Select Role!")
                cboSourceRole.Focus()
            End If


        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub SqlDataSourceRoles_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceRoles.Updating
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub
End Class
