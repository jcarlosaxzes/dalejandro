Public Class masscommunication
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txtBody.Content = "Dear [UserName],"
        End If
    End Sub
    Private Sub btnSend_Click(sender As Object, e As EventArgs) Handles btnSend.Click
        Try
            Dim ToText = cboTo.Text
            cboTo.Text = "(Type Emails comma separated Or Select option:...)"
            Dim nRecs As Integer = LocalAPI.MasterMassCommunication(Val(cboTo.SelectedValue), txtSubject.Text, txtBody.Content.ToString, ToText)
            lblMailResult.Text = nRecs & " Emails were Sent"
        Catch ex As Exception
            lblMailResult.Text = "Error. " & ex.Message

        End Try
    End Sub
End Class
