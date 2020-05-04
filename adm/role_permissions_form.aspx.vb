Public Class role_permissions_form
    Inherits System.Web.UI.Page

    Protected Property SuccessMessageText() As String
        Get
            Return m_SuccessMessage
        End Get
        Private Set(value As String)
            m_SuccessMessage = value
            successMessage.Visible = Not [String].IsNullOrEmpty(value)
        End Set
    End Property
    Private m_SuccessMessage As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            lblRoleId.Text = Request.QueryString("roleId")
            FormView1.DataBind()
        End If
    End Sub

    Private Sub SqlDataSource1_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles SqlDataSource1.Selecting
        e.Command.Parameters("@Id").Value = lblRoleId.Text
    End Sub
End Class
