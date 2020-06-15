<%@ Page Title="Proposals" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_proposals.aspx.vb" Inherits="pasconcept20.job_proposals" %>

<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">
            function OnClientCloseProposals(sender, args) {
                var masterTable = $find("<%= RadGridProposals.ClientID%>").get_masterTableView();
                masterTable.rebind();
            }
        </script>
        <style>
            .RadTabStrip .rtsLI, .RadTabStripVertical .rtsLI {
                line-height: 10px;
            }
        </style>
    </telerik:RadCodeBlock>
    <div class="container">

        <table class="table-sm" style="width: 100%">
            <tr>
                <td>
                    <asp:LinkButton ID="btnNewPropsal" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false">
                                                            <i class="fas fa-plus"></i> Proposal (Change Order)
                    </asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="RadGridProposals" runat="server" AllowAutomaticDeletes="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceProposals" GridLines="None" ShowFooter="True">
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceProposals"
                            ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small" FooterStyle-Font-Size="X-Small">
                            <Columns>
                                <telerik:GridTemplateColumn DataField="Id" HeaderText="Proposal Number"
                                    SortExpression="Id" UniqueName="Id" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEditProp" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Proposal"
                                            CommandName="EditProposal" Text='<%# Eval("ProposalNumber")%>'>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Date" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime"
                                    HeaderText="Date Created" SortExpression="Date" UniqueName="Date"
                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" AllowFiltering="False" HeaderStyle-Width="100px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ProjectName" HeaderText="Project Name" SortExpression="ProjectName" UniqueName="ProjectName" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn AllowFiltering="False" DataField="Total" DataFormatString="{0:N}"
                                    Groupable="False" HeaderText="Proposal Amount" ReadOnly="True" SortExpression="Total"
                                    UniqueName="Total" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                    FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N}" FooterStyle-Width="100px">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="Id" HeaderText="Status" UniqueName="Status"
                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px"
                                    HeaderStyle-HorizontalAlign="Center" AllowFiltering="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnAcept3" Text='<%# Eval("Status") %>' CommandName="AceptProposal" Width="100%" CssClass="btn btn-secondary btn-sm"
                                            CommandArgument='<%# Eval("Id") %>' runat="server" Enabled='<%# ProposalStatusEnabled(Eval("Id"), Eval("Status"))%>'>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Email Print" UniqueName="columnEmail" AllowFiltering="False"
                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                                    <ItemTemplate>
                                        <telerik:RadButton ID="btnProposal" runat="server" CommandName="EmailPrint" CommandArgument='<%# Eval("Id") %>' Width="36px"
                                            ToolTip="Send Email with Proposal information" ButtonType="LinkButton">
                                            <Icon PrimaryIconCssClass="rbMail"></Icon>
                                        </telerik:RadButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Share" UniqueName="Share"
                                    HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnShareLink" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Get a link to copy and paste in an email or browser" Width="36px"
                                            CommandName="GetSharedLink" UseSubmitBehavior="false">
                                                <span aria-hidden="true" class="far fa-share-square"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="AceptedDate" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime"
                                    HeaderText="Acepted Date" SortExpression="AceptedDate" UniqueName="AceptedDate"
                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" AllowFiltering="False" HeaderStyle-Width="100px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AceptanceName" HeaderText="Aceptance Name" SortExpression="AceptanceName"
                                    UniqueName="AceptanceName" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridBoundColumn>
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Note that the only Proposal with $0.00 can be eliminated. Delete this proposal?"
                                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                    UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>

    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>


    <asp:SqlDataSource ID="SqlDataSourceProposals" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSALS_FROM_JOB_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="ProposalNew_ChangeOrder" InsertCommandType="StoredProcedure"
        DeleteCommand="PROPOSALS_FROM_JOB_DELETE" DeleteCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="EmployeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" DefaultValue="0" Name="JobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>

    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
</asp:Content>
