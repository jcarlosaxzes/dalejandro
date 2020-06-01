Public Class signature
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack() Then
            If Not Request.QueryString("GuiId") Is Nothing Then
                lblGuiId.Text = Request.QueryString("GuiId")
                lblObjType.Text = Request.QueryString("ObjType")
                lblId.Text = LocalAPI.GetSharedLink_Id(lblObjType.Text, lblGuiId.Text)
                Dim clientId As Integer

                Select Case lblObjType.Text
                    Case 11  'Proposal
                        'lblTitle.Text = "To Accept Proposal, Sign Here"
                        lblExplication.Text = "I 'Accept and Sign' Proposal No.:"
                        lblReferencia.Text = LocalAPI.ProposalNumber(lblId.Text)
                        lblCompanyId.Text = LocalAPI.GetProposalProperty(lblId.Text, "companyId")

                        clientId = LocalAPI.GetProposalProperty(lblId.Text, "ClientId")
                        txtNombre.Text = LocalAPI.GetClientName(clientId)

                    Case 22, 30  'Transmittal
                        'lblTitle.Text = "Sign Transmittal Letter to Pick Up"
                        lblExplication.Text = "I 'Sign' the Transmittal Letter No.:"
                        lblReferencia.Text = LocalAPI.TransmittalNumber(lblId.Text)
                        lblCompanyId.Text = LocalAPI.GetTransmittalProperty(lblId.Text, "companyId")

                        clientId = LocalAPI.GetTransmittalProperty(lblId.Text, "ClientId")
                        txtNombre.Text = LocalAPI.GetClientName(clientId)

                        'Case 33  'RFP
                        '    lblTitle.Text = "Sign RFP Acceptance"
                        '    lblExplication.Text = "I Sign the'Accepted' RFP No.:"
                        '    lblReferencia.Text = LocalAPI.RFPNumber(lblId.Text)
                        '    lblCompanyId.Text = LocalAPI.GetRFPProperty(lblId.Text, "RequestForProposals.companyId")
                End Select

            End If
        Else
            ' Evento PostBack del boton btnSave
            If Request("__EVENTTARGET") = "CommandSave" Then
                Guardar_y_retornar(lblId.Text, txtNombre.Text, Request("__EVENTARGUMENT"))
            End If
        End If
    End Sub

    Public Sub Guardar_y_retornar(Id As Integer, Name As String, img64 As String)
        Dim sName As String = txtNombre.Text

        Select Case lblObjType.Text
            Case 11
                ' 1.- Email Aceptacion
                LocalAPI.ProposalAcceptedEmail(lblId.Text, lblCompanyId.Text)

                ' 2.- Confirm proposal acceptance
                Dim JobId As Integer
                JobId = LocalAPI.ProposalStatus2Acept(lblId.Text, lblCompanyId.Text)

                ' 3.- Guardar Firma
                LocalAPI.SignProposal(lblId.Text, Name, img64)

                '4 - Create Job
                If JobId > 0 Then
                    LocalAPI.NewJobEmail(lblId.Text, JobId, lblCompanyId.Text)
                Else
                    LocalAPI.NoJobEmail(lblId.Text, lblCompanyId.Text)
                End If

                ' Redirect 
                Response.Redirect(LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/SingProposalSign.aspx?GuiId=" & lblGuiId.Text)

            Case 22  'Transmittal
                LocalAPI.SignTransmittal(lblId.Text, Name, img64)
                Response.Redirect(LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Transmittal.aspx?GuiId=" & lblGuiId.Text)

            Case 30  'Mobile Transmittal
                LocalAPI.SignTransmittal(lblId.Text, Name, img64)
                Response.Redirect(LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/mtransmittal.aspx?GuiId=" & lblGuiId.Text)

                'Case 33  'RFP
                '    LocalAPI.SignRFP(lblId.Text, Name, img64)
                '    Response.RedirectPermanent("~/ADMCLI/RequestForProposal.aspx?rfpId=" & Id & "&signed=1")
        End Select

    End Sub

    Private Sub ThanksPage()
        Dim url As String
        ' Corporative Thanks Page
        url = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "ThankPage_AceptanceProposal_url")
        If Len(url) = 0 Then
            url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/thank-you-proposal.aspx?GuiId=" & lblGuiId.Text
        End If

        Response.Redirect(url)

    End Sub

End Class