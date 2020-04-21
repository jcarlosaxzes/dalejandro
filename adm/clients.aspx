<%@ Page Title="Clients" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="clients.aspx.vb" Inherits="pasconcept20.clients" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="ImageClientPhoto" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lblSelected" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNewClient">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    </telerik:RadWindowManager>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }

            function PrintPage(sender, args) {
                window.print();
            }
        </script>
    </telerik:RadCodeBlock>
    <div class="Formulario">
        <table class="table-condensed">
            <tr>
                <td>
                    <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                        <span class="glyphicon glyphicon-filter"></span>&nbsp;Filter
                    </button>
                </td>
                <td>
                    <asp:LinkButton ID="btnNewClient" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    <span class="glyphicon glyphicon-plus"></span> Client
                    </asp:LinkButton>
                </td>
                <td>
                    <telerik:RadButton ID="printbutton" OnClientClicked="PrintPage" Text="Print Page" runat="server" AutoPostBack="false" UseSubmitBehavior="false">
                        <Icon PrimaryIconCssClass=" rbPrint"></Icon>
                    </telerik:RadButton>
                </td>
                <td>
                    <telerik:RadLinkButton ID="btnImport" runat="server" Text="Import Data" NavigateUrl="~/ADM/ImportData.aspx?source=Clients" ToolTip="Import records from CSV files" UseSubmitBehavior="false">
                        <Icon CssClass="rbUpload"></Icon>
                    </telerik:RadLinkButton>
                </td>
            </tr>
        </table>
    </div>

    <div class="collapse" id="collapseFilter">
        <div class="card card-body">
            <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                <table class="table-condensed" style="width: 100%">
                    <tr>
                        <td style="width: 180px">
                            <telerik:RadComboBox ID="cboStatus" runat="server" AppendDataBoundItems="True"
                                Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="Active Clients" Value="0" />
                                    <telerik:RadComboBoxItem runat="server" Text="(All Clients)" Value="-1" />
                                </Items>
                            </telerik:RadComboBox>

                        </td>
                        <td style="width: 400px">
                            <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="400px"
                                EmptyMessage="Search for Client Name, Organization, TAGS... ">
                            </telerik:RadTextBox>
                        </td>
                        <td>
                            <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-search"></span> Search
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </div>

    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" GridLines="None" AllowPaging="True"
            CellSpacing="0" AllowSorting="True" PageSize="25" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" CommandItemDisplay="None" ShowFooter="True" HeaderStyle-Font-Size="Small">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridTemplateColumn HeaderText="Photo" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                        <ItemTemplate>

                            <asp:LinkButton ID="btnEditClient2" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to Edit Client Photo"
                                CommandName="EditPhoto" UseSubmitBehavior="false">
                                <asp:Image ID="ImageClientPhoto" ImageUrl='<%# LocalAPI.GetClientPhotoURL(Eval("Id"))%>'
                                    runat="server" Width="45" Height="50" AlternateText='<%# Eval("Name", "{0} photo")%>'></asp:Image>
                            </asp:LinkButton>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn Aggregate="Count" DataField="Name" FilterControlAltText="Filter Name column"
                        FooterAggregateFormatString="{0:N0}" HeaderText="Name & Company" SortExpression="Name" ItemStyle-HorizontalAlign="Left"
                        UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div>
                                <asp:LinkButton ID="btnEditCli" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Client"
                                    CommandName="EditClient" Text='<%# Eval("Name")%>' UseSubmitBehavior="false">
                                </asp:LinkButton>
                                <span style="font-size: x-small"><%# Eval("Position") %></span>

                            </div>
                            <div>
                                <%# Eval("Company")%>
                                <span class="badge badge-important" title="Uploaded files"><%# LocalAPI.ClientFilesCount(Eval("Id"))  %></span>
                            </div>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Email" FilterControlAltText="Filter Email column"
                        HeaderText="Contact info -- Customer Rep." SortExpression="Email" UniqueName="Email" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div>
                                <a href='<%#String.Concat("mailto:", Eval("Email")) %>' title="Mail to"><%#Eval("Email") %></a>
                                <%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone"))%>&nbsp;&nbsp;&nbsp;<%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("Cellular"))%>
                                <a href='<%# Eval("Web")%>' target="_blank" title="View client web"><%#Eval("Web")%>
                           <div>
                            <small style="color:black"><%# Eval("SalesRep1")%></small>
                            
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="Type" FilterControlAltText="Filter Type column"
                        HeaderText="Client Type" SortExpression="Type" UniqueName="Type" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="180px" ItemStyle-Font-Size="Small">
                        <ItemTemplate>
                            <%# Eval("nType")%>
                            <%# Eval("nSubtype")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Activity" FilterControlAltText="Filter Activity column" ItemStyle-HorizontalAlign="Center"
                        HeaderText="Activity" SortExpression="Activity" UniqueName="Activity" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="90px" ItemStyle-Font-Size="Small">
                        <ItemTemplate>
                            <small><%# Eval("LastDateActivity", "{0:d}")%></small>
                            <br />
                            <small><%# Eval("EntityActivity")%></small>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="column" HeaderStyle-HorizontalAlign="Center"
                        HeaderStyle-Width="90px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="btnClone" runat="server" UseSubmitBehavior="false" ToolTip="Duplicate Client"
                                            CommandName="Duplicate" CommandArgument='<%# Eval("Id")%>'>
                                                <span class="glyphicon glyphicon-duplicate"></span></a>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <a href='<%# LocalAPI.GetSharedLink_URL(91, Eval("Id"))%>' target="_blank" title="View Client Portal">
                                            <span class="glyphicon glyphicon-share"></span></a>
                                        </a>
                                    </td>
                                    <td>
                                        <asp:LinkButton runat="server" ID="btnAzureStorage" CommandName="AzureUpload" CommandArgument='<%# Eval("Id") %>' ToolTip="Upload Files">
                                                <span aria-hidden="true" class="glyphicon glyphicon-cloud-upload"></span>                                                
                                        </asp:LinkButton>

                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this client and asociate user?" ConfirmTitle="Delete"
                        ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                        HeaderText="" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px"
                        ItemStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>

        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Client_DUPLICATE" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboStatus" Name="StatusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblSelected" Name="Id" PropertyName="Text" />
            <asp:Parameter Direction="InputOutput" Name="Id_OUT" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelected" runat="server" Visible="False"></asp:Label>
</asp:Content>
