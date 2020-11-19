﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposaltask.aspx.vb" Inherits="pasconcept20.proposaltask" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<%--    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cboMulticolumnTask">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtName" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescriptionPlus" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txtTimeSel" />
                    <telerik:AjaxUpdatedControl ControlID="txtRates" />
                    <telerik:AjaxUpdatedControl ControlID="cboBillType" />

                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"  EnableEmbeddedSkins="false" ></telerik:RadAjaxLoadingPanel>--%>


    <div class="pasconcept-bar">
        <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back
        </asp:LinkButton>

        <span class="pasconcept-pagetitle">Proposal Task</span>

    </div>

    <div class="pasconcept-bar">
        <table class="table-sm" style="width: 99%;">
            <tr>
                <td style="text-align: right; width: 200px">
                    <asp:Label ID="lblTaskList" runat="server" Text="Select Task from List:"></asp:Label>
                </td>
                <td>
                    <asp:Panel ID="pnlTemplate" runat="server">
                        <telerik:RadMultiColumnComboBox ID="cboMulticolumnTask" runat="server" DataSourceID="SqlDataSource1" DataTextField="Description" DataValueField="Id" AutoPostBack="true" Skin="Material"
                            Width="800px" DropDownWidth="800" MarkFirstMatch="True" Filter="Contains" AutoFilter="True" Height="300px"
                            FilterFields="taskcode, Description">
                            <ColumnsCollection>
                                <telerik:MultiColumnComboBoxColumn Field="taskcode" Title="Code" Width="100px" />
                                <telerik:MultiColumnComboBoxColumn Field="Description" Title="Description" />
                                <telerik:MultiColumnComboBoxColumn Field="Hours" Title="Hours" Width="100px" />
                                <telerik:MultiColumnComboBoxColumn Field="Rates" Title="Rates" Width="150px" />
                                <telerik:MultiColumnComboBoxColumn Field="HourRatesService" Title="HR Service" Width="100px" />
                            </ColumnsCollection>
                        </telerik:RadMultiColumnComboBox>
                    </asp:Panel>

                </td>
            </tr>
        </table>
        <hr />
        <asp:Panel runat="server" ID="PanelPhases">
            <table class="table-sm" style="width: 99%;">
                <tr>
                    <td style="text-align: right; width: 200px">
                        <asp:Label ID="lblPhaseLabel" runat="server" Text="Phase:"></asp:Label>
                    </td>
                    <td>
                        <telerik:RadComboBox runat="server" ID="cboPhase" DataValueField="Id" Width="95%" Height="250px"
                            DataTextField="Name" DataSourceID="SqlDataSourcePhases" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="(Select phase...)" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
            <asp:CompareValidator runat="server" ID="ComparevalidatorPhase" ValueToCompare="(Select phase...)" Display="None"
                Operator="NotEqual" ControlToValidate="cboPhase" ErrorMessage="<span><b>Phase</b> is required</span>" ValidationGroup="TaskUpdate">
            </asp:CompareValidator>

        </asp:Panel>
        <table class="table-sm" style="width: 99%;">
            <tr>
                <td style="text-align: right; width: 200px">Position (optional):
                </td>
                <td>
                    <telerik:RadComboBox runat="server" ID="cboPosition" DataValueField="Id" Width="95%" Height="250px" AutoPostBack="true" CausesValidation="false"
                        DataTextField="Name" DataSourceID="SqlDataSourcePositions" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Text="(Select position...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Task Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtName" runat="server" MaxLength="80" Width="95%" EmptyMessage="Task Name"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right; vertical-align: top">Description:
                </td>
                <td>
                    <telerik:RadEditor ID="txtDescriptionPlus" runat="server" Content='<%# Bind("DescriptionPlus")%>' Height="250px"
                        AllowScripts="True" Width="95%"
                        ToolbarMode="Default" ToolsFile="~/BasicTools.xml" EditModes="Design,Preview" RenderMode="Auto">
                    </telerik:RadEditor>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Quantity:
                </td>
                <td>
                    <table class="table-sm" style="width: 95%">
                        <tr>
                            <td style="width: 120px">
                                <telerik:RadNumericTextBox ID="txtAmount" runat="server" Width="100%" EmptyMessage="Optional">
                                    <NumberFormat DecimalDigits="4" />
                                </telerik:RadNumericTextBox>
                            </td>
                            <td style="text-align: right; width: 100px">Hours:
                            </td>
                            <td style="width: 120px">
                                <telerik:RadNumericTextBox ID="txtTimeSel" runat="server" MaxLength="5" Width="100%" EmptyMessage="Optional">
                                    <NumberFormat DecimalDigits="2" />
                                </telerik:RadNumericTextBox>
                            </td>
                            <td style="text-align: right; width: 100px">Rates:
                            </td>
                            <td style="width: 120px">
                                <telerik:RadNumericTextBox ID="txtRates" runat="server" Width="100%" EmptyMessage="Optional">
                                </telerik:RadNumericTextBox>
                            </td>
                            <td style="text-align: right; width: 100px">Bill Type:
                            </td>
                            <td style="width: 180px">
                                <telerik:RadComboBox ID="cboBillType" runat="server" Width="100%">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Undefined" Value="0" />
                                        <telerik:RadComboBoxItem runat="server" Text="Flat Rate" Value="1" />
                                        <telerik:RadComboBoxItem runat="server" Text="Hourly Rate" Value="2" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>

                            <td style="text-align: right">
                                <asp:Label ID="lblTotalLine" runat="server" Font-Bold="true" Font-Size="Large"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <b>Expression</b>:
                </td>
                <td>
                    <small>Total = [Quantity] * [Hours] * [Rates]</small>     <small>if [Quantity] or [Hours] 'is blank' then Total = [1] * [1] * [Rates]</small>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Payment Schedule:
                </td>
                <td>
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 500px">
                                <telerik:RadComboBox ID="cboPaymentSchedulesEdit" runat="server" DataSourceID="SqlDataSourcePaymentSchedules"
                                    DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="true"
                                    ToolTip="Select Payment Schedules for individual Task">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(Select Payment Schedules...)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td style="text-align: right; padding-right: 5%">
                                <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-lg" ValidationGroup="TaskUpdate" UseSubmitBehavior="false" Text="Insert">
                                </asp:LinkButton>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:LinkButton ID="btnUpdateAndBack" runat="server" CssClass="btn btn-success btn-lg" ValidationGroup="TaskUpdate" UseSubmitBehavior="false" Text="Insert">
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:Panel runat="server" ID="PanelEstimator" BackColor="WhiteSmoke">
            <hr style="margin: 0" />
            <h3 style="margin-left: 100px">Estimator
            </h3>
            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="text-align: right; width: 180px">Position:
                    </td>
                    <td style="width: 300px">
                        <telerik:RadComboBox runat="server" ID="cboPositionForEstimator" DataValueField="Id" Width="100%" Height="250px" CausesValidation="false"
                            DataTextField="Name" DataSourceID="SqlDataSourcePositions" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="(Select position...)" Value="0" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td style="text-align: right; width: 100px">Hours:</td>
                    <td style="width: 100px">
                        <telerik:RadNumericTextBox ID="txtHoursForEstimate" runat="server" Width="100%" MaxLength="5">
                            <NumberFormat DecimalDigits="0" />
                        </telerik:RadNumericTextBox>

                    </td>
                    <td style="width: 120px">
                        <asp:LinkButton ID="btnNewEstimator" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="Estimator">
                                        <i class="fas fa-plus"></i>&nbsp;&nbsp;Position
                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:CompareValidator runat="server" ID="Comparevalidator3" ValueToCompare="(Select position...)" Display="Dynamic" ForeColor="Red"
                            Operator="NotEqual" ControlToValidate="cboPositionForEstimator" ErrorMessage="<span><b>Position</b> is required</span>" ValidationGroup="Estimator">
                        </asp:CompareValidator>

                    </td>
                </tr>
            </table>
            <div style="padding-left: 180px; width: 90%">
                <telerik:RadGrid ID="RadGridEstaimator" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                    AutoGenerateColumns="False" DataSourceID="SqlDataSourceEstimator" CellSpacing="0" Width="100%"
                    HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" FooterStyle-Font-Size="Small">
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceEstimator" ShowFooter="true">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderText="" HeaderStyle-Width="50px">
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn DataField="Id" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id" Display="False">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="Position" HeaderText="Position" SortExpression="Position" UniqueName="Position" ReadOnly="true">
                                <ItemTemplate>
                                    <%# Eval("Position") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Hours" HeaderText="Hours" SortExpression="Hours" UniqueName="Hours" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <%# Eval("Hours", "{0:N2}") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div style="margin: 5px">
                                        <telerik:RadNumericTextBox ID="txtHoursForEstimateEdit" runat="server" Width="100%" MaxLength="5" DbValue='<%# Bind("Hours") %>'>
                                            <NumberFormat DecimalDigits="0" />
                                        </telerik:RadNumericTextBox>
                                    </div>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Rate" DataType="System.Double" HeaderText="Rate"
                                SortExpression="Rate" UniqueName="Rate" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right" ReadOnly="true">
                                <ItemTemplate>
                                    <asp:Label ID="lblRates" runat="server" Text='<%# Eval("Rate", "{0:N2}")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="Total" HeaderText="Total" ReadOnly="True"
                                SortExpression="Total" DataFormatString="{0:N2}" UniqueName="Total" Aggregate="Sum"
                                FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>

                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn" HeaderText=""
                                HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridButtonColumn>
                        </Columns>

                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </asp:Panel>

        <div style="padding-top: 10px; padding-left: 50px">
            <asp:ValidationSummary ID="ValidationSummaryTaskUpdate" runat="server" ForeColor="Red" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="TaskUpdate" />
        </div>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtName" ValidationGroup="TaskUpdate" ErrorMessage="Define Task Name" Display="None">
        </asp:RequiredFieldValidator>
    </div>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="PROPOSAL_details_v20_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="PROPOSAL_details_v20_UPDATE" UpdateCommandType="StoredProcedure"
        SelectCommand="SELECT [Id], [taskcode], [Description], isnull([Hours],0) as [Hours], isnull([Rates],0) as [Rates], isnull(HourRatesService,0) AS HourRatesService FROM [Proposal_tasks] WHERE (companyId = @companyId) ORDER BY taskcode">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="cboPhase" Name="phaseId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboMulticolumnTask" Name="TaskId" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="txtName" Name="Description" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDescriptionPlus" Name="DescriptionPlus" PropertyName="Content" Type="String" />
            <asp:ControlParameter ControlID="txtAmount" Name="Amount" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtTimeSel" Name="Hours" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtRates" Name="Rates" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="cboPosition" Name="positionId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblproposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboPaymentSchedulesEdit" Name="paymentscheduleId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboBillType" Name="BillType" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="Id_OUT" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="txtName" Name="Description" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDescriptionPlus" Name="DescriptionPlus" PropertyName="Content" Type="String" />
            <asp:ControlParameter ControlID="txtAmount" Name="Amount" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtTimeSel" Name="Hours" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtRates" Name="Rates" PropertyName="Text" Type="Double" />

            <asp:ControlParameter ControlID="cboPaymentSchedulesEdit" Name="paymentscheduleId" PropertyName="SelectedValue" Type="Int32" />

            <asp:ControlParameter ControlID="cboPhase" Name="phaseId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboPosition" Name="positionId" PropertyName="SelectedValue" Type="Int32" />

            <asp:ControlParameter ControlID="cboBillType" Name="BillType" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lbldetailId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePhases" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], Code+' '+[Name] As Name FROM [Proposal_phases] WHERE proposalId=@proposalId ORDER BY [nOrder]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblproposalId" Name="proposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePositions" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Employees_Position where companyId=@companyId Order By Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEstimator" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Proposal_detail_estimator_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Proposal_detail_estimator_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="Proposal_detail_estimator_UPDATE" UpdateCommandType="StoredProcedure"
        DeleteCommand="Proposal_detail_estimator_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lbldetailId" Name="ProposaldetailId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lbldetailId" Name="ProposaldetailId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboPositionForEstimator" Name="PositionId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtHoursForEstimate" Name="Hours" PropertyName="Value" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Hours" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePaymentSchedules" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Invoices_types WHERE (companyId = @companyId) ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblproposalId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lbldetailId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblBackSource" runat="server" Visible="False" Text="0"></asp:Label>

</asp:Content>
