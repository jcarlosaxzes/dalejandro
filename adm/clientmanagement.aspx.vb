Imports Telerik.Web.UI
Public Class clientmanagement
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Client Management"
            If (Not Page.IsPostBack) Then

                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ClientManagement") Then Response.RedirectPermanent("~/ADM/Default.aspx")

                Master.PageTitle = "Clients/Client Management"
                Master.Help = "http://blog.pasconcept.com/2012/06/billing-client-accounts-report.html"
                lblCompanyId.Text = Session("companyId")

                SqlDataSourceClientStatus.DataBind()
                cboStatus.DataBind()
                cboStatus.SelectedValue = 1

                SqlDataSource1.DataBind()
            End If

            RadWindowManager1.EnableViewState = False

        Catch ex As Exception

        End Try
    End Sub

    Private Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditClient"
                sUrl = "~/ADM/Client.aspx?clientId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 850, 750)

            Case "EditAvailability"
                lblClientSelectdId.Text = e.CommandArgument
                RadToolTipAvailability.Visible = True
                RadToolTipAvailability.Show()
                cboNewAvailability.Focus()
        End Select

    End Sub

    Protected Sub btnUpdateAvailability_Click(sender As Object, e As EventArgs) Handles btnUpdateAvailability.Click
        LocalAPI.SetClientAvailability(lblClientSelectdId.Text, cboNewAvailability.SelectedValue)
        RadToolTipAvailability.Visible = False
        RadGrid1.DataBind()
    End Sub

    Private Sub ConfigureExport()
        RadGridExportData.AllowPaging = False
        RadGridExportData.ExportSettings.FileName = "PASconcept_clientmanagement" & "--" & Date.Today
        RadGridExportData.ExportSettings.ExportOnlyData = True
        RadGridExportData.ExportSettings.IgnorePaging = True
        RadGridExportData.ExportSettings.OpenInNewWindow = True
        'RadGridExportData.ExportSettings.UseItemStyles = False
        'RadGridExportData.ExportSettings.HideStructureColumns = True
        'RadGridExportData.MasterTableView.ShowFooter = True
    End Sub

    Private Sub MostrarNewCampaign()
        RadToolTipNewCampaign.Visible = True
        RadToolTipNewCampaign.Show()
        txtCampaignName.Focus()
    End Sub

    Protected Sub btnConfirmCreate_Click(sender As Object, e As EventArgs) Handles btnConfirmCreate.Click
        If Len(txtCampaignName.Text) > 0 Then

            If Not LocalAPI.IsCampaign(txtCampaignName.Text, lblCompanyId.Text) Then
                SqlDataSource1.Insert()
            Else
                Master.ErrorMessage("Already exists campaign called: " & txtCampaignName.Text)
            End If
        Else
            Master.ErrorMessage("Define campaign name")
            txtCampaignName.Focus()
        End If
    End Sub

    Private Sub RefreshCampaign(campaignId As Integer)
        cboCampaing.Items.Clear()
        cboCampaing.Items.Insert(0, New RadComboBoxItem("(Select Campaing...)", -1))
        SqlDataSourceCampaing.DataBind()
        cboCampaing.DataBind()
        cboCampaing.SelectedValue = campaignId
        btnExecuteCampaign.Visible = cboCampaing.SelectedValue > 0
        btnDeleteCampaign.Visible = btnExecuteCampaign.Enabled

    End Sub
    Protected Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        MostrarNewCampaign()
    End Sub

    Protected Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        Dim campaignId As Integer = e.Command.Parameters("@OUT_MarketingCampaingId").Value
        If campaignId > 0 Then
            RefreshCampaign(campaignId)
            Master.InfoMessage("Was created the campaign: " & txtCampaignName.Text)
            txtCampaignName.Text = ""
        End If
    End Sub

    Protected Sub cboCampaing_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboCampaing.SelectedIndexChanged
        btnExecuteCampaign.Visible = cboCampaing.SelectedValue > 0
        btnDeleteCampaign.Visible = btnExecuteCampaign.Enabled
    End Sub

    Protected Sub btnDeleteCampaign_Click(sender As Object, e As EventArgs) Handles btnDeleteCampaign.Click
        SqlDataSourceCampaing.Delete()
        RefreshCampaign(-1)
        Master.InfoMessage("Campaign was deleted")
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
        window1.DestroyOnClose = True
        window1.ShowOnTopWhenMaximized = True
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Protected Sub btnExecuteCampaign_Click(sender As Object, e As EventArgs) Handles btnExecuteCampaign.Click
        CreateRadWindows("RunCampaign", "~/ADM/ClientsMarketing.aspx?MarketingId=" & cboCampaing.SelectedValue, 1024, 820)
    End Sub

    Private Sub CSVButton_Click(sender As Object, e As EventArgs) Handles CSVButton.Click
        ConfigureExport()
        RadGridExportData.MasterTableView.ExportToCSV()
    End Sub
End Class
