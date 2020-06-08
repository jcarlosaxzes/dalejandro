Imports Telerik.Web.UI

Public Class employee
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Request.QueryString("employeeId")

                If LocalAPI.IsCompanyViolation(lblEmployeeId.Text, "Employees", lblCompanyId.Text) Then Response.RedirectPermanent("~/ADM/Default.aspx")

                If Not Request.QueryString("fromcontacts") Is Nothing Then
                    lblBackSource.Text = 1
                End If
                Master.PageTitle = "Employees/Edit Employee: " & LocalAPI.GetEmployeeName(lblEmployeeId.Text)

                lblInactive.Text = IIf(LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "Inactive"), 1, 0)
                FormView1.Enabled = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewEmployee")

                'If Request.QueryString("FullPage") Is Nothing Then
                '    Master.HideMasterMenu()
                '    btnBack.Visible = False
                'End If
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Private Sub FormView1_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles FormView1.ItemCommand
        Select Case e.CommandName
            Case "Photo"
                CreateRadWindows(e.CommandName, "~/ADM/UploadPhoto.aspx?Id=" & lblEmployeeId.Text & "&Entity=Employee", 640, 480, True)

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
    Private Sub SqlDataSource1_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Updated
        If lblInactive.Text <> e.Command.Parameters("@Inactive").Value Then
            If lblCompanyId.Text = 260962 Then
                ' Change status in eeg360
                'eeg360.EmployeeStatus_UPDATE(e.Command.Parameters("@Email").Value, IIf(e.Command.Parameters("@Inactive").Value = 0, 1, 0))

                lblInactive.Text = e.Command.Parameters("@Inactive").Value
            End If
        End If

    End Sub
    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Back()
    End Sub
    Private Sub btnTotals_Click(sender As Object, e As EventArgs) Handles btnTotals.Click
        FormViewEmployeeBalance.Visible = Not FormViewEmployeeBalance.Visible
    End Sub

    Private Sub Back()
        If lblBackSource.Text = 1 Then
            Response.Redirect("~/adm/contacts.aspx?restoreFilter=true")
        Else
            Response.Redirect("~/adm/employees.aspx?restoreFilter=true")
        End If

    End Sub
End Class
