<%@ Page Title="Employee Permissions" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="employee_permissions.aspx.vb" Inherits="pasconcept20.employee_permissions" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .EditFormHeader td {
            background: #dadec8;
            padding: 5px 0px;
        }
    </style>
    <table class="table-condensed Formulario" style="width:100%">
        <tr>
            <td class="ToolButtom noprint Normal" style="width: 200px">
                <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" AppendDataBoundItems="true" Label="Status" AutoPostBack="true">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="Active" Value="0" Selected="true" />
                        <telerik:RadComboBoxItem runat="server" Text="Inactive" Value="1" />
                        <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" />
                    </Items>
                </telerik:RadComboBox>
            </td>
            <td class="ToolButtom noprint Normal" style="width: 200px">
                <telerik:RadComboBox ID="cboSourceRole" runat="server" AppendDataBoundItems="true"
                    Width="100%" DataSourceID="SqlDataSourceRoles" DataTextField="Name" DataValueField="Id" Height="300px">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(Select Role...)" Value="-1" />
                    </Items>
                </telerik:RadComboBox>

            </td>
            <td>
                <asp:LinkButton ID="btnApply" runat="server"
                    CssClass="btn btn-danger btn" UseSubmitBehavior="false">
                                     Apply Role to selected employees
                </asp:LinkButton>
            </td>
            <td>
                <telerik:RadTextBox ID="txtIPv4" runat="server" Width="200px"
                    MaxLength="80" EmptyMessage="Type IP v4" ToolTip="IP v4 to Apply Selected Role">
                </telerik:RadTextBox>
                <asp:LinkButton ID="btnApplyIPv4toRole" runat="server"
                    CssClass="btn btn-danger btn" UseSubmitBehavior="false">
                                     Apply IP v4 to Role
                </asp:LinkButton>
            </td>
            <td style="width: 100px">
                <asp:LinkButton ID="btnExport" runat="server" UseSubmitBehavior="false" class="btn btn-default">
                   <span class="glyphicon glyphicon-save"> Export</span>
                </asp:LinkButton>
            </td>
        </tr>

    </table>
    <div>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                function OnClientClose(sender, args) {
                    var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                    masterTable.rebind();
                    $find("<%= cboSourceRole.ClientID %>").rebind();
                }
            </script>
        </telerik:RadCodeBlock>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" AllowMultiRowSelection="True" ShowFooter="true"
            Width="100%" AutoGenerateColumns="False" AllowPaging="True" PageSize="100" AllowSorting="True" GroupPanelPosition="Top" HeaderStyle-Font-Size="X-Small">
            <ClientSettings EnableRowHoverStyle="true">
                <ClientEvents OnGridCreated="isRowSelected" OnRowSelected="isRowSelected" OnRowDeselected="isRowSelected"></ClientEvents>
                <Selecting AllowRowSelect="True"></Selecting>
            </ClientSettings>
            <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="Id" ClientDataKeyNames="Id" EditMode="PopUp">
                <Columns>
                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="Id" ReadOnly="True" HeaderText="Id" UniqueName="Id" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Name" ReadOnly="True" FilterControlAltText="Filter Name column" Aggregate="Count" FooterAggregateFormatString="{0:N0}"
                        HeaderText="Employee Name" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="btnPermits" CommandName="Permits" CommandArgument='<%# Eval("Id") %>'
                                ToolTip="Employee Permits"><%# Eval("Name")%>
                                                <span class="glyphicon glyphicon-cog"></span>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Role" FilterControlAltText="Filter Role column" HeaderText="Role" SortExpression="Role" UniqueName="Role" ReadOnly="True"
                        HeaderStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="URLFirewall" FilterControlAltText="Filter URLFirewall column" HeaderText="IP v4 Firewall" SortExpression="URLFirewall" UniqueName="URLFirewall" ReadOnly="True"
                        HeaderStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridCheckBoxColumn DataField="Allow_EmployeesPermissions" DataType="System.Boolean" EditFormColumnIndex="0"
                        FilterControlAltText="Filter Allow_EmployeesPermissions column" HeaderText="Allow Empl Perm"
                        SortExpression="Allow_EmployeesPermissions" UniqueName="Allow_EmployeesPermissions"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridCheckBoxColumn>
                    <telerik:GridCheckBoxColumn DataField="Allow_EditAcceptedProposal" DataType="System.Boolean" EditFormColumnIndex="0"
                        FilterControlAltText="Filter Allow_EditAcceptedProposal column" HeaderText="Allow Edit Accepted Prop"
                        SortExpression="Allow_EditAcceptedProposal" UniqueName="Allow_EditAcceptedProposal"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridCheckBoxColumn>
                    <telerik:GridCheckBoxColumn DataField="Allow_InactivateJob" DataType="System.Boolean" EditFormColumnIndex="0"
                        FilterControlAltText="Filter Allow_InactivateJob column" HeaderText="Allow Inact Jobs"
                        SortExpression="Allow_InactivateJob" UniqueName="Allow_InactivateJob"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridCheckBoxColumn>
                    <telerik:GridCheckBoxColumn DataField="Allow_DepartmentReport" DataType="System.Boolean" EditFormColumnIndex="0"
                        FilterControlAltText="Filter Allow_DepartmentReport column" HeaderText="Allow Dep/Emp Report"
                        SortExpression="Allow_DepartmentReport" UniqueName="Allow_DepartmentReport"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridCheckBoxColumn>
                    <telerik:GridCheckBoxColumn DataField="Allow_BadDebt" DataType="System.Boolean" EditFormColumnIndex="0"
                        FilterControlAltText="Filter Allow_BadDebt column" HeaderText="Allow Inv BadDebt"
                        SortExpression="Allow_BadDebt" UniqueName="Allow_BadDebt"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridCheckBoxColumn>


                </Columns>
                <EditFormSettings ColumnNumber="4" CaptionDataField="Name" CaptionFormatString="Edit Permissions of <b>{0}</b>" FormCaptionStyle-ForeColor="#ff8c00">
                    <PopUpSettings Modal="true" Width="800px" />
                    <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                    <FormCaptionStyle CssClass="EditFormHeader"></FormCaptionStyle>
                    <FormMainTableStyle GridLines="None" CellSpacing="0" CellPadding="3" Width="100%" />
                    <FormTableStyle GridLines="Horizontal" CellSpacing="0" CellPadding="2" BackColor="White"
                        Width="100%" />
                    <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                    <FormStyle Width="100%" BackColor="#eef2ea"></FormStyle>
                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1"
                        CancelText="Cancel">
                    </EditColumn>
                    <FormTableButtonRowStyle HorizontalAlign="Left" CssClass="EditFormButtonRow"></FormTableButtonRowStyle>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <div style="height: 1px; overflow: auto">
        <asp:Panel ID="ExportPanel" runat="server" Height="1px">
            <telerik:RadGrid ID="RadGridToPrint" runat="server" DataSourceID="SqlDataSource1" Width="100%" Culture="en-US">
                <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" AutoGenerateColumns="False">
                    <Columns>
                        <telerik:GridBoundColumn DataField="Id" FilterControlAltText="Filter Id column" HeaderText="Id" SortExpression="Id" UniqueName="Id" DataType="System.Int32" ReadOnly="True">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name" ReadOnly="True">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Role" FilterControlAltText="Filter Role column" HeaderText="Role" SortExpression="Role" UniqueName="Role" ReadOnly="True">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="URLFirewall" FilterControlAltText="Filter URLFirewall column" HeaderText="URLFirewall" SortExpression="URLFirewall" UniqueName="URLFirewall" ReadOnly="True">
                        </telerik:GridBoundColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_JobsList" DataType="System.Int16" FilterControlAltText="Filter Deny_JobsList column" HeaderText="Deny_JobsList" SortExpression="Deny_JobsList" UniqueName="Deny_JobsList">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_NewJob" DataType="System.Int16" FilterControlAltText="Filter Deny_NewJob column" HeaderText="Deny_NewJob" SortExpression="Deny_NewJob" UniqueName="Deny_NewJob">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_JobCodes" DataType="System.Int16" FilterControlAltText="Filter Deny_JobCodes column" HeaderText="Deny_JobCodes" SortExpression="Deny_JobCodes" UniqueName="Deny_JobCodes">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_TransmittalList" DataType="System.Int16" FilterControlAltText="Filter Deny_TransmittalList column" HeaderText="Deny_TransmittalList" SortExpression="Deny_TransmittalList" UniqueName="Deny_TransmittalList">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_TransmittalPackageTypes" DataType="System.Int16" FilterControlAltText="Filter Deny_TransmittalPackageTypes column" HeaderText="Deny_TransmittalPackageTypes" SortExpression="Deny_TransmittalPackageTypes" UniqueName="Deny_TransmittalPackageTypes">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_ProjectClasification" DataType="System.Int16" FilterControlAltText="Filter Deny_ProjectClasification column" HeaderText="Deny_ProjectClasification" SortExpression="Deny_ProjectClasification" UniqueName="Deny_ProjectClasification">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_ProposalsList" DataType="System.Int16" FilterControlAltText="Filter Deny_ProposalsList column" HeaderText="Deny_ProposalsList" SortExpression="Deny_ProposalsList" UniqueName="Deny_ProposalsList">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_NewProposal" DataType="System.Int16" FilterControlAltText="Filter Deny_NewProposal column" HeaderText="Deny_NewProposal" SortExpression="Deny_NewProposal" UniqueName="Deny_NewProposal">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_ProposalTasksList" DataType="System.Int16" FilterControlAltText="Filter Deny_ProposalTasksList column" HeaderText="Deny_ProposalTasksList" SortExpression="Deny_ProposalTasksList" UniqueName="Deny_ProposalTasksList">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_ProposalTemplates" DataType="System.Int16" FilterControlAltText="Filter Deny_ProposalTemplates column" HeaderText="Deny_ProposalTemplates" SortExpression="Deny_ProposalTemplates" UniqueName="Deny_ProposalTemplates">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_ProposalTermsConditions" DataType="System.Int16" FilterControlAltText="Filter Deny_ProposalTermsConditions column" HeaderText="Deny_ProposalTermsConditions" SortExpression="Deny_ProposalTermsConditions" UniqueName="Deny_ProposalTermsConditions">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_UseClassification" DataType="System.Int16" FilterControlAltText="Filter Deny_UseClassification column" HeaderText="Deny_UseClassification" SortExpression="Deny_UseClassification" UniqueName="Deny_UseClassification">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_InvoicesList" DataType="System.Int16" FilterControlAltText="Filter Deny_InvoicesList column" HeaderText="Deny_InvoicesList" SortExpression="Deny_InvoicesList" UniqueName="Deny_InvoicesList">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_StatementList" DataType="System.Int16" FilterControlAltText="Filter Deny_StatementList column" HeaderText="Deny_StatementList" SortExpression="Deny_StatementList" UniqueName="Deny_StatementList">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_BillingSchedules" DataType="System.Int16" FilterControlAltText="Filter Deny_BillingSchedules column" HeaderText="Deny_BillingSchedules" SortExpression="Deny_BillingSchedules" UniqueName="Deny_BillingSchedules">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_BillingManager" DataType="System.Int16" FilterControlAltText="Filter Deny_BillingManager column" HeaderText="Deny_BillingManager" ReadOnly="True" SortExpression="Deny_BillingManager" UniqueName="Deny_BillingManager">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_ClientAccountsReport" DataType="System.Int16" FilterControlAltText="Filter Deny_ClientAccountsReport column" HeaderText="Deny_ClientAccountsReport" SortExpression="Deny_ClientAccountsReport" UniqueName="Deny_ClientAccountsReport">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_ClientsList" DataType="System.Int16" FilterControlAltText="Filter Deny_ClientsList column" HeaderText="Deny_ClientsList" SortExpression="Deny_ClientsList" UniqueName="Deny_ClientsList">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_NewClient" DataType="System.Int16" FilterControlAltText="Filter Deny_NewClient column" HeaderText="Deny_NewClient" SortExpression="Deny_NewClient" UniqueName="Deny_NewClient">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_ClientType" DataType="System.Int16" FilterControlAltText="Filter Deny_ClientType column" HeaderText="Deny_ClientType" SortExpression="Deny_ClientType" UniqueName="Deny_ClientType">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_ClientManagement" DataType="System.Int16" FilterControlAltText="Filter Deny_ClientManagement column" HeaderText="Deny_ClientManagement" SortExpression="Deny_ClientManagement" UniqueName="Deny_ClientManagement">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_RequestsProposalsList" DataType="System.Int16" FilterControlAltText="Filter Deny_RequestsProposalsList column" HeaderText="Deny_RequestsProposalsList" SortExpression="Deny_RequestsProposalsList" UniqueName="Deny_RequestsProposalsList">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_NewRequestProposals" DataType="System.Int16" FilterControlAltText="Filter Deny_NewRequestProposals column" HeaderText="Deny_NewRequestProposals" SortExpression="Deny_NewRequestProposals" UniqueName="Deny_NewRequestProposals">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_SubconsultantsList" DataType="System.Int16" FilterControlAltText="Filter Deny_SubconsultantsList column" HeaderText="Deny_SubconsultantsList" SortExpression="Deny_SubconsultantsList" UniqueName="Deny_SubconsultantsList">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_NewSubconsultant" DataType="System.Int16" FilterControlAltText="Filter Deny_NewSubconsultant column" HeaderText="Deny_NewSubconsultant" SortExpression="Deny_NewSubconsultant" UniqueName="Deny_NewSubconsultant">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_DisciplinesList" DataType="System.Int16" FilterControlAltText="Filter Deny_DisciplinesList column" HeaderText="Deny_DisciplinesList" SortExpression="Deny_DisciplinesList" UniqueName="Deny_DisciplinesList">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_EmployeesList" DataType="System.Int16" FilterControlAltText="Filter Deny_EmployeesList column" HeaderText="Deny_EmployeesList" SortExpression="Deny_EmployeesList" UniqueName="Deny_EmployeesList">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_NewEmployee" DataType="System.Int16" FilterControlAltText="Filter Deny_NewEmployee column" HeaderText="Deny_NewEmployee" SortExpression="Deny_NewEmployee" UniqueName="Deny_NewEmployee">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_ProjectTimeEntries" DataType="System.Int16" FilterControlAltText="Filter Deny_ProjectTimeEntries column" HeaderText="Deny_ProjectTimeEntries" SortExpression="Deny_ProjectTimeEntries" UniqueName="Deny_ProjectTimeEntries">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_PayrollCalendar" DataType="System.Int16" FilterControlAltText="Filter Deny_PayrollCalendar column" HeaderText="Deny_PayrollCalendar" SortExpression="Deny_PayrollCalendar" UniqueName="Deny_PayrollCalendar">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_Timesheet" DataType="System.Int16" FilterControlAltText="Filter Deny_Timesheet column" HeaderText="Deny_Timesheet" SortExpression="Deny_Timesheet" UniqueName="Deny_Timesheet">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_EmployeesEfficiencyGraphic" DataType="System.Int16" FilterControlAltText="Filter Deny_EmployeesEfficiencyGraphic column" HeaderText="Deny_EmployeesEfficiencyGraphic" SortExpression="Deny_EmployeesEfficiencyGraphic" UniqueName="Deny_EmployeesEfficiencyGraphic">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_TimesheetReport" DataType="System.Int16" FilterControlAltText="Filter Deny_TimesheetReport column" HeaderText="Deny_TimesheetReport" SortExpression="Deny_TimesheetReport" UniqueName="Deny_TimesheetReport">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_Analytics" DataType="System.Int16" FilterControlAltText="Filter Deny_Analytics column" HeaderText="Deny_Analytics" SortExpression="Deny_Analytics" UniqueName="Deny_Analytics">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_DepartmentsList" DataType="System.Int16" FilterControlAltText="Filter Deny_DepartmentsList column" HeaderText="Deny_DepartmentsList" SortExpression="Deny_DepartmentsList" UniqueName="Deny_DepartmentsList">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_MonthlyBudget" DataType="System.Int16" FilterControlAltText="Filter Deny_MonthlyBudget column" HeaderText="Deny_MonthlyBudget" SortExpression="Deny_MonthlyBudget" UniqueName="Deny_MonthlyBudget">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_OrganizationChart" DataType="System.Int16" FilterControlAltText="Filter Deny_OrganizationChart column" HeaderText="Deny_OrganizationChart" SortExpression="Deny_OrganizationChart" UniqueName="Deny_OrganizationChart">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_DepartmentBalance" DataType="System.Int16" FilterControlAltText="Filter Deny_DepartmentBalance column" HeaderText="Deny_DepartmentBalance" SortExpression="Deny_DepartmentBalance" UniqueName="Deny_DepartmentBalance">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_DepartmentChart" DataType="System.Int16" FilterControlAltText="Filter Deny_DepartmentChart column" HeaderText="Deny_DepartmentChart" SortExpression="Deny_DepartmentChart" UniqueName="Deny_DepartmentChart">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_CompanyProfile" DataType="System.Int16" FilterControlAltText="Filter Deny_CompanyProfile column" HeaderText="Deny_CompanyProfile" SortExpression="Deny_CompanyProfile" UniqueName="Deny_CompanyProfile">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_PASconceptUsers" DataType="System.Int16" FilterControlAltText="Filter Deny_PASconceptUsers column" HeaderText="Deny_PASconceptUsers" SortExpression="Deny_PASconceptUsers" UniqueName="Deny_PASconceptUsers">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_HistoryLog" DataType="System.Int16" FilterControlAltText="Filter Deny_HistoryLog column" HeaderText="Deny_HistoryLog" SortExpression="Deny_HistoryLog" UniqueName="Deny_HistoryLog">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_TimeCategory" DataType="System.Int16" FilterControlAltText="Filter Deny_TimeCategory column" HeaderText="Deny_TimeCategory" SortExpression="Deny_TimeCategory" UniqueName="Deny_TimeCategory">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_MiscellaneousTimeCodes" DataType="System.Int16" FilterControlAltText="Filter Deny_MiscellaneousTimeCodes column" HeaderText="Deny_MiscellaneousTimeCodes" SortExpression="Deny_MiscellaneousTimeCodes" UniqueName="Deny_MiscellaneousTimeCodes">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_MessagesTemplates" DataType="System.Int16" FilterControlAltText="Filter Deny_MessagesTemplates column" HeaderText="Deny_MessagesTemplates" SortExpression="Deny_MessagesTemplates" UniqueName="Deny_MessagesTemplates">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Deny_Importdata" DataType="System.Int16" FilterControlAltText="Filter Deny_Importdata column" HeaderText="Deny_Importdata" SortExpression="Deny_Importdata" UniqueName="Deny_Importdata">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Allow_EmployeesPermissions" DataType="System.Int16" FilterControlAltText="Filter Allow_EmployeesPermissions column" HeaderText="Allow_EmployeesPermissions" SortExpression="Allow_EmployeesPermissions" UniqueName="Allow_EmployeesPermissions">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Allow_EditAcceptedProposal" DataType="System.Int16" FilterControlAltText="Filter Allow_EditAcceptedProposal column" HeaderText="Allow_EditAcceptedProposal" SortExpression="Allow_EditAcceptedProposal" UniqueName="Allow_EditAcceptedProposal">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Allow_InactivateJob" DataType="System.Int16" FilterControlAltText="Filter Allow_InactivateJob column" HeaderText="Allow_InactivateJob" SortExpression="Allow_InactivateJob" UniqueName="Allow_InactivateJob">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Allow_OtherEmployeeJobs" DataType="System.Int16" FilterControlAltText="Filter Allow_OtherEmployeeJobs column" HeaderText="Allow_OtherEmployeeJobs" SortExpression="Allow_OtherEmployeeJobs" UniqueName="Allow_OtherEmployeeJobs">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Allow_DepartmentReport" DataType="System.Int16" FilterControlAltText="Filter Allow_DepartmentReport column" HeaderText="Allow_DepartmentReport" SortExpression="Allow_DepartmentReport" UniqueName="Allow_DepartmentReport">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Allow_BadDebt" DataType="System.Int16" FilterControlAltText="Filter Allow_BadDebt column" HeaderText="Allow_BadDebt" SortExpression="Allow_BadDebt" UniqueName="Allow_BadDebt">
                        </telerik:GridCheckBoxColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </asp:Panel>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    </telerik:RadWindowManager>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_Permissions_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="empl_COPY_ROLE" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblRoleId" Name="roleId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblSelectedEmpl" Name="empl_Dest" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="InactiveId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceRoles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Employees_roles where companyId=@companyId order by Name" 
        UpdateCommand="Employee_IPv4_byRole_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="txtIPv4" DefaultValue="" Name="IPv4" PropertyName="Text"  />
            <asp:ControlParameter ControlID="cboSourceRole" Name="Role" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblRoleId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedEmpl" runat="server" Visible="False"></asp:Label>
</asp:Content>
