<%@ Page Title="Vendors" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="vendors.aspx.vb" Inherits="pasconcept20.vendors" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNewVendor">
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
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <div class="Formulario">
        <table class="table-condensed">
            <tr>
                <td>
                    <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                        <span class="glyphicon glyphicon-filter"></span>&nbsp;Filter
                    </button>
                </td>
                <td>
                    <asp:LinkButton ID="btnNewVendor" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    <span class="glyphicon glyphicon-plus"></span> Vendor
                    </asp:LinkButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnprint" OnClientClicked="PrintPage" Text="Print Page" runat="server" AutoPostBack="false" UseSubmitBehavior="false">
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
                <table class="table-condensed">
                    <tr>
                        <td >
                            <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="600px"
                                EmptyMessage="Search for Name, Company... ">
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
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                function OnClientClose(sender, args) {
                    var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                    masterTable.rebind();
                }
            </script>
        </telerik:RadCodeBlock>
        <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" AllowAutomaticDeletes="true"
            DataSourceID="SqlDataSource1" GridLines="None" AllowPaging="True" PageSize="250" Height="700px"
            CellSpacing="0" AllowSorting="True" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" CommandItemDisplay="None" ShowFooter="True" EditMode="PopUp">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridTemplateColumn Aggregate="Count" DataField="Name" FilterControlAltText="Filter Name column"
                        FooterAggregateFormatString="{0:N0}" HeaderText="Name & Company" SortExpression="Name"
                        UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div>
                                <strong>
                                    <asp:LinkButton ID="btnEditVendor" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Vendor"
                                        CommandName="EditVendor" Text='<%# Eval("Name")%>' UseSubmitBehavior="false">
                                    </asp:LinkButton>
                                </strong>
                            </div>
                            <b><%# Eval("Company")%></b> &nbsp;&nbsp;&nbsp;<%# Eval("Position") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="VendorType" FilterControlAltText="Filter VendorType column" HeaderText="Vendor Type" SortExpression="VendorType" UniqueName="VendorType">
                        <ItemTemplate>
                            <%# Eval("VendorType") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Address" FilterControlAltText="Filter Address column"
                        HeaderText="Address" SortExpression="Address" UniqueName="Address" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div><a class="lnkGrid" href="http://maps.google.com/?q=<%# Eval("FullAddress")%>" target="_blank" title="view google vendor address"><%# Eval("FullAddress")%></a></div>
                            <%# String.Concat(Eval("Phone"), " ", Eval("Cellular"))%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Email" FilterControlAltText="Filter Email column"
                        HeaderText="Email & Web" SortExpression="Email" UniqueName="Email" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="250px">
                        <ItemTemplate>
                             <div><a href='<%# string.Concat("mailto:",Eval("Email")) %>' title="Mail to"><%#Eval("Email") %></a></div>
                            <a class="lnkGrid" href='<%# Eval("Web")%>' target="_blank" title="View web"><%#Eval("Web")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this Vendor?" ConfirmTitle="Delete"
                        ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                        HeaderText="" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings>
                    <PopUpSettings Modal="true" Width="800px" />
                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                    </EditColumn>
                </EditFormSettings>

            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Vendors_SELECT" SelectCommandType="StoredProcedure" 
        DeleteCommand="Vendor_DELETE" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter"
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelected" runat="server" Visible="False"></asp:Label>
</asp:Content>
