
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
    Public Shared Function DeleteFile(ByVal KeyName As String, companyId As Integer) As Boolean
        Try
            Dim containerName As String = "documents"
            Dim storageAccount As CloudStorageAccount = CloudStorageAccount.Parse(GetConexion())
            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference(containerName)
            Dim blockBlob As CloudBlockBlob = container.GetBlockBlobReference(KeyName)
            blockBlob.FetchAttributes()
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

    Public Shared Function UploadFilesStream(file As Stream, KeyName As String, contentType As String, companyId As Integer) As String
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

            blockBlob.FetchAttributes()
            Return blockBlob.Uri.AbsoluteUri
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function CopyFile(SourceKeyName As String, DestinationKeyName As String, companyId As Integer) As Boolean
        Try
            Dim containerName As String = "documents"
            Dim storageAccount As CloudStorageAccount = CloudStorageAccount.Parse(GetConexion())
            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference(containerName)
            Dim sourceBlockBlob As CloudBlockBlob = container.GetBlockBlobReference(SourceKeyName)
            Dim destinationBlockBlob As CloudBlockBlob = container.GetBlockBlobReference(DestinationKeyName)
            destinationBlockBlob.StartCopy(sourceBlockBlob)

            sourceBlockBlob.FetchAttributes()
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function


    Public Shared Function UploadBytesData(fileName As String, fileData As Byte(), contentType As String) As String
        Try

            ' Create a BlobServiceClient object which will be used to create a container client
            Dim storageAccount As CloudStorageAccount = CloudStorageAccount.Parse(GetConexion())

            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference("documents")

            Dim blockBlob = container.GetBlockBlobReference(fileName)
            'Sets the content type to image
            blockBlob.Properties.ContentType = contentType
            blockBlob.UploadFromByteArray(fileData, 0, fileData.LongLength)
            Return blockBlob.Uri.AbsoluteUri
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function UploadBytesData(fileName As String, keyName As String, fileData As Byte(), contentType As String, companyId As String, EntityId As Integer, EntityType As String) As String
        Try

            ' Create a BlobServiceClient object which will be used to create a container client
            Dim storageAccount As CloudStorageAccount = CloudStorageAccount.Parse(GetConexion())

            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference("documents")

            Dim blockBlob = container.GetBlockBlobReference(keyName)
            'Sets the content type to image
            blockBlob.Properties.ContentType = contentType
            blockBlob.UploadFromByteArray(fileData, 0, fileData.LongLength)

            blockBlob.FetchAttributes()
            LocalAPI.AzureStorage_Insert(EntityId, 0, fileName, keyName, False, fileData.LongLength, contentType, companyId, EntityType)


            Return blockBlob.Uri.AbsoluteUri
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Shared Function DeleteDirectory(directory As String) As Boolean
        Try

            Dim storageAccount As CloudStorageAccount = CloudStorageAccount.Parse(GetConexion())
            Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
            Dim container As CloudBlobContainer = blobClient.GetContainerReference("documents")
            For Each blob As IListBlobItem In container.GetDirectoryReference(directory).ListBlobs(True)
                If TypeOf blob Is CloudBlob Then
                    CType(blob, CloudBlob).DeleteIfExists()
                End If
            Next

            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

End Class
