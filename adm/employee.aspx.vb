Imports Telerik.Web.UI
Public Class employee
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Request.QueryString("employeeId")
                Master.PageTitle = "Employees/Edit Employee: " & LocalAPI.GetEmployeeName(lblEmployeeId.Text)

                lblInactive.Text = IIf(LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "Inactive"), 1, 0)
                FormView1.Enabled = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewEmployee")
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Private Sub FormView1_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles FormView1.ItemCommand
        Select Case e.CommandName
            Case "Photo"
                'Response.Redirect("~/ADM/EditAvatar.aspx?Id=" & lblEmployeeId.Text & "&Entity=Employee")
                Response.Redirect("~/ADM/UploadPhoto.aspx?Id=" & lblEmployeeId.Text & "&Entity=Employee")
        End Select
    End Sub

    Private Sub SqlDataSource1_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Updated
        If lblInactive.Text <> e.Command.Parameters("@Inactive").Value Then
            If lblCompanyId.Text = 260962 Then
                ' Change status in eeg360
                eeg360.EmployeeStatus_UPDATE(e.Command.Parameters("@Email").Value, IIf(e.Command.Parameters("@Inactive").Value = 0, 1, 0))

                lblInactive.Text = e.Command.Parameters("@Inactive").Value
            End If
        End If

    End Sub
End Class
