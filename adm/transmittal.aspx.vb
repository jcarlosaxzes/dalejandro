Imports Telerik.Web.UI
Public Class transmittal1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then

                lblCompanyId.Text = Session("companyId")
                lblTransmittalId.Text = Request.QueryString("transmittalId")
                lblJobId.Text = LocalAPI.GetTransmittalProperty(lblTransmittalId.Text, "JobId")

                lblEmployeeEmail.Text = Master.UserEmail
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)
                lblEmployeeName.Text = LocalAPI.GetEmployeeName(lblEmployeeId.Text)

                FormView1.DataBind()
                CType(FormView1.FindControl("RadBarcode1"), RadBarcode).Text = LocalAPI.GetSharedLink_URL(66, lblTransmittalId.Text)

                If Not LocalAPI.IsADMCLIuserAutorized(lblEmployeeEmail.Text, lblCompanyId.Text) Then
                    lblTransmittalId.Text = 0
                End If

                If Not Request.QueryString("BackPage") Is Nothing Then
                    lblBackPage.Text = Request.QueryString("BackPage")
                    btnBack.Visible = True
                Else
                    Master.HideMasterMenu()
                    btnBack.Visible = False
                End If

                ConfigUploadPanels()

            End If

            Botones()

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub ConfigUploadPanels()
        Dim ExistingFiles As Integer = LocalAPI.GetEntityAzureFilesCount(lblTransmittalId.Text, "Transmittal")

        If ExistingFiles = 0 Then
            RadWizardStepUpload.Active = True
            PanelUpload.Visible = True
            RadListViewFiles.Visible = False
            RadGridFiles.Visible = False
        Else
            RadWizardStepFiles.Active = True
            PanelUpload.Visible = False
            RadListViewFiles.Visible = False
            RadGridFiles.Visible = Not RadListViewFiles.Visible
            RadGridFiles.DataBind()
            RadListViewFiles.DataBind()
        End If

        btnGridPage.Visible = Not RadListViewFiles.Visible
        btnTablePage.Visible = RadListViewFiles.Visible

        If lblCompanyId.Text = 260962 Then
            ' EEG 10 Mb
            RadCloudUpload1.MaxFileSize = 10485760
        End If

    End Sub
    Protected Sub RadAjaxManager1_AjaxRequest(sender As Object, e As Telerik.Web.UI.AjaxRequestEventArgs)
        ' Return of ClientClose
        FormView1.DataBind()
    End Sub



    Private Sub Botones()
        Try

            Dim bIsTransmittalReadyToSigned As Boolean = LocalAPI.IsTransmittalReadyToSigned(lblTransmittalId.Text)

            ' Administrators
            CType(FormView1.FindControl("btnMailReadyToSign"), RadButton).Visible = bIsTransmittalReadyToSigned
            CType(FormView1.FindControl("btnPickUp"), RadButton).Visible = bIsTransmittalReadyToSigned
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As EventArgs)
        CType(FormView1.FindControl("RadGridEditDetails"), RadGrid).MasterTableView.InsertItem()
    End Sub

    Protected Sub SqlDataSourceDetails_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceDetails.Inserted
        SqlDataSourceDetails.DataBind()
        CType(FormView1.FindControl("RadGridEditDetails"), RadGrid).DataBind()
    End Sub

    Protected Sub btnPickUp_Click(sender As Object, e As EventArgs)
        If btnBack.Visible Then
            Response.RedirectPermanent("~/adm/signature.aspx?ObjId=2&Id=" & lblTransmittalId.Text & "&BackPage=transmittals")
        Else
            Response.RedirectPermanent("~/adm/signature.aspx?ObjId=2&Id=" & lblTransmittalId.Text)
        End If

    End Sub

    Protected Sub btnMailReadyToSign_Click(sender As Object, e As EventArgs)
        MailReadtToSign()
    End Sub
    Protected Sub btnMailDigitalDelivery_Click(sender As Object, e As EventArgs)
        If btnBack.Visible Then
            CreateRadWindows("Delivery", "~/adm/sendtransmittal.aspx?TransmittalId=" & lblTransmittalId.Text, 960, 780, True)
        Else
            Response.Redirect("~/adm/sendtransmittal.aspx?TransmittalId=" & lblTransmittalId.Text & "&BackPage=" & lblBackPage.Text)
        End If

    End Sub

    Private Sub MailReadtToSign()
        Try
            If LocalAPI.EmailReadyToPickUp(lblTransmittalId.Text, lblCompanyId.Text, lblEmployeeEmail.Text, lblEmployeeName.Text) Then
                LocalAPI.SetTransmittalJobToDoneStatus(lblTransmittalId.Text)
            End If
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub FormView1_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormView1.ItemUpdated
        MostrarConfirmMail()
    End Sub

    Private Sub MostrarConfirmMail()
        RadToolTipMail.Visible = True
        RadToolTipMail.Show()
    End Sub

    Protected Sub btnCancelMail_Click(sender As Object, e As EventArgs) Handles btnCancelMail.Click
        RadToolTipMail.Visible = False
        CType(FormView1.FindControl("RadBarcode1"), RadBarcode).Text = LocalAPI.GetSharedLink_URL(66, lblTransmittalId.Text)
    End Sub

    Protected Sub btnConfirmMail_Click(sender As Object, e As EventArgs) Handles btnConfirmMail.Click
        ' Enviar mail
        MailReadtToSign()
        RadToolTipMail.Visible = False
        CType(FormView1.FindControl("RadBarcode1"), RadBarcode).Text = LocalAPI.GetSharedLink_URL(66, lblTransmittalId.Text)
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Select Case lblBackPage.Text
            Case "transmittals"
                Response.Redirect("~/adm/transmittals.aspx")
            Case "job_transmittals"
                Response.Redirect("~/adm/job_transmittals.aspx?jobId=" & lblJobId.Text)
        End Select

    End Sub

    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean)
        RadWindowManager1.Windows.Clear()
        Dim window1 As RadWindow = New RadWindow()
        window1.NavigateUrl = sUrl
        window1.VisibleOnPageLoad = True
        window1.VisibleStatusbar = False
        window1.ID = WindowsID
        If Maximize Then window1.InitialBehaviors = WindowBehaviors.Maximize
        window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
        window1.Width = Width
        window1.Height = Height
        window1.Modal = True
        window1.OnClientClose = "OnClientClose"
        RadWindowManager1.Windows.Add(window1)
    End Sub

#Region "Upload Files"


    Public Sub RadCloudUpload1_FileUploaded(sender As Object, e As CloudFileUploadedEventArgs) Handles RadCloudUpload1.FileUploaded
        Try
            Dim tempName = e.FileInfo.KeyName
            Dim fileExt = IO.Path.GetExtension(tempName)
            Dim newName = "Companies/" & lblCompanyId.Text & $"/{Guid.NewGuid().ToString()}" & fileExt
            AzureStorageApi.CopyFile(tempName, newName, lblCompanyId.Text)
            AzureStorageApi.DeleteFile(tempName)

            ' The uploaded files need to be removed from the storage by the control after a certain time.
            e.IsValid = LocalAPI.AzureStorage_Insert_Transmittal(lblTransmittalId.Text, "Transmittal", cboDocType.SelectedValue, e.FileInfo.OriginalFileName, newName, chkPublic.Checked, e.FileInfo.ContentLength, e.FileInfo.ContentType, lblCompanyId.Text, tbMaxDownload.Text, RadDatePickerExpiration.DbSelectedDate)
            If e.IsValid Then
                'RadListViewFiles.ClearSelectedItems()
                'RadGridFiles.DataBind()
                'RadListViewFiles.DataBind()
                'FormView1.DataBind()
                'RadWizardStepFiles.Active = True

                'Master.InfoMessage(e.FileInfo.OriginalFileName & " uploaded")
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
                Dim TransmittalFileObject = LocalAPI.GetRecord(lblSelectedId.Text, "Azure_Uploads_SELECT")

                RadToolTipBulkEdit.Visible = True
                RadToolTipBulkEdit.Show()
                cboDocTypeBulk.SelectedValue = TransmittalFileObject("Type")
                chkPublicBulk.Checked = TransmittalFileObject("Public")
                tbMaxDownloadBulk.Text = TransmittalFileObject("MaxDownload")
                If Not TransmittalFileObject("ExpirationDate") Is Nothing Then
                    RadDatePickerExpirationBulk.DbSelectedDate = TransmittalFileObject("ExpirationDate")
                End If

            Case "Delete"
                Dim item As GridDataItem = TryCast(e.Item, GridDataItem)
                lblSelectedId.Text = item.GetDataKeyValue("Id").ToString()
                RadToolTipBulkDelete.Visible = True
                RadToolTipBulkDelete.Show()
        End Select
    End Sub

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

    Private Sub btnUpdateStatusFiles_Click(sender As Object, e As EventArgs) Handles btnUpdateStatusFiles.Click

        If String.IsNullOrEmpty(lblSelectedId.Text) Then
            If RadListViewFiles.Visible Then
                RadListViewFiles.AllowMultiItemEdit = True
                For Each item As RadListViewDataItem In RadListViewFiles.SelectedItems
                    If item.Selected Then
                        item.Selected = False
                        Dim Id = item.OwnerListView.DataKeyValues(item.DisplayIndex)("Id").ToString()
                        Dim lblName As Label = CType(item.FindControl("lblFileName"), Label)
                        LocalAPI.UpdateTransmittalAzureUploads(Id, cboDocTypeBulk.SelectedValue, chkPublicBulk.Checked, tbMaxDownloadBulk.Text, RadDatePickerExpirationBulk.DbSelectedDate)
                    End If
                Next
            Else
                For Each item As GridDataItem In RadGridFiles.SelectedItems
                    If item.Selected Then
                        item.Selected = False
                        Dim Id = item("Id").Text
                        Dim lblName As Label = CType(item.FindControl("lblNameHide"), Label)
                        LocalAPI.UpdateTransmittalAzureUploads(Id, cboDocTypeBulk.SelectedValue, chkPublicBulk.Checked, tbMaxDownloadBulk.Text, RadDatePickerExpirationBulk.DbSelectedDate)
                    End If
                Next
            End If

        Else
            LocalAPI.UpdateTransmittalAzureUploads(lblSelectedId.Text, cboDocTypeBulk.SelectedValue, chkPublicBulk.Checked, tbMaxDownloadBulk.Text, RadDatePickerExpirationBulk.DbSelectedDate)
            lblSelectedId.Text = ""
        End If

        RadListViewFiles.DataBind()
        RadGridFiles.DataBind()
    End Sub

    Protected Sub btnConfirmDeleteFiles_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnConfirmDeleteFiles.Click

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

    Protected Sub btnCancelDeleteFiles_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelDeleteFiles.Click
        RadToolTipBulkDelete.Visible = False
    End Sub

    Private Sub RadListViewFiles_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles RadListViewFiles.ItemCommand

        Select Case e.CommandName
            Case "Update"
                Dim item As RadListViewDataItem = TryCast(e.ListViewItem, RadListViewDataItem)

                lblSelectedId.Text = item.GetDataKeyValue("Id").ToString()
                Dim type As String = CType(item.FindControl("lblTypeHide"), Label).Text
                Dim spublic As String = CType(item.FindControl("lblPubicHide"), Label).Text
                Dim maxDownloade As String = CType(item.FindControl("lblMaxDownloadeHide"), Label).Text


                RadToolTipBulkEdit.Visible = True
                RadToolTipBulkEdit.Show()
                CType(RadToolTipBulkEdit.FindControl("cboDocTypeBulk"), RadComboBox).SelectedValue = type
                CType(RadToolTipBulkEdit.FindControl("chkPublicBulk"), RadCheckBox).Checked = spublic
                CType(RadToolTipBulkEdit.FindControl("tbMaxDownloadBulk"), RadTextBox).Text = maxDownloade

        End Select
    End Sub


    Public Function FormatSource(source As String)
        Return source.Replace("1.-", "").Replace("2.-", "").Replace("3.-", "")
    End Function

    Protected Sub btnUploadFiles_Click(sender As Object, e As EventArgs)
        RadWizardFiles.ActiveStepIndex = 1
        PanelUpload.Visible = True
    End Sub

    Protected Sub btnListFiles_Click(sender As Object, e As EventArgs)
        RadWizardFiles.ActiveStepIndex = 0
        PanelUpload.Visible = False
    End Sub

    Protected Sub btnTablePage_Click(sender As Object, e As EventArgs)
        RadListViewFiles.Visible = Not RadListViewFiles.Visible
        RadGridFiles.Visible = Not RadListViewFiles.Visible
        btnGridPage.Visible = Not RadListViewFiles.Visible
        btnTablePage.Visible = RadListViewFiles.Visible
    End Sub

#End Region


    Protected Sub btnNewFileLink_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewFileLink.Click
        Try

            RadGridLinks.MasterTableView.InsertItem()
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub
    Private Sub btnSaveUpload_Click(sender As Object, e As EventArgs) Handles btnSaveUpload.Click
        ConfigUploadPanels()
    End Sub
End Class
