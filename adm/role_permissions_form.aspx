﻿<%@ Page Title="Role Permissions" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="role_permissions_form.aspx.vb" Inherits="pasconcept20.role_permissions_form" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="Formulario">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="width: 120px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                       Back to List
                    </asp:LinkButton>
                </td>
                <td style="text-align:center">
                    <h2 style="margin:0">Role Permissions</h2>
                </td>

            </tr>
        </table>
    </div>

    <div class="pas-container">
        <div style="margin-left: 50px; margin-right: 50px">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%">
                <EditItemTemplate>
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td style="width: 100px">Role Name:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="RadTextBoxName" runat="server" MaxLength="255" Width="100%"
                                    Text='<%# Bind("Name") %>'
                                    EmptyMessage="Name is mandatory...">
                                </telerik:RadTextBox>
                            </td>
                            <td style="width: 200px; text-align: right">
                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" CommandName="Update">
                                        Update
                                </asp:LinkButton>
                                &nbsp;&nbsp;
                                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-default btn-lg" UseSubmitBehavior="false" CausesValidation="False" CommandName="Cancel">
                                        Cancel
                                    </asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td>URL Firewall:
                            </td>
                            <td colspan="2">
                                <telerik:RadTextBox ID="RadTextBox1" runat="server" MaxLength="255" Width="100%"
                                    Text='<%# Bind("URLFirewall") %>'
                                    EmptyMessage="IP List Permits. if empty, all are allowed.">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>

                    <table style="width: 100%">
                        <tr>
                            <td style="width: 50%; vertical-align: top">
                                <table class="table-hover">

                                    <%--Allow Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Allow Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 250px"><span class="label label-danger">Allow Employees Permissions</span>:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Allow_EmployeesPermissionsCheckBox" runat="server" Checked='<%# Bind("Allow_EmployeesPermissions") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow Edit Accepted Proposal</span>:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Allow_EditAcceptedProposalCheckBox" runat="server" Checked='<%# Bind("Allow_EditAcceptedProposal") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow Inactivate Job</span>:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Allow_InactivateJobCheckBox" runat="server" Checked='<%# Bind("Allow_InactivateJob") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow Other Employee Jobs</span>:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Allow_OtherEmployeeJobsCheckBox" runat="server" Checked='<%# Bind("Allow_OtherEmployeeJobs") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow Department Report</span>:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Allow_DepartmentReportCheckBox" runat="server" Checked='<%# Bind("Allow_DepartmentReport") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow Bad Debt</span>:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Allow_BadDebtCheckBox" runat="server" Checked='<%# Bind("Allow_BadDebt") %>' />
                                        </td>
                                    </tr>

                                    <%--Job Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Job Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 250px">Deny Jobs Menu:
                                        </td>

                                        <td>
                                            <telerik:RadCheckBox ID="CheckBox27" runat="server" Checked='<%# Bind("Deny_JobsMenu") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 250px">Deny Jobs :
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_JobsListCheckBox" runat="server" Checked='<%# Bind("Deny_JobsList") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Job:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_NewJobCheckBox" runat="server" Checked='<%# Bind("Deny_NewJob") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 250px">Deny Job Tag Finder:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="CheckBox30" runat="server" Checked='<%# Bind("Deny_JobTagFinder") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Job Codes:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_JobCodesCheckBox" runat="server" Checked='<%# Bind("Deny_JobCodes") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Transmittal:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_TransmittalListCheckBox" runat="server" Checked='<%# Bind("Deny_TransmittalList") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Transmittal Package Types:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_TransmittalPackageTypesCheckBox" runat="server" Checked='<%# Bind("Deny_TransmittalPackageTypes") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Project Clasification:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_ProjectClasificationCheckBox" runat="server" Checked='<%# Bind("Deny_ProjectClasification") %>' /></td>
                                    </tr>

                                    <%--Proposal Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Proposal Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Proposals Menu:
                                        </td>

                                        <td>
                                            <telerik:RadCheckBox ID="CheckBox37" runat="server" Checked='<%# Bind("Deny_ProposalsMenu") %>' />

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Proposals:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_ProposalsListCheckBox" runat="server" Checked='<%# Bind("Deny_ProposalsList") %>' />

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Proposal:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_NewProposalCheckBox" runat="server" Checked='<%# Bind("Deny_NewProposal") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Proposal Tasks:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_ProposalTasksListCheckBox" runat="server" Checked='<%# Bind("Deny_ProposalTasksList") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Proposal Templates:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_ProposalTemplatesCheckBox" runat="server" Checked='<%# Bind("Deny_ProposalTemplates") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Proposal Terms Conditions:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_ProposalTermsConditionsCheckBox" runat="server" Checked='<%# Bind("Deny_ProposalTermsConditions") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Use Classification:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_UseClassificationCheckBox" runat="server" Checked='<%# Bind("Deny_UseClassification") %>' /></td>
                                    </tr>

                                    <%--Billing Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Billing Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Billing Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox2" runat="server" Checked='<%# Bind("Deny_BillingMenu") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Invoices:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_InvoicesListCheckBox" runat="server" Checked='<%# Bind("Deny_InvoicesList") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Statements:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_StatementListCheckBox" runat="server" Checked='<%# Bind("Deny_StatementList") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Billing Schedules:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_BillingSchedulesCheckBox" runat="server" Checked='<%# Bind("Deny_BillingSchedules") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Billing Manager:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_BillingManagerCheckBox" runat="server" Checked='<%# Bind("Deny_BillingManager") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Client Balance Report:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_ClientAccountsReportCheckBox" runat="server" Checked='<%# Bind("Deny_ClientAccountsReport") %>' /></td>
                                    </tr>

                                    <%--Client Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Client Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Clients Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox1" runat="server" Checked='<%# Bind("Deny_ClientsMenu") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Clients:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_ClientsListCheckBox" runat="server" Checked='<%# Bind("Deny_ClientsList") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Client:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_NewClientCheckBox" runat="server" Checked='<%# Bind("Deny_NewClient") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Client Type:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_ClientTypeCheckBox" runat="server" Checked='<%# Bind("Deny_ClientType") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Client Management:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_ClientManagementCheckBox" runat="server" Checked='<%# Bind("Deny_ClientManagement") %>' /></td>
                                    </tr>

                                    <%--Contact Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Contact Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Contacts Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox13" runat="server" Checked='<%# Bind("Deny_ContactsMenu") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Contacts:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox7" runat="server" Checked='<%# Bind("Deny_ContactsList") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Contact:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox8" runat="server" Checked='<%# Bind("Deny_NewContact") %>' /></td>
                                    </tr>

                                    <%--RFP Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">RFP Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Subconsultants Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox6" runat="server" Checked='<%# Bind("Deny_SubconsultantsMenu") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Request for Proposals:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_RequestsProposalsListCheckBox" runat="server" Checked='<%# Bind("Deny_RequestsProposalsList") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Request for Proposal:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_NewRequestProposalsCheckBox" runat="server" Checked='<%# Bind("Deny_NewRequestProposals") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Subconsultants:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_SubconsultantsListCheckBox" runat="server" Checked='<%# Bind("Deny_SubconsultantsList") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Subconsultant:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_NewSubconsultantCheckBox" runat="server" Checked='<%# Bind("Deny_NewSubconsultant") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Disciplines:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_DisciplinesListCheckBox" runat="server" Checked='<%# Bind("Deny_DisciplinesList") %>' /></td>
                                    </tr>

                                </table>
                            </td>
                            <td style="vertical-align: top">
                                <table class="table-hover">
                                    <%--MobileApp Allow Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">MobileApp Allow Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 250px"><span class="label label-danger">Mobile Role</span>:</td>
                                        <td>
                                            <telerik:RadComboBox ID="cboMobileRole" runat="server" SelectedValue='<%# Bind("MobileRole") %>' Width="100%">
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text="Employee" Value="0" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Admin. Department" Value="1" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Admin. Compamy" Value="99" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td><span class="label label-default">Allow MobileApp Dashboard</span>:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox10" runat="server" Checked='<%# Bind("Allow_MobileApp_Dashboard") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow MobileApp Contacts</span>:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox23" runat="server" Checked='<%# Bind("Allow_MobileApp_Contacts") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow MobileApp Clientmap</span>:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox9" runat="server" Checked='<%# Bind("Allow_MobileApp_Clientmap") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow MobileApp Projectmap</span>:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox11" runat="server" Checked='<%# Bind("Allow_MobileApp_Projectmap") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow MobileApp Appointments</span>:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox12" runat="server" Checked='<%# Bind("Allow_MobileApp_Appointments") %>' /></td>
                                    </tr>

                                    <%--Employee Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Employee Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Employees Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox7" runat="server" Checked='<%# Bind("Deny_EmployeesMenu") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Employees:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_EmployeesListCheckBox" runat="server" Checked='<%# Bind("Deny_EmployeesList") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Employee:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_NewEmployeeCheckBox" runat="server" Checked='<%# Bind("Deny_NewEmployee") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Project Time Entries:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_ProjectTimeEntriesCheckBox" runat="server" Checked='<%# Bind("Deny_ProjectTimeEntries") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Payroll:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_PayrollCalendarCheckBox" runat="server" Checked='<%# Bind("Deny_PayrollCalendar") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Timesheet:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_TimesheetCheckBox" runat="server" Checked='<%# Bind("Deny_Timesheet") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Employees Efficiency Chart:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_EmployeesEfficiencyGraphicCheckBox" runat="server" Checked='<%# Bind("Deny_EmployeesEfficiencyGraphic") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Timesheet Report:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_TimesheetReportCheckBox" runat="server" Checked='<%# Bind("Deny_TimesheetReport") %>' /></td>
                                    </tr>

                                    <%--Department Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Department Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Departments Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox10" runat="server" Checked='<%# Bind("Deny_DepartmentsMenu") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Departments:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_DepartmentsListCheckBox" runat="server" Checked='<%# Bind("Deny_DepartmentsList") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Monthly Budget:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_MonthlyBudgetCheckBox" runat="server" Checked='<%# Bind("Deny_MonthlyBudget") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Organization Chart:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_OrganizationChartCheckBox" runat="server" Checked='<%# Bind("Deny_OrganizationChart") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Department Balance:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_DepartmentBalanceCheckBox" runat="server" Checked='<%# Bind("Deny_DepartmentBalance") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Department Chart:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_DepartmentChartCheckBox" runat="server" Checked='<%# Bind("Deny_DepartmentChart") %>' /></td>
                                    </tr>

                                    <%--Expenses Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Expenses Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Expenses Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox11" runat="server" Checked='<%# Bind("Deny_ExpensesMenu") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Vendors:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox19" runat="server" Checked='<%# Bind("Deny_VendorsList") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Vendor:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox20" runat="server" Checked='<%# Bind("Deny_NewVendor") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Expenses:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox32" runat="server" Checked='<%# Bind("Deny_Expenses") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Cashflow:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox33" runat="server" Checked='<%# Bind("Deny_Cashflow") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Expenses Chart:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox34" runat="server" Checked='<%# Bind("Deny_Expenseschart") %>' /></td>
                                    </tr>


                                    <%--Analytics--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Analytics Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Analytics Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Deny_AnalyticsCheckBox" runat="server" Checked='<%# Bind("Deny_Analytics") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Dashboard:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox4" runat="server" Checked='<%# Bind("Deny_Dashboard") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Budget(show/hide buttom):</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Deny_Budget") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Projectmap:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("Deny_Projectmap") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Clientmap:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Bind("Deny_Clientmap") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Analytic Reports:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox5" runat="server" Checked='<%# Bind("Deny_AnalyticReports") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Analytic Charts:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox6" runat="server" Checked='<%# Bind("Deny_AnalyticCharts") %>' /></td>
                                    </tr>

                                    <%--Company Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Company Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Company Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox15" runat="server" Checked='<%# Bind("Deny_CompanyMenu") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Company Profile:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_CompanyProfileCheckBox" runat="server" Checked='<%# Bind("Deny_CompanyProfile") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Multiplier:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox29" runat="server" Checked='<%# Bind("Deny_Multiplier") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Users:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_PASconceptUsersCheckBox" runat="server" Checked='<%# Bind("Deny_PASconceptUsers") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny History Log:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_HistoryLogCheckBox" runat="server" Checked='<%# Bind("Deny_HistoryLog") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Time Categories:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_TimeCategoryCheckBox" runat="server" Checked='<%# Bind("Deny_TimeCategory") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Miscellaneous Time Codes:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_MiscellaneousTimeCodesCheckBox" runat="server" Checked='<%# Bind("Deny_MiscellaneousTimeCodes") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Messages Templates:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_MessagesTemplatesCheckBox" runat="server" Checked='<%# Bind("Deny_MessagesTemplates") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Import data:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_ImportdataCheckBox" runat="server" Checked='<%# Bind("Deny_Importdata") %>' /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>


                    <div style="text-align: right; padding: 5px">
                        <asp:LinkButton ID="UpdateButton" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" CommandName="Update">
                             Update
                        </asp:LinkButton>
                        &nbsp;&nbsp;
                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CssClass="btn btn-default btn-lg" UseSubmitBehavior="false" CausesValidation="False" CommandName="Cancel">
                             Cancel
                    </asp:LinkButton>
                    </div>
                </EditItemTemplate>

                <ItemTemplate>
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td style="width: 100px">Role Name:
                            </td>
                            <td>
                                <h2 style="margin: 0"><%# Eval("Name") %></h2>
                            </td>
                            <td style="width: 150px; text-align: right">
                                <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" CommandName="Edit">
                                        Edit Permissions
                                </asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td>URL Firewall:
                            </td>
                            <td colspan="2">
                                <%# Eval("URLFirewall") %>
                            </td>
                        </tr>
                    </table>
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 50%; vertical-align: top">
                                <table class="table-hover">

                                    <%--Allow Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Allow Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 250px"><span class="label label-danger">Allow Employees Permissions</span>:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Allow_EmployeesPermissionsCheckBox" runat="server" Checked='<%# Eval("Allow_EmployeesPermissions") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow Edit Accepted Proposal</span>:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Allow_EditAcceptedProposalCheckBox" runat="server" Checked='<%# Eval("Allow_EditAcceptedProposal") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow Inactivate Job</span>:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Allow_InactivateJobCheckBox" runat="server" Checked='<%# Eval("Allow_InactivateJob") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow Other Employee Jobs</span>:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Allow_OtherEmployeeJobsCheckBox" runat="server" Checked='<%# Eval("Allow_OtherEmployeeJobs") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow Department Report</span>:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Allow_DepartmentReportCheckBox" runat="server" Checked='<%# Eval("Allow_DepartmentReport") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow Bad Debt</span>:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Allow_BadDebtCheckBox" runat="server" Checked='<%# Eval("Allow_BadDebt") %>' Enabled="false" />
                                        </td>
                                    </tr>

                                    <%--Job Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Job Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 250px">Deny Jobs Menu:
                                        </td>

                                        <td>
                                            <telerik:RadCheckBox ID="CheckBox28" runat="server" Checked='<%# Eval("Deny_JobsMenu") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 250px">Deny Jobs:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_JobsListCheckBox" runat="server" Checked='<%# Eval("Deny_JobsList") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Job:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_NewJobCheckBox" runat="server" Checked='<%# Eval("Deny_NewJob") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Job Tag Finder:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="CheckBox31" runat="server" Checked='<%# Eval("Deny_JobTagFinder") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Job Codes:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_JobCodesCheckBox" runat="server" Checked='<%# Eval("Deny_JobCodes") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Transmittal:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_TransmittalListCheckBox" runat="server" Checked='<%# Eval("Deny_TransmittalList") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Transmittal Package Types:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_TransmittalPackageTypesCheckBox" runat="server" Checked='<%# Eval("Deny_TransmittalPackageTypes") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Project Clasification:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_ProjectClasificationCheckBox" runat="server" Checked='<%# Eval("Deny_ProjectClasification") %>' Enabled="false" /></td>
                                    </tr>

                                    <%--Proposal Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Proposal Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Proposals Menu:
                                        </td>

                                        <td>
                                            <telerik:RadCheckBox ID="CheckBox38" runat="server" Checked='<%# Eval("Deny_ProposalsMenu") %>' Enabled="false" />

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Proposals:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_ProposalsListCheckBox" runat="server" Checked='<%# Eval("Deny_ProposalsList") %>' Enabled="false" />

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Proposal:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_NewProposalCheckBox" runat="server" Checked='<%# Eval("Deny_NewProposal") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Proposal Tasks:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_ProposalTasksListCheckBox" runat="server" Checked='<%# Eval("Deny_ProposalTasksList") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Proposal Templates:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_ProposalTemplatesCheckBox" runat="server" Checked='<%# Eval("Deny_ProposalTemplates") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Proposal Terms and Conditions:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_ProposalTermsConditionsCheckBox" runat="server" Checked='<%# Eval("Deny_ProposalTermsConditions") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Use Classification:
                                        </td>

                                        <td>
                                            <asp:CheckBox ID="Deny_UseClassificationCheckBox" runat="server" Checked='<%# Eval("Deny_UseClassification") %>' Enabled="false" /></td>
                                    </tr>

                                    <%--Billing Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Billing Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Billing Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox1" runat="server" Checked='<%# Eval("Deny_BillingMenu") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Invoices:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_InvoicesListCheckBox" runat="server" Checked='<%# Eval("Deny_InvoicesList") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Statements:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_StatementListCheckBox" runat="server" Checked='<%# Eval("Deny_StatementList") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Billing Schedules:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_BillingSchedulesCheckBox" runat="server" Checked='<%# Eval("Deny_BillingSchedules") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Billing Manager:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_BillingManagerCheckBox" runat="server" Checked='<%# Eval("Deny_BillingManager") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Client Balance Report:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_ClientAccountsReportCheckBox" runat="server" Checked='<%# Eval("Deny_ClientAccountsReport") %>' Enabled="false" /></td>
                                    </tr>

                                    <%--Client Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Client Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Clients Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox4" runat="server" Checked='<%# Eval("Deny_ClientsMenu") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Clients:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_ClientsListCheckBox" runat="server" Checked='<%# Eval("Deny_ClientsList") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Client:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_NewClientCheckBox" runat="server" Checked='<%# Eval("Deny_NewClient") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Client Type:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_ClientTypeCheckBox" runat="server" Checked='<%# Eval("Deny_ClientType") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Client Management:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_ClientManagementCheckBox" runat="server" Checked='<%# Eval("Deny_ClientManagement") %>' Enabled="false" /></td>
                                    </tr>

                                    <%--Contact Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Contact Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Contacts Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox14" runat="server" Checked='<%# Eval("Deny_ContactsMenu") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Contacts:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox13" runat="server" Checked='<%# Eval("Deny_ContactsList") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Contact:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox14" runat="server" Checked='<%# Eval("Deny_NewContact") %>' Enabled="false" /></td>
                                    </tr>

                                    <%--RFP Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">RFP Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Subconsultants Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox5" runat="server" Checked='<%# Eval("Deny_SubconsultantsMenu") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Request fro Proposals:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_RequestsProposalsListCheckBox" runat="server" Checked='<%# Eval("Deny_RequestsProposalsList") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Request for Proposal:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_NewRequestProposalsCheckBox" runat="server" Checked='<%# Eval("Deny_NewRequestProposals") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Subconsultants:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_SubconsultantsListCheckBox" runat="server" Checked='<%# Eval("Deny_SubconsultantsList") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Subconsultant:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_NewSubconsultantCheckBox" runat="server" Checked='<%# Eval("Deny_NewSubconsultant") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Disciplines:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_DisciplinesListCheckBox" runat="server" Checked='<%# Eval("Deny_DisciplinesList") %>' Enabled="false" /></td>
                                    </tr>

                                </table>
                            </td>
                            <td style="vertical-align: top">
                                <table class="table-hover">

                                    <%--Allow MobileApp Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Allow MobileApp Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 250px"><span class="label label-danger">Mobile Role</span>:</td>
                                        <td>
                                            <%# Eval("MobileRoleName") %></td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow MobileApp Dashboard</span>:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox16" runat="server" Checked='<%# Eval("Allow_MobileApp_Dashboard") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow MobileApp Contacts</span>:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox24" runat="server" Checked='<%# Eval("Allow_MobileApp_Contacts") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow MobileApp Clientmap</span>:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox15" runat="server" Checked='<%# Eval("Allow_MobileApp_Clientmap") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow MobileApp Projectmap</span>:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox17" runat="server" Checked='<%# Eval("Allow_MobileApp_Projectmap") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td><span class="label label-default">Allow MobileApp Appointments</span>:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox18" runat="server" Checked='<%# Eval("Allow_MobileApp_Appointments") %>' Enabled="false" /></td>
                                    </tr>

                                    <%--Employee Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Employee Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Employees Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox8" runat="server" Checked='<%# Eval("Deny_EmployeesMenu") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Employees:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_EmployeesListCheckBox" runat="server" Checked='<%# Eval("Deny_EmployeesList") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Employee:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_NewEmployeeCheckBox" runat="server" Checked='<%# Eval("Deny_NewEmployee") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Project Time Entries:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_ProjectTimeEntriesCheckBox" runat="server" Checked='<%# Eval("Deny_ProjectTimeEntries") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Payroll:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_PayrollCalendarCheckBox" runat="server" Checked='<%# Eval("Deny_PayrollCalendar") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Timesheet:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_TimesheetCheckBox" runat="server" Checked='<%# Eval("Deny_Timesheet") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Employees Efficiency Chart:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_EmployeesEfficiencyGraphicCheckBox" runat="server" Checked='<%# Eval("Deny_EmployeesEfficiencyGraphic") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Timesheet Report:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_TimesheetReportCheckBox" runat="server" Checked='<%# Eval("Deny_TimesheetReport") %>' Enabled="false" /></td>
                                    </tr>

                                    <%--Department Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Department Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Departments Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox9" runat="server" Checked='<%# Eval("Deny_DepartmentsMenu") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Departments:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_DepartmentsListCheckBox" runat="server" Checked='<%# Eval("Deny_DepartmentsList") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Monthly Budget:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_MonthlyBudgetCheckBox" runat="server" Checked='<%# Eval("Deny_MonthlyBudget") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Organization Chart:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_OrganizationChartCheckBox" runat="server" Checked='<%# Eval("Deny_OrganizationChart") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Department Balance:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_DepartmentBalanceCheckBox" runat="server" Checked='<%# Eval("Deny_DepartmentBalance") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Department Chart:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_DepartmentChartCheckBox" runat="server" Checked='<%# Eval("Deny_DepartmentChart") %>' Enabled="false" /></td>
                                    </tr>

                                    <%--Expenses Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Expenses Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Expenses Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox12" runat="server" Checked='<%# Eval("Deny_ExpensesMenu") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Vendors:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox21" runat="server" Checked='<%# Eval("Deny_VendorsList") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny New Vendor:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox22" runat="server" Checked='<%# Eval("Deny_NewVendor") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Expenses:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox25" runat="server" Checked='<%# Eval("Deny_Expenses") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Cashflow:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox35" runat="server" Checked='<%# Eval("Deny_Cashflow") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Expenses Chart:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox36" runat="server" Checked='<%# Eval("Deny_Expenseschart") %>' Enabled="false" /></td>
                                    </tr>

                                    <%--AnalyticsDeny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Analytics Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Analytics Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="Deny_AnalyticsCheckBox" runat="server" Checked='<%# Eval("Deny_Analytics") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Dashboard:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox4" runat="server" Checked='<%# Eval("Deny_Dashboard") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Budget(show/hide buttom):</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("Deny_Budget") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Projectmap:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Eval("Deny_Projectmap") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Clientmap:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Eval("Deny_Clientmap") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Analytic Reports:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox5" runat="server" Checked='<%# Eval("Deny_AnalyticReports") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Analytic Charts:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox6" runat="server" Checked='<%# Eval("Deny_AnalyticCharts") %>' Enabled="false" /></td>
                                    </tr>

                                    <%--Company Deny Permits--%>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <h4 style="margin-bottom: 0">Company Deny Permits</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Company Menu:</td>
                                        <td>
                                            <telerik:RadCheckBox ID="RadCheckBox16" runat="server" Checked='<%# Eval("Deny_CompanyMenu") %>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Deny Company Profile:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_CompanyProfileCheckBox" runat="server" Checked='<%# Eval("Deny_CompanyProfile") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Multiplier:</td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox26" runat="server" Checked='<%# Eval("Deny_Multiplier") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Users:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_PASconceptUsersCheckBox" runat="server" Checked='<%# Eval("Deny_PASconceptUsers") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny History Log:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_HistoryLogCheckBox" runat="server" Checked='<%# Eval("Deny_HistoryLog") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Time Category:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_TimeCategoryCheckBox" runat="server" Checked='<%# Eval("Deny_TimeCategory") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Miscellaneous Time Codes:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_MiscellaneousTimeCodesCheckBox" runat="server" Checked='<%# Eval("Deny_MiscellaneousTimeCodes") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Messages Templates:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_MessagesTemplatesCheckBox" runat="server" Checked='<%# Eval("Deny_MessagesTemplates") %>' Enabled="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>Deny Import Data:</td>
                                        <td>
                                            <asp:CheckBox ID="Deny_ImportdataCheckBox" runat="server" Checked='<%# Eval("Deny_Importdata") %>' Enabled="false" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>

                </ItemTemplate>
            </asp:FormView>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_role_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Employee_PermissionsRole_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblRoleId" Name="Id" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Deny_JobsList" Type="Boolean" />
            <asp:Parameter Name="Deny_NewJob" Type="Boolean" />
            <asp:Parameter Name="Deny_JobCodes" Type="Boolean" />
            <asp:Parameter Name="Deny_TransmittalList" Type="Boolean" />
            <asp:Parameter Name="Deny_TransmittalPackageTypes" Type="Boolean" />
            <asp:Parameter Name="Deny_ProposalsList" Type="Boolean" />
            <asp:Parameter Name="Deny_NewProposal" Type="Boolean" />
            <asp:Parameter Name="Deny_ProposalTasksList" Type="Boolean" />
            <asp:Parameter Name="Deny_ProposalTemplates" Type="Boolean" />
            <asp:Parameter Name="Deny_ProposalTermsConditions" Type="Boolean" />
            <asp:Parameter Name="Deny_BillingManager" Type="Boolean" />
            <asp:Parameter Name="Deny_InvoicesList" Type="Boolean" />
            <asp:Parameter Name="Deny_StatementList" Type="Boolean" />
            <asp:Parameter Name="Deny_BillingSchedules" Type="Boolean" />
            <asp:Parameter Name="Deny_ClientAccountsReport" Type="Boolean" />
            <asp:Parameter Name="Deny_ClientsList" Type="Boolean" />
            <asp:Parameter Name="Deny_NewClient" Type="Boolean" />
            <asp:Parameter Name="Deny_ClientType" Type="Boolean" />
            <asp:Parameter Name="Deny_ClientManagement" Type="Boolean" />
            <asp:Parameter Name="Deny_RequestsProposalsList" Type="Boolean" />
            <asp:Parameter Name="Deny_NewRequestProposals" Type="Boolean" />
            <asp:Parameter Name="Deny_SubconsultantsList" Type="Boolean" />
            <asp:Parameter Name="Deny_NewSubconsultant" Type="Boolean" />
            <asp:Parameter Name="Deny_DisciplinesList" Type="Boolean" />
            <asp:Parameter Name="Deny_EmployeesList" Type="Boolean" />
            <asp:Parameter Name="Deny_NewEmployee" Type="Boolean" />
            <asp:Parameter Name="Deny_ProjectTimeEntries" Type="Boolean" />
            <asp:Parameter Name="Deny_PayrollCalendar" Type="Boolean" />
            <asp:Parameter Name="Deny_Timesheet" Type="Boolean" />
            <asp:Parameter Name="Deny_EmployeesEfficiencyGraphic" Type="Boolean" />
            <asp:Parameter Name="Deny_TimesheetReport" Type="Boolean" />
            <asp:Parameter Name="Deny_Analytics" Type="Boolean" />
            <asp:Parameter Name="Deny_CompanyProfile" Type="Boolean" />
            <asp:Parameter Name="Deny_PASconceptUsers" Type="Boolean" />
            <asp:Parameter Name="Deny_HistoryLog" Type="Boolean" />
            <asp:Parameter Name="Deny_MiscellaneousTimeCodes" Type="Boolean" />
            <asp:Parameter Name="Deny_MessagesTemplates" Type="Boolean" />
            <asp:Parameter Name="Deny_Importdata" Type="Boolean" />
            <asp:Parameter Name="Allow_EmployeesPermissions" Type="Boolean" />

            <asp:Parameter Name="Deny_ProjectClasification" Type="Boolean" />
            <asp:Parameter Name="Deny_UseClassification" Type="Boolean" />
            <asp:Parameter Name="Deny_DepartmentsList" Type="Boolean" />
            <asp:Parameter Name="Deny_MonthlyBudget" Type="Boolean" />
            <asp:Parameter Name="Deny_OrganizationChart" Type="Boolean" />
            <asp:Parameter Name="Deny_DepartmentBalance" Type="Boolean" />
            <asp:Parameter Name="Deny_DepartmentChart" Type="Boolean" />
            <asp:Parameter Name="Deny_TimeCategory" Type="Boolean" />
            <asp:Parameter Name="Allow_EditAcceptedProposal" Type="Boolean" />
            <asp:Parameter Name="Allow_InactivateJob" Type="Boolean" />
            <asp:Parameter Name="Allow_OtherEmployeeJobs" Type="Boolean" />
            <asp:Parameter Name="Allow_DepartmentReport" Type="Boolean" />
            <asp:Parameter Name="Allow_BadDebt" Type="Boolean" />

            <asp:Parameter Name="Deny_Budget" Type="Boolean" />
            <asp:Parameter Name="Deny_Projectmap" Type="Boolean" />
            <asp:Parameter Name="Deny_Clientmap" Type="Boolean" />
            <asp:Parameter Name="Deny_Dashboard" Type="Boolean" />
            <asp:Parameter Name="Deny_AnalyticReports" Type="Boolean" />
            <asp:Parameter Name="Deny_AnalyticCharts" Type="Boolean" />

            <asp:Parameter Name="Deny_ContactsList" Type="Boolean" />
            <asp:Parameter Name="Deny_NewContact" Type="Boolean" />
            <asp:Parameter Name="Deny_VendorsList" Type="Boolean" />
            <asp:Parameter Name="Deny_NewVendor" Type="Boolean" />

            <asp:Parameter Name="Allow_MobileApp_Dashboard" Type="Boolean" />
            <asp:Parameter Name="Allow_MobileApp_Contacts" Type="Boolean" />
            <asp:Parameter Name="Allow_MobileApp_Clientmap" Type="Boolean" />
            <asp:Parameter Name="Allow_MobileApp_Projectmap" Type="Boolean" />
            <asp:Parameter Name="Allow_MobileApp_Appointments" Type="Boolean" />

            <asp:Parameter Name="URLFirewall" Type="String" />

            <asp:Parameter Name="Deny_JobTagFinder" Type="Boolean" />
            <asp:Parameter Name="Deny_Expenses" Type="Boolean" />
            <asp:Parameter Name="Deny_Cashflow" Type="Boolean" />
            <asp:Parameter Name="Deny_Expenseschart" Type="Boolean" />
            <asp:Parameter Name="Deny_Multiplier" Type="Boolean" />

            <asp:Parameter Name="Deny_JobsMenu" Type="Boolean" />
            <asp:Parameter Name="Deny_ProposalsMenu" Type="Boolean" />
            <asp:Parameter Name="Deny_BillingMenu" Type="Boolean" />
            <asp:Parameter Name="Deny_ClientsMenu" Type="Boolean" />
            <asp:Parameter Name="Deny_SubconsultantsMenu" Type="Boolean" />
            <asp:Parameter Name="Deny_EmployeesMenu" Type="Boolean" />
            <asp:Parameter Name="Deny_DepartmentsMenu" Type="Boolean" />
            <asp:Parameter Name="Deny_ExpensesMenu" Type="Boolean" />
            <asp:Parameter Name="Deny_ContactsMenu" Type="Boolean" />
            <asp:Parameter Name="Deny_CompanyMenu" Type="Boolean" />

            <asp:Parameter Name="Name" Type="String" />

            <asp:Parameter Name="MobileRole" />

            <asp:ControlParameter ControlID="lblRoleId" Name="Id" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblRoleId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>

</asp:Content>
