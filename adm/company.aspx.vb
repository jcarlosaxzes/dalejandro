Imports Telerik.Web.UI
Public Class company
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If Not IsPostBack() Then
                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_CompanyProfile") Then Response.RedirectPermanent("~/adm/schedule.aspx")
                lblEmployeeEmail.Text = Master.UserEmail

                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Company Profile"
                Master.PageTitle = "Company/Profile"
                Master.Help = "http://blog.pasconcept.com/2012/08/others-company-information.html"
                lblCompanyId.Text = Session("companyId")

                If Not Request.QueryString("Tab") Is Nothing Then
                    Select Case Request.QueryString("Tab")
                        Case "1", "SMTP"
                            CType(FormView1.FindControl("RadWizard1"), RadWizard).ActiveStepIndex = 1
                        Case "2", "Notifications"
                            CType(FormView1.FindControl("RadWizard1"), RadWizard).ActiveStepIndex = 2
                        Case "3", "Paypal"
                            CType(FormView1.FindControl("RadWizard1"), RadWizard).ActiveStepIndex = 3
                        Case "4"
                            CType(FormView1.FindControl("RadWizard1"), RadWizard).ActiveStepIndex = 4
                        Case "5", "Logo"
                            CType(FormView1.FindControl("RadWizard1"), RadWizard).ActiveStepIndex = 5
                    End Select
                End If

            End If
            RadWindowManager1.EnableViewState = False
        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub


    Protected Sub SendTestEmail()
        Try
            If LocalAPI.ValidEmail(lblEmployeeEmail.Text) Then
                If LocalAPI.AdminTestEmail(lblEmployeeEmail.Text, lblCompanyId.Text) Then
                    Master.InfoMessage("The TEST Email was sent")
                End If
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub SendTestSMS()
        Try
            If LocalAPI.IsCompanyTwilio(lblCompanyId.Text) Then
                Dim sCellPhone As String = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Movile")
                If SMS.IsValidPhone(sCellPhone) Then
                    If SMS.SendSMS(Master.UserId, sCellPhone, "Test message sent from PASconcept", lblCompanyId.Text) Then
                        Master.InfoMessage("The TEST SMS was sent")
                    End If
                Else
                    Master.ErrorMessage("SMS Error. Telephone format must be 10-digit number, eg.: 3058889999")
                End If
            Else
                Master.ErrorMessage("To hire the notification service by SMS to Customers and Employees, contact AXZES.")
            End If
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
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
        'window1.OnClientClose = "OnClientClose"
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Protected Sub btnQB_Click(sender As Object, e As EventArgs)
        Try
            Dim url As String = ConfigurationManager.AppSettings("qbOauthCallback") & "?connect=true"
            CreateRadWindows("QBauthorization", url, 850, 800)
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub


    Private Sub FormView1_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles FormView1.ItemCommand
        Select Case e.CommandName
            Case "Edit"
                btnActiveTab.Text = CType(FormView1.FindControl("RadWizard1"), RadWizard).ActiveStepIndex
                'CType(FormView1.FindControl("RadWizard2"), RadWizard).ActiveStepIndex = btnActiveTab.Text
            Case "Update"
                btnActiveTab.Text = CType(FormView1.FindControl("RadWizard2"), RadWizard).ActiveStepIndex
                'CType(FormView1.FindControl("RadWizard1"), RadWizard).ActiveStepIndex = btnActiveTab.Text

            Case "SendTestEmail"
                SendTestEmail()

            Case "SendTestSMS"
                SendTestSMS()

        End Select

    End Sub

    Private Sub FormView1_ItemCreated(sender As Object, e As EventArgs) Handles FormView1.ItemCreated
        Select Case FormView1.CurrentMode
            Case FormViewMode.ReadOnly
                CType(FormView1.FindControl("RadWizard1"), RadWizard).ActiveStepIndex = btnActiveTab.Text
            Case FormViewMode.Edit
                CType(FormView1.FindControl("RadWizard2"), RadWizard).ActiveStepIndex = btnActiveTab.Text
        End Select
    End Sub

    Private Sub FormView1_ModeChanging(sender As Object, e As FormViewModeEventArgs) Handles FormView1.ModeChanging
        Dim e1 = 1
    End Sub

    Private Sub FormView1_ModeChanged(sender As Object, e As EventArgs) Handles FormView1.ModeChanged
        Dim e1 = 1
    End Sub
End Class
