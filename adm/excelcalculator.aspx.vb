Imports Telerik.Web.UI
Public Class excelcalculator
    Inherits System.Web.UI.Page

    Private Const ProviderSessionKey As String = "Telerik.Web.Examples.SpreadSheet.Overview.DefaultVB"

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        lblCompanyId.Text = Session("companyId")
        Dim user As MembershipUser = Membership.GetUser()
        Dim UserId As String = LocalAPI.GetEmployeeId(user.Email, lblCompanyId.Text)

        If (Not System.IO.Directory.Exists(Server.MapPath("~/App_Data/" & lblCompanyId.Text))) Then
            ' Crear directorio de la companyId
            System.IO.Directory.CreateDirectory(Server.MapPath("~/App_Data/" & lblCompanyId.Text))
        End If
        Dim userFile As String = Server.MapPath("~/App_Data/" & lblCompanyId.Text & "/ExcelCalculator_" & UserId & ".xlsx")
        If (Not System.IO.File.Exists(userFile)) Then
            System.IO.File.Copy(Server.MapPath("~/App_Data/ExcelCalculator.xlsx"), userFile)
        End If

        Dim provider As SpreadsheetDocumentProvider

        If (Session(ProviderSessionKey) Is Nothing) OrElse (Not IsPostBack) Then
            provider = New SpreadsheetDocumentProvider(userFile)
            Session(ProviderSessionKey) = provider
        Else
            provider = DirectCast(Session(ProviderSessionKey), SpreadsheetDocumentProvider)
        End If

        RadSpreadsheet1.Provider = provider
    End Sub

End Class
