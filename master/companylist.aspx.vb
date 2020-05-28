Imports Microsoft.AspNet.Identity.Owin
Imports Telerik.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Owin

Public Class companylist
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As EventArgs) Handles Me.PreInit
        Theme = LocalAPI.DefinirTheme(Request.UserAgent)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            If Request.QueryString("StatusId") <> Nothing Then
                cboStatus.DataBind()
                cboStatus.SelectedValue = Request.QueryString("StatusId")
            End If
        End If
    End Sub

    Private Async Function SendMasterCredentilasAsync(companyId As Integer) As Threading.Tasks.Task(Of Boolean)
        Try
            If Val(companyId) > 0 Then
                Dim sEmail As String = LocalAPI.GetCompanyProperty(companyId, "Email")
                If sEmail.Length > 0 Then
                    LocalAPI.AppUserManager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
                    Dim user = LocalAPI.ExisteUserIdentity(sEmail)
                    If user Then
                        Await LocalAPI.EmployeeEmailResetPassword(sEmail)
                    End If
                    lblMsg.Text = "The credentials were sent by email"
                End If
            End If
        Catch ex As Exception
            lblMsg.Text = "Error. " & ex.Message

        End Try
        Return True
    End Function

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Select Case e.CommandName
            Case "Credentials"
                SendMasterCredentilasAsync(Val(e.CommandArgument))
            Case "GetStartedEmail"
                If LocalAPI.PASconceptGetStartedEmail(e.CommandArgument) Then
                    LocalAPI.ExecuteNonQuery("UPDATE [Company] SET [GetStartedEmailDate]=dbo.CurrentTime() WHERE companyId=" & e.CommandArgument)
                    lblMsg.Text = "The Email to Get Started was sent successfully!"
                    RadGrid1.DataBind()
                End If
            Case "BindAxzesClient"
                lblSelectedCompanyId.Text = e.CommandArgument
                lblCompanyName.Text = LocalAPI.GetCompanyName(lblSelectedCompanyId.Text)
                ReloadComboClients()
                ReloadComboJobs()
                RadToolTipBindAxzesClient.Visible = True
                RadToolTipBindAxzesClient.Show()
        End Select
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        Response.Redirect("~/MASTER/CreateCompany.aspx")
    End Sub

    Protected Sub RadGrid1_FilterCheckListItemsRequested(sender As Object, e As GridFilterCheckListItemsRequestedEventArgs)
        Dim DataField As String = TryCast(e.Column, IGridDataColumn).GetActiveDataField()
        Select Case DataField
            Case "VersionName"
                e.ListBox.DataSource = LocalAPI.GetDataTable("sys_Versiones", DataField)
                e.ListBox.DataKeyField = DataField
                e.ListBox.DataTextField = DataField
                e.ListBox.DataValueField = DataField
                e.ListBox.DataBind()
        End Select
    End Sub

    Private Sub btnBindAxzesClient_Click(sender As Object, e As EventArgs) Handles btnBindAxzesClient.Click
        Try
            ' Binding Client
            Dim clientId As Integer = LocalAPI.BindCompanyToAxzesClient(lblSelectedCompanyId.Text, cboClient.SelectedValue)

            ' Binding Job
            LocalAPI.BindCompanyToAxzesJob(lblSelectedCompanyId.Text, clientId, cboJob.SelectedValue)

            RadGrid1.DataBind()
        Catch ex As Exception
            lblMsg.Text = ex.Message
        End Try
    End Sub

    Private Sub cboClient_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboClient.SelectedIndexChanged
        ReloadComboJobs()
        RadToolTipBindAxzesClient.Visible = True
        RadToolTipBindAxzesClient.Show()
    End Sub

    Private Sub ReloadComboClients()
        cboClient.Items.Clear()
        cboClient.Items.Insert(0, New RadComboBoxItem("(Create NEW Axzes Client...)", 0))
        cboClient.DataBind()
        cboClient.SelectedValue = LocalAPI.GetCompanyProperty(lblSelectedCompanyId.Text, "AxzesClientId")
    End Sub

    Private Sub ReloadComboJobs()
        cboJob.Items.Clear()
        cboJob.Items.Insert(0, New RadComboBoxItem("(Create NEW Axzes Job...)", 0))
        cboJob.DataBind()
        cboJob.SelectedValue = LocalAPI.GetCompanyProperty(lblSelectedCompanyId.Text, "AxzesJobId")
    End Sub
End Class

