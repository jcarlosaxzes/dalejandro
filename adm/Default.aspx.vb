Imports Telerik.Web.UI

Public Class _Default1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If Not IsPostBack Then

                Master.PageTitle = "Control Panel"
                Master.Help = "http://blog.pasconcept.com/2015/04/home.html"
                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Control Panel"
                lblCompanyId.Text = Session("companyId")

                lblUserEmail.Text = Master.UserEmail

                lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblUserEmail.Text, lblCompanyId.Text)

                If LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Analytics") Then
                    ' User con Permiso al Administrator PORTAL
                    ' Load RadDocks status
                    RadDockProposals.Collapsed = LocalAPI.GetEmployeeDockCollapsed(lblEmployeeId.Text, "RDP_Collapsed")
                    RadDockJobs.Collapsed = LocalAPI.GetEmployeeDockCollapsed(lblEmployeeId.Text, "RDJ_Collapsed")
                    RadDockClients.Collapsed = LocalAPI.GetEmployeeDockCollapsed(lblEmployeeId.Text, "RDC_Collapsed")
                    RadDockSubconsultants.Collapsed = LocalAPI.GetEmployeeDockCollapsed(lblEmployeeId.Text, "RDS_Collapsed")
                Else
                    ' User con Permiso al Employee PORTAL
                    Response.Redirect("~/adm/activejobsdashboad")
                    'RadDockLayout1.Visible = False
                    'panelEmployeePortal.Visible = True
                End If

                RadGridProposalJobs.DataBind()
                RadGridEmployeeStatistics.DataBind()
                RadGridClients.DataBind()
                RadGridSubConsultants.DataBind()

                RadBarcode1.Text = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/smarth/salesstatus.aspx?GuiId=" & LocalAPI.GetCompanyGUID(lblCompanyId.Text)
            End If

            RadWindowManagerJob.EnableViewState = False

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub RadGridProposalJobs_PreRender(sender As Object, e As EventArgs) Handles RadGridProposalJobs.PreRender
        RadGridHeader(RadGridProposalJobs)
    End Sub
    Private Sub RadGridJobs_PreRender(sender As Object, e As EventArgs) Handles RadGridJobs.PreRender
        RadGridHeader(RadGridJobs)
    End Sub
    Private Sub RadGridClients_PreRender(sender As Object, e As EventArgs) Handles RadGridClients.PreRender
        RadGridHeader(RadGridClients)
    End Sub
    Private Sub RadGridSubConsultants_PreRender(sender As Object, e As EventArgs) Handles RadGridSubConsultants.PreRender
        RadGridHeader(RadGridSubConsultants)
    End Sub


    Private Sub RadGridHeader(RadGrid1 As RadGrid)
        Dim Y0 As Integer = Today.Year
        Dim StartYear As Integer = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "StartYear")
        RadGrid1.MasterTableView.GetColumn("year").HeaderText = Y0
        For i = 1 To 4
            Y0 = Y0 - 1
            If Y0 >= StartYear Then
                RadGrid1.MasterTableView.GetColumn("year-" & i).HeaderText = Y0
            Else
                RadGrid1.MasterTableView.GetColumn("year-" & i).Visible = False
            End If
        Next
        RadGrid1.MasterTableView.DataBind()

    End Sub

    Private Sub RadDockProposals_Command(sender As Object, e As DockCommandEventArgs) Handles RadDockProposals.Command
        Select Case e.Command.Name
            Case "ExpandCollapse"
                LocalAPI.SetEmployeeDockCollapsed(lblEmployeeId.Text, "RDP_Collapsed", RadDockProposals.Collapsed)
            Case "Close"
                LocalAPI.SetEmployeeDockCollapsed(lblEmployeeId.Text, "RDP_Collapsed", True)
        End Select
    End Sub
    Private Sub RadDockJobs_Command(sender As Object, e As DockCommandEventArgs) Handles RadDockJobs.Command
        Select Case e.Command.Name
            Case "ExpandCollapse"
                LocalAPI.SetEmployeeDockCollapsed(lblEmployeeId.Text, "RDJ_Collapsed", RadDockJobs.Collapsed)
            Case "Close"
                LocalAPI.SetEmployeeDockCollapsed(lblEmployeeId.Text, "RDJ_Collapsed", True)
        End Select
    End Sub
    Private Sub RadDockClients_Command(sender As Object, e As DockCommandEventArgs) Handles RadDockClients.Command
        Select Case e.Command.Name
            Case "ExpandCollapse"
                LocalAPI.SetEmployeeDockCollapsed(lblEmployeeId.Text, "RDC_Collapsed", RadDockClients.Collapsed)
            Case "Close"
                LocalAPI.SetEmployeeDockCollapsed(lblEmployeeId.Text, "RDC_Collapsed", True)
        End Select
    End Sub
    Private Sub RadDockSubconsultants_Command(sender As Object, e As DockCommandEventArgs) Handles RadDockSubconsultants.Command
        Select Case e.Command.Name
            Case "ExpandCollapse"
                LocalAPI.SetEmployeeDockCollapsed(lblEmployeeId.Text, "RDS_Collapsed", RadDockSubconsultants.Collapsed)
            Case "Close"
                LocalAPI.SetEmployeeDockCollapsed(lblEmployeeId.Text, "RDS_Collapsed", True)
        End Select
    End Sub

    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean)
        Try

            RadWindowManagerJob.Windows.Clear()
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
            window1.ShowOnTopWhenMaximized = Maximize
            RadWindowManagerJob.Windows.Add(window1)
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub btnEmployeePortal_Click(sender As Object, e As EventArgs) Handles btnEmployeePortal.Click
        Response.Redirect("~/EMP/Default")
    End Sub

    Private Sub SqlDataSourceClients_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceClients.Selecting
        e.Command.CommandTimeout = 0
    End Sub

    Private Sub SqlDataSourceJobs_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceJobs.Selecting
        e.Command.CommandTimeout = 0
    End Sub

    Private Sub SqlDataSourceRates_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceRates.Selecting
        e.Command.CommandTimeout = 0
    End Sub

    Private Sub SqlDataSourceProposalEmployeeStatistics_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceProposalEmployeeStatistics.Selecting
        e.Command.CommandTimeout = 0
    End Sub

    Private Sub SqlDataSourceProposalJobs_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceProposalJobs.Selecting
        e.Command.CommandTimeout = 0
    End Sub

    Private Sub SqlDataSourceSubConsultants_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceSubConsultants.Selecting
        e.Command.CommandTimeout = 0
    End Sub
End Class
