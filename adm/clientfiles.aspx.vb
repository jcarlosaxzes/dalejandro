Imports Telerik.Web.UI
Public Class clientfiles
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ClientsList") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Uploaded Files"
            Master.PageTitle = "Clients/Uploaded Files"

            lblCompanyId.Text = Session("companyId")

            If Not Request.QueryString("client") Is Nothing Then
                Dim clientGuid As String = Request.QueryString("client")
                Dim clietnId = LocalAPI.GetClientIdFromGUID(clientGuid)
                If clietnId > 0 Then
                    cboClients.DataBind()
                    cboClients.SelectedValue = clietnId
                End If
                btnBack.Visible = True
                Session("BackTo") = "~/adm/clients"
            End If

            If Not Request.QueryString("preproject") Is Nothing Then
                btnBack.Visible = True
                Session("BackTo") = "~/adm/pre-projects"
            End If


        End If
        If cboClients.SelectedItem Is Nothing Then
            UploadPanel.Visible = False
        ElseIf String.IsNullOrEmpty(cboClients.SelectedItem.Value) Or cboClients.SelectedItem.Value = "-1" Then
            UploadPanel.Visible = False
        Else
            UploadPanel.Visible = True
        End If
    End Sub

    Private Sub btnFind_Click(sender As Object, e As EventArgs) Handles btnFind.Click
        RadListView1.DataBind()
    End Sub

    Private Sub SqlDataSourceAzureFiles_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceAzureFiles.Selecting
        If Len(txtJob.Text) = 6 Then
            e.Command.Parameters("@JobId").Value = LocalAPI.GetJobIdFromCode(txtJob.Text, lblCompanyId.Text)
        Else
            e.Command.Parameters("@JobId").Value = 0
        End If

    End Sub

    Private Sub cboClients_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboClients.SelectedIndexChanged
        cboProposals.Items.Clear()
        cboProposals.Items.Insert(0, New RadComboBoxItem("(All Proposals...)", 0))
        cboProposals.DataBind()
        txtJob.Text = ""
    End Sub

    Private Sub cboProposals_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboProposals.SelectedIndexChanged
        If cboProposals.SelectedValue > 0 And cboClients.SelectedValue <= 0 Then
            cboClients.SelectedValue = LocalAPI.GetProposalProperty(cboProposals.SelectedValue, "clientId")
            txtJob.Text = ""
        End If
    End Sub

    Private Sub btnDeleteSelected_Click(sender As Object, e As EventArgs) Handles btnDeleteSelected.Click
        If RadListView1.Visible Then
            If RadListView1.SelectedItems.Count > 0 Then
                RadToolTipDelete.Visible = True
                RadToolTipDelete.Show()
            Else
                Master.ErrorMessage("Select (Mark) Files to Delete")
            End If
        Else
            If RadGrid1.SelectedItems.Count > 0 Then
                RadToolTipDelete.Visible = True
                RadToolTipDelete.Show()
            Else
                Master.ErrorMessage("Select (Mark) Files to Delete")
            End If
        End If
    End Sub
    Protected Sub btnConfirmDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnConfirmDelete.Click

        Try
            'get a reference to the row
            If RadListView1.Visible Then
                If RadListView1.SelectedItems.Count > 0 Then
                    For Each dataItem As RadListViewDataItem In RadListView1.SelectedItems
                        If dataItem.Selected Then
                            Dim idFile = dataItem.GetDataKeyValue("Id").ToString()
                            Dim KeyName As String = LocalAPI.GetAzureFileKeyName(idFile)
                            LocalAPI.DeleteAzureFile(idFile)
                            AzureStorageApi.DeleteFile(KeyName)
                        End If
                    Next
                    RadListView1.ClearSelectedItems()
                    RadListView1.DataBind()
                Else
                    Master.ErrorMessage("Select records!")
                End If
            Else
                If RadGrid1.SelectedItems.Count > 0 Then
                    For Each item As GridDataItem In RadGrid1.SelectedItems
                        If item.Selected Then
                            item.Selected = False
                            Dim idFile = item("Id").Text
                            Dim KeyName As String = LocalAPI.GetAzureFileKeyName(idFile)
                            LocalAPI.DeleteAzureFile(idFile)
                            AzureStorageApi.DeleteFile(KeyName)
                        End If
                    Next
                    RadGrid1.DataBind()
                Else
                    Master.ErrorMessage("Select records!")
                End If
            End If

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnCancelDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelDelete.Click
        RadToolTipDelete.Visible = False
    End Sub

    Private Sub btnBulkEdit_Click(sender As Object, e As EventArgs) Handles btnBulkEdit.Click
        If RadListView1.SelectedItems.Count > 0 Then
            RadToolTipBulkEdit.Visible = True
            RadToolTipBulkEdit.Show()
        Else
            Master.ErrorMessage("Select (Mark) Files to Update")
        End If

    End Sub

    Private Sub btnUpdateStatus_Click(sender As Object, e As EventArgs) Handles btnUpdateStatus.Click
        RadListView1.AllowMultiItemEdit = True

        For Each item As RadListViewDataItem In RadListView1.SelectedItems
            If item.Selected Then
                item.Selected = False
                Dim Id = item.OwnerListView.DataKeyValues(item.DisplayIndex)("Id").ToString()
                Dim lblName As Label = CType(item.FindControl("lblFileName"), Label)
                LocalAPI.UpdateAzureUploads(Id, cboDocTypeBulk.SelectedValue, lblName.Text, chkPublicBulk.Checked)
            End If
        Next
        RadListView1.DataBind()
    End Sub

    Private Sub SqlDataSourceAzureFiles_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAzureFiles.Deleting
        Dim KeyName As String = LocalAPI.GetAzureFileKeyName(e.Command.Parameters("@Id").Value)
        AzureStorageApi.DeleteFile(KeyName)
    End Sub

    Public Function FormatSource(source As String)
        Return source.Replace("1.-", "").Replace("2.-", "").Replace("3.-", "")
    End Function

    Public Sub RadCloudUpload1_FileUploaded(sender As Object, e As CloudFileUploadedEventArgs) Handles RadCloudUpload1.FileUploaded
        Try
            Dim tempName = e.FileInfo.KeyName
            Dim fileExt = IO.Path.GetExtension(tempName)
            Dim newName = "Companies/" & lblCompanyId.Text & $"/{Guid.NewGuid().ToString()}" & fileExt
            AzureStorageApi.CopyFile(tempName, newName, lblCompanyId.Text)
            AzureStorageApi.DeleteFile(tempName)

            ' The uploaded files need to be removed from the storage by the control after a certain time.
            Dim EmployeeId = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)
            e.IsValid = LocalAPI.ClientAzureStorage_Insert(cboClients.SelectedValue, 0, cboDocType.SelectedValue, e.FileInfo.OriginalFileName, newName, chkPublic.Checked, e.FileInfo.ContentLength, e.FileInfo.ContentType, EmployeeId, lblCompanyId.Text)
            If e.IsValid Then
                RadListView1.ClearSelectedItems()
                RadListView1.DataBind()
                RadGrid1.DataBind()
                RadWizard1.ActiveStepIndex = 1
                Master.InfoMessage(e.FileInfo.OriginalFileName & " uploaded")
            Else
                Master.ErrorMessage("The file " & e.FileInfo.OriginalFileName & " has been previously loaded!")
                AzureStorageApi.DeleteFile(newName)
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try

    End Sub

    Protected Sub btnBack_Click(sender As Object, e As EventArgs)
        Response.Redirect(Session("BackTo"))
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case e.CommandName
            Case "Update"
                lblSelectedId.Text = e.CommandArgument

                'Dim item As GridDataItem = TryCast(e.Item, GridDataItem)
                ''Dim chart As RadHtmlChart = TryCast(item("ChartColumn").FindControl("RadHtmlChart1"), RadHtmlChart)
                'Dim Id As String = item.GetDataKeyValue("Id").ToString()
                'Dim TypeId As String = item("Type").Text
                'Dim sPublic As String = item("Public").Text


                RadToolTipBulkEdit.Visible = True
                RadToolTipBulkEdit.Show()
            Case "Delete"
                Response.Redirect("~/adm/employee.aspx?employeeId=" & e.CommandArgument & "&fromcontacts=1")
        End Select
    End Sub




    Private Sub RadListView1_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles RadListView1.ItemCommand

        Select Case e.CommandName
            Case "Update"
                Dim item As RadListViewDataItem = TryCast(e.ListViewItem, RadListViewDataItem)


                Dim editedItem As RadListViewEditableItem = TryCast(e.ListViewItem, RadListViewEditableItem)


                Dim ProductID As String = editedItem.OwnerListView.DataKeyValues(editedItem.DisplayIndex)("cboDocTypeItem").ToString()


                Dim comboBox As RadComboBox = DirectCast(editedItem.FindControl("RadComboBox1"), RadComboBox)

                Dim id = e.CommandArgument
                Dim lblName As Label = CType(editedItem.FindControl("Name"), Label)
                Dim cboDocTypeItem As RadComboBox = CType(editedItem.FindControl("cboDocTypeItem"), RadComboBox)
                Dim chkPublic As RadCheckBox = CType(editedItem.FindControl("chkPublic"), RadCheckBox)
                LocalAPI.UpdateAzureUploads(id, cboDocType.SelectedValue, lblName.Text, chkPublic.Checked)
                item.Edit = False
            Case "Cancel"
                Dim item As RadListViewDataItem = TryCast(e.ListViewItem, RadListViewDataItem)
                item.Edit = False
                item.Selected = False
        End Select
    End Sub

    Protected Sub btnTablePage_Click(sender As Object, e As EventArgs)
        RadListView1.Visible = Not RadListView1.Visible
        RadGrid1.Visible = Not RadListView1.Visible
        btnGridPage.Visible = Not RadListView1.Visible
        btnTablePage.Visible = RadListView1.Visible
    End Sub


    'Protected Sub RadWizard2_ActiveStepChanged(sender As Object, e As EventArgs)
    '    Dim activeStepIndex As Integer = TryCast(sender, RadWizard).ActiveStep.Index
    '    btnDeleteSelected.Visible = (activeStepIndex = 1)
    '    btnBulkEdit.Visible = (activeStepIndex = 1)

    'End Sub


End Class
