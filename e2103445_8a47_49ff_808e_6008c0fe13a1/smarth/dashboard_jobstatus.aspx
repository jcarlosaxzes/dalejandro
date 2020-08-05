<%@ Page Title="Job Status" Language="vb" AutoEventWireup="false" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/smarth/mastersmarth.Master" CodeBehind="dashboard_jobstatus.aspx.vb" Inherits="pasconcept20.dashboard_jobstatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        h1 {
            font-size: 50px;
            padding-top: 20px;
        }

        h2 {
            font-size: 24px;
        }

        .PanelGreen {
            font-size: 16px;
            color: black;
            font-weight: bold;
            background-color: rgb(145, 199, 148);
        }

        .PanelRed {
            font-size: 16px;
            color: black;
            font-weight: bold;
            background-color: rgb(214, 76, 76);
        }

        .PanelBlue {
            font-size: 16px;
            color: black;
            font-weight: bold;
            background-color: rgb(92, 194, 241);
        }

        .ComboLabel {
            font-size: 14px;
            color: darkblue;
            font-weight: bold;
        }
    </style>

    <div id="main-section-header" class="row">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="text-align: right;">
                    <telerik:RadComboBox ID="cboTimeFrame" runat="server" AppendDataBoundItems="true"
                        AutoPostBack="true" Label="Time Frame:" Width="95%" LabelCssClass="ComboLabel" Font-Size="12px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="All Years" Value="1" />
                            <telerik:RadComboBoxItem runat="server" Text="Last Year" Value="2" />
                            <telerik:RadComboBoxItem runat="server" Text="This Year" Value="3" Selected="true" />
                            <telerik:RadComboBoxItem runat="server" Text="Last Quarter" Value="4" />
                            <telerik:RadComboBoxItem runat="server" Text="This Quarter" Value="5" />
                            <telerik:RadComboBoxItem runat="server" Text="Last Month" Value="6" />
                            <telerik:RadComboBoxItem runat="server" Text="This Month" Value="7" />
                            <telerik:RadComboBoxItem runat="server" Text="Last 30 Days" Value="8" />
                            <telerik:RadComboBoxItem runat="server" Text="Last 15 Days" Value="9" />
                            <telerik:RadComboBoxItem runat="server" Text="Last 7 Days" Value="10" />
                            <telerik:RadComboBoxItem runat="server" Text="Last  Day" Value="11" />
                            <telerik:RadComboBoxItem runat="server" Text="ToDay" Value="12" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <telerik:RadComboBox ID="cboDepartment" runat="server" DataSourceID="SqlDataSourceDepartments" AutoPostBack="true"
                        Label="Department:" LabelCssClass="ComboLabel"
                        DataTextField="Name" DataValueField="Id" Width="95%" AppendDataBoundItems="true" Font-Size="12px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="0" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>

                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmpl_activos" AutoPostBack="true" MarkFirstMatch="True"
                        ToolTip="Select active Employye" Label="Employee:" LabelCssClass="ComboLabel" Font-Size="12px"
                        Width="91%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="200px" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="0" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>

                </td>
            </tr>
        </table>

        <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" Width="100%">
            <ItemTemplate>
                <div style="text-align: center; width: 100%">

                    <table class="table-bordered" style="width: 98%">
                        <tr>
                            <td></td>
                            <td colspan="3">
                                <h1 style="color: darkblue"><%# Eval("Number_All", "{0:N0}")%></h1>
                                <h2 style="color: darkblue"><%# Eval("Budget_All", "{0:C0}")%></h2>
                                <p class="text-success input-lg PanelBlue">All status</p>
                            </td>
                        </tr>

                        <tr>
                            <td></td>
                            <td style="width: 48%">
                                <h1 style="color: darkgreen"><%# Eval("Number_Active", "{0:N0}")%></h1>
                                <h2 style="color: darkgreen"><%# Eval("Budget_Active", "{0:C0}")%></h2>
                                <p class="text-success input-lg PanelGreen">Actives</p>
                            </td>
                            <td></td>
                            <td style="width: 48%">
                                <h1 style="color: darkred"><%# Eval("Number_InActive", "{0:N0}")%></h1>
                                <h2 style="color: darkred"><%# Eval("Budget_InActive", "{0:C0}")%></h2>
                                <p class="text-success input-lg PanelRed">Inactives</p>
                            </td>
                        </tr>

                        <tr>
                            <td></td>
                            <td style="width: 48%">
                                <h1 style="color: darkred"><%# Eval("Number_InProgress", "{0:N0}")%></h1>
                                <h2 style="color: darkred"><%# Eval("Budget_InProgress", "{0:C0}")%></h2>
                                <p class="text-success input-lg PanelRed">In Progress</p>
                            </td>
                            <td></td>
                            <td style="width: 48%">
                                <h1 style="color: darkgreen"><%# Eval("Number_NotInProgress", "{0:N0}")%></h1>
                                <h2 style="color: darkgreen"><%# Eval("Budget_NotInProgress", "{0:C0}")%></h2>
                                <p class="text-success input-lg PanelGreen">Not In Progress</p>
                            </td>
                        </tr>

                        <tr>
                            <td></td>
                            <td style="width: 48%">
                                <h1 style="color: darkred"><%# Eval("Number_Unassigned", "{0:N0}")%></h1>
                                <h2 style="color: darkred"><%# Eval("Budget_Unassigned", "{0:C0}")%></h2>
                                <p class="text-success input-lg PanelRed">Unassigned</p>
                            </td>
                            <td></td>
                            <td style="width: 48%">
                                <h1 style="color: darkred"><%# Eval("Number_PMnotAssigned", "{0:N0}")%></h1>
                                <h2 style="color: darkred"><%# Eval("Number_PMnotAssigned", "{0:C0}")%></h2>
                                <p class="text-success input-lg PanelRed">PM not Assigned</p>
                            </td>
                        </tr>

                        <tr>
                            <td></td>
                            <td style="width: 48%">
                                <h1 style="color: darkgreen"><%# Eval("Number_Done", "{0:N0}")%></h1>
                                <h2 style="color: darkgreen"><%# Eval("Budget_Done", "{0:C0}")%></h2>
                                <p class="text-success input-lg PanelGreen">Done</p>
                            </td>
                            <td></td>
                            <td style="width: 48%">
                                <h1 style="color: darkred"><%# Eval("Number_Submitted", "{0:N0}")%></h1>
                                <h2 style="color: darkred"><%# Eval("Budget_Submitted", "{0:C0}")%></h2>
                                <p class="text-success input-lg PanelRed">Submitted</p>
                            </td>
                        </tr>

                        <tr>
                            <td></td>
                            <td style="width: 48%">
                                <h1 style="color: darkgreen"><%# Eval("Number_Approved", "{0:N0}")%></h1>
                                <h2 style="color: darkgreen"><%# Eval("Budget_Approved", "{0:C0}")%></h2>
                                <p class="text-success input-lg PanelGreen">Approved</p>
                            </td>
                            <td></td>
                            <td style="width: 48%">
                                <h1 style="color: darkred"><%# Eval("Number_UnderRevision", "{0:N0}")%></h1>
                                <h2 style="color: darkred"><%# Eval("Budget_UnderRevision", "{0:C0}")%></h2>
                                <p class="text-success input-lg PanelRed">Under Revision</p>
                            </td>
                        </tr>

                        <tr>
                            <td></td>
                            <td colspan="3">
                                <h1 style="color: darkblue"><%# Eval("Number_OnHold", "{0:N0}")%></h1>
                                <h2 style="color: darkblue"><%# Eval("Budget_OnHold", "{0:C0}")%></h2>
                                <p class="text-success input-lg PanelBlue">On Hold</p>
                            </td>
                        </tr>
                    </table>
                </div>
            </ItemTemplate>
        </asp:FormView>



    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Dashboard1_JobsStatus" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboTimeFrame" Name="TimeFrameId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartment" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployee" Name="EmployeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpl_activos" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    `   
    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
</asp:Content>
