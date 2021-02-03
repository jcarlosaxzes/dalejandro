Imports System.Threading.Tasks
Imports Telerik.Web.UI
Public Class employees
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Employees List"
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_EmployeesList") Then Response.RedirectPermanent("~/adm/default.aspx")
            ' Si no tiene permiso New, boton.Visible=False
            btnNew.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewEmployee")

            Master.PageTitle = "Employees/Employees List"
            Master.Help = "http://blog.pasconcept.com/2012/07/employees-list.html"
            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")
            cboStatus.DataBind()

            ActivateTechnicalSupportButton()

        End If
        RadWindowManager1.EnableViewState = False
        'If RadWindowManager1.Windows.Count > 0 Then
        '    RadWindowManager1.Windows.Clear()
        '    RadGrid1.DataBind()
        'End If

    End Sub

    Protected Sub RadGrid1_DeleteCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.DeleteCommand
        Try
            Dim ID As String = (CType(e.Item, GridDataItem)).OwnerTableView.DataKeyValues(e.Item.ItemIndex)("Id").ToString
            If Val(ID) > 0 Then
                lblSelected.Text = ID

                MostrarConfirmDelete()
            Else
                Master.ErrorMessage("Select the employee to delete", 0)
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Sub

    Protected Sub btnFind_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFind.Click
        RadGrid1.DataBind()
    End Sub

    Protected Sub btnConfirmDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnConfirmDelete.Click
        Dim CurrentInactive As Integer = IIf(LocalAPI.GetEmployeeProperty(lblSelected.Text, "Inactive"), 1, 0)
        Dim EmployeeName As String = LocalAPI.GetEmployeeProperty(lblSelected.Text, "FullName")
        If LocalAPI.EliminarEmployee(CInt(lblSelected.Text)) Then

            LocalAPI.sys_log_Nuevo(Master.UserEmail, LocalAPI.sys_log_AccionENUM.DeleteEmployee, lblCompanyId.Text, "Delete Employee: " & EmployeeName)

            OcultarConfirmDelete()
            Master.InfoMessage("The employee was deleted.")
            lblSelected.Text = ""

            If CurrentInactive = 0 Then
                ' Estaba Active...
                ' Afectaciones al Multiplier y Department Target
                LocalAPI.CompanyCalculateMultiplier(lblCompanyId.Text, Year(Today))
                Dim dbMultiplier As Double = LocalAPI.GetCompanyMultiplier(lblCompanyId.Text, Year(Today))
                LocalAPI.DeparmentBudgetByBaseSalaryForMultiplierFromThisMonth(lblCompanyId.Text, dbMultiplier, Year(Today), Month(Today))
            End If

            ' Refrescar el grid
            RadGrid1.DataBind()
        End If

    End Sub

    Private Sub MostrarConfirmDelete()
        RadToolTipDelete.Visible = True
        RadToolTipDelete.Show()
    End Sub

    Private Sub OcultarConfirmDelete()
        RadToolTipDelete.Visible = False
    End Sub


    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditEmployee"
                Response.Redirect("~/ADM/Employee.aspx?employeeId=" & e.CommandArgument)
            Case "EditPhoto"
                'sUrl = "~/ADM/EditAvatar.aspx?Id=" & e.CommandArgument & "&Entity=Employee"
                sUrl = "~/ADM/UploadPhoto.aspx?Id=" & e.CommandArgument & "&Entity=Employee"
                CreateRadWindows(e.CommandName, sUrl, 640, 480, True)

            Case "SendCredentials"
                Dim sEmail As String = LocalAPI.GetEmployeeEmail(lId:=e.CommandArgument)
                If LocalAPI.ValidEmail(sEmail) Then
                    Task.Run(Function() LocalAPI.RefrescarUsuarioVinculadoAsync(sEmail, "Empleados"))
                    If LocalAPI.EmployeeEmailCredentials(EmployeeId:=e.CommandArgument, companyId:=lblCompanyId.Text) Then
                        Master.InfoMessage("The credentials were sent by email", 0)
                    End If
                End If

            Case "Permits"
                Response.Redirect($"~/ADM/Employee_Permissions_form.aspx?employeeId={e.CommandArgument}&Entity=Employee&backpage=employees")

            Case "UpdateStatus"
                sUrl = "~/ADM/Employee_Status_form.aspx?employeeId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 800, 650, True)

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

    Protected Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        Response.Redirect("~/ADM/newemployee.aspx")
    End Sub

    Protected Sub RadGrid1_PreRender(sender As Object, e As EventArgs) Handles RadGrid1.PreRender
        Try

            RadGrid1.MasterTableView.GetColumn("Actions").Visible = Master.IsMasterUser()

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnQB_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim id As Integer = CType(sender, ImageButton).CommandArgument
            If Val(id) > 0 Then
                'qbAPI.CreateUpdateQBEmployee(id, lblCompanyId.Text, lblEmployee.Text)
                Master.InfoMessage("Employee successfully synchronized with QuickBook", 0)
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message & ". May be another employee, vendor, or customer is already using this name.  Please enter a different name")

        End Try
    End Sub

    Public Function ActiveInactiveIcon(Inactive As Boolean) As String
        If Inactive Then
            ' Inactive
            Return "fas fa-minus-circle"
        Else
            'Active
            Return "far fa-check-circle"
        End If
    End Function
    Public Function GetStatusColor(Inactive As Boolean) As System.Drawing.Color
        If Inactive Then
            Return System.Drawing.Color.Red
        Else
            Return System.Drawing.Color.Green
        End If

    End Function

    Private Sub btnTechnicalSupport_Click(sender As Object, e As EventArgs) Handles btnTechnicalSupport.Click
        If btnTechnicalSupport.Text = "Activate Technical Support" Then
            RadToolTipTechnicalSupport.Visible = True
            RadToolTipTechnicalSupport.Show()
        Else
            ' Deactivate Employee of Technical Support
            LocalAPI.DeactivateTechnicalSupportEmployee(Master.UserEmail, lblCompanyId.Text)
            RadGrid1.DataBind()
            ActivateTechnicalSupportButton()
        End If
    End Sub

    Private Sub btnConfirmActivateTechnicalSupport_Click(sender As Object, e As EventArgs) Handles btnConfirmActivateTechnicalSupport.Click
        If (Page.IsValid) Then
            LocalAPI.ActivateTechnicalSupportEmployee(Master.UserEmail, lblCompanyId.Text)
            RadGrid1.DataBind()
            ActivateTechnicalSupportButton()
        End If
    End Sub

    Private Sub ActivateTechnicalSupportButton()
        If LocalAPI.IsTechnicalSupportEmployee(lblCompanyId.Text) Then
            btnTechnicalSupport.Text = "Deactivate Technical Support"
            btnTechnicalSupport.ToolTip = "Deactivate Employee of Technical Support"
        Else
            btnTechnicalSupport.Text = "Activate Technical Support"
            btnTechnicalSupport.ToolTip = "Activate Employee for Technical Support"
        End If
    End Sub

    Protected Sub CheckBoxRequired_ServerValidate(sender As Object, e As ServerValidateEventArgs)
        e.IsValid = chkAuthorizeTS.Checked
    End Sub
#Region "Vacations"
    Private Sub RadScheduler1_AppointmentDataBound(sender As Object, e As SchedulerEventArgs) Handles RadScheduler1.AppointmentDataBound
        Select Case e.Appointment.Description
            Case "Vacation"
                e.Appointment.CssClass = "rsCategoryPink"
                e.Appointment.Font.Size = 10
                e.Appointment.ForeColor = System.Drawing.Color.White

            Case "Holiday"
                e.Appointment.CssClass = "rsCategoryGreen"
                e.Appointment.Font.Size = 10
                e.Appointment.ForeColor = System.Drawing.Color.White
        End Select
    End Sub

    Private Sub RadScheduler1_NavigationComplete(sender As Object, e As SchedulerNavigationCompleteEventArgs) Handles RadScheduler1.NavigationComplete
        Select Case e.Command
            Case SchedulerNavigationCommand.SwitchToSelectedDay And RadScheduler1.SelectedView = SchedulerViewType.DayView
                RadScheduler1.SelectedView = SchedulerViewType.WeekView
        End Select
    End Sub

#End Region

#Region "Hiring Timeline"
    Protected Sub TimelineOrders_ItemDataBound(ByVal sender As Object, ByVal e As RadTimelineItemEventArgs)
    End Sub

    Private Sub RadTimelineHiring_ItemDataBound(sender As Object, e As RadTimelineItemEventArgs) Handles RadTimelineHiring.ItemDataBound
        Dim dataItem = TryCast(e.Item.DataItem, DataRowView)
        Dim SrcPhoto = dataItem("SrcPhoto").ToString()
        If String.IsNullOrEmpty(SrcPhoto) Then
            SrcPhoto = "../Images/Employees/nophoto.jpg"
        End If
        e.Item.Images.Add(New TimelineItemImage() With {.Src = SrcPhoto})
    End Sub
#End Region
End Class
