<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="invoicestypes.aspx.vb" Inherits="pasconcept20.invoicestypes" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
        <Rows>
            <telerik:LayoutRow>
                <Content>
                    <table class="table-condensed noprint">
                        <tr>
                            <td>
                                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Add New Schedule">
                                    <i class="fas fa-plus"></i> Schedule
                                </asp:LinkButton></td>
                            <td>
                                <script type="text/javascript">
                                    function PrintPage(sender, args) {
                                        window.print();
                                    }
                                </script>
                                <telerik:RadButton ID="printbutton" OnClientClicked="PrintPage" Text="Print Page" runat="server" AutoPostBack="false" UseSubmitBehavior="false">
                                    <Icon PrimaryIconCssClass=" rbPrint" PrimaryIconLeft="4"></Icon>
                                </telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                </Content>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Content>
                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                        AllowAutomaticInserts="True" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" HeaderStyle-HorizontalAlign="Center"
                        Width="100%" AutoGenerateColumns="False" CellSpacing="0" AllowPaging="True" PageSize="25"
                        AllowSorting="True"
                        HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                        <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="Id">
                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderText="" HeaderStyle-Width="50px">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column"
                                    HeaderText="Schedule Name" SortExpression="Name" UniqueName="Name">
                                    <EditItemTemplate>
                                        <div style="margin: 5px">
                                            <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' Width="800px"
                                                MaxLength="80" EmptyMessage="Insert billing name; e.g. 30%, 60%, 10%">
                                            </telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                        </div>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="BillingFrequency" FilterControlAltText="Filter BillingFrequency column"
                                    HeaderText="Billing Frequency" UniqueName="BillingFrequency" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Center">
                                    <EditItemTemplate>
                                        <div style="margin: 5px">
                                            <telerik:RadComboBox ID="cboBillingFrequency" runat="server" Width="400px" SelectedValue='<%# Bind("BillingFrequency") %>'>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text="(Not Defined...)" Value="" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Month" Value="month" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Quarter" Value="quarter" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Week" Value="week" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Day" Value="day" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </div>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="BillingFrequencyLabel0" runat="server" Text='<%# Eval("BillingFrequency") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="PaymentsScheduleList" FilterControlAltText="Filter PaymentsScheduleList column" Display="false"
                                    HeaderText="Values(comma-separated) List" SortExpression="PaymentsScheduleList" UniqueName="PaymentsScheduleList" HeaderStyle-Width="190px">
                                    <EditItemTemplate>
                                        <div style="margin: 5px">
                                            <telerik:RadTextBox ID="PaymentsScheduleListTextBox" runat="server" Text='<%# Bind("PaymentsScheduleList") %>' ToolTip="Insert billing percentages separated by commas(,)"
                                                Width="800px" MaxLength="255" EmptyMessage="Insert billing percentages separated by commas(,) e.g. 30,60,10">
                                            </telerik:RadTextBox>
                                        </div>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="PaymentsScheduleListLabel" runat="server" Text='<%# Eval("PaymentsScheduleList") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="PaymentsTextList" HeaderText="Descriptions(comma-separated) List" SortExpression="PaymentsTextList"
                                    UniqueName="PaymentsTextList" Display="false">
                                    <ItemTemplate>
                                        <asp:Label ID="PaymentsTextListLabel" runat="server" Text='<%# Eval("PaymentsTextList") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <div style="margin: 5px">
                                            <telerik:RadTextBox ID="PaymentsTextListTextBox" runat="server" Text='<%# Bind("PaymentsTextList") %>'
                                                Width="800px" TextMode="MultiLine" MaxLength="512" Rows="6" EmptyMessage="Insert descriptions of percentages separated by commas; e.g. Due at time of signed contract,Due at time of project submittal,Due at time of project approval"
                                                ToolTip="Insert descriptions of percentages separated by commas(,) e.g. Due at time of signed contract,Due at time of project submittal,Due at time of project approval">
                                            </telerik:RadTextBox>
                                        </div>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                    ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings>
                                <PopUpSettings Modal="true" Width="800px" />
                                <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                        </HeaderContextMenu>
                    </telerik:RadGrid>
                </Content>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Invoices_types] WHERE [Id] = @Id"
        InsertCommand="INSERT INTO Invoices_types(Name, PaymentsScheduleList, PaymentsTextList, companyId, BillingFrequency) VALUES (@Name, @PaymentsScheduleList, @PaymentsTextList, @companyId, @BillingFrequency)"
        SelectCommand="SELECT [Id],[Name],[PaymentsScheduleList],[PaymentsTextList],[companyId],isnull([BillingFrequency],'') As BillingFrequency FROM [Invoices_types] WHERE companyId=@companyId ORDER BY [Id]"
        UpdateCommand="UPDATE Invoices_types SET Name = @Name, PaymentsScheduleList = @PaymentsScheduleList, PaymentsTextList = @PaymentsTextList, BillingFrequency=@BillingFrequency WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="PaymentsScheduleList" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="PaymentsTextList" />
            <asp:Parameter Name="BillingFrequency" />

        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="PaymentsScheduleList" Type="String" />
            <asp:Parameter Name="PaymentsTextList" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Name="BillingFrequency" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
