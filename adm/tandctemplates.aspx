<%@ Page Title="TandC templates" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="tandctemplates.aspx.vb" Inherits="pasconcept20.tandctemplates" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <table style="width: 100%" class="table-condensed">
        <tr>
            <td>
                <div class="PanelFilter">
                    <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                        <table style="width: 100%" class="table-condensed Formulario">
                            <tr>
                                <td style="width: 100px">Find:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="100%" EmptyMessage="Find">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 120px">
                                    <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                            <i class="fas fa-search"></i> Search
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Add New Proposal Template">
                                    <i class="fas fa-plus"></i> Terms & Conditions
                </asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>
                <script type="text/javascript">

                    function OnClientClose(sender, args) {
                        var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                        masterTable.rebind();
                    }

                </script>
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" PageSize="25"
                    AllowAutomaticDeletes="True" >
                    <PagerStyle Mode="Slider" AlwaysVisible="false" />
                    <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="Id">
                        <Columns>
                            <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column"
                                HeaderText="Name" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEditTemplate" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Template"
                                        CommandName="EditTemplate">
                                                <%# Eval("Name")%>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <%--<telerik:GridHTMLEditorColumn UniqueName="Descripction" SortExpression="Descripction" HeaderText="Terms &amp; Conditions"
                                DataField="Descripction" Display="False" >
                            </telerik:GridHTMLEditorColumn>--%>
                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this record?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                            </telerik:GridButtonColumn>
                        </Columns>


                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Proposal_TandCtemplates] WHERE [Id] = @Id"
        SelectCommand="Proposal_TandCtemplates_SELECT" SelectCommandType="StoredProcedure">
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
