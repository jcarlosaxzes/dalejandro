Public Class messagestemplates1
    Inherits System.Web.UI.Page


    Protected Sub RadGrid1_ItemCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Try
            Select Case e.CommandName

                Case "ApplyToAllCompanies"
                    lblSelectedType.Text = e.CommandArgument

                    SqlDataSource1.Insert()


            End Select
        Catch ex As Exception
            Dim e1 As String = ex.Message
        End Try
    End Sub
End Class
