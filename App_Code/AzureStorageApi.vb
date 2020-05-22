
Imports System.IO
Imports System.Threading.Tasks
Imports Microsoft.Azure.Storage.DataMovement
Imports Microsoft.Azure.Storage
Imports Microsoft.Azure.Storage.Blob
Imports Microsoft.Azure.Management.DataLake.Store

Public Class AzureStorageApi
    Public Shared Function GetConexion() As String
        Return "DefaultEndpointsProtocol=https;AccountName=pasconceptstorage;AccountKey=hwAAeswB6wU9E6nF1f2s33k40vp1A4Vo4XeWrkA/eXIuULghBFjzjl0En8QMAf1g3ndTBktzpAnM5sXMBA4qdQ==;EndpointSuffix=core.windows.net"
    End Function
    Public Shared Function DeleteFile(ByVal KeyName As String) As Boolean
        Try
            Dim containerName As String = "documents"
            Dim storageAccount As CloudStorageAccount = CloudStorageAccount.Parse(GetConexion())
            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference(containerName)
            Dim blockBlob As CloudBlockBlob = container.GetBlockBlobReference(KeyName)
            blockBlob.DeleteIfExists()
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
            Dim fileExt = Path.GetExtension(fileName)
            Dim randomName = $"{Guid.NewGuid().ToString()}" & fileExt
            Dim blockBlob = container.GetBlockBlobReference(randomName)
            'Sets the content type to image
            Dim mimeType = MimeMapping.GetMimeMapping(fileName)
            If IsNothing(mimeType) Then
                mimeType = "image/jpeg"
            End If
            blockBlob.Properties.ContentType = mimeType


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

    Public Shared Function UploadFilesStream(file As Stream, KeyName As String, contentType As String, companyId As String) As String
        Try

            ' Create a BlobServiceClient object which will be used to create a container client
            Dim storageAccount As CloudStorageAccount = CloudStorageAccount.Parse(GetConexion())

            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference("documents")

            'Generates Random Blob Name
            Dim blockBlob = container.GetBlockBlobReference(KeyName)
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

    Public Shared Function CopyFile(SourceKeyName As String, DestinationKeyName As String) As Boolean
        Try
            Dim containerName As String = "documents"
            Dim storageAccount As CloudStorageAccount = CloudStorageAccount.Parse(GetConexion())
            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference(containerName)
            Dim sourceBlockBlob As CloudBlockBlob = container.GetBlockBlobReference(SourceKeyName)
            Dim destinationBlockBlob As CloudBlockBlob = container.GetBlockBlobReference(DestinationKeyName)

            destinationBlockBlob.StartCopy(sourceBlockBlob)

            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function


    Public Shared Function UploadBytesData(fileName As String, fileData As Byte(), directory As String, contentType As String) As String
        Try

            ' Create a BlobServiceClient object which will be used to create a container client
            Dim storageAccount As CloudStorageAccount = CloudStorageAccount.Parse(GetConexion())

            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference("documents")

            'Generates Random Blob Name
            Dim fileExt = Path.GetExtension(fileName)
            Dim randomName = $"{Guid.NewGuid().ToString()}" & fileExt
            Dim blockBlob = container.GetBlockBlobReference(randomName)
            'Sets the content type to image
            blockBlob.Properties.ContentType = contentType

            'Using File
            '    File.Position = 0
            '    blockBlob.UploadFromStream(File)
            '    File.Close()
            'End Using

            Return blockBlob.Uri.AbsoluteUri
        Catch ex As Exception
            Throw ex
        End Try
    End Function


End Class
