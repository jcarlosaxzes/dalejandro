Imports Telerik.Web.UI

Public Class AATest
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblCompanyId.Text = Session("companyId")
        End If


        RadWindowManager1.EnableViewState = False

    End Sub

#Region "TimeEntries"

    Private Sub btnGetTimeEntries_Click(sender As Object, e As EventArgs) Handles btnGetTimeEntries.Click
        System.Threading.Tasks.Task.Run(Function() EbillityApi.GetTimeEntriesAsync(lblCompanyId.Text))
    End Sub


#End Region



End Class