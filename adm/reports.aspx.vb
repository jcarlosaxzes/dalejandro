Imports System.Drawing
Imports Telerik.Web.UI
Public Class reports
    Inherits System.Web.UI.Page

    Dim QueryGropu As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_AnalyticReports") Then Response.RedirectPermanent("~/adm/default.aspx")

            Title = ConfigurationManager.AppSettings("Titulo") & ". Reports"
            Master.PageTitle = "Analytics/Reports"
            lblCompanyId.Text = Session("companyId")
            InitNamesReports()
            Master.Help = "http://blog.pasconcept.com/2015/04/analyticsreports.html"

            RadDatePickerFrom.DbSelectedDate = "01/01/" & Date.Today.Year
            RadDatePickerTo.DbSelectedDate = "12/31/" & Date.Today.Year

            cboDepartment.DataBind()
            'Dim nDefaultDep As Integer = LocalAPI.GetEmployeeProperty(LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text), "FilterJob_Department")
            'If nDefaultDep > 0 Then
            '    ' Solo ve su Dpto
            '    cboDepartment.SelectedValue = nDefaultDep
            '    cboDepartment.Enabled = False
            'End If
            If Not Request.QueryString("group") Is Nothing Then
                QueryGropu = Request.QueryString("group")
            End If

            TimeFrame(3)
        End If

    End Sub

    Private Sub cboTimeFrame_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboTimeFrame.SelectedIndexChanged
        TimeFrame(cboTimeFrame.SelectedValue)
    End Sub
    Private Sub TimeFrame(TimeFrameId As Integer)
        '@TimeFrameId
        '    1:  All Years
        '    2:  Last Years
        '    3:  This Years
        '    4:  Last Quarter
        '    5:  This Quarter
        '    6:  Last Month
        '    7:  This Month
        '    8:  Last 30 Days
        '    9:  Last 15 Days
        '    10: Last 7 Days
        '    11: Last  Day
        '    12: Today
        '    13: MTD Y - 1
        '    14: MTD
        '    15: QTD Y - 1
        '    16: QTD
        '    17: YTD Y - 1
        '    18: YTD
        If TimeFrameId <> 99 Then
            RadDatePickerFrom.DbSelectedDate = LocalAPI.GetDateFromOfTimeFrame(TimeFrameId)
            RadDatePickerTo.DbSelectedDate = LocalAPI.GetDateToOfTimeFrame(TimeFrameId)
        Else
            RadDatePickerFrom.Focus()
        End If
        cboTimeFrame.SelectedValue = TimeFrameId
    End Sub
    Protected Sub btnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        Try
            If cboNames.SelectedValue > 0 Then
                Master.PageTitle = "Analytics/Reports (" & cboNames.Text & ")"
                RadGrid1.Visible = True
                SqlDataSource1.DataBind()
            Else
                RadGrid1.Visible = False
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try

    End Sub

    Protected Sub RadGrid1_ColumnCreated(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridColumnCreatedEventArgs) Handles RadGrid1.ColumnCreated
        Try
            Dim boundColumn As GridBoundColumn = CType(e.Column, GridBoundColumn)

            boundColumn.HeaderStyle.HorizontalAlign = HorizontalAlign.Center
            boundColumn.AllowFiltering = False

            Select Case boundColumn.DataTypeName
                Case "System.Double", "System.Decimal"
                    boundColumn.ItemStyle.HorizontalAlign = HorizontalAlign.Right
                    boundColumn.DataFormatString = "{0:N2}"
                    boundColumn.Aggregate = Telerik.Web.UI.GridAggregateFunction.Sum
                    boundColumn.FooterStyle.HorizontalAlign = HorizontalAlign.Right
                    boundColumn.HeaderStyle.Width = "120"
                Case "System.Int32"
                    boundColumn.ItemStyle.HorizontalAlign = HorizontalAlign.Right
                    boundColumn.DataFormatString = "{0:N0}"
                    boundColumn.HeaderStyle.Width = "100"
                    'boundColumn.Aggregate = Telerik.Web.UI.GridAggregateFunction.Sum
                Case "System.DateTime"
                    boundColumn.ItemStyle.HorizontalAlign = HorizontalAlign.Right
                    boundColumn.DataFormatString = "{0:d}"
                    boundColumn.HeaderStyle.Width = "100"

                Case Else
                    'boundColumn.ItemStyle.HorizontalAlign = HorizontalAlign.Left

            End Select

            ' Hacer No Visible Columna Year
            Select Case UCase(boundColumn.DataField)
                Case "YEAR"
                    boundColumn.Visible = cboGroups.SelectedValue = "COMPANY"
                Case "YEAR", "ISRATE", "FORMATSTRING"
                    boundColumn.Visible = False
                Case "INVOICENUMBER"
                    boundColumn.Aggregate = Telerik.Web.UI.GridAggregateFunction.Count
                    boundColumn.FooterStyle.HorizontalAlign = HorizontalAlign.Center
                    boundColumn.FooterAggregateFormatString = "{0:N0}"
                    boundColumn.HeaderStyle.Width = "140"
                Case "CODE", "ID"
                    boundColumn.Aggregate = Telerik.Web.UI.GridAggregateFunction.Count
                    boundColumn.FooterStyle.HorizontalAlign = HorizontalAlign.Center
                    boundColumn.FooterAggregateFormatString = "{0:N0}"
                    boundColumn.HeaderStyle.Width = "80"
                Case "STATUS", "AVAILABILITY", "SOURCE"
                    boundColumn.HeaderStyle.Width = "140"
                    boundColumn.ItemStyle.HorizontalAlign = HorizontalAlign.Center
                    'Case "JOBNAME", "PROJECTNAME", "EMPLOYEE", "NAME", "CONCEPT", "CLIENTNAME", "PM"
                    'boundColumn.AllowFiltering = True
                    'boundColumn.HeaderStyle.Width = "180"
                Case "JOB", "NAME", "COMPANY", "JOBNAME", "PROJECTNAME", "EMPLOYEE", "CONCEPT", "CLIENTNAME"
                    boundColumn.HeaderStyle.Width = "280"
            End Select

            ' Ajustar el ancho del filtro
            'If boundColumn.AllowFiltering Then
            '    Select Case UCase(boundColumn.DataField)
            '        Case "STATUS"
            '            boundColumn.FilterControlWidth = "100"
            '        Case "JOBNAME", "PROJECTNAME", "EMPLOYEE", "NAME", "CONCEPT", "CLIENTNAME"
            '            boundColumn.FilterControlWidth = "200"
            '    End Select
            'End If



        Catch ex As Exception
        End Try
    End Sub

    Protected Sub RadGrid1_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles RadGrid1.ItemDataBound
        'Is it a GridDataItem
        If (TypeOf (e.Item) Is GridDataItem And (cboNames.SelectedValue = 253 Or cboNames.SelectedValue = 254 Or cboNames.SelectedValue = 255)) Then
            'Get the instance of the right type
            Try
                Dim dataBoundItem As GridDataItem = e.Item
                'Check the formatting condition
                Dim ProfitPercent = Decimal.Parse(dataBoundItem("ProfitPercent").Text)
                If (ProfitPercent >= 30) Then
                    dataBoundItem("ProfitPercent").BackColor = Color.Green
                End If
                If (ProfitPercent < 30 And ProfitPercent >= 20) Then
                    dataBoundItem("ProfitPercent").BackColor = Color.Yellow
                End If
                If (ProfitPercent < 20) Then
                    dataBoundItem("ProfitPercent").BackColor = Color.Red
                End If
            Catch ex As Exception
            End Try
        End If
    End Sub

    Protected Sub cboGroups_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboGroups.SelectedIndexChanged
        InitNamesReports()
    End Sub
    Private Sub InitNamesReports()
        cboNames.Items.Clear()
        cboNames.Items.Insert(0, New RadComboBoxItem("(Select Report...)", -1))
        SqlDataSourceName.DataBind()
        cboNames.DataBind()
        cboDepartment.Enabled = (cboGroups.SelectedValue = "Jobs" Or cboGroups.SelectedValue = "Employees" Or cboGroups.SelectedValue = "Marketing" Or cboGroups.SelectedValue = "Expenses")
    End Sub

    Private Sub ConfigureExport()
        RadGrid1.AllowPaging = False
        RadGrid1.ExportSettings.FileName = cboNames.Text & "_" & DateTime.Today.ToString("yyyy-MM-dd")
        RadGrid1.ExportSettings.ExportOnlyData = True
        RadGrid1.ExportSettings.IgnorePaging = True
        RadGrid1.ExportSettings.OpenInNewWindow = True
        RadGrid1.ExportSettings.UseItemStyles = False
        RadGrid1.ExportSettings.HideStructureColumns = True
        RadGrid1.MasterTableView.ShowFooter = True
    End Sub

    Private Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
        ConfigureExport()
        RadGrid1.MasterTableView.ExportToCSV()
        RadGrid1.Rebind()

    End Sub

    Protected Sub cboGroups_DataBound(sender As Object, e As EventArgs)
        If Not IsNothing(QueryGropu) Then
            Dim cb As RadComboBox = CType(sender, RadComboBox)
            Dim item = cboGroups.FindItemByText(QueryGropu)
            If Not IsNothing(item) Then
                item.Selected = True
                InitNamesReports()
            End If
            QueryGropu = Nothing
        End If

    End Sub
End Class
