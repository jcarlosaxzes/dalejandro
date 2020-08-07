Public Class department_form
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                If Request.QueryString("DepartmentId") Is Nothing Then
                    ' Mode NEW
                    btnUpdate.Text = "Insert"
                Else
                    ' Mode EDIT
                    btnUpdate.Text = "Update"
                    lblDepartmentId.Text = Request.QueryString("DepartmentId")

                    If LocalAPI.IsCompanyViolation(lblDepartmentId.Text, "Company_Department", lblCompanyId.Text) Then Response.RedirectPermanent("~/adm/default.aspx")

                    ReadDepartmentInfo()

                End If

                'If Request.QueryString("FullPage") Is Nothing Then
                '    Master.HideMasterMenu()
                '    btnBack.Visible = False
                'End If
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub
    Private Sub ReadDepartmentInfo()
        Dim DepartmentInfo = LocalAPI.GetRecord(lblDepartmentId.Text, "Company_Department_SELECT")

        Try
            NameTextBox.Text = DepartmentInfo("Name")
            CodeTextBox.Text = DepartmentInfo("Code")
            DescriptionTextBox.Text = DepartmentInfo("Description")
            cboHead.DataBind()
            cboHead.SelectedValue = DepartmentInfo("Head")

            cboParent.DataBind()
            cboParent.SelectedValue = DepartmentInfo("ParentID")

            chkProductive.Checked = DepartmentInfo("Productive")
            ProposalStatusTrackingEmailTextBox.Text = DepartmentInfo("ProposalStatusTrackingEmail")
            BillingContactNameTextBox.Text = DepartmentInfo("BillingContactName")
            BillingContactEmailTextBox.Text = DepartmentInfo("BillingContactEmail")
        Catch ex As Exception
        End Try
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/departmentslist.aspx")
    End Sub
    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        If lblDepartmentId.Text > 0 Then
            SqlDataSource1.Update()
            Master.InfoMessage("Department was updated!")
        Else
            SqlDataSource1.Insert()
        End If
    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        Response.Redirect("~/adm/departmentslist.aspx")
    End Sub

End Class