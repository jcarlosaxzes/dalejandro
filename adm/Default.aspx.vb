Imports Telerik.Web.UI

Public Class _Default1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            Master.PageTitle = "Control Panel"
            Master.Help = "http://blog.pasconcept.com/2015/04/home.html"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Control Panel"
            lblCompanyId.Text = Session("companyId")
            panelCompany16.DataBind()
            tableCompany16.DataBind()

            lblEmployeeId.Text = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)
            lblUserEmail.Text = Master.UserEmail

            If LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Analytics") Then
                ' User con Permiso al Administrator PORTAL
                ' Load RadDocks status
                RadDockProposals.Collapsed = LocalAPI.GetEmployeeDockCollapsed(lblEmployeeId.Text, "RDP_Collapsed")
                RadDockJobs.Collapsed = LocalAPI.GetEmployeeDockCollapsed(lblEmployeeId.Text, "RDJ_Collapsed")
                RadDockClients.Collapsed = LocalAPI.GetEmployeeDockCollapsed(lblEmployeeId.Text, "RDC_Collapsed")
                RadDockSubconsultants.Collapsed = LocalAPI.GetEmployeeDockCollapsed(lblEmployeeId.Text, "RDS_Collapsed")
            Else
                ' User con Permiso al Employee PORTAL
                Response.Redirect("~/ADM/activejobsdashboad.aspx")
                'RadDockLayout1.Visible = False
                'panelEmployeePortal.Visible = True
            End If


        End If
        RadWindowManagerJob.EnableViewState = False
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

    Private Sub RadListView1_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles RadListView1.ItemCommand
        Dim sUrl As String
        Select Case e.CommandName
            Case "EditJob"
                sUrl = "~/ADM/Job_job.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True)

            Case "Accounting"
                sUrl = "~/ADM/Job_accounting.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True)

            Case "Tickets"
                If LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Type") = 16 Then
                    ' Programmers/Computer/IT
                    Response.Redirect("~/ADM/JobTickets.aspx?JobId=" & e.CommandArgument)
                End If

            Case "Images"
                sUrl = "~/ADM/Job_images_files.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True)

            Case "JobTimes"
                sUrl = "~/ADM/Job_times.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True)

            Case "Notes"
                sUrl = "~/ADM/Job_notes.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True)

            Case "NewTime"
                Response.Redirect("~/adm/employeenewtime.aspx?JobId=" & e.CommandArgument & "&back=2")

            Case "JobTags"
                sUrl = "~/ADM/Job_tags.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True)

            Case "GetSharedLink"
                sUrl = "~/adm/sharelink.aspx?ObjType=2&ObjId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 520, 400, False)

            Case "EditClient"
                sUrl = "~/ADM/Client.aspx?clientId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 850, 750, False)

            Case "Tags"
                sUrl = "~/ADM/Job_tags.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True)

            Case "AzureUpload"
                sUrl = "~/ADM/Job_links.aspx?JobId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 820, True)


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
        Response.Redirect("~/EMP/Default.aspx")
    End Sub
End Class
