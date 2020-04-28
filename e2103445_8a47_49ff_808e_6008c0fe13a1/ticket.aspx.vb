Public Class ticket1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then

            If Not Request.QueryString("guid") Is Nothing Then
                lbljobGUID.Text = Request.QueryString("guid")
                lblJobId.Text = LocalAPI.GetJobIdFromGUID(lbljobGUID.Text)
                urlPublicLink.DataBind()

                lblCompanyId.Text = LocalAPI.GetJobProperty(lblJobId.Text, "companyId")
                lblJob.Text = LocalAPI.GetJobCodeName(lblJobId.Text)

                ' client-GUID to Header Master Page
                Session("CLIENTPORTAL_clientId") = LocalAPI.GetJobProperty(lblJobId.Text, "Client")
                Master.Company = lblCompanyId.Text

                If Not Request.QueryString("TicketId") Is Nothing Then
                    lblTicketId.Text = Request.QueryString("TicketId")
                    lblEmployeeId.Text = LocalAPI.GetTicketProperty(lblTicketId.Text, "employeeId")
                End If

            End If
        End If
    End Sub

    Private Sub SqlDataSource1_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Updated
        ' Notify Project Manager
        LocalAPI.SendTicketNotificationToEmployee(lblJobId.Text, lblTicketId.Text, lblCompanyId.Text, "for a Client.")
    End Sub

    Public Function GetJobGUID() As String
        Return "../../e2103445_8a47_49ff_808e_6008c0fe13a1/tickets.aspx?guid=" & LocalAPI.GetJobProperty(lblJobId.Text, "guid")
    End Function

End Class
