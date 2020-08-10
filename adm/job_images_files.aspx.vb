Imports Telerik.Web.UI
Public Class Job_images_files
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblJobId.Text = Request.QueryString("JobId")
                imgGoogleStreetview.DataBind()
                '!!!RadBinaryImageJob.DataValue = LocalAPI.JobGetImage(lblJobId.Text)
                Master.ActiveTab(12)
            End If


        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    'Protected Sub btnSaveImage_Click(sender As Object, e As EventArgs) Handles btnSaveImage.Click
    '    Try

    '        If RadAsyncUpload1.UploadedFiles(0).FileName IsNot Nothing AndAlso RadAsyncUpload1.UploadedFiles(0).FileName <> "" Then
    '            Dim strExtension As String = System.IO.Path.GetExtension(RadAsyncUpload1.UploadedFiles(0).FileName)
    '            If (strExtension.ToUpper() = ".JPEG") Or (strExtension.ToUpper() = ".JPG") Or (strExtension.ToUpper() = ".GIF") Or (strExtension.ToUpper() = ".BMP") Or (strExtension.ToUpper() = ".PNG") Then
    '                ' Resize Image Before Uploading to DataBase
    '                Dim imageToBeResized As System.Drawing.Image = System.Drawing.Image.FromStream(RadAsyncUpload1.UploadedFiles(0).InputStream)
    '                Dim imageHeight As Integer = imageToBeResized.Height
    '                Dim imageWidth As Integer = imageToBeResized.Width
    '                Dim maxHeight As Integer = IIf(Val(ConfigurationManager.AppSettings("JobImageHeight")) > 0, ConfigurationManager.AppSettings("JobImageHeight"), 320)
    '                Dim maxWidth As Integer = IIf(Val(ConfigurationManager.AppSettings("JobImageWidth")) > 0, ConfigurationManager.AppSettings("JobImageWidth"), 200)
    '                imageHeight = (imageHeight * maxWidth) / imageWidth
    '                imageWidth = maxWidth

    '                If imageHeight > maxHeight Then
    '                    imageWidth = (imageWidth * maxHeight) / imageHeight
    '                    imageHeight = maxHeight
    '                End If

    '                Dim bitmap As New Bitmap(imageToBeResized, imageWidth, imageHeight)
    '                Dim stream As System.IO.MemoryStream = New MemoryStream()
    '                bitmap.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg)
    '                stream.Position = 0
    '                Dim imageBytes As Byte() = New Byte(stream.Length) {}
    '                stream.Read(imageBytes, 0, imageBytes.Length)

    '                LocalAPI.JobSetImage(lblJobId.Text, imageBytes)
    '                'btnSaveImage.Enabled = False
    '                RadBinaryImageJob.DataValue = LocalAPI.JobGetImage(lblJobId.Text)
    '                Master.InfoMessage("The image is updated")
    '            Else
    '                Master.InfoMessage("The file most be JPG, GIF o PNG")
    '            End If
    '        Else
    '            Master.InfoMessage("Select an image file")
    '        End If
    '    Catch ex As Exception
    '        Master.ErrorMessage(ex.Message)
    '    End Try

    'End Sub

    'Protected Sub btnDeleteImage_Click(sender As Object, e As EventArgs) Handles btnDeleteImage.Click
    '    LocalAPI.JobDeleteImages(lblJobId.Text)
    '    Response.Redirect("~/ADM/Job_images_files.aspx?JobId=" & lblJobId.Text)
    'End Sub

    'Protected Sub RadAsyncUpload1_FileUploaded(sender As Object, e As Telerik.Web.UI.FileUploadedEventArgs)
    '    Try

    '        Dim imgStream As Stream = e.File.InputStream
    '        Dim imgBytes As Byte() = New Byte(imgStream.Length) {}
    '        imgStream.Read(imgBytes, 0, imgStream.Length)

    '        RadBinaryImageJob.DataValue = imgBytes
    '        'btnSaveImage.Enabled = True

    '    Catch ex As Exception
    '        Master.ErrorMessage(ex.Message)

    '    End Try
    'End Sub

    Private Sub RadCloudUploadOthers_FileUploaded(sender As Object, e As CloudFileUploadedEventArgs) Handles RadCloudUploadOthers.FileUploaded
        Try
            If LocalAPI.IsAzureStorage(lblCompanyId.Text) Then
                Dim tempName = e.FileInfo.KeyName
                Dim fileExt = IO.Path.GetExtension(tempName)
                Dim newName = "Companies/" & lblCompanyId.Text & $"/{Guid.NewGuid().ToString()}" & fileExt
                AzureStorageApi.CopyFile(tempName, newName, lblCompanyId.Text)
                AzureStorageApi.DeleteFile(tempName)

                ' The uploaded files need to be removed from the storage by the control after a certain time.
                e.IsValid = LocalAPI.AzureStorage_Insert(lblJobId.Text, "Jobs", 9, e.FileInfo.OriginalFileName, newName, True, e.FileInfo.ContentLength, "image/png", lblCompanyId.Text)
                If e.IsValid Then
                    RadListView1.DataBind()
                    Master.InfoMessage(e.FileInfo.OriginalFileName & " uploaded")
                Else
                    Master.ErrorMessage("The file " & e.FileInfo.OriginalFileName & " has been previously loaded!")
                End If
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try

    End Sub

    Private Sub SqlDataSourceAzureFiles_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceFotos.Deleting
        Dim KeyName As String = LocalAPI.GetAzureFileKeyName(e.Command.Parameters("@Id").Value)
        AzureStorageApi.DeleteFile(KeyName)
    End Sub
End Class
