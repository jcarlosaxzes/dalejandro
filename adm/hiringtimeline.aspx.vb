Imports Telerik.Web.UI

Public Class hiringtimeline
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_EmployeesList") Then Response.RedirectPermanent("~/adm/schedule.aspx")

            lblCompanyId.Text = Session("companyId")
            lblEmployeeId.Text = Master.UserId

        End If

    End Sub

#Region "Hiring Timeline"


    Private Sub RadTimelineHiring_ItemDataBound(sender As Object, e As RadTimelineItemEventArgs) Handles RadTimelineHiring.ItemDataBound
        Dim dataItem = TryCast(e.Item.DataItem, DataRowView)
        Dim SrcPhoto = dataItem("SrcPhoto").ToString()
        If String.IsNullOrEmpty(SrcPhoto) Then
            SrcPhoto = "../Images/Employees/nophoto.jpg"
        End If
        e.Item.Images.Add(New TimelineItemImage() With {.Src = SrcPhoto})
    End Sub


#End Region
    Private Sub btnFind_Click(sender As Object, e As EventArgs) Handles btnFind.Click
        RadTimelineHiring.DataBind()
    End Sub

End Class