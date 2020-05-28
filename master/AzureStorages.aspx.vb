﻿Imports System.Data.SqlClient

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
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Jobs_azureuploads] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname, cboCompany.SelectedValue)
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
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Proposals_azureuploads] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname, 0)
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
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Clients_azureuploads] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname, 0)
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

        Dim query As String = "SELECT TOP (" & txtCount.Text & ")  ru.[Id] ,[KeyName] ,[DesName] ,[FMove] FROM [dbo].RequestForProposals_azureuploads ru inner join [RequestForProposals] rp on (rp.Id = ru.requestforproposalId) inner join Jobs j on (rp.jobId = j.Id) where j.companyId  = " & cboCompany.SelectedValue & " and ISNULL(FMove,0) = 0 AND ISNULL(Deleted,0) = 0"


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
                        LocalAPI.ExecuteNonQuery($"update [dbo].[RequestForProposals_azureuploads] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname, 0)
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
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Invoices_payments] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
                        AzureStorageApi.DeleteFile(Keyname, 0)
                    Else
                        LocalAPI.ExecuteNonQuery($"update [dbo].[Invoices_payments] set DesName = 'NotFound', Fmove = 1 where Id = {Id}")
                    End If
                Else
                    LocalAPI.ExecuteNonQuery($"update [dbo].[Invoices_payments] set DesName = '{DesName}', Fmove = 1 where Id = {Id}")
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
End Class