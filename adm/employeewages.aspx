<%@ Page Title="Employee Wages" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="employeewages.aspx.vb" Inherits="pasconcept20.employeewages" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/adm/ADM_Main_Responsive.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Employee Wages</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
           
            </button>
        </span>

    </div>


    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 200px">
                        <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYears"
                            DataTextField="nYear" DataValueField="Year" Width="100%">
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 350px">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" MarkFirstMatch="True"
                            Width="100%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(Select Department...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboEmployees" runat="server" DataSourceID="SqlDataSourceEmployees" MarkFirstMatch="True"
                            Width="350px" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>

                </tr>
            </table>
        </asp:Panel>

    </div>
    <div>
        <telerik:RadGrid ID="RadGridHourlyWage" runat="server" DataSourceID="SqlDataSourceHourlyWageGroup"
            AutoGenerateColumns="False" AllowSorting="True" ShowFooter="true" FooterStyle-HorizontalAlign="Center">
            <MasterTableView DataKeyNames="employeeId" DataSourceID="SqlDataSourceHourlyWageGroup" ShowFooter="true">
                <Columns>
                    <telerik:GridTemplateColumn HeaderText="Photo" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                        <ItemTemplate>
                            <asp:Image ID="ImageEmployeePhoto" ImageUrl='<%#LocalAPI.GetEmployeePhotoURL(employeeId:=Eval("employeeId"))%>' CssClass="photo50"
                                runat="server" AlternateText=""></asp:Image>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="employeeId" FilterControlAltText="Filter Employee column"
                        HeaderText="Employee" SortExpression="Employee" UniqueName="employeeId" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1"
                                runat="server" ToolTip="Click to View/Edit Employee Hourly Wage"
                                CommandArgument='<%# Eval("employeeId") %>'
                                CommandName="EditHourlyWage"
                                UseSubmitBehavior="false">
                                                                <i class="fas fa-user-edit"></i>&nbsp;
                            </asp:LinkButton>
                            <%# Eval("Employee")%>
                            <span style="font-size: x-small" class="badge badge-pill badge-danger" title="weeks this year"><%# Eval("weekthisyear", "{0:N1}") %></span>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Department" FilterControlAltText="Filter Department column" HeaderText="Department" HeaderStyle-HorizontalAlign="Center"
                        SortExpression="Department" UniqueName="Department" ReadOnly="true">
                        <ItemTemplate>
                            <%# Eval("Department") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridNumericColumn DataField="Producer" HeaderText="Producer Rate" HeaderStyle-HorizontalAlign="Center"
                        SortExpression="Producer" UniqueName="Producer" DataFormatString="{0:N2}" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center" Aggregate="Avg" FooterAggregateFormatString="{0:N2}" ReadOnly="true"
                        HeaderTooltip="Producer Rate 0 to 1">
                    </telerik:GridNumericColumn>
                    <telerik:GridTemplateColumn DataField="Amount" FilterControlAltText="Filter Amount column" HeaderText="Hourly Rate" HeaderStyle-HorizontalAlign="Center"
                        SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right"
                        HeaderTooltip="Hourly Wage Rate">
                        <ItemTemplate>
                            <span style='<%# IIf(Eval("NumberOfRecords") <= 1, "display:none;font-size:x-small", "display:normal;font-size:x-small")%>' class="badge badge-pill badge-success" title="Salary Modifications this Year">
                                <%# Eval("NumberOfRecords") - 1 %>
                            </span>
                            <%# Eval("Amount", "{0:C2}") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridNumericColumn DataField="AnnualSalary" HeaderText="Annual Salary" HeaderStyle-HorizontalAlign="Center"
                        SortExpression="AnnualSalary" UniqueName="AnnualSalary" DataFormatString="{0:C0}" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C0}" ReadOnly="true"
                        HeaderTooltip="Annual Salary Calculated">
                    </telerik:GridNumericColumn>
                    <telerik:GridTemplateColumn DataField="ProductiveSalary" HeaderText="Productive Salary" HeaderStyle-HorizontalAlign="Center"
                        SortExpression="ProductiveSalary" UniqueName="ProductiveSalary" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C0}" ReadOnly="true"
                        HeaderTooltip="Annual Salary - (Non-productive hours)*$/Hour">
                        <ItemTemplate>
                            <span style="font-size: x-small" class="badge badge-pill badge-danger" title="productive weeks this year">
                                <%# Eval("productiveweekthisyear", "{0:N1}") %>
                            </span>
                            <%# Eval("ProductiveSalary", "{0:C0}") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceHourlyWageGroup" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_HourlyWageHistory_Group_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployees" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYears" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Year, nYear FROM (select Year, nYear from Years union all select Year,Year as nYear from Company_MultiplierByYear where companyId=@companyId)T GROUP BY Year, nYear ORDER BY Year DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]=[FullName]+case when isnull(Inactive,0)=1 then ' (I)' else '' end FROM [Employees] WHERE companyId=@companyId and DepartmentId=case when @DepartmentId>0 then @DepartmentId else DepartmentId end ORDER BY isnull(Inactive,0), [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
