Public Class singclientportal
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub
    Public Sub DisplayMsg(header As String, body As String, Optional type As String = "success")
        Dim options = "toastr.options={closeButton:true,debug:false,newestOnTop:false,progressBar:true,positionClass:'toast-top-right',preventDuplicates:false,onclick:null,showDuration:300,hideDuration:1000,timeOut:5000,extendedTimeOut:1000,showEasing:'swing',hideEasing:'linear',showMethod:'fadeIn',hideMethod:'fadeOut'};"
        Page.ClientScript.RegisterStartupScript(Me.[GetType](), "displayMsg", options & "toastr." & type & "('" & header & "', '" & body & "');", True)
    End Sub

    Private Sub singclientportal_Init(sender As Object, e As EventArgs) Handles Me.Init

        If Not Request.QueryString("GuiId") Is Nothing Then
            Dim guid As String = Request.QueryString("GuiId")
            Dim ProposalId As Integer = LocalAPI.GetSharedLink_Id(11, guid)
            Dim ClientID As Integer = LocalAPI.GetProposalProperty(ProposalId, "ClientId")
            Dim companyId As Integer = LocalAPI.GetCompanyIdFromProposal(ProposalId)

            If Request.QueryString("source") Is Nothing Then
                If Request.QueryString("source") <> 111 Then
                    ' source differente of ~/adm/proposals.aspx
                    LocalAPI.sys_Log_clients_INSERT(Request.UserHostAddress(), ClientID, 1, ProposalId, companyId)
                End If

            End If


        End If


    End Sub
End Class