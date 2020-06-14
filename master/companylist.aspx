<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="companylist.aspx.vb" Inherits="pasconcept20.companylist" MasterPageFile="~/master/MasterPage.Master" Async="true" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table class="table-condensed" style="width: 100%">
        <tr>
        </tr>
        <tr>
            <td style="width: 150px">
                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Create New Company">
                    <span class="glyphicon glyphicon-plus"> Company</span>
                </asp:LinkButton>
            </td>
            <td style="width: 120px; text-align: right">Payment Status:
            </td>
            <td style="width: 180px;">
                <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" AppendDataBoundItems="true">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="Active" Value="0" Selected="true" />
                        <telerik:RadComboBoxItem runat="server" Text="Past Due" Value="1" />
                        <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="-1" />
                    </Items>
                </telerik:RadComboBox>
            </td>

            <td style="width: 120px; text-align: right">Binded to Axzes:
            </td>
            <td style="width: 180px;">
                <telerik:RadComboBox ID="cboBinding" runat="server" Width="100%" AppendDataBoundItems="true">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="-1" Selected="true" />
                        <telerik:RadComboBoxItem runat="server" Text="Already Binded" Value="0" />
                        <telerik:RadComboBoxItem runat="server" Text="Pending Bind" Value="1" />
                    </Items>
                </telerik:RadComboBox>
            </td>

            <td style="text-align: center">
                <asp:Label ID="lblMsg" runat="server" Style="font-size: medium; color: #cc0000; font-family: Calibri, Verdana"></asp:Label>
            </td>
            <td style="width: 100px; text-align: right">
                <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-search"></span> Search
                </asp:LinkButton>
            </td>
        </tr>
    </table>
    <table class="table-condensed" style="width: 100%">
        <tr>
            <td>
                <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="0" DataSourceID="SqlDataSource1" AllowAutomaticUpdates="false" AllowAutomaticDeletes="false" ShowFooter="true"
                    GridLines="None" AutoGenerateColumns="False" AllowSorting="True" Skin="Bootstrap"
                    ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="X-Small">
                    <MasterTableView DataKeyNames="companyId" DataSourceID="SqlDataSource1">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="ID" UniqueName="companyId" SortExpression="companyId"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" runat="server" CssClass="PequenaNegrita" NavigateUrl='<%# Eval("companyId", "~/MASTER/Company.aspx?companyId={0}") %>'
                                        Text='<%# Eval("companyId") %>'></asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" SortExpression="Name"
                                HeaderText="Name -- Type" UniqueName="Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left"
                                FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                <ItemTemplate>
                                    <b><%# Eval("Name") %></b> -- <%# Eval("TypeName") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="BillingPlan" FilterControlAltText="Filter Contact column" SortExpression="BillingPlan"
                                HeaderText="Billing Plan<br/> Start - Expiration Date" UniqueName="BillingPlan" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                                <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td colspan="2">
                                                <%# Eval("BillingPlan")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <%# Eval("StartDate", "{0:d}")%>
                                            </td>
                                            <td>
                                                <%# Eval("billingExpirationDate", "{0:d}")%>
                                            </td>
                                        </tr>
                                    </table>

                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="VersionName" FilterControlAltText="Filter Contact column" SortExpression="VersionName"
                                HeaderText="Version" UniqueName="VersionName" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("VersionName") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="ActiveUsers" FilterControlAltText="Filter Contact column" SortExpression="ActiveUsers"
                                HeaderText="Active Users" UniqueName="ActiveUsers" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("ActiveUsers")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Clients" FilterControlAltText="Filter Contact column" SortExpression="Clients"
                                HeaderText="Clients" UniqueName="Clients" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Center" Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                <ItemTemplate>
                                    <%# Eval("Clients", "{0:N0}")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Jobs" FilterControlAltText="Filter Contact column" SortExpression="Jobs"
                                HeaderText="Jobs" UniqueName="Jobs" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Center" Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                <ItemTemplate>
                                    <%# Eval("AxzesJobCode", "{0:N0}")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="AxzesClient" FilterControlAltText="Filter Contact column" SortExpression="AxzesClient"
                                HeaderText="Binded to Axzes (Client -- Job)" UniqueName="AxzesClient" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("Bindingstatus") %>
                                    <b><%# Eval("AxzesClient") %></b>
                                    <%# Eval("AxzesJob") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Contact" FilterControlAltText="Filter Contact column"
                                HeaderText="Contact info" UniqueName="Contact" HeaderStyle-HorizontalAlign="Center" SortExpression="Contact">
                                <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td>
                                                <span title='<%# Eval("Email") %> , <%# Eval("Phone") %>'><%# Eval("Contact") %></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>-- <span><%# Eval("GetStartedEmailDate", "{0:d}") %></span>

                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>

                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-Width="90px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <table style="text-align: center; width: 100%">
                                        <tr>
                                            <td style="width: 30px">
                                                <asp:LinkButton ID="btnSentContactAgain" runat="server" CommandName="GetStartedEmail" CommandArgument='<%# Eval("companyId") %>' UseSubmitBehavior="false"
                                                    ToolTip="Send Email with Help to Get Started with PASconcept!">
                                                    <span class="glyphicon glyphicon-envelope"></span>
                                                </asp:LinkButton>
                                            </td>
                                            <td style="width: 30px">
                                                <asp:LinkButton ID="btnBindAxzesClient" runat="server" CommandName="BindAxzesClient" CommandArgument='<%# Eval("companyId") %>' UseSubmitBehavior="false"
                                                    ToolTip="Bind Company to Axzes Client">
                                                    <span class="glyphicon glyphicon-user"></span>
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:LinkButton runat="server" ID="btnCredentials" CommandName="Credentials" CommandArgument='<%# Eval("companyId") %>'
                                                    ToolTip="Send Email with login credentials">
                                                    <span style="color:green" class="glyphicon glyphicon-envelope"></span>
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>


                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>

                </telerik:RadGrid>
            </td>
        </tr>
    </table>

    <telerik:RadToolTip ID="RadToolTipBindAxzesClient" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table table-bordered" style="width: 650px">
            <tr>
                <td>
                    <h2 style="margin: 0; text-align: center; color:white; width: 650px">
                        <span class="navbar bg-dark">Bind Company to Axzes Client & Job
                        </span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td>
                    <h3>
                        <asp:Label ID="lblCompanyName" runat="server"></asp:Label></h3>
                </td>
            </tr>
            <tr>
                <td>
                    <p>
                        Create NEW Axzes Client or Select one from Client List?
                    </p>
                </td>
            </tr>
            <tr>
                <td>

                    <telerik:RadComboBox ID="cboClient" runat="server" DataSourceID="SqlDataSourceClientes" AutoPostBack="true"
                        DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="True" ZIndex="50001" Height="350px"
                        MarkFirstMatch="True" Filter="Contains">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Create NEW Axzes Client...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>

                </td>
            </tr>
            <tr>
                <td>
                    <p>
                        Create NEW Axzes Job or Select one from Job(Not in Progress or In Progress) List?
                    </p>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadComboBox ID="cboJob" runat="server" DataSourceID="SqlDataSourceJobs"
                        DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="True" ZIndex="50001" Height="350px"
                        MarkFirstMatch="True" Filter="Contains">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Create NEW Axzes Job...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <asp:LinkButton ID="btnBindAxzesClient" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false" ValidationGroup="BindAxzesClient">
                                    <span class="glyphicon glyphicon-ok"></span> Bind Company<-->Axzes
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="MasterCompanyList_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboStatus" Name="statusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboBinding" Name="bindingstatusId" PropertyName="SelectedValue" Type="Int32" />

        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_types] ORDER BY [Name]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]+' [' + isnull(Company,'...') + ']' As Name FROM Clients WHERE companyId=260973 ORDER BY Name"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], Code+'  '+Job Name FROM Jobs WHERE companyId=260973 and Client=@clientId and Status in(0,2) ORDER BY Code DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboClient" Name="clientId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblSelectedCompanyId" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>
