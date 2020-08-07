Imports Telerik.Web.UI

Public Class avgeemployeesprofit
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not IsPostBack Then
                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_EmployeesEfficiencyGraphic") Then Response.RedirectPermanent("~/adm/default.aspx")

                Master.PageTitle = "Employees/Employees Efficiency Graphic"
                Master.Help = "http://blog.pasconcept.com/2012/07/employees-efficiency-chart.html"
                lblCompanyId.Text = Session("companyId")
                Me.Title = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Name") & ". Employees Efficiency Graphic"

                SqlDataSourceYear.DataBind()
                cboYear.DataBind()
                cboYear.SelectedValue = Date.Today.Year

                cboDepartments.DataBind()
                ShowCheckedOneItem(lblDepartmentIdIN_List, cboDepartments)
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

    Private Sub ShowCheckedOneItem(LabelIN_List As Label, Combo1 As RadComboBox)
        ' Companies...............................
        LabelIN_List.Text = ""
        Dim collection As IList(Of RadComboBoxItem) = Combo1.CheckedItems
        If (collection.Count <> 0) Then

            For Each item As RadComboBoxItem In collection
                LabelIN_List.Text = LabelIN_List.Text + item.Value + ","
            Next
            ' Quitar la ultima coma
            LabelIN_List.Text = Left(LabelIN_List.Text, Len(LabelIN_List.Text) - 1)
        End If
    End Sub

    Protected Sub cboDepartments_ItemDataBound(sender As Object, e As RadComboBoxItemEventArgs) Handles cboDepartments.ItemDataBound
        e.Item.Checked = True
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        ShowCheckedOneItem(lblDepartmentIdIN_List, cboDepartments)
        SqlDataSource1.DataBind()
    End Sub

End Class
