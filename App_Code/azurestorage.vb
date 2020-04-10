
Public Class azurestorage
    Public Shared Function GetConexion() As String
        Return "DefaultEndpointsProtocol=https;AccountName=pasconceptstorage;AccountKey=hwAAeswB6wU9E6nF1f2s33k40vp1A4Vo4XeWrkA/eXIuULghBFjzjl0En8QMAf1g3ndTBktzpAnM5sXMBA4qdQ==;EndpointSuffix=core.windows.net"
    End Function
    Public Shared Function DeleteFile(ByVal KeyName As String) As Boolean
        Try
            Dim containerName As String = "documents"
            'Dim storageAccount As CloudStorageAccount = CloudStorageAccount.Parse(GetConexion())
            'Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            'Dim container As CloudBlobContainer = blobClient.GetContainerReference(containerName)
            'Dim blockBlob As CloudBlockBlob = container.GetBlockBlobReference(KeyName)
            'blockBlob.DeleteIfExists()
            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function
End Class
