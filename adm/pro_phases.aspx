<%@ Page Title="Fees & Scope" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterPROPOSAL.Master" CodeBehind="pro_phases.aspx.vb" Inherits="pasconcept20.pro_phases" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/adm/MasterPROPOSAL.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <%--Panel Phases--%>
    <asp:Panel runat="server" ID="PanelPhases">
        <div class="pasconcept-bar noprint">
            <span class="pasconcept-pagetitle">Fees & Scope</span>
        </div>
        <div class="pasconcept-bar noprint">
            <span class="h4">Proposal Phases</span>

            <span style="float: right; vertical-align: middle;">
                <asp:LinkButton ID="btnNewPhase" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Add New Phase for Proposal">
                       Add Phase
                </asp:LinkButton>
            </span>
        </div>
        <telerik:RadGrid ID="RadGridPhases" runat="server" DataSourceID="SqlDataSourcePhases" GridLines="None" AllowAutomaticDeletes="true"
            AutoGenerateColumns="False" CellSpacing="0" ShowFooter="true" HeaderStyle-HorizontalAlign="Center"
            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePhases">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <BatchEditingSettings EditType="Cell" />
                <CommandItemSettings ShowAddNewRecordButton="false" />
                <Columns>
                    <telerik:GridBoundColumn DataField="nOrder" HeaderStyle-Width="100px" HeaderText="Order" SortExpression="nOrder" UniqueName="nOrder" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Code" HeaderStyle-Width="100px" HeaderText="Code" SortExpression="Code" UniqueName="Code" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkPhaseEdit" runat="server" CommandName="EditPhase" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to Edit Phase">
                                                    <span class= "badge badge-pill badge-info"><%#Eval("Code")%></span>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Task" HeaderText="Task" SortExpression="Task" UniqueName="Task" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <span title="Number of task for this Phase" class='<%#IIf(Eval("Task") = 0, "badge badge-pill badge-dark", "badge badge-pill badge-success") %>'>
                                <%#Eval("Task")%>
                            </span>
                            &nbsp;
                                                <asp:LinkButton ID="btnNewTaskInPhase" Font-Size="X-Small" runat="server" CssClass="btn btn-primary btn-sm" CommandName="AddTaskInPhase" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false"
                                                    ToolTip="Add New Task for this Pahse">
                                                    Add Task
                                                </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Name" HeaderText="Name" SortExpression="Name" UniqueName="Name">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkPhaseEdit2" runat="server" CommandName="EditPhase" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to Edit Phase">
                                                    <%#Eval("Name")%>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Period" HeaderStyle-Width="180px" HeaderText="Period" SortExpression="Period" UniqueName="Period" ItemStyle-HorizontalAlign="Left" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DateFrom" HeaderText="DateFrom" SortExpression="DateFrom" UniqueName="DateFrom" DataFormatString="{0:d}" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DateTo" HeaderText="DateTo" SortExpression="DateTo" UniqueName="DateTo" DataFormatString="{0:d}" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Progress" HeaderText="Progress" SortExpression="Progress" DataFormatString="{0:N0}" UniqueName="Progress" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" DataFormatString="{0:N2}" UniqueName="Total" Aggregate="Sum"
                        FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this phase and its related tasks?"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </asp:Panel>

    <%--Proposal Tasks--%>
    <div class="pasconcept-bar noprint">
        <span class="h4">Proposal Tasks</span>

        <span style="float: right; vertical-align: middle;">

            <asp:LinkButton ID="btnNewFee" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                                        Add Task
            </asp:LinkButton>

        </span>
    </div>
    <telerik:RadGrid ID="RadGridFees" runat="server" AllowAutomaticDeletes="True"
        AutoGenerateColumns="False" DataSourceID="SqlDataSourceServiceFees" CellSpacing="0" Width="100%"
        HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small">
        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceServiceFees" ShowFooter="true">
            <Columns>
                <telerik:GridBoundColumn DataField="Id" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id" Display="False">
                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn DataField="phaseId" HeaderText="Phase" SortExpression="PhaseCode" UniqueName="phaseId" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%--<asp:Label ID="lblphaseId" runat="server" Text='<%# Eval("PhaseCode") %>' ToolTip='<%# Eval("PhaseName") %>'></asp:Label>--%>
                        <span title="Phase of This Task" class="badge badge-pill badge-info">
                            <%#Eval("PhaseCode")%>
                        </span>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="taskcode" HeaderText="Task" ReadOnly="True" SortExpression="taskcode"
                    UniqueName="taskcode" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEditDetail" runat="server" CommandName="EditTask" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
                            ToolTip="Click to Edit detail">
                                                                <%# Eval("taskcode")%>
                        </asp:LinkButton>
                        &nbsp;
                                                        <asp:LinkButton ID="btnOrderDown" runat="server" CommandName="OrderDown" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
                                                            ToolTip="Click to Order Down">
                                                                <i class="fas fa-arrow-down"></i>
                                                        </asp:LinkButton>
                        &nbsp;
                                                        <asp:LinkButton ID="btnOrderUp" runat="server" CommandName="OrderUp" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
                                                            ToolTip="Click to Order Up">
                                                                <i class="fas fa-arrow-up"></i>
                                                        </asp:LinkButton>
                        &nbsp;
                                                        <asp:LinkButton ID="btnDuplicate" runat="server" CommandName="DetailDuplicate" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false" CausesValidation="false"
                                                            ToolTip="Click to duplicate record">
                                                                <i class="far fa-clone"></i>
                                                        </asp:LinkButton>

                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                    HeaderText="Name" SortExpression="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEditDetail2" runat="server" CommandName="EditTask" CommandArgument='<%# Eval("Id") %>' CausesValidation="false" ToolTip="Click to Edit detail">
                                                                <%# Eval("Description") %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="Amount" DataType="System.Double" HeaderText="Quantity"
                    SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                    HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount", "{0:N4}") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="Hours" DataType="System.Double" HeaderText="Hours"
                    SortExpression="Hours" UniqueName="Hours" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                    HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblHours" runat="server" Text='<%# Eval("Hours", "{0:N2}") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="Rates" DataType="System.Double" HeaderText="Rates"
                    SortExpression="Rates" UniqueName="Rates" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                    HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblRates" runat="server" Text='<%# Eval("Rates", "{0:N2}")%>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="BillType" HeaderText="Bill Type" SortExpression="BillType" UniqueName="BillType" HeaderStyle-Width="180px">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Estimator" HeaderText="Estimated" ReadOnly="True"
                    SortExpression="Estimator" DataFormatString="{0:N2}" UniqueName="Estimated" Aggregate="Sum"
                    FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right"
                    HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TotalRow" HeaderText="Total" ReadOnly="True"
                    SortExpression="TotalRow" DataFormatString="{0:N2}" UniqueName="TotalRow" Aggregate="Sum"
                    FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right"
                    HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="Paymentschedule" FilterControlAltText="Filter Paymentschedule column" ItemStyle-HorizontalAlign="Center"
                    HeaderText="Payment Shedule" SortExpression="Paymentschedule" UniqueName="Paymentschedule" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("Paymentschedule") %>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridButtonColumn ConfirmDialogType="Classic" ConfirmText="Delete this row?"
                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                    UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                    HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                </telerik:GridButtonColumn>
            </Columns>

        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="SqlDataSourcePhases" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_phases_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="PROPOSAL_phases_DELETE" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="proposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceServiceFees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="PROPOSAL_details_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="PROPOSAL_details_SELECT" SelectCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="String" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProposaldDetailDuplicate" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="PROPOSAL_details_DUPLICATE" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="lblDetailSelectedId" Name="ProposaldetailsId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblOriginalStatus" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblDetailSelectedId" runat="server" Visible="false"></asp:Label>

</asp:Content>
