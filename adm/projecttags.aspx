<%@ Page Title="Project Tags" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="projecttags.aspx.vb" Inherits="pasconcept20.projecttags" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
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
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />--%>
    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Project Tags</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>

            <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    Add Tag
            </asp:LinkButton>

        </span>
    </div>

    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 350px">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name"
                            DataValueField="Id" Width="100%">
                        </telerik:RadComboBox>

                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboCategory" runat="server" DataSourceID="SqlDataSourceCategoriesByDepartment"
                            DataTextField="Name" DataValueField="Id" Width="350px" AppendDataBoundItems="true">
                        </telerik:RadComboBox>

                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                            <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    <div>
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
            AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
            AllowAutomaticUpdates="True" AllowSorting="True" CellSpacing="0" Height="1000px"
            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <ClientSettings>
                <Scrolling AllowScroll="True"></Scrolling>
                <ClientEvents OnPopUpShowing="PopUpShowing" />
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderStyle-HorizontalAlign="Center"
                        HeaderText="" HeaderStyle-Width="40px">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridTemplateColumn DataField="Tag" ItemStyle-HorizontalAlign="Left"
                        FilterControlAltText="Filter Tag column" HeaderText="Tag" SortExpression="Tag" UniqueName="Tag" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="250px">
                        <EditItemTemplate>
                            <div style="margin: 5px">
                                <telerik:RadTextBox ID="TagTextBox" runat="server" Text='<%# Bind("Tag") %>' MaxLength="80" Width="600px"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TagTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                            </div>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="TagLabel0" runat="server" Text='<%# Eval("Tag") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="CategoryId" ItemStyle-HorizontalAlign="Center"
                        FilterControlAltText="Filter CategoryId column" HeaderText="Department Category" SortExpression="CategoryName" UniqueName="CategoryName" HeaderStyle-HorizontalAlign="Center">
                        <EditItemTemplate>
                            <div style="margin: 5px">
                                <telerik:RadComboBox ID="cboCategoryIn" runat="server" DataSourceID="SqlDataSourceCategoriesByDepartment"
                                    DataTextField="Name" DataValueField="Id" Width="300px" SelectedValue='<%# Bind("CategoryId") %>' AppendDataBoundItems="true">
                                </telerik:RadComboBox>
                            </div>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("CategoryName") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Description" ItemStyle-HorizontalAlign="Left"
                        FilterControlAltText="Filter Description column" HeaderText="Description" SortExpression="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center">
                        <EditItemTemplate>
                            <div style="margin: 5px">
                                <telerik:RadTextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' MaxLength="128" Width="600px"></telerik:RadTextBox>
                            </div>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="DescriptionLabel0" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Reference" ItemStyle-HorizontalAlign="Left" Display="false"
                        FilterControlAltText="Filter Reference column" HeaderText="Reference" SortExpression="Reference" UniqueName="Reference" HeaderStyle-HorizontalAlign="Center">
                        <EditItemTemplate>
                            <div style="margin: 5px">
                                <telerik:RadTextBox ID="ReferenceTextBox" runat="server" Text='<%# Bind("Reference") %>' MaxLength="255" Width="600px"></telerik:RadTextBox>
                            </div>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("Reference") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings>
                    <PopUpSettings Modal="true" Width="700px" Height="350px" />
                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
            <FilterMenu EnableImageSprites="False">
            </FilterMenu>
            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
            </HeaderContextMenu>
        </telerik:RadGrid>

    </div>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [prj_tags] WHERE [Id] = @Id"
        InsertCommand="prj_tags_INSERT" InsertCommandType="StoredProcedure"
        SelectCommand="prj_tags_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="prj_tags_UPDATE" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="String" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboCategory" Name="CategoryId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Tag" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" />
            <asp:Parameter Name="Reference" Type="String" />
            <asp:Parameter Name="CategoryId" Type="String" />
            <asp:Parameter Name="Id" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Tag" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" />
            <asp:Parameter Name="Reference" Type="String" />
            <asp:Parameter Name="CategoryId" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY Productive DESC, [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceCategoriesByDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="DepartmentCategories_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
