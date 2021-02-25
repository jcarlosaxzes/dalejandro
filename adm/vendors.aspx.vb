Imports Telerik.Web.UI
Public Class vendors
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_VendorsList") Then Response.RedirectPermanent("~/adm/schedule.aspx")
            ' Si no tiene permiso New, boton.Visible=False
            btnNewVendor.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewVendor")

            Master.PageTitle = "Contacts/Vendors List"
            Master.Help = "http://blog.pasconcept.com/2012/07/subconsultants-list.html"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Vendors List"
            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")
        End If

    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditVendor"
                Response.Redirect("~/ADM/Vendor.aspx?vendorId=" & e.CommandArgument)
        End Select
    End Sub

    Protected Sub btnNewVendor_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewVendor.Click
        Response.Redirect("~/ADM/NewVendor.aspx")
    End Sub
End Class
