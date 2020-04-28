Public Class jobprogressrollup
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try

            If Not IsPostBack Then

                Dim invoiceguiId As String = ""
                Dim jobguiId As String = ""

                ' Dos posible entradas, job-GUID or Invoice-GUID
                If Not Request.QueryString("jobguid") Is Nothing Then
                    jobguiId = Request.QueryString("jobguid")
                Else
                    If Not Request.QueryString("invoiceguiId") Is Nothing Then
                        invoiceguiId = Request.QueryString("invoiceguiId")
                    End If
                End If

                '!!!!! test
                'jobguiId = "62CCAAA6-F297-47C2-8111-D9C74B684456"

                If Len(jobguiId) > 0 Then
                    llJobId.Text = LocalAPI.GetSharedLink_Id(7, jobguiId)
                Else
                    ' Datos desde el invoiceguid
                    Dim invoiceId As Integer = LocalAPI.GetSharedLink_Id(4, invoiceguiId)
                    llJobId.Text = LocalAPI.GetInvoiceProperty(invoiceId, "jobId")
                End If

                lblCompanyId.Text = LocalAPI.GetJobProperty(llJobId.Text, "companyId")
                Master.Company = lblCompanyId.Text

                Title = LocalAPI.GetJobCode(llJobId.Text)

                ' Para navegar en CLIENT PORTAL.....................................
                Session("CLIENTPORTAL_clientId") = LocalAPI.GetJobProperty(llJobId.Text, "Client")

            End If
        Catch ex As Exception

        End Try

    End Sub
End Class
