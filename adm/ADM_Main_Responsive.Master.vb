Imports System.Threading.Tasks
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin

Public Class ADM_Main_Responsive
    Inherits System.Web.UI.MasterPage

    Public UserIdp As Integer
    Public Companyp As Integer

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Try
            ' Inicializando Controles y Properties de la Master Page

            lblEmployeeEmail.Text = UserEmail
            cboCompany.DataBind()
            If Session("companyId") Is Nothing Then
                Session("companyId") = LocalAPI.GetCompanyDefault(UserEmail)
                Session("LastPage") = ""
            End If


            Dim versionId As Integer = LocalAPI.sys_VersionId(Session("companyId"))
            Session("Version") = versionId

            If LocalAPI.IsEmployeeInactive(UserEmail, Session("companyId")) Then
                ' INACTIVE LogOut
                FormsAuthentication.SignOut()
                FormsAuthentication.RedirectToLoginPage()
            Else
                lblCompanyId.Text = Session("companyId")
                Companyp = Session("companyId")
                UserId = LocalAPI.GetEmployeeId(UserEmail, lblCompanyId.Text)
                UserName = LocalAPI.GetEmployeeFullName(UserEmail, lblCompanyId.Text)
            End If

            If LocalAPI.IsFirewallViolation(UserId, Request.UserHostAddress()) Then
                ' Firewall violation
                FormsAuthentication.SignOut()
                'FormsAuthentication.RedirectToLoginPage()
                Response.Redirect("~/Default.aspx?IPAddress=" & Request.UserHostAddress())
            End If

            CheckbillingExpirationDate(Companyp)

            LocalAPI.AppUserManager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            LocalAPI.SiteUrl = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority)

        Catch ex As Exception
            Dim e1 As String = ex.Message
        End Try
    End Sub

    Private Function CheckbillingExpirationDate(companyId As Integer) As Boolean
        '!!!! Check Billing Expiracion Date
        If LocalAPI.GetCompanybillingExpirationDate(companyId) <= Date.Today Then

            If LocalAPI.GetCompanyBillingAmount(companyId) > 0 Then
                ' Payment subscriptor Page
                Response.Redirect("~/adm/subscribe/pro.aspx")
            Else
                ' If Free Plan (Amount=0), extend 'Expiracion Date'
                LocalAPI.CompanyExpirationDateUpdate(companyId, DateAdd(DateInterval.Year, 1, Date.Today))
            End If
        End If
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Session("companyId") Is Nothing Then
                Session("companyId") = LocalAPI.GetCompanyDefault(UserEmail)
            End If
            If Not LocalAPI.IAgree(UserEmail) And Val("" & Session("ReadLater")) <> "1" Then
                Response.RedirectPermanent("~/adm/useragree.aspx")
            Else
                btnCompanyName.Text = LocalAPI.GetCompanyName(Companyp)
            End If
            If cboCompany.SelectedValue <> Session("companyId") Then
                cboCompany.SelectedValue = Session("companyId")
            End If

            If Session("LastPage") <> HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Path) Then
                Session("LastPage") = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Path)
                Task.Run(Function() LocalAPI.EmployeePageTracking(UserId, Session("LastPage")))
            End If

            btnCompanyName.Enabled = (LocalAPI.GetCompanyBySubDomain() = 0)
        End If
    End Sub

    Public Function GetEmployeeImage(ByVal sEmail As String) As String
        Try
            Return LocalAPI.GetEmployeePhotoURL(Email:=sEmail)
        Catch ex As Exception
        End Try
    End Function

    Public Sub ErrorMessage(ByVal sText As String, Optional ByVal SecondsAutoCloseDelay As Integer = 0)
        If sText.Length > 0 Then
            RadNotificationError.Title = lblPageTitle.Text
            RadNotificationError.Text = sText
            RadNotificationError.AutoCloseDelay = SecondsAutoCloseDelay * 1000
            RadNotificationError.Show()
        End If
    End Sub

    Public Sub InfoMessage(ByVal sText As String, Optional ByVal SecondsAutoCloseDelay As Integer = 1)
        If sText.Length > 0 Then
            RadNotificationWarning.Title = lblPageTitle.Text
            RadNotificationWarning.Text = sText
            RadNotificationWarning.AutoCloseDelay = SecondsAutoCloseDelay * 1000
            RadNotificationWarning.Show()
        End If
    End Sub

    Public WriteOnly Property PageTitle() As String
        Set(ByVal value As String)
            lblPageTitle.Text = value
        End Set
    End Property

    Public WriteOnly Property Help() As String
        Set(ByVal value As String)
            'lnkHelp.NavigateUrl = value
            'lnkHelp.ToolTip = value
            'RadMenu2.FindNodeByText("Help").NavigateUrl = value
        End Set
    End Property

    Public Property UserId() As Integer
        Get
            UserId = UserIdp
        End Get
        Set(ByVal value As Integer)
            UserIdp = value.ToString
        End Set
    End Property

    Public Property UserEmail() As String
        Get
            UserEmail = Context.User.Identity.GetUserName()
            If Session("AdmLogin") Is Nothing Then
                Session("AdmLogin") = UserEmail
                Try
                    LocalAPI.sys_log_Nuevo(UserEmail, LocalAPI.sys_log_AccionENUM.AdminLogin, Session("companyId"), LocalAPI.GetEmployeeFullName(UserEmail, Companyp))
                Catch ex As Exception

                End Try
            End If
        End Get
        Set(ByVal value As String)
            lblEmployeeEmail.Text = value.ToString
        End Set
    End Property

    Public Property UserName() As String
        Get
            UserName = lblUserName.Text

        End Get
        Set(ByVal value As String)
            lblUserName.Text = value.ToString
        End Set
    End Property

    Public Function IsMasterUser() As Boolean
        Return LocalAPI.IsMasterUser(UserEmail, Companyp)
    End Function
    Public Function VersionCaracteristica(CaracteristicaId As Integer) As Boolean
        Return LocalAPI.sys_CaracteristicaVisible(CaracteristicaId, Session("Version"))
    End Function

    Public Function EmployeePermission(sOpcion As String) As Boolean
        Try
            If Session(sOpcion) Is Nothing And UserId > 0 Then
                ' Reads all permissions once and updates Session
                Dim permissions = LocalAPI.GetEmployeePermissions(UserId)
                For Each kvp In permissions
                    ' Following pattern in `GetEmployeePermissions'
                    ' Negates permissions that starts with "Deny"
                    Session(kvp.Key) = If(kvp.Key.StartsWith("Deny"), Not kvp.Value, kvp.Value)
                Next
                ' Session(sOpcion) = LocalAPI.GetEmployeePermission(UserId, sOpcion)
            End If
            Return Session(sOpcion)
        Catch ex As Exception
            ErrorMessage(ex.Message)
        End Try
    End Function

    Public Function EmployeePermissionHiden(sOpcion As String) As Integer
        If Session(sOpcion) Is Nothing Then
            Session(sOpcion) = LocalAPI.GetEmployeePermission(UserId, sOpcion)
        End If
        If Session(sOpcion) Then
            Return 0
        Else
            Return 1
        End If

    End Function
    Public Sub btnSwitchCompany_Click(sender As Object, e As EventArgs)
        If btnCompanyName.Enabled Then
            RadToolTipSwitchCompany.Visible = True
            RadToolTipSwitchCompany.Show()
        Else
            ErrorMessage("Current subdomain does not allow switch company!")
        End If
    End Sub

    Private Sub btnSwitchCompanyConfirm_Click(sender As Object, e As EventArgs) Handles btnSwitchCompanyConfirm.Click
        ' Clear session Permissions
        Session.Contents.RemoveAll()
        Session("companyId") = cboCompany.SelectedValue
        lblCompanyId.Text = cboCompany.SelectedValue
        Companyp = cboCompany.SelectedValue

        If chkSetAsDefault.Checked Then
            SqlDataSourceCompany.Update()
        End If
        LocalAPI.SetLastCompanyId(lblEmployeeId.Text, cboCompany.SelectedValue)

        Session("Version") = LocalAPI.sys_VersionId(Session("companyId"))
        btnCompanyName.Text = LocalAPI.GetCompanyName(cboCompany.SelectedValue)

        ' Navegate Default Page
        Response.RedirectPermanent("~/adm/Start.aspx")
    End Sub
    Public Function IsTicketsVisible() As Boolean
        ' Programmers/Computer/IT
        If Session("companyId") Is Nothing Then
            Session("companyId") = LocalAPI.GetCompanyDefault(UserEmail)
        End If
        Return (LocalAPI.GetCompanyProperty(Session("companyId"), "Type") = 16)
    End Function

    Protected Sub Unnamed_LoggingOut(sender As Object, e As LoginCancelEventArgs)
        Context.GetOwinContext().Authentication.SignOut()
        Session.Contents.RemoveAll()
        Session.Abandon()
    End Sub

    Public Function HideMasterMenu() As Boolean
        PanelHeader.Visible = False
        PanelFotter.Visible = False
    End Function

End Class



