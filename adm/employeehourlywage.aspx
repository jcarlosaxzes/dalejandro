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
                    <br />
                    <telerik:RadComboBox ID="cboFilter" runat="server" AutoPostBack="true" Label=" View: "
                        Width="400px" Filter="Contains" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Text="Last Employee Record Update for year" Value="0" />
                            <telerik:RadComboBoxItem Text="All Records" Value="1" />
                        </Items>
                    </telerik:RadComboBox>

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
                AutoGenerateColumns="False" AllowSorting="True" ShowFooter="true" HeaderStyle-HorizontalAlign="Center">
                <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceHourlyWage">
                    <Columns>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" ItemStyle-HorizontalAlign="Center"
                            HeaderText="" HeaderStyle-Width="50px">
                        </telerik:GridEditCommandColumn>
                        <telerik:GridDateTimeColumn DataField="Date" HeaderText="Date From"
                            SortExpression="Date" UniqueName="Date" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="center" DataFormatString="{0:d}">
                        </telerik:GridDateTimeColumn>
                        <telerik:GridDateTimeColumn DataField="DateEnd" HeaderText="Date To"
                            SortExpression="DateEnd" UniqueName="DateEnd" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="center" DataFormatString="{0:d}">
                        </telerik:GridDateTimeColumn>
                        <telerik:GridNumericColumn DataField="Amount" HeaderText="$/Hour"
                            SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Hourly Wage Rate"
                            DecimalDigits="2" MinValue="0">
                        </telerik:GridNumericColumn>
                        <telerik:GridNumericColumn DataField="EmployerPayrollTaxPercentage" HeaderText="Payroll Tax(%)" HeaderStyle-HorizontalAlign="Center"
                            SortExpression="EmployerPayrollTaxPercentage" UniqueName="EmployerPayrollTaxPercentage" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Employer Payroll Tax Percentage"
                            DecimalDigits="2" MinValue="0">
                        </telerik:GridNumericColumn>
                        <telerik:GridNumericColumn DataField="HourPerWeek" HeaderText="Hours per Week"
                            SortExpression="HourPerWeek" UniqueName="HourPerWeek" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center"
                            DecimalDigits="2" MinValue="0" MaxValue="40">
                        </telerik:GridNumericColumn>
                        <telerik:GridNumericColumn DataField="Benefits_vacations" HeaderText="Vacations (hours)"
                            SortExpression="Benefits_vacations" UniqueName="Benefits_vacations" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center"
                            DecimalDigits="0" MinValue="0" MaxValue="80">
                        </telerik:GridNumericColumn>
                        <telerik:GridNumericColumn DataField="Benefits_personals" HeaderText="Personals (hours)"
                            SortExpression="Benefits_personals" UniqueName="Benefits_personals" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center"
                            DecimalDigits="0" MinValue="0" MaxValue="32">
                        </telerik:GridNumericColumn>
                        <telerik:GridNumericColumn DataField="Producer" HeaderText="Producer Rate"
                            SortExpression="Producer" UniqueName="Producer" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Producer Rate 0 to 1"
                            DecimalDigits="2" MinValue="0" MaxValue="1">
                        </telerik:GridNumericColumn>

                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ButtonType="ImageButton"
                            HeaderText="" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="width: 180px; text-align: right">Date From:
                                    </td>
                                    <td style="width: 250px;">
                                        <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" Width="90%" DbSelectedDate='<%# Bind("Date")%>'>
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td>The starting date for the benefits entered below
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Date To:
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" Width="90%" DbSelectedDate='<%# Bind("DateEnd")%>'>
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td>The end date for the benefits entered below
                                                <br />
                                        <small>The benefits below will be applied beyond this date if no changes are made</small>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Hourly Wage Rate:
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="RadNumericTextAmount" runat="server" DbValue='<%# Bind("Amount")%>' Width="90%">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td>The amount of money that is earned by an employee for every hour worked
                                                <br />
                                        <small>Previously this employee earned $<b><%#LocalAPI.GetEmployee_HourlyWageHistoryPreviousPeriodProperty(Eval("Id"), "Amount") %> per hour</b></small>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Payroll Tax(%):
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="RadNumericTextBoxPayrollTax" runat="server" DbValue='<%# Bind("EmployerPayrollTaxPercentage")%>' Width="90%" MaxValue="99">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td>Employer Payroll Tax Percentage is the sum of all Local, State and Federal Taxes the Employer is responsible for (e.g. Medicare, Unemployment, etc)
                                                <br />
                                        <small>Previously this value was <b><%#LocalAPI.GetEmployee_HourlyWageHistoryPreviousPeriodProperty(Eval("Id"), "EmployerPayrollTaxPercentage") %></b>
                                        </small>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Housr Per Week:
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="RadNumericTextBox2" runat="server" DbValue='<%# Bind("HourPerWeek")%>' Width="90%" MaxValue="168">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td>The total number of hours this employee is to work before being entitled to overtime (e.g 40 Hours may be considered standard full-time employment)
                                                <br />
                                        <small>Previously this employee was listed as working <b><%#LocalAPI.GetEmployee_HourlyWageHistoryPreviousPeriodProperty(Eval("Id"), "HourPerWeek") %></b> Hours per week.</small>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Vacations (hours):
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server" DbValue='<%# Bind("Benefits_vacations")%>' Width="90%" MaxValue="999">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td>This is the total number of Vacation Hours this employee can take in the defined time range
                                                <br />
                                        <small>This employee had <b><%#LocalAPI.GetEmployee_HourlyWageHistoryPreviousPeriodProperty(Eval("Id"), "Benefits_vacations") %></b> Vacation hours in the previous period</small>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Personals (hours):
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="RadNumericTextBox3" runat="server" DbValue='<%# Bind("Benefits_personals")%>' Width="90%" MaxValue="999">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td>This is the total Personal Time off in Hours that this employee is allotted in the defined time range
                                                <br />
                                        <small>This employee had <b><%#LocalAPI.GetEmployee_HourlyWageHistoryPreviousPeriodProperty(Eval("Id"), "Benefits_personals") %></b> hours of Personal Time allotted to them in the previous period</small>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Producer Rate:
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="RadNumericTextBox4" runat="server" DbValue='<%# Bind("Producer")%>' Width="90%" MaxValue="1" MinValue="0">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td>This factor, from 0.0 to 1.0, defines the percentage of time this employee works directly on Jobs/Projects (e.g. If an employee, on average, spends 50% of their working hours working directory on project tasks for which there is a budget then this value would be set to .50)
                                                <br />
                                        <small>This employee's Producer Rate was previously listed as <b><%#LocalAPI.GetEmployee_HourlyWageHistoryPreviousPeriodProperty(Eval("Id"), "Producer") %></b></small>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td colspan="2">
                                        <asp:LinkButton ID="btnUpdate" Text="Update" runat="server" CommandName="Update" CssClass="btn btn-success btn-lg"></asp:LinkButton>
                                        &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-secondary btn-lg"></asp:LinkButton>

                                    </td>

                                </tr>
                            </table>
                        </FormTemplate>
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
        SelectCommand="Employee_HourlyWageHistory_v21_1_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Employee_HourlyWageHistory_v21_UPDATE" UpdateCommandType="StoredProcedure"
        InsertCommand="Employee_HourlyWageHistory_v21_INSERT" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboFilter" Name="detailed" PropertyName="SelectedValue" Type="Int32" />
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
