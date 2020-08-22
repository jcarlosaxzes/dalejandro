<%@ Page Title="Gantt Chart for Projects" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="projectschedule.aspx.vb" Inherits="pasconcept20.projectschedule" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .gantt-container {
            padding: 0 2px 2px 0;
            height: 100%;
            width: 100%;
            box-sizing: border-box;
        }
    </style>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Gantt Chart for Projects</span>

        <span style="float: right; vertical-align: middle;">Gantt Chart Type:
                    <telerik:RadComboBox ID="cboParentMode" runat="server" Width="200px" AppendDataBoundItems="true" AutoPostBack="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="Proposals" Value="Proposal" />
                            <telerik:RadComboBoxItem runat="server" Text="Jobs" Value="Job" Selected="true" />
                            <telerik:RadComboBoxItem runat="server" Text="Billing" Value="Billing" />
                            <telerik:RadComboBoxItem runat="server" Text="Clients" Value="Client" />
                            <telerik:RadComboBoxItem runat="server" Text="Departments" Value="Department" />
                            <telerik:RadComboBoxItem runat="server" Text="Employees" Value="Employee" />
                            <telerik:RadComboBoxItem runat="server" Text="Subconsultants" Value="Subconsultant" />
                        </Items>
                    </telerik:RadComboBox>
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
        </span>
    </div>

    <div class="collapse" id="collapseFilter">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 200px">
                    <telerik:RadComboBox ID="cboPeriod" runat="server" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True">
                        <Items>
                            <telerik:RadComboBoxItem Text="Last 30 days" Value="30" Selected="true" />
                            <telerik:RadComboBoxItem Text="Last 60 days" Value="60" />
                            <telerik:RadComboBoxItem Text="Last 90 days" Value="90" />
                            <telerik:RadComboBoxItem Text="Last 120 days" Value="120" />
                            <telerik:RadComboBoxItem Text="Last 180 days" Value="180" />
                            <telerik:RadComboBoxItem Text="Last 365 days" Value="365" />
                            <telerik:RadComboBoxItem Text="(This year...)" Value="14" />
                            <telerik:RadComboBoxItem Text="(Last year...)" Value="15" />
                            <telerik:RadComboBoxItem Text="(All years...)" Value="13" />
                            <telerik:RadComboBoxItem Text="Custom Range..." Value="99" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="width: 350px;">
                    <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="130px" Culture="en-US">
                    </telerik:RadDatePicker>
                    &nbsp;To
                                <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="130px" Culture="en-US">
                                </telerik:RadDatePicker>
                    &nbsp;&nbsp;Slot Width:
                                <telerik:RadComboBox ID="cboSlotWidth" runat="server" Width="80px" AppendDataBoundItems="true" ToolTip="Slot Width (px)">
                                    <Items>
                                        <telerik:RadComboBoxItem Value="15px" Text="15" />
                                        <telerik:RadComboBoxItem Value="25px" Text="25" Selected="true" />
                                        <telerik:RadComboBoxItem Value="50px" Text="50" />
                                        <telerik:RadComboBoxItem Value="65px" Text="65" />
                                        <telerik:RadComboBoxItem Value="85px" Text="85" />
                                        <telerik:RadComboBoxItem Value="100px" Text="100" />
                                    </Items>
                                </telerik:RadComboBox>
                </td>
                <td style="width: 450px">
                    <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient"
                        Width="450px" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px"
                        AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <telerik:RadComboBox ID="cboDepartment" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" DropDownAutoWidth="Enabled"
                        Width="100%" CheckBoxes="true" Height="250px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains">
                        <Localization AllItemsCheckedString="(All Departments...)" CheckAllString="Check All..." ItemsCheckedString="items checked"></Localization>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmployee"
                        Width="300px" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="250px"
                        AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td></td>
                <td style="text-align: right; width: 150px">
                    <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                    </asp:LinkButton>
                </td>
            </tr>


        </table>
    </div>
    <div>
        <telerik:RadGantt ID="RadGantt1" runat="server" ReadOnly="true" Height="1000px" AutoGenerateColumns="false"
            SelectedView="MonthView" DayView-UserSelectable="false" Skin="Material"
            OnNavigationCommand="RadGantt1_NavigationCommand"
            ShowFullWeek="false"
            DataSourceID="SqlDataSourceGrantt"
            EnableResources="true"
            ShowCurrentTimeMarker="true"
            AllowColumnResize="true">
            <YearView UserSelectable="true" />
            <Columns>
                <telerik:GanttBoundColumn DataField="Title" DataType="String" HeaderText="Entity"></telerik:GanttBoundColumn>
            </Columns>
            <DataBindings>
                <TasksDataBindings
                    IdField="ID"
                    TitleField="Title"
                    StartField="StartDay"
                    EndField="EndDay"
                    ParentIdField="ParentID"
                    SummaryField="Summary"
                    PercentCompleteField="PercentComplete" />
            </DataBindings>
        </telerik:RadGantt>
        <%--PercentCompleteField="PercentComplete" ExpandedField="Expanded"  />--%>
    </div>


    <asp:SqlDataSource ID="SqlDataSourceGrantt" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Gantt_v20_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboClients" Name="Client" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployee" Name="Employee" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblDepartmentIN_List" Name="lblDepartmentIN_List" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboParentMode" Name="ParentMode" PropertyName="SelectedValue" />

        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_of_JobsList_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE (ISNULL(Inactive, 0) = 0) AND (companyId=@companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceResources" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name, 0 As Color FROM Employees WHERE (ISNULL(Inactive, 0) = 0) AND (companyId=@companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceResourcesAssignments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT 2000000+Id As ID, 1000000+Id as TaskID, Employee As ResourceID, dbo.JobProfit(Id,Budget)/100 as Units FROM Jobs WHERE companyId=@companyId and [Status]=2 and isnull(Employee,0)>0">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblDepartmentIN_List" runat="server" Visible="False" Text=""></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
