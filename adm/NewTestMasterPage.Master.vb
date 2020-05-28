Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin
Public Class NewTestMasterPage
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Try
            ' Inicializando Controles y Properties de la Master Page
            UserEmail = Context.User.Identity.GetUserName()
            cboCompany.DataBind()
            If Session("companyId") Is Nothing Then
                Session("companyId") = cboCompany.SelectedValue
            Else
                If cboCompany.SelectedValue <> Session("companyId") Then
                    cboCompany.SelectedValue = Session("companyId")
                End If
            End If

            Dim versionId As Integer = LocalAPI.sys_VersionId(Session("companyId"))
            Session("Version") = versionId
            lblVersion.Text = LocalAPI.sys_VersionAndRevision(versionId)

            If LocalAPI.IsEmployeeInactive(UserEmail, Session("companyId")) Then
                ' INACTIVE LogOut
                FormsAuthentication.SignOut()
                FormsAuthentication.RedirectToLoginPage()
            Else
                lblCompanyId.Text = Session("companyId")
                UserId = LocalAPI.GetEmployeeId(UserEmail, lblCompanyId.Text)
                UserName = LocalAPI.GetEmployeeFullName(UserEmail)
            End If

            If LocalAPI.IsFirewallViolation(UserId, Request.UserHostAddress()) Then
                ' Firewall violation
                FormsAuthentication.SignOut()
                'FormsAuthentication.RedirectToLoginPage()
                Response.Redirect("~/Default.aspx?IPAddress=" & Request.UserHostAddress())
            End If

            CheckbillingExpirationDate(lblCompanyId.Text)

            LocalAPI.AppUserManager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()


        Catch ex As Exception
            Dim e1 As String = ex.Message
        End Try
    End Sub

    Private Function CheckbillingExpirationDate(companyId As Integer) As Boolean
        '!!!! Check Billing Expiracion Date
        If LocalAPI.GetCompanybillingExpirationDate(companyId) <= Date.Today Then

            If LocalAPI.GetCompanyBillingAmount(companyId) > 0 Then
                ' Payment subscriptor Page
                Response.Redirect("~/ADM/subscribe/pro.aspx")
            Else
                ' If Free Plan (Amount=0), extend 'Expiracion Date'
                LocalAPI.CompanyExpirationDateUpdate(companyId, DateAdd(DateInterval.Year, 1, Date.Today))
            End If
        End If
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            If Not LocalAPI.IAgree(UserEmail) And Val("" & Session("ReadLater")) <> "1" Then
                Response.RedirectPermanent("~/adm/useragree.aspx")
            Else

                'Dim Asunto As String
                'Dim MessId As Integer

                RadMenu2.DataBind()
                'If LocalAPI.GetNotificationPending(Context.User.Identity.GetUserName(), Asunto, MessId) Then
                '    InfoMessage(Asunto)
                'End If

                ' Device detection
                'Dim screenSize As DeviceScreenSize = Detector.GetScreenSize(Request.UserAgent)
                'If screenSize = DeviceScreenSize.ExtraLarge Then
                '    RadMenu2.RenderMode = Telerik.Web.UI.RenderMode.Classic
                'End If

                lblCompanyName.Text = LocalAPI.GetCompanyName(cboCompany.SelectedValue)
            End If
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
            lnkHelp.NavigateUrl = value
            lnkHelp.ToolTip = value
            RadMenu2.FindItemByText("Help").NavigateUrl = value
        End Set
    End Property

    Public Property UserId() As Integer
        Get
            UserId = lblEmployeeId.Text
        End Get
        Set(ByVal value As Integer)
            lblEmployeeId.Text = value.ToString
        End Set
    End Property

    Public Property UserEmail() As String
        Get
            UserEmail = lblEmployeeEmail.Text
            If Session("AdmLogin") Is Nothing Then
                Session("AdmLogin") = UserEmail
                Try
                    LocalAPI.sys_log_Nuevo(UserEmail, LocalAPI.sys_log_AccionENUM.AdminLogin, cboCompany.SelectedValue, LocalAPI.GetEmployeeFullName(UserEmail))
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
        Return LocalAPI.IsMasterUser(UserEmail, lblCompanyId.Text)
    End Function
    Public Function VersionCaracteristica(CaracteristicaId As Integer) As Boolean
        Return LocalAPI.sys_CaracteristicaVisible(CaracteristicaId, Session("Version"))
    End Function

    Public Function EmployeePermission(sOpcion As String) As Boolean
        If Session(sOpcion) Is Nothing Then
            Session(sOpcion) = LocalAPI.GetEmployeePermission(UserId, sOpcion)
        End If
        Return Session(sOpcion)
    End Function

    Private Sub btnSwitchCompany_Click(sender As Object, e As EventArgs) Handles btnSwitchCompany.Click
        RadToolTipSwitchCompany.Visible = True
        RadToolTipSwitchCompany.Show()
    End Sub

    Private Sub btnSwitchCompanyConfirm_Click(sender As Object, e As EventArgs) Handles btnSwitchCompanyConfirm.Click
        ' Clear session Permissions
        Session.Contents.RemoveAll()

        Session("companyId") = cboCompany.SelectedValue
        lblCompanyId.Text = cboCompany.SelectedValue

        If chkSetAsDefault.Checked Then
            SqlDataSourceCompany.Update()
        End If
        LocalAPI.SetLastCompanyId(lblEmployeeId.Text, cboCompany.SelectedValue)

        Session("Version") = LocalAPI.sys_VersionId(Session("companyId"))
        lblCompanyName.Text = LocalAPI.GetCompanyName(cboCompany.SelectedValue)
        FormViewCompany.DataBind()

        ' Navegate Default Page
        Response.RedirectPermanent("~/ADM/Start.aspx")
    End Sub
    Public Function IsTicketsVisible() As Boolean
        ' Programmers/Computer/IT
        Return (LocalAPI.GetCompanyProperty(Session("companyId"), "Type") = 16)
    End Function

    Protected Sub Unnamed_LoggingOut(sender As Object, e As LoginCancelEventArgs)
        Context.GetOwinContext().Authentication.SignOut()
        Session.Contents.RemoveAll()
        Session.Abandon()
    End Sub

    Public Function HideMasterMenu() As Boolean
        RadMenu2.Visible = False
        HeaderPanel.Visible = False
    End Function

End Class



