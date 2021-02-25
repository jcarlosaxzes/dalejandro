Imports Telerik.Web.UI
Public Class clientsmap
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Clientmap") Then Response.RedirectPermanent("~/adm/schedule.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Clients Map"
            Master.PageTitle = "Analytics/Clients Map"
            Master.Help = "http://blog.pasconcept.com/2015/03/project-map.html"

            lblCompanyId.Text = Session("companyId")

            Dim employeeId As Integer = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)

            ConfigureLayes()

        End If
    End Sub

    Private Sub ConfigureLayes()
        Try

            Dim mapLayer As MapLayer = RadMap1.LayersCollection.Item(0)

            If btnSattelite.Text = "Earth View" Then
                ' Layer con el Mapa de Bing
                mapLayer.Type = Map.LayerType.Bing
                mapLayer.ImagerySet = "Aerial"
                mapLayer.Key = ConfigurationManager.AppSettings.Get("BingMapKey").ToString()

                btnSattelite.Text = "Map View"
            Else
                ' Layer Predeterminado gratuito
                mapLayer.Type = Map.LayerType.Bing
                mapLayer.ImagerySet = "RoadOnDemand"
                mapLayer.Key = ConfigurationManager.AppSettings.Get("BingMapKey").ToString()
                btnSattelite.Text = "Earth View"
            End If


        Catch ex As Exception
            Master.ErrorMessage("ConfigureLayes Error. " & ex.Message)
        End Try
    End Sub

    Protected Sub btnSattelite_Click(sender As Object, e As EventArgs) Handles btnSattelite.Click
        ConfigureLayes()
    End Sub

End Class
