Imports System.Data.SqlClient
Imports System.IO
Imports Microsoft.AspNet.Identity.Owin
Imports Telerik.Web.UI

Partial Class Usercrud
    Inherits System.Web.UI.Page

    Private Const ColumnUniqueName As String = "cmdMigrate"
    Private gridMessage As String = Nothing

    Protected Sub RadGrid1_DataBound(ByVal sender As Object, ByVal e As EventArgs)

        '
    End Sub

    Protected Sub RadGrid1_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs)
        If TypeOf e.Item Is GridDataItem Then
            Dim dataItem As GridDataItem = CType(e.Item, GridDataItem)
            Dim IsMigrate = dataItem.DataItem.Row.ItemArray(6)
            If IsMigrate = True Then
                dataItem("cmdMigrate").Controls(0).Visible = False
            Else
                dataItem("cmdMigrate").Controls(0).Visible = True
            End If
        End If
    End Sub

    Protected Sub RadGrid1_PreRender(ByVal sender As Object, ByVal e As EventArgs)
        RadGrid1.MasterTableView.GetColumn("IsMigrate").Visible = False
        RadGrid1.Rebind()
    End Sub



    Protected Async Sub RadGrid1_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs)
        If e.CommandName = "cmdMigrate" Then
            Try
                Dim item As GridDataItem = CType(e.Item, GridDataItem)
                Dim email As String = item("Email").Text
                Dim password = LocalAPI.GetMembershipUserPasswod(email)
                LocalAPI.AppUserManager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
                Dim user = Await LocalAPI.CreateOrUpdateUser(email, password)

                Dim query = "update [dbo].[Employees] set [IsMigrate] = 1 where [Email] = '" & email & "'"
                LocalAPI.ExecuteNonQuery(query)

                ' Refrescar el grid
                RadGrid1.DataBind()

            Catch ex As Exception
                Throw ex
            End Try
        End If
    End Sub





    Protected Sub RadGrid1_cmdMigrate(ByVal source As Object, ByVal e As Telerik.Web.UI.GridInsertedEventArgs)
        If Not e.Exception Is Nothing Then
            e.ExceptionHandled = True
            e.KeepInInsertMode = True
            SetMessage("Insert failed. Reason: " + e.Exception.Message)
        Else
            SetMessage("New product is inserted!")
        End If
    End Sub

    Private Sub DisplayMessage(ByVal text As String)
        RadGrid1.Controls.Add(New LiteralControl(String.Format("<span style='color:red'>{0}</span>", text)))
    End Sub

    Private Sub SetMessage(ByVal message As String)
        gridMessage = message
    End Sub

    Protected Sub Unnamed_Click(sender As Object, e As EventArgs)
        Dim sImagePath = "~/Images/Employees/"

        Dim files() As String = Directory.GetFiles(HttpContext.Current.Server.MapPath(sImagePath))

        For Each f As String In files
            Dim name = Path.GetFileNameWithoutExtension(f)
            Dim empEmail = LocalAPI.GetEmployeeEmail(Convert.ToInt32(name))
            If Not IsNothing(empEmail) And Len(empEmail) > 0 Then

                Dim uploadFileStream = File.OpenRead(f)

                Dim Url = AzureStorageApi.UploadFilesStream(uploadFileStream, "2016/Employess/", "image/jpeg")

                LocalAPI.EmployeeAddUpdatePhoto(empEmail, Url, "image/jpeg", DateTime.Now)

            End If
        Next

    End Sub

    Protected Sub btnClients_Click(sender As Object, e As EventArgs)
        Dim sImagePath = "~/Images/Clients/"

        Dim files() As String = Directory.GetFiles(HttpContext.Current.Server.MapPath(sImagePath))

        For Each f As String In files
            Dim name = Path.GetFileNameWithoutExtension(f)
            If Not IsNothing(name) And Len(name) > 0 And IsNumeric(name) Then

                Dim uploadFileStream = File.OpenRead(f)

                Dim Url = AzureStorageApi.UploadFilesStream(uploadFileStream, "2016/Clients/", "image/jpeg")

                LocalAPI.ClientAddUpdatePhoto(Convert.ToInt32(name), Url, "image/jpeg", DateTime.Now)

            End If
        Next
    End Sub
End Class
