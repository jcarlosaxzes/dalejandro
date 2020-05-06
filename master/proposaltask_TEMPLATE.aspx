<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="proposaltask_TEMPLATE.aspx.vb" Inherits="pasconcept20.proposaltask_TEMPLATE" %>

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

                                <telerik:GridTemplateColumn DataField="taskcode" FilterControlAltText="Filter taskcode column"
                                    HeaderText="taskcode" SortExpression="taskcode" UniqueName="taskcode" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="100px">
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="taskcodeTextBox" runat="server" Text='<%# Bind("taskcode") %>' MaxLength="80"
                                            Width="700px">
                                        </telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="taskcodeTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="taskcodeLabel0" runat="server" Text='<%# Eval("taskcode")%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                                    HeaderText="Name" SortExpression="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' MaxLength="80"
                                            Width="700px">
                                        </telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DescriptionTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="DescriptionLabel0" runat="server" Text='<%# Eval("Description")%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn DataField="DescriptionPlus" Display="False" HeaderText="Description"
                                    SortExpression="DescriptionPlus" UniqueName="DescriptionPlus">
                                    <ItemTemplate>
                                        <asp:Label ID="DescriptionPlusLabel" runat="server" Text='<%# Eval("DescriptionPlus")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadEditor ID="gridEditor_Saludo" runat="server" Content='<%# Bind("DescriptionPlus")%>' Height="400px" AllowScripts="True" 
                                            Width="700px"
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
        DeleteCommand="DELETE FROM [Company_Proposal_tasks_TEMPLATE] WHERE [templateId] = @templateId"
        InsertCommand="INSERT INTO Company_Proposal_tasks_TEMPLATE(taskcode, Description, DescriptionPlus, companyType) VALUES (@taskcode, @Description, @DescriptionPlus, @companyType)"
        SelectCommand="MASTER_Proposal_Tasktemplates_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE Company_Proposal_tasks_TEMPLATE SET companyType=@companyType, taskcode = @taskcode, Description = @Description, DescriptionPlus=@DescriptionPlus WHERE (templateId = @templateId)">
        <DeleteParameters>
            <asp:Parameter Name="templateId" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="taskcode" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="DescriptionPlus" Type="String" />
            <asp:Parameter Name="companyType" Type="Int32" />
            <asp:Parameter Name="templateId" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="taskcode" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="DescriptionPlus" Type="String" />
            <asp:Parameter Name="companyType" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceCompanyTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Company_types ORDER BY Name"></asp:SqlDataSource>

</asp:Content>

