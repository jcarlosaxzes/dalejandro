<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="client_sync_qb.aspx.vb" Inherits="pasconcept20.client_sync_qb" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <br />
    <asp:Button ID="btnConnect" runat="server" Text="Connect to QuickBook" OnClick="btnConnect_Click" />&nbsp;&nbsp; 
    <asp:Label ID="lblResutl" runat="server" Text=""></asp:Label>
    <br />


    <asp:Panel ID="SyncPanel" runat="server">

        <br />
        <asp:Button ID="btnGetCustomers" runat="server" Text="Reload QuicBooks Customers" OnClick="btnGetCustomers_Click" />&nbsp;&nbsp; 
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
        <br />

        <br />
        <br />
        <h3>QuickBooks Customers</h3>
        <br />

        <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" Width="100%" DataSourceID="SqlDataSourceClientPending">
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="DisplayName" DataSourceID="SqlDataSourceClientPending">
                <ColumnGroups>
                    <telerik:GridColumnGroup HeaderText="QuickBooks Customers" Name="QuickBooksCustomers" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50%" />
                    <telerik:GridColumnGroup HeaderText="PASconcept Suggest Clients" Name="Clients" HeaderStyle-HorizontalAlign="Center" />
                    <telerik:GridColumnGroup HeaderText="Acctions" Name="Acctions" HeaderStyle-HorizontalAlign="Center" />
                </ColumnGroups>
                <Columns>

                    <telerik:GridBoundColumn DataField="DisplayName"
                        FilterControlAltText="Filter DisplayName column" HeaderText="DisplayName"
                        SortExpression="DisplayName" UniqueName="DisplayName" ColumnGroupName="QuickBooksCustomers">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Email"
                        FilterControlAltText="Filter Email column" HeaderText="Email"
                        SortExpression="Email" UniqueName="Email" ColumnGroupName="QuickBooksCustomers">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CompanyName"
                        FilterControlAltText="Filter CompanyName column" HeaderText="CompanyName"
                        SortExpression="CompanyName" UniqueName="CompanyName" ColumnGroupName="QuickBooksCustomers">
                    </telerik:GridBoundColumn>


                    <telerik:GridTemplateColumn HeaderText="" UniqueName="Acctions" ColumnGroupName="Acctions" HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                ToolTip="Link to PASconcept Client" Visible='<%# IIf(TypeOf Eval("Name") Is DBNull, "False", "True") %>' CommandName="Link" CommandArgument='<%# String.Concat(Eval("QBId"), ",", Eval("Id")) %>'>
                                <i class="fas fa-link" aria-hidden="true" ></i>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCreate" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                ToolTip="Import Customers to PASconcept" Visible='<%# IIf(TypeOf Eval("Name") Is DBNull, "True", "False") %>' CommandName="CreateNew" CommandArgument='<%# Eval("QBId")%>'>
                                <i class="far fa-clone" aria-hidden="true" ></i>
                            </asp:LinkButton>
                            &nbsp;&nbsp;
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                ToolTip="Search client in PASconcept" CommandName="Search" CommandArgument='<%# Eval("QBId")%>'>
                                <i class="fas fa-search" aria-hidden="true" ></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="Name"
                        FilterControlAltText="Name column" HeaderText="Name"
                        SortExpression="Name" UniqueName="Name" ColumnGroupName="Clients">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="cEmail"
                        FilterControlAltText=" Email column" HeaderText="cEmail"
                        SortExpression="cEmail" UniqueName="cEmail" ColumnGroupName="Clients">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>

        <br />
        <h3>PASconcept Linked Clients</h3>
        <br />

        <telerik:RadGrid ID="RadGridLinked" runat="server" AllowPaging="True" Width="100%" DataSourceID="SqlDataSourceQBLinked">
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceQBLinked">

                <Columns>
                    <telerik:GridBoundColumn DataField="Name"
                        FilterControlAltText="Filter Name column" HeaderText="Name"
                        SortExpression="Name" UniqueName="Name">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Email"
                        FilterControlAltText="Filter Email column" HeaderText="Email"
                        SortExpression="Email" UniqueName="Email">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Company"
                        FilterControlAltText="Filter Company column" HeaderText="Company"
                        SortExpression="Company" UniqueName="Company">
                    </telerik:GridBoundColumn>


                    <telerik:GridTemplateColumn HeaderText="Acctions" UniqueName="Acctions" HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
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

        <telerik:RadToolTip ID="RadToolTipSearchClient" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

            <table style="width: 400px">
                <tr>
                    <td colspan="2">
                        <h3 style="margin: 0; text-align: center; color: white;">
                            <span class="navbar navbar-expand-md bg-dark text-white">Match Client Files</span>
                        </h3>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td>
                                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="100%"
                                            EmptyMessage="Search for Client Name, email, Company">
                                        </telerik:RadTextBox>
                                    </td>
                                    <td style="width: 150px; text-align: right"> 
                                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" OnClick="btnFind_Click">
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
                            <telerik:RadGrid ID="RadGridSearhcClient" runat="server" AllowPaging="False" Width="100%" DataSourceID="SqlDataSourceQBNotLinked">
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceQBNotLinked">

                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Clients" UniqueName="Acctions" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="60px">
                                            <ItemTemplate>
                                                <h5><%# Eval("Name")%></h5>
                                                <span><%# Eval("Email")%></span>
                                                <br />
                                                <span><%# Eval("Company")%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn HeaderText="Acctions" UniqueName="Acctions" HeaderStyle-HorizontalAlign="Center"
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
    <asp:SqlDataSource ID="SqlDataSourceClientPending" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_Sync_QBO_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceQBLinked" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_linked_QBO_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceQBNotLinked" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_Not_linked_QBO_SELECT" SelectCommandType="StoredProcedure" >
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFind" Name="Filter" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectCustomer" runat="server" Visible="False"></asp:Label>
</asp:Content>

