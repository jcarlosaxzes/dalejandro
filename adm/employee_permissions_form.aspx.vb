Imports Telerik.Web.UI
Public Class employee_permissions_form
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
            lblCompanyId.Text = Session("companyId")
            lblEmployeeId.Text = Request.QueryString("employeeId")
            lblEmployeeEmail.Text = LocalAPI.GetEmployeeEmail(lId:=lblEmployeeId.Text)
            lblEmployeeName.Text = LocalAPI.GetEmployeeFullName(lblEmployeeEmail.Text) & " " & LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "Role")
        End If
    End Sub
End Class
