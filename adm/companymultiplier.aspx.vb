Imports Telerik.Web.UI
Public Class companymultiplier
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If Not IsPostBack() Then
                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Multiplier") Then Response.RedirectPermanent("~/adm/default.aspx")

                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Company Multiplier"
                Master.PageTitle = "Company/Multiplier"
                lblCompanyId.Text = Session("companyId")

                cboYear.DataBind()
                If Not Request.QueryString("year") Is Nothing Then
                    cboYear.SelectedValue = Request.QueryString("year")
                Else
                    cboYear.SelectedValue = Year(Now())
                End If

                cboDepartments.DataBind()
                If Not Request.QueryString("departmentId") Is Nothing Then
                    cboDepartments.SelectedValue = Request.QueryString("departmentId")
                    RadWizardStepEmployeeHourlyWage.Active = True
                End If


                SqlDataSourceDptoTarget.DataBind()
                'ReadCompanyRates()
                cboMonthSalary.DataBind()
                cboMonthSalary.SelectedValue = Month(Today)

            End If
            RadWindowManager1.EnableViewState = False
        Catch ex As Exception

        End Try
    End Sub

    Private Sub btnNewMultiplier_Click(sender As Object, e As EventArgs) Handles btnNewMultiplier.Click
        '!!!RadGridMultiplier.MasterTableView.InsertItem()
        Response.Redirect("~/adm/multiplierwizard.aspx")
    End Sub

    Private Sub RadGridHourlyWage_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridHourlyWage.ItemCommand
        Select Case e.CommandName
            Case "EditHourlyWage"
                Dim guid As String = LocalAPI.GetEmployeeProperty(e.CommandArgument, "guid")
                Response.Redirect($"~/adm/employeehourlywage.aspx?guid={guid}&year={cboYear.SelectedValue}&departmentId={cboDepartments.SelectedValue}")
        End Select

    End Sub
    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, onClose As String)
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
        If Len(onClose) > 0 Then window1.OnClientClose = onClose
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Private Sub RadGridMonthlySalaryCalculation_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridMonthlySalaryCalculation.ItemCommand
        Select Case e.CommandName
            Case "EditHourlyWage"
                Dim guid As String = LocalAPI.GetEmployeeProperty(e.CommandArgument, "guid")
                Response.Redirect($"~/adm/employeehourlywage.aspx?guid={guid}&year={cboYear.SelectedValue}&departmentId={cboDepartments.SelectedValue}")
        End Select
    End Sub

    Private Sub Refresh()
        RadGridMultiplier.DataBind()
        RadGridDptoTarget.DataBind()
        RadGridHourlyWage.DataBind()
        RadGridMonthlySalaryCalculation.DataBind()
    End Sub

    Private Sub btnFind_Click(sender As Object, e As EventArgs) Handles btnFind.Click
        Refresh()
    End Sub

    Private Sub RadGridMultiplier_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGridMultiplier.ItemCommand
        Select Case e.CommandName
            Case "EditMultiplier"
                Response.Redirect($"~/adm/multiplierwizard.aspx?Id={e.CommandArgument}")
        End Select




    End Sub
End Class
