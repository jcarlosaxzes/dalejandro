Imports Telerik.Web.UI
Public Class rfp
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")

                lblEmployeeEmail.Text = Master.UserEmail
                lblEmployeeId.Text = Master.UserId

                lblRFPId.Text = Request.QueryString("rfpId")
                lblGuiId.Text = LocalAPI.GetRFPProperty(lblRFPId.Text, "guid")

                If Not Request.QueryString("fromtree") Is Nothing Then
                    lblBackSource.Text = 1
                End If

            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub
    Protected Sub btnUpdateTandCTemplate_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try

            Dim btnUpdate As RadButton = sender
            Dim cbo As RadComboBox = CType(btnUpdate.NamingContainer.FindControl("cboTandCtemplates"), RadComboBox)
            Dim editor As RadEditor = CType(btnUpdate.NamingContainer.FindControl("radEditor_TandC"), RadEditor)
            editor.Content = LocalAPI.GetProposalTemplateDescription(Val("" & cbo.SelectedValue))
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub
    Protected Sub btnPaymentSchedules_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try

            Dim btnGenerate As RadButton = sender
            Dim PanelContainer As Panel
            Dim cbo As RadComboBox = CType(btnGenerate.NamingContainer.FindControl("cboPaymentSchedules"), RadComboBox)

            Dim psValues As String = LocalAPI.GetStringEscalar("SELECT PaymentsScheduleList FROM Invoices_types WHERE [Id]=" & cbo.SelectedValue)
            Dim psText As String = LocalAPI.GetStringEscalar("SELECT PaymentsTextList FROM Invoices_types WHERE [Id]=" & cbo.SelectedValue)

            Dim sArrValues As String() = Split(psValues, ",")
            Dim sArrText As String() = Split(psText, ",")
            Dim i As Int16, j As Int16
            If sArrValues.Length > 0 Then
                For i = 0 To sArrValues.Length - 1
                    If Len(sArrValues(i).ToString) > 0 Then
                        PanelContainer = CType(btnGenerate.NamingContainer.FindControl("PanelPS" & i + 1), Panel)
                        CType(PanelContainer.FindControl("txtValue" & i + 1), RadTextBox).Text = sArrValues(i)
                        CType(PanelContainer.FindControl("txtText" & i + 1), RadTextBox).Text = sArrText(i)
                        PanelContainer.Visible = True
                    End If
                Next
            End If
            For j = i To 3
                PanelContainer = CType(btnGenerate.NamingContainer.FindControl("PanelPS" & j + 1), Panel)
                CType(PanelContainer.FindControl("txtValue" & j + 1), RadTextBox).Text = 0
                CType(PanelContainer.FindControl("txtText" & j + 1), RadTextBox).Text = ""
                PanelContainer.Visible = False
            Next

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub
#Region "Attachment_Step7"
    Protected Sub RadCloudUpload1_FileUploaded(sender As Object, e As Telerik.Web.UI.CloudFileUploadedEventArgs)
        Try
            If LocalAPI.IsAzureStorage(lblCompanyId.Text) Then
                Dim tempName = e.FileInfo.KeyName
                Dim fileExt = IO.Path.GetExtension(tempName)
                Dim newName = "Companies/" & lblCompanyId.Text & $"/{Guid.NewGuid().ToString()}" & fileExt
                AzureStorageApi.CopyFile(tempName, newName, lblCompanyId.Text)
                AzureStorageApi.DeleteFile(tempName, 0)
                ' The uploaded files need to be removed from the storage by the control after a certain time.
                e.IsValid = LocalAPI.RequestForProposalsAzureStorage_Insert(lblRFPId.Text, 0, e.FileInfo.OriginalFileName, newName, True, e.FileInfo.ContentLength, e.FileInfo.ContentType, lblGuiId.Text)
                SqlDataSourceAzureFiles.DataBind()
                Master.InfoMessage(e.FileInfo.OriginalFileName & " uploaded")
                Try
                    CType(sender.NamingContainer.FindControl("RadGridAzureuploads"), RadGrid).DataBind()
                Catch ex As Exception
                End Try
            Else
                Master.ErrorMessage("You do not have hired the module Upload files")
            End If
        Catch ex As Exception
            e.IsValid = False
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub


#End Region

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Select Case lblBackSource.Text
            Case 1
                Response.Redirect("~/adm/rfps.aspx")
            Case 2
                Response.Redirect("~/adm/requestforproposals.aspx")

        End Select
    End Sub

    Private Sub SqlDataSourceAzureFiles_Deleting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceAzureFiles.Deleting
        Dim KeyName As String = LocalAPI.GetAzureFileKeyName(e.Command.Parameters("@Id").Value)
        AzureStorageApi.DeleteFile(KeyName, lblCompanyId.Text)
    End Sub
End Class
