<%@ Page Title="Client Account Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="clientsbalance.aspx.vb" Inherits="pasconcept20.clientsbalance" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
    <div class="row">
        <div class="col-md-12">
            <table class="table-condensed" style="width: 100%">
                <tr>
                    <td style="width: 180px; text-align: right">Client Account Status:
                    </td>
                    <td style="width: 250px;">
                        <telerik:RadComboBox ID="cboFilter" Width="100%" runat="server" ToolTip="Filter by">
                            <Items>
                                <telerik:RadComboBoxItem Text="Pending Balance" Value="1" Selected="true" />
                                <telerik:RadComboBoxItem Text="Bad Debt" Value="2" />
                                <telerik:RadComboBoxItem Text="Pending Emmit" Value="3" />
                                <telerik:RadComboBoxItem Text="(All ...)" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 100px; text-align: right">Department:
                    </td>
                    <td style="Width:350px">
                        <telerik:RadComboBox ID="cboDepartment" runat="server" DataSourceID="SqlDataSourceDepartments"
                            DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-search"></span> Search
                        </asp:LinkButton>
                    </td>
                    <td style="text-align: right;padding-top:10px">
                        <asp:ImageButton ID="ExcelButton" ImageUrl="~/Images/Toolbar/Excel-icon.png" runat="server" ToolTip="Export List to Excel file format (.XSLS)" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                AllowSorting="True" AllowPaging="True" PageSize="50" Skin="Bootstrap"
                HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right"
                CellSpacing="0" AutoGenerateColumns="False" Height="700px">
                <ClientSettings>
                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                </ClientSettings>
                <MasterTableView DataKeyNames="ClientId" DataSourceID="SqlDataSource1" ShowFooter="True">
                    <PagerStyle Mode="Slider" AlwaysVisible="false" />
                    <Columns>

                        <telerik:GridBoundColumn DataField="ClientName" HeaderText="Client Name"
                            SortExpression="ClientName" UniqueName="ClientName" Aggregate="Count"
                            FooterAggregateFormatString="{0:N0}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Company" HeaderText="Company"
                            SortExpression="Company" UniqueName="Company">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Jobs" HeaderText="#Jobs"
                            SortExpression="Jobs" UniqueName="Jobs" DataFormatString="{0:N0}"
                            Aggregate="Sum" ItemStyle-HorizontalAlign="Right"
                            FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="80px">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="LastJobDate" HeaderText="Last Job"
                            SortExpression="LastJobDate" UniqueName="LastJobDate" DataFormatString="{0:d}"
                            HeaderStyle-Width="100px">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="JobBudget" HeaderText="Contract Amount"
                            SortExpression="JobBudget" UniqueName="JobBudget" DataFormatString="{0:N2}"
                            Aggregate="Sum" ItemStyle-HorizontalAlign="Right"
                            FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="100px">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="AmountEmitted" HeaderText="Emitted($)"
                            SortExpression="AmountEmitted" UniqueName="AmountEmitted" DataFormatString="{0:N2}"
                            Aggregate="Sum" ItemStyle-HorizontalAlign="Right"
                            FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="100px">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="AmountNotEmitted" HeaderText="Not Emitted($)"
                            SortExpression="AmountNotEmitted" UniqueName="AmountNotEmitted" DataFormatString="{0:N2}"
                            Aggregate="Sum" ItemStyle-HorizontalAlign="Right"
                            FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="100px">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="BadDebtTotal" HeaderText="BadDebt($)"
                            SortExpression="BadDebtTotal" UniqueName="BadDebtTotal" DataFormatString="{0:N2}"
                            Aggregate="Sum" ItemStyle-HorizontalAlign="Right"
                            FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="100px">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="AmountPaid" HeaderText="Paid($)"
                            SortExpression="AmountPaid" UniqueName="AmountPaid" DataFormatString="{0:N2}"
                            Aggregate="Sum" ItemStyle-HorizontalAlign="Right"
                            FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="100px">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Balance" HeaderText="Outstanding Fees"
                            SortExpression="Balance" UniqueName="Balance" DataFormatString="{0:N2}"
                            Aggregate="Sum" ItemStyle-HorizontalAlign="Right"
                            FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="100px">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_BALANCE3_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboFilter" Name="FilterId" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="cboDepartment" Name="departmentId" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

