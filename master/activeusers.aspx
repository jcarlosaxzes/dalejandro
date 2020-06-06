<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="activeusers.aspx.vb" Inherits="pasconcept20.activeusers" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Year:
    <telerik:RadDropDownList ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear" DataTextField="nYear"
        DataValueField="Year" Width="100px" AutoPostBack="true" CausesValidation="false" UseSubmitBehavior="false">
    </telerik:RadDropDownList>


    <telerik:RadWizard ID="RadWizard1" runat="server" Height="650px" Width="100%" BorderColor="LightBlue" BorderStyle="Solid" RenderMode="Lightweight" Skin="Silk"
        DisplayNavigationButtons="false" DisplayProgressBar="false">
        <WizardSteps>
            <telerik:RadWizardStep ID="RadWizardStep1" Title="PASconcept" runat="server" StepType="Start" CausesValidation="true">
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" AllowSorting="True" ShowFooter="true" Height="600px">
                    <ClientSettings>
                        <Scrolling AllowScroll="True"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataSourceID="SqlDataSource1" AutoGenerateColumns="False">
                        <Columns>
                            <telerik:GridBoundColumn DataField="Company" FilterControlAltText="Filter Company column" HeaderText="Company" SortExpression="Company" UniqueName="Company">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Jobs" DataType="System.Int32" FilterControlAltText="Filter Jobs column" HeaderText="Jobs" ReadOnly="True" SortExpression="Jobs" UniqueName="Jobs"
                                DataFormatString="{0:N0}" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center" FooterStyle-Width="100px" FooterStyle-HorizontalAlign="Center" FooterStyle-Font-Bold="TRUE" FooterStyle-Font-Size="Large">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Invoices" DataType="System.Int32" FilterControlAltText="Filter Invoices column" HeaderText="Invoices" ReadOnly="True" SortExpression="Invoices" UniqueName="Invoices"
                                DataFormatString="{0:N0}" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" FooterStyle-Font-Bold="TRUE" FooterStyle-Font-Size="Large">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ActiveUsers" DataType="System.Int32" FilterControlAltText="Filter ActiveUsers column" HeaderText="Active Users" ReadOnly="True" SortExpression="ActiveUsers" UniqueName="ActiveUsers"
                                DataFormatString="{0:N0}" FooterAggregateFormatString="{0:N0}" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center" FooterStyle-Width="100px" FooterStyle-HorizontalAlign="Center" FooterStyle-Font-Bold="TRUE" FooterStyle-Font-Size="Large">
                            </telerik:GridBoundColumn>

                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </telerik:RadWizardStep>
            <telerik:RadWizardStep ID="RadWizardStep2" Title="iBinderbook" runat="server" StepType="Start" CausesValidation="true">
                <p>
                    Debemos cobrar por "Active Users" y no por "Active (not repeated) Users" desde que no cobramos $1,500 por "Web Site" !!!
                </p>
                <telerik:RadGrid ID="RadGrid2" runat="server" DataSourceID="SqlDataSourceiBiderbook" AllowSorting="True" ShowFooter="true" Height="600px">
                    <ClientSettings>
                        <Scrolling AllowScroll="True"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataSourceID="SqlDataSourceiBiderbook" AutoGenerateColumns="False">
                        <Columns>
                            <telerik:GridBoundColumn DataField="Application" FilterControlAltText="Filter Module column" HeaderText="Application" SortExpression="Application" UniqueName="Application">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ActiveUsers" DataType="System.Int32" FilterControlAltText="Filter ActiveUsers column" HeaderText="Active Users" ReadOnly="True" SortExpression="ActiveUsers" UniqueName="ActiveUsers"
                                Aggregate="Sum" DataFormatString="{0:N0}" FooterAggregateFormatString="{0:N0}" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center" FooterStyle-Width="150px" FooterStyle-HorizontalAlign="Center" FooterStyle-Font-Bold="TRUE" FooterStyle-Font-Size="Large">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ActiveNotRepeatedUsers" DataType="System.Int32" FilterControlAltText="Filter ActiveNotRepeatedUsers column" HeaderText="Active (not repeated) Users" ReadOnly="True" SortExpression="ActiveNotRepeatedUsers" UniqueName="ActiveNotRepeatedUsers"
                                Aggregate="Sum" DataFormatString="{0:N0}" FooterAggregateFormatString="{0:N0}" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center" FooterStyle-Width="150px" FooterStyle-HorizontalAlign="Center" FooterStyle-Font-Bold="TRUE" FooterStyle-Font-Size="Large">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ActiveUsersMonthlyBill" FilterControlAltText="Filter ActiveUsersMonthlyBill column" HeaderText="Monthly Bill" ReadOnly="True" SortExpression="ActiveUsersMonthlyBill" UniqueName="ActiveUsersMonthlyBill"
                                Aggregate="Sum" DataFormatString="{0:C2}" FooterAggregateFormatString="{0:C2}" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="TRUE" FooterStyle-Font-Size="Large">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ActiveNotRepeatedUsersMonthlyBill" FilterControlAltText="Filter ActiveNotRepeatedUsersMonthlyBill column" HeaderText="Monthly (not repeated) Bill" ReadOnly="True" SortExpression="ActiveNotRepeatedUsersMonthlyBill" UniqueName="ActiveNotRepeatedUsersMonthlyBill"
                                Aggregate="Sum" DataFormatString="{0:C2}" FooterAggregateFormatString="{0:C2}" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="TRUE" FooterStyle-Font-Size="Large">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </telerik:RadWizardStep>
            <telerik:RadWizardStep ID="RadWizardStep3" Title="iBinderBook Use STADISTICTS" runat="server" StepType="Start" CausesValidation="true">
                <telerik:RadGrid ID="RadGrid3" runat="server" DataSourceID="SqlDataSource3" AllowSorting="True" ShowFooter="true" Height="600px">
                    <ClientSettings>
                        <Scrolling AllowScroll="True"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataSourceID="SqlDataSource3" AutoGenerateColumns="False">
                        <Columns>
                            <telerik:GridBoundColumn DataField="Activity" FilterControlAltText="Filter Activity column" HeaderText="Activity" SortExpression="Activity" UniqueName="Activity">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Year" HeaderText="Year" SortExpression="Year" UniqueName="Year" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MonthName" HeaderText="Month" SortExpression="Month" UniqueName="Month" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AORS" HeaderText="#AORS" SortExpression="#AORS" UniqueName="#AORS" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="USERS" HeaderText="#Agents" SortExpression="#Agents" UniqueName="#Agents" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>


                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </telerik:RadWizardStep>
        </WizardSteps>
    </telerik:RadWizard>

    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Year, nYear FROM Years ORDER BY Year DESC"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="sys_CompanyYearActivity" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="year" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceiBiderbook" runat="server"
        ConnectionString="Server=axzesu2server.database.windows.net;Database=ibinderbook_db;User ID=axzesu2@axzesu2server;Password=P@ssw0rd;Trusted_Connection=False;Encrypt=True;Connection Timeout=30;" ProviderName="System.Data.SqlClient"
        SelectCommand="sys_BillingByActiveUsers" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server"
        ConnectionString="Server=axzesu2server.database.windows.net;Database=ibinderbook_db;User ID=axzesu2@axzesu2server;Password=P@ssw0rd;Trusted_Connection=False;Encrypt=True;Connection Timeout=30;" ProviderName="System.Data.SqlClient"
        SelectCommand="sys_iBinderBook_USE_STADISTICTS" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="year" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

