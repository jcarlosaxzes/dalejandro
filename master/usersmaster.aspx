<%@ Page Title="Master/Prime Users" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="usersmaster.aspx.vb" Inherits="pasconcept20.usersmaster" %>

<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>PASconcept Master/Prime Users</h3>
    <table class=" table-sm pasconcept-bar" style="width: 100%">
        <tr>
            <td style="width: 350px">
                <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" AppendDataBoundItems="true" AutoPostBack="true">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="Active" Value="0" Selected="true" />
                        <telerik:RadComboBoxItem runat="server" Text="Inactive" Value="1" />
                        <telerik:RadComboBoxItem runat="server" Text="(All Active/Inactive...)" Value="-1" />
                    </Items>
                </telerik:RadComboBox>
            </td>
            <td>
                <asp:LinkButton ID="btnExport" runat="server" ToolTip="Export records to Excel"
                    CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                    <i class="fas fa-download"></i> Export
                </asp:LinkButton>

            </td>
        </tr>
    </table>
    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceMasterUsers" AllowPaging="True"
            AllowSorting="True" PageSize="25"
            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center"
            AllowMultiRowSelection="True" Height="1000px">

            <ClientSettings Selecting-AllowRowSelect="true">
                <Scrolling AllowScroll="True"></Scrolling>
            </ClientSettings>

            <MasterTableView DataKeyNames="companyId" DataSourceID="SqlDataSourceMasterUsers" CommandItemDisplay="None" ShowFooter="True" HeaderStyle-Font-Size="Small">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridBoundColumn DataField="companyId" HeaderText="ID" SortExpression="companyId" UniqueName="companyId">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ContactName" HeaderText="Contact Name" SortExpression="ContactName" UniqueName="ContactName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Company" HeaderText="Company" SortExpression="Company" UniqueName="Company">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ContactEmail" HeaderText="Email" SortExpression="ContactEmail" UniqueName="ContactEmail">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ContactPhone" HeaderText="Phone" SortExpression="ContactPhone" UniqueName="ContactPhone">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Status" HeaderText="Status" SortExpression="Status" UniqueName="Status">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>

        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceMasterUsers" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="MasterUsers_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboStatus" Name="statusId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
