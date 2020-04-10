Imports Telerik.Web.UI
Public Class subconsultants
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_SubconsultantsList") Then Response.RedirectPermanent("~/ADM/Default.aspx")
            ' Si no tiene permiso New, boton.Visible=False
            btnNewSubconsultant.Visible = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewSubconsultant")

            Master.PageTitle = "Subconsultants/Subconsultants List"
            Master.Help = "http://blog.pasconcept.com/2012/07/subconsultants-list.html"
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Subconsultants List"
            lblEmployee.Text = Master.UserEmail
            lblCompanyId.Text = Session("companyId")
        End If
        RadWindowManager1.EnableViewState = False

    End Sub

    Protected Sub btnCredentials_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim id As String = CType(sender, ImageButton).CommandArgument

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)

        End Try


    End Sub

    Protected Sub btnFind_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFind.Click
        RadGrid1.DataBind()
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditSubconsultant"
                sUrl = "~/ADM/Subconsultant.aspx?subconsultantId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 850, 700)

            Case "SendCredential"
                Master.InfoMessage("Sending credentials ... please wait")
                Dim sEmail As String = LocalAPI.GetSubConsultanEmail(e.CommandArgument)
                If sEmail.Length > 0 Then
                    ' !!! old subconsultant Portal 
                    '    LocalAPI.RefrescarUsuarioVinculado(sEmail, "Subconsultans")
                    '    If LocalAPI.SubConsultanEmailCredentials(e.CommandArgument, lblCompanyId.Text) Then
                    '        Master.InfoMessage("The Subconsultant Credentials have been sent by email")
                    '    End If
                    LocalAPI.SubConsultanEmailPrivateLink(e.CommandArgument, lblCompanyId.Text)
                End If
        End Select
    End Sub

    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer)
        RadWindowManager1.Windows.Clear()
        Dim window1 As RadWindow = New RadWindow()
        window1.NavigateUrl = sUrl
        window1.VisibleOnPageLoad = True
        window1.VisibleStatusbar = False
        window1.ID = WindowsID
        'window1.InitialBehaviors = WindowBehaviors.Maximize
        window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
        window1.Width = Width
        window1.Height = Height
        window1.Modal = True
        window1.OnClientClose = "OnClientClose"
        RadWindowManager1.Windows.Add(window1)
    End Sub

    Protected Sub btnNewSubconsultant_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewSubconsultant.Click
        CreateRadWindows("NewSubconsultant", "~/ADM/NewSubConsultant.aspx", 850, 700)
    End Sub

End Class

