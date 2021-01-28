Public Class pro_notes
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then

                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Master.UserId

                lblProposalId.Text = LocalAPI.GetProposalIdFromGUID(Request.QueryString("guid"))

                Master.ActiveTab(6)

            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try

    End Sub

    Private Sub btnNewNote_Click(sender As Object, e As EventArgs) Handles btnNewNote.Click
        RadGridNotes.MasterTableView.InsertItem()
    End Sub
End Class