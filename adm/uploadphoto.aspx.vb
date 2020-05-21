Imports Telerik.Web.UI
Public Class uploadphoto
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblCodeId.Text = Request.QueryString("Id")
                lblEntity.Text = Request.QueryString("Entity")
                lblEmail.Text = Request.QueryString("Email")
                Page.Title = lblEntity.Text & " Avatar"

                If lblEntity.Text = "Client" Then
                    lblPath.Text = "~/Images/Clients"
                End If
                If lblEntity.Text = "Employee" Then
                    lblPath.Text = "~/Images/Employees"
                End If
            End If

        Catch ex As Exception
        End Try

    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Try
            For Each f As UploadedFile In RadAsyncUpload1.UploadedFiles


                If lblEntity.Text = "Client" Then
                    Dim newName = "Companies/" & lblCompanyId.Text & $"/Clients/{Guid.NewGuid().ToString()}" & f.GetExtension()
                    Dim Url = AzureStorageApi.UploadFilesStream(f.InputStream, newName, "image/jpeg", lblCompanyId.Text)
                    LocalAPI.ClientAddUpdatePhoto(Convert.ToInt32(lblCodeId.Text), Url, f.ContentType, DateTime.Now)
                End If
                If lblEntity.Text = "Employee" Then
                    Dim newName = "Companies/" & lblCompanyId.Text & $"/Employess/{Guid.NewGuid().ToString()}" & f.GetExtension()
                    Dim Url = AzureStorageApi.UploadFilesStream(f.InputStream, newName, "image/jpeg", lblCompanyId.Text)
                    Dim empEmail = LocalAPI.GetEmployeeEmail(Convert.ToInt32(lblCodeId.Text))
                    LocalAPI.EmployeeAddUpdatePhoto(empEmail, Url, f.ContentType, DateTime.Now)
                End If


            Next
            Label1.Text = "Photo has been uploaded successfully"
        Catch ex As Exception
            Label1.Text = ex.Message
        End Try
    End Sub
End Class
