Imports Telerik.Web.UI
Public Class pre_projects
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ProposalsList") Then Response.RedirectPermanent("~/adm/schedule.aspx")

            Title = ConfigurationManager.AppSettings("Titulo") & ". Pre_Projects"
            Master.PageTitle = "Clients/Pre_Projects"
            lblCompanyId.Text = Session("companyId")

            lblEmployeeId.Text = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)

        End If
        RadWindowManager1.EnableViewState = False
    End Sub
    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditPre_Project"
                sUrl = "~/ADM/Pre-Project.aspx?preprojectsId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 800, 610, False, True)

            Case "AddActivity"
                lblSelected.Text = e.CommandArgument
                lblSelectedClientId.Text = LocalAPI.GetPreProjectProperty(lblSelected.Text, "clientId")
                NewClientActivityDlg(True)

            Case "EditProposal"
                Response.Redirect(LocalAPI.GetSharedLink_URL(11001, e.CommandArgument) & "&backpage=job_proposals")

            Case "NewProposal"
                Response.Redirect("~/ADM/ProposalNewWizard.aspx?preprojectId=" & e.CommandArgument)

            Case "AzureUpload"
                Dim clientId As Integer = LocalAPI.GetPreProjectProperty(e.CommandArgument, "clientId")
                sUrl = "~/ADM/AzureStorage_client.aspx?clientId=" & clientId & "&preprojectId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 750, False, False)

            Case "View/Edit Client Profile"
                sUrl = "~/ADM/Client.aspx?clientId=" & e.CommandArgument
                CreateRadWindows("Client", sUrl, 970, 750, True, False)

        End Select
    End Sub

    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean, bRefreshOnClose As Boolean)
        Try

            RadWindowManager1.Windows.Clear()
            Dim window1 As RadWindow = New RadWindow()
            window1.NavigateUrl = sUrl
            window1.VisibleOnPageLoad = True
            window1.VisibleStatusbar = False
            window1.ID = WindowsID
            If Maximize Then window1.InitialBehaviors = WindowBehaviors.Maximize
            window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
            window1.Width = Width
            window1.Height = Height
            window1.Modal = True
            window1.DestroyOnClose = True
            If bRefreshOnClose Then window1.OnClientClose = "OnClientClose"
            window1.ShowOnTopWhenMaximized = Maximize
            RadWindowManager1.Windows.Add(window1)
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        Dim sUrl As String = "~/ADM/Pre-Project.aspx"
        CreateRadWindows("Windows1", sUrl, 800, 610, False, True)
    End Sub

#Region "Activity"
    Private Sub NewClientActivityDlg(bInitDlg As Boolean)
        If bInitDlg Then
            cboActivityEmployees.SelectedValue = lblEmployeeId.Text
            RadDateTimePickerActivityDueDate.DbSelectedDate = DateAdd(DateInterval.Hour, 24, Now)
            cboActivityType.SelectedValue = -1
            lblClientName.Text = LocalAPI.GetClientProperty(lblSelectedClientId.Text, "Client")
            txtActivitySubject.Text = ""
        End If

        RadToolTipNewActivity.Visible = True
        RadToolTipNewActivity.Show()
    End Sub

    Private Sub btnAddActivity_Click(sender As Object, e As EventArgs) Handles btnAddActivity.Click
        Try
            ' Insert new Activity
            Dim EndDate As DateTime = DateAdd(DateInterval.Minute, CInt(cboActivityDuration.SelectedValue), RadDateTimePickerActivityDueDate.DbSelectedDate)
            Dim ActivityId As Integer = LocalAPI.Activity_INSERT(txtActivitySubject.Text, RadDateTimePickerActivityDueDate.DbSelectedDate, EndDate, cboActivityType.SelectedValue, cboActivityEmployees.SelectedValue, lblSelectedClientId.Text, 0, 0, lblSelected.Text, lblCompanyId.Text, 1, txtActivityDescription.Text)
            If chkMoreOptions.Checked Then
                Response.Redirect($"~/adm/appointment?Id={ActivityId}&EntityType=Pre-Proposal&EntityId={lblSelected.Text}&backpage=pre-projects")
            Else
                Master.InfoMessage("The Activity was inserted successfully!")
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

#End Region
End Class
