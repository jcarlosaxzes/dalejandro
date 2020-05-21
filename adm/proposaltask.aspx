<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposaltask.aspx.vb" Inherits="pasconcept20.proposaltask" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cboMulticolumnTask">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtName" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescriptionPlus" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txtTimeSel" />
                    <telerik:AjaxUpdatedControl ControlID="txtRates" />

                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>

    <div class="Formulario">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="width: 120px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                       Cancel
                    </asp:LinkButton>
                </td>
                <td style="text-align: center">
                    <h3 style="margin:0">Proposal Task</h3>
                </td>

            </tr>
        </table>
    </div>
    <div class="pas-container">
        <table class="table-condensed" style="width: 95%; margin-left: 25px">
            <tr>
                <td style="text-align: right; width: 180px">
                    <asp:Label ID="lblTaskList" runat="server" Text="Select Task from List:"></asp:Label>
                </td>
                <td>
                    <asp:Panel ID="pnlTemplate" runat="server">
                        <telerik:RadMultiColumnComboBox ID="cboMulticolumnTask" runat="server" DataSourceID="SqlDataSource1" DataTextField="Description" DataValueField="Id" AutoPostBack="true"
                            Width="95%" DropDownWidth="800" MarkFirstMatch="True" Filter="Contains" AutoFilter="True"
                            FilterFields="taskcode, Description">
                            <ColumnsCollection>
                                <telerik:MultiColumnComboBoxColumn Field="taskcode" Title="Code" Width="100px" />
                                <telerik:MultiColumnComboBoxColumn Field="Description" Title="Description" />
                                <telerik:MultiColumnComboBoxColumn Field="Hours" Title="Hours" Width="100px" />
                                <telerik:MultiColumnComboBoxColumn Field="Rates" Title="Rates" Width="150px" />
                            </ColumnsCollection>
                        </telerik:RadMultiColumnComboBox>
                    </asp:Panel>

                </td>
            </tr>
            <tr>
                <td style="text-align: right"></td>
                <td>
                    <telerik:RadComboBox runat="server" ID="cboPhase" DataValueField="Id" Width="95%" Height="250px"
                        DataTextField="Name" DataSourceID="SqlDataSourcePhases" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Text="(Select phase...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Position (optional):</td>
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
                <td style="text-align: right">Task Name:</td>
                <td>
                    <telerik:RadTextBox ID="txtName" runat="server" MaxLength="80" Width="95%" EmptyMessage="Task Name"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Description:</td>
                <td>
                    <telerik:RadEditor ID="txtDescriptionPlus" runat="server" Content='<%# Bind("DescriptionPlus")%>' Height="300px"
                        AllowScripts="True" Width="95%"
                        ToolbarMode="Default" ToolsFile="~/BasicTools.xml" EditModes="All">
                    </telerik:RadEditor>

                </td>
            </tr>
            <tr>
                <td style="text-align: right">Quantity (optional):</td>
                <td>
                    <telerik:RadNumericTextBox ID="txtAmount" runat="server" Width="155px">
                        <NumberFormat DecimalDigits="2" />
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Hours (optional):</td>
                <td>
                    <telerik:RadNumericTextBox ID="txtTimeSel" runat="server" Width="155px" MaxLength="5" >
                            <NumberFormat DecimalDigits="2" />
                        </telerik:RadNumericTextBox>
                </td>
            </tr>
             <tr>
                <td style="text-align: right">Rates (optional):</td>
                <td>
                    <telerik:RadNumericTextBox ID="txtRates" runat="server" Width="155px">
                            <NumberFormat DecimalDigits="2" />
                        </telerik:RadNumericTextBox>
                </td>
            </tr>
             <tr>
                <td style="text-align: right"><b>Expression</b>:</td>
                <td>
                    <small>Total = [Quantity] * [Hours] * [Rates]</small><br />
                    <small>if [Quantity] or [Hours] 'is blank' then Total = [1] * [1] * [Rates]</small>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center">
                    <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-lg" Width="150px" ValidationGroup="TaskUpdate" UseSubmitBehavior="false" Text="Insert Task">
                                </asp:LinkButton>
                </td>
            </tr>
        </table>
        <div style="padding-top: 10px;padding-left:50px">
            <asp:ValidationSummary ID="ValidationSummaryTaskUpdate" runat="server" ForeColor="Red" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="TaskUpdate" />
        </div>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtName" ValidationGroup="TaskUpdate" ErrorMessage="Define Task Name" Display="None">
        </asp:RequiredFieldValidator>

    </div>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="PROPOSAL_details2_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="PROPOSAL_details_UPDATE" UpdateCommandType="StoredProcedure"
        SelectCommand="SELECT [Id], [taskcode], [Description], [Hours], [Rates] FROM [Proposal_tasks] WHERE (companyId = @companyId) ORDER BY taskcode">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="cboPhase" Name="phaseId" PropertyName="SelectedValue" Type="Int32" />
            <%--<asp:ControlParameter ControlID="cboTaskTemplate" Name="TaskId" PropertyName="SelectedValue" Type="Int32" />--%>
            <asp:ControlParameter ControlID="cboMulticolumnTask" Name="TaskId" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="txtName" Name="Description" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDescriptionPlus" Name="DescriptionPlus" PropertyName="Content" Type="String" />
            <asp:ControlParameter ControlID="txtAmount" Name="Amount" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtTimeSel" Name="Hours" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtRates" Name="Rates" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="cboPosition" Name="positionId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblproposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="cboPhase" Name="phaseId" PropertyName="SelectedValue" Type="Int32" />
            <%--<asp:ControlParameter ControlID="cboTaskTemplate" Name="TaskId" PropertyName="SelectedValue" Type="Int32" />--%>
            <asp:ControlParameter ControlID="cboMulticolumnTask" Name="TaskId" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="txtName" Name="Description" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDescriptionPlus" Name="DescriptionPlus" PropertyName="Content" Type="String" />
            <asp:ControlParameter ControlID="txtAmount" Name="Amount" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtTimeSel" Name="Hours" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtRates" Name="Rates" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="cboPosition" Name="positionId" PropertyName="SelectedValue" Type="Int32" />
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


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblproposalId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lbldetailId" runat="server" Visible="false"></asp:Label>
</asp:Content>
