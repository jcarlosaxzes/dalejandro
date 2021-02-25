Public Class DownFiles
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        Dim guid = Request.QueryString("guid")
        If Not String.IsNullOrEmpty(guid) Then
            Dim recor = LocalAPI.GetRecordFromQuery($"select * FROM [dbo].[Azure_Uploads] where [guid] = '{guid}'")
            If Not IsNothing(recor) AndAlso recor.ContainsKey("KeyName") Then
                Dim response As HttpResponse = Page.Response

                response.Clear()
                response.Buffer = True

                response.AddHeader("Content-Description", "File Transfer")
                response.AddHeader("Content-Type", recor("ContentType"))
                response.AddHeader("Content-Disposition", $"attachment;filename=""{recor("OriginalFileName")}""")

                Dim blob = AzureStorageApi.GetCloudBlockBlob(recor("KeyName"))
                blob.DownloadToStream(response.OutputStream)
                response.[End]()
            End If
        Else
            Response.RedirectPermanent("~/adm/schedule.aspx")
        End If






    End Sub

End Class