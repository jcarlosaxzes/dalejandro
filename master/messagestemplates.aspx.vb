
Imports Newtonsoft.Json.Linq
Imports Telerik.Web.UI

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


    Protected Sub RadGrid1_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs)
        If TypeOf e.Item Is GridEditableItem AndAlso e.Item.IsInEditMode Then

            Dim editItem As GridEditableItem = CType(e.Item, GridEditableItem)
            Dim GridEditorBody As RadEditor = CType(editItem.FindControl("GridEditorBody"), RadEditor)

            'add a new Toolbar dynamically   
            Dim dynamicToolbar As New EditorToolGroup()
            GridEditorBody.Tools.Add(dynamicToolbar)

            'add a custom dropdown and set its items and dimension attributes   
            Dim ddn As New EditorDropDown("Variables")
            ddn.Text = "Variables"

            'Set the popup width and height   
            ddn.Attributes("width") = "150px"
            ddn.Attributes("Height") = "100px"

            Dim dataItemRow = editItem.DataItem
            Dim jsonText As String = dataItemRow("Variables")
            Dim jsonObj As JObject = JObject.Parse(jsonText)

            Dim dictObj As Dictionary(Of String, String) = jsonObj.ToObject(Of Dictionary(Of String, String))()

            For Each kvp As KeyValuePair(Of String, String) In dictObj
                ddn.Items.Add($"[{kvp.Key}]", $"[{kvp.Key}]")
            Next

            'Add tool to toolbar   
            dynamicToolbar.Tools.Add(ddn)
        End If

    End Sub
End Class
