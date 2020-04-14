Imports Telerik.Web.UI
Public Class vendors
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_VendorsList") Then Response.RedirectPermanent("~/ADM/Default.aspx")
            ' Si no tiene permiso New, boton.Visible=False
            btnNewVendor.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewVendor")

            Master.PageTitle = "Contacts/Vendors List"
            Master.Help = "http://blog.pasconcept.com/2012/07/subconsultants-list.html"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Vendors List"
            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")
        End If
        RadWindowManager1.EnableViewState = False

    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditVendor"
                sUrl = "~/ADM/Vendor.aspx?vendorId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 850, 820)
        End Select
    End Sub
    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer)
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
        window1.OnClientClose = "OnClientClose"
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Protected Sub btnNewVendor_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewVendor.Click
        CreateRadWindows("NewVendor", "~/ADM/NewVendor.aspx", 850, 700)
    End Sub
End Class
