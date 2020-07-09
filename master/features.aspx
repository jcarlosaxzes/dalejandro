<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="features.aspx.vb" Inherits="pasconcept20.features" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%">
        <tr>
            <td class="ToolButtom noprint">
                Insert only features NO AVAILABLES by version<br />
                <br />
                <telerik:RadButton ID="btnNew" runat="server" Text="Add Feature">
                    <Icon PrimaryIconCssClass="rbAdd" PrimaryIconLeft="4"  PrimaryIconTop="4"></Icon>
                </telerik:RadButton>
                <br />
                <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; versionId values:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 = PROFESSIONAL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 = GROW,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 = PREMIUM</b>
            </td>
        </tr>
        <tr>
            <td width="100%">
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                    AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
                    AllowAutomaticUpdates="True" AllowPaging="True" PageSize="100" AllowSorting="True" CellSpacing="0">
                    <ExportSettings>
                        <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                            PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in" />
                    </ExportSettings>
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                        <PagerStyle Mode="Slider" AlwaysVisible="false"   />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                HeaderText="Edit" ItemStyle-Width="30px">
                                <ItemStyle Width="20px"></ItemStyle>
                            </telerik:GridEditCommandColumn>
                            <telerik:GridTemplateColumn DataField="Id"
                                FilterControlAltText="Filter Id column" HeaderText="Id" SortExpression="Id" UniqueName="Id" ReadOnly="true" ItemStyle-Width="30px">
                                <ItemTemplate>
                                    <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="versionId"
                                FilterControlAltText="Filter versionId column" HeaderText="versionId" SortExpression="versionId" UniqueName="versionId" ItemStyle-Width="30px">
                                <EditItemTemplate>
                                    <telerik:RadTextBox ID="versionIdTextBox" runat="server" Text='<%# Bind("versionId") %>' MaxLength="1"></telerik:RadTextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="versionIdLabel" runat="server" Text='<%# Eval("versionId") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="caracteristicaId"
                                FilterControlAltText="Filter caracteristicaId column" HeaderText="caracteristicaId" SortExpression="caracteristicaId" UniqueName="caracteristicaId" ItemStyle-Width="30px">
                                <EditItemTemplate>
                                    <telerik:RadTextBox ID="caracteristicaIdTextBox" runat="server" Text='<%# Bind("caracteristicaId") %>'></telerik:RadTextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="caracteristicaIdLabel" runat="server" Text='<%# Eval("caracteristicaId") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Caracteristica"
                                FilterControlAltText="Filter Caracteristica column" HeaderText="Feature name"
                                SortExpression="Caracteristica" UniqueName="Caracteristica">
                                <EditItemTemplate>
                                    <telerik:RadTextBox ID="CaracteristicaTextBox" runat="server" Text='<%# Bind("Caracteristica") %>' MaxLength="80" Width="600px"></telerik:RadTextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="CaracteristicaLabel" runat="server" Text='<%# Eval("Caracteristica") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridButtonColumn>
                        </Columns>
                        <CommandItemSettings AddNewRecordText="Add Feature" />
                        <ExpandCollapseColumn Resizable="False" Visible="False">
                            <HeaderStyle Width="20px" />
                        </ExpandCollapseColumn>
                        <RowIndicatorColumn Visible="False">
                            <HeaderStyle Width="20px" />
                        </RowIndicatorColumn>
                        <EditFormSettings CaptionDataField="Caracteristica" CaptionFormatString="Edit {0}">
                            <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                            <FormMainTableStyle GridLines="None" CellSpacing="0" CellPadding="3" BackColor="White"
                                Width="100%" />
                            <FormTableStyle CellSpacing="0" CellPadding="2" BackColor="White" />
                            <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                            <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1"
                                CancelText="Cancel">
                            </EditColumn>
                            <FormTableButtonRowStyle HorizontalAlign="Left" CssClass="EditFormButtonRow"></FormTableButtonRowStyle>
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
        DeleteCommand="DELETE FROM sys_Vesriones_CaractristicasNoPermitidas WHERE (Id = @Id)"
        InsertCommand="INSERT INTO sys_Vesriones_CaractristicasNoPermitidas([versionId],[CaracteristicaId],[Caracteristica]) VALUES(@versionId,@CaracteristicaId,@Caracteristica)"
        SelectCommand="SELECT [Id],[versionId],[CaracteristicaId],[Caracteristica] FROM sys_Vesriones_CaractristicasNoPermitidas Order By CaracteristicaId, versionId"
        UpdateCommand="UPDATE sys_Vesriones_CaractristicasNoPermitidas SET [versionId] = @versionId,[CaracteristicaId] = @CaracteristicaId,[Caracteristica]=@Caracteristica WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>

        <InsertParameters>
            <asp:Parameter Name="versionId" />
            <asp:Parameter Name="CaracteristicaId" />
            <asp:Parameter Name="Caracteristica" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="versionId" />
            <asp:Parameter Name="CaracteristicaId" />
            <asp:Parameter Name="Caracteristica" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>

    </asp:SqlDataSource>
</asp:Content>


