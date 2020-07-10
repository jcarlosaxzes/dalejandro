<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="historylog.aspx.vb" Inherits="pasconcept20.historylog1" %>


<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td class="PanelFilter">
                <asp:Panel ID="pnlFind" runat="server" >
                    <table width="100%" class="pasconcept-bar">
                        <tr>
                            <td align="right" class="Normal" width="80px">Company:
                            </td>
                            <td align="left" width="410px">
                                <telerik:RadComboBox ID="cboCompany" runat="server" DataSourceID="SqlDataSourceCompany"
                                    DataTextField="Name" DataValueField="companyId" Width="400px"
                                    AutoPostBack="True" AppendDataBoundItems="True">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All companies...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td align="right" class="Normal">Find:
                            </td>
                            <td align="left" width="410px">
                                <telerik:RadComboBox ID="cboActions" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceActions" 
                                    DataTextField="Name" DataValueField="Id" Width="400px"
                                    AppendDataBoundItems="True">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All actions...)" Value="-1" />
                                    </Items>

                                </telerik:RadComboBox>
                            </td>
                            <td>
                                
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                    Width="100%" AutoGenerateColumns="False" CellSpacing="0" AllowSorting="True"
                    AllowPaging="True" PageSize="50" ShowHeader="true" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                    <ExportSettings  OpenInNewWindow="true" HideStructureColumns="true">
                        <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                            PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in" />
                    </ExportSettings>
                    <MasterTableView DataSourceID="SqlDataSource1" CommandItemDisplay="Top">
                        <CommandItemSettings  ShowAddNewRecordButton="false" ShowExportToExcelButton="true" />
                        <ExpandCollapseColumn Resizable="False" Visible="False">
                            <HeaderStyle Width="20px" />
                        </ExpandCollapseColumn>
                        <RowIndicatorColumn Visible="False">
                            <HeaderStyle Width="20px" />
                        </RowIndicatorColumn>
                        <PagerStyle Mode="NextPrevNumericAndAdvanced"  AlwaysVisible="true" />
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="ID" UniqueName="companyId" SortExpression="companyId"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" runat="server" CssClass="PequenaNegrita" NavigateUrl='<%# Eval("companyId", "~/MASTER/Company.aspx?companyId={0}") %>'
                                        Text='<%# Eval("companyId") %>'></asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="CompanyName" FilterControlAltText="Filter CompanyName column"
                                HeaderText="Company" SortExpression="CompanyName" UniqueName="CompanyName"
                                 HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Contact" FilterControlAltText="Filter Contact column"
                                HeaderText="Contact" SortExpression="Contact" UniqueName="Contact"
                                ItemStyle-Width="200px" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Last" DataType="System.DateTime" FilterControlAltText="Filter Last column" 
                                HeaderText="Last Time" ReadOnly="True" SortExpression="Last" UniqueName="Last"
                                ItemStyle-Width="150px" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Last24h" DataType="System.Int32" FilterControlAltText="Filter Last24h column" 
                                HeaderText="Last 24h" ReadOnly="True" SortExpression="Last24h" UniqueName="Last24h"
                                ItemStyle-Width="60px" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="LastWeek" DataType="System.Int32" FilterControlAltText="Filter LastWeek column" 
                                HeaderText="Last Week" ReadOnly="True" SortExpression="LastWeek" UniqueName="LastWeek"
                                ItemStyle-Width="60px" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="LastMonth" DataType="System.Int32" FilterControlAltText="Filter LastMonth column" 
                                HeaderText="Last Month" ReadOnly="True" SortExpression="LastMonth" UniqueName="LastMonth"
                                ItemStyle-Width="60px" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Total" DataType="System.Int32" FilterControlAltText="Filter Total column" 
                                HeaderText="Amount" ReadOnly="True" SortExpression="Total" UniqueName="Total"
                                ItemStyle-Width="60px" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="sys_Log_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboCompany" Name="companyId"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboActions" Name="AccionId"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCompany" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT companyId, Name FROM Company ORDER BY Company.companyId"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceActions" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [sys_Actions] ORDER BY [Id]"></asp:SqlDataSource>
</asp:Content>
