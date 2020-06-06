<%@ Page Title="Client Management" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="clientmanagement.aspx.vb" Inherits="pasconcept20.clientmanagement" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipAvailability"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="btnUpdateAvailability">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipAvailability"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lblStatusDescription" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipNewCampaign" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="btnConfirmCreate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnConfirmCreate" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipNewCampaign" />
                    <telerik:AjaxUpdatedControl ControlID="cboCampaing" />
                    <telerik:AjaxUpdatedControl ControlID="btnExecuteCampaign" />
                    <telerik:AjaxUpdatedControl ControlID="btnDeleteCampaign" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboCampaing">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboCampaing" />
                    <telerik:AjaxUpdatedControl ControlID="btnExecuteCampaign" />
                    <telerik:AjaxUpdatedControl ControlID="btnDeleteCampaign" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnDeleteCampaign">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboCampaing" />
                    <telerik:AjaxUpdatedControl ControlID="btnExecuteCampaign" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnExecuteCampaign">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboCampaing" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }
        </script>
    </telerik:RadCodeBlock>

    <div class="collapse" id="collapseFilter">
        <div class="card card-body">
            <div class="Formulario">
                <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td style="width: 150px; text-align: right">Type:
                            </td>
                            <td style="width: 400px;">
                                <telerik:RadComboBox ID="cboTypes" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceClientTypes" AutoPostBack="true"
                                    DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Width="100%" CausesValidation="False">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Clients Types...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td style="width: 150px; text-align: right">Subtype:
                            </td>
                            <td style="width: 400px;">
                                <telerik:RadComboBox ID="cboSubtype" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceClientSubtypes" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True"
                                    Width="100%">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Clients Subtype...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Status:
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" AppendDataBoundItems="True" DataTextField="Name" DataValueField="Id" DataSourceID="SqlDataSourceClientStatus">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td style="text-align: right">Balance:</td>
                            <td>
                                <telerik:RadComboBox ID="cboAmountDue" runat="server" MarkFirstMatch="True" Width="100%">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Clients ...)" Value="-1" />
                                        <telerik:RadComboBoxItem runat="server" Text="Profit Balance (Amount Due > 0)" Value="1" />
                                        <telerik:RadComboBoxItem runat="server" Text="Zero Balance (Amount Due = 0)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Availability</td>
                            <td>
                                <telerik:RadComboBox ID="cboAvailability" runat="server" Width="100%" AppendDataBoundItems="True" DataTextField="Name" DataValueField="Id"
                                    DataSourceID="SqlDataSourceAvailability">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Availability...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td style="text-align: right">Find:</td>
                            <td>
                                <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Text="" Width="100%"
                                    EmptyMessage="Additional search for Client Name, Organization, Source... ">
                                </telerik:RadTextBox>
                            </td>
                            <td style="text-align: right">
                                <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-search"></span> Search
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
        </div>
    </div>

    <table class="table-condensed noprint Formulario" style="width: 100%">
        <tr>
            <td style="width: 80px; text-align: left">
                <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                    <span class="glyphicon glyphicon-filter"></span>&nbsp;Filter
                </button>
            </td>
            <td></td>
            <td style="width: 90px">
                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Add New Campaign">
                    <span class="glyphicon glyphicon-plus"></span> Campaign
                </asp:LinkButton>
            </td>
            <td style="width: 400px">
                <telerik:RadComboBox ID="cboCampaing" runat="server" DataSourceID="SqlDataSourceCampaing" AutoPostBack="true" CausesValidation="False"
                    Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(Select Campaing...)" Value="-1" Selected="true" />
                    </Items>
                </telerik:RadComboBox>

            </td>
            <td style="width: 100px">
                <asp:LinkButton ID="btnExecuteCampaign" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Run Campaign" Visible="false">
                    <span class="glyphicon glyphicon-envelope"></span> Run
                </asp:LinkButton>

            </td>
            <td style="text-align: center">
                <h3 style="margin: 0">Clients Management
                </h3>
            </td>

            <td style="width: 100px">
                <asp:LinkButton runat="server" ID="CSVButton"
                    CssClass="btn btn-default btn"
                    UseSubmitBehavior="false"
                    ToolTip="Export List to Comma-Separated Values format (.CSV)"
                    CausesValidation="false">
                                        <span class="glyphicon glyphicon-download"></span> Export
                </asp:LinkButton>
            </td>
            <td style="width: 100px">
                <asp:LinkButton ID="btnDeleteCampaign" runat="server" CssClass="btn btn-danger btn" UseSubmitBehavior="false" ToolTip="Delete Campaign" Visible="false">
                    <span class="glyphicon glyphicon-trash"></span> Delete
                </asp:LinkButton>
            </td>
        </tr>
    </table>


    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True"
            GroupingEnabled="False" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="100%" Height="1200px"
            PageSize="250" AllowPaging="True" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center">
            <ClientSettings Selecting-AllowRowSelect="true">
                <Scrolling AllowScroll="True"></Scrolling>
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" ShowFooter="True">
                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                <Columns>
                    <telerik:GridTemplateColumn Aggregate="Count" DataField="Name" FilterControlAltText="Filter Name column"
                        FooterAggregateFormatString="{0:N0}" HeaderText="Client Name" SortExpression="Name" UniqueName="Name">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditCli" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Client"
                                CommandName="EditClient" UseSubmitBehavior="false">
                                <%# Eval("Name")%>
                            </asp:LinkButton>
                            &nbsp; <%# Eval("Organization")%>
                        </ItemTemplate>

                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="nStatus" FilterControlAltText="Filter nStatus column" HeaderText="Status" SortExpression="nStatus" UniqueName="nStatus"
                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center" Exportable="true">
                        <ItemTemplate>
                            <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("nStatus")%>' ForeColor='<%# LocalAPI.ClientStatusColor(Eval("Status"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Availability" HeaderText="Availability" ItemStyle-HorizontalAlign="Center"
                        SortExpression="Availability" UniqueName="Availability" FilterControlAltText="Filter Availability column"
                        HeaderStyle-Width="100px">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkEditStatus" runat="server" CommandName="EditAvailability" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to edit Availability">
                                <span title="Clic to edit Availability" class="label label-<%# IIf(Eval("AvailabilityId") = 0, "success", IIf(Eval("AvailabilityId") = 1, "danger", "default")) %>"><%# Eval("Availability") %>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="nType" HeaderText="Type"
                        SortExpression="nType" UniqueName="nType" FilterControlAltText="Filter nType column"
                        HeaderStyle-Width="130px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="nSubtype" HeaderText="Subtype" Display="False"
                        SortExpression="nSubtype" UniqueName="nSubtype" FilterControlAltText="Filter nSubtype column">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ProposalAmount" HeaderText="#Prop." HeaderTooltip="Number of Proposals"
                        SortExpression="ProposalAmount" UniqueName="ProposalAmount" ItemStyle-HorizontalAlign="Right"
                        HeaderStyle-Width="70px"
                        Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JobAmount" HeaderText="#Jobs" FilterControlAltText="Filter JobAmount column"
                        SortExpression="JobAmount" UniqueName="JobAmount" ItemStyle-HorizontalAlign="center"
                        HeaderStyle-Width="70px"
                        Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TotalBudget" FilterControlAltText="Filter TotalBudget column" HeaderText="Budget" SortExpression="TotalBudget" UniqueName="TotalBudget"
                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}"
                        Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AmountDue" DataType="System.Double" FilterControlAltText="Filter AmountDue column" HeaderText="$Due" SortExpression="AmountDue" UniqueName="AmountDue"
                        HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}"
                        Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderTooltip="Amount Due ($)">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column" HeaderText="Email" SortExpression="Email" UniqueName="Email" ItemStyle-Font-Size="X-Small">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Phone" FilterControlAltText="Filter Phone column" HeaderText="Phone" SortExpression="Phone" UniqueName="Phone"
                        HeaderStyle-Width="90px" ItemStyle-Font-Size="X-Small">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Cellular" FilterControlAltText="Filter Cellular column" HeaderText="Cellular" SortExpression="Cellular" UniqueName="Cellular"
                        HeaderStyle-Width="90px" ItemStyle-Font-Size="X-Small">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>

        </telerik:RadGrid>

    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <telerik:RadToolTip ID="RadToolTipNewCampaign" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; width: 600px">
            <span class="label label-default center-block">Create New Marketing Campaign
            </span>
        </h2>
        <table class="table-condensed" style="width: 600px">
            <tr>
                <td>
                    <h3>Actions to create new marketing campaign</h3>
                    <ul>
                        <li>Pre-selection <b>List of Clients</b> with Filters and the <b>Search</b> button</li>
                        <li>Click <b>[+Campaign]</b>, open this Dialog</li>
                        <li>Define a <b>Campaign Name</b> to Identify the campaign</li>
                        <li>Click <b>[Create Campaign]</b> button</li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td style="padding-left: 25px">
                    <telerik:RadTextBox ID="txtCampaignName" runat="server" Width="100%" EmptyMessage="Type the Campaign Name...">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <hr />
                </td>
            </tr>
            <tr>
                <td style="text-align: center"><b>Are you ready to create a New Campaign?</b>
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <asp:LinkButton ID="btnConfirmCreate" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ToolTip="Create New Campaign">
                     Create Campaign
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipAvailability" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; width: 600px">
            <span class="label label-default center-block">Client Availability
            </span>
        </h2>
        <table class="table-condensed" style="width: 600px">
            <tr>
                <td style="width: 140px; text-align: right" class="Normal">New Availability:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboNewAvailability" runat="server" DataSourceID="SqlDataSourceAvailability" DataTextField="Name" DataValueField="Id"
                        Filter="Contains" MarkFirstMatch="True" Width="100%" ZIndex="50001">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnUpdateAvailability" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="100px">
                                    <span class="glyphicon glyphicon-ok"></span> Update
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <div style="height: 1px; overflow: auto">
        <telerik:RadGrid ID="RadGridExportData" runat="server" DataSourceID="SqlDataSource1" AllowPaging="True" PageSize="10">
            <MasterTableView DataSourceID="SqlDataSource1" AutoGenerateColumns="False">
                <Columns>
                    <telerik:GridBoundColumn DataField="Name" HeaderText="Client Name" UniqueName="Name">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Organization" HeaderText="Organization" UniqueName="Organization">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="nStatus" HeaderText="nStatus" UniqueName="nStatus">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Availability" HeaderText="Availability" UniqueName="Availability">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Email" HeaderText="Email" UniqueName="Email">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Phone" HeaderText="Phone" UniqueName="Phone">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Cellular" HeaderText="Cellular" UniqueName="Cellular">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ProposalAmount" HeaderText="#Prop" UniqueName="ProposalAmount">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JobAmount" HeaderText="#Jobs" UniqueName="JobAmount">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TotalBudget" HeaderText="Budget" UniqueName="TotalBudget" DataFormatString="{0:C2}">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AmountDue" HeaderText="$Due" UniqueName="AmountDue" DataFormatString="{0:C2}">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_Management_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="CLIENTS_Management_Marketing_INSERT" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="Status" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboTypes" Name="Type" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboSubtype" Name="Subtype" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboAmountDue" Name="Balance" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboAvailability" Name="AvailabilityId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="Status" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboTypes" Name="Type" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboSubtype" Name="Subtype" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboAmountDue" Name="Balance" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCampaignName" Name="MarketingCampaing" PropertyName="Text" Type="String" />
            <asp:Parameter Direction="InputOutput" Name="OUT_MarketingCampaingId" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Clients_types] WHERE ([companyId] = @companyId) ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientSubtypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Clients_Subtypes] Where typeId=@typeId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboTypes" Name="typeId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] + '. '+[Description] As Name FROM [Clients_status] ORDER BY Id"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceAvailability" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Clients_availability] ORDER BY Id"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCampaing" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select Id, Name from Clients_MarketingCampaign where companyId=@companyId order by Name"
        DeleteCommand="DELETE FROM Clients_MarketingCampaign WHERE Id=@Id">
        <DeleteParameters>
            <asp:ControlParameter ControlID="cboCampaing" Name="Id" PropertyName="SelectedValue" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblClientSelectdId" runat="server" Text="0" Visible="False"></asp:Label>
</asp:Content>
