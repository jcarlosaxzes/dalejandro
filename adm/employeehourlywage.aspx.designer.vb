﻿'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated by a tool.
'
'     Changes to this file may cause incorrect behavior and will be lost if
'     the code is regenerated. 
' </auto-generated>
'------------------------------------------------------------------------------

Option Strict On
Option Explicit On


Partial Public Class employeehourlywage

    '''<summary>
    '''btnBack control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents btnBack As Global.System.Web.UI.WebControls.LinkButton

    '''<summary>
    '''btnReviewSalary control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents btnReviewSalary As Global.System.Web.UI.WebControls.LinkButton

    '''<summary>
    '''lblEmployeeName control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblEmployeeName As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lblYear control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblYear As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''RadHtmlChart1 control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents RadHtmlChart1 As Global.Telerik.Web.UI.RadHtmlChart

    '''<summary>
    '''RadGridHourlyWage control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents RadGridHourlyWage As Global.Telerik.Web.UI.RadGrid

    '''<summary>
    '''RadToolTipReview control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents RadToolTipReview As Global.Telerik.Web.UI.RadToolTip

    '''<summary>
    '''RadDatePickerFrom control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents RadDatePickerFrom As Global.Telerik.Web.UI.RadDatePicker

    '''<summary>
    '''txtHourlyRate control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents txtHourlyRate As Global.Telerik.Web.UI.RadNumericTextBox

    '''<summary>
    '''RadNumericProducer control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents RadNumericProducer As Global.Telerik.Web.UI.RadNumericTextBox

    '''<summary>
    '''RadNumericHour control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents RadNumericHour As Global.Telerik.Web.UI.RadNumericTextBox

    '''<summary>
    '''txtBenefits_vacations control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents txtBenefits_vacations As Global.Telerik.Web.UI.RadNumericTextBox

    '''<summary>
    '''txtBenefits_personals control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents txtBenefits_personals As Global.Telerik.Web.UI.RadNumericTextBox

    '''<summary>
    '''btnReviewSalaryConfirmed control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents btnReviewSalaryConfirmed As Global.System.Web.UI.WebControls.LinkButton

    '''<summary>
    '''SqlDataSourceHourlyWage control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents SqlDataSourceHourlyWage As Global.System.Web.UI.WebControls.SqlDataSource

    '''<summary>
    '''SqlDataSourceChart control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents SqlDataSourceChart As Global.System.Web.UI.WebControls.SqlDataSource

    '''<summary>
    '''lblEmployeeId control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblEmployeeId As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lblEmployeeEmail control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblEmployeeEmail As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lblCompanyId control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblCompanyId As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lblMonthUpdated control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblMonthUpdated As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lblDepartmentId control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblDepartmentId As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lblHourlyWageHistoryId control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblHourlyWageHistoryId As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''Master property.
    '''</summary>
    '''<remarks>
    '''Auto-generated property.
    '''</remarks>
    Public Shadows ReadOnly Property Master() As pasconcept20.ADM_Main_Responsive
        Get
            Return CType(MyBase.Master, pasconcept20.ADM_Main_Responsive)
        End Get
    End Property
End Class
