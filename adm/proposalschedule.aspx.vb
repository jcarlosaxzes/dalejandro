Public Class proposalschedule
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                lblCompanyId.Text = Session("companyId")
                lblproposalId.Text = Request.QueryString("Id")
                ConfigRadGrantt()
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub ConfigRadGrantt()
        Try

            Dim ProposalNumber As String = LocalAPI.ProposalNumber(lblproposalId.Text)
            RadGantt1.ExportSettings.Pdf.FileName = "Proposal_Schedule_" & ProposalNumber & ".pdf"
            SqlDataSource1.DataBind()
            RadGantt1.DataBind()
            RadGantt1.Columns(0).Visible = False    ' Id
            RadGantt1.Columns(1).Visible = True     ' Title
            RadGantt1.Columns(1).Width = "150"

            RadGantt1.Columns(2).Visible = True     ' Start
            RadGantt1.Columns(2).DataFormatString = "MM/dd/yyyy"

            RadGantt1.Columns(3).Visible = True     ' End
            RadGantt1.Columns(3).DataFormatString = "MM/dd/yyyy"

            RadGantt1.Columns(4).Visible = False    ' Percent
            RadGantt1.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Response.Redirect("~/ADM/Proposal.aspx?Id=" & lblproposalId.Text & "&Tab2=2")
    End Sub

End Class

