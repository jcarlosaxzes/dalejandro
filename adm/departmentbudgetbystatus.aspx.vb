Public Class departmentbudgetbystatus
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                ' Si no tiene permiso, la dirijo a message LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Budget")
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Budget") Then Response.RedirectPermanent("~/adm/schedule.aspx")
                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Department Budget by Status"
                Master.PageTitle = "Department/Budget by Status"

                lblCompanyId.Text = Session("companyId")

                RadDatePickerFrom.DbSelectedDate = "2000-01-01"
                RadDatePickerTo.DbSelectedDate = Year(Date.Today) & "-12-31"
            End If

        Catch ex As Exception

        End Try
    End Sub

End Class
