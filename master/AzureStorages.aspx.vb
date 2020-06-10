Imports System.Data.SqlClient
Imports Microsoft.Azure.Storage
Imports Microsoft.Azure.Storage.Blob

Public Class AzureStorages
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim connection = LocalAPI.GetConnection()

        Dim query As String = "SELECT TOP (" & txtCount.Text & ") a.[Id] ,[KeyName] ,[DesName] ,[FMove] FROM [dbo].[Jobs_azureuploads] a inner join Jobs j on (a.jobId = j.Id) where j.companyId = " & cboCompany.SelectedValue & " and ISNULL(FMove,0) = 0 AND ISNULL(Deleted,0) = 0"


        Dim command As SqlCommand = New SqlCommand(query, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()
        Dim totla = 0
        Dim startTime = DateTime.Now
        If reader.HasRows Then
            While reader.Read()
                Dim Keyname = reader.GetString(1)
                Dim Id = reader.GetInt32(0)
                Dim DesName = "Companies/" & cboCompany.SelectedValue & "/" & IO.Path.GetFileName(Keyname)
                If Keyname <> DesName Then
                    If AzureStorageApi.CopyFile(Keyname, DesName, 0) Then
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Jobs_azureuploads] set KeyName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname, cboCompany.SelectedValue)
                    Else
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Jobs_azureuploads] set DesName = 'NotFound', Fmove = 1 where Id = {Id}")
                    End If
                Else
                    LocalAPI.ExecuteNonQuery($"update [dbo].[Jobs_azureuploads] set KeyName = '{DesName}', Fmove = 1 where Id = {Id}")
                End If
                totla += 1
            End While
        Else
        End If
        reader.Close()
        Dim EndTime = DateTime.Now()
        lbResutl.Text = "Start: " & startTime.ToLongTimeString() & "   End: " & EndTime.ToLongTimeString() & "  Totla:" & totla
    End Sub

    Protected Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click

        Dim connection = LocalAPI.GetConnection()

        Dim query As String = "SELECT TOP (" & txtCount.Text & ") pu.[Id] ,[KeyName] ,[DesName] ,[FMove] FROM [dbo].[Proposals_azureuploads] pu inner join Proposal p on (pu.proposalId = p.Id) inner join Clients c on (c.Id = p.ClientId) where c.companyId  = " & cboCompany.SelectedValue & "  and ISNULL(FMove,0) = 0 AND ISNULL(Deleted,0) = 0"


        Dim command As SqlCommand = New SqlCommand(query, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()
        Dim totla = 0
        Dim startTime = DateTime.Now
        If reader.HasRows Then
            While reader.Read()
                Dim Keyname = reader.GetString(1)
                Dim Id = reader.GetInt32(0)
                Dim DesName = "Companies/" & cboCompany.SelectedValue & "/" & IO.Path.GetFileName(Keyname)
                If Keyname <> DesName Then
                    If AzureStorageApi.CopyFile(Keyname, DesName, 0) Then
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Proposals_azureuploads] set KeyName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname, 0)
                    Else
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Proposals_azureuploads] set DesName = 'NotFound', Fmove = 1 where Id = {Id}")
                    End If
                Else
                    LocalAPI.ExecuteNonQuery($"update [dbo].[Proposals_azureuploads] set KeyName = '{DesName}', Fmove = 1 where Id = {Id}")
                End If
                totla += 1
            End While
        Else
        End If
        reader.Close()
        Dim EndTime = DateTime.Now()
        lblProposal.Text = "Start: " & startTime.ToLongTimeString() & "   End: " & EndTime.ToLongTimeString() & "  Totla:" & totla
    End Sub

    Protected Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click

        Dim connection = LocalAPI.GetConnection()

        Dim query As String = "SELECT TOP (" & txtCount.Text & ") cu.[Id] ,[KeyName] ,[DesName] ,[FMove] FROM [dbo].Clients_azureuploads cu inner join Clients c on (c.Id = cu.ClientId) where c.companyId  = " & cboCompany.SelectedValue & " and ISNULL(FMove,0) = 0 AND ISNULL(Deleted,0) = 0"


        Dim command As SqlCommand = New SqlCommand(query, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()
        Dim totla = 0
        Dim startTime = DateTime.Now
        If reader.HasRows Then
            While reader.Read()
                Dim Keyname = reader.GetString(1)
                Dim Id = reader.GetInt32(0)
                Dim DesName = "Companies/" & cboCompany.SelectedValue & "/" & IO.Path.GetFileName(Keyname)
                If Keyname <> DesName Then
                    If AzureStorageApi.CopyFile(Keyname, DesName, 0) Then
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Clients_azureuploads] set KeyName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname, 0)
                    Else
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Clients_azureuploads] set DesName = 'NotFound', Fmove = 1 where Id = {Id}")
                    End If
                Else
                    LocalAPI.ExecuteNonQuery($"update [dbo].[Clients_azureuploads] set KeyName = '{DesName}', Fmove = 1 where Id = {Id}")
                End If
                totla += 1
            End While
        Else
        End If
        reader.Close()
        Dim EndTime = DateTime.Now()
        lblCliet.Text = "Start: " & startTime.ToLongTimeString() & "   End: " & EndTime.ToLongTimeString() & "  Totla:" & totla
    End Sub

    Protected Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Dim connection = LocalAPI.GetConnection()

        Dim query As String = "SELECT TOP (" & txtCount.Text & ")  ru.[Id] ,[KeyName] ,[DesName] ,[FMove] FROM [dbo].RequestForProposals_azureuploads ru inner join [RequestForProposals] rp on (rp.Id = ru.requestforproposalId) where rp.companyId  = " & cboCompany.SelectedValue & " and ISNULL(FMove,0) = 0 AND ISNULL(Deleted,0) = 0"


        Dim command As SqlCommand = New SqlCommand(query, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()
        Dim totla = 0
        Dim startTime = DateTime.Now
        If reader.HasRows Then
            While reader.Read()
                Dim Keyname = reader.GetString(1)
                Dim Id = reader.GetInt32(0)
                Dim DesName = "Companies/" & cboCompany.SelectedValue & "/" & IO.Path.GetFileName(Keyname)
                If Keyname <> DesName Then
                    If AzureStorageApi.CopyFile(Keyname, DesName, 0) Then
                        LocalAPI.ExecuteNonQuery($"update [dbo].[RequestForProposals_azureuploads] set KeyName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname, 0)
                    Else
                        Dim old = "old_2016/" & IO.Path.GetFileName(Keyname)
                        If AzureStorageApi.CopyFile(old, DesName, 0) Then
                            LocalAPI.ExecuteNonQuery($"update [dbo].[RequestForProposals_azureuploads] set KeyName = '{DesName}', Fmove = 1 where Id = {Id}")
                            AzureStorageApi.DeleteFile(old, 0)
                        Else
                            LocalAPI.ExecuteNonQuery($"update [dbo].[RequestForProposals_azureuploads] set DesName = 'NotFound', Fmove = 1 where Id = {Id}")
                        End If

                    End If
                Else
                    LocalAPI.ExecuteNonQuery($"update [dbo].[RequestForProposals_azureuploads] set KeyName = '{DesName}', Fmove = 1 where Id = {Id}")
                End If
                totla += 1
            End While
        Else
        End If
        reader.Close()
        Dim EndTime = DateTime.Now()
        lblrfproporsal.Text = "Start: " & startTime.ToLongTimeString() & "   End: " & EndTime.ToLongTimeString() & "  Totla:" & totla
    End Sub

    Protected Sub Invoices_payment_Click(sender As Object, e As EventArgs) Handles Invoices_payment.Click
        Dim connection = LocalAPI.GetConnection()

        Dim query As String = "SELECT TOP (" & txtCount.Text & ")  invp.[Id] ,[KeyName] ,[DesName] ,[FMove] FROM [dbo].[Invoices_payments] invp inner join Invoices inv on( invp.InvoiceId = inv.Id) inner join Jobs j on (inv.jobId = j.Id) where j.companyId = " & cboCompany.SelectedValue & " and ISNULL(FMove,0) = 0 AND KeyName is not null AND ISNULL(Deleted,0) = 0"


        Dim command As SqlCommand = New SqlCommand(query, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()
        Dim totla = 0
        Dim startTime = DateTime.Now
        If reader.HasRows Then
            While reader.Read()
                Dim Keyname = reader.GetString(1)
                Dim Id = reader.GetInt32(0)
                Dim DesName = "Companies/" & cboCompany.SelectedValue & "/" & IO.Path.GetFileName(Keyname)
                If Keyname <> DesName Then
                    If AzureStorageApi.CopyFile(Keyname, DesName, 0) Then
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Invoices_payments] set KeyName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname, 0)
                    Else
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Invoices_payments] set DesName = 'NotFound', Fmove = 1 where Id = {Id}")
                    End If
                Else
                    LocalAPI.ExecuteNonQuery($"update [dbo].[Invoices_payments] set KeyName = '{DesName}', Fmove = 1 where Id = {Id}")
                End If
                totla += 1
            End While
        Else
        End If
        reader.Close()
        Dim EndTime = DateTime.Now()
        lblInvoice_payment.Text = "Start: " & startTime.ToLongTimeString() & "   End: " & EndTime.ToLongTimeString() & "  Totla:" & totla
    End Sub

    Protected Sub Button5_Click(sender As Object, e As EventArgs) Handles Button5.Click
        Dim connection = LocalAPI.GetConnection()

        Dim query As String = "SELECT  TOP (" & txtCount.Text & ")  [KeyName] from dbo.For_Delete_Files"


        Dim command As SqlCommand = New SqlCommand(query, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()
        Dim totla = 0
        Dim startTime = DateTime.Now
        If reader.HasRows Then
            While reader.Read()
                Try
                    Dim Keyname = reader.GetString(0)
                    LocalAPI.ExecuteNonQuery($"delete from  For_Delete_Files where KeyName = '{Keyname}'")
                    AzureStorageApi.DeleteFile(Keyname, 0)
                    totla += 1
                Catch ex As Exception
                End Try

            End While
        Else
        End If
        reader.Close()
        Dim EndTime = DateTime.Now()
        lblInvoice_payment.Text = "Start: " & startTime.ToLongTimeString() & "   End: " & EndTime.ToLongTimeString() & "  Totla:" & totla
    End Sub

    Protected Sub move2016_Click(sender As Object, e As EventArgs) Handles move2016.Click

        Dim containerName As String = "documents"
        Dim storageAccount As CloudStorageAccount = CloudStorageAccount.Parse(AzureStorageApi.GetConexion())
        Dim blobClient As CloudBlobClient = storageAccount.CreateCloudBlobClient()
        Dim container As CloudBlobContainer = blobClient.GetContainerReference(containerName)

        Dim startTime = DateTime.Now
        Dim count As Integer = 0
        Dim blobDirectory As CloudBlobDirectory = container.GetDirectoryReference("2016")
        Dim blobList As IEnumerable(Of IListBlobItem) = blobDirectory.ListBlobs()
        For Each blobItem As IListBlobItem In blobList
            If blobItem.GetType() = GetType(CloudBlockBlob) Then
                Dim blob As CloudBlockBlob = DirectCast(blobItem, CloudBlockBlob)
                Dim DesName = "old_2016/" & IO.Path.GetFileName(blob.Name)
                Dim destinationBlockBlob As CloudBlockBlob = container.GetBlockBlobReference(DesName)
                destinationBlockBlob.StartCopy(blob)
                blob.DeleteIfExists()
                count += 1
                If count > CType(txtCount.Text, Integer) Then
                    Return
                End If
            End If

        Next
        Dim EndTime = DateTime.Now()
        lblmove.Text = "Start: " & startTime.ToLongTimeString() & "   End: " & EndTime.ToLongTimeString() & "  Totla:" & count
        'Dim sourceBlockBlob As CloudBlockBlob = container.GetBlockBlobReference(SourceKeyName)
        'Dim destinationBlockBlob As CloudBlockBlob = container.GetBlockBlobReference(DestinationKeyName)
        'destinationBlockBlob.StartCopy(sourceBlockBlob)
    End Sub
End Class