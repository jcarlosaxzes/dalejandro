Imports Telerik.Web.UI
Public Class client
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblClientId.Text = Request.QueryString("clientId")

                'Not necessary, Client_Select include @companyId
                'If LocalAPI.IsCompanyViolation(lblClientId.Text, "Clients", lblCompanyId.Text) Then Response.RedirectPermanent("~/ADM/Default.aspx")

                If Not Request.QueryString("fromcontacts") Is Nothing Then
                    lblBackSource.Text = 1
                End If

                lblEmployee.Text = Master.UserEmail
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployee.Text, lblCompanyId.Text)
                Master.PageTitle = "Client List/Edit Client: " & LocalAPI.GetClientName(CInt(lblClientId.Text))

                FormView1.Enabled = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewClient")

                SqlDataSource1.DataBind()
                FormView1.DataBind()

                If Request.QueryString("FullPage") Is Nothing Then
                    Master.HideMasterMenu()
                    btnBack.Visible = False
                End If
            End If
            RadWindowManager1.EnableViewState = False
        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Protected Sub FormView1_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormView1.ItemUpdated
        Master.InfoMessage("Updated Client Record")

        Try
            ' Update Latitude, Longitude
            LocalAPI.ClientGeolocationUpdate(lblClientId.Text)
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub FormView1_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles FormView1.ItemUpdating
        e.NewValues("Subtype") = CType(FormView1.FindControl("cboSubtype"), RadComboBox).SelectedValue
        e.NewValues("TAGS") = CType(FormView1.FindControl("lblActualTAGS"), Label).Text + CType(FormView1.FindControl("cboTags"), RadAutoCompleteBox).Text
    End Sub

    Protected Sub btnUpdateClient1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            SqlDataSource1.Update()
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)

        End Try

    End Sub
    Public Function GetClientPhotoURL(clientId As Integer) As String
        Return LocalAPI.GetClientPhotoURL(clientId)
    End Function

    Private Sub FormView1_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles FormView1.ItemCommand
        Select Case e.CommandName
            Case "Photo"
                'Response.Redirect("~/ADM/UploadPhoto.aspx?Id=" & lblClientId.Text & "&Entity=Client")
                Dim sUrl As String = "~/ADM/UploadPhoto.aspx?Id=" & lblClientId.Text & "&Entity=Client"
                CreateRadWindows(e.CommandName, sUrl, 640, 400)

        End Select
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Back()
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

    Private Sub btnTotals_Click(sender As Object, e As EventArgs) Handles btnTotals.Click
        FormViewClientBalance.Visible = Not FormViewClientBalance.Visible
    End Sub

    Private Sub Back()
        If lblBackSource.Text = 1 Then
            Response.Redirect("~/adm/contacts.aspx?restoreFilter=true")
        Else
            Response.Redirect("~/adm/clients.aspx?restoreFilter=true")
        End If

    End Sub
End Class
