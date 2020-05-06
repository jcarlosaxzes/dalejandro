<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="usersagreelist.aspx.vb" Inherits="pasconcept20.usersagreelist" %>

<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%">
        <tr>
            <td width="100%">&nbsp;</td>
        </tr>
        <tr>
            <td width="100%">
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                    AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
                    AllowAutomaticUpdates="True" PageSize="100" AllowSorting="True" CellSpacing="0" Culture="es-ES">
                    <ExportSettings>
                        <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                            PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in">
                            <PageHeader>
                                <LeftCell Text=""></LeftCell>

                                <MiddleCell Text=""></MiddleCell>

                                <RightCell Text=""></RightCell>
                            </PageHeader>

                            <PageFooter>
                                <LeftCell Text=""></LeftCell>

                                <MiddleCell Text=""></MiddleCell>

                                <RightCell Text=""></RightCell>
                            </PageFooter>
                        </Pdf>
                    </ExportSettings>
                    <MasterTableView DataKeyNames="userEmail" DataSourceID="SqlDataSource1">

                        <BatchEditingSettings EditType="Cell"></BatchEditingSettings>

                        <PagerStyle Mode="Slider" AlwaysVisible="false"   />
                        <Columns>
                            <telerik:GridBoundColumn DataField="userEmail" FilterControlAltText="Filter userEmail column" HeaderText="userEmail" ReadOnly="True" SortExpression="userEmail" UniqueName="userEmail">
                            </telerik:GridBoundColumn>
                            <telerik:GridCheckBoxColumn DataField="Agree" DataType="System.Boolean" FilterControlAltText="Filter Agree column" HeaderText="Agree" SortExpression="Agree" UniqueName="Agree"
                                ItemStyle-Width="60px" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridCheckBoxColumn>
                            <telerik:GridCheckBoxColumn DataField="DisAgree" DataType="System.Boolean" FilterControlAltText="Filter DisAgree column" HeaderText="DisAgree" SortExpression="DisAgree" UniqueName="DisAgree"
                                ItemStyle-Width="60px" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridCheckBoxColumn>
                            <telerik:GridBoundColumn DataField="DateSet" DataType="System.DateTime" FilterControlAltText="Filter DateSet column" HeaderText="DateSet" SortExpression="DateSet" UniqueName="DateSet"
                                ItemStyle-Width="80px" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Times" DataType="System.Int16" FilterControlAltText="Filter Times column" HeaderText="Times" SortExpression="Times" UniqueName="Times"
                                ItemStyle-Width="60px" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
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

                    <PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>

                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                    </HeaderContextMenu>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [userEmail], [Agree], [DisAgree], [DateSet], [Times] FROM [UserAgree] ORDER BY [userEmail]"></asp:SqlDataSource>
</asp:Content>

