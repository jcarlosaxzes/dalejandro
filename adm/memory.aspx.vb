Public Class memory
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblEmployeeId.Text = 0
            If Not Request.QueryString("companyId") Is Nothing Then
                lblCompanyId.Text = Request.QueryString("companyId")

                If Not Request.QueryString("year") Is Nothing Then
                    lblYear.Text = Request.QueryString("year")
                Else
                    lblYear.Text = Date.Today.Year
                End If

                If Not Request.QueryString("employeeId") Is Nothing Then
                    lblEmployeeId.Text = Request.QueryString("employeeId")
                End If
                If Not Request.QueryString("JobStatusIN_List") Is Nothing Then
                    lblJobStatusIN_List.Text = Request.QueryString("JobStatusIN_List")
                End If



            End If
        End If
    End Sub

End Class