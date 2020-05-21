Public Class register1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Not Request.QueryString("Version") Is Nothing Then
                lblVersion.Text = Val(Request.QueryString("Version"))
            Else
                lblVersion.Text = 0
            End If
            lblVersinoName.Text = "Register for " & LocalAPI.sys_VersionName(lblVersion.Text) & " version"

            'If Not Request.QueryString("Email") Is Nothing Then
            '    txtEmail.Text = Request.QueryString("Email")
            '    SqlDataSource1.Insert()
            'End If

        End If
    End Sub

    Protected Sub btbCreate_Click(sender As Object, e As EventArgs) Handles btbCreate.Click
        If RadCaptcha1.IsValid Then
            ' Insert preuser
            SqlDataSource1.Insert()
        End If
    End Sub

    Protected Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        Try

            Dim sGUID As String = e.Command.Parameters("@GUID_OUT").Value.ToString
            If sGUID.Length > 0 Then
                SendConfirmationEmail(sGUID)
            Else
                lblMsg.Text = "Register error"
            End If
        Catch ex As Exception
            lblMsg.Text = ex.Message
        End Try
    End Sub
    Private Sub SendConfirmationEmail(sGUID As String)
        ' Componer el Body
        Dim sMsg As New System.Text.StringBuilder
        sMsg.Append("Welcome to PASconcept!")
        sMsg.Append("<br />")
        sMsg.Append("<br />")
        sMsg.Append("To activate your account and begin using PASconcept, please click the following link:")
        sMsg.Append("<br />")
        sMsg.Append("<br />")
        sMsg.Append("<a href=" & """" & LocalAPI.GetHostAppSite() & "/RegisterEnd.aspx?Id=" & sGUID & """" & ">PASconcept setup</a>")
        sMsg.Append("<br />")
        sMsg.Append("<br />")
        sMsg.Append("<br />")
        sMsg.Append(LocalAPI.GetPASShortSign())

        If SendGrid.Email.SendMail(txtEmail.Text, "", ConfigurationManager.AppSettings("FromPASconceptEmail"), "PASconcept registration", sMsg.ToString, -1) Then
            Response.RedirectPermanent("~/RegisterConfirm.aspx?Step=2")
        End If
    End Sub
End Class
