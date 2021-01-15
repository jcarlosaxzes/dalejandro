<%@ Page Title="Employee Hourly Wage" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="employeehourlywage.aspx.vb" Inherits="pasconcept20.employeehourlywage" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
            </asp:LinkButton>
            Employee Hourly Wage
        </span>
        <span style="float: right; vertical-align: middle;">
            <asp:LinkButton ID="btnReviewSalary" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                   Review Salary
            </asp:LinkButton>
        </span>
    </div>

    <div class="pasconcept-bar">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="text-align: center">
                    <h3>
                        <asp:Label ID="lblEmployeeName" runat="server"></asp:Label><br />
                        (<asp:Label ID="lblYear" runat="server"></asp:Label>)</h3>
                </td>
                <td>
                    <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSourceChart" Height="170px" Width="100%"
                        Transitions="true">
                        <PlotArea>
                            <Series>
                                <telerik:LineSeries DataFieldY="Amount" Name="$/Hour" AxisName="LeftAxis">

                                    <TooltipsAppearance DataFormatString="{0:N2}"></TooltipsAppearance>

                                    <Appearance>
                                        <FillStyle BackgroundColor="Red" />
                                    </Appearance>

                                    <LineAppearance LineStyle="Smooth" Width="2" />
                                    <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                    <LabelsAppearance Color="Red" Position="Above">
                                        <TextStyle FontSize="12" />
                                    </LabelsAppearance>

                                </telerik:LineSeries>
                            </Series>
                            <YAxis Name="LeftAxis" MajorTickSize="6" MajorTickType="Outside" Step="10" MinorTickSize="1" Color="Red" Width="3">
                                <TitleAppearance Text="$/Hour"></TitleAppearance>
                                <LabelsAppearance DataFormatString="{0:N2}">
                                    <TextStyle FontSize="8" />
                                </LabelsAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>

                            </YAxis>
                            <XAxis DataLabelsField="YearGroup">
                                <TitleAppearance Text="Date" Visible="false"></TitleAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                                <MajorGridLines Visible="false" />
                                <LabelsAppearance RotationAngle="270">
                                    <TextStyle FontSize="10" />
                                </LabelsAppearance>
                            </XAxis>
                        </PlotArea>
                        <Legend>
                            <Appearance Visible="false" Position="Top"></Appearance>
                        </Legend>
                    </telerik:RadHtmlChart>
                </td>
            </tr>
        </table>
        <div>
            <telerik:RadGrid ID="RadGridHourlyWage" runat="server" DataSourceID="SqlDataSourceHourlyWage" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                AutoGenerateColumns="False" AllowSorting="True" ShowFooter="true"
                HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceHourlyWage" CommandItemDisplay="Top">
                    <CommandItemSettings ShowAddNewRecordButton="false" />
                    <Columns>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" ItemStyle-HorizontalAlign="Center"
                            HeaderText="" HeaderStyle-Width="50px">
                        </telerik:GridEditCommandColumn>
                        <telerik:GridDateTimeColumn DataField="Date" HeaderText="Date From" HeaderStyle-HorizontalAlign="Center"
                            SortExpression="Date" UniqueName="Date" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="center" PickerType="DatePicker" DataFormatString="{0:d}">
                        </telerik:GridDateTimeColumn>
                        <telerik:GridDateTimeColumn DataField="DateEnd" FilterControlAltText="Filter DateEnd column" HeaderText="Date To" HeaderStyle-HorizontalAlign="Center"
                            SortExpression="DateEnd" UniqueName="DateEnd" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="center" PickerType="DatePicker" DataFormatString="{0:d}">
                        </telerik:GridDateTimeColumn>
                        <telerik:GridNumericColumn DataField="Amount" HeaderText="$/Hour" HeaderStyle-HorizontalAlign="Center"
                            SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Hourly Wage Rate"
                            DecimalDigits="2" MinValue="0">
                        </telerik:GridNumericColumn>
                        <telerik:GridNumericColumn DataField="HourPerWeek" HeaderText="Hours per Week" HeaderStyle-HorizontalAlign="Center"
                            SortExpression="HourPerWeek" UniqueName="HourPerWeek" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                            DecimalDigits="2" MinValue="0" MaxValue="40">
                        </telerik:GridNumericColumn>
                        <telerik:GridNumericColumn DataField="Benefits_vacations" HeaderText="Vacations (hours)" HeaderStyle-HorizontalAlign="Center"
                            SortExpression="Benefits_vacations" UniqueName="Benefits_vacations" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center"
                            DecimalDigits="0" MinValue="0" MaxValue="80">
                        </telerik:GridNumericColumn>
                        <telerik:GridNumericColumn DataField="Benefits_personals" HeaderText="Personals (hours)" HeaderStyle-HorizontalAlign="Center"
                            SortExpression="Benefits_personals" UniqueName="Benefits_personals" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center"
                            DecimalDigits="0" MinValue="0" MaxValue="32">
                        </telerik:GridNumericColumn>
                        <telerik:GridNumericColumn DataField="Producer" HeaderText="Producer Rate" HeaderStyle-HorizontalAlign="Center"
                            SortExpression="Producer" UniqueName="Producer" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Producer Rate 0 to 1"
                            DecimalDigits="2" MinValue="0" MaxValue="1">
                        </telerik:GridNumericColumn>

                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ButtonType="ImageButton"
                            HeaderText="" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings>
                        <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>

    <telerik:RadToolTip ID="RadToolTipReview" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <table class="table-sm" style="width: 800px">
            <tr>
                <td style="text-align: center" colspan="2">
                    <h3 style="margin: 0; text-align: center; color: white;">
                        <span class="navbar navbar-expand-md bg-dark text-white">Review Salary
                        </span>
                    </h3>
                </td>
            </tr>
            <tr>
                <td style="width: 180px">Date From:
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Culture="en-US" ZIndex="50001">
                    </telerik:RadDatePicker>
                </td>
                <td class="small">Date From (in selected year) to apply this settings.
                </td>
            </tr>
            <tr>
                <td>Hourly Rate ($/hour):
                </td>
                <td style="width: 180px;">
                    <telerik:RadNumericTextBox ID="txtHourlyRate" runat="server" MinValue="0" MaxValue="80" Width="160"
                        ShowSpinButtons="True"
                        ButtonsPosition="Right">
                        <NumberFormat DecimalDigits="2" />
                        <IncrementSettings Step="0.5" />
                    </telerik:RadNumericTextBox>
                </td>
                <td class="small">Amount of money that is paid for every hour worked.
                </td>
            </tr>
            <tr>
                <td>Employer Payroll Tax  (%):
                </td>
                <td style="width: 180px;">
                    <telerik:RadNumericTextBox ID="txtEmployerPayrollTaxPercentage" runat="server" MinValue="0" MaxValue="100" Width="160">
                        <NumberFormat DecimalDigits="2" />
                    </telerik:RadNumericTextBox>
                </td>
                <td class="small">Total Local, State and Federal Tax Percentage.
                </td>
            </tr>
            <tr>
                <td>Producer Rate (0 to 1):
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="RadNumericProducer" runat="server" MinValue="0" Width="160" MaxValue="1">
                        <NumberFormat DecimalDigits="2" />
                    </telerik:RadNumericTextBox>
                </td>
                <td class="small">Ratio as Producer, where 1 is fully producer and 0 is non-producer.
                </td>
            </tr>
            <tr>
                <td>Hour Per Week:
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="RadNumericHour" runat="server" MinValue="0" Width="160">
                        <NumberFormat DecimalDigits="0" />
                    </telerik:RadNumericTextBox>
                </td>
                <td class="small">The number of hours a employee may spend per work week.
                </td>
            </tr>
            <tr>
                <td>Vacations(Hours):
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtBenefits_vacations" runat="server" MinValue="0" MaxValue="160" Width="160">
                        <NumberFormat DecimalDigits="0" />
                    </telerik:RadNumericTextBox>
                </td>
                <td class="small">The number of hours of benefit given to employees during a year in which they do not have to work.
                </td>
            </tr>
            <tr>
                <td>Personal/Sicks (Hours):
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtBenefits_personals" runat="server" MinValue="0" MaxValue="32" Width="160">
                        <NumberFormat DecimalDigits="0" />
                    </telerik:RadNumericTextBox>
                </td>
                <td class="small">The number of hours of benefit given to employees during a year in which they do not have to work.
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnReviewSalaryConfirmed" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" Text="Insert" ToolTip="Insert New Record" ValidationGroup="Insert">
                    </asp:LinkButton>
                </td>
            </tr>
        </table>


        
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSourceHourlyWage" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Employee_HourlyWageHistory_v21_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="Employee_HourlyWageHistory_v21_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Employee_HourlyWageHistory_v21_UPDATE" UpdateCommandType="StoredProcedure"
        InsertCommand="Employee_HourlyWageHistory_v21_INSERT" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
            <asp:Parameter Name="Date" />
            <asp:Parameter Name="DateEnd" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="EmployerPayrollTaxPercentage" />
            <asp:Parameter Name="HourPerWeek" />
            <asp:Parameter Name="Producer" />
            <asp:Parameter Name="Benefits_vacations" />
            <asp:Parameter Name="Benefits_personals" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="txtHourlyRate" Name="Amount" PropertyName="Value" />
            <asp:ControlParameter ControlID="txtEmployerPayrollTaxPercentage" Name="EmployerPayrollTaxPercentage" PropertyName="Value" />
            <asp:ControlParameter ControlID="RadNumericHour" Name="HourPerWeek" PropertyName="Value" />
            <asp:ControlParameter ControlID="RadNumericProducer" Name="Producer" PropertyName="Value" />
            <asp:ControlParameter ControlID="txtBenefits_vacations" Name="Benefits_vacations" PropertyName="Value" />
            <asp:ControlParameter ControlID="txtBenefits_personals" Name="Benefits_personals" PropertyName="Value" />
            <asp:ControlParameter ControlID="lblHourlyWageHistoryId" Name="HourlyWageHistoryLastId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceChart" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_HourlyWageHistoryChart_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblMonthUpdated" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblDepartmentId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblHourlyWageHistoryId" runat="server" Visible="False"></asp:Label>

</asp:Content>
