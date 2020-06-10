Public Class ope_project
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Not Request.QueryString("guId") Is Nothing Then
                lblGUID.Text = Request.QueryString("guId")
                lblJobId.Text = LocalAPI.GetJobIdFromGUID(lblGUID.Text)
                'lblJobId.Text = Request.QueryString("Id")
                'AnalisisGUID(Request.QueryString("guId"), lblJobId.Text)
                Me.Title = LocalAPI.GetJobName(lblJobId.Text)
                Me.MetaDescription = LocalAPI.GetJobProperty(lblJobId.Text, "Description")

                RadDataForm1.DataBind()
                'If Request.QueryString("Back") Is Nothing Then
                '    CType(RadDataForm1.Items(0).FindControl("btnBak"), RadButton).Visible = False
                'End If
            End If
        End If
    End Sub

    Private Sub AnalisisGUID(guid As String, JobId As Integer)
        If guid = "a454d8ed-d27d-2609-1962-426a02615e1a" Then
            ' Interno 
            Dim companyId As Integer = LocalAPI.GetJobProperty(JobId, "companyId")
            'lblCompanyGUID.Text = LocalAPI.GetCompanyGUID(companyId)
        Else
            'lblCompanyGUID.Text = guid
        End If
    End Sub

End Class