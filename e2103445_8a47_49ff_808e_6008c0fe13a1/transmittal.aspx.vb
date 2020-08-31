Imports Telerik.Web.UI

Public Class transmittal
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                If Not Request.QueryString("GuiId") Is Nothing Then
                    lblguid.Text = Request.QueryString("GuiId")
                    lblTransmittalId.Text = LocalAPI.GetSharedLink_Id(6, lblguid.Text)

                    Dim JobId As Integer = LocalAPI.GetTransmittalProperty(lblTransmittalId.Text, "JobId")
                    Session("CLIENTPORTAL_clientId") = LocalAPI.GetJobProperty(JobId, "Client")

                    lblCompanyId.Text = LocalAPI.GetTransmittalProperty(lblTransmittalId.Text, "companyId")
                    Master.Company = lblCompanyId.Text
                    'Clients_visitslog?
                    ' Visit not from Current session company "False visit"
                    If Not Request.QueryString("entityType") Is Nothing And Val("" & Session("companyId")) <> lblCompanyId.Text Then
                        LocalAPI.SetTransmittalStatusClientVisited(lblTransmittalId.Text)
                        LocalAPI.NewClients_visitslog(Request.QueryString("entityType"), lblTransmittalId.Text, Request.UserHostAddress())
                    End If

                    FormView1.DataBind()

                    CType(FormView1.FindControl("RadBarcode1"), RadBarcode).Text = LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Signature.aspx?GuiId=" & lblguid.Text & "&ObjType=22"

                    CType(FormView1.FindControl("PanelDigitalFiles"), Panel).Visible = IIf(LocalAPI.GetTransmittalDigitalFilesCount(lblTransmittalId.Text) > 0, True, False)

                    If Not Request.QueryString("Print") Is Nothing Then
                        Response.Write("<script>window.print();</script>")
                    End If

                End If

            End If


        Catch ex As Exception
        End Try
    End Sub

    Protected Sub btnPickUp_Click(sender As Object, e As EventArgs)
        Response.RedirectPermanent(LocalAPI.GetHostAppSite() & "/e2103445_8a47_49ff_808e_6008c0fe13a1/Signature.aspx?GuiId=" & lblguid.Text & "&ObjType=22")

    End Sub

End Class
