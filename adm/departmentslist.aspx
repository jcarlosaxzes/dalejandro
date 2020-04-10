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
                            <span class="glyphicon glyphicon-plus"></span> Department
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
                    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                        <script type="text/javascript">
                            var popUp;
                            function PopUpShowing(sender, eventArgs) {
                                popUp = eventArgs.get_popUp();
                                var gridWidth = sender.get_element().offsetWidth;
                                var gridHeight = sender.get_element().offsetHeight;
                                var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("px"));
                                var popUpHeight = popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
                                popUp.style.left = ((gridWidth - popUpWidth) / 2 + sender.get_element().offsetLeft).toString() + "px";
                                popUp.style.top = 10 + "px";
                            }
                        </script>
                    </telerik:RadCodeBlock>
                    <div style="text-align: left">
                        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                            AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True" ShowFooter="true"
                            AllowAutomaticUpdates="True" AllowPaging="True" PageSize="25" AllowSorting="True" CellSpacing="0">
                            <ClientSettings>
                                <Scrolling AllowScroll="True"></Scrolling>
                                <ClientEvents OnPopUpShowing="PopUpShowing" />
                            </ClientSettings>
                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" EditMode="PopUp">
                                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                <Columns>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                        HeaderText="" HeaderStyle-Width="30px">
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridTemplateColumn DataField="Name" ItemStyle-HorizontalAlign="Left" Aggregate="Count" FooterAggregateFormatString="{0:N0}"
                                        FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="350px">
                                        <EditItemTemplate>
                                            <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80" Width="600px"></telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Code" ItemStyle-HorizontalAlign="Left"
                                        FilterControlAltText="Filter Code column" HeaderText="Code" SortExpression="Code" UniqueName="Code" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" Display="false">
                                        <EditItemTemplate>
                                            <telerik:RadTextBox ID="CodeTextBox" runat="server" Text='<%# Bind("Code") %>' MaxLength="32" Width="600px"></telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator554" runat="server" ControlToValidate="CodeTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <%# Eval("Code") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" Display="false"
                                        SortExpression="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                        <EditItemTemplate>
                                            <telerik:RadTextBox ID="DescriptionTextBox" runat="server" MaxLength="512" Width="600px" TextMode="MultiLine" Rows="4"
                                                Text='<%# Bind("Description") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="DescriptionLabel" runat="server"
                                                Text='<%# Eval("Description") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="Head" HeaderText="Empl. Head" SortExpression="Head" UniqueName="Head" HeaderTooltip="Employee Head"
                                        ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px">
                                        <ItemTemplate>
                                            <asp:Label ID="HeadLabel" runat="server" Text='<%# Eval("EmployeeHead")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadDropDownList runat="server" ID="HeadDepartmentDropDown" DataValueField="Id" Width="100%" DropDownHeight="250px"
                                                DataTextField="Name" DataSourceID="SqlDataSourceEmployees" AppendDataBoundItems="true" SelectedValue='<%# Bind("Head")%>'>
                                                <Items>
                                                    <telerik:DropDownListItem Text="(Select Department Head...)" Value="0" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>



                                    <telerik:GridTemplateColumn DataField="ParentID" HeaderText="Parent Dep." Display="false" SortExpression="ParentID" UniqueName="ParentID"
                                        ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="ParentIDLabel" runat="server" Text='<%# Eval("ParentID")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadDropDownList runat="server" ID="ParentIDDepartmentDropDown" DataValueField="Id" Width="100%" DropDownHeight="250px"
                                                DataTextField="Name" DataSourceID="SqlDataSourceDepartments" AppendDataBoundItems="true" SelectedValue='<%# Bind("ParentID")%>'>
                                                <Items>
                                                    <telerik:DropDownListItem Text="(Select Parent Department...)" Value="0" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridCheckBoxColumn DataField="Productive" DataType="System.Boolean" FilterControlAltText="Filter Productive column" HeaderText="Productive"
                                        SortExpression="Productive" UniqueName="Productive" ItemStyle-Width="30px" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                    </telerik:GridCheckBoxColumn>

                                    <telerik:GridTemplateColumn DataField="ProposalStatusTrackingEmail" FilterControlAltText="Filter ProposalStatusTrackingEmail column" HeaderText="Tracking Email"
                                        SortExpression="ProposalStatusTrackingEmail" UniqueName="ProposalStatusTrackingEmail" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" Display="false">
                                        <EditItemTemplate>
                                            <telerik:RadTextBox ID="ProposalStatusTrackingEmailTextBox" runat="server" MaxLength="128" Width="600px"
                                                Text='<%# Bind("ProposalStatusTrackingEmail") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="ProposalStatusTrackingEmailLabel" runat="server"
                                                Text='<%# Eval("ProposalStatusTrackingEmail") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="BillingContactName" FilterControlAltText="Filter BillingContactName column" HeaderText="Billing Contact Name"
                                        SortExpression="BillingContactName" UniqueName="BillingContactName" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" Display="false">
                                        <EditItemTemplate>
                                            <telerik:RadTextBox ID="BillingContactNameTextBox" runat="server" MaxLength="80" Width="600px"
                                                Text='<%# Bind("BillingContactName") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="BillingContactNameLabel" runat="server"
                                                Text='<%# Eval("BillingContactName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="BillingContactEmail" FilterControlAltText="Filter BillingContactEmail column" HeaderText="Billing Contact Email"
                                        SortExpression="BillingContactEmail" UniqueName="BillingContactEmail" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" Display="false">
                                        <EditItemTemplate>
                                            <telerik:RadTextBox ID="BillingContactEmailTextBox" runat="server" MaxLength="80" Width="600px"
                                                Text='<%# Bind("BillingContactEmail") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <%# Eval("BillingContactEmail") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="Members" FilterControlAltText="Filter Members column" HeaderText="Members" ReadOnly="true" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                                        SortExpression="Members" UniqueName="Members" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="TagCategoryLabel0" HeaderText="TagCategoryLabel0" UniqueName="TagCategoryLabel0" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TagCategoryLabel1" HeaderText="TagCategoryLabel1" UniqueName="TagCategoryLabel1" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TagCategoryLabel2" HeaderText="TagCategoryLabel2" UniqueName="TagCategoryLabel2" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TagCategoryLabel3" HeaderText="TagCategoryLabel3" UniqueName="TagCategoryLabel3" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TagCategoryLabel4" HeaderText="TagCategoryLabel4" UniqueName="TagCategoryLabel4" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TagCategoryLabel5" HeaderText="TagCategoryLabel5" UniqueName="TagCategoryLabel5" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TagCategoryLabel6" HeaderText="TagCategoryLabel6" UniqueName="TagCategoryLabel6" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TagCategoryLabel7" HeaderText="TagCategoryLabel7" UniqueName="TagCategoryLabel7" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TagCategoryLabel8" HeaderText="TagCategoryLabel8" UniqueName="TagCategoryLabel8" Display="false">
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
        InsertCommand="Company_Department_INSERT" InsertCommandType="StoredProcedure"
        SelectCommand="Company_Department_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Company_Department_UPDATE" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Code" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Head" />
            <asp:Parameter Name="ParentID" />
            <asp:Parameter Name="Productive" />
            <asp:Parameter Name="ProposalStatusTrackingEmail" />
            <asp:Parameter Name="BillingContactName" />
            <asp:Parameter Name="BillingContactEmail" />

            <asp:Parameter Name="TagCategoryLabel0" />
            <asp:Parameter Name="TagCategoryLabel1" />
            <asp:Parameter Name="TagCategoryLabel2" />
            <asp:Parameter Name="TagCategoryLabel3" />
            <asp:Parameter Name="TagCategoryLabel4" />
            <asp:Parameter Name="TagCategoryLabel5" />
            <asp:Parameter Name="TagCategoryLabel6" />
            <asp:Parameter Name="TagCategoryLabel7" />
            <asp:Parameter Name="TagCategoryLabel8" />

            <asp:Parameter Name="Id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Code" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Head" />
            <asp:Parameter Name="ParentID" />
            <asp:Parameter Name="Productive" />
            <asp:Parameter Name="BillingContactName" />
            <asp:Parameter Name="BillingContactEmail" />

            <asp:Parameter Name="TagCategoryLabel0" />
            <asp:Parameter Name="TagCategoryLabel1" />
            <asp:Parameter Name="TagCategoryLabel2" />
            <asp:Parameter Name="TagCategoryLabel3" />
            <asp:Parameter Name="TagCategoryLabel4" />
            <asp:Parameter Name="TagCategoryLabel5" />
            <asp:Parameter Name="TagCategoryLabel6" />
            <asp:Parameter Name="TagCategoryLabel7" />
            <asp:Parameter Name="TagCategoryLabel8" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Company_Department where companyId=@companyId Order By Name">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, FullName as Name from Employees where companyId=@companyId Order By FullName">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

