<%@ Page Title="Employee Permissions" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="employee_permissions.aspx.vb" Inherits="pasconcept20.employee_permissions" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .EditFormHeader td {
            background: #dadec8;
            padding: 5px 0px;
        }
    </style>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Employee Permissions</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>

            <asp:LinkButton ID="btnExport" runat="server" ToolTip="Export records to Excel"
                CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                    <i class="fas fa-download"></i> Export
            </asp:LinkButton>


        </span>
    </div>

    <div class="collapse pasconcept-bar" id="collapseFilter">
        Status:&nbsp;
        <telerik:RadComboBox ID="cboStatus" runat="server" Width="350px" AppendDataBoundItems="true" AutoPostBack="true">
            <Items>
                <telerik:RadComboBoxItem runat="server" Text="Active" Value="0" Selected="true" />
                <telerik:RadComboBoxItem runat="server" Text="Inactive" Value="1" />
                <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" />
            </Items>
        </telerik:RadComboBox>
    </div>

    <div class="pasconcept-subbar">
        <telerik:RadComboBox ID="cboSourceRole" runat="server" AppendDataBoundItems="true"
            Width="350px" DataSourceID="SqlDataSourceRoles" DataTextField="Name" DataValueField="Id" Height="300px" Font-Size="Small">
            <Items>
                <telerik:RadComboBoxItem runat="server" Text="(Bulk Apply Role...)" Value="-1" />
            </Items>
        </telerik:RadComboBox>
        <asp:LinkButton ID="btnApply" runat="server"
            CssClass="btn btn-primary btn-sm" UseSubmitBehavior="false">
                                     Apply Role to Selected Employees
        </asp:LinkButton>
        &nbsp;&nbsp;&nbsp;&nbsp;
            <telerik:RadTextBox ID="txtIPv4" runat="server" Width="300px"
                MaxLength="80" EmptyMessage="Bulk IPv4 addresses separated by a comma" ToolTip="IP v4 to Apply Selected Role" Font-Size="Small">
            </telerik:RadTextBox>
        <asp:LinkButton ID="btnApplyIPv4toRole" runat="server"
            CssClass="btn btn-primary  btn-sm" UseSubmitBehavior="false">
                                         Apply IP to Selected Role
        </asp:LinkButton>


    </div>


    <div class="row" style="padding-top: 5px">
        <div class="col-md-12">
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
                Width="100%" AutoGenerateColumns="False" AllowPaging="True" PageSize="100" AllowSorting="True" GroupPanelPosition="Top"
                HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                <ClientSettings EnableRowHoverStyle="true">
                    <ClientEvents OnGridCreated="isRowSelected" OnRowSelected="isRowSelected" OnRowDeselected="isRowSelected"></ClientEvents>
                    <Selecting AllowRowSelect="True"></Selecting>
                </ClientSettings>
                <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="Id" ClientDataKeyNames="Id">
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
                                                <i class="fas fa-cog"></i>
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
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center">
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
        <div class="container">
            <div style="height: 1px; overflow: auto">
                <asp:Panel ID="ExportPanel" runat="server" Height="1px">
                    <telerik:RadGrid ID="RadGridToPrint" runat="server" DataSourceID="SqlDataSource1" Width="100%" Culture="en-US">
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" AutoGenerateColumns="False">
                            <Columns>
                                <telerik:GridBoundColumn DataField="Id" HeaderText="Id" SortExpression="Id" UniqueName="Id" DataType="System.Int32" ReadOnly="True">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name" ReadOnly="True">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Role" FilterControlAltText="Filter Role column" HeaderText="Role" SortExpression="Role" UniqueName="Role" ReadOnly="True">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="URLFirewall" FilterControlAltText="Filter URLFirewall column" HeaderText="URLFirewall" SortExpression="URLFirewall" UniqueName="URLFirewall" ReadOnly="True">
                                </telerik:GridBoundColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_JobsList" FilterControlAltText="Filter Deny_JobsList column" HeaderText="Deny_JobsList" SortExpression="Deny_JobsList" UniqueName="Deny_JobsList">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_NewJob" FilterControlAltText="Filter Deny_NewJob column" HeaderText="Deny_NewJob" SortExpression="Deny_NewJob" UniqueName="Deny_NewJob">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_JobCodes" FilterControlAltText="Filter Deny_JobCodes column" HeaderText="Deny_JobCodes" SortExpression="Deny_JobCodes" UniqueName="Deny_JobCodes">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_TransmittalList" FilterControlAltText="Filter Deny_TransmittalList column" HeaderText="Deny_TransmittalList" SortExpression="Deny_TransmittalList" UniqueName="Deny_TransmittalList">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_TransmittalPackageTypes" FilterControlAltText="Filter Deny_TransmittalPackageTypes column" HeaderText="Deny_TransmittalPackageTypes" SortExpression="Deny_TransmittalPackageTypes" UniqueName="Deny_TransmittalPackageTypes">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_ProjectClasification" FilterControlAltText="Filter Deny_ProjectClasification column" HeaderText="Deny_ProjectClasification" SortExpression="Deny_ProjectClasification" UniqueName="Deny_ProjectClasification">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_ProposalsList" FilterControlAltText="Filter Deny_ProposalsList column" HeaderText="Deny_ProposalsList" SortExpression="Deny_ProposalsList" UniqueName="Deny_ProposalsList">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_NewProposal" FilterControlAltText="Filter Deny_NewProposal column" HeaderText="Deny_NewProposal" SortExpression="Deny_NewProposal" UniqueName="Deny_NewProposal">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_ProposalTasksList" FilterControlAltText="Filter Deny_ProposalTasksList column" HeaderText="Deny_ProposalTasksList" SortExpression="Deny_ProposalTasksList" UniqueName="Deny_ProposalTasksList">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_ProposalTemplates" FilterControlAltText="Filter Deny_ProposalTemplates column" HeaderText="Deny_ProposalTemplates" SortExpression="Deny_ProposalTemplates" UniqueName="Deny_ProposalTemplates">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_ProposalTermsConditions" FilterControlAltText="Filter Deny_ProposalTermsConditions column" HeaderText="Deny_ProposalTermsConditions" SortExpression="Deny_ProposalTermsConditions" UniqueName="Deny_ProposalTermsConditions">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_UseClassification" FilterControlAltText="Filter Deny_UseClassification column" HeaderText="Deny_UseClassification" SortExpression="Deny_UseClassification" UniqueName="Deny_UseClassification">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_InvoicesList" FilterControlAltText="Filter Deny_InvoicesList column" HeaderText="Deny_InvoicesList" SortExpression="Deny_InvoicesList" UniqueName="Deny_InvoicesList">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_StatementList" FilterControlAltText="Filter Deny_StatementList column" HeaderText="Deny_StatementList" SortExpression="Deny_StatementList" UniqueName="Deny_StatementList">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_BillingSchedules" FilterControlAltText="Filter Deny_BillingSchedules column" HeaderText="Deny_BillingSchedules" SortExpression="Deny_BillingSchedules" UniqueName="Deny_BillingSchedules">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_BillingManager" FilterControlAltText="Filter Deny_BillingManager column" HeaderText="Deny_BillingManager" ReadOnly="True" SortExpression="Deny_BillingManager" UniqueName="Deny_BillingManager">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_ClientAccountsReport" FilterControlAltText="Filter Deny_ClientAccountsReport column" HeaderText="Deny_ClientAccountsReport" SortExpression="Deny_ClientAccountsReport" UniqueName="Deny_ClientAccountsReport">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_ClientsList" FilterControlAltText="Filter Deny_ClientsList column" HeaderText="Deny_ClientsList" SortExpression="Deny_ClientsList" UniqueName="Deny_ClientsList">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_NewClient" FilterControlAltText="Filter Deny_NewClient column" HeaderText="Deny_NewClient" SortExpression="Deny_NewClient" UniqueName="Deny_NewClient">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_ClientType" FilterControlAltText="Filter Deny_ClientType column" HeaderText="Deny_ClientType" SortExpression="Deny_ClientType" UniqueName="Deny_ClientType">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_ClientManagement" FilterControlAltText="Filter Deny_ClientManagement column" HeaderText="Deny_ClientManagement" SortExpression="Deny_ClientManagement" UniqueName="Deny_ClientManagement">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_RequestsProposalsList" FilterControlAltText="Filter Deny_RequestsProposalsList column" HeaderText="Deny_RequestsProposalsList" SortExpression="Deny_RequestsProposalsList" UniqueName="Deny_RequestsProposalsList">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_NewRequestProposals" FilterControlAltText="Filter Deny_NewRequestProposals column" HeaderText="Deny_NewRequestProposals" SortExpression="Deny_NewRequestProposals" UniqueName="Deny_NewRequestProposals">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_SubconsultantsList" FilterControlAltText="Filter Deny_SubconsultantsList column" HeaderText="Deny_SubconsultantsList" SortExpression="Deny_SubconsultantsList" UniqueName="Deny_SubconsultantsList">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_NewSubconsultant" FilterControlAltText="Filter Deny_NewSubconsultant column" HeaderText="Deny_NewSubconsultant" SortExpression="Deny_NewSubconsultant" UniqueName="Deny_NewSubconsultant">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_DisciplinesList" FilterControlAltText="Filter Deny_DisciplinesList column" HeaderText="Deny_DisciplinesList" SortExpression="Deny_DisciplinesList" UniqueName="Deny_DisciplinesList">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_EmployeesList" FilterControlAltText="Filter Deny_EmployeesList column" HeaderText="Deny_EmployeesList" SortExpression="Deny_EmployeesList" UniqueName="Deny_EmployeesList">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_NewEmployee" FilterControlAltText="Filter Deny_NewEmployee column" HeaderText="Deny_NewEmployee" SortExpression="Deny_NewEmployee" UniqueName="Deny_NewEmployee">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_ProjectTimeEntries" FilterControlAltText="Filter Deny_ProjectTimeEntries column" HeaderText="Deny_ProjectTimeEntries" SortExpression="Deny_ProjectTimeEntries" UniqueName="Deny_ProjectTimeEntries">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_PayrollCalendar" FilterControlAltText="Filter Deny_PayrollCalendar column" HeaderText="Deny_PayrollCalendar" SortExpression="Deny_PayrollCalendar" UniqueName="Deny_PayrollCalendar">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_Timesheet" FilterControlAltText="Filter Deny_Timesheet column" HeaderText="Deny_Timesheet" SortExpression="Deny_Timesheet" UniqueName="Deny_Timesheet">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_EmployeesEfficiencyGraphic" FilterControlAltText="Filter Deny_EmployeesEfficiencyGraphic column" HeaderText="Deny_EmployeesEfficiencyGraphic" SortExpression="Deny_EmployeesEfficiencyGraphic" UniqueName="Deny_EmployeesEfficiencyGraphic">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_TimesheetReport" FilterControlAltText="Filter Deny_TimesheetReport column" HeaderText="Deny_TimesheetReport" SortExpression="Deny_TimesheetReport" UniqueName="Deny_TimesheetReport">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_Analytics" FilterControlAltText="Filter Deny_Analytics column" HeaderText="Deny_Analytics" SortExpression="Deny_Analytics" UniqueName="Deny_Analytics">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_DepartmentsList" FilterControlAltText="Filter Deny_DepartmentsList column" HeaderText="Deny_DepartmentsList" SortExpression="Deny_DepartmentsList" UniqueName="Deny_DepartmentsList">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_MonthlyBudget" FilterControlAltText="Filter Deny_MonthlyBudget column" HeaderText="Deny_MonthlyBudget" SortExpression="Deny_MonthlyBudget" UniqueName="Deny_MonthlyBudget">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_OrganizationChart" FilterControlAltText="Filter Deny_OrganizationChart column" HeaderText="Deny_OrganizationChart" SortExpression="Deny_OrganizationChart" UniqueName="Deny_OrganizationChart">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_DepartmentBalance" FilterControlAltText="Filter Deny_DepartmentBalance column" HeaderText="Deny_DepartmentBalance" SortExpression="Deny_DepartmentBalance" UniqueName="Deny_DepartmentBalance">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_DepartmentChart" FilterControlAltText="Filter Deny_DepartmentChart column" HeaderText="Deny_DepartmentChart" SortExpression="Deny_DepartmentChart" UniqueName="Deny_DepartmentChart">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_CompanyProfile" FilterControlAltText="Filter Deny_CompanyProfile column" HeaderText="Deny_CompanyProfile" SortExpression="Deny_CompanyProfile" UniqueName="Deny_CompanyProfile">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_PASconceptUsers" FilterControlAltText="Filter Deny_PASconceptUsers column" HeaderText="Deny_PASconceptUsers" SortExpression="Deny_PASconceptUsers" UniqueName="Deny_PASconceptUsers">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_HistoryLog" FilterControlAltText="Filter Deny_HistoryLog column" HeaderText="Deny_HistoryLog" SortExpression="Deny_HistoryLog" UniqueName="Deny_HistoryLog">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_TimeCategory" FilterControlAltText="Filter Deny_TimeCategory column" HeaderText="Deny_TimeCategory" SortExpression="Deny_TimeCategory" UniqueName="Deny_TimeCategory">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_MiscellaneousTimeCodes" HeaderText="Deny_MiscellaneousTimeCodes" SortExpression="Deny_MiscellaneousTimeCodes" UniqueName="Deny_MiscellaneousTimeCodes">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_MessagesTemplates" HeaderText="Deny_MessagesTemplates" SortExpression="Deny_MessagesTemplates" UniqueName="Deny_MessagesTemplates">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Deny_Importdata" HeaderText="Deny_Importdata" SortExpression="Deny_Importdata" UniqueName="Deny_Importdata">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Allow_EmployeesPermissions" HeaderText="Allow_EmployeesPermissions" SortExpression="Allow_EmployeesPermissions" UniqueName="Allow_EmployeesPermissions">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Allow_EditAcceptedProposal" HeaderText="Allow_EditAcceptedProposal" SortExpression="Allow_EditAcceptedProposal" UniqueName="Allow_EditAcceptedProposal">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Allow_InactivateJob" HeaderText="Allow_InactivateJob" SortExpression="Allow_InactivateJob" UniqueName="Allow_InactivateJob">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Allow_OtherEmployeeJobs" HeaderText="Allow_OtherEmployeeJobs" SortExpression="Allow_OtherEmployeeJobs" UniqueName="Allow_OtherEmployeeJobs">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Allow_DepartmentReport" HeaderText="Allow_DepartmentReport" SortExpression="Allow_DepartmentReport" UniqueName="Allow_DepartmentReport">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridCheckBoxColumn DataField="Allow_BadDebt" HeaderText="Allow_BadDebt" SortExpression="Allow_BadDebt" UniqueName="Allow_BadDebt">
                                </telerik:GridCheckBoxColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </asp:Panel>
            </div>
        </div>
    </div>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
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
            <asp:ControlParameter ControlID="txtIPv4" DefaultValue="" Name="IPv4" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboSourceRole" Name="Role" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblRoleId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedEmpl" runat="server" Visible="False"></asp:Label>
</asp:Content>
