﻿<%@ Page Title="Project Schedule" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="projectschedule.aspx.vb" Inherits="pasconcept20.projectschedule" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table class="pasconcept-bar noprint" style="width: 100%">
        <tr>
            <td>Range:
                <telerik:RadComboBox ID="cboPeriod" runat="server" Width="200px" AppendDataBoundItems="True" MarkFirstMatch="True">
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
                &nbsp;From:
                                <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="130px" Culture="en-US">
                                </telerik:RadDatePicker>
                &nbsp;To
                                <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="130px" Culture="en-US">
                                </telerik:RadDatePicker>
                &nbsp;Parent Mode View:
                    <telerik:RadComboBox ID="cboParentMode" runat="server" Width="200px" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="Proposal" Value="Proposal"  />
                            <telerik:RadComboBoxItem runat="server" Text="Job" Value="Job" Selected="true" />
                            <telerik:RadComboBoxItem runat="server" Text="Client" Value="Client"  />
                            <telerik:RadComboBoxItem runat="server" Text="Department" Value="Department"  />
                            <telerik:RadComboBoxItem runat="server" Text="Employee" Value="Employee"  />
                            <telerik:RadComboBoxItem runat="server" Text="Subconsultant" Value="Subconsultant"  />
                        </Items>
                    </telerik:RadComboBox>
                
                &nbsp;Client:
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
            <td>Department:
                <telerik:RadComboBox ID="cboDepartment" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" DropDownAutoWidth="Enabled"
                    Width="300px" CheckBoxes="true" Height="250px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains">
                    <Localization AllItemsCheckedString="(All Departments...)" CheckAllString="Check All..." ItemsCheckedString="items checked"></Localization>
                </telerik:RadComboBox>
                &nbsp;Employee:
                                <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmployee"
                                    Width="300px" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="250px"
                                    AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" Selected="true" />
                                    </Items>
                                </telerik:RadComboBox>
                &nbsp;Slot Width:
                                <telerik:RadComboBox ID="cboSlotWidth" runat="server" Width="100px" AppendDataBoundItems="true" ToolTip="Slot Width (px)">
                                    <Items>
                                        <telerik:RadComboBoxItem Value="15px" Text="15" />
                                        <telerik:RadComboBoxItem Value="25px" Text="25" Selected="true" />
                                        <telerik:RadComboBoxItem Value="50px" Text="50"  />
                                        <telerik:RadComboBoxItem Value="65px" Text="65" />
                                        <telerik:RadComboBoxItem Value="85px" Text="85" />
                                        <telerik:RadComboBoxItem Value="100px" Text="100" />
                                    </Items>
                                </telerik:RadComboBox>

            </td>
            <td style="text-align: right; width: 120px">
                <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Search
                </asp:LinkButton>
            </td>
        </tr>


    </table>

    <div class="pasconcept-bar" style="text-align: center">
        <h3 style="margin: 0">Projects Schedule
        </h3>
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
                <telerik:GanttBoundColumn DataField="Title" DataType="String" HeaderText="Title" ></telerik:GanttBoundColumn>
            </Columns>
            <DataBindings>
                <TasksDataBindings
                    IdField="ID"
                    TitleField="Title"
                    StartField="StartDay"
                    EndField="EndDay"
                    ParentIdField="ParentID"
                    SummaryField="Summary" 
                    PercentCompleteField="PercentComplete"/>
            </DataBindings>
        </telerik:RadGantt>
                    <%--PercentCompleteField="PercentComplete" ExpandedField="Expanded"  />--%>
    </div>


    <asp:SqlDataSource ID="SqlDataSourceGrantt" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Grantt_v20_SELECT" SelectCommandType="StoredProcedure">
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
