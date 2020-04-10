<%@ Page Title="TandC templates" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="tandctemplates.aspx.vb" Inherits="pasconcept20.tandctemplates" %>
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
                    <div class="PanelFilter">
                        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                            <table style="width:100%" class="table-condensed Formulario">
                                <tr>
                                    <td style="width:100px">Find:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="100%" EmptyMessage="Find">
                                        </telerik:RadTextBox>
                                    </td>
                                    <td style="width:120px">
                                         <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                            <span class="glyphicon glyphicon-search"></span> Search
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                </Content>
            </telerik:LayoutRow>
            <telerik:LayoutRow>
                <Content>
                    <table class="table-condensed noprint">
                        <tr>
                            <td>
                                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Add New Proposal Template">
                                    <span class="glyphicon glyphicon-plus"></span> Template
                                </asp:LinkButton></td>
                        </tr>
                    </table>
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
                        <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="Id" >
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                    HeaderText=""  ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column"
                                    HeaderText="Name" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80"
                                            Width="800px">
                                        </telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Name")%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <%--<telerik:GridHTMLEditorColumn UniqueName="Descripction" SortExpression="Descripction" HeaderText="Terms &amp; Conditions"
                                DataField="Descripction" Display="False" >
                            </telerik:GridHTMLEditorColumn>--%>
                                <telerik:GridTemplateColumn DataField="Descripction" Display="False" HeaderText="Terms &amp; Conditions"
                                    SortExpression="Descripction" UniqueName="Descripction">
                                    <ItemTemplate>
                                        <asp:Label ID="DescripctionLabel" runat="server" Text='<%# Eval("Descripction")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadEditor ID="gridEditor_Saludo" runat="server" Content='<%# Bind("Descripction")%>' Height="400px" AllowScripts="True" Width="800px"
                                            ToolbarMode="Default" ToolsFile="~/BasicTools.xml" EditModes="All">
                                        </telerik:RadEditor>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this template?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings>
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
        DeleteCommand="DELETE FROM [Proposal_TandCtemplates] WHERE [Id] = @Id"
        InsertCommand="INSERT INTO Proposal_TandCtemplates(Name, Descripction, companyId) VALUES (@Name, @Descripction, @companyId)"
        SelectCommand="Proposal_TandCtemplates_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE Proposal_TandCtemplates SET Name = @Name, Descripction = @Descripction WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Descripction" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="PaymentsTextList" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Descripction" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
