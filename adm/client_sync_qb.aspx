<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="client_sync_qb.aspx.vb" Inherits="pasconcept20.client_sync_qb" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">QuickBooks Import Manager
        </span>
        <asp:Panel ID="ConnectPanel" runat="server">
            <span style="float: right; vertical-align: middle;">
                <asp:LinkButton ID="btnDisconnectFromQuickBooks" runat="server" CssClass="btn btn-danger btn" UseSubmitBehavior="false">
                    Disconnect from QuickBooks
                </asp:LinkButton>
                <asp:LinkButton ID="btnConnectToQuickBooks" runat="server" CssClass="btn" UseSubmitBehavior="false">
                <img src="../Images/C2QB_green_btn_lg_default.png" height="40" />
                </asp:LinkButton>
            </span>
        </asp:Panel>
    </div>
    <div class="pas-container" style="width: 100%">
        <telerik:RadWizard ID="RadWizardFiles" runat="server" DisplayCancelButton="false" DisplayProgressBar="false" DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Silk">
            <WizardSteps>
                <%--Customers--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepClients" Title="Clients" StepType="Step">

                    <asp:Panel ID="SyncPanel" runat="server">
                        <div class="pasconcept-bar">
                            <span class="pasconcept-pagetitle">Unlinked QuickBooks Customers
                            </span>
                            <span style="float: right; vertical-align: middle;">
                                <asp:Button ID="btnGetCustomers" runat="server" Text="Get Customers from QuickBooks Online " CssClass="btn btn-success" OnClick="btnGetCustomers_Click" />

                                <asp:LinkButton ID="btnBulkLink" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Link all selected QuickBook Customers to PASconcept Clients">
                    Bulk Link
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnBulkCopy" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Copy all selected QuickBook Customers to PASconcept Clients">
                    Bulk Copy
                                </asp:LinkButton>
                            </span>
                        </div>
                        <telerik:RadGrid ID="RadGrid1" runat="server" Width="100%" DataSourceID="SqlDataSourceClientPending"
                            PageSize="50" AllowPaging="true" Height="580px" RenderMode="Lightweight" BorderStyle="None"
                            AllowMultiRowSelection="True" AllowAutomaticDeletes="true"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                            FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                            <ClientSettings Selecting-AllowRowSelect="true">
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="DisplayName" DataSourceID="SqlDataSourceClientPending">
                                <ColumnGroups>
                                    <telerik:GridColumnGroup HeaderText="QuickBooks Customers" Name="QuickBooksCustomers" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Larger" HeaderStyle-ForeColor="DarkGreen" />
                                    <telerik:GridColumnGroup HeaderText="PASconcept Suggested Clients" Name="Clients" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="24px" HeaderStyle-ForeColor="DarkBlue" />
                                    <telerik:GridColumnGroup HeaderText="Options" Name="Actions" HeaderStyle-HorizontalAlign="Center" />
                                </ColumnGroups>
                                <Columns>

                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="ClientSelectColumn">
                                    </telerik:GridClientSelectColumn>

                                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" HeaderStyle-Width="10px" UniqueName="Id" Display="false"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="QBId" HeaderText="QBId" HeaderStyle-Width="10px" UniqueName="QBId" Display="false"></telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="DisplayName"
                                        FilterControlAltText="Filter DisplayName column" HeaderText="Customer Name"
                                        SortExpression="DisplayName" UniqueName="DisplayName" ColumnGroupName="QuickBooksCustomers">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Email"
                                        FilterControlAltText="Filter Email column" HeaderText="Email"
                                        SortExpression="Email" UniqueName="Email" ColumnGroupName="QuickBooksCustomers">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CompanyName"
                                        FilterControlAltText="Filter CompanyName column" HeaderText="Company"
                                        SortExpression="CompanyName" UniqueName="CompanyName" ColumnGroupName="QuickBooksCustomers">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderText="" UniqueName="Actions" ColumnGroupName="Actions" HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                ToolTip="Link to PASconcept Client" Visible='<%# IIf(TypeOf Eval("Name") Is DBNull, "False", "True") %>' CommandName="Link" CommandArgument='<%# String.Concat(Eval("QBId"), ",", Eval("Id")) %>'>
                                <i class="fas fa-link" aria-hidden="true" ></i>
                                            </asp:LinkButton>
                                            &nbsp;
                            <asp:LinkButton ID="btnCreate" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                ToolTip="Import Customers to PASconcept" Visible='<%# IIf(TypeOf Eval("cEmail") Is DBNull, "True", "False") %>' CommandName="CreateNew" CommandArgument='<%# Eval("QBId")%>'>
                                <i class="far fa-clone" aria-hidden="true" ></i>
                            </asp:LinkButton>
                                            &nbsp;
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                ToolTip="Search client in PASconcept" CommandName="Search" CommandArgument='<%# Eval("QBId")%>'>
                                <i class="fas fa-search" aria-hidden="true" ></i>
                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="Name"
                                        FilterControlAltText="Name column" HeaderText="Client Name"
                                        SortExpression="Name" UniqueName="Name" ColumnGroupName="Clients">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="cEmail"
                                        FilterControlAltText=" Email column" HeaderText="Email"
                                        SortExpression="cEmail" UniqueName="cEmail" ColumnGroupName="Clients">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <br />
                        <h4>Linked PASconcept Clients</h4>
                        <telerik:RadGrid ID="RadGridLinked" runat="server" Width="100%" DataSourceID="SqlDataSourceQBLinked"
                            PageSize="50" AllowPaging="true" Height="600px" RenderMode="Lightweight" BorderStyle="None"
                            AllowMultiRowSelection="True" AllowAutomaticDeletes="true"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                            FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                            <ClientSettings Selecting-AllowRowSelect="true">
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
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
                                                        <telerik:GridTemplateColumn HeaderText="Clients" UniqueName="Clients" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="60px">
                                                            <ItemTemplate>
                                                                <h5><%# Eval("Name")%></h5>
                                                                <span><%# Eval("Email")%></span>
                                                                <br />
                                                                <span><%# Eval("Company")%></span>
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

                </telerik:RadWizardStep>

                <%--Employees--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepEmployees" Title="Employees" StepType="Step">

                    <asp:Panel ID="SyncPanelEmployees" runat="server">
                        <div class="pasconcept-bar">
                            <span class="pasconcept-pagetitle">Unlinked QuickBooks Employees
                            </span>
                            <span style="float: right; vertical-align: middle;">
                                <asp:Button ID="btnGetEmployees" runat="server" Text="Get Employees from QuickBooks Online " CssClass="btn btn-success" />

                                <asp:LinkButton ID="btnBulkLinkEmployees" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Link all selected QuickBook Employees to PASconcept">
                    Bulk Link
                                </asp:LinkButton>
                            </span>
                        </div>
                        <telerik:RadGrid ID="RadGridEmployees" runat="server" Width="100%" DataSourceID="SqlDataSourceEmployeesPending"
                            PageSize="50" AllowPaging="true" Height="580px" RenderMode="Lightweight" BorderStyle="None"
                            AllowMultiRowSelection="True" AllowAutomaticDeletes="true"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                            FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                            <ClientSettings Selecting-AllowRowSelect="true">
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="DisplayName" DataSourceID="SqlDataSourceEmployeesPending">
                                <ColumnGroups>
                                    <telerik:GridColumnGroup HeaderText="QuickBooks Employees" Name="QuickBooksEmployees" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Larger" HeaderStyle-ForeColor="DarkGreen" />
                                    <telerik:GridColumnGroup HeaderText="PASconcept Suggested Employees" Name="Employees" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="24px" HeaderStyle-ForeColor="DarkBlue" />
                                    <telerik:GridColumnGroup HeaderText="Options" Name="Actions" HeaderStyle-HorizontalAlign="Center" />
                                </ColumnGroups>
                                <Columns>

                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="EmployeesSelectColumn">
                                    </telerik:GridClientSelectColumn>

                                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" HeaderStyle-Width="10px" UniqueName="Id" Display="false"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="QBId" HeaderText="QBId" HeaderStyle-Width="10px" UniqueName="QBId" Display="false"></telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="DisplayName"
                                        FilterControlAltText="Filter DisplayName column" HeaderText="Employees Name"
                                        SortExpression="DisplayName" UniqueName="DisplayName" ColumnGroupName="QuickBooksEmployees">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PrimaryEmailAddr"
                                        FilterControlAltText="Filter Email column" HeaderText="Email"
                                        SortExpression="Email" UniqueName="Email" ColumnGroupName="QuickBooksEmployees">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Mobile"
                                        FilterControlAltText="Filter Phone column" HeaderText="Phone"
                                        SortExpression="CompanyName" UniqueName="Phone" ColumnGroupName="QuickBooksEmployees">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderText="" UniqueName="Actions" ColumnGroupName="Actions" HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                ToolTip="Link to PASconcept Client" Visible='<%# IIf(TypeOf Eval("Name") Is DBNull, "False", "True") %>' CommandName="Link" CommandArgument='<%# String.Concat(Eval("QBId"), ",", Eval("Id")) %>'>
                                                <i class="fas fa-link" aria-hidden="true" ></i>
                                            </asp:LinkButton>
                                            &nbsp;
                                            <asp:LinkButton ID="btnLincUpdateemp" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                ToolTip="Update Employee Info from Quickbooks" CommandName="QBUpdate" CommandArgument='<%# String.Concat(Eval("QBId"), ",", Eval("Id")) %>' Visible='<%# IIf(TypeOf Eval("Name") Is DBNull, "False", "True") %>'>
                                                <i class="fas fa-download" aria-hidden="true"></i>
                                            </asp:LinkButton>
                                            &nbsp;
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                ToolTip="Search client in PASconcept" CommandName="Search" CommandArgument='<%# Eval("QBId")%>'>
                                <i class="fas fa-search" aria-hidden="true" ></i>
                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="FullName"
                                        FilterControlAltText="Name column" HeaderText="Employee Name"
                                        SortExpression="FullName" UniqueName="FullName" ColumnGroupName="Employees">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="cEmail"
                                        FilterControlAltText=" Email column" HeaderText="Email"
                                        SortExpression="cEmail" UniqueName="cEmail" ColumnGroupName="Employees">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <br />
                        <h4>Linked PASconcept EMployees</h4>
                        <telerik:RadGrid ID="RadGridLinkedEmployees" runat="server" Width="100%" DataSourceID="SqlDataSourceQBLinkedEmployees"
                            PageSize="50" AllowPaging="true" Height="600px" RenderMode="Lightweight" BorderStyle="None"
                            AllowMultiRowSelection="True" AllowAutomaticDeletes="true"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                            FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                            <ClientSettings Selecting-AllowRowSelect="true">
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceQBLinkedEmployees">

                                <Columns>
                                    <telerik:GridBoundColumn DataField="FullName"
                                        FilterControlAltText="Filter Name column" HeaderText="FullName"
                                        SortExpression="FullName" UniqueName="FullName">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Email"
                                        FilterControlAltText="Filter Email column" HeaderText="Email"
                                        SortExpression="Email" UniqueName="Email">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Phone"
                                        FilterControlAltText="Filter Phone column" HeaderText="Phone"
                                        SortExpression="Phone" UniqueName="Phone">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                ToolTip="Unlink from Quickbooks" CommandName="UnLink" CommandArgument='<%# Eval("Id")%>'>
                                <i class="fas fa-unlink" aria-hidden="true"></i>
                                            </asp:LinkButton>
                                            &nbsp;
                                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                ToolTip="Update Employee Info from Quickbooks" CommandName="QBUpdate" CommandArgument='<%# Eval("Id")%>'>
                                                <i class="fas fa-download" aria-hidden="true"></i>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <telerik:RadToolTip ID="RadToolTipSearchEmployee" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

                            <table style="width: 400px">
                                <tr>
                                    <td colspan="2">
                                        <h3 style="margin: 0; text-align: center; color: white;">
                                            <span class="navbar navbar-expand-md bg-dark text-white">Match Employees</span>
                                        </h3>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlFindEMployees" runat="server" DefaultButton="btnFindEmployee">
                                            <table class="table-sm" style="width: 100%">
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox ID="txtFindEmployees" runat="server" x-webkit-speech="x-webkit-speech" Width="100%"
                                                            EmptyMessage="Search for Name, Email, Phone">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="width: 150px; text-align: right">
                                                        <asp:LinkButton ID="btnFindEmployee" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
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
                                            <telerik:RadGrid ID="RadGridSearhcEmployee" runat="server" AllowPaging="False" Width="100%" DataSourceID="SqlDataSourceQBNotLinkedEmployees">
                                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceQBNotLinkedEmployees">

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
                </telerik:RadWizardStep>

                <%--Vendors--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepVendors" Title="Vendors" StepType="Step">
                    <asp:Panel ID="SyncPanelVendors" runat="server">
                        <div class="pasconcept-bar">
                            <span class="pasconcept-pagetitle">Unlinked QuickBooks Vendors
                            </span>
                            <span style="float: right; vertical-align: middle;">
                                <asp:Button ID="btnGetVendors" runat="server" Text="Get Vendors from QuickBooks Online " CssClass="btn btn-success" />
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
                            <asp:LinkButton ID="btnCreate" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                ToolTip="Import Customers to PASconcept" Visible='<%# IIf(TypeOf Eval("Name") Is DBNull, "True", "False") %>' CommandName="CreateNew" CommandArgument='<%# Eval("QBId")%>'>
                                <i class="far fa-clone" aria-hidden="true" ></i>
                            </asp:LinkButton>
                                            &nbsp;
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                ToolTip="Search client in PASconcept" CommandName="Search" CommandArgument='<%# Eval("QBId")%>'>
                                <i class="fas fa-search" aria-hidden="true" ></i>
                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="Name"
                                        FilterControlAltText="Name" HeaderText="Vendor Name"
                                        SortExpression="Name" UniqueName="Name" ColumnGroupName="Vendors">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Company"
                                        FilterControlAltText="Company" HeaderText="Vendor Company"
                                        SortExpression="Company" UniqueName="Company" ColumnGroupName="Vendors">
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
                </telerik:RadWizardStep>

                <%--Payments--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepPayments" Title="Payments" StepType="Step">
                    <div class="pasconcept-bar noprint">
                        <span class="pasconcept-pagetitle">Payments</span>

                        <span style="float: right; vertical-align: middle;">
                            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                                <i class="fas fa-filter"></i>&nbsp;Filter
                            </button>
                            <asp:LinkButton ID="btnSyncPayments" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Get payments">
                                Get Payment From QuickBooks Online
                            </asp:LinkButton>

                        </span>

                    </div>

                    <div class="collapse" id="collapseFilter">
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnRefresh">
                            <table class="table-sm pasconcept-bar" style="width: 100%">
                                <tr>
                                    <td style="width: 160px">From:
                        <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Culture="en-US" ToolTip="Date From of the filter">
                        </telerik:RadDatePicker>
                                    </td>
                                    <td style="width: 160px">To:
                                <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Culture="en-US">
                                </telerik:RadDatePicker>

                                    </td>
                                    <td style="width: 300px">
                                        <telerik:RadComboBox ID="cboDepartments" runat="server" AppendDataBoundItems="true"
                                            DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" Filter="Contains"
                                            Height="300px" MarkFirstMatch="True" Width="100%">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Departments...)" Value="-1" />
                                            </Items>
                                        </telerik:RadComboBox>

                                    </td>

                                    <td></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <telerik:RadComboBox ID="cboClients" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceClient" ToolTip="Clients"
                                            DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" MarkFirstMatch="True" Width="100%">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Clients...)" Value="-1" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox1" runat="server" EmptyMessage="Search for Invoice, Job/Client, Notes..."
                                            Width="100%" x-webkit-speech="x-webkit-speech">
                                        </telerik:RadTextBox>
                                    </td>
                                    <td style="text-align: right; width: 150px">
                                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                    <div>
                        <telerik:RadGrid ID="RadGridPayments" runat="server" DataSourceID="SqlDataSourcePayment" ShowFooter="true" Width="100%" Skin="Bootstrap" AllowSorting="true" AllowAutomaticDeletes="True"
                            AllowMultiRowSelection="True"
                            PageSize="50" AllowPaging="true"
                            Height="850px" RenderMode="Lightweight"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                            <ClientSettings Selecting-AllowRowSelect="true">
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourcePayment" DataKeyNames="Id">
                                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                                <Columns>


                                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Payment ID" ReadOnly="True"
                                        HeaderStyle-Width="100px" SortExpression="Id" UniqueName="Id" ItemStyle-HorizontalAlign="Center">
                                    </telerik:GridBoundColumn>




                                    <telerik:GridTemplateColumn DataField="InvoiceNumber" HeaderText="Invoice" UniqueName="InvoiceNumber"
                                        HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton ID="lnkEditPayment" runat="server" CommandName="EditPayment" CommandArgument='<%# Eval("Id") %>'
                                                            Text='<%# Eval("InvoiceNumber") %>' ToolTip="Click to Edit Payment"></asp:LinkButton>
                                                    </td>
                                                    <td style="padding-left: 3px">
                                                        <asp:Panel runat="server" Visible='<%# Eval("InvoicesId")>0 %>'>
                                                            <a class="far fa-share-square" title="View Invoice"
                                                                href='<%# LocalAPI.GetSharedLink_URL(4, Eval("InvoicesId"))%>'
                                                                target="_blank" aria-hidden="true"></a>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>

                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="PaymentDate" DataType="System.DateTime" FilterControlAltText="Filter PaymentDate column"
                                        HeaderText="Date" SortExpression="PaymentDate" UniqueName="PaymentDate" AllowSorting="true"
                                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Payment Date">
                                        <ItemTemplate>
                                            <%# Eval("PaymentDate","{0:d}")%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="ClientName" HeaderText="Client - Job - Notes" UniqueName="ClientName"
                                        ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <div>
                                                <b><%# Eval("ClientName")%></b> (<%# Eval("JobName")%>)
                                            </div>
                                            <div>
                                                <div>
                                                    <small><%# Eval("InvoiceNotes")%></small>
                                                </div>
                                            </div>

                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="InvoiceAmount" HeaderText="Amount" UniqueName="InvoiceAmount" AllowSorting="true"
                                        HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" DataFormatString="{0:C}"
                                        FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="PaymentAmount" HeaderText="Amount Paid" UniqueName="PaymentAmount" AllowSorting="true"
                                        HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" DataFormatString="{0:C}"
                                        FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="AmountDue" HeaderText="Amount Due" UniqueName="AmountDue" AllowSorting="true"
                                        HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}"
                                        FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <%# Eval("AmountDue", "{0:C}") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="PaymentMethod" HeaderText="Method" UniqueName="PaymentMethod" HeaderStyle-Width="180px" AllowSorting="true"
                                        ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <div>
                                                <b><%# Eval("PaymentMethod") %></b>
                                                <span style="float: right; vertical-align: middle;">
                                                    <asp:Panel ID="PanelUpload" runat="server" Visible='<%#Len(Eval("Download_url")) %>'>
                                                        <a class="fas fa-cloud-download-alt" href='<%# Eval("Download_url")%>' target="_blank"></a>
                                                    </asp:Panel>
                                                </span>

                                            </div>
                                            <div>
                                                <small><%# Eval("PaymentNotes")%></small>
                                            </div>

                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </telerik:RadWizardStep>

            </WizardSteps>
        </telerik:RadWizard>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

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
        SelectCommand="CLIENT_Not_linked_QBO_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFind" Name="Filter" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceEmployeesPending" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_Sync_QBO_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceQBLinkedEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employyes_linked_QBO_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceQBNotLinkedEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_Not_linked_QBO_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFindEmployees" Name="Filter" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

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

    <%--Payments--%>

    <asp:SqlDataSource ID="SqlDataSourcePayment" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Payments_v20_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="PaymentDateFrom" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="PaymentDateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboClients" Name="ClientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="PaymentMethodId" DefaultValue="13" Type="Int32" />
            <asp:Parameter Name="ReconciledId" DefaultValue="-1" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectCustomer" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectEmployee" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectVendors" runat="server" Visible="False"></asp:Label>
</asp:Content>

