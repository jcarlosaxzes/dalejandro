Imports Telerik.Web.UI
Public Class transmittal1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then

                lblCompanyId.Text = Session("companyId")
                lblTransmittalId.Text = Request.QueryString("transmittalId")
                Dim JobId As Integer = LocalAPI.GetTransmittalProperty(lblTransmittalId.Text, "JobId")

                lblEmployeeEmail.Text = Master.UserEmail
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)
                lblEmployeeName.Text = LocalAPI.GetEmployeeName(lblEmployeeId.Text)

                FormView1.DataBind()
                CType(FormView1.FindControl("RadBarcode1"), RadBarcode).Text = LocalAPI.GetSharedLink_URL(66, lblTransmittalId.Text)

                If Not LocalAPI.IsADMCLIuserAutorized(lblEmployeeEmail.Text, lblCompanyId.Text) Then
                    lblTransmittalId.Text = 0
                End If

                If Request.QueryString("FullPage") Is Nothing Then
                    Master.HideMasterMenu()
                    btnBack.Visible = False
                End If

            End If

            Botones()

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub Botones()
        Try

            Dim bIsTransmittalReadyToSigned As Boolean = LocalAPI.IsTransmittalReadyToSigned(lblTransmittalId.Text)

            ' Administrators
            CType(FormView1.FindControl("btnMailReadyToSign"), RadButton).Visible = bIsTransmittalReadyToSigned
            CType(FormView1.FindControl("btnPickUp2"), RadButton).Visible = bIsTransmittalReadyToSigned
            CType(FormView1.FindControl("btnPickUp"), RadButton).Visible = bIsTransmittalReadyToSigned
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As EventArgs)
        SqlDataSourceDetails.Insert()
    End Sub

    Protected Sub SqlDataSourceDetails_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceDetails.Inserted
        SqlDataSourceDetails.DataBind()
        CType(FormView1.FindControl("RadGridEditDetails"), RadGrid).DataBind()
    End Sub

    Protected Sub btnPickUp_Click(sender As Object, e As EventArgs)
        Response.RedirectPermanent("~/adm/signature.aspx?ObjId=2&Id=" & lblTransmittalId.Text)
    End Sub

    Protected Sub btnMailReadyToSign_Click(sender As Object, e As EventArgs)
        MailReadtToSign()
    End Sub

    Private Sub MailReadtToSign()
        Try
            If LocalAPI.EmailReadyToPickUp(lblTransmittalId.Text, lblCompanyId.Text, lblEmployeeEmail.Text, lblEmployeeName.Text) Then
                LocalAPI.SetTransmittalJobToDoneStatus(lblTransmittalId.Text)
            End If
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub FormView1_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormView1.ItemUpdated
        MostrarConfirmMail()
    End Sub

    Private Sub MostrarConfirmMail()
        RadToolTipMail.Visible = True
        RadToolTipMail.Show()
    End Sub

    Protected Sub btnCancelMail_Click(sender As Object, e As EventArgs) Handles btnCancelMail.Click
        RadToolTipMail.Visible = False
        CType(FormView1.FindControl("RadBarcode1"), RadBarcode).Text = LocalAPI.GetSharedLink_URL(66, lblTransmittalId.Text)
    End Sub

    Protected Sub btnConfirmMail_Click(sender As Object, e As EventArgs) Handles btnConfirmMail.Click
        ' Enviar mail
        MailReadtToSign()
        RadToolTipMail.Visible = False
        CType(FormView1.FindControl("RadBarcode1"), RadBarcode).Text = LocalAPI.GetSharedLink_URL(66, lblTransmittalId.Text)
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/transmittals.aspx")
    End Sub
End Class
