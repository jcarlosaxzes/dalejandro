Public Class SingProposalSignPrint
    Inherits System.Web.UI.Page


#Region "Page Properties"

    Public Property CompanyId() As Integer
        Get
            Return m_CompanyId
        End Get
        Private Set
            m_CompanyId = Value
        End Set
    End Property
    Private m_CompanyId As Integer
    Public Property CompanyName() As String
        Get
            Return m_CompanyName
        End Get
        Private Set
            m_CompanyName = Value
        End Set
    End Property
    Private m_CompanyName As String
    Public Property CompanyAddress() As String
        Get
            Return m_CompanyAddress
        End Get
        Private Set
            m_CompanyAddress = Value
        End Set
    End Property
    Private m_CompanyAddress As String
    Public Property CompanyCity() As String
        Get
            Return m_CompanyCity
        End Get
        Private Set
            m_CompanyCity = Value
        End Set
    End Property
    Private m_CompanyCity As String
    Public Property CompanyState() As String
        Get
            Return m_CompanyState
        End Get
        Private Set
            m_CompanyState = Value
        End Set
    End Property
    Private m_CompanyState As String
    Public Property CompanyZipCode() As String
        Get
            Return m_CompanyZipCode
        End Get
        Private Set
            m_CompanyZipCode = Value
        End Set
    End Property
    Private m_CompanyZipCode As String
    Public Property CompanyPhone() As String
        Get
            Return m_CompanyPhone
        End Get
        Private Set
            m_CompanyPhone = Value
        End Set
    End Property
    Private m_CompanyPhone As String
    Public Property CompanyEmail() As String
        Get
            Return m_CompanyEmail
        End Get
        Private Set
            m_CompanyEmail = Value
        End Set
    End Property
    Private m_CompanyEmail As String
    Public Property CompanyWebLink() As String
        Get
            Return m_CompanyWebLink
        End Get
        Private Set
            m_CompanyWebLink = Value
        End Set
    End Property
    Private m_CompanyWebLink As String
    Public Property CompanyLetterHead() As Byte()
        Get
            Return m_CompanyLetterHead
        End Get
        Private Set
            m_CompanyLetterHead = Value
        End Set
    End Property
    Private m_CompanyLetterHead As Byte()
    Public Property Base64StringCompanyLetterHead() As String
        Get
            Return m_Base64StringCompanyLetterHead
        End Get
        Private Set
            m_Base64StringCompanyLetterHead = Value
        End Set
    End Property
    Private m_Base64StringCompanyLetterHead As String
    Public Property CompanyLogo() As Byte()
        Get
            Return m_CompanyLogo
        End Get
        Private Set
            m_CompanyLogo = Value
        End Set
    End Property
    Private m_CompanyLogo As Byte()
    Public Property Base64StringCompanyLogo() As String
        Get
            Return m_Base64StringCompanyLogo
        End Get
        Private Set
            m_Base64StringCompanyLogo = Value
        End Set
    End Property
    Private m_Base64StringCompanyLogo As String
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'for test https://staging.pasconcept.com/e2103445_8a47_49ff_808e_6008c0fe13a1/SingProposalSign?GuiId=f8d09640-73c9-4390-b959-b3113dbde454&source=111

        If Not Page.IsPostBack Then
            Try
                If Not "f8d09640-73c9-4390-b959-b3113dbde454" Is Nothing Then
                    lblGuiId.Text = "f8d09640-73c9-4390-b959-b3113dbde454"
                    lblProposalId.Text = LocalAPI.GetSharedLink_Id(11, lblGuiId.Text)
                    lblCompanyId.Text = LocalAPI.GetCompanyIdFromProposal(lblProposalId.Text)
                    CompanyId = lblCompanyId.Text
                    UpdatePageProperties()

                    RadBarcode1.Text = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Signature.aspx?GuiId=" & lblGuiId.Text & "&ObjType=11"
                End If
                Dim IsReadOnly As Boolean
                If Not Request.QueryString("IsReadOnly") Is Nothing Then
                    IsReadOnly = Request.QueryString("IsReadOnly")
                Else
                    IsReadOnly = LocalAPI.GetProposalData(lblProposalId.Text, "statusId") > 1
                End If

                pnlSideTools.Visible = Not IsReadOnly
                '!!!lblProposalId.Text = 14424
                'lblCompanyId.Text = LocalAPI.GetCompanyIdFromProposal(lblProposalId.Text)

                ' Para navegar en CLIENT PORTAL.....................................
                Session("CLIENTPORTAL_clientId") = LocalAPI.GetProposalProperty(lblProposalId.Text, "ClientId")
            Catch generatedExceptionName As Exception
                Throw New HttpException(404, "Proposal not found")
            End Try

        End If
    End Sub


    Public Function ShareDocumentsPanelVisible(IsSharePublicLinks As Integer) As Boolean
        If IsSharePublicLinks = 1 Then
            Return LocalAPI.IsAzureStorage(lblCompanyId.Text) And LocalAPI.GetAzureFilesCountInProposal(lblProposalId.Text) > 0
        End If
    End Function

    Private Sub RedirectToThanksPage()
        Dim url As String
        ' Corporative Thanks Page
        url = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "ThankPage_AceptanceProposal_url")
        If Len(url) = 0 Then
            url = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/thank-you-proposal.aspx?GuiId=" & lblGuiId.Text
        End If
        Response.Redirect(url)
    End Sub


    Private Sub UpdatePageProperties()
        ' TODO: Do a Simple query in DB
        Try
            CompanyName = LocalAPI.GetCompanyProperty(CompanyId, "Name")
            CompanyAddress = LocalAPI.GetCompanyProperty(CompanyId, "Address")
            CompanyCity = LocalAPI.GetCompanyProperty(CompanyId, "City")
            CompanyState = LocalAPI.GetCompanyProperty(CompanyId, "State")
            CompanyZipCode = LocalAPI.GetCompanyProperty(CompanyId, "ZipCode")
            CompanyPhone = LocalAPI.GetCompanyProperty(CompanyId, "Phone")
            CompanyEmail = LocalAPI.GetCompanyProperty(CompanyId, "Email")
            CompanyWebLink = LocalAPI.GetCompanyProperty(CompanyId, "web")
            CompanyLogo = LocalAPI.GetCompanyLogo(CompanyId)
            CompanyLetterHead = LocalAPI.GetCompanyLetterHead(CompanyId)
            ' Encoding Images
            Base64StringCompanyLogo = Convert.ToBase64String(CompanyLogo)
            Base64StringCompanyLetterHead = Convert.ToBase64String(CompanyLetterHead)
        Catch ex As Exception

        End Try
    End Sub

End Class