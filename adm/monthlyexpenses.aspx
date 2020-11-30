<%@ Page Title="Company Expenses" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="monthlyexpenses.aspx.vb" Inherits="pasconcept20.monthlyexpenses" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGridExpenses">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridExpenses" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnExpensesImport">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnExpensesImport" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridExpenses" />
                    <telerik:AjaxUpdatedControl ControlID="cboYear" />
                    <telerik:AjaxUpdatedControl ControlID="RadListBoxImportError" />
                    <telerik:AjaxUpdatedControl ControlID="RadUploadExpenses1" />
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipImport" />

                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnImportPayroll">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnImportPayroll" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridPayroll" />
                    <telerik:AjaxUpdatedControl ControlID="cboYear" />
                    <telerik:AjaxUpdatedControl ControlID="RadListBoxImportError" />
                    <telerik:AjaxUpdatedControl ControlID="RadAsyncUploadPayroll" />
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipImport" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnFind" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridExpenses" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridPayroll" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridMonthly" />
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChartMonthly" />
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChartYearly" />
                    <telerik:AjaxUpdatedControl ControlID="FloatedTilesListView" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" EnableEmbeddedSkins="false" />
    <style>
        .RadListView .rlvFloated {
            display: block;
        }

        .RadListView .rlvAutoScroll .rlvI, .RadListView .rlvAutoScroll .rlvA, .RadListView .rlvAutoScroll .rlvISel, .RadListView .rlvAutoScroll .rlvIEmpty, .RadListView .rlvAutoScroll .rlvIEdit {
            overflow: auto;
        }

        .RadListView .rlvFloated .rlvI, .RadListView .rlvFloated .rlvA, .RadListView .rlvFloated .rlvISel, .RadListView .rlvFloated .rlvIEmpty, .RadListView .rlvFloated .rlvIEdit {
            float: left;
            display: inline;
            border: 1px solid;
        }

        .RadListView div.rlvI, .RadListView div.rlvA, .RadListView div.rlvISel, .RadListView div.rlvIEmpty, .RadListView div.rlvIEdit {
            border-bottom: 1px solid;
            padding-top: 5px;
            padding-bottom: 4px;
        }

        .productItemWrapper {
            height: 220px;
            width: 310px;
            margin: 3px;
            padding-left: 10px;
        }
    </style>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Expenses</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
           
            </button>
            <button class="btn btn-dark" type="button" data-toggle="collapse" data-target="#collapseImport" aria-expanded="false" aria-controls="collapseImport" title="Show/Hide Import expenses panel">
                Import Expenses
           
            </button>
            <button class="btn btn-dark" type="button" data-toggle="collapse" data-target="#collapseImportP" aria-expanded="false" aria-controls="collapseImportP" title="Show/Hide Import payroll panel">
                Import Payroll
           
            </button>
            <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" CausesValidation="true">
                    Add Expense
            </asp:LinkButton>
        </span>
    </div>

    <%--Filter Panel--%>
    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind" class="pasconcept-bar">
            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="width: 200px">
                        <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear" Label="  Year:"
                            DataTextField="nYear" DataValueField="Year" Width="100%" AppendDataBoundItems="True">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Years...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>

                    <td style="width: 300px">
                        <telerik:RadComboBox ID="cboVendors" runat="server" DataSourceID="SqlDataSourceVendors"
                            Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Vendors...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 300px">
                        <telerik:RadComboBox ID="cboCategory" runat="server" DataSourceID="SqlDataSourceCategory"
                            Width="100%" DataTextField="Name" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Categories...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="text-align: right"></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" MarkFirstMatch="True" AutoPostBack="true"
                            Width="100%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(Select Department...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboEmployees" runat="server" DataSourceID="SqlDataSourceEmployees" MarkFirstMatch="True"
                            Width="100%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="text-align: right">
                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="true">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>

                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>

    <%--Import Expenses Panel--%>
    <div class="collapse pasconcept-bar" id="collapseImport">
        <div>
            <h4 style="margin: 0">Instructions for importing Expenses files</h4>
            <ul>
                <li>Ensure your CSV file adheres to the PASconcept structure: (ExpDate, Type, No., Payee, Category, Memo, Amount). <a href="https://app.pasconcept.com/csv/expenses.csv" target="_blank">Click to download</a> sample csv file. <a href="https://c25.qbo.intuit.com/app/expenses" target="_blank">Intuit QuickBooks exports Expenses </a>using this structure</li>
                <li>Select Import Mode, Select File and click Import button</li>
            </ul>

            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="width: 100px; text-align: right">Import Year:
                    </td>
                    <td style="width: 100px">

                        <telerik:RadNumericTextBox ID="txtYear" runat="server" Width="100%" MinValue="2000">
                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                        </telerik:RadNumericTextBox>
                    </td>
                    <td style="width: 500px">
                        <telerik:RadComboBox ID="cboImportMode" runat="server" Width="100%" AppendDataBoundItems="True" ValidationGroup="Import">
                            <Items>
                                <telerik:RadComboBoxItem Text="(Select Import Mode...)" Value="-1" />
                                <telerik:RadComboBoxItem Text="DELETE all records for the selected year, then Import new records" Value="0" />
                                <telerik:RadComboBoxItem Text="Add imported records to existing entries" Value="1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 300px; text-align: right">
                        <telerik:RadAsyncUpload ID="RadUploadExpenses1" runat="server" ControlObjectsVisibility="None" MultipleFileSelection="Disabled" EnableFileInputSkinning="true"
                            AllowedFileExtensions="csv,txt" RenderMode="Classic">
                        </telerik:RadAsyncUpload>
                    </td>
                    <td style="padding-left: 50px; vertical-align: bottom">

                        <asp:LinkButton ID="btnExpensesImport" runat="server" ToolTip="Import Company Overhead.CSV files with columns(Date, Category, Amount)"
                            CssClass="btn btn-info btn" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="Import">
                                     <i class="fas fa-upload"></i>&nbsp;Import Expenses
                        </asp:LinkButton>
                    </td>
                    <td style="padding-left: 50px; vertical-align: bottom">

                        <asp:LinkButton ID="btnExpensesImportQb" runat="server" ToolTip="Import Expenses from Quickbooks"
                            CssClass="btn btn-info btn" UseSubmitBehavior="false" >
                                     <i class="fas fa-upload"></i>&nbsp;Import Expenses from Quickbooks
                        </asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Select Import Mode...)" ForeColor="Red"
                            Operator="NotEqual" ControlToValidate="cboImportMode" Display="Dynamic" ErrorMessage="Select Import Mode" SetFocusOnError="true" ValidationGroup="Import">
                        </asp:CompareValidator>
                    </td>
                </tr>

            </table>
        </div>
    </div>

    <%--Import Payroll Panel--%>
    <div class="collapse pasconcept-bar" id="collapseImportP">
        <div>
            <h4 style="margin: 0">Instructions for importing Payrolls files</h4>
            <ul>
                <li>Ensure your CSV file adheres to the PASconcept structure: (Check Date,Name,Net Amount,,Total Hours,Taxes Withheld,Total Deductions,Total Pay,Employer Taxes,Company Contributions,Total Cost,Check Num). <a href="https://app.pasconcept.com/csv/payroll.csv" target="_blank">Click to download</a> sample csv file. <a href="https://c25.qbo.intuit.com/app/payrollreport?h=reports&arg1=paystubs&rptid=9418890136-PC_PAYSTUBS-paystubs-1596286830976" target="_blank">Intuit QuickBooks exports Payroll Summary Report </a>using this structure</li>
                <li>Select Import Mode, Select File and click Import button</li>
            </ul>

            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="width: 100px; text-align: right">Import Year:
                    </td>
                    <td style="width: 100px">

                        <telerik:RadNumericTextBox ID="txtYearPayroll" runat="server" Width="100%" MinValue="2000">
                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                        </telerik:RadNumericTextBox>
                    </td>
                    <td style="width: 500px">
                        <telerik:RadComboBox ID="cboImportPayrollMode" runat="server" Width="100%" AppendDataBoundItems="True" ValidationGroup="ImportPayroll">
                            <Items>
                                <telerik:RadComboBoxItem Text="(Select Import Mode...)" Value="-1" />
                                <telerik:RadComboBoxItem Text="DELETE all records for the selected year, then Import new records" Value="0" />
                                <telerik:RadComboBoxItem Text="Add imported records to existing entries" Value="1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 300px; text-align: right">
                        <telerik:RadAsyncUpload ID="RadAsyncUploadPayroll" runat="server" ControlObjectsVisibility="None" MultipleFileSelection="Disabled" EnableFileInputSkinning="true"
                            AllowedFileExtensions="csv,txt" RenderMode="Classic">
                        </telerik:RadAsyncUpload>
                    </td>
                    <td style="padding-left: 50px; vertical-align: bottom">

                        <asp:LinkButton ID="btnImportPayroll" runat="server" ToolTip="Import Company Overhead.CSV files with columns(Date, Category, Amount)"
                            CssClass="btn btn-info btn" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="ImportPayroll">
                                     <i class="fas fa-upload"></i>&nbsp;Import Payroll
                        </asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Select Import Mode...)" ForeColor="Red"
                            Operator="NotEqual" ControlToValidate="cboImportPayrollMode" Display="Dynamic" ErrorMessage="Select Import Mode" SetFocusOnError="true" ValidationGroup="ImportPayroll">
                        </asp:CompareValidator>
                    </td>
                </tr>

            </table>
        </div>
    </div>

    <telerik:RadWizard ID="RadWizard1" runat="server" Width="100%" Height="1200px" DisplayProgressBar="false" DisplayCancelButton="false" DisplayNavigationButtons="false" Skin="Silk">
        <WizardSteps>

            <telerik:RadWizardStep Title="Monthly/Yearly Charts">
                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td colspan="2">
                            <h4>Monthly Expenses</h4>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 65%">
                            <telerik:RadHtmlChart ID="RadHtmlChartMonthly" runat="server" DataSourceID="SqlDataSourceMonthly" Height="500px" Width="95%">
                                <PlotArea>
                                    <Series>
                                        <telerik:AreaSeries DataFieldY="Total" Name="Total = Expenses + Payroll">
                                            <Appearance FillStyle-BackgroundColor="Red"></Appearance>
                                            <LabelsAppearance Visible="false"></LabelsAppearance>
                                            <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                                        </telerik:AreaSeries>
                                        <telerik:LineSeries DataFieldY="Expenses" Name="Expenses">
                                            <LabelsAppearance Visible="false" DataFormatString="{0:N2}">
                                            </LabelsAppearance>
                                            <Appearance>
                                                <FillStyle BackgroundColor="Red" />
                                            </Appearance>
                                            <LineAppearance LineStyle="Smooth" Width="3" />
                                            <TooltipsAppearance DataFormatString="{0:N2}" Color="White"></TooltipsAppearance>
                                            <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                        </telerik:LineSeries>
                                        <telerik:LineSeries DataFieldY="Payroll" Name="Payroll">
                                            <LabelsAppearance Visible="false" DataFormatString="{0:N2}">
                                            </LabelsAppearance>
                                            <Appearance>
                                                <FillStyle BackgroundColor="Blue" />
                                            </Appearance>
                                            <LineAppearance LineStyle="Smooth" Width="3" />
                                            <TooltipsAppearance DataFormatString="{0:N2}" Color="White"></TooltipsAppearance>
                                            <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                        </telerik:LineSeries>
                                    </Series>
                                    <YAxis Name="LeftAxis" MajorTickSize="4" MajorTickType="Outside" Width="3">
                                        <TitleAppearance Text="$"></TitleAppearance>
                                        <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                        <MinorGridLines Visible="false"></MinorGridLines>
                                    </YAxis>
                                    <XAxis DataLabelsField="Month">
                                        <TitleAppearance Text="Month"></TitleAppearance>
                                        <MinorGridLines Visible="false"></MinorGridLines>
                                        <AxisCrossingPoints>
                                            <telerik:AxisCrossingPoint Value="0" />
                                            <telerik:AxisCrossingPoint Value="9999" />
                                        </AxisCrossingPoints>
                                    </XAxis>
                                </PlotArea>
                                <Legend>
                                    <Appearance Visible="True" Position="Top">
                                        <TextStyle FontSize="14" Bold="true" FontFamily="Sans-Serif" />
                                        <ClientTemplate>
                                                #= text #&nbsp;
                                        </ClientTemplate>
                                    </Appearance>

                                </Legend>
                            </telerik:RadHtmlChart>
                        </td>
                        <td>
                            <telerik:RadGrid ID="RadGridMonthly" runat="server" Width="95%"
                                ShowFooter="true"
                                ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" HeaderStyle-Font-Size="Small"
                                AutoGenerateColumns="False" DataSourceID="SqlDataSourceMonthly" AllowPaging="true" PageSize="12"
                                HeaderStyle-HorizontalAlign="Center">
                                <MasterTableView DataSourceID="SqlDataSourceMonthly">
                                    <Columns>
                                        <telerik:GridNumericColumn DataField="Year" HeaderText="Year" SortExpression="Year" UniqueName="Year" ItemStyle-HorizontalAlign="Center">
                                        </telerik:GridNumericColumn>
                                        <telerik:GridNumericColumn DataField="Month" HeaderText="Month" SortExpression="Month" UniqueName="Month" ItemStyle-HorizontalAlign="Center">
                                        </telerik:GridNumericColumn>
                                        <telerik:GridNumericColumn DataField="Expenses" HeaderText="Expenses" SortExpression="Expenses" UniqueName="Expenses" DataFormatString="{0:C2}" ItemStyle-HorizontalAlign="Right"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                                        </telerik:GridNumericColumn>
                                        <telerik:GridNumericColumn DataField="Payroll" HeaderText="Payroll" SortExpression="Payroll" UniqueName="Payroll" DataFormatString="{0:C2}" ItemStyle-HorizontalAlign="Right"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                                        </telerik:GridNumericColumn>
                                        <telerik:GridNumericColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataFormatString="{0:C2}" ItemStyle-HorizontalAlign="Right"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                                        </telerik:GridNumericColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <h4>Yearly Expenses</h4>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadHtmlChart ID="RadHtmlChartYearly" runat="server" DataSourceID="SqlDataSourceChartByYear" Height="400px" Width="95%">
                                <PlotArea>
                                    <Series>
                                        <telerik:AreaSeries DataFieldY="Total" Name="Total = Expenses + Payroll">
                                            <Appearance FillStyle-BackgroundColor="Red"></Appearance>
                                            <LabelsAppearance Visible="false"></LabelsAppearance>
                                            <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                                        </telerik:AreaSeries>


                                        <telerik:LineSeries DataFieldY="Expenses" Name="Expenses">
                                            <LabelsAppearance Visible="false" DataFormatString="{0:N2}">
                                            </LabelsAppearance>
                                            <Appearance>
                                                <FillStyle BackgroundColor="Red" />
                                            </Appearance>
                                            <LineAppearance LineStyle="Smooth" Width="3" />
                                            <TooltipsAppearance DataFormatString="{0:N2}" Color="White"></TooltipsAppearance>
                                            <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                        </telerik:LineSeries>
                                        <telerik:LineSeries DataFieldY="Payroll" Name="Payroll">
                                            <LabelsAppearance Visible="false" DataFormatString="{0:N2}">
                                            </LabelsAppearance>
                                            <Appearance>
                                                <FillStyle BackgroundColor="Blue" />
                                            </Appearance>
                                            <LineAppearance LineStyle="Smooth" Width="3" />
                                            <TooltipsAppearance DataFormatString="{0:N2}" Color="White"></TooltipsAppearance>
                                            <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                        </telerik:LineSeries>


                                    </Series>
                                    <XAxis DataLabelsField="Year">
                                        <TitleAppearance Text="Year"></TitleAppearance>
                                        <MinorGridLines Visible="false"></MinorGridLines>
                                    </XAxis>
                                    <YAxis MajorTickSize="4" MajorTickType="Outside" MinorTickSize="1">
                                        <LabelsAppearance DataFormatString="{0:C0}"></LabelsAppearance>
                                        <MinorGridLines Visible="false"></MinorGridLines>
                                    </YAxis>
                                </PlotArea>
                                <Legend>
                                    <Appearance Visible="True" Position="Top">
                                        <TextStyle FontSize="14" Bold="true" FontFamily="Sans-Serif" />
                                        <ClientTemplate>
                                                #= text #&nbsp;
                                        </ClientTemplate>
                                    </Appearance>

                                </Legend>
                            </telerik:RadHtmlChart>
                        </td>
                        <td>
                            <telerik:RadGrid ID="RadGridYearly" runat="server" Width="95%"
                                ShowFooter="true" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" HeaderStyle-Font-Size="Small"
                                AutoGenerateColumns="False" DataSourceID="SqlDataSourceChartByYear" AllowPaging="true" PageSize="12"
                                HeaderStyle-HorizontalAlign="Center">
                                <MasterTableView DataSourceID="SqlDataSourceChartByYear">
                                    <Columns>
                                        <telerik:GridNumericColumn DataField="Year" HeaderText="Year" SortExpression="Year" UniqueName="Year" ItemStyle-HorizontalAlign="Center">
                                        </telerik:GridNumericColumn>
                                        <telerik:GridNumericColumn DataField="Expenses" HeaderText="Expenses" SortExpression="Expenses" UniqueName="Expenses" DataFormatString="{0:C2}" ItemStyle-HorizontalAlign="Right"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                                        </telerik:GridNumericColumn>
                                        <telerik:GridNumericColumn DataField="Payroll" HeaderText="Payroll" SortExpression="Payroll" UniqueName="Payroll" DataFormatString="{0:C2}" ItemStyle-HorizontalAlign="Right"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                                        </telerik:GridNumericColumn>
                                        <telerik:GridNumericColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataFormatString="{0:C2}" ItemStyle-HorizontalAlign="Right"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                                        </telerik:GridNumericColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                </table>

            </telerik:RadWizardStep>

            <telerik:RadWizardStep Title="Monthly Category Chart">
                <telerik:RadListView runat="server" ID="FloatedTilesListView" RenderMode="Lightweight" AllowPaging="True"
                    DataKeyNames="Category" DataSourceID="SqlDataSourceGroupByCategory">
                    <AlternatingItemTemplate>

                        <div class="rlvA productItemWrapper">
                            <h5 style="margin: 0; text-align: center">
                                <asp:Label ID="lblAlternatingCategory" runat="server" Font-Bold="true" Text='<%# Eval("Category") %>'></asp:Label>
                            </h5>

                            <div style="margin: 0; text-align: right; padding-right: 5px; font-size: 16px; font-weight: 500; color: darkblue"><%# Eval("Tot", "{0:C2}")%></div>
                            <telerik:RadHtmlChart ID="RainfallChart" runat="server" Width="100%" Height="150px" DataSourceID="SqlDataSourceItemAlternating">
                                <Legend>
                                    <Appearance Visible="false">
                                    </Appearance>
                                </Legend>
                                <PlotArea>
                                    <CommonTooltipsAppearance Color="White" />
                                    <Series>
                                        <telerik:ColumnSeries DataFieldY="Amount" Name="Amount">
                                            <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>
                                            <LabelsAppearance Visible="false"></LabelsAppearance>
                                            <TooltipsAppearance DataFormatString="{0:C2}"></TooltipsAppearance>
                                        </telerik:ColumnSeries>
                                    </Series>
                                    <XAxis DataLabelsField="MonthCode">
                                        <MajorGridLines Visible="false" />
                                        <MinorGridLines Visible="false" />
                                        <LabelsAppearance>
                                            <TextStyle FontSize="10px" />
                                        </LabelsAppearance>
                                    </XAxis>
                                    <YAxis>
                                        <MajorGridLines Visible="true" />
                                        <MajorGridLines Color="#EFEFEF" Width="1"></MajorGridLines>
                                        <MinorGridLines Visible="false" />
                                        <LabelsAppearance DataFormatString="{0:N0}">
                                            <TextStyle FontSize="10px" />
                                        </LabelsAppearance>
                                    </YAxis>
                                </PlotArea>
                            </telerik:RadHtmlChart>

                            <asp:SqlDataSource ID="SqlDataSourceItemAlternating" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                                SelectCommand="YearStadistic_ExpensesItem_Chart" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="lblAlternatingCategory" Name="category" PropertyName="Text" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </AlternatingItemTemplate>
                    <ItemTemplate>
                        <div class="rlvI productItemWrapper">
                            <h5 style="margin: 0; text-align: center">
                                <asp:Label ID="lblItemCategory" runat="server" Font-Bold="true" Text='<%# Eval("Category") %>'></asp:Label>
                            </h5>
                            <div style="margin: 0; text-align: right; padding-right: 5px; font-size: 16px; font-weight: 500; color: darkblue"><%# Eval("Tot", "{0:C2}")%></div>
                            <telerik:RadHtmlChart ID="SunshineChart" runat="server" Width="100%" Height="150px" DataSourceID="SqlDataSourceItem">
                                <Legend>
                                    <Appearance Visible="false">
                                    </Appearance>
                                </Legend>
                                <PlotArea>
                                    <CommonTooltipsAppearance Color="White" />
                                    <Series>
                                        <telerik:ColumnSeries DataFieldY="Amount" Name="Amount">
                                            <Appearance FillStyle-BackgroundColor="Blue"></Appearance>
                                            <LabelsAppearance Visible="false"></LabelsAppearance>
                                            <TooltipsAppearance DataFormatString="{0:C2}"></TooltipsAppearance>
                                        </telerik:ColumnSeries>
                                    </Series>
                                    <XAxis DataLabelsField="MonthCode">
                                        <MajorGridLines Visible="false" />
                                        <MinorGridLines Visible="false" />
                                        <LabelsAppearance>
                                            <TextStyle FontSize="10px" />
                                        </LabelsAppearance>
                                    </XAxis>
                                    <YAxis>
                                        <MajorGridLines Visible="true" />
                                        <MajorGridLines Color="#EFEFEF" Width="1"></MajorGridLines>
                                        <MinorGridLines Visible="false" />
                                        <LabelsAppearance DataFormatString="{0:N0}">
                                            <TextStyle FontSize="10px" />
                                        </LabelsAppearance>
                                    </YAxis>
                                </PlotArea>
                            </telerik:RadHtmlChart>

                            <asp:SqlDataSource ID="SqlDataSourceItem" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                                SelectCommand="YearStadistic_ExpensesItem_Chart" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="lblItemCategory" Name="category" PropertyName="Text" />

                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <div class="RadListView RadListView_<%# Container.Skin %>">
                            <div class="rlvEmpty">
                                There are no items to be displayed.
                           
                            </div>
                        </div>
                    </EmptyDataTemplate>
                    <LayoutTemplate>
                        <div class="RadListView RadListViewFloated ">
                            <div class="rlvFloated rlvAutoScroll">
                                <div id="itemPlaceholder" runat="server">
                                </div>
                            </div>
                            <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPager1" runat="server" PageSize="60">
                                <Fields>
                                    <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                                </Fields>
                            </telerik:RadDataPager>
                        </div>
                    </LayoutTemplate>
                </telerik:RadListView>

            </telerik:RadWizardStep>

            <telerik:RadWizardStep Title="Expenses Details">

                <telerik:RadGrid ID="RadGridExpenses" runat="server" AllowAutomaticDeletes="True" ItemStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center"
                    AlternatingItemStyle-Font-Size="Small" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AllowPaging="True" ShowFooter="true"
                    AutoGenerateColumns="False" DataSourceID="SqlDataSourceExpenses" Height="900px" PageSize="100" AllowSorting="true" HeaderStyle-Font-Size="Small">
                    <ClientSettings>
                        <Scrolling AllowScroll="True" SaveScrollPosition="true"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="Id"
                        DataSourceID="SqlDataSourceExpenses" HorizontalAlign="NotSet" AutoGenerateColumns="False" CssClass="table-sm">
                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                HeaderText="" HeaderStyle-Width="40px">
                            </telerik:GridEditCommandColumn>
                            <telerik:GridDateTimeColumn DataField="ExpDate" HeaderStyle-Width="100px" PickerType="DatePicker" HeaderText="Date" ItemStyle-HorizontalAlign="Center"
                                SortExpression="ExpDate" UniqueName="ExpDate" DataFormatString="{0:d}">
                            </telerik:GridDateTimeColumn>
                            <telerik:GridBoundColumn DataField="Type" HeaderText="Type" SortExpression="Type" UniqueName="Type" HeaderStyle-Width="180px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Reference" HeaderText="Reference" SortExpression="Reference" UniqueName="Reference" HeaderStyle-Width="150px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Category" HeaderText="Category" SortExpression="Category" UniqueName="Category">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="VendorId" HeaderText="Vendor" SortExpression="VendorId" UniqueName="VendorId">
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="cboVendorEdit" runat="server" SelectedValue='<%# Bind("VendorId") %>' DataSourceID="SqlDataSourceVendors"
                                        DataTextField="Name" DataValueField="Id" Width="350px" AppendDataBoundItems="True" Height="300px"
                                        MarkFirstMatch="True" Filter="Contains">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Vendor...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                    <br />
                                    <span style="font-size: x-small; color: darkgray"><%# String.Concat("Original Import Reference: ", Eval("OriginalReference")) %></span>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%# Eval("Vendor") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="Memo" HeaderText="Memo" SortExpression="Memo" UniqueName="Memo">
                            </telerik:GridBoundColumn>
                            <telerik:GridNumericColumn DataField="Amount" HeaderStyle-Width="120px" HeaderText="Amount" ItemStyle-HorizontalAlign="Right"
                                SortExpression="Amount" UniqueName="Amount" DataFormatString="{0:N2}" Aggregate="Sum">
                            </telerik:GridNumericColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete this record?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" HeaderText="" HeaderStyle-Width="50px"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                            </telerik:GridButtonColumn>
                        </Columns>
                        <EditFormSettings>
                            <PopUpSettings Modal="true" Width="800px" />
                            <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </telerik:RadWizardStep>

            <telerik:RadWizardStep Title="Payroll Details">
                <telerik:RadGrid ID="RadGridPayroll" runat="server" DataSourceID="SqlDataSourcePayroll"
                    ItemStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center" AlternatingItemStyle-Font-Size="Small"
                    AutoGenerateColumns="False" AllowPaging="True" PageSize="50" AllowSorting="True" Height="900px" ShowFooter="true" HeaderStyle-Font-Size="Small">
                    <ClientSettings>
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePayroll">
                        <Columns>
                            <telerik:GridBoundColumn DataField="SalaryDate" DataType="System.DateTime" FilterControlAltText="Filter SalaryDate column" HeaderText="Date" SortExpression="SalaryDate" UniqueName="SalaryDate" DataFormatString="{0:d}" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-Width="150px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Employee" FilterControlAltText="Filter Employee column" HeaderText="Employee" SortExpression="Employee" UniqueName="Employee" Aggregate="CountDistinct" FooterAggregateFormatString="{0:N0}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="OriginalReference" HeaderText="Original Reference" SortExpression="OriginalReference" UniqueName="OriginalReference">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Hours" DataType="System.Double" HeaderText="Hours" SortExpression="Hours" UniqueName="Hours" Aggregate="Sum" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" FooterAggregateFormatString="{0:N1}"
                                HeaderStyle-Width="100px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NetAmount" DataType="System.Double" HeaderText="Net Amount" SortExpression="NetAmount" UniqueName="NetAmount" Aggregate="Sum" DataFormatString="{0:C2}" FooterAggregateFormatString="{0:C2}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" HeaderTooltip="Net Salary"
                                HeaderStyle-Width="150px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="GrossAmount" DataType="System.Double" HeaderText="Gross Amount" SortExpression="GrossAmount" UniqueName="GrossAmount" Aggregate="Sum" DataFormatString="{0:C2}" FooterAggregateFormatString="{0:C2}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" HeaderTooltip="Gross Salary"
                                HeaderStyle-Width="150px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TotalCost" DataType="System.Double" HeaderText="Gross Amount" SortExpression="TotalCost" UniqueName="TotalCost" Aggregate="Sum" DataFormatString="{0:C2}" FooterAggregateFormatString="{0:C2}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" HeaderTooltip="Total Cost"
                                HeaderStyle-Width="150px">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </telerik:RadWizardStep>

        </WizardSteps>
    </telerik:RadWizard>

    <telerik:RadToolTip ID="RadToolTipImport" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table table-bordered" style="width: 600px">
            <tr>
                <td>
                    <h2 style="text-align: center; color: white; width: 600px">
                        <span class="navbar navbar-expand-md bg-dark text-white">Import Results</span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td>Rows not imported:
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadListBox ID="RadListBoxImportError" runat="server" Width="100%" ZIndex="50001">
                    </telerik:RadListBox>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipQBExpenses" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table table-bordered" style="width: 600px">
            <tr>
                <td colspan="2">
                    <h2 style="text-align: center; color: white; width: 600px">
                        <span class="navbar navbar-expand-md bg-dark text-white">Import Period Expenses</span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td style="width: 200px;">Date From
                </td>
                <td>
                    <telerik:RadDatePicker ID="DPFrom" runat="server" Width="100%" ZIndex="50001">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="width: 200px;">Date To
                </td>
                <td>
                    <telerik:RadDatePicker ID="DPTo" runat="server" Width="100%" ZIndex="50001">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:LinkButton ID="btnImportExpensesQB" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" CausesValidation="true">
                    Import Expenses
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSourceExpenses" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Company_Expenses_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Company_Expenses_INSERT" InsertCommandType="StoredProcedure"
        DeleteCommand="Company_Expenses_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommand="Company_Expenses_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboCategory" Name="Category" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboVendors" Name="VendorId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ExpDate" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="Reference" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="Category" />
            <asp:Parameter Name="VendorId" />
            <asp:Parameter Name="Memo" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ExpDate" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="Reference" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="Category" />
            <asp:Parameter Name="VendorId" />
            <asp:Parameter Name="Memo" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceMonthly" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Company_ExpensesMonthlyView_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboCategory" Name="Category" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboVendors" Name="VendorId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceChartByYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Company_ExpensesYearView_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboCategory" Name="Category" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboVendors" Name="VendorId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceGroupByCategory" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_v20_Expenses_Chart" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboCategory" Name="Category" PropertyName="Text" />

        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Years] ORDER BY [Year] DESC "></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceExpensesUtility" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Company_Expenses_YEAR_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommand="Company_Payroll_YEAR_DELETE" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:ControlParameter ControlID="txtYear" Name="Year" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="txtYearPayroll" Name="Year" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceVendors" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Vendors WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Category as Name FROM [Company_Expenses] WHERE companyId=@companyId and len(isnull(Category,''))>1 group by Category">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePayroll" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_Payroll_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="PayrollInitialize_INSERT" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboEmployees" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]=[FullName]+case when isnull(Inactive,0)=1 then ' (I)' else '' end FROM [Employees] WHERE companyId=@companyId and DepartmentId=case when @DepartmentId>0 then @DepartmentId else DepartmentId end ORDER BY isnull(Inactive,0), [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

