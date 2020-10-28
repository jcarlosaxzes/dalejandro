Imports Telerik.Web.UI
Public Class projectmap
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Projectmap") Then Response.RedirectPermanent("~/adm/default.aspx")

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Project Map"
            Master.PageTitle = "Analytics/Project Map"
            Master.Help = "http://blog.pasconcept.com/2015/03/project-map.html"

            lblCompanyId.Text = Session("companyId")

            Dim employeeId As Integer = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)

            cboPeriod.DataBind()

            IniciaPeriodo(365)


            ConfigureLayes()

        End If
    End Sub

    Private Sub IniciaPeriodo(nPeriodo As Integer)
        Select Case nPeriodo
            Case 13  ' (All Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/2000"
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

            Case 14  ' (This Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

            Case 15  ' (Last Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Today.Year - 1
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year - 1

            Case 16  ' (This Month)
                RadDatePickerFrom.DbSelectedDate = Today.Month & "/01/" & Today.Year
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate))
            Case 17  ' (Past Month)
                RadDatePickerFrom.DbSelectedDate = Today.Month & "/01/" & Today.Year
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Month, -1, RadDatePickerFrom.DbSelectedDate)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate))

            Case 30, 60, 90, 120, 180, 365 '   days....
                RadDatePickerTo.DbSelectedDate = Date.Today
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Day, 0 - nPeriodo, RadDatePickerTo.DbSelectedDate)

            Case 99   'Custom
                RadDatePickerFrom.Focus()
                ' Allow RadDatePicker user Values...

            Case Else  ' xxxx Year
                RadDatePickerFrom.DbSelectedDate = "01/01/" & nPeriodo
                RadDatePickerTo.DbSelectedDate = "12/31/" & nPeriodo
        End Select
        cboPeriod.SelectedValue = nPeriodo
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

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        Try

            IniciaPeriodo(cboPeriod.SelectedValue)
            SqlDataSource1.DataBind()
        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try
    End Sub

End Class
