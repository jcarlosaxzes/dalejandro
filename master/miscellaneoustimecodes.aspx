<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="miscellaneoustimecodes.aspx.vb" Inherits="pasconcept20.miscellaneoustimecodes" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%">
            <tr>
                <td class="ToolButtom noprint">
                    <telerik:RadButton ID="btnNew" runat="server" Text="Add New Time Code">
                        <Icon PrimaryIconCssClass="rbAdd" PrimaryIconLeft="4"  PrimaryIconTop="4"></Icon>
                    </telerik:RadButton>
                </td>
            </tr>
        <tr>
            <td width="100%">
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" EnableAJAX="True"
                    GridLines="None" AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
                    AllowAutomaticUpdates="True" AllowSorting="True" CellSpacing="0">
                    <ExportSettings>
                        <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                            PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in" />
                    </ExportSettings>
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" >
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                HeaderText="Edit" ItemStyle-Width="20px">
                                <ItemStyle Width="20px"></ItemStyle>
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn DataField="Id" HeaderText="ID" SortExpression="Id" UniqueName="Id">
                                <ItemStyle Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Name" HeaderText="Code Name" SortExpression="Name"
                                UniqueName="Name">
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this Code?" ConfirmTitle="Delete"
                                ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                                HeaderText="Delete" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px"
                                ItemStyle-HorizontalAlign="Center">
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridButtonColumn>
                        </Columns>
                        <CommandItemSettings AddNewRecordText="Add New Code" />
                        <ExpandCollapseColumn Resizable="False" Visible="False">
                            <HeaderStyle Width="20px" />
                        </ExpandCollapseColumn>
                        <RowIndicatorColumn Visible="False">
                            <HeaderStyle Width="20px" />
                        </RowIndicatorColumn>
                        <EditFormSettings>
                            <EditColumn UniqueName="EditCommandColumn1" ButtonType="PushButton">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [NonRegularHours_typesTEMPLATE]  WHERE [Id] = @Id" 
        InsertCommand="INSERT INTO [NonRegularHours_typesTEMPLATE] ([Id], [Name]) VALUES (@Id, @Name)"
        SelectCommand="SELECT [Id], [Name] FROM [NonRegularHours_typesTEMPLATE]  ORDER BY [Id]"
        UpdateCommand="UPDATE [NonRegularHours_typesTEMPLATE] SET [Name] = @Name WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Id" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Id" Type="String" />
            <asp:Parameter Name="Name" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>

