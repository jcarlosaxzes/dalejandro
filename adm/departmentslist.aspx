<%@ Page Title="Department List" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="departmentslist.aspx.vb" Inherits="pasconcept20.departmentslist" %>
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
                    <div style="text-align: left" class="Formulario noprint">
                        <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Add New Department">
                            <i class="fas fa-plus"></i> Department
                        </asp:LinkButton>

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <script type="text/javascript">
                            function PrintPage(sender, args) {
                                window.print();
                            }
                        </script>
                        <telerik:RadButton ID="printbutton" OnClientClicked="PrintPage" Text="Print Page" runat="server" AutoPostBack="false" UseSubmitBehavior="false">
                            <Icon PrimaryIconCssClass=" rbPrint"></Icon>
                        </telerik:RadButton>
                    </div>

                </Content>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Content>
                    <div style="text-align: left">
                        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                            AutoGenerateColumns="False" AllowAutomaticDeletes="True" ShowFooter="false"
                            AllowPaging="True" PageSize="25" AllowSorting="True" CellSpacing="0">
                            <ClientSettings>
                                <Scrolling AllowScroll="True"></Scrolling>
                            </ClientSettings>
                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" EditMode="PopUp">
                                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                <Columns>
                                    <telerik:GridTemplateColumn DataField="Name" ItemStyle-HorizontalAlign="Left" Aggregate="Count" FooterAggregateFormatString="{0:N0}"
                                        FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="350px">
                                        <ItemTemplate>
                                    <asp:LinkButton ID="btnEditTemplate" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Department"
                                        CommandName="EditDepartment">
                                                <%# Eval("Name")%>
                                    </asp:LinkButton>

                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Code" ItemStyle-HorizontalAlign="Left"
                                        FilterControlAltText="Filter Code column" HeaderText="Code" SortExpression="Code" UniqueName="Code" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" Display="false">
                                        <ItemTemplate>
                                            <%# Eval("Code") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" Display="false"
                                        SortExpression="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                                <%# Eval("Description") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="Head" HeaderText="Empl. Head" SortExpression="Head" UniqueName="Head" HeaderTooltip="Employee Head"
                                        ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px">
                                        <ItemTemplate>
                                            <%# Eval("EmployeeHead")%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="ParentID" HeaderText="Parent Dep." Display="false" SortExpression="ParentID" UniqueName="ParentID"
                                        ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%# Eval("ParentID")%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridCheckBoxColumn DataField="Productive" DataType="System.Boolean" FilterControlAltText="Filter Productive column" HeaderText="Productive"
                                        SortExpression="Productive" UniqueName="Productive" ItemStyle-Width="30px" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                    </telerik:GridCheckBoxColumn>

                                    <telerik:GridTemplateColumn DataField="ProposalStatusTrackingEmail" FilterControlAltText="Filter ProposalStatusTrackingEmail column" HeaderText="Tracking Email"
                                        SortExpression="ProposalStatusTrackingEmail" UniqueName="ProposalStatusTrackingEmail" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" Display="false">
                                        <ItemTemplate>
                                            <%# Eval("ProposalStatusTrackingEmail") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="BillingContactName" FilterControlAltText="Filter BillingContactName column" HeaderText="Billing Contact Name"
                                        SortExpression="BillingContactName" UniqueName="BillingContactName" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" Display="false">
                                        <ItemTemplate>
                                            <%# Eval("BillingContactName") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="BillingContactEmail" FilterControlAltText="Filter BillingContactEmail column" HeaderText="Billing Contact Email"
                                        SortExpression="BillingContactEmail" UniqueName="BillingContactEmail" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" Display="false">
                                        <ItemTemplate>
                                            <%# Eval("BillingContactEmail") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="Members" FilterControlAltText="Filter Members column" HeaderText="Members" ReadOnly="true" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                                        SortExpression="Members" UniqueName="Members" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
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
                </Content>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Department_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="Company_Departments_SELECT" SelectCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

