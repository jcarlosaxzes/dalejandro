Imports Telerik.Web.UI

Public Class companytypes
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As EventArgs) Handles Me.PreInit
        Theme = LocalAPI.DefinirTheme(Request.UserAgent)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Master.PageTitle = "Company Types"
        End If
    End Sub

    Protected Sub btnPaymentSchedules_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try

            Dim btnGenerate As RadButton = sender
            Dim cbo As RadComboBox = CType(btnGenerate.NamingContainer.FindControl("cboPaymentSchedules"), RadComboBox)

            Dim psValues As String = LocalAPI.GetStringEscalar("SELECT PaymentsScheduleList FROM Company_Invoices_types_TEMPLATE WHERE [templateId]=" & cbo.SelectedValue)
            Dim psText As String = LocalAPI.GetStringEscalar("SELECT PaymentsTextList FROM Company_Invoices_types_TEMPLATE WHERE [templateId]=" & cbo.SelectedValue)

            CType(btnGenerate.NamingContainer.FindControl("PaymentsScheduleListTextBox"), RadTextBox).Text = psValues
            CType(btnGenerate.NamingContainer.FindControl("PaymentsTextListTextBox"), RadTextBox).Text = psText

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnUpdateTandCTemplate_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try

            Dim btnUpdate As RadButton = sender
            Dim cbo As RadComboBox = CType(btnUpdate.NamingContainer.FindControl("cboTandCtemplates"), RadComboBox)
            Dim editor As RadEditor = CType(btnUpdate.NamingContainer.FindControl("gridEditor_TandC"), RadEditor)
            editor.Content = LocalAPI.GetCompanyProposalTemplateDescription(Val("" & cbo.SelectedValue))
        Catch ex As Exception

        End Try
    End Sub

End Class
