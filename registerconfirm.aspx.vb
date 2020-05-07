Public Class registerconfirm
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Select Case Request.QueryString("Step")
                Case 2
                    lblTitle.Text = "Thank you for registering with PASconcept"
                    lblMsg.Text = "You will receive a verification email to complete your registration"
                    lnkBegin.Visible = False
                Case 4
                    lblTitle.Text = "Registration completed"
                    lblMsg.Text = "You have successfully completed the process. <br/>To start working with PASconcept, "
                    lnkBegin.Visible = True
                Case 5
                    lblTitle.Text = "Recover PASconcept"
                    lblMsg.Text = "You will receive an email, to complete the recovery password"
                    lnkBegin.Visible = False
                Case 6
                    lblTitle.Text = "The Recover Password has been completed"
                    lblMsg.Text = "To start working with PASconcept, "
                    lnkBegin.Visible = True
                Case Else
                    Response.Redirect("http://pasconcept.com/")
            End Select
        End If
    End Sub
End Class
