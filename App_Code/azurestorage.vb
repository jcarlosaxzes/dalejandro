
Imports System.IO
Imports System.Threading.Tasks
Imports Microsoft.WindowsAzure.Storage
Imports Microsoft.WindowsAzure.Storage.Blob

Public Class AzureStorageApi
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

    Public Shared Function UploadFilesAsync(fileName As String) As String
        Try

            ' Create a BlobServiceClient object which will be used to create a container client
            Dim storageAccount As CloudStorageAccount = CloudStorageAccount.Parse(GetConexion())

            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference("documents")

            'Generates Random Blob Name
            Dim randomName = $"{Guid.NewGuid().ToString()}.jpg"
            Dim blockBlob = container.GetBlockBlobReference(randomName)
            'Sets the content type to image
            blockBlob.Properties.ContentType = "image/jpeg"


            Dim localPath = "./data/"
            Dim localFilePath = Path.Combine(localPath, fileName)

            Dim fileContent = File.OpenRead(localFilePath)

            Using fileContent
                fileContent.Position = 0
                blockBlob.UploadFromStream(fileContent)
                fileContent.Close()
            End Using

            Return blockBlob.Uri.AbsoluteUri
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function UploadFilesStream(file As Stream, directory As String, contentType As String) As String
        Try

            ' Create a BlobServiceClient object which will be used to create a container client
            Dim storageAccount As CloudStorageAccount = CloudStorageAccount.Parse(GetConexion())

            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference("documents")

            'Generates Random Blob Name
            Dim randomName = $"{directory}{Guid.NewGuid().ToString()}.jpg"
            Dim blockBlob = container.GetBlockBlobReference(randomName)
            'Sets the content type to image
            blockBlob.Properties.ContentType = contentType

            Using file
                file.Position = 0
                blockBlob.UploadFromStream(file)
                file.Close()
            End Using

            Return blockBlob.Uri.AbsoluteUri
        Catch ex As Exception
            Throw ex
        End Try
    End Function

End Class
