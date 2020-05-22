<%@ Page Title="Contacts" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="contacts.aspx.vb" Inherits="pasconcept20.contacts" %>

<%@ Import Namespace="pasconcept20" %>
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
            <telerik:AjaxSetting AjaxControlID="btnNewContact">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNewClient">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNewSubconsultant">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cboContactType" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>


    <table style="width: 100%">
        <tr>
            <td class="PanelFilter">
                <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                    <table class="table-condensed Formulario" style="width: 100%">
                        <tr>
                            <td style="width: 100px">Contact Type:</td>
                            <td style="width: 400px">
                                <telerik:RadComboBox ID="cboContactType" runat="server" ToolTip="Select Contact types"
                                    Width="100%" CheckBoxes="true" Height="300px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains">
                                    <Localization AllItemsCheckedString="All Contact types Checked" CheckAllString="Check All..." ItemsCheckedString="Contact status checked"></Localization>
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Contacts" Value="1" Checked="true" />
                                        <telerik:RadComboBoxItem runat="server" Text="Clients" Value="2" Checked="false" />
                                        <telerik:RadComboBoxItem runat="server" Text="Employees" Value="3" Checked="true" />
                                        <telerik:RadComboBoxItem runat="server" Text="SubConsultants" Value="4" Checked="false" />
                                        <telerik:RadComboBoxItem runat="server" Text="Vendors" Value="5" Checked="false" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtFind" runat="server" EmptyMessage="Find (max. 50 records)..." Width="100%">
                                </telerik:RadTextBox>
                            </td>
                            <td style="width: 150px">
                                <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                    <span class="glyphicon glyphicon-search"></span> Search
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <div>
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="width: 80px">
                    <asp:LinkButton ID="btnNewClient" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    <span class="glyphicon glyphicon-plus"></span> Client
                    </asp:LinkButton>

                </td>
                <td style="width: 80px">
                    <asp:LinkButton ID="btnNewEmployee" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                            <span class="glyphicon glyphicon-plus"></span>&nbsp;Employee
                    </asp:LinkButton>

                </td>
                <td style="width: 80px">
                    <asp:LinkButton ID="btnNewSubconsultant" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    <span class="glyphicon glyphicon-plus"></span> SubConsultant
                    </asp:LinkButton>
                </td>
                <td style="width: 80px">
                    <asp:LinkButton ID="btnNewVendor" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    <span class="glyphicon glyphicon-plus"></span> Vendor
                    </asp:LinkButton>

                </td>
                <td style="width: 80px">
                    <asp:LinkButton ID="btnNewContact" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                        <span class="glyphicon glyphicon-plus"></span>&nbsp;Other
                    </asp:LinkButton>

                </td>
                <td></td>
                <td style="width: 80px">
                    <asp:LinkButton ID="btnImport" runat="server" CssClass="btn btn-default" UseSubmitBehavior="false" ToolTip="Import records from CSV files">
                                        <span class="glyphicon glyphicon-cloud-upload"></span>&nbsp;Import
                    </asp:LinkButton>
                </td>
                <td style="width: 80px">
                    <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-default" UseSubmitBehavior="false" ToolTip="Update records from CSV files">
                                        <span class="glyphicon glyphicon-saved"></span>&nbsp;Update
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
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

        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" ShowFooter="True" AutoGenerateColumns="False" AllowSorting="True"
            PageSize="50" AllowPaging="true" AllowAutomaticDeletes="True" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="680px" />
            </ClientSettings>
            <MasterTableView DataKeyNames="Id, ContactType" ClientDataKeyNames="Id" DataSourceID="SqlDataSource1" ShowFooter="True">
                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>

                <Columns>
                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Id" ReadOnly="True" Display="false" UniqueName="Id">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn Aggregate="Count" DataField="Name" FilterControlAltText="Filter Name column"
                        FooterAggregateFormatString="{0:N0}" HeaderText="Name & Organization" SortExpression="Name" ItemStyle-HorizontalAlign="Left"
                        UniqueName="Name2" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div>
                                <asp:LinkButton ID="btnEditContact" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Contact"
                                    CommandName='<%# Eval("ContactType")%>' Text='<%# Eval("Name") %>' UseSubmitBehavior="false">
                                </asp:LinkButton>
                                <%# Eval("Position")%>
                            </div>
                            <%# Eval("Company")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="nType" FilterControlAltText="Filter nType column"
                        HeaderText="Contact Type" SortExpression="nType" UniqueName="nType" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="250px">
                        <ItemTemplate>
                            <div>
                                <span class='<%# LocalAPI.GetContactClassLabelCSS(Eval("ContactTypeName")) %>'>
                                    <%# Eval("ContactTypeName")%>
                                </span>
                            </div>
                            <table>
                                <tr>
                                    <td>
                                        <%# Eval("nType")%>
                                    </td>
                                    <td>
                                        <%# Eval("nSubtype")%>
                                    </td>

                                </tr>
                            </table>

                            <br />

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Email" FilterControlAltText="Filter Email column"
                        HeaderText="Contact info" SortExpression="Email" UniqueName="Email" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div><a href='<%#String.Concat("mailto:", Eval("Email")) %>' title="Mail to"><%#Eval("Email") %></a></div>
                            <div>

                                <span class="glyphicon glyphicon-phone-alt "></span></a>
                                            <%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone"))%>
                                            &nbsp;
                                            <span class="glyphicon glyphicon-phone "></span></a>
                                            <%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("Cellular"))%>
                                <div>
                                    <a class="lnkGrid" href='<%# Eval("Web")%>' target="_blank" title="View client web"><%#Eval("Web")%>
                                </div>
                            </div>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Notes" FilterControlAltText="Filter Notes column"
                        HeaderText="Notes & Tags" SortExpression="Notes" UniqueName="Notes" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px">
                        <ItemTemplate>
                            <small><%# Eval("Notes")%>
                                <br />
                                <%# Eval("TAGS")%></small>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this Contact?" ConfirmTitle="Delete"
                        ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                        HeaderText="" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px"
                        ItemStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>

        </telerik:RadGrid>




    </div>



    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CONTACTS_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="CONTACT_DELETE" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ContactType" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:Parameter Name="IncludeContacts" Type="Boolean" />
            <asp:Parameter Name="IncludeClients" Type="Boolean" />
            <asp:Parameter Name="IncludeEmployees" Type="Boolean" />
            <asp:Parameter Name="IncludeSubConsultants" Type="Boolean" />
            <asp:Parameter Name="IncludeVendors" Type="Boolean" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelected" runat="server" Visible="False"></asp:Label>
</asp:Content>
