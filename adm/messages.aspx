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
    <table style="width: 100%">
        <tr>
            <td class="PanelFilter">
                <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                    <table width="100%" class="Formulario">
                        <tr>
                            <td align="right" class="Normal" width="40px">Find:
                            </td>
                            <td align="center" width="410px">
                                <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="400px">
                                </telerik:RadTextBox>
                            </td>
                            <td>
                                <telerik:RadButton ID="btnFind" runat="server" Text="Search">
                                    <Icon PrimaryIconCssClass="rbSearch" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
                                </telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" Width="100%" AutoGenerateColumns="False" AllowSorting="True"
        AllowPaging="True" PageSize="50" Height="800px"
        HeaderStyle-HorizontalAlign="Center">
        <ClientSettings>
            <Scrolling AllowScroll="True"></Scrolling>
        </ClientSettings>
        <MasterTableView DataSourceID="SqlDataSource1">
            <PagerStyle Mode="Slider" AlwaysVisible="false" />
            <Columns>
                <telerik:GridTemplateColumn DataField="To" HeaderText="From/To/Date/Subject" SortExpression="To" UniqueName="To" HeaderStyle-Width="350px" ItemStyle-Width="150px" ItemStyle-Wrap="true" ItemStyle-VerticalAlign="Top">
                    <ItemTemplate>
                        <table class="table-condensed" style="width: 100%">
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Messages_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDelete" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM Messages_Addressees WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="lblSelectedMessage" Name="Id" PropertyName="Text" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblSelectedMessage" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
</asp:Content>
