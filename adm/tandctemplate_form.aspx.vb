Public Class tandctemplate_form
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message

            lblCompanyId.Text = Session("companyId")
            If Request.QueryString("templateId") Is Nothing Then
                ' Mode NEW
                btnUpdate.Text = "Insert"
            Else
                ' Mode EDIT
                btnUpdate.Text = "Update"
                lblTemplateId.Text = Request.QueryString("templateId")
                ReadTemplate()

            End If

        End If
    End Sub

    Private Sub ReadTemplate()
        Dim PreProjectInfo = LocalAPI.GetRecord(lblTemplateId.Text, "Proposal_TandCtemplate_SELECT")

        Try
            NameTextBox.Text = PreProjectInfo("Name")
            gridEditor.Content = PreProjectInfo("Descripction")

        Catch ex As Exception
        End Try
    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        If lblTemplateId.Text > 0 Then
            SqlDataSource1.Update()
            Master.InfoMessage("Term & Condition was updated!")
        Else
            SqlDataSource1.Insert()
            btnUpdate.Text = "Update"
            Master.InfoMessage("Term & Condition was Inserted!")
        End If
    End Sub

    Private Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Inserted
        lblTemplateId.Text = LocalAPI.GetProposal_TandCtemplatesId(NameTextBox.Text, lblCompanyId.Text)
    End Sub


End Class