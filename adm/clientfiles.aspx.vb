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

    Private Sub btnBulkEdit_Click(sender As Object, e As EventArgs) Handles btnBulkEdit.Click
        If RadListView1.SelectedItems.Count > 0 Then
            RadToolTipBulkEdit.Visible = True
            RadToolTipBulkEdit.Show()
        Else
            Master.ErrorMessage("Select (Mark) Files to Update")
        End If


        'Try
        '    'get a reference to the row
        '    If RadListView1.SelectedItems.Count > 0 Then
        '        For Each dataItem As RadListViewDataItem In RadListView1.SelectedItems
        '            If dataItem.Selected Then
        '                Dim idFile = dataItem.GetDataKeyValue("Id").ToString()
        '                Dim KeyName As String = LocalAPI.GetAzureFileKeyName(idFile)
        '                LocalAPI.DeleteAzureFile(idFile)
        '                AzureStorageApi.DeleteFile(KeyName)
        '            End If
        '        Next
        '        RadListView1.ClearSelectedItems()
        '        RadListView1.DataBind()
        '    Else
        '        Master.ErrorMessage("Select records!")

        '    End If
        'Catch ex As Exception
        '    Master.ErrorMessage("Error. " & ex.Message)
        'End Try
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

    Public Function CreateIcon(sContentType As String, sUrl As String, sName As String)
        If sContentType = "application/pdf" Then
            Return $"<a class=""far fa-file-pdf"" style=""font-size: 96px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
        End If
        If sContentType = "application/zip" Or sContentType = "application/x-tar" Or sContentType = "application/x-rar" Then
            Return $"<a class=""far fa-file-archive"" style=""font-size: 96px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
        End If
        If sContentType = "application/vnd.ms-excel" Or sContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" Then
            Return $"<a class=""far fa-file-excel"" style=""font-size: 96px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
        End If
        If sContentType = "application/msword" Or sContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document" Then
            Return $"<a class=""far fa-file-pdf"" style=""font-size: 96px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
        End If
        If sContentType = "image/tiff" Or sContentType = "image/bmp" Or sContentType = "image/jpeg" Or sContentType = "image/gif" Or sContentType = "Image/jpg" Or sContentType = "image/png" Then
            Return $"<image src=""{sUrl}"" width=""200px""/>"
        End If

        Return $"<a class=""far fa-file"" style=""font-size: 96px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"

    End Function

    Public Function CreateSmallIcon(sContentType As String, sUrl As String, sName As String)
        If sContentType = "application/pdf" Then
            Return $"<a class=""far fa-file-pdf"" style=""font-size: 60px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
        End If
        If sContentType = "application/zip" Or sContentType = "application/x-tar" Or sContentType = "application/x-rar" Then
            Return $"<a class=""far fa-file-archive"" style=""font-size: 60px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
        End If
        If sContentType = "application/vnd.ms-excel" Or sContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" Then
            Return $"<a class=""far fa-file-excel"" style=""font-size: 60px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
        End If
        If sContentType = "application/msword" Or sContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document" Then
            Return $"<a class=""far fa-file-pdf"" style=""font-size: 60px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
        End If
        If sContentType = "image/tiff" Or sContentType = "image/bmp" Or sContentType = "image/jpeg" Or sContentType = "image/gif" Or sContentType = "Image/jpg" Or sContentType = "image/png" Then
            Return $"<image src=""{sUrl}"" width=""100px""/>"
        End If

        Return $"<a class=""far fa-file"" style=""font-size: 60px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"

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
                Master.InfoMessage(e.FileInfo.OriginalFileName & " uploaded")
            Else
                Master.ErrorMessage("The file " & e.FileInfo.OriginalFileName & " has been previously loaded!")
                AzureStorageApi.DeleteFile(newName)
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try

    End Sub


End Class
