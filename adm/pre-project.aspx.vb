Public Class pre_project
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblEmployeeEmail.Text = Master.UserEmail
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)

                cboPreparedBy.DataBind()
                cboProposalBy.DataBind()
                cboDepartment.DataBind()
                If Request.QueryString("preprojectsId") Is Nothing Then
                    ' Mode NEW
                    btnUpdate.Text = "Insert"
                    'btnUpload.Visible = False
                    cboPreparedBy.SelectedValue = lblEmployeeId.Text
                    cboProposalBy.SelectedValue = lblEmployeeId.Text
                    cboDepartment.SelectedValue = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "DepartmentId")
                Else
                    ' Mode EDIT
                    btnUpdate.Text = "Update"
                    'btnUpload.Visible = True
                    lblPreProjectId.Text = Request.QueryString("preprojectsId")
                    cboCliente.DataBind()
                    cboType.DataBind()
                    cboStatus.DataBind()
                    ReadPreProject()

                End If

            End If

        Catch ex As Exception

        End Try
    End Sub

    Private Sub ReadPreProject()
        Dim PreProjectInfo = LocalAPI.GetRecord(lblPreProjectId.Text, "Pre_Project_SELECT")

        lblPre_ProjectNumber.Text = PreProjectInfo("Pre_ProjectNumber")
        txtName.Text = PreProjectInfo("Name")
        cboCliente.SelectedValue = PreProjectInfo("clientId")
        cboType.SelectedValue = PreProjectInfo("ProjectType")
        txtProjectLocation.Text = PreProjectInfo("ProjectLocation")
        txtDescription.Text = PreProjectInfo("Description")
        cboStatus.SelectedValue = PreProjectInfo("statusId")
        Try
            If PreProjectInfo("PreparedBy") > 0 Then
                cboPreparedBy.SelectedValue = PreProjectInfo("PreparedBy")
            Else
                cboPreparedBy.SelectedValue = lblEmployeeId.Text
            End If
            If PreProjectInfo("ProposalBy") > 0 Then
                cboProposalBy.SelectedValue = PreProjectInfo("ProposalBy")
            Else
                cboProposalBy.SelectedValue = lblEmployeeId.Text
            End If
            If PreProjectInfo("DepartmentId") > 0 Then
                cboDepartment.SelectedValue = PreProjectInfo("DepartmentId")
            Else
                cboDepartment.SelectedValue = LocalAPI.GetEmployeeProperty(lblEmployeeId.Text, "DepartmentId")
            End If
        Catch ex As Exception
        End Try
        Try

        Catch ex As Exception
        End Try
    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        If lblPreProjectId.Text > 0 Then
            SqlDataSource1.Update()
            Master.InfoMessage("Pre-Project was updated!")
        Else
            SqlDataSource1.Insert()
            btnUpdate.Text = "Update"
            btnUpload.Visible = True
            Master.InfoMessage("Pre-Project was Inserted!")
        End If
    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        lblPreProjectId.Text = LocalAPI.GetLastPreProjectInsertedId(txtName.Text)
    End Sub

    Private Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click
        Dim clientId As Integer = LocalAPI.GetPreProjectProperty(lblPreProjectId.Text, "clientId")
        Response.Redirect("~/ADM/AzureStorage_client.aspx?clientId=" & clientId & "&preprojectId=" & lblPreProjectId.Text)
    End Sub
End Class
