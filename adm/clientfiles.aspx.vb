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
            ''get a reference to the row
            'If RadGridAzureFiles.SelectedItems.Count > 0 Then
            '    For Each dataItem As GridDataItem In RadGridAzureFiles.SelectedItems
            '        If dataItem.Selected Then
            '            lblSelectedId.Text = dataItem("Id").Text
            '            lblSelectedSource.Text = dataItem("Source").Text
            '            SqlDataSourceAzureFiles.Delete()
            '        End If
            '    Next
            '    RadGridAzureFiles.DataBind()
            'Else
            '    Master.ErrorMessage("Select records!")

            'End If



        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

    Private Sub SqlDataSourceAzureFiles_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAzureFiles.Deleting
        Dim KeyName As String = LocalAPI.GetAzureFileKeyName(e.Command.Parameters("@Id").Value)
        AzureStorageApi.DeleteFile(KeyName, lblCompanyId.Text)
    End Sub

    Public Function FormatSource(source As String)
        Return source.Replace("1.-", "").Replace("2.-", "").Replace("3.-", "")
    End Function

    Public Function CreateIcon(sContentType As String, sUrl As String, sName As String)
        If sContentType = "application/pdf" Then
            Return $"<a class=""far fa-file-pdf"" style=""font-size: 150px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
        End If
        If sContentType = "application/zip" Or sContentType = "application/x-tar" Or sContentType = "application/x-rar" Then
            Return $"<a class=""far fa-file-archive"" style=""font-size: 150px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
        End If
        If sContentType = "application/vnd.ms-excel" Or sContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" Then
            Return $"<a class=""far fa-file-excel"" style=""font-size: 150px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
        End If
        If sContentType = "application/msword" Or sContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document" Then
            Return $"<a class=""far fa-file-pdf"" style=""font-size: 150px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"
        End If
        If sContentType = "image/tiff" Or sContentType = "image/bmp" Or sContentType = "image/jpeg" Or sContentType = "image/gif" Or sContentType = "Image/jpg" Or sContentType = "image/png" Then
            Return $"<image src=""{sUrl}"" width=""300px""/>"
        End If

        Return $"<a class=""far fa-file"" style=""font-size: 150px; color: black"" title=""Click To View "" href='{sUrl}' target=""_blank"" aria-hidden=""True""></a>"

    End Function

End Class
