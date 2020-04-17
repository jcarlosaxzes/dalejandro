Imports Telerik.Web.UI
Public Class uploadphoto
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblCodeId.Text = Request.QueryString("Id")
                lblEntity.Text = Request.QueryString("Entity")
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

            Dim urlPath As String = lblPath.Text & "/" & lblCodeId.Text & ".jpg"
            For Each f As UploadedFile In RadAsyncUpload1.UploadedFiles
                f.SaveAs(Server.MapPath(urlPath), True)
            Next
            Label1.Text = "Photo has been uploaded successfully"
        Catch ex As Exception
            Label1.Text = ex.Message
        End Try
    End Sub
End Class
