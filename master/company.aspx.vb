Public Class company1
    Inherits System.Web.UI.Page


    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As EventArgs) Handles Me.PreInit
        Theme = LocalAPI.DefinirTheme(Request.UserAgent)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            If Request.QueryString("companyId") <> Nothing Then
                lblCompanyId.Text = Request.QueryString("companyId")
            End If
            btnDelete.Enabled = (LocalAPI.GetClientsNumbers(lblCompanyId.Text) < 2)
            Dim CompanyObject = LocalAPI.GetRecord(lblCompanyId.Text, "CompanyAccount_SELECT")
            lblGetStartedEmailDate.Text = CompanyObject("GetStartedEmailDate")
        End If
    End Sub

    Protected Sub RadToolBar1_ButtonClick(ByVal sender As Object, ByVal e As Telerik.Web.UI.RadToolBarEventArgs) Handles RadToolBar1.ButtonClick
        Select Case e.Item.Text
            Case "Employees"
                Response.RedirectPermanent("~/MASTER/employees.aspx?companyId=" & lblCompanyId.Text)
            Case "Billing"
                Response.RedirectPermanent("~/MASTER/CompanyPayments.aspx?companyId=" & lblCompanyId.Text)
            Case "Analytics"
                Response.RedirectPermanent("~/MASTER/Stadistic.aspx?companyId=" & lblCompanyId.Text)
        End Select
    End Sub

    Protected Sub btnDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        lblMasterMail.Text = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Email")
        SqlDataSource1.Delete()
    End Sub

    Private Sub SqlDataSource1_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Deleted
        Try
            LocalAPI.EliminarUser(lblMasterMail.Text)
            Response.RedirectPermanent("~/MASTER/CompanyList.aspx")
        Catch ex As Exception
        End Try
    End Sub

    Private Sub btnSentContactAgain_Click(sender As Object, e As EventArgs) Handles btnSentContactAgain.Click
        If LocalAPI.PASconceptGetStartedEmail(lblCompanyId.Text) Then
            LocalAPI.ExecuteNonQuery("UPDATE [Company] SET [GetStartedEmailDate]=dbo.CurrentTime() WHERE companyId=" & lblCompanyId.Text)
            lblGetStartedEmailDate.Text = Date.Now()
        End If
    End Sub
End Class
