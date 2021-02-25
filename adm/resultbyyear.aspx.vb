Public Class resultbyyear
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If (Not Page.IsPostBack) Then
                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_Analytics") Then Response.RedirectPermanent("~/adm/schedule.aspx")

                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Results by Year"
                Master.PageTitle = "Analytics/Results by Year"
                lblCompanyId.Text = Session("companyId")
                Master.Help = "http://blog.pasconcept.com/2015/04/analyticschart-by-year.html"
            End If
        Catch ex As Exception

        End Try
        'Pasos para lograr un Grafico de varias Y_SERIES contra unas X_LABELS comun, bindiado a un SQLDataSource
        '1. Crear un SQLDataSource de 1 Columna de Labes para las X (Ejemplo, Meses del año)
        '    y tantas otras columnas de VALORES correspondientes a las Y_SERIES (Ejemplo, Budget, Coste, Collected)
        '2. Bindear el RadChart al SQLDataSource
        '3. Definir Dimensiones, Skin, Tipo
        '4. Ir a Collection, Añadir tantas Series como columnas de VALORES quiera represntar
        '5. Definir para Cada una "DataYColumn" con DataField, "Name" con su nombre en la Leyenda
        '6. Definir en estas mismas series "DataLabelsColumn" con el nombre de la columna que define etiquetas de las X (Ej. Mes)
        '7. Definiren <PlotArea> <XAxis DataLabelsColumn="Mes"
        '8. Definir en <Series> <Appearance> debajo de <FillStyle ...</FillStyle>, <LabelAppearance Visible="False">
        '9. Propiedad  AutoLayout="true" para ajustar los tamaños de letas y ejes dentro del grafico
    End Sub

End Class
