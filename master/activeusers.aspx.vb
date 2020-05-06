Public Class activeusers
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Master.PageTitle = "Active User"
        End If
    End Sub

End Class