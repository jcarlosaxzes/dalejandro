<%@ Page Title="Multiplier Wizard" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="multiplierwizard.aspx.vb" Inherits="pasconcept20.multiplierwizard" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
            </asp:LinkButton>
            Company Multiplier Wizard (<asp:Label ID="lblTitleYear" runat="server" Text="0"></asp:Label>)
        </span>
    </div>

    <div class="pasconcept-bar">
        <telerik:RadWizard ID="RadWizard1" runat="server" Height="800px" DisplayCancelButton="true" RenderMode="Lightweight" Skin="Material">
            <Localization Finish="Calculate Multiplier" />
            <WizardSteps>

                <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Employee Wages" StepType="Start">
                    <div>
                        <h4>Wage Modifications for
                            <asp:Label ID="lblYearTab1" runat="server"></asp:Label></h4>
                    </div>
                    <div class="pasconcept-bar">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" MarkFirstMatch="True" Label="Departement: "
                            Width="500px" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true" AutoPostBack="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Department...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </div>
                    <telerik:RadGrid ID="RadGridHourlyWage" runat="server" DataSourceID="SqlDataSourceHourlyWage" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                        AutoGenerateColumns="False" AllowSorting="True" ShowFooter="true" HeaderStyle-HorizontalAlign="Center">
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceHourlyWage">
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" ItemStyle-HorizontalAlign="Center"
                                    HeaderText="" HeaderStyle-Width="50px">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridBoundColumn DataField="Employee" HeaderText="Employee" SortExpression="Employee" UniqueName="Employee" ReadOnly="true">
                                </telerik:GridBoundColumn>
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
                                            <td>
                                                The starting date for the benefits entered below
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style=" text-align: right">Date To:
                                            </td>
                                            <td>
                                                <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" Width="90%" DbSelectedDate='<%# Bind("DateEnd")%>'>
                                                    </telerik:RadDatePicker>
                                            </td>
                                            <td>
                                                The end date for the benefits entered below
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
                                            <td>
                                                The amount of money that is earned by an employee for every hour worked
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
                                            <td>
                                                Employer Payroll Tax Percentage is the sum of all Local, State and Federal Taxes the Employer is responsible for (e.g. Medicare, Unemployment, etc)
                                                <br />
                                                <small>
                                                    Previously this value was <b><%#LocalAPI.GetEmployee_HourlyWageHistoryPreviousPeriodProperty(Eval("Id"), "EmployerPayrollTaxPercentage") %></b>
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
                                            <td>
                                                The total number of hours this employee is to work before being entitled to overtime (e.g 40 Hours may be considered standard full-time employment)
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
                                            <td>
                                                This is the total number of Vacation Hours this employee can take in the defined time range
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
                                            <td>
                                                This is the total Personal Time off in Hours that this employee is allotted in the defined time range
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
                                            <td>
                                                This factor, from 0.0 to 1.0, defines the percentage of time this employee works directly on Jobs/Projects (e.g. If an employee, on average, spends 50% of their working hours working directory on project tasks for which there is a budget then this value would be set to .50)
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

                </telerik:RadWizardStep>

                <%--Year Setup--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepYearInfo" Title="Year Setup" StepType="Finish">
                    <%-- Year Information --%>
                    <div>
                        <h4>Expense Information and Options for
                            <asp:Label ID="lblYear" runat="server"></asp:Label></h4>
                        <asp:Panel runat="server" ID="panelRecord">
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="width: 250px; text-align: right">Expected Total Salary:
                                    </td>
                                    <td style="width: 250px; padding-top: 12px; padding-bottom: 12px">
                                        <telerik:RadNumericTextBox Width="95%" ID="txtSalary" runat="server">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td>The total salary to be paid to employees throughout <%# lblTitleYear.Text %>
                                        <br />
                                        <small>In <%# lblPastYear.Text %>, this was listed as $<asp:Label ID="lblPastSalary" runat="server"></asp:Label></small>

                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Expected Productive Salary:

                                    </td>
                                    <td style="padding-top: 15px; padding-bottom: 15px">
                                        <telerik:RadNumericTextBox Width="95%" ID="txtProductiveSalary" runat="server">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td>Anticipated Salary dedicated exclusively to Job Based Activities in <%# lblTitleYear.Text %>
                                        <br />
                                        <small>In <%# lblPastYear.Text %>, this was listed as
                                            <asp:Label ID="lblPastProductiveSalary" runat="server"></asp:Label></small>

                                    </td>
                                </tr>


                                <%--Sub Fees--%>
                                <tr>
                                    <td style="text-align: right">Expected Total Sub Fees:

                                    </td>
                                    <td style="padding-top: 15px; padding-bottom: 15px">
                                        <telerik:RadNumericTextBox Width="95%" ID="txtSubContracts" runat="server">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td>Anticipated expenses on Sub Fees for <%# lblTitleYear.Text %>
                                        <br />
                                        <small>In <%# lblPastYear.Text %>, this was listed as $<asp:Label ID="lblPastSubContracts" runat="server"></asp:Label></small>

                                    </td>
                                </tr>

                                <%--Rent--%>
                                <tr>
                                    <td style="text-align: right">Expected Total Rent:

                                    </td>
                                    <td style="padding-top: 15px; padding-bottom: 15px">
                                        <telerik:RadNumericTextBox Width="95%" ID="txtRent" runat="server">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td>Anticipated expenses on Rent for <%# lblTitleYear.Text %>
                                        <br />
                                        <small>In <%# lblPastYear.Text %>, this was listed as $<asp:Label ID="lblPastRent" runat="server"></asp:Label></small>

                                    </td>
                                </tr>

                                <%--Others--%>
                                <tr>
                                    <td style="text-align: right">Other Expected Expenses:

                                    </td>
                                    <td style="padding-top: 15px; padding-bottom: 15px">
                                        <telerik:RadNumericTextBox Width="95%" ID="txtOthers" runat="server">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td>Anticipated expenses outside of Salary, Sub Fees and Rent for <%# lblTitleYear.Text %>
                                        <br />
                                        <small>In <%# lblPastYear.Text %>, this was listed as $<asp:Label ID="lblPastOthers" runat="server"></asp:Label></small>

                                    </td>
                                </tr>

                                <%--Profit--%>
                                <tr>
                                    <td style="text-align: right">Desired Profit Margin:

                                    </td>
                                    <td style="padding-top: 15px; padding-bottom: 15px">
                                        <telerik:RadNumericTextBox Width="95%" ID="txtProfit" runat="server">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td>The desired profit margin for <%# lblTitleYear.Text %>
                                        <br />
                                        <small>In <%# lblPastYear.Text %>, this was listed as
                                            <asp:Label ID="lblPastProfit" runat="server"></asp:Label>%</small>


                                    </td>
                                </tr>

                            </table>
                        </asp:Panel>
                    </div>

                    <%--Comboboxs ocultos--%>
                    <div style="height: 1px; overflow: auto">
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="width: 250px; text-align: right">Auto Update Expected Salary:
                                </td>
                                <td style="width: 250px;">
                                    <telerik:RadComboBox ID="cboAutoSalary" runat="server" Width="95%">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="YES" Value="1" Selected="true" />
                                            <telerik:RadComboBoxItem runat="server" Text="NO" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td>Automatically calculate salary on background operations. New/Inactivate/Update Benefits of any Employee
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Auto Update Productive Salary:

                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboAutoProductiveSalary" runat="server" Width="95%">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="YES" Value="1" Selected="true" />
                                            <telerik:RadComboBoxItem runat="server" Text="NO" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td>Automatically calculate Productive Salary on background operations. New/Inactivate/Update Benefits of any Employee.
                                </td>
                            </tr>

                            <tr>
                                <td style="text-align: right">Employee Hourly Wage:

                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboInitializeEmployee" runat="server" Width="95%">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="YES" Value="1" Selected="true" />
                                            <telerik:RadComboBoxItem runat="server" Text="NO" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td>Initialize Employee Hourly Wage and Benefits of active employees on background operations. New/Inactivate/Update Benefits of any Employee.
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Budgets by Departments:

                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboCalculateBudgetDepartment" runat="server" Width="95%">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="YES" Value="1" Selected="true" />
                                            <telerik:RadComboBoxItem runat="server" Text="NO" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td>Update Budgets by Departments on background operations. New/Inactivate/Update Benefits of any Employee.
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Automatic Multiplier:

                                </td>
                                <td style="padding-top: 15px; padding-bottom: 15px">
                                    <telerik:RadComboBox ID="cboStatus" runat="server" Width="95%">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="Yes" Value="0" Selected="true" />
                                            <telerik:RadComboBoxItem runat="server" Text="No" Value="1" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>

                                <td>Do you want changes made to Employee Salaries throughout the year to automatically affect the multiplier value?
                                        <br />
                                    <small>An increase in an employees salary will cause in an automatic increase in the company multiplier factor if this field is set to "Yes".</small>

                                </td>
                            </tr>

                        </table>
                    </div>

                </telerik:RadWizardStep>


                <%-- Complete --%>
                <telerik:RadWizardStep runat="server" Title="Confirmation" ID="RadWizardStep1" StepType="Complete">
                    <div style="padding-top: 25px; padding-left: 150px" class="alert alert-success" role="alert">
                        <h2 class="alert-heading">Updated Multiplier Value:
                            <asp:Label ID="lblFinalMultiplier" runat="server" Text=""></asp:Label></h2>
                        <h5>Previous Multiplier Value:
                            <asp:Label ID="lblPreviousMultiplier" runat="server" Text="0"></asp:Label></h5>
                    </div>
                    <br />
                    <h4>Historical Log (Last 10 changes)</h4>
                    <telerik:RadGrid ID="RadGridMultiplier_log" GridLines="None" runat="server" AllowAutomaticDeletes="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceMultiplier_log">
                        <MasterTableView DataSourceID="SqlDataSourceMultiplier_log" AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                            <Columns>

                                <telerik:GridNumericColumn DataField="UpdatedDate" HeaderText="Updated Date" SortExpression="UpdatedDate" UniqueName="UpdatedDate">
                                </telerik:GridNumericColumn>

                                <telerik:GridNumericColumn DataField="Year" HeaderText="Year" HeaderStyle-Width="130px" SortExpression="Year" UniqueName="Year" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridNumericColumn>

                                <telerik:GridNumericColumn DataField="Salary" HeaderText="Salary" SortExpression="Salary" UniqueName="Salary" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right">
                                </telerik:GridNumericColumn>

                                <telerik:GridNumericColumn DataField="SalaryTax" HeaderText="Salary Tax" SortExpression="SalaryTax" UniqueName="SalaryTax" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right">
                                </telerik:GridNumericColumn>

                                <telerik:GridNumericColumn DataField="ProductiveSalary" HeaderText="Productive Salary" SortExpression="ProductiveSalary" UniqueName="ProductiveSalary" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right">
                                </telerik:GridNumericColumn>

                                <telerik:GridNumericColumn DataField="SubContracts" HeaderText="Sub Fees" SortExpression="SubContracts" UniqueName="SubContracts" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right">
                                </telerik:GridNumericColumn>

                                <telerik:GridNumericColumn DataField="Rent" HeaderText="Rent" SortExpression="Rent" UniqueName="Rent" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right">
                                </telerik:GridNumericColumn>

                                <telerik:GridNumericColumn DataField="Others" HeaderText="Others" SortExpression="Others" UniqueName="Others" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right">
                                </telerik:GridNumericColumn>

                                <telerik:GridNumericColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataFormatString="{0:N2}" ReadOnly="true" ItemStyle-HorizontalAlign="Right">
                                </telerik:GridNumericColumn>

                                <telerik:GridNumericColumn DataField="Profit" HeaderStyle-Width="130px" HeaderText="(%)" SortExpression="Profit" UniqueName="Profit" DataFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridNumericColumn>

                                <telerik:GridNumericColumn DataField="Multiplier" HeaderStyle-Width="130px" HeaderText="Multiplier" SortExpression="Multiplier" UniqueName="Multiplier" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true">
                                </telerik:GridNumericColumn>

                                <telerik:GridNumericColumn DataField="Action" HeaderText="Action" SortExpression="Action" UniqueName="Action" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridNumericColumn>

                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceMultiplier_log" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CompanyMultiplier_log_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="DELETE FROM Company_MultiplierByYear WHERE Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceHourlyWage" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Employee_HourlyWageHistory_v21_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="Employees_HourlyWageHistory_v21_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Employee_HourlyWageHistory_v21_UPDATE" UpdateCommandType="StoredProcedure"
        InsertCommand="Employee_HourlyWageHistory_v21_INSERT" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblYear" Name="year" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
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
            <asp:ControlParameter ControlID="RadNumericHour" Name="HourPerWeek" PropertyName="Value" />
            <asp:ControlParameter ControlID="RadNumericProducer" Name="Producer" PropertyName="Value" />
            <asp:ControlParameter ControlID="txtBenefits_vacations" Name="Benefits_vacations" PropertyName="Value" />
            <asp:ControlParameter ControlID="txtBenefits_personals" Name="Benefits_personals" PropertyName="Value" />
            <asp:ControlParameter ControlID="lblHourlyWageHistoryId" Name="HourlyWageHistoryLastId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblEmployeeId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblMultiplierId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblModeInsert" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblPastYear" runat="server" Visible="False"></asp:Label>
</asp:Content>
