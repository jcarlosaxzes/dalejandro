<%@ Page Title="Miscellaneous Time Codes" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="nojobstimetypes.aspx.vb" Inherits="pasconcept20.nojobstimetypes" %>

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
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"  EnableEmbeddedSkins="false" />

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Non-Productive Time Categories</span>

        <span style="float: right; vertical-align: middle;">
            <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    Add Category
            </asp:LinkButton>

        </span>
    </div>

    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1"
            GridLines="None" AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
            AllowAutomaticUpdates="True" AllowSorting="True" CellSpacing="0" AllowPaging="True" PageSize="25"
            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                        HeaderText="" HeaderStyle-Width="50px">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="Id" HeaderText="ID" SortExpression="Id" UniqueName="Id" HeaderStyle-Width="80px"
                        HeaderStyle-HorizontalAlign="Center" Display="false" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Name" HeaderText="Code Name" SortExpression="Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left"
                        UniqueName="Name">
                        <EditItemTemplate>
                            <div style="margin: 5px">
                                <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80" Width="600px"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                            </div>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                        </ItemTemplate>

                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this Code?" ConfirmTitle="Delete"
                        ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                        HeaderText="" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px"
                        ItemStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings>
                    <PopUpSettings Modal="true" Width="600px" />
                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [NonRegularHours_types] WHERE companyId=@companyId AND [Id] = @Id"
        InsertCommand="NonRegularHours_types_INSERT" InsertCommandType="StoredProcedure"
        SelectCommand="SELECT [Id], [Name] FROM [NonRegularHours_types]  WHERE companyId=@companyId ORDER BY [Id]"
        UpdateCommand="UPDATE [NonRegularHours_types] SET [Name] = @Name WHERE companyId=@companyId AND [Id] = @Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Id" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId"
                PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
