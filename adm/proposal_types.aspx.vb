Imports Telerik.Web.UI
Public Class proposal_types
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ProposalTemplates") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Proposal Templates"
            Master.PageTitle = "Proposals/Proposal Templates"
            Master.Help = "http://blog.pasconcept.com/2012/04/fee-proposal-templates.html"

            lblCompanyId.Text = Session("companyId")
        End If
        RadWindowManager1.EnableViewState = False

    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditTemplate"
                sUrl = "~/ADM/proposaltemplate.aspx?templateId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 650, False, True)


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

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        CreateRadWindows("New", "~/ADM/proposaltemplate.aspx", 960, 650, False, True)
    End Sub

End Class
