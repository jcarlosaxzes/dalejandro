<%@ Page Title="History Log" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="historylog.aspx.vb" Inherits="pasconcept20.historylog" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
        <Rows>
            <telerik:LayoutRow>
                <Content>
                    <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                        <table width="100%" class="Formulario">
                            <tr>
                                <td align="right" class="Normal" width="40px">Find:
                                </td>
                                <td align="center" width="410px">
                                    <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="400px">
                                    </telerik:RadTextBox>
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnFind" runat="server" Text="Search">
                                        <Icon PrimaryIconCssClass="rbSearch" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
                                    </telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </Content>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Content>
                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                        Width="100%" AutoGenerateColumns="False" CellSpacing="0" AllowSorting="True" AllowPaging="True" PageSize="100" Height="1200px">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                        </ClientSettings>
                        <MasterTableView DataSourceID="SqlDataSource1">
                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                            <Columns>
                                <telerik:GridBoundColumn DataField="Email" HeaderText="Email" SortExpression="Email"  ItemStyle-HorizontalAlign="Left"
                                    UniqueName="Email" HeaderStyle-HorizontalAlign="Center"
                                    FilterControlAltText="Filter Email column" HeaderStyle-Width="180px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sys_Actions" FilterControlAltText="Filter sys_Actions column"
                                    HeaderText="Actions" SortExpression="sys_Actions" UniqueName="sys_Actions"
                                    HeaderStyle-Width="160px" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="logDate" DataType="System.DateTime" FilterControlAltText="Filter logDate column"
                                    HeaderText="Date" SortExpression="logDate" UniqueName="logDate"
                                    HeaderStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Notes" FilterControlAltText="Filter Notes column"  ItemStyle-HorizontalAlign="Left"
                                    HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </Content>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>

    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="log_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter"
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
