<%@ Page Title="Proposals" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_proposals.aspx.vb" Inherits="pasconcept20.job_proposals" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">
        <div class="pasconcept-bar">
            <span class="pasconcept-pagetitle">Proposals</span>
            <span style="float: right; vertical-align: middle;">
                <asp:LinkButton ID="btnNewPropsal" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                                                            Add Proposal (Change Order)
                    </asp:LinkButton>
            </span>
        </div>

      <div>
          <telerik:RadGrid ID="RadGridProposals" runat="server" AllowAutomaticDeletes="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceProposals" GridLines="None" ShowFooter="True">
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceProposals" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" FooterStyle-Font-Size="Small">
                            <Columns>
                                <telerik:GridTemplateColumn DataField="Id" HeaderText="Number"
                                    SortExpression="Id" UniqueName="Id" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-Width="130px" FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEditProp" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Proposal"
                                            CommandName="EditProposal"><%# Eval("ProposalNumber")%>
                                        </asp:LinkButton>

                                        <div style="float: right; vertical-align: top; margin: 0;">
                                            <%--Three Point Action Menu--%>
                                            <asp:HyperLink runat="server" ID="lblAction" NavigateUrl="javascript:void(0);" Style="text-decoration: none;">
                                            <i title="Click to menu for this row" style="color:dimgray" class="fas fa-ellipsis-v"></i>
                                            </asp:HyperLink>

                                            <telerik:RadToolTip ID="RadToolTipAction" runat="server" TargetControlID="lblAction" RelativeTo="Element"
                                                RenderMode="Lightweight" EnableViewState="true" ShowCallout="false" RenderInPageRoot="true"
                                                Position="BottomRight" Modal="True" Title="" ShowEvent="OnClick"
                                                HideDelay="100" HideEvent="LeaveToolTip" IgnoreAltAttribute="true">

                                                <table class="table-borderless" style="width: 200px; font-size: medium">
                                                    <tr>
                                                        <td>
                                                            <asp:LinkButton ID="btnEdit2" runat="server" UseSubmitBehavior="false" CommandName="EditProposal" CommandArgument='<%# Eval("Id")%>' CssClass="dropdown-item">
                                                    <i class="fas fa-pencil-alt"></i>&nbsp;&nbsp;View/Edit Proposal (Form Page)
                                                            </asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="dropdown-divider"></div>
                                                        </td>
                                                    </tr>
                                                    <%--<tr>
                                                        <td>
                                                            <asp:LinkButton runat="server" ID="btnSendProposal" CommandName="EmailPrint" CommandArgument='<%# Eval("Id") %>' CssClass="dropdown-item">
                                                                <i class="far fa-envelope"></i>&nbsp;&nbsp;Send Proposal Email to Client
                                                            </asp:LinkButton>
                                                        </td>
                                                    </tr>--%>
                                                    <tr>
                                                        <td>
                                                            <a href='<%# LocalAPI.GetSharedLink_URL(111, Eval("Id"), True)%>' target="_blank" class="dropdown-item">
                                                                <i class="fas fa-print"></i>&nbsp;&nbsp;Print Proposal
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <a href='<%# LocalAPI.GetSharedLink_URL(111, Eval("Id"), False)%>' target="_blank" class="dropdown-item">
                                                                <i class="far fa-share-square"></i>&nbsp;&nbsp;View/Share Client Proposal Page
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </telerik:RadToolTip>
                                        </div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Date" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime"
                                    HeaderText="Date" SortExpression="Date" UniqueName="Date" ItemStyle-HorizontalAlign="Center" AllowFiltering="False" HeaderStyle-Width="100px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ProjectName" HeaderText="Project Name" SortExpression="ProjectName" UniqueName="ProjectName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn AllowFiltering="False" DataField="Total" DataFormatString="{0:N}" HeaderText="Total" ReadOnly="True" SortExpression="Total"
                                    UniqueName="Total" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                    FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N}" FooterStyle-Width="100px">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="Id" HeaderText="Status" UniqueName="Status" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="130px" AllowFiltering="False">
                                    <ItemTemplate>
                                        <div style="font-size: 12px; width: 100%"
                                            class='<%# LocalAPI.GetProposalStatusLabelCSS(Eval("StatusId")) %>'>
                                            <%# Eval("Status") %>
                                        </div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="AceptedDate" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime"
                                    HeaderText="Acepted" SortExpression="AceptedDate" UniqueName="AceptedDate"
                                    ItemStyle-HorizontalAlign="Right" AllowFiltering="False" HeaderStyle-Width="100px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AceptanceName" HeaderText="Aceptance Name" SortExpression="AceptanceName"
                                    UniqueName="AceptanceName">
                                </telerik:GridBoundColumn>

                                <telerik:GridTemplateColumn HeaderText="Insights" UniqueName="Insights" AllowFiltering="False" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px">
                                    <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="text-align:right;width: 60px">
                                                <spa style="font-size: x-small" title="Emitted Date"><%# Eval("EmailDate", "{0:d}") %></spa>
                                            </td>
                                            <td style="text-align:center;width: 30px">
                                                <span title="Number of times Sent to Client" class="badge badge-pill badge-secondary" style='<%# IIf(Eval("Emitted")=0,"display:none;vertical-align:middle","display:normal;vertical-align:middle")%>'>
                                                    <%#Eval("Emitted")%>
                                                </span>
                                            </td>
                                            <td style="text-align:center;">
                                                <span title="Number of times the Client has visited your Proposal Page" class="badge badge-pill badge-warning" style='<%# IIf(Eval("Emitted")=0,"display:none","display:normal")%>'>
                                                    <%#Eval("clientvisits")%>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Note that the only Proposal with $0.00 can be eliminated. Delete this proposal?"
                                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                    UniqueName="DeleteColumn" HeaderText="" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
      </div>
              

        <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
        </telerik:RadWindowManager>

    </div>


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
