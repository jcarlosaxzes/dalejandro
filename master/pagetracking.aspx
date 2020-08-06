<%@ Page Title="Page Tracking" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="pagetracking.aspx.vb" Inherits="pasconcept20.pagetracking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td colspan="2">
                <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                    <table class="table-sm pasconcept-bar" style="width: 100%">
                        <tr>
                            <td style="width: 150px; text-align: right">Time Frame:
                            </td>
                            <td style="width: 400px">
                                <telerik:RadComboBox ID="cboTimeFrame" runat="server" AppendDataBoundItems="true" Width="100%">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="All Years" Value="1" />
                                        <telerik:RadComboBoxItem runat="server" Text="Last Year" Value="2" />
                                        <telerik:RadComboBoxItem runat="server" Text="This Year" Value="3" />
                                        <telerik:RadComboBoxItem runat="server" Text="Last Quarter" Value="4" />
                                        <telerik:RadComboBoxItem runat="server" Text="This Quarter" Value="5" />
                                        <telerik:RadComboBoxItem runat="server" Text="Last Month" Value="6" />
                                        <telerik:RadComboBoxItem runat="server" Text="This Month" Value="7" />
                                        <telerik:RadComboBoxItem runat="server" Text="Last 30 Days" Value="8" />
                                        <telerik:RadComboBoxItem runat="server" Text="Last 15 Days" Value="9" />
                                        <telerik:RadComboBoxItem runat="server" Text="Last 7 Days" Value="10" Selected="true" />
                                        <telerik:RadComboBoxItem runat="server" Text="Last  Day" Value="11" />
                                        <telerik:RadComboBoxItem runat="server" Text="ToDay" Value="12" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td style="width: 150px; text-align: right">Company:
                            </td>
                            <td style="width: 400px">
                                <telerik:RadComboBox ID="cboCompany" runat="server" DataSourceID="SqlDataSourceCompany"  MarkFirstMatch="True" Filter="Contains"
                                    DataTextField="Name" DataValueField="companyId" Width="400px" AppendDataBoundItems="True" Height="300px">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All companies...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td style="text-align: right">
                                <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td style="width: 50%"></td>
            <td></td>
        </tr>
        <tr>
            <td style="vertical-align: top">
                <telerik:RadGrid ID="RadGridCompanyPageTracking" runat="server" DataSourceID="SqlDataSourceCompanyPageTracking" GridLines="None" Width="100%" AutoGenerateColumns="False" CellSpacing="0" AllowSorting="True"
                    AllowPaging="True" PageSize="50" ShowHeader="true" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center">
                    <MasterTableView DataSourceID="SqlDataSourceCompanyPageTracking">
                        <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                        <Columns>
                            <telerik:GridBoundColumn DataField="Company" HeaderText="Company" SortExpression="Company" UniqueName="Company">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Visited" HeaderText="Visit" SortExpression="Visited" UniqueName="Visited" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Center"
                                DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
            <td style="vertical-align: top">
                <telerik:RadGrid ID="RadGridPageTracking" runat="server" DataSourceID="SqlDataSourcePageTracking" GridLines="None" Width="100%" AutoGenerateColumns="False" CellSpacing="0" AllowSorting="True"
                    AllowPaging="True" PageSize="50" ShowHeader="true" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center">
                    <MasterTableView DataSourceID="SqlDataSourcePageTracking">
                        <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                        <Columns>
                            <telerik:GridBoundColumn DataField="Page" HeaderText="Page" SortExpression="Page" UniqueName="Page">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Visited" HeaderText="Visit" SortExpression="Visited" UniqueName="Visited" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Center"
                                DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSourcePageTracking" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="sys_PageTracking_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboTimeFrame" Name="TimeFrameId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboCompany" Name="companyId" PropertyName="SelectedValue" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCompanyPageTracking" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="sys_CompanyPageTracking_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboTimeFrame" Name="TimeFrameId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboCompany" Name="companyId" PropertyName="SelectedValue" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCompany" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT companyId, Name FROM Company ORDER BY Company.companyId"></asp:SqlDataSource>
</asp:Content>
