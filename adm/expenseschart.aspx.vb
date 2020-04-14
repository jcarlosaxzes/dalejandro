Public Class expenseschart
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Expenseschart") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Master.PageTitle = "Analytics/Expenses Chart"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Expenses Chart"
            lblCompanyId.Text = Session("companyId")

            cboYear.DataBind()

            RefreshPage()
        End If
    End Sub
    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RefreshPage()
    End Sub

    Private Sub RefreshPage()

    End Sub

    Private Sub SqlDataSource1_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSource1.Selecting
        e.Command.Parameters(2).Value = ""
    End Sub

End Class
