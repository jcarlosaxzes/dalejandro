<%@ Page Title="Multiplier Wizard" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="multiplierwizard.aspx.vb" Inherits="pasconcept20.multiplierwizard" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
            </asp:LinkButton>
            Company Multiplier Wizard
        </span>
    </div>

    <div class="pasconcept-bar">
        <telerik:RadWizard ID="RadWizard1" runat="server" Height="800px" DisplayCancelButton="false" RenderMode="Lightweight" Skin="Material">
            <WizardSteps>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepYearInfo" Title="Year Setup" ValidationGroup="YearInformation" StepType="Start">
                    <%-- Year Information --%>

                    <div>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="YearInformation"
                            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
                    </div>

                    <div>
                        <h4>Define Expense Information and Options for the Year</h4>

                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="width: 250px; text-align: right">Year:

                                </td>
                                <td style="width: 250px;">
                                    <telerik:RadNumericTextBox Width="95%" ID="txtYear" runat="server" Enabled="false">
                                        <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Expected Total Salary:

                                </td>
                                <td>
                                    <telerik:RadNumericTextBox Width="95%" ID="txtSalary" runat="server">
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td>Total Gross Salary to be paid to employees throughout the selected year
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Employer Payroll Tax Percentage:

                                </td>
                                <td>
                                    <telerik:RadNumericTextBox Width="95%" ID="txtTaxPercent" runat="server" MaxValue="99">
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td>Total Local, State and Federal tax percentage
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Auto Update Expected Salary:

                                </td>
                                <td>
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
                                <td style="text-align: right">Expected Productive Salary:

                                </td>
                                <td>
                                    <telerik:RadNumericTextBox Width="95%" ID="txtProductiveSalary" runat="server">
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td>Expected Salary dedicated exclusively to Productive Activities this year
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


                            <%--Sub Fees--%>
                            <tr>
                                <td style="text-align: right">Expected Total Sub Fees:

                                </td>
                                <td>
                                    <telerik:RadNumericTextBox Width="95%" ID="txtSubContracts" runat="server">
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td>Expected Expenses on Sub Fees this year
                                </td>
                            </tr>

                            <%--Rent--%>
                            <tr>
                                <td style="text-align: right">Expected Total Rent:

                                </td>
                                <td>
                                    <telerik:RadNumericTextBox Width="95%" ID="txtRent" runat="server">
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td>Expected Expenses on Rent this year
                                </td>
                            </tr>

                            <%--Others--%>
                            <tr>
                                <td style="text-align: right">Expected Others Expenses:

                                </td>
                                <td>
                                    <telerik:RadNumericTextBox Width="95%" ID="txtOthers" runat="server">
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td>Expected Others Expenses this year, than Salary, Sub Fees and Rent
                                </td>
                            </tr>

                            <%--Profit--%>
                            <tr>
                                <td style="text-align: right">Expected Profit over Expenses:

                                </td>
                                <td>
                                    <telerik:RadNumericTextBox Width="95%" ID="txtProfit" runat="server">
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td>Total others expenses than this year, than Salary, Sub Fees and Rent
                                </td>
                            </tr>


                        </table>
                    </div>

                    <div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtYear" Display="None" runat="server" ErrorMessage="<span><b>Year</b> is required</span>" SetFocusOnError="true" ValidationGroup="YearInformation">
                        </asp:RequiredFieldValidator>
                    </div>
                </telerik:RadWizardStep>

                <%-- Finish --%>
                <telerik:RadWizardStep runat="server" Title="Confirmation" ID="RadWizardStepConfirmation" Enabled="false" StepType="Finish">

                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td style="width: 250px; text-align: right">Employee Hourly Wage:

                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboInitializeEmployee" runat="server" Width="95%">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="YES" Value="1" Selected="true" />
                                        <telerik:RadComboBoxItem runat="server" Text="NO" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td>
                                Initialize Employee Hourly Wage and Benefits of active employees on background operations. New/Inactivate/Update Benefits of any Employee.
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
                            <td>
                                Update Budgets by Departments on background operations. New/Inactivate/Update Benefits of any Employee.
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Multiplier Status:

                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboStatus" runat="server" Width="95%">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Open" Value="0" Selected="true"/>
                                        <telerik:RadComboBoxItem runat="server" Text="Closed" Value="1"  />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td>Closed status avoid automatic changes of multiplier.    
                            </td>
                        </tr>


                    </table>
                </telerik:RadWizardStep>

                <%-- Complete --%>
                <telerik:RadWizardStep runat="server" Title="Confirmation" ID="RadWizardStep1" StepType="Complete">
                        <div style="padding-top:25px; padding-left:150px" class="alert alert-danger" role="alert">
                            <h5 class="alert-heading">Previous Multiplier Value: <asp:Label ID="lblPreviousMultiplier" runat="server" Text="0"></asp:Label></h5>
                        </div>
                        <div style="padding-top:25px; padding-left:150px" class="alert alert-success" role="alert">
                            <h2 class="alert-heading">Updated Multiplier Value: <asp:Label ID="lblFinalMultiplier" runat="server" Text="0"></asp:Label></h2>
                        </div>
                        Historical Log (Last 50 changes)
                        <telerik:RadGrid ID="RadGridMultiplier_log" GridLines="None" runat="server" AllowAutomaticDeletes="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceMultiplier_log" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-HorizontalAlign="Center">
                                        <MasterTableView DataSourceID="SqlDataSourceMultiplier_log" AutoGenerateColumns="False" CommandItemDisplay="Top">
                                            <CommandItemSettings ShowAddNewRecordButton="false" />
                                            <Columns>

                                                <telerik:GridNumericColumn DataField="UpdatedDate" HeaderText="Updated Date" SortExpression="UpdatedDate" UniqueName="UpdatedDate">
                                                </telerik:GridNumericColumn>

                                                <telerik:GridNumericColumn DataField="Year" HeaderText="Year" HeaderStyle-Width="80px" SortExpression="Year" UniqueName="Year" ItemStyle-HorizontalAlign="Center">
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

                                                <telerik:GridNumericColumn DataField="Profit" HeaderStyle-Width="80px" HeaderText="(%)" SortExpression="Profit" UniqueName="Profit" DataFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                                                </telerik:GridNumericColumn>

                                                <telerik:GridNumericColumn DataField="Multiplier" HeaderStyle-Width="80px" HeaderText="Multiplier" SortExpression="Multiplier" UniqueName="Multiplier" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" ItemStyle-Font-Bold="true">
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



    <asp:Label ID="lblEmployeeId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblMultiplierId" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>
