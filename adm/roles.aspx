<%@ Page Title="Roles" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="roles.aspx.vb" Inherits="pasconcept20.roles" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table class="table-sm Formulario" style="width:100%">
        <tr>
            <td style="width:100px">
                <asp:LinkButton ID="btnNewRole" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    <i class="fas fa-plus"></i> Role
                </asp:LinkButton>
            </td>
            <td style="width:100px">
                <asp:LinkButton ID="btnInitialize" runat="server" CssClass="btn btn-danger btn" UseSubmitBehavior="false" ToolTip="Setup default initial roles">
                     Initialize
                </asp:LinkButton>

            </td>
            <td></td>
        </tr>
    </table>
    <div class="row">
        <div class="col-md-12">
            <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                <script type="text/javascript">
                    function OnClientClose(sender, args) {
                        var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                        masterTable.rebind();
                    }
                </script>
            </telerik:RadCodeBlock>
            <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" Width="100%" Culture="en-US" AllowAutomaticDeletes="true" AllowAutomaticInserts="true" ShowFooter="true"
                HeaderStyle-HorizontalAlign="Center">
                <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" AutoGenerateColumns="False">
                    <Columns>
                        <telerik:GridBoundColumn DataField="Id" FilterControlAltText="Filter Id column" HeaderText="Id" SortExpression="Id" UniqueName="Id" Display="false" ReadOnly="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn ReadOnly="True" HeaderText="" UniqueName="Actions" HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnPermits" CommandName="Permits" CommandArgument='<%# Eval("Id") %>'
                                    ToolTip="Employee Permits">
                                                <i class="fas fa-cog"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="Name" FilterControlAltText="Filter Name column" Aggregate="Count" FooterAggregateFormatString="{0:N0}"
                            HeaderText="Role Name" SortExpression="Name" UniqueName="Name">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="URLFirewall" FilterControlAltText="Filter URLFirewall column" HeaderText="URLFirewall" SortExpression="URLFirewall" UniqueName="URLFirewall">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="UserInRole" HeaderText="#Users" SortExpression="UserInRole" UniqueName="UserInRole" ReadOnly="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" >
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete role?"
                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                            UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                        </telerik:GridButtonColumn>

                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>

    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_roles_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="Employee_roles_DELETE" DeleteCommandType="StoredProcedure"
        InsertCommand="Employee_roles_SHORT_INSERT" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="URLFirewall" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceInitRoles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="[Company_EmployeeRoles_COPY]" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="companySourceId" DefaultValue="260962" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyDestId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>

</asp:Content>

