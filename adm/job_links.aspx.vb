Imports Telerik.Web.UI

Public Class job_links
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblJobId.Text = Request.QueryString("JobId")
                lblClientId.Text = LocalAPI.GetJobProperty(lblJobId.Text, "Client")

                lblproposalId.Text = LocalAPI.GetJobProperty(lblJobId.Text, "proposalId")
                Master.ActiveTab(7)
            End If

            RadWindowManager2.EnableViewState = False
            RadWindowDropBox.NavigateUrl = "~/ADMCLI/DropboxChooser.aspx?Origen=1&JobId=" & lblJobId.Text

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Protected Sub RadCloudUpload1_FileUploaded(sender As Object, e As Telerik.Web.UI.CloudFileUploadedEventArgs)
        Try
            If LocalAPI.IsAzureStorage(lblCompanyId.Text) Then

                Dim tempName = e.FileInfo.KeyName
                Dim fileExt = IO.Path.GetExtension(tempName)
                Dim newName = "Companies/" & lblCompanyId.Text & $"/{Guid.NewGuid().ToString()}" & fileExt
                AzureStorageApi.CopyFile(tempName, newName, lblCompanyId.Text)
                AzureStorageApi.DeleteFile(tempName)

                ' The uploaded files need to be removed from the storage by the control after a certain time.
                e.IsValid = LocalAPI.JobAzureStorage_Insert(lblJobId.Text, cboDocType.SelectedValue, e.FileInfo.OriginalFileName, newName, chkPublic.Checked, e.FileInfo.ContentLength, e.FileInfo.ContentType, lblCompanyId.Text)
                If e.IsValid Then
                    RadListView1.ClearSelectedItems()
                    RadListView1.DataBind()
                    Master.InfoMessage(e.FileInfo.OriginalFileName & " uploaded")
                Else
                    Master.ErrorMessage("The file " & e.FileInfo.OriginalFileName & " has been previously loaded!")
                End If

            End If
        Catch ex As Exception
            e.IsValid = False
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Public Function FormatSource(source As String)
        Return source.Replace("1.-", "").Replace("2.-", "").Replace("3.-", "")
    End Function


    Private Sub btnDeleteSelected_Click(sender As Object, e As EventArgs) Handles btnDeleteSelected.Click
        If RadListView1.SelectedItems.Count > 0 Then
            RadToolTipDeleteFiles.Visible = True
            RadToolTipDeleteFiles.Show()
        Else
            Master.ErrorMessage("Select (Mark) Files to Update")
        End If
    End Sub
    Protected Sub btnConfirmDeleteFiles_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnConfirmDeleteFiles.Click
        Try
            'get a reference to the row
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
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnCancelDeleteFiles_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelDeleteFiles.Click
        RadToolTipDeleteFiles.Visible = False
    End Sub

    Private Sub btnBulkEdit_Click(sender As Object, e As EventArgs) Handles btnBulkEdit.Click
        If RadListView1.SelectedItems.Count > 0 Then
            RadToolTipBulkEdit.Visible = True
            RadToolTipBulkEdit.Show()
        Else
            Master.ErrorMessage("Select (Mark) Files to Update")
        End If

    End Sub

    Private Sub btnUpdateStatus_Click(sender As Object, e As EventArgs) Handles btnUpdateStatusFiles.Click
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

    Private Sub SqlDataSourceAzureFiles_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAzureFiles.Updating
        Dim e1 As String = e.Command.Parameters(3).Value
    End Sub


    Private Sub SqlDataSourceAzureFiles_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceAzureFiles.Selecting
        Dim e1 As String = e.Command.Parameters(2).Value
    End Sub

    Private Sub SqlDataSourceAzureFiles_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAzureFiles.Deleting
        Dim KeyName As String = LocalAPI.GetAzureFileKeyName(e.Command.Parameters("@Id").Value)
        AzureStorageApi.DeleteFile(KeyName)
    End Sub
End Class
