Imports Telerik.Web.UI
Public Class contact1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblContactId.Text = Request.QueryString("ContactId")
                Master.PageTitle = "Contact/Edit Contact: " & LocalAPI.GetContactProperty(lblContactId.Text, "Name")

                FormView1.Enabled = LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewClient")
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Protected Sub FormView1_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles FormView1.ItemUpdating
        e.NewValues("Subtype") = CType(FormView1.FindControl("cboSubtype"), RadComboBox).SelectedValue
    End Sub
End Class
