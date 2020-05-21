Imports Telerik.Web.UI
Public Class azurestorage_client
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            lblCompanyId.Text = Session("companyId")
            lblClientId.Text = Val("" & Request.QueryString("clientId"))
            lblEmployeeId.Text = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)

            Me.Title = "Upload Documents. " & LocalAPI.GetClientNameFromId(lblClientId.Text)
            If Not LocalAPI.IsAzureStorage(lblCompanyId.Text) Then
                RadCloudUpload1.Enabled = False
                btnSaveUpload.Enabled = False
                lblMsg.Text = "You do not have hired the module Upload files"
            End If

            If Not Request.QueryString("preprojectId") Is Nothing Then
                cboPreProject.DataBind()
                cboPreProject.SelectedValue = Request.QueryString("preprojectId")
            End If

        End If
    End Sub

    Protected Sub RadCloudUpload1_FileUploaded(sender As Object, e As Telerik.Web.UI.CloudFileUploadedEventArgs)
        Try
            If LocalAPI.IsAzureStorage(lblCompanyId.Text) Then
                Dim tempName = e.FileInfo.KeyName
                Dim fileExt = IO.Path.GetExtension(tempName)
                Dim newName = "Companies/" & lblCompanyId.Text & $"/{Guid.NewGuid().ToString()}" & fileExt
                AzureStorageApi.CopyFile(tempName, newName)
                AzureStorageApi.DeleteFile(tempName)

                ' The uploaded files need to be removed from the storage by the control after a certain time.
                e.IsValid = LocalAPI.ClientAzureStorage_Insert(lblClientId.Text, cboPreProject.SelectedValue, cboDocType.SelectedValue, e.FileInfo.OriginalFileName, newName, chkPublic.Checked, e.FileInfo.ContentLength, e.FileInfo.ContentType, lblEmployeeId.Text)
                If e.IsValid Then
                    RadGridAzureFiles.DataBind()
                    Master.InfoMessage(e.FileInfo.OriginalFileName & " uploaded")
                Else
                    Master.ErrorMessage("The file " & e.FileInfo.OriginalFileName & " has been previously loaded!")
                End If
            Else
                Master.ErrorMessage("You do not have hired the module Upload files")
            End If
        Catch ex As Exception
            e.IsValid = False
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub SqlDataSourceAzureFiles_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAzureFiles.Deleting
        Dim KeyName As String = LocalAPI.GetClientProsalJobAzureFileKeyName(e.Command.Parameters("@Id").Value, e.Command.Parameters("@Source").Value)
        AzureStorageApi.DeleteFile(KeyName)
    End Sub
End Class
