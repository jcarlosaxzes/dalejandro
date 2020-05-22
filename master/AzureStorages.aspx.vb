Imports System.Data.SqlClient

Public Class AzureStorages
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim connection = LocalAPI.GetConnection()

        Dim query As String = "SELECT TOP (" & txtCount.Text & ") a.[Id] ,[KeyName] ,[DesName] ,[FMove] FROM [dbo].[Jobs_azureuploads] a inner join Jobs j on (a.jobId = j.Id) where j.companyId = " & txtCompanyId.Text & "and Fmove = 0 AND ISNULL(Deleted,0) = 0"


        Dim command As SqlCommand = New SqlCommand(query, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()
        Dim totla = 0
        Dim startTime = DateTime.Now
        If reader.HasRows Then
            While reader.Read()
                Dim Keyname = reader.GetString(1)
                Dim Id = reader.GetInt32(0)
                Dim DesName = "Companies/" & txtCompanyId.Text & "/" & IO.Path.GetFileName(Keyname)
                If Keyname <> DesName Then
                    If AzureStorageApi.CopyFile(Keyname, DesName) Then
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Jobs_azureuploads] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname)
                    Else
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Jobs_azureuploads] set DesName = 'NotFound', Fmove = 1 where Id = {Id}")
                    End If
                Else
                    LocalAPI.ExecuteNonQuery($"update [dbo].[Jobs_azureuploads] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
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

        Dim query As String = "SELECT TOP (" & txtCount.Text & ") pu.[Id] ,[KeyName] ,[DesName] ,[FMove] FROM [dbo].[Proposals_azureuploads] pu inner join Proposal p on (pu.proposalId = p.Id) inner join Clients c on (c.Id = p.ClientId) where c.companyId  = " & txtCompanyId.Text & "and FMove = 0 AND ISNULL(Deleted,0) = 0"


        Dim command As SqlCommand = New SqlCommand(query, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()
        Dim totla = 0
        Dim startTime = DateTime.Now
        If reader.HasRows Then
            While reader.Read()
                Dim Keyname = reader.GetString(1)
                Dim Id = reader.GetInt32(0)
                Dim DesName = "Companies/" & txtCompanyId.Text & "/" & IO.Path.GetFileName(Keyname)
                If Keyname <> DesName Then
                    If AzureStorageApi.CopyFile(Keyname, DesName) Then
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Proposals_azureuploads] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname)
                    Else
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Proposals_azureuploads] set DesName = 'NotFound', Fmove = 1 where Id = {Id}")
                    End If
                Else
                    LocalAPI.ExecuteNonQuery($"update [dbo].[Proposals_azureuploads] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
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

        Dim query As String = "SELECT TOP (" & txtCount.Text & ") cu.[Id] ,[KeyName] ,[DesName] ,[FMove] FROM [dbo].Clients_azureuploads cu inner join Clients c on (c.Id = cu.ClientId) where c.companyId  = " & txtCompanyId.Text & "and FMove = 0 AND ISNULL(Deleted,0) = 0"


        Dim command As SqlCommand = New SqlCommand(query, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()
        Dim totla = 0
        Dim startTime = DateTime.Now
        If reader.HasRows Then
            While reader.Read()
                Dim Keyname = reader.GetString(1)
                Dim Id = reader.GetInt32(0)
                Dim DesName = "Companies/" & txtCompanyId.Text & "/" & IO.Path.GetFileName(Keyname)
                If Keyname <> DesName Then
                    If AzureStorageApi.CopyFile(Keyname, DesName) Then
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Clients_azureuploads] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname)
                    Else
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Clients_azureuploads] set DesName = 'NotFound', Fmove = 1 where Id = {Id}")
                    End If
                Else
                    LocalAPI.ExecuteNonQuery($"update [dbo].[Clients_azureuploads] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
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

        Dim query As String = "SELECT TOP (" & txtCount.Text & ")  ru.[Id] ,[KeyName] ,[DesName] ,[FMove] FROM [dbo].RequestForProposals_azureuploads ru inner join [RequestForProposals] rp on (rp.Id = ru.requestforproposalId) inner join Jobs j on (rp.jobId = j.Id) where j.companyId  = " & txtCompanyId.Text & "and FMove = 0 AND ISNULL(Deleted,0) = 0"


        Dim command As SqlCommand = New SqlCommand(query, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()
        Dim totla = 0
        Dim startTime = DateTime.Now
        If reader.HasRows Then
            While reader.Read()
                Dim Keyname = reader.GetString(1)
                Dim Id = reader.GetInt32(0)
                Dim DesName = "Companies/" & txtCompanyId.Text & "/" & IO.Path.GetFileName(Keyname)
                If Keyname <> DesName Then
                    If AzureStorageApi.CopyFile(Keyname, DesName) Then
                        LocalAPI.ExecuteNonQuery($"update [dbo].[RequestForProposals_azureuploads] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname)
                    Else
                        LocalAPI.ExecuteNonQuery($"update [dbo].[RequestForProposals_azureuploads] set DesName = 'NotFound', Fmove = 1 where Id = {Id}")
                    End If
                Else
                    LocalAPI.ExecuteNonQuery($"update [dbo].[RequestForProposals_azureuploads] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
                End If
                totla += 1
            End While
        Else
        End If
        reader.Close()
        Dim EndTime = DateTime.Now()
        lblrfproporsal.Text = "Start: " & startTime.ToLongTimeString() & "   End: " & EndTime.ToLongTimeString() & "  Totla:" & totla
    End Sub
End Class