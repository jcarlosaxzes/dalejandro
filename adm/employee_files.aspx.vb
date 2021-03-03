Imports Telerik.Web.UI
Public Class employee_files
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_ClientsList") Then Response.RedirectPermanent("~/adm/schedule.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Uploaded Files"
            Master.PageTitle = "Employee/Uploaded Files"

            lblCompanyId.Text = Session("companyId")

            If Not Request.QueryString("employee") Is Nothing Then
                Dim employeeGuid As String = Request.QueryString("employee")
                Dim employeeId = LocalAPI.GetEmployeeIdFromGUID(employeeGuid)
                If employeeId > 0 Then
                    cboEmployee.DataBind()
                    cboEmployee.SelectedValue = employeeId
                End If
                btnBack.Visible = True
                Session("BackTo") = "~/adm/employees"
                RadWizardFiles.ActiveStepIndex = 1
            End If


            RadListViewFiles.Visible = False
            RadGridFiles.Visible = Not RadListViewFiles.Visible
            btnGridPage.Visible = Not RadListViewFiles.Visible
            btnTablePage.Visible = RadListViewFiles.Visible

            RadCloudUpload1.MaxFileSize = LocalAPI.GetCompanyMaxFileSizeForUpload(lblCompanyId.Text)
            lblMaxSize.Text = $"[Maximum upload size per file: {LocalAPI.FormatByteSize(RadCloudUpload1.MaxFileSize)}]"

        End If
        If cboEmployee.SelectedItem Is Nothing Then
            UploadPanel.Visible = False
        ElseIf String.IsNullOrEmpty(cboEmployee.SelectedItem.Value) Or cboEmployee.SelectedItem.Value = "-1" Then
            UploadPanel.Visible = False
        Else
            UploadPanel.Visible = True
        End If
    End Sub


    Protected Sub btnBack_Click(sender As Object, e As EventArgs)
        Response.Redirect(Session("BackTo"))
    End Sub




    Private Sub SqlDataSourceAzureFiles_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAzureFiles.Deleting
        Dim KeyName As String = LocalAPI.GetAzureFileKeyName(e.Command.Parameters("@Id").Value)
        AzureStorageApi.DeleteFile(KeyName)
    End Sub

    Public Function FormatSource(source As String)
        Return source.Replace("1.-", "").Replace("2.-", "").Replace("3.-", "")
    End Function




#Region "Bulk Delete"

    Private Sub btnBulkDelete_Click(sender As Object, e As EventArgs) Handles btnBulkDelete.Click
        lblSelectedId.Text = ""
        If RadListViewFiles.Visible Then
            If RadListViewFiles.SelectedItems.Count > 0 Then
                RadToolTipBulkDelete.Visible = True
                RadToolTipBulkDelete.Show()
            Else
                Master.ErrorMessage("Select (Mark) Files to Delete")
            End If
        Else
            If RadGridFiles.SelectedItems.Count > 0 Then
                RadToolTipBulkDelete.Visible = True
                RadToolTipBulkDelete.Show()
            Else
                Master.ErrorMessage("Select (Mark) Files to Delete")
            End If
        End If
    End Sub
    Protected Sub btnConfirmDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnConfirmDelete.Click

        Try
            'get a reference to the row
            If String.IsNullOrEmpty(lblSelectedId.Text) Then
                If RadListViewFiles.Visible Then
                    If RadListViewFiles.SelectedItems.Count > 0 Then
                        For Each dataItem As RadListViewDataItem In RadListViewFiles.SelectedItems
                            If dataItem.Selected Then
                                Dim idFile = dataItem.GetDataKeyValue("Id").ToString()
                                Dim KeyName As String = LocalAPI.GetAzureFileKeyName(idFile)
                                LocalAPI.DeleteAzureFile(idFile)
                                AzureStorageApi.DeleteFile(KeyName)
                            End If
                        Next
                        RadListViewFiles.ClearSelectedItems()
                    Else
                        Master.ErrorMessage("Select records!")
                    End If
                Else
                    If RadGridFiles.SelectedItems.Count > 0 Then
                        For Each item As GridDataItem In RadGridFiles.SelectedItems
                            If item.Selected Then
                                item.Selected = False
                                Dim idFile = item("Id").Text
                                Dim KeyName As String = LocalAPI.GetAzureFileKeyName(idFile)
                                LocalAPI.DeleteAzureFile(idFile)
                                AzureStorageApi.DeleteFile(KeyName)
                            End If
                        Next
                    Else
                        Master.ErrorMessage("Select records!")
                    End If
                End If
            Else
                Dim KeyName As String = LocalAPI.GetAzureFileKeyName(lblSelectedId.Text)
                LocalAPI.DeleteAzureFile(lblSelectedId.Text)
                AzureStorageApi.DeleteFile(KeyName)
                lblSelectedId.Text = ""
            End If

            RadListViewFiles.DataBind()
            RadGridFiles.DataBind()

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnCancelDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelDelete.Click
        RadToolTipBulkDelete.Visible = False
    End Sub

#End Region

#Region "Bulk Update"

    Private Sub btnBulkEdit_Click(sender As Object, e As EventArgs) Handles btnBulkEdit.Click
        lblSelectedId.Text = ""
        If RadListViewFiles.Visible Then
            If RadListViewFiles.SelectedItems.Count > 0 Then
                RadToolTipBulkEdit.Visible = True
                RadToolTipBulkEdit.Show()
            Else
                Master.ErrorMessage("Select (Mark) Files to Update")
            End If
        Else
            If RadGridFiles.SelectedItems.Count > 0 Then
                RadToolTipBulkEdit.Visible = True
                RadToolTipBulkEdit.Show()
            Else
                Master.ErrorMessage("Select (Mark) Files to Update")
            End If
        End If



    End Sub

    Private Sub btnUpdateStatus_Click(sender As Object, e As EventArgs) Handles btnUpdateStatus.Click

        If String.IsNullOrEmpty(lblSelectedId.Text) Then
            If RadListViewFiles.Visible Then
                RadListViewFiles.AllowMultiItemEdit = True
                For Each item As RadListViewDataItem In RadListViewFiles.SelectedItems
                    If item.Selected Then
                        item.Selected = False
                        Dim Id = item.OwnerListView.DataKeyValues(item.DisplayIndex)("Id").ToString()
                        Dim lblName As Label = CType(item.FindControl("lblFileName"), Label)
                        LocalAPI.UpdateAzureUploads(Id, cboDocTypeBulk.SelectedValue, lblName.Text, chkPublicBulk.Checked)
                    End If
                Next
            Else
                For Each item As GridDataItem In RadGridFiles.SelectedItems
                    If item.Selected Then
                        item.Selected = False
                        Dim Id = item("Id").Text
                        Dim lblName As Label = CType(item.FindControl("lblNameHide"), Label)
                        LocalAPI.UpdateAzureUploads(Id, cboDocTypeBulk.SelectedValue, lblName.Text, chkPublicBulk.Checked)
                    End If
                Next
            End If

        Else
            LocalAPI.UpdateAzureUploads(lblSelectedId.Text, cboDocTypeBulk.SelectedValue, lblSelectedName.Text, chkPublicBulk.Checked)
            lblSelectedId.Text = ""
        End If

        RadListViewFiles.DataBind()
        RadGridFiles.DataBind()
    End Sub


#End Region

    Public Sub RadCloudUpload1_FileUploaded(sender As Object, e As CloudFileUploadedEventArgs) Handles RadCloudUpload1.FileUploaded
        Try
            Dim tempName = e.FileInfo.KeyName
            Dim fileExt = IO.Path.GetExtension(tempName)
            Dim newName = "Companies/" & lblCompanyId.Text & $"/{Guid.NewGuid().ToString()}" & fileExt
            AzureStorageApi.CopyFile(tempName, newName, lblCompanyId.Text)
            AzureStorageApi.DeleteFile(tempName)

            ' The uploaded files need to be removed from the storage by the control after a certain time.
            Dim EmployeeId = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)
            e.IsValid = LocalAPI.AzureStorage_Insert(cboEmployee.SelectedValue, "Employee", cboDocType.SelectedItem.Value, e.FileInfo.OriginalFileName, newName, chkPublic.Checked, e.FileInfo.ContentLength, e.FileInfo.ContentType, lblCompanyId.Text)
            If e.IsValid Then
                RadListViewFiles.ClearSelectedItems()
                RadListViewFiles.DataBind()
                RadGridFiles.DataBind()
                RadWizardFiles.ActiveStepIndex = 1
                Master.InfoMessage(e.FileInfo.OriginalFileName & " uploaded")
            Else
                Master.ErrorMessage("The file " & e.FileInfo.OriginalFileName & " has been previously loaded!")
                AzureStorageApi.DeleteFile(newName)
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try

    End Sub

    Protected Sub RadGridFiles_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case e.CommandName
            Case "Update"
                lblSelectedId.Text = e.CommandArgument

                Dim item As GridDataItem = TryCast(e.Item, GridDataItem)

                lblSelectedId.Text = item.GetDataKeyValue("Id").ToString()
                lblSelectedName.Text = CType(item.FindControl("lblNameHide"), Label).Text
                Dim type As String = CType(item.FindControl("lblTypeHide"), Label).Text
                Dim spublic As String = CType(item.FindControl("lblPubicHide"), Label).Text

                RadToolTipBulkEdit.Visible = True
                RadToolTipBulkEdit.Show()
                CType(RadToolTipBulkEdit.FindControl("cboDocTypeBulk"), RadComboBox).SelectedValue = type
                CType(RadToolTipBulkEdit.FindControl("chkPublicBulk"), RadCheckBox).Checked = spublic
            Case "Delete"
                Dim item As GridDataItem = TryCast(e.Item, GridDataItem)
                lblSelectedId.Text = item.GetDataKeyValue("Id").ToString()
                RadToolTipBulkDelete.Visible = True
                RadToolTipBulkDelete.Show()
        End Select
    End Sub

    Private Sub RadListViewFiles_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles RadListViewFiles.ItemCommand

        Select Case e.CommandName
            Case "Update"
                Dim item As RadListViewDataItem = TryCast(e.ListViewItem, RadListViewDataItem)

                lblSelectedId.Text = item.GetDataKeyValue("Id").ToString()
                lblSelectedName.Text = CType(item.FindControl("lblNameHide"), Label).Text
                Dim type As String = CType(item.FindControl("lblTypeHide"), Label).Text
                Dim spublic As String = CType(item.FindControl("lblPubicHide"), Label).Text

                RadToolTipBulkEdit.Visible = True
                RadToolTipBulkEdit.Show()
                CType(RadToolTipBulkEdit.FindControl("cboDocTypeBulk"), RadComboBox).SelectedValue = type
                CType(RadToolTipBulkEdit.FindControl("chkPublicBulk"), RadCheckBox).Checked = spublic
        End Select
    End Sub

    Protected Sub btnTablePage_Click(sender As Object, e As EventArgs)
        RadListViewFiles.Visible = Not RadListViewFiles.Visible
        RadGridFiles.Visible = Not RadListViewFiles.Visible
        btnGridPage.Visible = Not RadListViewFiles.Visible
        btnTablePage.Visible = RadListViewFiles.Visible
    End Sub


End Class
