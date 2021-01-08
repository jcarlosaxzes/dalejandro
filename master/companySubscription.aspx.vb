Imports Microsoft.AspNet.Identity.Owin
Imports Telerik.Web.UI

Public Class companySubscription
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



    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim record = LocalAPI.GetRecordFromQuery($"select company.[companyId],company.[Name],company.[Contact],company.[Email], company.billingExpirationDate ,ISNULL( AlertMasterSubscriptionExpired, 0) as AlertMasterSubscriptionExpired, isnull(BlockSubcriptionExpired, 0 ) as BlockSubcriptionExpired , Billing_plans.Name AS BillingPlan from company LEFT OUTER JOIN  Billing_plans ON Company.Billing_plan = Billing_plans.Id  where companyId = {e.CommandArgument}")

        Select Case e.CommandName
            Case "SendEmail"
                lblSelectedCompanyId.Text = e.CommandArgument
                lblCompanyName.Text = record("Name")
                txtTo.Text = record("Email")

                Dim DictValues As Dictionary(Of String, String) = New Dictionary(Of String, String)
                DictValues.Add("[CompanyName]", record("Name"))
                DictValues.Add("[ContactName]", record("Contact"))
                DictValues.Add("[Email]", record("Email"))
                Dim expDate As DateTime = record("billingExpirationDate")
                DictValues.Add("[BillingExpirationDate]", expDate.ToString("MM/dd/yyyy"))
                DictValues.Add("[BillingPlan]", record("BillingPlan"))
                DictValues.Add("[PASSign]", LocalAPI.GetPASSign())

                Dim sSubject As String = ""
                Dim sBody As String = ""

                sSubject = LocalAPI.GetMessageTemplateSubject("Subscription_Expired", lblSelectedCompanyId.Text, DictValues)
                sBody = LocalAPI.GetMessageTemplateBody("Subscription_Expired", lblSelectedCompanyId.Text, DictValues)
                txtEmail.Content = sBody
                txtSubject.Text = sSubject

                RadToolTipBindAxzesClient.Visible = True
                RadToolTipBindAxzesClient.Show()
            Case "BlockCompany"
                Dim BlockSubcriptionExpired As Boolean = record("BlockSubcriptionExpired")
                LocalAPI.ExecuteNonQuery($"update company set BlockSubcriptionExpired = {IIf(BlockSubcriptionExpired, 0, 1)} where companyId = {e.CommandArgument}")
                RadGrid1.DataBind()
        End Select
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

    Private Sub btnSendEmail_Click(sender As Object, e As EventArgs) Handles btnSendEmail.Click
        SendGrid.Email.SendMail(txtTo.Text, "", "", txtSubject.Text, txtEmail.Content, lblSelectedCompanyId.Text, 0, 0)
        LocalAPI.ExecuteNonQuery($"update company set SendRenewSubscription = isnull(SendRenewSubscription,0)+1 where companyId = {lblSelectedCompanyId.Text}")
        RadGrid1.DataBind()
    End Sub

    Private Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        RadGrid1.DataBind()
    End Sub
End Class

