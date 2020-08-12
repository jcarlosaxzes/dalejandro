<%@ Page Title="Messages" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="messages.aspx.vb" Inherits="pasconcept20.messages" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />--%>
    <style>
        .RadGrid td {
            word-wrap: break-word;
            word-break: break-all;
        }
    </style>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Email History Log</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
        </span>
    </div>

    <div class="collapse" id="collapseFilter">
        <table style="width: 100%">
            <tr>
                <td class="PanelFilter">
                    <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                        <table class="table-sm pasconcept-bar" style="width: 100%">
                            <tr>
                                <td>
                                    <telerik:RadComboBox ID="cboTimeFrame" runat="server" AppendDataBoundItems="false" Width="200px">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="All Years" Value="1" />
                                            <telerik:RadComboBoxItem runat="server" Text="Last Year" Value="2" />
                                            <telerik:RadComboBoxItem runat="server" Text="This Year" Value="3" />
                                            <telerik:RadComboBoxItem runat="server" Text="Last Quarter" Value="4" />
                                            <telerik:RadComboBoxItem runat="server" Text="This Quarter" Value="5" />
                                            <telerik:RadComboBoxItem runat="server" Text="Last Month" Value="6" />
                                            <telerik:RadComboBoxItem runat="server" Text="This Month" Value="7" />
                                            <telerik:RadComboBoxItem runat="server" Text="Last 30 Days" Value="8" Selected="true"/>
                                            <telerik:RadComboBoxItem runat="server" Text="Last 15 Days" Value="9" />
                                            <telerik:RadComboBoxItem runat="server" Text="Last 7 Days" Value="10" Selected="true" />
                                            <telerik:RadComboBoxItem runat="server" Text="Last  Day" Value="11" />
                                            <telerik:RadComboBoxItem runat="server" Text="ToDay" Value="12" />
                                        </Items>
                                    </telerik:RadComboBox>

                                    <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient" AutoPostBack="false"
                                        DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Width="300px" Height="300px"
                                        AppendDataBoundItems="true">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Client...)" Value="-1" Selected="true" />
                                        </Items>
                                    </telerik:RadComboBox>

                                    <telerik:RadTextBox ID="txtFind" runat="server" EmptyMessage="Search From, To, Subject or Body..." Width="300px">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 150px; text-align: right">
                                    <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                            <i class="fas fa-search"></i> Filter/Search
                                    </asp:LinkButton>

                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSourceMessages" Width="100%" AutoGenerateColumns="False" AllowSorting="True"
            AllowPaging="True" PageSize="50" Height="800px"
            HeaderStyle-HorizontalAlign="Center">
            <ClientSettings>
                <Scrolling AllowScroll="True"></Scrolling>
            </ClientSettings>
            <MasterTableView DataSourceID="SqlDataSourceMessages">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridTemplateColumn DataField="To" HeaderText="From/To/Date/Subject" SortExpression="To" UniqueName="To" HeaderStyle-Width="350px" ItemStyle-Width="150px" ItemStyle-Wrap="true" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td>
                                        <b>From:</b> <%# Eval("From")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>To:</b> <%# Eval("To")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%# Eval("Received")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b><%# Eval("Subject")%></b>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Body" HeaderText="Body" SortExpression="Body" UniqueName="Body" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
     <asp:SqlDataSource ID="SqlDataSourceMessages" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Messages_v20_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" PropertyName="Text" Name="Filter" Type="String" ConvertEmptyStringToNull="False" />
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="jobId" DefaultValue="0" Type="Int32" />
            <asp:ControlParameter ControlID="cboTimeFrame" Name="TimeFrameId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDelete" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM Messages_Addressees WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="lblSelectedMessage" Name="Id" PropertyName="Text" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_for_Files_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblSelectedMessage" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
</asp:Content>
