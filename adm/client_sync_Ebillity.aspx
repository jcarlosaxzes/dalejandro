<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="client_sync_Ebillity.aspx.vb" Inherits="pasconcept20.client_sync_Ebillity" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">Ebillity Import Manager
        </span>
        
    </div>
    <div class="pas-container" style="width: 100%">
        <telerik:RadWizard ID="RadWizardFiles" runat="server" DisplayCancelButton="false" DisplayProgressBar="false" DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Silk">
            <WizardSteps>
               
                 <%--Clients--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepClients" Title="Clients" StepType="Step">

                    <asp:Panel ID="SyncPanel" runat="server">
                        <div class="pasconcept-bar">
                            <span class="pasconcept-pagetitle">Unlinked Ebillity Clients
                            </span>
                            <span style="float: right; vertical-align: middle;">
                                <asp:Button ID="btnRefresh" runat="server" Text="Refresh" CssClass="btn btn-primary" />

                                <asp:Button ID="btnGetCustomers" runat="server" Text="Get Clients from Ebillity" CssClass="btn btn-success" OnClick="btnGetCustomers_Click" />

                                <asp:LinkButton ID="btnBulkLink" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Link all selected Ebillity Client to PASconcept Clients">
                    Bulk Link
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnBulkCopy" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Copy all selected Ebillity Client to PASconcept Clients">
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
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="ClientName" DataSourceID="SqlDataSourceClientPending">
                                
                                <Columns>

                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="ClientSelectColumn">
                                    </telerik:GridClientSelectColumn>

                                    <telerik:GridBoundColumn DataField="ClientId" HeaderText="EbillityId" HeaderStyle-Width="10px" UniqueName="ClientId" Display="false"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PC_ClientId" HeaderText="PC_ClientId" HeaderStyle-Width="10px" UniqueName="PC_ClientId" Display="false"></telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="ClientName"
                                        FilterControlAltText="Filter ClientName column" HeaderText="Ebillity Client"
                                        SortExpression="ClientName" UniqueName="ClientName" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="24px" HeaderStyle-ForeColor="DarkBlue">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderText="" UniqueName="Actions"  HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                ToolTip="Link to PASconcept Client" Visible='<%# IIf(Len(Eval("Client")) > 0, "True", "False") %>' CommandName="Link" CommandArgument='<%# String.Concat(Eval("ClientId"), ",", Eval("PC_ClientId")) %>'>
                                            <i class="fas fa-link" aria-hidden="true" ></i>
                                                        </asp:LinkButton>
                                                        &nbsp;
                                        <asp:LinkButton ID="btnCreate" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                            ToolTip="Import Clients to PASconcept" Visible='<%# IIf(Len(Eval("Client")) > 0, "False", "True") %>' CommandName="CreateNew" CommandArgument='<%# Eval("ClientId") %>'>
                                            <i class="far fa-clone" aria-hidden="true" ></i>
                                        </asp:LinkButton>
                                                        &nbsp;
                                        <asp:LinkButton ID="btnSearch" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                            ToolTip="Search client in PASconcept" CommandName="Search" CommandArgument='<%# Eval("ClientId")%>'>
                                            <i class="fas fa-search" aria-hidden="true" ></i>
                                        </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="Client"
                                        FilterControlAltText="Name column" HeaderText="PASconcept Suggested Clients"
                                        SortExpression="Client" UniqueName="Client" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="24px" HeaderStyle-ForeColor="DarkBlue">
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
                                                ToolTip="Unlink from Ebillity" CommandName="UnLink" CommandArgument='<%# Eval("Id")%>'>
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

                  <%--Project--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepProject" Title="Projects" StepType="Step">

                    <asp:Panel ID="Panel1" runat="server">
                        <div class="pasconcept-bar">
                            <span class="pasconcept-pagetitle">Unlinked Ebillity Projects (Task)
                            </span>
                            <span style="float: right; vertical-align: middle;">

                                <asp:LinkButton ID="btnBulkLinkJobs" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Link all selected Ebillity Project to PASconcept Project">
                    Bulk Link
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnBulkCopyJobs" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Copy all selected Ebillity Project to PASconcept Projects">
                    Bulk Copy
                                </asp:LinkButton>
                            </span>
                        </div>
                        <telerik:RadGrid ID="RadGridProject" runat="server" Width="100%" DataSourceID="SqlDataSourceProjectPending"
                            PageSize="50" AllowPaging="true" Height="580px" RenderMode="Lightweight" BorderStyle="None"
                            AllowMultiRowSelection="True" AllowAutomaticDeletes="true"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                            FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                            <ClientSettings Selecting-AllowRowSelect="true">
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="ClientName" DataSourceID="SqlDataSourceProjectPending">

                                <Columns>

                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="ProjectSelectColumn">
                                    </telerik:GridClientSelectColumn>

                                    <telerik:GridBoundColumn DataField="ClientId" HeaderText="ClientId Id" HeaderStyle-Width="10px" UniqueName="ClientId" Display="false"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="JobId" HeaderText="Project Id" HeaderStyle-Width="10px" UniqueName="JobId" Display="false"></telerik:GridBoundColumn>



                                    <telerik:GridTemplateColumn HeaderText="Ebillity Project " UniqueName="ClientName" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="24px" HeaderStyle-ForeColor="DarkBlue">
                                         <ItemTemplate>
                                             <asp:Label runat="server" Text='<%# Eval("ClientName") & IIf(Len(Eval("projectName")) > 0, " :" & Eval("projectName"), "") %>'></asp:Label>
                                         </ItemTemplate>                                    
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                ToolTip="Link to PASconcept Project" Visible='<%# IIf(Len(Eval("Job")) > 0, "True", "False") %>' CommandName="Link" CommandArgument='<%# String.Concat(Eval("ClientId"), ",", Eval("JobId")) %>'>
                                            <i class="fas fa-link" aria-hidden="true" ></i>
                                            </asp:LinkButton>
                                            &nbsp;
                                        <asp:LinkButton ID="btnCreate" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                            ToolTip="Import Projects to PASconcept" Visible='<%# IIf(Len(Eval("Job")) > 0, "False", "True") %>' CommandName="CreateNew" CommandArgument='<%# Eval("ClientId") %>'>
                                            <i class="far fa-clone" aria-hidden="true" ></i>
                                        </asp:LinkButton>
                                            &nbsp;
                                        <asp:LinkButton ID="btnSearch" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                            ToolTip="Search Project in PASconcept" CommandName="Search" CommandArgument='<%# Eval("ClientId")%>'>
                                            <i class="fas fa-search" aria-hidden="true" ></i>
                                        </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="Job"
                                        FilterControlAltText="Name column" HeaderText="PASconcept Suggested Projects"
                                        SortExpression="Job" UniqueName="Job" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="24px" HeaderStyle-ForeColor="DarkBlue">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <br />
                        <h4>Linked PASconcept Projects</h4>
                        <telerik:RadGrid ID="RadGridLinkedProject" runat="server" Width="100%" DataSourceID="SqlDataSourceProjectLinked"
                            PageSize="50" AllowPaging="true" Height="600px" RenderMode="Lightweight" BorderStyle="None"
                            AllowMultiRowSelection="True" AllowAutomaticDeletes="true"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                            FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                            <ClientSettings Selecting-AllowRowSelect="true">
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="JobId" DataSourceID="SqlDataSourceProjectLinked">

                                <Columns>
                                     <telerik:GridBoundColumn DataField="JobId" HeaderText="Project Id" HeaderStyle-Width="10px" UniqueName="JobId" Display="false"></telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="EbillityClient"
                                        FilterControlAltText="Filter Name column" HeaderText="Ebillity Client"
                                        SortExpression="EbillityClient" UniqueName="EbillityClient">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="projectName"
                                        FilterControlAltText="Filter Name column" HeaderText="Ebillity Project"
                                        SortExpression="projectName" UniqueName="projectName">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Job"
                                        FilterControlAltText="Filter Email column" HeaderText="Project"
                                        SortExpression="Job" UniqueName="Job">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Code"
                                        FilterControlAltText="Filter Code column" HeaderText="Project Code"
                                        SortExpression="Code" UniqueName="Code">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                ToolTip="Unlink from Ebillity" CommandName="UnLink" CommandArgument='<%# Eval("JobId")%>'>
                                <i class="fas fa-unlink" aria-hidden="true"></i>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <telerik:RadToolTip ID="RadToolTipSearchProject" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

                            <table style="width: 400px">
                                <tr>
                                    <td colspan="2">
                                        <h3 style="margin: 0; text-align: center; color: white;">
                                            <span class="navbar navbar-expand-md bg-dark text-white">Match Project Files</span>
                                        </h3>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlFindJobs" runat="server" DefaultButton="btnFindJobs">
                                            <table class="table-sm" style="width: 100%">
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox ID="txtFindJobs" runat="server" x-webkit-speech="x-webkit-speech" Width="100%"
                                                            EmptyMessage="Search for Project Name">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="width: 150px; text-align: right">
                                                        <asp:LinkButton ID="btnFindJobs" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
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
                                            <telerik:RadGrid ID="RadGridSearhcProject" runat="server" AllowPaging="False" Width="100%" DataSourceID="SqlDataSourceProjectNotLinked">
                                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceProjectNotLinked">

                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderText="Projects" UniqueName="Projects" HeaderStyle-HorizontalAlign="Center"
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
                                                                    ToolTip="Link to PASconcept Project" CommandName="Link" CommandArgument='<%# Eval("Id")%>'>
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

                        <telerik:RadToolTip ID="RadToolTipCompyProject" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
                            <asp:Panel ID="Panel2" runat="server" DefaultButton="btnFindJobs">
                                <div class="pasconcept-bar">
                                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Cancel
                                    </asp:LinkButton>

                                    <span class="pasconcept-pagetitle">New Job</span>

                                </div>
                                <div>
                                    <asp:ValidationSummary ID="vsClient" runat="server" ValidationGroup="JobUpdate" ForeColor="Red"
                                        HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were this errors:"></asp:ValidationSummary>
                                </div>
                                <div class="pasconcept-bar">
                                    <table class="table-sm" style="width: 100%">
                                        <tr>                                            
                                            <td style="width: 180px; text-align: right">Project Code:</td>
                                            <td style="width: 40px; text-align: right">
                                                <asp:Label ID="lblYear" runat="server" Font-Bold="true" Font-Size="Medium">
                                                </asp:Label>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtCode" runat="server" Width="100px" MaxLength="4" Font-Bold="true">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="table-sm" style="width: 100%">
                                       <tr>
                                            <td style="text-align: right">Job Name:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtJob" runat="server" Width="100%" MaxLength="80">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="text-align: right">Client:
                                            </td>
                                            <td>
                                                
                                            </td>
                                        </tr>
                                       
                                    </table>
                                </div>
                            </asp:Panel>
                        </telerik:RadToolTip>


                    </asp:Panel>

                </telerik:RadWizardStep>


                <%--Employees--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepEmployees" Title="Employees" StepType="Step">

                    <asp:Panel ID="SyncPanelEmployees" runat="server">
                        <div class="pasconcept-bar">
                            <span class="pasconcept-pagetitle">Unlinked Ebillity Employees
                            </span>
                            <span style="float: right; vertical-align: middle;">
                                <asp:Button ID="btnGetEmployees" runat="server" Text="Get Employees from Ebillity " CssClass="btn btn-success" />

                                <asp:LinkButton ID="btnBulkLinkEmployees" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Link all selected Ebillity Employees to PASconcept">
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
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="EmployeeId" DataSourceID="SqlDataSourceEmployeesPending">
                                <ColumnGroups>
                                    <telerik:GridColumnGroup HeaderText="Ebillity Employees" Name="EabillityEmployees" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Larger" HeaderStyle-ForeColor="DarkGreen" />
                                    <telerik:GridColumnGroup HeaderText="PASconcept Suggested Employees" Name="Employees" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="24px" HeaderStyle-ForeColor="DarkBlue" />
                                    <telerik:GridColumnGroup HeaderText="Options" Name="Actions" HeaderStyle-HorizontalAlign="Center" />
                                </ColumnGroups>
                                <Columns>

                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="EmployeesSelectColumn">
                                    </telerik:GridClientSelectColumn>

                                    <telerik:GridBoundColumn DataField="EmployeeId" HeaderText="EmployeeId" HeaderStyle-Width="10px" UniqueName="EmployeeId" Display="false"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" HeaderStyle-Width="10px" UniqueName="Id" Display="false"></telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="FirstName"
                                        FilterControlAltText="Filter FirstName column" HeaderText="First Name"
                                        SortExpression="FirstName" UniqueName="FirstName" ColumnGroupName="EabillityEmployees">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LastName"
                                        FilterControlAltText="Filter LastName column" HeaderText="Last Name"
                                        SortExpression="LastName" UniqueName="LastName" ColumnGroupName="EabillityEmployees">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderText="" UniqueName="Actions" ColumnGroupName="Actions" HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                ToolTip="Link to PASconcept Client" Visible='<%# IIf(TypeOf Eval("FullName") Is DBNull, "False", "True") %>' CommandName="Link" CommandArgument='<%# String.Concat(Eval("EmployeeId"), ",", Eval("Id")) %>'>
                                                <i class="fas fa-link" aria-hidden="true" ></i>
                                            </asp:LinkButton>
                                            &nbsp;
                                        <asp:LinkButton ID="btnSearch" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                            ToolTip="Search client in PASconcept" CommandName="Search" CommandArgument='<%# Eval("EmployeeId")%>'>
                                            <i class="fas fa-search" aria-hidden="true" ></i>
                                        </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="FullName"
                                        FilterControlAltText="Name column" HeaderText="Employee Name"
                                        SortExpression="FullName" UniqueName="FullName" ColumnGroupName="Employees">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Email"
                                        FilterControlAltText=" Email column" HeaderText="Email"
                                        SortExpression="Email" UniqueName="Email" ColumnGroupName="Employees">
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
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="EmployeeId" DataSourceID="SqlDataSourceQBLinkedEmployees">

                                <Columns>
                                    <telerik:GridBoundColumn DataField="FirstName"
                                        FilterControlAltText="Filter Name column" HeaderText=" Ebillity First Name"
                                        SortExpression="FirstName" UniqueName="FirstName">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LastName"
                                        FilterControlAltText="Filter Name column" HeaderText="Ebillity Last Name"
                                        SortExpression="LastName" UniqueName="LastName">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="FullName"
                                        FilterControlAltText="Filter Name column" HeaderText="FullName"
                                        SortExpression="FullName" UniqueName="FullName">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Email"
                                        FilterControlAltText="Filter Email column" HeaderText="Email"
                                        SortExpression="Email" UniqueName="Email">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                ToolTip="Unlink from Eabillity" CommandName="UnLink" CommandArgument='<%# Eval("EmployeeId")%>'>
                                <i class="fas fa-unlink" aria-hidden="true"></i>
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

                 <%--TimeCategories--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepTimeCategories" Title="Time Categories" StepType="Step">

                    <asp:Panel ID="SyncPanelTimeCategories" runat="server">
                        <div class="pasconcept-bar">
                            <span class="pasconcept-pagetitle">Unlinked Ebillity Activities
                            </span>
                            <span style="float: right; vertical-align: middle;">

                                <asp:Button ID="btnGetTimeCategories" runat="server" Text="Get Activities from Ebillity " CssClass="btn btn-success" />

                                <asp:LinkButton ID="btnBulkLinkTimeCategories" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Link all selected Activities to Time Categories">
                    Bulk Link
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnBulkCopyTimeCategories" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Copy all selected Activities to Time Categories">
                    Bulk Copy
                                </asp:LinkButton>
                            </span>
                        </div>
                        <telerik:RadGrid ID="RadGridTimeCategories" runat="server" Width="100%" DataSourceID="SqlDataSourceTimeCategoriesPending"
                            PageSize="50" AllowPaging="true" Height="580px" RenderMode="Lightweight" BorderStyle="None"
                            AllowMultiRowSelection="True" AllowAutomaticDeletes="true"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                            FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                            <ClientSettings Selecting-AllowRowSelect="true">
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="ActivityId" DataSourceID="SqlDataSourceTimeCategoriesPending">

                                <Columns>

                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="TimeCategoriesSelectColumn">
                                    </telerik:GridClientSelectColumn>

                                    <telerik:GridBoundColumn DataField="ActivityId" HeaderText="ActivityId" HeaderStyle-Width="10px" UniqueName="ActivityId" Display="false"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PC_Time_Categories_ID" HeaderText="TimeCategories Id" HeaderStyle-Width="10px" UniqueName="PC_Time_Categories_ID" Display="false"></telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="ActivityName"
                                        FilterControlAltText="Filter ActivityName column" HeaderText="Ebillity Activity"
                                        SortExpression="ActivityName" UniqueName="ActivityName" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="24px" HeaderStyle-ForeColor="DarkBlue">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderText="" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                ToolTip="Link to PASconcept Project" Visible='<%# IIf(Len(Eval("Name")) > 0, "True", "False") %>' CommandName="Link" CommandArgument='<%# String.Concat(Eval("ActivityId"), ",", Eval("PC_Time_Categories_ID")) %>'>
                                            <i class="fas fa-link" aria-hidden="true" ></i>
                                            </asp:LinkButton>
                                            &nbsp;
                                        <asp:LinkButton ID="btnCreate" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                            ToolTip="Import Projects to PASconcept" Visible='<%# IIf(Len(Eval("Name")) > 0, "False", "True") %>' CommandName="CreateNew" CommandArgument='<%# Eval("ActivityId") %>'>
                                            <i class="far fa-clone" aria-hidden="true" ></i>
                                        </asp:LinkButton>
                                            &nbsp;
                                        <asp:LinkButton ID="btnSearch" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                            ToolTip="Search Project in PASconcept" CommandName="Search" CommandArgument='<%# Eval("ActivityId")%>'>
                                            <i class="fas fa-search" aria-hidden="true" ></i>
                                        </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="Name"
                                        FilterControlAltText="Name column" HeaderText="PASconcept Suggested Time Categories"
                                        SortExpression="Name" UniqueName="Name" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="24px" HeaderStyle-ForeColor="DarkBlue">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <br />
                        <h4>Linked PASconcept Time Categories</h4>
                        <telerik:RadGrid ID="RadGridLinkedTimeCategories" runat="server" Width="100%" DataSourceID="SqlDataSourceTimeCategoriesLinked"
                            PageSize="50" AllowPaging="true" Height="600px" RenderMode="Lightweight" BorderStyle="None"
                            AllowMultiRowSelection="True" AllowAutomaticDeletes="true"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                            FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                            <ClientSettings Selecting-AllowRowSelect="true">
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="ActivityId" DataSourceID="SqlDataSourceTimeCategoriesLinked">

                                <Columns>
                                    <telerik:GridBoundColumn DataField="ActivityName"
                                        FilterControlAltText="Filter Name column" HeaderText="Ebillity Activity Name"
                                        SortExpression="ActivityName" UniqueName="ActivityName">
                                    </telerik:GridBoundColumn>
                                   
                                    <telerik:GridBoundColumn DataField="Name"
                                        FilterControlAltText="Filter Name column" HeaderText="Time Categories"
                                        SortExpression="Name" UniqueName="Name">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                ToolTip="Unlink from Ebillity" CommandName="UnLink" CommandArgument='<%# Eval("ActivityId")%>'>
                                <i class="fas fa-unlink" aria-hidden="true"></i>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <telerik:RadToolTip ID="RadToolTipSearchTimeCategories" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

                            <table style="width: 400px">
                                <tr>
                                    <td colspan="2">
                                        <h3 style="margin: 0; text-align: center; color: white;">
                                            <span class="navbar navbar-expand-md bg-dark text-white">Match Time Categorie </span>
                                        </h3>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlFindTimeCategories" runat="server" DefaultButton="btnFindTimeCategories">
                                            <table class="table-sm" style="width: 100%">
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox ID="txtFindTimeCategories" runat="server" x-webkit-speech="x-webkit-speech" Width="100%"
                                                            EmptyMessage="Search for Time Categorie Name">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="width: 150px; text-align: right">
                                                        <asp:LinkButton ID="btnFindTimeCategories" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
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
                                            <telerik:RadGrid ID="RadGridSearhcTimeCategories" runat="server" AllowPaging="False" Width="100%" DataSourceID="SqlDataSourceTimeCategoriesNotLinked">
                                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceTimeCategoriesNotLinked">

                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderText="Time Categories" UniqueName="Name" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="60px">
                                                            <ItemTemplate>
                                                                <h5><%# Eval("Name")%></h5>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>


                                                        <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false"
                                                                    ToolTip="Link to PASconcept Project" CommandName="Link" CommandArgument='<%# Eval("Id")%>'>
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

                  <%--Time Entries--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepTimeEntries" Title="Time Entries" StepType="Step">

                    <asp:Panel ID="SyncPanelTimeEntries" runat="server">
                        <div class="pasconcept-bar">
                            <span class="pasconcept-pagetitle">Unlinked Ebillity Activities
                            </span>
                            <span style="float: right; vertical-align: middle;">

                                <asp:Button ID="btnGetTimeEntries" runat="server" Text="Get Timer Entries from Ebillity " CssClass="btn btn-success" />

                            </span>
                        </div>
                        <telerik:RadGrid ID="RadGridTimeEntries" runat="server" Width="100%" DataSourceID="SqlDataSourceTimeEntriesPending"
                            PageSize="50" AllowPaging="true" Height="580px" RenderMode="Lightweight" BorderStyle="None"
                            AllowMultiRowSelection="True" AllowAutomaticDeletes="true"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                            FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                            <ClientSettings Selecting-AllowRowSelect="true">
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="TimeEntryId" DataSourceID="SqlDataSourceTimeEntriesPending">

                                <Columns>

                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="TimeEntriesSelectColumn">
                                    </telerik:GridClientSelectColumn>

                                    <telerik:GridBoundColumn DataField="TimeEntryId" HeaderText="TimeEntryId" HeaderStyle-Width="10px" UniqueName="TimeEntryId" Display="false"></telerik:GridBoundColumn>
                                    
                                    <telerik:GridBoundColumn DataField="fecha"
                                        FilterControlAltText="Filter fecha column" HeaderText="Date"
                                        SortExpression="Date" UniqueName="Date" HeaderStyle-Font-Bold="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn HeaderText="Time " UniqueName="TIme" HeaderStyle-Font-Bold="true" >
                                         <ItemTemplate>
                                             <asp:Label runat="server" Text='<%# Eval("TotalHour") & ":" & Eval("TotalMinute") %>'></asp:Label>
                                         </ItemTemplate>                                    
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="Employee"
                                        FilterControlAltText="Employee column" HeaderText="Employee"
                                        SortExpression="Employee" UniqueName="Employee" HeaderStyle-Font-Bold="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Client"
                                        FilterControlAltText="Client column" HeaderText="Client"
                                        SortExpression="Client" UniqueName="Client" HeaderStyle-Font-Bold="true" >
                                    </telerik:GridBoundColumn>

                                    
                                    <telerik:GridBoundColumn DataField="Job"
                                        FilterControlAltText="Project column" HeaderText="Project"
                                        SortExpression="Job" UniqueName="Job" HeaderStyle-Font-Bold="true" >
                                    </telerik:GridBoundColumn>

                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <br />

                    </asp:Panel>

                </telerik:RadWizardStep>


            </WizardSteps>
        </telerik:RadWizard>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <%--Client Data sources--%>
    
    <asp:SqlDataSource ID="SqlDataSourceClientPending" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_Sync_Ebillity_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceQBLinked" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_linked_Ebillity_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceQBNotLinked" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_Not_linked_Ebillity_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFind" Name="Filter" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <%--Employee DataSource--%>

    <asp:SqlDataSource ID="SqlDataSourceEmployeesPending" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_Sync_Ebillity_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceQBLinkedEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employyes_linked_Ebillity_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceQBNotLinkedEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_Ebillity_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFindEmployees" Name="Filter" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

    <%--Project DataSources--%>
    
    <asp:SqlDataSource ID="SqlDataSourceProjectPending" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Job_Sync_Ebillity_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProjectLinked" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Jobs_linked_Ebillity_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProjectNotLinked" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Jobs_Not_linked_Ebillity_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFindJobs" Name="Filter" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

     <%--Time Categorie--%>
    <asp:SqlDataSource ID="SqlDataSourceTimeCategoriesPending" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Time_Categories_Sync_Ebillity_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTimeCategoriesLinked" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Time_Catagories_linked_Ebillity_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTimeCategoriesNotLinked" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Activity_Not_linked_Ebillity_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFindTimeCategories" Name="Filter" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

    
    <%--Time Categorie--%>
    <asp:SqlDataSource ID="SqlDataSourceTimeEntriesPending" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JobTimeEntries_Sync_Ebillity_Select" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectCustomer" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectEmployee" runat="server" Visible="False"></asp:Label>    
    <asp:Label ID="lblSelectProject" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectTimeCategories" runat="server" Visible="False"></asp:Label>
</asp:Content>

