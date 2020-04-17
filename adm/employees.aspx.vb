Imports Telerik.Web.UI
Public Class employees
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Employees List"
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_EmployeesList") Then Response.RedirectPermanent("~/ADM/Default.aspx")
            ' Si no tiene permiso New, boton.Visible=False
            btnNew.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewEmployee")

            Master.PageTitle = "Employees/Employees List"
            Master.Help = "http://blog.pasconcept.com/2012/07/employees-list.html"
            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")
            cboStatus.DataBind()
            RadSchedulerVacation.SelectedDate = CDate("01/01/" & Date.Today.Year)
            RadSchedulerLive.SelectedDate = CDate("01/01/" & Date.Today.Year)

        End If
        'RadWindowManager1.EnableViewState = False
        If RadWindowManager1.Windows.Count > 0 Then
            RadWindowManager1.Windows.Clear()
            RadGrid1.DataBind()
        End If

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
        If LocalAPI.EliminarEmployee(CInt(lblSelected.Text)) Then
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

    Protected Sub btnCancelDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelDelete.Click
        lblSelected.Text = ""
        OcultarConfirmDelete()

    End Sub

    Private Sub MostrarConfirmDelete()
        RadToolTipDelete.Visible = True
        RadToolTipDelete.Show()
    End Sub

    Private Sub OcultarConfirmDelete()
        RadToolTipDelete.Visible = False
    End Sub


    Protected Sub cboYear_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboYear.SelectedIndexChanged
        RadSchedulerVacation.SelectedDate = CDate("01/01/" & cboYear.SelectedValue)
    End Sub

    Protected Sub cboYear2_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboYear2.SelectedIndexChanged
        RadSchedulerLive.SelectedDate = CDate("01/01/" & cboYear2.SelectedValue)
    End Sub

    Public Function GetEmployeePhotoURL(employeeId As Integer) As String
        Try
            'Return "~/Images/Employees/" & employeeId.ToString & ".jpg"
            Dim sImageURL = "~/Images/Employees/" & employeeId.ToString & ".jpg"

            If System.IO.File.Exists(Server.MapPath(sImageURL)) Then
                GetEmployeePhotoURL = sImageURL
            End If
            If Len(GetEmployeePhotoURL) = 0 Then GetEmployeePhotoURL = "~/Images/Employees/NophotoForList.jpg"

        Catch ex As Exception
        End Try
    End Function

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditEmployee"
                sUrl = "~/ADM/Employee.aspx?employeeId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 850, 700, True)
            Case "EditPhoto"
                'sUrl = "~/ADM/EditAvatar.aspx?Id=" & e.CommandArgument & "&Entity=Employee"
                sUrl = "~/ADM/UploadPhoto.aspx?Id=" & e.CommandArgument & "&Entity=Employee"
                CreateRadWindows(e.CommandName, sUrl, 640, 400, True)

            Case "SendCredentials"
                Dim sEmail As String = LocalAPI.GetEmployeeEmail(lId:=e.CommandArgument)
                If LocalAPI.ValidEmail(sEmail) Then
                    LocalAPI.RefrescarUsuarioVinculado(sEmail, "Empleados")
                    If LocalAPI.EmployeeEmailCredentials(EmployeeId:=e.CommandArgument, companyId:=lblCompanyId.Text) Then
                        Master.InfoMessage("The credentials were sent by email", 0)
                    End If
                End If

            Case "Permits"
                sUrl = "~/ADM/Employee_Permissions_form.aspx?employeeId=" & e.CommandArgument & "&Entity=Employee"
                CreateRadWindows(e.CommandName, sUrl, 960, 800, False)

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
        CreateRadWindows("NewEmployee", "~/ADM/newemployee.aspx", 850, 700, True)
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
            Return "glyphicon glyphicon-remove-circle"
        Else
            'Active
            Return "glyphicon glyphicon-ok-circle"
        End If
    End Function
    Public Function GetStatusColor(Inactive As Boolean) As System.Drawing.Color
        If Inactive Then
            Return System.Drawing.Color.Red
        Else
            Return System.Drawing.Color.Green
        End If

    End Function

End Class
