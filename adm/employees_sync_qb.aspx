<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="employees_sync_qb.aspx.vb" Inherits="pasconcept20.employees_sync_qb" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">QuickBooks Customer Import Manager
        </span>
        <asp:Panel ID="ConnectPanel" runat="server">
        <span style="float: right; vertical-align: middle;">
            <asp:LinkButton ID="btnDisconnectFromQuickBooks" runat="server" CssClass="btn btn-danger btn" UseSubmitBehavior="false">
                    Disconnect from QuickBooks
            </asp:LinkButton>
            <asp:LinkButton ID="btnConnectToQuickBooks" runat="server" CssClass="btn" UseSubmitBehavior="false">
                <img src="../Images/C2QB_green_btn_lg_default.png" height="40" />
            </asp:LinkButton>
            <asp:Button ID="btnGetVendors" runat="server" Text="Get Vendors from QuickBooks Online " CssClass="btn btn-success" />
        </span>
        </asp:Panel>
    </div>
    <asp:Panel ID="SyncPanelVendors" runat="server">
        <div class="pasconcept-bar">
            <span class="pasconcept-pagetitle">Unlinked QuickBooks Vendors
            </span>
            <span style="float: right; vertical-align: middle;">
                <asp:LinkButton ID="btnBulkLinkVendors" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Link all selected QuickBook Vendors to PASconcept">
                    Bulk Link
                </asp:LinkButton>
                <asp:LinkButton ID="btnBulkCopyVendors" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Copy all selected QuickBook Vendors to PASconcept">
                    Bulk Copy
                </asp:LinkButton>
            </span>
        </div>
        <telerik:RadGrid ID="RadGridVendors" runat="server" Width="100%" DataSourceID="SqlDataSourceVendorsPending"
            PageSize="50" AllowPaging="true" Height="580px" RenderMode="Lightweight" BorderStyle="None"
            AllowMultiRowSelection="True" AllowAutomaticDeletes="true"
            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
            FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
            <ClientSettings Selecting-AllowRowSelect="true">
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="DisplayName" DataSourceID="SqlDataSourceVendorsPending">
                <ColumnGroups>
                    <telerik:GridColumnGroup HeaderText="QuickBooks Vendors" Name="QuickBooksVendors" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Larger" HeaderStyle-ForeColor="DarkGreen" />
                    <telerik:GridColumnGroup HeaderText="PASconcept Suggested Vendors" Name="Vendors" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="24px" HeaderStyle-ForeColor="DarkBlue" />
                    <telerik:GridColumnGroup HeaderText="Options" Name="Actions" HeaderStyle-HorizontalAlign="Center" />
                </ColumnGroups>
                <Columns>

                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="VendorsSelectColumn">
                    </telerik:GridClientSelectColumn>

                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" HeaderStyle-Width="10px" UniqueName="Id" Display="false"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="QBId" HeaderText="QBId" HeaderStyle-Width="10px" UniqueName="QBId" Display="false"></telerik:GridBoundColumn>


                    <telerik:GridBoundColumn DataField="DisplayName"
                        FilterControlAltText="Filter DisplayName column" HeaderText="Vendors Name"
                        SortExpression="DisplayName" UniqueName="DisplayName" ColumnGroupName="QuickBooksVendors">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PrimaryEmailAddr"
                        FilterControlAltText="Filter Email column" HeaderText="Email"
                        SortExpression="Email" UniqueName="Email" ColumnGroupName="QuickBooksVendors">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CompanyName"
                        FilterControlAltText="Filter Company column" HeaderText="Company"
                        SortExpression="CompanyName" UniqueName="Company" ColumnGroupName="QuickBooksVendors">
                    </telerik:GridBoundColumn>


                    <telerik:GridTemplateColumn HeaderText="" UniqueName="Actions" ColumnGroupName="Actions" HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                ToolTip="Link to PASconcept Client" Visible='<%# IIf(TypeOf Eval("Name") Is DBNull, "False", "True") %>' CommandName="Link" CommandArgument='<%# String.Concat(Eval("QBId"), ",", Eval("Id")) %>'>
                                <i class="fas fa-link" aria-hidden="true" ></i>
                            </asp:LinkButton>
                            &nbsp;
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                ToolTip="Search client in PASconcept" CommandName="Search" CommandArgument='<%# Eval("QBId")%>'>
                                <i class="fas fa-search" aria-hidden="true" ></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="Company"
                        FilterControlAltText="Company" HeaderText="Vendor Company"
                        SortExpression="Company" UniqueName="Company" ColumnGroupName="Vendors">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Name"
                        FilterControlAltText="Name" HeaderText="Vendor Name"
                        SortExpression="Name" UniqueName="Name" ColumnGroupName="Vendors">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>

        <br />
        <h4>Linked PASconcept Vendors</h4>
        <telerik:RadGrid ID="RadGridLinkedVendors" runat="server" Width="100%" DataSourceID="SqlDataSourceQBLinkedVendors"
            PageSize="50" AllowPaging="true" Height="600px" RenderMode="Lightweight" BorderStyle="None"
            AllowMultiRowSelection="True" AllowAutomaticDeletes="true"
            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
            FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
            <ClientSettings Selecting-AllowRowSelect="true">
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceQBLinkedVendors">

                <Columns>
                    <telerik:GridBoundColumn DataField="Name"
                        FilterControlAltText="Filter Name column" HeaderText="Name"
                        SortExpression="Name" UniqueName="Name">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Company"
                        FilterControlAltText="Filter Company column" HeaderText="Company"
                        SortExpression="Company" UniqueName="Company">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Email"
                        FilterControlAltText="Filter Email column" HeaderText="Email"
                        SortExpression="Email" UniqueName="Email">
                    </telerik:GridBoundColumn>


                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                ToolTip="Unlink from Quickbooks" CommandName="UnLink" CommandArgument='<%# Eval("Id")%>'>
                                <i class="fas fa-unlink" aria-hidden="true"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>

        <telerik:RadToolTip ID="RadToolTipSearchVendors" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

            <table style="width: 400px">
                <tr>
                    <td colspan="2">
                        <h3 style="margin: 0; text-align: center; color: white;">
                            <span class="navbar navbar-expand-md bg-dark text-white">Match Vendors</span>
                        </h3>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlFindVendors" runat="server" DefaultButton="btnFindVendors">
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td>
                                        <telerik:RadTextBox ID="txtFindVendors" runat="server" x-webkit-speech="x-webkit-speech" Width="100%"
                                            EmptyMessage="Search for Name, Email, Phone">
                                        </telerik:RadTextBox>
                                    </td>
                                    <td style="width: 150px; text-align: right">
                                        <asp:LinkButton ID="btnFindVendors" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                                <i class="fas fa-search"></i> Search
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td style="width: 400px; height: 400px">

                        <div style="overflow: auto; width: 100%; height: 100%">
                            <telerik:RadGrid ID="RadGridSearhcVendors" runat="server" AllowPaging="False" Width="100%" DataSourceID="SqlDataSourceQBNotLinkedVendors">
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceQBNotLinkedVendors">

                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Clients" UniqueName="Clients" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="60px">
                                            <ItemTemplate>
                                                <h5><%# Eval("Name")%></h5>
                                                <span><%# Eval("Email")%></span>
                                                <br />
                                                <span><%# Eval("Phone")%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                    ToolTip="Link to PASconcept Client" CommandName="Link" CommandArgument='<%# Eval("Id")%>'>
                                                    <i class="fas fa-link" aria-hidden="true"></i>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </td>

                </tr>
            </table>
        </telerik:RadToolTip>


    </asp:Panel>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <asp:SqlDataSource ID="SqlDataSourceVendorsPending" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Vendors_Sync_QBO_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceQBLinkedVendors" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Vendeors_linked_QBO_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceQBNotLinkedVendors" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Vendors_Not_linked_QBO_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFindVendors" Name="Filter" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectVendors" runat="server" Visible="False"></asp:Label>
</asp:Content>

