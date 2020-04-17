Imports Telerik.Web.UI
Public Class job_tags
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblJobId.Text = Request.QueryString("JobId")

                Dim DepartmentId As Integer = LocalAPI.GetJobProperty(lblJobId.Text, "DepartmentId")
                If DepartmentId > 0 Then
                    cboDepartments.DataBind()
                    cboDepartments.SelectedValue = DepartmentId
                    FillDepartmentTagCategoryLabels()
                End If


                SqlDataSourceCRUD.DataBind()

            End If


        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Protected Sub btnAddTags_Click(sender As Object, e As EventArgs) Handles btnAddTags.Click

        lblTag.Text = ""

        If cboPreExistingTags.SelectedValue <> "-1" Then
            lblTag.Text = cboPreExistingTags.Text
        Else
            ' sumar Tags de Categorias seleccionadas
            If cboTagCat0.SelectedValue > 0 Then
                lblTag.Text = cboTagCat0.Text & "-"
                cboTagCat0.SelectedValue = -1
            End If
            If cboTagCat1.SelectedValue > 0 Then
                lblTag.Text = lblTag.Text & cboTagCat1.Text & "-"
                cboTagCat1.SelectedValue = -1
            End If
            If cboTagCat2.SelectedValue > 0 Then
                lblTag.Text = lblTag.Text & cboTagCat2.Text & "-"
                cboTagCat2.SelectedValue = -1
            End If
            If cboTagCat3.SelectedValue > 0 Then
                lblTag.Text = lblTag.Text & cboTagCat3.Text & "-"
                cboTagCat3.SelectedValue = -1
            End If
            If cboTagCat4.SelectedValue > 0 Then
                lblTag.Text = lblTag.Text & cboTagCat4.Text & "-"
                cboTagCat4.SelectedValue = -1
            End If
            If cboTagCat5.SelectedValue > 0 Then
                lblTag.Text = lblTag.Text & cboTagCat5.Text & "-"
                cboTagCat5.SelectedValue = -1
            End If
            If cboTagCat6.SelectedValue > 0 Then
                lblTag.Text = lblTag.Text & cboTagCat6.Text & "-"
                cboTagCat6.SelectedValue = -1
            End If
            If cboTagCat7.SelectedValue > 0 Then
                lblTag.Text = lblTag.Text & cboTagCat7.Text & "-"
                cboTagCat7.SelectedValue = -1
            End If
            If cboTagCat8.SelectedValue > 0 Then
                lblTag.Text = lblTag.Text & cboTagCat8.Text & "-"
                cboTagCat8.SelectedValue = -1
            End If
        End If

        If Len(lblTag.Text) > 0 Then
            lblTag.Text = Left(lblTag.Text, Len(lblTag.Text) - 1)
            SqlDataSourceCRUD.Insert()
            ' Refrescar datos mostrados
            RadListView1.DataBind()
            cboPreExistingTags.SelectedValue = -1
            panelCategoryTags.Visible = True
        Else
            Master.InfoMessage("Select at lest one Tag!")
        End If

    End Sub
    Private Sub cboPreExistingTags_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboPreExistingTags.SelectedIndexChanged
        panelCategoryTags.Visible = (cboPreExistingTags.SelectedValue = "-1")
    End Sub

    Private Sub RadListView1_ItemCommand(sender As Object, e As RadListViewCommandEventArgs) Handles RadListView1.ItemCommand
        Select Case e.CommandName
            Case "DeleteTAG"
                lblTag.Text = e.CommandArgument
                SqlDataSourceCRUD.Delete()
                RadListView1.DataBind()
        End Select
    End Sub

    Private Sub FillDepartmentTagCategoryLabels()
        lblCategory0.Text = LocalAPI.GetDepartmentsProperty(cboDepartments.SelectedValue, "TagCategoryLabel0")
        lblCategory1.Text = LocalAPI.GetDepartmentsProperty(cboDepartments.SelectedValue, "TagCategoryLabel1")
        lblCategory2.Text = LocalAPI.GetDepartmentsProperty(cboDepartments.SelectedValue, "TagCategoryLabel2")
        lblCategory3.Text = LocalAPI.GetDepartmentsProperty(cboDepartments.SelectedValue, "TagCategoryLabel3")
        lblCategory4.Text = LocalAPI.GetDepartmentsProperty(cboDepartments.SelectedValue, "TagCategoryLabel4")
        lblCategory5.Text = LocalAPI.GetDepartmentsProperty(cboDepartments.SelectedValue, "TagCategoryLabel5")
        lblCategory6.Text = LocalAPI.GetDepartmentsProperty(cboDepartments.SelectedValue, "TagCategoryLabel6")
        lblCategory7.Text = LocalAPI.GetDepartmentsProperty(cboDepartments.SelectedValue, "TagCategoryLabel7")
        lblCategory8.Text = LocalAPI.GetDepartmentsProperty(cboDepartments.SelectedValue, "TagCategoryLabel8")
    End Sub
End Class
