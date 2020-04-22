Imports Telerik.Web.UI
Public Class time
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                ' Si no tiene permiso, la dirijo a message
                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Master.UserId
                If Not LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Deny_ProjectTimeEntries") Then Response.RedirectPermanent("~/ADM/Default.aspx")

                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Time Entries"

                If Not Request.QueryString("BasicMP") Is Nothing Then
                    'cboYear.SelectedValue = -1
                    'cboMes.SelectedValue = 0
                    cboPeriod.SelectedValue = 13
                    RadGrid1.Height = 400
                    RadGrid2.Height = 400
                Else
                    cboPeriod.SelectedValue = 30
                    'cboYear.SelectedValue = Today.Year
                    'cboMes.SelectedValue = Date.Today.Month
                End If
                cboPeriod.DataBind()
                IniciaPeriodo(cboPeriod.SelectedValue)

                SqlDataSourceEmployee.DataBind()
                cboEmployee.DataBind()

                SqlDataSourceClients.DataBind()
                cboClient.DataBind()

                If Not Request.QueryString("JobId") Is Nothing Then
                    SqlDataSourceJobs.DataBind()
                    cboJob.DataBind()
                    cboJob.SelectedValue = Request.QueryString("JobId")
                Else
                    ' Desde el Menu, seleccionamos el employee
                    cboEmployee.DataBind()
                    cboEmployee.SelectedValue = lblEmployeeId.Text
                End If

                RefrescarDatos()

                RadGrid2.AllowAutomaticDeletes = LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Deny_PayrollCalendar")

                Master.PageTitle = "Employees/Time Entries"
                Master.Help = "http://blog.pasconcept.com/2012/07/employees-project-time-entries.html"
            End If
            'RadWindow1.NavigateUrl = "~/RPT/rptTimesList.aspx?Empleado=" & Val("" & cboEmployee.SelectedValue) & "&Job=" & cboJob.SelectedValue & "&Client=" & cboClient.SelectedValue &
            '    "&Year=" & cboYear.SelectedValue & "&Mes=" & cboMes.SelectedValue & "&CategoryId=-1"
        Catch ex As Exception

        End Try
    End Sub

    Private Sub IniciaPeriodo(nPeriodo As Integer)

        Select Case nPeriodo
            Case 13  ' All Years...
                RadDatePickerFrom.DbSelectedDate = "01/01/2000"
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

            Case 30, 60, 90, 120, 180, 365 '   days....
                RadDatePickerTo.DbSelectedDate = Date.Today
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Day, 0 - nPeriodo, RadDatePickerTo.DbSelectedDate)

            Case 14  ' This year...
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Date.Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Date.Today.Year

        End Select
        cboPeriod.SelectedValue = nPeriodo
    End Sub
    Private Sub RefrescarDatos()
        Try

            RadGrid1.DataBind()
            RadGrid2.DataBind()

            PanelAssignedEmployees.Visible = (cboJob.SelectedValue > 0)
            lblPanelAssignedEmployees.Visible = PanelAssignedEmployees.Visible
        Catch ex As Exception
            Master.ErrorMessage(ex.Message, 5)
        End Try
    End Sub

    Protected Sub btnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        RefrescarDatos()
    End Sub

    'Protected Sub cboYear_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboYear.SelectedIndexChanged
    '    cboJob.Items.Clear()
    '    cboJob.Items.Insert(0, New RadComboBoxItem("(All jobs...)", -1))
    '    SqlDataSourceJobs.DataBind()
    'End Sub

    Protected Sub SqlDataSource1_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSource1.Selecting
        Dim e1 As String = e.Command.Parameters(0).Value

    End Sub
    Private Sub SqlDataSource1_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Selected
        Dim e1 As String = e.AffectedRows
    End Sub

    Public Function GetPercentETForeColor(ByVal dPercent As Object) As System.Drawing.Color
        If Val("" & dPercent) < 25 Then
            Return System.Drawing.Color.LightGreen
        ElseIf dPercent < 50 Then
            Return System.Drawing.Color.Green
        ElseIf dPercent < 75 Then
            Return System.Drawing.Color.Orange
        ElseIf dPercent < 100 Then
            Return System.Drawing.Color.OrangeRed
        Else
            Return System.Drawing.Color.DarkRed
        End If
    End Function
    Public Function GetPercentETFontBold(ByVal dPercent As Object) As Boolean
        If Val("" & dPercent) < 75 Then
            Return False
        Else
            Return True
        End If
    End Function


    Private Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.ItemCommand

        Select Case e.CommandName

            Case "NewHrInvoice"
                lblTimeId.Text = e.CommandArgument
                txtTimeSel.DbValue = LocalAPI.GetTimeProperty(lblTimeId.Text, "Time")
                txtRate.DbValue = LocalAPI.GetTimeProperty(lblTimeId.Text, "HourRate")
                txtTimeDescription.Text = LocalAPI.GetTimeProperty(lblTimeId.Text, "Description")
                ConfirmInsertDlg("New Invoice", "Create New (hr) Invoice from Time record")

            Case "DeleteHrInvoice"
                lblInvoiceSelected.Text = e.CommandArgument
                ConfirmDeleteDlg("Delete Invoice", "Delete (hr) Invoice Number " & LocalAPI.GetInvoiceProperty(e.CommandArgument, "InvoiceNumber"))

        End Select

    End Sub

    Private Sub ConfirmInsertDlg(Title As String, Text As String)
        RadToolTipConfirmInsert.Title = "<h2>" & Title & "</h2>"
        lblActionMesage.Text = Text & "<br /><br />Are you sure to do this action?<br /><br />"
        btnOk.Text = Title
        RadToolTipConfirmInsert.Visible = True
        RadToolTipConfirmInsert.Show()
    End Sub

    Private Sub ConfirmDeleteDlg(Title As String, Text As String)
        RadToolTipConfirmDelete.Title = "<h2>" & Title & "</h2>"
        lblActionMesage2.Text = Text & "<br /><br />Are you sure to do this action?<br /><br />"
        btnOk2.Text = Title
        RadToolTipConfirmDelete.Visible = True
        RadToolTipConfirmDelete.Show()
    End Sub


    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        RadToolTipConfirmInsert.Visible = False
    End Sub
    Protected Sub btnCancel2_Click(sender As Object, e As EventArgs) Handles btnCancel2.Click
        RadToolTipConfirmDelete.Visible = False
    End Sub

    Protected Sub btnOk_Click(sender As Object, e As EventArgs) Handles btnOk.Click
        Try

            Dim jobId As Integer = LocalAPI.GetTimeProperty(lblTimeId.Text, "Job")
            LocalAPI.NuevoInvoiceHourlyRate(lblTimeId.Text, jobId, txtTimeSel.DbValue, txtRate.DbValue, txtTimeDescription.Text)
            SqlDataSource1.DataBind()

            RadGrid1.DataBind()

            RadToolTipConfirmInsert.Visible = False

        Catch ex As Exception
            RadToolTipConfirmInsert.Visible = False
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub btnOk2_Click(sender As Object, e As EventArgs) Handles btnOk2.Click
        Try

            SqlDataSource1.Delete()
            SqlDataSource1.DataBind()

            RadGrid1.DataBind()

            RadToolTipConfirmDelete.Visible = False

        Catch ex As Exception
            RadToolTipConfirmDelete.Visible = False
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub RadGrid2_PreRender(sender As Object, e As EventArgs) Handles RadGrid2.PreRender
        RadGrid2.MasterTableView.GetColumn("DeleteColumn").Visible = LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Deny_PayrollCalendar")
    End Sub
End Class
