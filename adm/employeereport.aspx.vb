Public Class employeereport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Allow_DepartmentReport") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Master.PageTitle = "Analytics/Employee Report"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Employee Report"
            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")

            cboYear.DataBind()
            cboEmployees.DataBind()

            RefreshPage()
        End If
    End Sub
    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RefreshPage()
    End Sub

    Private Sub RefreshPage()
        btnView.DataBind()
    End Sub

    Public Function GetEmployeePhotoURL(Id As Integer) As String
        Try
            Dim sImageURL = "~/Images/Employees/" & Id & ".jpg"

            If Len(sImageURL) > 0 Then
                ' Existe el archivo en disco?
                If System.IO.File.Exists(Server.MapPath(sImageURL)) Then
                    GetEmployeePhotoURL = sImageURL
                End If
            End If
            If Len(GetEmployeePhotoURL) = 0 Then GetEmployeePhotoURL = "http://media.istockphoto.com/photos/businessman-silhouette-as-avatar-or-default-profile-picture-picture-id476085198?s=235x235"

        Catch ex As Exception
        End Try
    End Function

    Protected Sub btnMemory_Click(sender As Object, e As EventArgs) Handles btnMemory.Click
        LocalAPI.EmployeeEmailMemory(cboEmployees.SelectedValue, lblCompanyId.Text, cboYear.SelectedValue)
    End Sub
    Public Function GetMemoryUrl() As String
        Return "~/EMP/memory.aspx?companyId=" & lblCompanyId.Text & "&year=" & cboYear.SelectedValue & "&employeeId=" & cboEmployees.SelectedValue
    End Function
End Class
