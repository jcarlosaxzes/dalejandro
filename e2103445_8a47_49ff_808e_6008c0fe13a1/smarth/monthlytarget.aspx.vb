Public Class monthlytarget
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Monthly Target"

            If (Not Page.IsPostBack) Then
                If Not Request.QueryString("GuiId") Is Nothing Then
                    Session("CompanyGUID") = Request.QueryString("GuiId")
                    'Session("CompanyGUID") = "a454d8ed-d27d-4d12-88fa-426a02615e1a"  '!!!!EEG  
                End If
                lblCompanyId.Text = LocalAPI.GetCompanyIdFromGUID("" & Session("CompanyGUID"))
                lblTitle.Text = LocalAPI.GetCompanyName(lblCompanyId.Text)
            End If
        Catch ex As Exception

        End Try
    End Sub

End Class