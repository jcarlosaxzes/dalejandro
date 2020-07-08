<%@ Page Title="TandC templates" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="tandctemplates.aspx.vb" Inherits="pasconcept20.tandctemplates" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Terms & Conditions</span>

        <span style="float: right; vertical-align: middle;">
            <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    Add New Terms & Conditions
            </asp:LinkButton>
        </span>
    </div>

    <div>
        <script type="text/javascript">

            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }

        </script>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" PageSize="25"
            AllowAutomaticDeletes="True">
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

    </div>
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
    <telerik:RadTextBox ID="txtFind" runat="server" Width="100%" Visible="false" EmptyMessage="Find">
    </telerik:RadTextBox>
</asp:Content>
