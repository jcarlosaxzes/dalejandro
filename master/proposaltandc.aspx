<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="proposaltandc.aspx.vb" Inherits="pasconcept20.proposaltandc" %>

<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
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
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
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
                    <div class="ToolButtom noprint" style="text-align: left">
                        <telerik:RadButton ID="btnNew" runat="server" Text="Add New Template">
                            <Icon PrimaryIconCssClass="rbAdd" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
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
                                popUp.style.top = 25 + "px";
                            }
                        </script>
                    </telerik:RadCodeBlock>
                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                        AllowAutomaticInserts="True" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                        Width="100%" AutoGenerateColumns="False" CellSpacing="0" AllowPaging="True" AllowSorting="True" PageSize="25">
                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                        <ClientSettings>
                            <ClientEvents OnPopUpShowing="PopUpShowing" />
                        </ClientSettings>
                        <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="templateId" EditMode="PopUp">
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                    HeaderText="Edit" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridEditCommandColumn>

                                <telerik:GridTemplateColumn DataField="companyType" FilterControlAltText="Filter companyType column"
                                    HeaderText="Company Type" SortExpression="CompanyTypeName" UniqueName="companyType" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="180px">
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="cbotypeId" runat="server" DataSourceID="SqlDataSourceCompanyTypes"
                                            DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("companyType")%>'
                                            Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="CompanyTypeNameLabel0" runat="server" Text='<%# Eval("CompanyTypeName")%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column"
                                    HeaderText="Name" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80"
                                            Width="700px">
                                        </telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Name")%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn DataField="Descripction" Display="False" HeaderText="Terms &amp; Conditions"
                                    SortExpression="Descripction" UniqueName="Descripction">
                                    <ItemTemplate>
                                        <asp:Label ID="DescripctionLabel" runat="server" Text='<%# Eval("Descripction")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadEditor ID="gridEditor_Saludo" runat="server" Content='<%# Bind("Descripction")%>' Height="400px" AllowScripts="True" Width="700px"
                                            ToolbarMode="Default" ToolsFile="~/BasicTools.xml" EditModes="All">
                                        </telerik:RadEditor>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this template?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings>
                                <PopUpSettings Modal="true" Width="850px" />
                                <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </Content>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Company_Proposal_TandC_TEMPLATE] WHERE [templateId] = @templateId"
        InsertCommand="INSERT INTO Company_Proposal_TandC_TEMPLATE(Name, Descripction, companyType) VALUES (@Name, @Descripction, @companyType)"
        SelectCommand="MASTER_Proposal_TandCtemplates_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE Company_Proposal_TandC_TEMPLATE SET companyType=@companyType, Name = @Name, Descripction = @Descripction WHERE (templateId = @templateId)">
        <DeleteParameters>
            <asp:Parameter Name="templateId" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Descripction" Type="String" />
            <asp:Parameter Name="companyType" Type="Int32" />
            <asp:Parameter Name="templateId" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Descripction" Type="String" />
            <asp:Parameter Name="companyType" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceCompanyTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Company_types ORDER BY Name"></asp:SqlDataSource>

</asp:Content>
