Public Class newclientcollection
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            lblCompanyId.Text = Session("companyId")

            If Request.QueryString("collectionId") Is Nothing Then
                ' New Collection.....................
            Else
                ' Edit Collection.....................
                lblCollectionId.Text = Request.QueryString("collectionId")
                ReadCollectionRecord()
            End If
        End If

    End Sub

    Private Sub ReadCollectionRecord()
        Dim DepartmentInfo = LocalAPI.GetRecord(lblCollectionId.Text, "Clients_collection_Form_SELECT")

        Try
            cboClients.DataBind()
            cboClients.SelectedValue = DepartmentInfo("clientId")
            'NameTextBox.Text = DepartmentInfo("Name")
        Catch ex As Exception
        End Try
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/clientscolletion.aspx")
    End Sub
End Class