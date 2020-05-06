Imports System.IO

Public Class tandcedit
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Master.PageTitle = "Term & Conditions"
            If Not Page.IsPostBack Then
                RadEditor1.Content = ReadFile(Server.MapPath("~/Legal/ENG/Terms.html"))
            End If
        End If
    End Sub

    Protected Function ReadFile(path As String) As String
        If Not System.IO.File.Exists(path) Then
            Return String.Empty
        End If

        Using sr As New System.IO.StreamReader(path)
            Return sr.ReadToEnd()
        End Using
    End Function

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Using externalFile As New StreamWriter(Server.MapPath("~/Legal/ENG/Terms.html"), False, Encoding.UTF8)

            externalFile.Write(RadEditor1.Content)
        End Using
    End Sub
End Class
