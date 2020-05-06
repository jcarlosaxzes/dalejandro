<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="disciplines.aspx.vb" Inherits="pasconcept20.disciplines" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%">
        <tr>
            <td class="ToolButtom noprint">
            <telerik:RadButton ID="btnNew" runat="server" Text="Add New Discipline">
                <Icon PrimaryIconCssClass="rbAdd" PrimaryIconLeft="4"  PrimaryIconTop="4"></Icon>
            </telerik:RadButton>
            </td>
        </tr>
        <tr>
            <td width="100%">
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                    AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
                    AllowAutomaticUpdates="True" AllowPaging="True" PageSize="100" AllowSorting="True" CellSpacing="0"  >
                    <ExportSettings>
                        <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                            PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in" />
                    </ExportSettings>
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" >
                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                HeaderText="Edit" ItemStyle-Width="30px">
                                <ItemStyle Width="20px"></ItemStyle>
                            </telerik:GridEditCommandColumn>
                            <telerik:GridTemplateColumn DataField="Name" 
                                FilterControlAltText="Filter Name column" HeaderText="Name" 
                                SortExpression="Name" UniqueName="Name">
                                <EditItemTemplate>
                                    <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80" Width="600px"></telerik:RadTextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Description" 
                                FilterControlAltText="Filter Description column" HeaderText="Description" 
                                SortExpression="Description" UniqueName="Description">
                                <EditItemTemplate>
                                    <telerik:RadTextBox ID="DescriptionTextBox" runat="server" MaxLength="512" Width="600px" TextMode="MultiLine" Rows="4"
                                        Text='<%# Bind("Description") %>' ></telerik:RadTextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="DescriptionLabel" runat="server" 
                                        Text='<%# Eval("Description") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridButtonColumn>
                        </Columns>
                        <CommandItemSettings AddNewRecordText="Add New Discipline" />
                        <ExpandCollapseColumn Resizable="False" Visible="False">
                            <HeaderStyle Width="20px" />
                        </ExpandCollapseColumn>
                        <RowIndicatorColumn Visible="False">
                            <HeaderStyle Width="20px" />
                        </RowIndicatorColumn>
                        <EditFormSettings CaptionDataField="Name" CaptionFormatString="Edit {0}">
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
        DeleteCommand="DELETE FROM Company_Disciplines_TEMPLATE WHERE (Id = @Id)"  
        InsertCommand="INSERT INTO Company_Disciplines_TEMPLATE(Name, Description) VALUES (@Name, @Description)"
        SelectCommand="SELECT Id, Name, Description FROM Company_Disciplines_TEMPLATE Order By Name"
        UpdateCommand="UPDATE Company_Disciplines_TEMPLATE SET Name = @Name, Description = @Description WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Description" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
