Public Class messages
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Email Records"
            Master.PageTitle = "Company/Email Records"
            Master.Help = "http://blog.pasconcept.com/2014/01/email-records-this-page-contains-copies.html"
            ' Usando valores de Properties de la Master page
            lblCompanyId.Text = Session("companyId")
            lblEmployeeEmail.Text = Master.UserEmail
            RefreshData()
        Catch ex As Exception

        End Try

    End Sub

    Private Sub RefreshData()
        RadGrid1.DataBind()
    End Sub

    Private Sub SqlDataSource1_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSource1.Selecting
        Dim e1 As String = e.Command.Parameters(0).Value
    End Sub

    Private Sub btnFind_Click(sender As Object, e As EventArgs) Handles btnFind.Click
        RefreshData()
    End Sub
End Class
