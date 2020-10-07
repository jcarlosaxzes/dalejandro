<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="Notifications.aspx.vb" Inherits="pasconcept20.Notifications" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Notifications</span>

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
                                            <telerik:RadComboBoxItem runat="server" Text="Send Date" Value="0"  Selected="true"/>
                                            <telerik:RadComboBoxItem runat="server" Text="All Years" Value="1" />
                                            <telerik:RadComboBoxItem runat="server" Text="Last Year" Value="2" />
                                            <telerik:RadComboBoxItem runat="server" Text="This Year" Value="3" />
                                            <telerik:RadComboBoxItem runat="server" Text="Last Quarter" Value="4" />
                                            <telerik:RadComboBoxItem runat="server" Text="This Quarter" Value="5" />
                                            <telerik:RadComboBoxItem runat="server" Text="Last Month" Value="6" />
                                            <telerik:RadComboBoxItem runat="server" Text="This Month" Value="7" />
                                            <telerik:RadComboBoxItem runat="server" Text="Last 30 Days" Value="8" />
                                            <telerik:RadComboBoxItem runat="server" Text="Last 15 Days" Value="9" />
                                            <telerik:RadComboBoxItem runat="server" Text="Last 7 Days" Value="10" />
                                            <telerik:RadComboBoxItem runat="server" Text="Last  Day" Value="11" />
                                            <telerik:RadComboBoxItem runat="server" Text="ToDay" Value="12" />
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


    <div class="pasconcept-bar">
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSourceNotifications" Width="100%" AutoGenerateColumns="False" AllowSorting="True"
            AllowAutomaticInserts="True" AllowAutomaticDeletes="True" AllowPaging="True" PageSize="50" Height="800px"
            HeaderStyle-HorizontalAlign="Center">
            <ClientSettings Selecting-AllowRowSelect="true">
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceNotifications">

                <Columns>
                    <telerik:GridBoundColumn DataField="Subject" HeaderStyle-Width="20%"
                        FilterControlAltText="Filter Name column" HeaderText="Subject"
                        SortExpression="Subject" UniqueName="Subject">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SendDate"
                        FilterControlAltText="Filter SendDate column" HeaderText="SendDate" HeaderStyle-Width="20%"
                        SortExpression="SendDate" UniqueName="SendDate">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Body"
                        FilterControlAltText="Filter Body column" HeaderText="Body" HeaderStyle-Width="60%"
                        SortExpression="Body" UniqueName="Body">
                    </telerik:GridBoundColumn>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                        HeaderText="" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>

    </div>

    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [FullName] as Name FROM [Employees] WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceNotifications" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Notifications_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="Notifications_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboTimeFrame" Name="TimeFrameId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" PropertyName="Text" Name="Filter" Type="String" ConvertEmptyStringToNull="False" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
