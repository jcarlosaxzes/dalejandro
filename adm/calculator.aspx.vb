Imports Telerik.Web.UI
Public Class calculator
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Calculator"
            If (Not Page.IsPostBack) Then

                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewProposal") Then Response.RedirectPermanent("~/adm/schedule.aspx")

                Master.PageTitle = "Proposals/Calculator"
                Master.Help = "http://blog.pasconcept.com/2012/04/jobs-jobs-listhome-page.html"
                lblEmployeeEmail.Text = Master.UserEmail
                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)

                ' Default filter parameters
                RadDatePickerTo.DbSelectedDate = Date.Today
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Year, -3, RadDatePickerTo.DbSelectedDate)

                cboMeasure.DataBind()
                cboMeasure.SelectedValue = 12     ' Sq. Feet

                txtUnitFrom.DbValue = 1
                txtUnitTo.DbValue = 9999999

                cboDepartments.DataBind()

                ReadData(False)

            End If

        Catch ex As Exception

        End Try
    End Sub

    Private Sub btnFind_Click(sender As Object, e As EventArgs) Handles btnFind.Click
        ReadData(True)
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName

            Case "Exclude"
                Dim jobId As Integer = e.CommandArgument
                If jobId > 0 Then
                    lblExcludeJobsList.Text = lblExcludeJobsList.Text & IIf(Len(lblExcludeJobsList.Text) > 0, ",", "") & jobId
                    ReadData(True)
                End If

        End Select
    End Sub
    Private Function GetMultiCheckInList(Combo1 As RadComboBox) As String
        ' Companies...............................
        Dim ResultList As String = ""
        Dim collection As IList(Of RadComboBoxItem) = Combo1.CheckedItems
        If (collection.Count <> 0) Then

            For Each item As RadComboBoxItem In collection
                ResultList = ResultList + item.Value + ","
            Next
            ' Quitar la ultima coma
            ResultList = Left(ResultList, Len(ResultList) - 1)
            Return ResultList
        End If
    End Function
    Private Sub ReadData(bSghowCalculatorPanel As Boolean)
        lblDepartmentIdIN_List.Text = GetMultiCheckInList(cboDepartments)
        PanelSample.Visible = (bSghowCalculatorPanel And Len(lblDepartmentIdIN_List.Text) > 0)

        If PanelSample.Visible Then
            ClearData()
        End If

        collapseFilterCalculate.Visible = PanelSample.Visible

        RadHtmlChart1.DataBind()
        RadGrid1.DataBind()

        Dim UnitTo_OUT As Integer, RecNumbers_OUT As Integer
        Dim MIN_CosteByUnit As Double, AVG_CosteByUnit As Double, MAX_CosteByUnit As Double
        Dim MIN_HourByUnit As Double, AVG_HourByUnit As Double, MAX_HourByUnit As Double
        ' All Records
        LocalAPI.Jobs_Ratios_MinAvgMax(999999, RadDatePickerFrom.DbSelectedDate, RadDatePickerTo.DbSelectedDate, cboMeasure.SelectedValue, txtUnitFrom.DbValue, txtUnitTo.DbValue, lblDepartmentIdIN_List.Text, cboJobType.SelectedValue, lblExcludeJobsList.Text, cboClients.SelectedValue, lblCompanyId.Text, UnitTo_OUT, RecNumbers_OUT, MIN_CosteByUnit, AVG_CosteByUnit, MAX_CosteByUnit, MIN_HourByUnit, AVG_HourByUnit, MAX_HourByUnit)
        Label00.Text = "All Records (" & FormatNumber(RecNumbers_OUT, 0) & ")"
        Label01.Text = FormatNumber(txtUnitFrom.DbValue, 0)
        Label02.Text = FormatNumber(UnitTo_OUT, 0)
        Label03.Text = FormatNumber(MIN_CosteByUnit, 2)
        Label04.Text = FormatNumber(AVG_CosteByUnit, 2)
        Label05.Text = FormatNumber(MAX_CosteByUnit, 2)
        Label03.ToolTip = FormatNumber(MIN_HourByUnit, 2)
        Label04.ToolTip = FormatNumber(AVG_HourByUnit, 2)
        Label05.ToolTip = FormatNumber(MAX_HourByUnit, 2)

        ' Ranges
        lblRowCount.Text = "0"
        Dim PageSize As Integer = 0
        Select Case RecNumbers_OUT
            Case 26 To 50
                lblRowCount.Text = 2
            Case 51 To 75
                lblRowCount.Text = 3
            Case > 76
                lblRowCount.Text = 4
        End Select
        If lblRowCount.Text > 0 Then
            PageSize = RecNumbers_OUT / lblRowCount.Text + 1

            'Range 1
            Label11.Text = FormatNumber(txtUnitFrom.DbValue, 0)
            LocalAPI.Jobs_Ratios_MinAvgMax(PageSize, RadDatePickerFrom.DbSelectedDate, RadDatePickerTo.DbSelectedDate, cboMeasure.SelectedValue, txtUnitFrom.DbValue, txtUnitTo.DbValue, lblDepartmentIdIN_List.Text, cboJobType.SelectedValue, lblExcludeJobsList.Text, cboClients.SelectedValue, lblCompanyId.Text, UnitTo_OUT, RecNumbers_OUT, MIN_CosteByUnit, AVG_CosteByUnit, MAX_CosteByUnit, MIN_HourByUnit, AVG_HourByUnit, MAX_HourByUnit)
            Label10.Text = "Range 1 (" & FormatNumber(RecNumbers_OUT, 0) & ")"
            Label12.Text = FormatNumber(UnitTo_OUT, 0)
            Label13.Text = FormatNumber(MIN_CosteByUnit, 2)
            Label14.Text = FormatNumber(AVG_CosteByUnit, 2)
            Label15.Text = FormatNumber(MAX_CosteByUnit, 2)
            Label13.ToolTip = FormatNumber(MIN_HourByUnit, 2)
            Label14.ToolTip = FormatNumber(AVG_HourByUnit, 2)
            Label15.ToolTip = FormatNumber(MAX_HourByUnit, 2)

            'Range 2
            Label21.Text = FormatNumber(UnitTo_OUT, 0)
            LocalAPI.Jobs_Ratios_MinAvgMax(IIf(lblRowCount.Text > 2, PageSize, 999999), RadDatePickerFrom.DbSelectedDate, RadDatePickerTo.DbSelectedDate, cboMeasure.SelectedValue, UnitTo_OUT, txtUnitTo.DbValue, lblDepartmentIdIN_List.Text, cboJobType.SelectedValue, lblExcludeJobsList.Text, cboClients.SelectedValue, lblCompanyId.Text, UnitTo_OUT, RecNumbers_OUT, MIN_CosteByUnit, AVG_CosteByUnit, MAX_CosteByUnit, MIN_HourByUnit, AVG_HourByUnit, MAX_HourByUnit)
            Label20.Text = "Range 2 (" & FormatNumber(RecNumbers_OUT, 0) & ")"
            Label22.Text = FormatNumber(UnitTo_OUT, 0)
            Label23.Text = FormatNumber(MIN_CosteByUnit, 2)
            Label24.Text = FormatNumber(AVG_CosteByUnit, 2)
            Label25.Text = FormatNumber(MAX_CosteByUnit, 2)
            Label23.ToolTip = FormatNumber(MIN_HourByUnit, 2)
            Label24.ToolTip = FormatNumber(AVG_HourByUnit, 2)
            Label25.ToolTip = FormatNumber(MAX_HourByUnit, 2)
        End If

        If lblRowCount.Text >= 3 Then
            'Range 3
            Label31.Text = FormatNumber(UnitTo_OUT, 0)
            LocalAPI.Jobs_Ratios_MinAvgMax(IIf(lblRowCount.Text > 3, PageSize, 999999), RadDatePickerFrom.DbSelectedDate, RadDatePickerTo.DbSelectedDate, cboMeasure.SelectedValue, UnitTo_OUT, txtUnitTo.DbValue, lblDepartmentIdIN_List.Text, cboJobType.SelectedValue, lblExcludeJobsList.Text, cboClients.SelectedValue, lblCompanyId.Text, UnitTo_OUT, RecNumbers_OUT, MIN_CosteByUnit, AVG_CosteByUnit, MAX_CosteByUnit, MIN_HourByUnit, AVG_HourByUnit, MAX_HourByUnit)
            Label30.Text = "Range 3 (" & FormatNumber(RecNumbers_OUT, 0) & ")"
            Label32.Text = FormatNumber(UnitTo_OUT, 0)
            Label33.Text = FormatNumber(MIN_CosteByUnit, 2)
            Label34.Text = FormatNumber(AVG_CosteByUnit, 2)
            Label35.Text = FormatNumber(MAX_CosteByUnit, 2)
            Label33.ToolTip = FormatNumber(MIN_HourByUnit, 2)
            Label34.ToolTip = FormatNumber(AVG_HourByUnit, 2)
            Label35.ToolTip = FormatNumber(MAX_HourByUnit, 2)

        End If

        If lblRowCount.Text = 4 Then
            'Range 3
            Label41.Text = FormatNumber(UnitTo_OUT, 0)
            LocalAPI.Jobs_Ratios_MinAvgMax(999999, RadDatePickerFrom.DbSelectedDate, RadDatePickerTo.DbSelectedDate, cboMeasure.SelectedValue, UnitTo_OUT, txtUnitTo.DbValue, lblDepartmentIdIN_List.Text, cboJobType.SelectedValue, lblExcludeJobsList.Text, cboClients.SelectedValue, lblCompanyId.Text, UnitTo_OUT, RecNumbers_OUT, MIN_CosteByUnit, AVG_CosteByUnit, MAX_CosteByUnit, MIN_HourByUnit, AVG_HourByUnit, MAX_HourByUnit)
            Label40.Text = "Range 4 (" & FormatNumber(RecNumbers_OUT, 0) & ")"
            Label42.Text = FormatNumber(UnitTo_OUT, 0)
            Label43.Text = FormatNumber(MIN_CosteByUnit, 2)
            Label44.Text = FormatNumber(AVG_CosteByUnit, 2)
            Label45.Text = FormatNumber(MAX_CosteByUnit, 2)
            Label43.ToolTip = FormatNumber(MIN_HourByUnit, 2)
            Label44.ToolTip = FormatNumber(AVG_HourByUnit, 2)
            Label45.ToolTip = FormatNumber(MAX_HourByUnit, 2)

        End If
    End Sub

    Private Sub btnCalculate_Click(sender As Object, e As EventArgs) Handles btnCalculate.Click
        Dim CostByUnitRate As Double
        Dim HourByUnitRate As Double
        Select Case cboEstimatedType.SelectedValue
            Case 0      'All MAX
                CostByUnitRate = IIf(Len(Label05.Text) > 0, Label05.Text, 0)
                HourByUnitRate = IIf(Len(Label05.ToolTip) > 0, Label05.ToolTip, 0)
            Case 1      'All AVG
                CostByUnitRate = IIf(Len(Label04.Text) > 0, Label04.Text, 0)
                HourByUnitRate = IIf(Len(Label04.ToolTip) > 0, Label04.ToolTip, 0)
            Case 2      'All MIN
                CostByUnitRate = IIf(Len(Label03.Text) > 0, Label03.Text, 0)
                HourByUnitRate = IIf(Len(Label03.ToolTip) > 0, Label03.ToolTip, 0)
            Case 3  'Range MAX
                Select Case GetRangeRow()
                    Case 1
                        CostByUnitRate = IIf(Len(Label15.Text) > 0, Label15.Text, 0)
                        HourByUnitRate = IIf(Len(Label15.ToolTip) > 0, Label15.ToolTip, 0)
                    Case 2
                        CostByUnitRate = IIf(Len(Label25.Text) > 0, Label25.Text, 0)
                        HourByUnitRate = IIf(Len(Label25.ToolTip) > 0, Label25.ToolTip, 0)
                    Case 3
                        CostByUnitRate = IIf(Len(Label35.Text) > 0, Label35.Text, 0)
                        HourByUnitRate = IIf(Len(Label35.ToolTip) > 0, Label35.ToolTip, 0)
                    Case 4
                        CostByUnitRate = IIf(Len(Label45.Text) > 0, Label45.Text, 0)
                        HourByUnitRate = IIf(Len(Label45.ToolTip) > 0, Label45.ToolTip, 0)
                End Select
            Case 4
                Select Case GetRangeRow()
                    Case 1
                        CostByUnitRate = IIf(Len(Label14.Text) > 0, Label14.Text, 0)
                        HourByUnitRate = IIf(Len(Label14.ToolTip) > 0, Label14.ToolTip, 0)
                    Case 2
                        CostByUnitRate = IIf(Len(Label24.Text) > 0, Label24.Text, 0)
                        HourByUnitRate = IIf(Len(Label24.ToolTip) > 0, Label24.ToolTip, 0)
                    Case 3
                        CostByUnitRate = IIf(Len(Label34.Text) > 0, Label34.Text, 0)
                        HourByUnitRate = IIf(Len(Label34.ToolTip) > 0, Label34.ToolTip, 0)
                    Case 4
                        CostByUnitRate = IIf(Len(Label44.Text) > 0, Label44.Text, 0)
                        HourByUnitRate = IIf(Len(Label44.ToolTip) > 0, Label44.ToolTip, 0)
                End Select
            Case 5
                Select Case GetRangeRow()
                    Case 1
                        CostByUnitRate = IIf(Len(Label13.Text) > 0, Label13.Text, 0)
                        HourByUnitRate = IIf(Len(Label13.ToolTip) > 0, Label13.ToolTip, 0)
                    Case 2
                        CostByUnitRate = IIf(Len(Label23.Text) > 0, Label23.Text, 0)
                        HourByUnitRate = IIf(Len(Label23.ToolTip) > 0, Label23.ToolTip, 0)
                    Case 3
                        CostByUnitRate = IIf(Len(Label33.Text) > 0, Label33.Text, 0)
                        HourByUnitRate = IIf(Len(Label33.ToolTip) > 0, Label33.ToolTip, 0)
                    Case 4
                        CostByUnitRate = IIf(Len(Label43.Text) > 0, Label43.Text, 0)
                        HourByUnitRate = IIf(Len(Label43.ToolTip) > 0, Label43.ToolTip, 0)
                End Select
        End Select
        txtCostRate.DbValue = CostByUnitRate
        txtTimeRate.DbValue = HourByUnitRate
        lblEstimatedCost.Text = FormatCurrency(txtEstimatedUnit.DbValue * CostByUnitRate, 2)
        lblEstimatedTime.Text = FormatNumber(txtEstimatedUnit.DbValue * HourByUnitRate / 8, 0)
    End Sub
    Private Function GetRangeRow() As Integer
        Dim Row As Integer = 0
        If lblRowCount.Text > 0 Then
            If txtEstimatedUnit.DbValue >= Val(Label11.Text) And txtEstimatedUnit.DbValue < Val(Label12.Text) Then
                Row = 1
            End If
            If txtEstimatedUnit.DbValue >= Val(Label21.Text) And txtEstimatedUnit.DbValue < Val(Label22.Text) Then
                Row = 2
            End If
            If txtEstimatedUnit.DbValue >= Val(Label31.Text) And txtEstimatedUnit.DbValue < Val(Label32.Text) Then
                ' Range3
                RangeStyle(3)
                Return 3
            End If
            If txtEstimatedUnit.DbValue >= Val(Label41.Text) And txtEstimatedUnit.DbValue < Val(Label42.Text) Then
                ' Range4
                RangeStyle(4)
                Return 4
            End If
            If Row = 0 Then
                Select Case lblRowCount.Text
                    Case 1, 2
                        Row = 2
                    Case 3, 4
                        Row = lblRowCount.Text
                End Select
            End If
            RangeStyle(Row)
            Return Row
        End If

    End Function
    Private Sub RangeStyle(Range As Integer)
        Label10.ForeColor = System.Drawing.Color.DarkGray
        Label20.ForeColor = System.Drawing.Color.DarkGray
        Label30.ForeColor = System.Drawing.Color.DarkGray
        Label40.ForeColor = System.Drawing.Color.DarkGray

        Select Case Range
            Case 1
                Label10.ForeColor = System.Drawing.Color.Red
            Case 2
                Label20.ForeColor = System.Drawing.Color.Red
            Case 3
                Label30.ForeColor = System.Drawing.Color.Red
            Case 4
                Label40.ForeColor = System.Drawing.Color.Red
        End Select
    End Sub
    Private Sub ClearData()
        Label00.Text = ""
        Label01.Text = ""
        Label02.Text = ""
        Label03.Text = ""
        Label04.Text = ""
        Label05.Text = ""
        Label10.Text = ""
        Label11.Text = ""
        Label12.Text = ""
        Label13.Text = ""
        Label14.Text = ""
        Label15.Text = ""
        Label20.Text = ""
        Label21.Text = ""
        Label22.Text = ""
        Label23.Text = ""
        Label24.Text = ""
        Label25.Text = ""
        Label30.Text = ""
        Label31.Text = ""
        Label32.Text = ""
        Label33.Text = ""
        Label34.Text = ""
        Label35.Text = ""
        Label40.Text = ""
        Label41.Text = ""
        Label42.Text = ""
        Label43.Text = ""
        Label44.Text = ""
        Label45.Text = ""
    End Sub

End Class
