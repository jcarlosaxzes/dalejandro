<%@ Page Title="Billing Aging Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="billingagingreport.aspx.vb" Inherits="pasconcept20.billingagingreport" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" EnableEmbeddedSkins="false" />

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Clients Aging Report</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
           
            </button>

            <asp:LinkButton ID="btnExport" runat="server" ToolTip="Export records to Excel" Width="100px"
                CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                    <i class="fas fa-download"></i> Export
            </asp:LinkButton>


        </span>
    </div>


    <div class="collapse" id="collapseFilter">
        <table class="table-sm" style="width: 100%">
            <tr>

                <td style="width: 400px">
                    <telerik:RadComboBox ID="cboClients" runat="server" AppendDataBoundItems="true"
                        DataSourceID="SqlDataSourceClients" DataTextField="Name" DataValueField="Id" Filter="Contains"
                        Height="250px" MarkFirstMatch="True" Width="450px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Client...)" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <telerik:RadComboBox ID="cboDepartment" runat="server" DataSourceID="SqlDataSourceDepartments"
                        DataTextField="Name" DataValueField="Id" Width="350px" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="width: 150px; text-align: right">
                    <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                    </asp:LinkButton>
                </td>

            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
            AllowSorting="True" AllowPaging="True" PageSize="50" Skin="Bootstrap" HeaderStyle-HorizontalAlign="Center"
            CellSpacing="0" AutoGenerateColumns="False" Height="850px" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource1" ShowFooter="True">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>

                    <telerik:GridBoundColumn DataField="ClientName" HeaderText="Client Name" SortExpression="ClientName" UniqueName="ClientName"
                        Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Company" HeaderText="Company" SortExpression="Company" UniqueName="Company">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Total" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataFormatString="{0:N2}"
                        Aggregate="Sum" ItemStyle-HorizontalAlign="Right" FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="120px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="30D" HeaderText="30D" SortExpression="30D" UniqueName="30D" DataFormatString="{0:N2}"
                        Aggregate="Sum" ItemStyle-HorizontalAlign="Right" FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="120px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="60D" HeaderText="60D" SortExpression="60D" UniqueName="60D" DataFormatString="{0:N2}"
                        Aggregate="Sum" ItemStyle-HorizontalAlign="Right" FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="120px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="90D" HeaderText="90D" SortExpression="90D" UniqueName="90D" DataFormatString="{0:N2}"
                        Aggregate="Sum" ItemStyle-HorizontalAlign="Right" FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="120px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="90D+" HeaderText="90D+" SortExpression="90D+" UniqueName="90D+" DataFormatString="{0:N2}"
                        Aggregate="Sum" ItemStyle-HorizontalAlign="Right" FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="120px">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Billing_INVOICE AGING_REPORT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="cboDepartment" Name="departmentId" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClients" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

