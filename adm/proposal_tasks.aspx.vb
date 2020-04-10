Imports Telerik.Web.UI
Public Class proposal_tasks
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ProposalTasksList") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Title = ConfigurationManager.AppSettings("Titulo") & ". Proposal Tasks"
            Master.PageTitle = "Proposals/Proposal Tasks"
            Master.Help = "http://blog.pasconcept.com/2012/03/fee-proposal-scope-of-work-tasks.html"
            lblCompanyId.Text = Session("companyId")

        End If

    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click
        Try

            'get a reference to the row
            Dim nRecs As Integer
            If RadGrid1.SelectedItems.Count > 0 Then
                For Each dataItem As GridDataItem In RadGrid1.SelectedItems
                    If dataItem.Selected Then
                        lblSelected.Text = dataItem("Id").Text
                        SqlDataSource1.Delete()
                        nRecs = nRecs + 1
                    End If
                Next
                Master.InfoMessage(nRecs & " task deleted.")
            End If

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Sub
End Class
