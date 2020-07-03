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
                    RadGridAzureFiles.DataBind()
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
    Private Sub SqlDataSourceAzureFiles_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAzureFiles.Updating
        Dim e1 As String = e.Command.Parameters(3).Value
    End Sub
    Protected Sub btnNewFileLink_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewFileLink.Click
        Try

            RadGridLinks.MasterTableView.InsertItem()
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub SqlDataSourceAzureFiles_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSourceAzureFiles.Selecting
        Dim e1 As String = e.Command.Parameters(2).Value
    End Sub

    Private Sub SqlDataSourceAzureFiles_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAzureFiles.Deleting
        Dim KeyName As String = LocalAPI.GetAzureFileKeyName(e.Command.Parameters("@Id").Value)
        AzureStorageApi.DeleteFile(KeyName)
    End Sub
End Class
