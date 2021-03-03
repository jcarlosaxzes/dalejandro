<%@ Page Title="Job Types" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="jobtypes.aspx.vb" Inherits="pasconcept20.jobtypes" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
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
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"  EnableEmbeddedSkins="false" />

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Job Types</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>

            <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    Add Type
            </asp:LinkButton>

        </span>
    </div>

    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 90%">
                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="100%" EmptyMessage="Find">
                        </telerik:RadTextBox>
                    </td>
                    <td style="text-align: right">
                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                            <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>

    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
            AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
            AllowAutomaticUpdates="True" AllowSorting="True" AllowPaging="True" PageSize="250" Height="1200px"
            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderText="" HeaderStyle-Width="50px">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridTemplateColumn DataField="Id" HeaderText="Code" SortExpression="Id" UniqueName="Id" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center">
                        <EditItemTemplate>
                            <div style="margin: 5px">
                                <telerik:RadTextBox ID="IdTextBox" runat="server" Text='<%# Bind("Id")%>' Width="100px" MaxLength="3" ToolTip="Up to 3 alphanumeric characters">
                                </telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="IdTextBox" CssClass="Error" Display="Dynamic" ErrorMessage="Code is mandatory. Up to 3 alphanumeric characters"></asp:RequiredFieldValidator>
                            </div>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id")%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" ItemStyle-HorizontalAlign="Left"
                        HeaderText="Description" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                        <EditItemTemplate>
                            <div style="margin: 5px">
                                <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' Width="600px"
                                    MaxLength="80">
                                </telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage="Name is mandatory"></asp:RequiredFieldValidator>
                            </div>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="FolderTemplate" FilterControlAltText="Filter FolderTemplate column" ItemStyle-HorizontalAlign="Left"
                        HeaderText="Folder" SortExpression="FolderTemplate" UniqueName="FolderTemplate" HeaderStyle-HorizontalAlign="Center">
                        <EditItemTemplate>
                            <div style="margin: 5px">
                                <telerik:RadTextBox ID="FolderTemplateTextBox" runat="server" Text='<%# Bind("FolderTemplate") %>' Width="600px"
                                    MaxLength="512" EmptyMessage="Optional...">
                                </telerik:RadTextBox>
                            </div>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="FolderTemplateLabel0" runat="server" Text='<%# Eval("FolderTemplate") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
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



    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Jobs_types] WHERE [Id] = @Id AND companyId=@companyId"
        InsertCommand="INSERT INTO Jobs_types(Id, Name, FolderTemplate, companyId) VALUES (@Id, @Name, @FolderTemplate, @companyId)"
        SelectCommand="Jobs_types_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE [Jobs_types] SET [Name] = @Name, FolderTemplate=@FolderTemplate WHERE [Id]=@Id AND companyId=@companyId">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="FolderTemplate" Type="String" />
            <asp:Parameter Name="Id" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Id" Type="String" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="FolderTemplate" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
