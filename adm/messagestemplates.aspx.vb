Imports Newtonsoft.Json.Linq
Imports Telerik.Web.UI

Public Class messagestemplates
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            lblCompanyId.Text = Session("companyId")

        End If
    End Sub

    Private Sub btnRestore_Click(sender As Object, e As EventArgs) Handles btnRestore.Click
        LocalAPI.RestoreDefaultMessageTemplate(lblCompanyId.Text)
        RadGrid1.DataBind()
    End Sub


    Protected Sub RadGrid1_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs)
        If TypeOf e.Item Is GridEditableItem AndAlso e.Item.IsInEditMode Then

            Dim editItem As GridEditableItem = CType(e.Item, GridEditableItem)
            Dim GridEditorBody As RadEditor = CType(editItem.FindControl("GridEditorBody"), RadEditor)
            Dim dataItemRow = editItem.DataItem

            If dataItemRow("isEditable") Then
                'add a new Toolbar dynamically   
                Dim dynamicToolbar As New EditorToolGroup()
                GridEditorBody.Tools.Add(dynamicToolbar)

                'add a custom dropdown and set its items and dimension attributes   
                Dim ddn As New EditorDropDown("Variables")
                ddn.Text = "Variables"

                'Set the popup width and height   
                ddn.Attributes("width") = "150px"
                ddn.Attributes("Height") = "100px"


                If Not IsNothing(dataItemRow("Variables")) AndAlso Not (TypeOf dataItemRow("Variables") Is DBNull) Then
                    Dim jsonText As String = dataItemRow("Variables")
                    Dim jsonObj As JObject = JObject.Parse(jsonText)

                    Dim dictObj As Dictionary(Of String, String) = jsonObj.ToObject(Of Dictionary(Of String, String))()

                    For Each kvp As KeyValuePair(Of String, String) In dictObj
                        ddn.Items.Add($"[{kvp.Key}]", $"[{kvp.Key}]")
                    Next

                    'Add tool to toolbar   
                    dynamicToolbar.Tools.Add(ddn)
                End If
            End If
        End If

    End Sub

End Class