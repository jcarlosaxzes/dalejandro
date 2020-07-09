﻿<%@ Page Title="NAICS US Codes" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="naics_us_codes.aspx.vb" Inherits="pasconcept20.naics_us_codes" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">NAICS US Codes</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
            <asp:LinkButton ID="btnTablePage" runat="server" CssClass="btn btn-info" Width="40px"
                UseSubmitBehavior="false" ToolTip="View NAICS Table View" Visible="false">
                            <i class="fas fa-align-justify"></i>
            </asp:LinkButton>
            <asp:LinkButton ID="btnTreePage" runat="server" CssClass="btn btn-info" Width="40px"
                UseSubmitBehavior="false" ToolTip="View NAICS Tree View" Visible="true">
                           <span class="fas fa-stream"></span>
            </asp:LinkButton>


        </span>
    </div>

    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">
            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 180px">
                        <telerik:RadComboBox ID="cboLeves" runat="server" Width="100%" CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                            <Localization AllItemsCheckedString="All Levels Checked" CheckAllString="Check All..." ItemsCheckedString="levels checked"></Localization>
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="Level 2" Value="2" Checked="true" />
                                <telerik:RadComboBoxItem runat="server" Text="Level 3" Value="3" Checked="true" />
                                <telerik:RadComboBoxItem runat="server" Text="Level 4" Value="4" Checked="true" />
                                <telerik:RadComboBoxItem runat="server" Text="Level 5" Value="5" Checked="true" />
                                <telerik:RadComboBoxItem runat="server" Text="Level 6" Value="6" Checked="true" />
                            </Items>

                        </telerik:RadComboBox>

                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtFind" runat="server" EmptyMessage="NAICS Code, Title" Width="100%">
                        </telerik:RadTextBox>
                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton runat="server" ID="btnRefresh" CssClass="btn btn-info">
                            <i class="fas fa-redo"></i> 
                             Refresh
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    <div>
        <telerik:RadTreeList ID="RadTreeListNaics" runat="server" DataSourceID="SqlDataSource1" Skin="Bootstrap"
            AutoGenerateColumns="False" ParentDataKeyNames="rootCode" DataKeyNames="Code" Visible="false"
            HeaderStyle-HorizontalAlign="Center">
            <Columns>
                <telerik:TreeListTemplateColumn DataField="Code" HeaderText="Code" UniqueName="Code" HeaderStyle-Width="150px" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="20px">
                    <ItemTemplate>
                        <span style='<%# Eval("fontstyle") %>'><%# Eval("Code") %></span>
                    </ItemTemplate>
                </telerik:TreeListTemplateColumn>
                <telerik:TreeListTemplateColumn DataField="Title" HeaderText="Title" UniqueName="Title" ItemStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <span class="label badge-primary"><%# Eval("Level") %></span>
                        &nbsp;
                        <span style='<%# Eval("fontstyle") %>'><%# Eval("Title") %></span>
                    </ItemTemplate>
                </telerik:TreeListTemplateColumn>

            </Columns>

        </telerik:RadTreeList>
        <telerik:RadGrid ID="RadGridNaics" runat="server" DataSourceID="SqlDataSource1" Skin="Bootstrap" Visible="true"
            AutoGenerateColumns="False" Culture="en-US" HeaderStyle-HorizontalAlign="Center" DataKeyNames="Code">

            <MasterTableView DataKeyNames="Code" DataSourceID="SqlDataSource1">
                <CommandItemSettings ShowAddNewRecordButton="false" />
                <Columns>
                    <telerik:GridTemplateColumn DataField="Code" HeaderText="Code" UniqueName="Code" HeaderStyle-Width="150px" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="20px">
                        <ItemTemplate>
                            <span style='<%# Eval("fontstyle") %>'><%# Eval("Code") %></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Title" HeaderText="Title" UniqueName="Title">
                        <ItemTemplate>
                            <span style="font-size: 16px" class="badge badge-secondary"><%# Eval("Level") %></span>
                            &nbsp;
                            <span style='<%# Eval("fontstyle") %>'><%# Eval("Title") %></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="NAICS_US_Codes_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" />
            <asp:Parameter Name="LevelIdIN_List" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>

</asp:Content>
