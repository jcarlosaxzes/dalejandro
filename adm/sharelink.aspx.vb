Public Class sharelink
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then

            Dim ObjId As Integer = Request.QueryString("ObjId")
            Dim ObjType As Integer = Request.QueryString("ObjType")

            If Not Request.QueryString("ObjGuid") Is Nothing Then
                Dim ObjGuid As Integer = Request.QueryString("ObjGuid")
                txtURL.Text = LocalAPI.GetSharedLink_URL_ByGuid(ObjType, ObjGuid, ObjId)
            Else
                txtURL.Text = LocalAPI.GetSharedLink_URL(ObjType, ObjId)
            End If


            '@objType:  1:Proposal;   2:Job;   3:RFP;    4:Invoice;    5:Statement

            Select Case ObjType
                Case 1, 11
                    lblObjType.Text = "Proposal"
                Case 111
                    ' Fue llamado desde Target=_blank, debe navegar a resultado...
                    Response.Redirect(txtURL.Text)
                Case 2
                    lblObjType.Text = "Job"
                Case 3
                    lblObjType.Text = "RPF"
                Case 4
                    lblObjType.Text = "Invoice"
                Case 44
                    ' Fue llamado desde Target=_blank, debe navegar a resultado...
                    Response.Redirect(txtURL.Text)
                Case 5
                    lblObjType.Text = "Statement"
                Case 55
                    ' Fue llamado desde Target=_blank, debe navegar a resultado...
                    Response.Redirect(txtURL.Text)

                Case Else
                    lblObjType.Text = "Information"
            End Select
        End If
        txtURL.Focus()
    End Sub

End Class
