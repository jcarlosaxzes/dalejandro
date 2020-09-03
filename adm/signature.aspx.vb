Imports Microsoft.AspNet.Identity

Public Class signature1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack() Then
            If Request.QueryString("id") IsNot Nothing Then
                lblId.Text = Request.QueryString("Id")

                Dim companyId As Integer = Session("companyId")

                'Transmittal
                lblTitle.Text = "Sign Transmittal Letter to Pick Up"
                lblExplication.Text = "I 'Sign' the Transmittal Letter No.:"
                lblReferencia.Text = LocalAPI.TransmittalNumber(lblId.Text)
                Dim employeeId As Integer = LocalAPI.GetEmployeeId(Context.User.Identity.GetUserName(), companyId)
                txtNombre.Text = LocalAPI.GetEmployeeName(employeeId)

                lblBackPage.Text = Request.QueryString("BackPage")
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

        LocalAPI.SignTransmittal(lblId.Text, Name, img64)

        Select Case lblBackPage.Text
            Case "transmittals"
                Response.RedirectPermanent("~/adm/Transmittal.aspx?transmittalId=" & Id & "&BackPage=transmittals")
            Case Else
                Response.RedirectPermanent("~/adm/Transmittal.aspx?transmittalId=" & Id)
        End Select


    End Sub

End Class

