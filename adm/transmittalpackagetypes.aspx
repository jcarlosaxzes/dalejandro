<%@ Page Title="Package Types" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="transmittalpackagetypes.aspx.vb" Inherits="pasconcept20.transmittalpackagetypes" %>

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
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
    <table class="table-condensed noprint" style="width:100%">
        <tr>
            <td class="ToolButtom noprint">
                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Add New Package Type">
                     <i class="fas fa-plus"></i> Package Type
                </asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                    AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
                    AllowAutomaticUpdates="True" AllowPaging="True" PageSize="25" AllowSorting="True" CellSpacing="0">
                    <ExportSettings>
                        <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                            PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in" />
                    </ExportSettings>
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                HeaderText="Edit" ItemStyle-Width="30px">
                            </telerik:GridEditCommandColumn>
                            <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name"
                                SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                                <EditItemTemplate>
                                    <div style="margin: 5px">
                                        <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80" Width="400px"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                    </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridButtonColumn>
                        </Columns>
                        <EditFormSettings>
                            <PopUpSettings Modal="true" Width="600px" />
                            <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                    </HeaderContextMenu>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM Transmittals_package_types WHERE (Id = @Id)"
        InsertCommand="INSERT INTO Transmittals_package_types(companyId, Name) VALUES (@companyId, @Name)"
        SelectCommand="SELECT Id, Name FROM Transmittals_package_types WHERE (companyId = @companyId) ORDER BY Name"
        UpdateCommand="UPDATE Transmittals_package_types SET Name = @Name WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Name="Name" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

