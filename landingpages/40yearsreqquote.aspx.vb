Imports System.Threading.Tasks
Imports Telerik.Web.UI
Public Class _40yearsreqquote
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            lblCompanyId.Text = "260962"        '260965
            lblProposalType40Years.Text = "4"   '111
        End If
    End Sub

    Private Sub SqlDataSourceInsertClient_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceInsertClient.Inserted
        Try

            Dim sBody As String = LocalAPI.GetMailTemplateFromHTML("mailEEG.html")
            Dim sClientBody As String = LocalAPI.GetMailTemplateFromHTML("client40Mail.html")
            Dim clientEmail As String = e.Command.Parameters(4).Value
            Dim clientName As String = e.Command.Parameters(1).Value
            clientName = Left(UCase(clientName), 1) & Mid(clientName, 2)
            sClientBody = Replace(sClientBody, "#user#", clientName)

            Task.Run(Function() LocalAPI.SendMail40year(clientEmail, "", "lilliam@axzes.com", "EEG. 40 Years Request", sClientBody))

            Dim FullAddress As String = e.Command.Parameters(5).Value & " " & e.Command.Parameters(6).Value & ", " & e.Command.Parameters(7).Value & " " & e.Command.Parameters(8).Value
            sBody = Replace(sBody, "#fullAddress#", FullAddress)

            Task.Run(Function() LocalAPI.SendMail40year("fernando@easterneg.com", "sandra@easterneg.com,Ilianette@easterneg.com,info@easterneg.com", "lilliam@axzes.com", "40 Years Landingpage. New Request", sBody))

            'Response.Write("<script> window.open('http://www.easternengineeringgroup.com/thank-you-40-year/', '_parent'); </script>")

        Catch ex As Exception

        End Try
    End Sub

    Private Sub SqlDataSourceInsertClient_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceInsertClient.Inserting
        FormViewUser.Enabled = True
        Response.Write("<script> window.open('http://www.easternengineeringgroup.com/thank-you-40-year/', '_parent'); </script>")
    End Sub
End Class


