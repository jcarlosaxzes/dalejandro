<%@ Page Title="Setting Status" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="settingstatus.aspx.vb" Inherits="pasconcept20.settingstatus" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <div class="card card-body">
        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnFind">
            <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                <table class="table-condensed Formulario" style="width: 100%">
                    <tr>
                        <td style="text-align: right; width: 100px">Group:
                        </td>
                        <td style="width: 300px">
                            <telerik:RadComboBox ID="cboGroup" runat="server" MarkFirstMatch="True" Filter="Contains" Width="100%" AppendDataBoundItems="True">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(All Groups…)" Value="-1" />
                                    <telerik:RadComboBoxItem Text="Company" Value="Company" />
                                    <telerik:RadComboBoxItem Text="Employees" Value="Employees" />
                                    <telerik:RadComboBoxItem Text="Timesheet" Value="Timesheet" />
                                    <telerik:RadComboBoxItem Text="Payroll" Value="Payroll" />
                                    <telerik:RadComboBoxItem Text="Departments" Value="Departments" />
                                    <telerik:RadComboBoxItem Text="Clients" Value="Clients" />
                                    <telerik:RadComboBoxItem Text="Proposals" Value="Proposals" />
                                    <telerik:RadComboBoxItem Text="Jobs" Value="Jobs" />
                                    <telerik:RadComboBoxItem Text="Calendar" Value="Calendar" />
                                    <telerik:RadComboBoxItem Text="SubConsultants" Value="SubConsultants" />
                                    <telerik:RadComboBoxItem Text="Expenses" Value="Expenses" />
                                    
                                </Items>
                            </telerik:RadComboBox>
                        </td>

                        <td style="text-align: right; width: 100px">Status:
                        </td>
                        <td style="width: 300px">
                            <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" MarkFirstMatch="True">
                                <Items>
                                    <telerik:RadComboBoxItem Text="(All status)" Value="-1" Selected="true" />
                                    <telerik:RadComboBoxItem Text="Poor" Value="0" />
                                    <telerik:RadComboBoxItem Text="Fair" Value="1" />
                                    <telerik:RadComboBoxItem Text="Excellent" Value="2" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td style="text-align: right">
                            <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-search"></span> Search
                            </asp:LinkButton>

                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </asp:Panel>
    </div>

    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" AllowAutomaticDeletes="true"
            DataSourceID="SqlDataSource1" Height="700px" HeaderStyle-HorizontalAlign="Center"
            CellSpacing="0" AllowSorting="True">
            <ClientSettings>
                <Scrolling AllowScroll="True"></Scrolling>
            </ClientSettings>
            <MasterTableView DataSourceID="SqlDataSource1">
                <Columns>
                    <telerik:GridBoundColumn DataField="Group" HeaderText="Group" SortExpression="Group" UniqueName="Group" HeaderStyle-Width="300px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Entity -- Page Link" UniqueName="Entity" HeaderTooltip="Entity" >
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td>
                                        <%# Eval("Entity")%>
                                    </td>
                                    <td style="width: 24px; text-align: center">
                                        <a href='<%# Eval("URL")%>' target="_blank" title="View Page">
                                            <span class="glyphicon glyphicon-share"></span></a>
                                        </a>
                                    </td>
                                </tr>
                            </table>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Amount" HeaderText="# Records" SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <%# Eval("Amount", "{0:N0}")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Status" HeaderText="Status" SortExpression="Status" UniqueName="Status" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                        <span class='<%# LocalAPI.GetSettingStatusCSS(Eval("Status")) %>'><%# Eval("Status") %></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>

        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CompanySettingStatus_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboGroup" Name="Group" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboStatus" Name="StatusId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
