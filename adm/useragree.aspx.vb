Imports Microsoft.AspNet.Identity

Public Class useragree
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then

            If LocalAPI.IAgree(Context.User.Identity.GetUserName()) Then
                Response.RedirectPermanent("~/adm/dashboard.aspx")
            Else
                lblTerms.Text = ReadFile(Server.MapPath("~/Legal/ENG/Terms.html"))
            End If

        End If
    End Sub

    Protected Function ReadFile(path As String) As String
        If Not System.IO.File.Exists(path) Then
            Return String.Empty
        End If

        Using sr As New System.IO.StreamReader(path)
            Return sr.ReadToEnd()
        End Using
    End Function


    Protected Sub btnDISAGREE_Click(sender As Object, e As EventArgs) Handles btnDISAGREE.Click
        LocalAPI.SetIDisagree(Context.User.Identity.GetUserName())
        Context.GetOwinContext().Authentication.SignOut()
        Session.Abandon()
        Response.RedirectPermanent(LocalAPI.GetHostAppSite())
    End Sub

    Protected Sub btnAGREE_Click(sender As Object, e As EventArgs) Handles btnAGREE.Click
        LocalAPI.SetIAgree(Context.User.Identity.GetUserName())
        Response.RedirectPermanent("~/ADM/Start.aspx")
    End Sub

    Protected Sub btnREADLATER_Click(sender As Object, e As EventArgs) Handles btnREADLATER.Click
        Dim sEmail As String = Context.User.Identity.GetUserName()
        If LocalAPI.GetIReadLater(sEmail) > 5 Then
            Session.Abandon()
            System.Web.Security.FormsAuthentication.SignOut()
            Response.RedirectPermanent(LocalAPI.GetHostAppSite())
        Else
            LocalAPI.SetIReadLater(sEmail)
            Session("ReadLater") = "1"
            Response.RedirectPermanent("~/ADM/Start.aspx")
        End If
    End Sub


End Class