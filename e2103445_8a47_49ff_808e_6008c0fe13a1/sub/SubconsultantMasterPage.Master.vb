Public Class SubconsultantMasterPage
    Inherits System.Web.UI.MasterPage

    Public WriteOnly Property Company() As String
        Set(ByVal value As String)
            lblCompanyId.Text = value
            FormViewCompany.DataBind()
            Panels()
        End Set
    End Property

    Private Sub Panels()
        CType(FormViewCompany.FindControl("pnl_advertising"), Panel).Visible = False '(lblCompanyId.Text = 260962)
        pnl_reviews.Visible = (lblCompanyId.Text = 260962)
    End Sub



    Public Sub ErrorMessage(ByVal sText As String, Optional ByVal SecondsAutoCloseDelay As Integer = 0)
        If sText.Length > 0 Then
            RadNotificationError.Title = "Error message"
            RadNotificationError.Text = sText
            RadNotificationError.AutoCloseDelay = SecondsAutoCloseDelay * 1000
            RadNotificationError.Show()
        End If
    End Sub

    Public Sub InfoMessage(ByVal sText As String, Optional ByVal SecondsAutoCloseDelay As Integer = 3)
        If sText.Length > 0 Then
            RadNotificationWarning.Title = "Info message"
            RadNotificationWarning.Text = sText
            RadNotificationWarning.AutoCloseDelay = SecondsAutoCloseDelay * 1000
            RadNotificationWarning.Show()
        End If
    End Sub
End Class



