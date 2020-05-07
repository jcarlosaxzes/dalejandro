Imports Telerik.Web.UI
Public Class client
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblClientId.Text = Request.QueryString("clientId")
                lblEmployee.Text = Master.UserEmail
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployee.Text, lblCompanyId.Text)
                Master.PageTitle = "Client List/Edit Client: " & LocalAPI.GetClientName(CInt(lblClientId.Text))

                FormView1.Enabled = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewClient")

                SqlDataSource1.DataBind()
                FormView1.DataBind()

            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Protected Sub FormView1_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormView1.ItemUpdated
        lblStatus.Text = "Updated Client Details: <b>" & LocalAPI.GetClientName(CInt(lblClientId.Text)) & "</b>"

        Try
            ' Update Latitude, Longitude
            LocalAPI.ClientGeolocationUpdate(lblClientId.Text)
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub FormView1_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles FormView1.ItemUpdating
        lblStatus.Text = ""
        e.NewValues("Subtype") = CType(FormView1.FindControl("cboSubtype"), RadComboBox).SelectedValue
        e.NewValues("TAGS") = CType(FormView1.FindControl("lblActualTAGS"), Label).Text + CType(FormView1.FindControl("cboTags"), RadAutoCompleteBox).Text
    End Sub

    Protected Sub btnUpdateClient1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            SqlDataSource1.Update()
        Catch ex As Exception
            lblStatus.Text = "Error. " & ex.Message

        End Try

    End Sub
    Public Function GetClientPhotoURL(clientId As Integer) As String
        Return LocalAPI.GetClientPhotoURL(clientId)
    End Function

    Private Sub FormView1_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles FormView1.ItemCommand
        Select Case e.CommandName
            Case "Photo"
                'Response.Redirect("~/ADM/EditAvatar.aspx?Id=" & lblClientId.Text & "&Entity=Client")
                Response.Redirect("~/ADM/UploadPhoto.aspx?Id=" & lblClientId.Text & "&Entity=Client")
        End Select
    End Sub

End Class
