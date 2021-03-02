<%@ Page Title="Fees & Scope" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterPROPOSAL.Master" CodeBehind="pro_phases.aspx.vb" Inherits="pasconcept20.pro_phases" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/adm/MasterPROPOSAL.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <%--Panel Phases--%>
    <asp:Panel runat="server" ID="PanelPhases">
        <div class="pasconcept-bar noprint">
            <span class="h4">Proposal Phases</span>

            <span style="float: right; vertical-align: middle;">
                <asp:LinkButton ID="btnNewPhase" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Add New Phase for Proposal">
                       Add Phase
                </asp:LinkButton>
            </span>
        </div>
        <telerik:RadGrid ID="RadGridPhases" runat="server" DataSourceID="SqlDataSourcePhases" GridLines="None" AllowAutomaticDeletes="true"
            AutoGenerateColumns="False" CellSpacing="0" ShowFooter="true"
            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-Font-Bold="true"
            HeaderStyle-HorizontalAlign="Center" >
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePhases">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <BatchEditingSettings EditType="Cell" />
                <CommandItemSettings ShowAddNewRecordButton="false" />
                <Columns>
                    <telerik:GridTemplateColumn DataField="Code" HeaderStyle-Width="150px" HeaderText="Phase" SortExpression="Code" UniqueName="Code" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkPhaseEdit" runat="server" CommandName="EditPhase" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to Edit Phase" Enabled='<%# lblOriginalStatus.Text <= 1 %>'>
                                                    <b><%#Eval("Code")%></b>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="nOrder" HeaderStyle-Width="150px" HeaderText="Order" SortExpression="nOrder" UniqueName="nOrder" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
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
                            <asp:LinkButton ID="lnkPhaseEdit2" runat="server" CommandName="EditPhase" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to Edit Phase" Enabled='<%# lblOriginalStatus.Text <= 1 %>'>
                                                    <%#Eval("Name")%>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Period" HeaderStyle-Width="180px" HeaderText="Period" SortExpression="Period" UniqueName="Period" ItemStyle-HorizontalAlign="Left" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Progress" HeaderText="Progress" SortExpression="Progress" DataFormatString="{0:N0}" UniqueName="Progress" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DateFrom" HeaderText="Date From" SortExpression="DateFrom" UniqueName="DateFrom" DataFormatString="{0:d}" HeaderStyle-Width="150px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DateTo" HeaderText="Date To" SortExpression="DateTo" UniqueName="DateTo" DataFormatString="{0:d}" HeaderStyle-Width="150px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EstimatorHours" HeaderText="Estimated Hours" ReadOnly="True" SortExpression="EstimatorHours" DataFormatString="{0:N0}" UniqueName="EstimatorHours" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Estimator" HeaderText="Estimated" ReadOnly="True" SortExpression="Estimator" DataFormatString="{0:C2}" UniqueName="Estimated" Aggregate="Sum" FooterAggregateFormatString="{0:C2}" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right"
                        HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" DataFormatString="{0:C2}" UniqueName="Total" Aggregate="Sum"
                        FooterAggregateFormatString="{0:C2}" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this phase and its related tasks?"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn" HeaderText=""
                        ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </asp:Panel>

    <%--Proposal Tasks--%>
    <div class="pasconcept-bar noprint">
        <span class="h4">Proposal Tasks & Service Fee(s)</span>

        <span style="float: right; vertical-align: middle;">

            <asp:LinkButton ID="btnNewFee" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                                        Add Task
            </asp:LinkButton>

        </span>
    </div>

    <div style="padding-top: 10px">
        <telerik:RadGrid ID="RadGridFees" runat="server" AllowAutomaticDeletes="True"
            AutoGenerateColumns="False" DataSourceID="SqlDataSourceServiceFees" CellSpacing="0" Width="100%"
            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-Font-Bold="true"
            HeaderStyle-HorizontalAlign="Center" >
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceServiceFees" ShowFooter="true">
                <Columns>
                    <telerik:GridBoundColumn DataField="Id" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id" Display="False">
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="phaseId" HeaderText="Phase" SortExpression="PhaseCode" UniqueName="phaseId" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <b><%#Eval("PhaseCode")%></b>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="taskcode" HeaderText="Task" ReadOnly="True" SortExpression="taskcode"
                        UniqueName="taskcode" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditDetail" runat="server" CommandName="EditTask" CommandArgument='<%# Eval("Id") %>' CausesValidation="false" Enabled='<%# lblOriginalStatus.Text <= 1 %>'
                                ToolTip="Click to Edit detail">
                             <%# Eval("taskcode")%>
                            </asp:LinkButton>
                            &nbsp;
                        <asp:LinkButton ID="btnOrderDown" runat="server" CommandName="OrderDown" CommandArgument='<%# Eval("Id") %>' CausesValidation="false" Visible='<%# lblOriginalStatus.Text <= 1 %>'
                            ToolTip="Click to Order Down">
                            <i class="fas fa-arrow-down"></i>
                        </asp:LinkButton>
                            &nbsp;
                        <asp:LinkButton ID="btnOrderUp" runat="server" CommandName="OrderUp" CommandArgument='<%# Eval("Id") %>' CausesValidation="false" Visible='<%# lblOriginalStatus.Text <= 1 %>'
                            ToolTip="Click to Order Up">
                                <i class="fas fa-arrow-up"></i>
                        </asp:LinkButton>
                            &nbsp;
                        <asp:LinkButton ID="btnDuplicate" runat="server" CommandName="DetailDuplicate" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false" CausesValidation="false" Visible='<%# lblOriginalStatus.Text <= 1 %>'
                            ToolTip="Click to duplicate record">
                                <i class="far fa-clone"></i>
                        </asp:LinkButton>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                        HeaderText="Name" SortExpression="Description" UniqueName="Description">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditDetail2" runat="server" CommandName="EditTask" CommandArgument='<%# Eval("Id") %>' CausesValidation="false" ToolTip="Click to Edit detail" Enabled='<%# lblOriginalStatus.Text <= 1 %>'>
                                                                <%# Eval("Description") %>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Amount" DataType="System.Double" HeaderText="Quantity"
                        SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount", "{0:N4}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Hours" DataType="System.Double" HeaderText="Hours"
                        SortExpression="Hours" UniqueName="Hours" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lblHours" runat="server" Text='<%# Eval("Hours", "{0:N2}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Rates" DataType="System.Double" HeaderText="Rates"
                        SortExpression="Rates" UniqueName="Rates" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lblRates" runat="server" Text='<%# Eval("Rates", "{0:C2}")%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="BillType" HeaderText="Bill Type" SortExpression="BillType" UniqueName="BillType" HeaderStyle-Width="180px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EstimatorHours" HeaderText="Estimated Hours" ReadOnly="True" SortExpression="EstimatorHours" DataFormatString="{0:N0}" UniqueName="EstimatorHours" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Estimator" HeaderText="Estimated" ReadOnly="True" SortExpression="Estimator" DataFormatString="{0:C2}" UniqueName="Estimated" Aggregate="Sum" FooterAggregateFormatString="{0:C2}" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right"
                        HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TotalRow" HeaderText="Total" ReadOnly="True" SortExpression="TotalRow" DataFormatString="{0:C2}" UniqueName="TotalRow" Aggregate="Sum"
                        FooterAggregateFormatString="{0:C2}" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right"
                        FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Paymentschedule" FilterControlAltText="Filter Paymentschedule column" ItemStyle-HorizontalAlign="Center"
                        HeaderText="Payment Shedule" SortExpression="Paymentschedule" UniqueName="Paymentschedule" HeaderStyle-Width="250px">
                        <ItemTemplate>
                            <%# Eval("Paymentschedule") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridButtonColumn ConfirmDialogType="Classic" ConfirmText="Delete this row?"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn" HeaderText=""
                        HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>

            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div class="container" style="margin-top: 10px">
        <%--Project Phases Hide?--%>
        <div id="ScopeofWork">
            <asp:Panel ID="PanelPhase" runat="server" CssClass="row mb-lg">
                <div class="row mb-lg">
                    <section class="col-md-12 col-print-12">
                        <section class="col-md-12 col-print-12">
                            <h4>Scope of Work</h4>
                            <asp:Repeater ID="rptrPhases" runat="server" DataSourceID="SqlDataSourcePHASES" OnItemDataBound="rptrPhases_ItemDataBound">
                                <ItemTemplate>
                                    <h4 class="company-name m-t-1"><%# Eval("Name")%>&nbsp;&nbsp;(<%# Eval("Code")%>)</h4>
                                    <span class="fw-semi-bold">
                                        <%# Eval("Period")%>
                                    </span>
                                    <br />
                                    <%# Eval("Description")%>
                                    <div style="padding-left: 25px">
                                        <asp:Repeater ID="rptrScopeOfWorkByPhase" runat="server" DataSourceID="SqlDataSourceScopeOfWorkByPhase">
                                            <ItemTemplate>
                                                <h5 class="company-name m-t-1"><%# Eval("Description") %></h5>
                                                <%# Eval("DescriptionPlus")%>
                                                <hr />
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                    <asp:SqlDataSource ID="SqlDataSourceScopeOfWorkByPhase" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                                        SelectCommand="Proposal_ScopeOfWorkByPhase_Select" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
                                            <asp:Parameter Name="PhaseId" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>


                                </ItemTemplate>
                            </asp:Repeater>

                        </section>

                    </section>
                </div>
            </asp:Panel>

            <%--Scope of Work No Phases Hide?--%>
            <asp:Panel ID="PanelNoPhases" runat="server" CssClass="row mb-lg">
                <div class="row mb-lg">
                    <section class="col-md-12 col-print-12">
                        <h4>Scope of Work</h4>
                        <asp:Repeater ID="rptrScopeOfWork" runat="server" DataSourceID="SqlDataSourceSCOPEOFWORK">
                            <ItemTemplate>
                                <h5 class="company-name m-t-1"><%# IIf(Len(Eval("PhaseCode")) > 0, String.Concat(Eval("PhaseCode"), "  ", Eval("Description")), Eval("Description"))  %></h5>
                                <%# Eval("DescriptionPlus")%>
                            </ItemTemplate>
                        </asp:Repeater>

                    </section>
                </div>
            </asp:Panel>

        </div>
    </div>
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
    <asp:SqlDataSource ID="SqlDataSourceSCOPEOFWORK" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_SCOPEOFWORK_v20_Select" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblOriginalStatus" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblDetailSelectedId" runat="server" Visible="false"></asp:Label>

</asp:Content>
