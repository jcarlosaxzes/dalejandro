﻿Imports Microsoft.AspNet.Identity

Public Class job_notes
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblJobId.Text = LocalAPI.GetJobIdFromGUID(Request.QueryString("guid"))

                lblEmployeeId.Text = Master.UserId
                Master.ActiveTab(5)
            End If


        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblJobId.Text)
        End Try
    End Sub
    Protected Sub btnNewNote_Click(sender As Object, e As EventArgs) Handles btnNewNote.Click
        RadGridNotes.MasterTableView.InsertItem()
    End Sub
    Protected Sub btnFindMessages_Click(sender As Object, e As EventArgs)
        RadGridMessages.DataBind()
    End Sub
End Class
