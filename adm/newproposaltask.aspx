<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="newproposaltask.aspx.vb" Inherits="pasconcept20.newproposaltask" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cboMulticolumnTask">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtName" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescriptionPlus" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txtTimeSel"  />
                    <telerik:AjaxUpdatedControl ControlID="txtRates"  />
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>

    <table class="table-condensed" style="width: 100%">
        <tr>
            <td style="100%">
                <h3>Complete Task details</h3>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlTemplate" runat="server">
                    <telerik:RadMultiColumnComboBox ID="cboMulticolumnTask" runat="server" DataSourceID="SqlDataSource1" DataTextField="Description" DataValueField="Id" AutoPostBack="true"
                            Width="800px" DropDownWidth="800" MarkFirstMatch="True" Filter="Contains" AutoFilter="True"
                            FilterFields="taskcode, Description" Placeholder="(Select Task...)">
                            <ColumnsCollection>
                                <telerik:MultiColumnComboBoxColumn Field="taskcode" Title="Code" Width="100px" />
                                <telerik:MultiColumnComboBoxColumn Field="Description" Title="Description"  />
                                <telerik:MultiColumnComboBoxColumn Field="Hours" Title="Hours"  Width="100px" />
                                <telerik:MultiColumnComboBoxColumn Field="Rates" Title="Rates" Width="150px" />
                            </ColumnsCollection>
                        </telerik:RadMultiColumnComboBox>
                    <%--<telerik:RadComboBox ID="cboTaskTemplate" runat="server" DataSourceID="SqlDataSource1" DataTextField="Description" DataValueField="Id" Width="800px" MarkFirstMatch="True"
                        Filter="Contains" Height="300px" AppendDataBoundItems="true" AutoPostBack="true" CausesValidation="false">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Task...)" Value="0" />
                        </Items>

                        <HeaderTemplate>
                            <table>
                                <tr>
                                    <td style="width: 400px; text-align: center">Name</td>
                                    <td style="width: 100px; text-align: center">Hours</td>
                                    <td style="width: 100px; text-align: center">Rates</td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td style="width: 400px; text-align: left"><%# DataBinder.Eval(Container.DataItem, "Description")%></td>
                                    <td style="width: 100px; text-align: right"><%# DataBinder.Eval(Container.DataItem, "Hours")%></td>
                                    <td style="width: 100px; text-align: right"><%# DataBinder.Eval(Container.DataItem, "Rates")%></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Select Task...)"
                        Operator="NotEqual" ControlToValidate="cboTaskTemplate" CssClass="Error" ValidationGroup="TaskUpdate" Text="*" ErrorMessage="Select Task">
                    </asp:CompareValidator>--%>
                </asp:Panel>

            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadComboBox runat="server" ID="cboPhase" DataValueField="Id" Width="800px" Height="250px"
                    DataTextField="Name" DataSourceID="SqlDataSourcePhases" AppendDataBoundItems="true">
                    <Items>
                        <telerik:RadComboBoxItem Text="(Select phase...)" Value="0" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadComboBox runat="server" ID="cboPosition" DataValueField="Id" Width="800px" Height="250px" AutoPostBack="true" CausesValidation="false"
                    DataTextField="Name" DataSourceID="SqlDataSourcePositions" AppendDataBoundItems="true">
                    <Items>
                        <telerik:RadComboBoxItem Text="(Select position...)" Value="0" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadTextBox ID="txtName" runat="server" MaxLength="80" Width="800px" EmptyMessage="Task Name"></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtName" CssClass="Error" ValidationGroup="TaskUpdate" Text="*" ErrorMessage="Define Task Name">
                </asp:RequiredFieldValidator>

            </td>
        </tr>
        <tr>
            <td style="text-align: left">
                <telerik:RadEditor ID="txtDescriptionPlus" runat="server" Content='<%# Bind("DescriptionPlus")%>' Height="300px"
                    AllowScripts="True" Width="800px"
                    ToolbarMode="Default" ToolsFile="~/BasicTools.xml" EditModes="All">
                </telerik:RadEditor>

            </td>
        </tr>
        <tr>
            <td>
                <small>Total = [Quantity] * [Hours] * [Rates]</small>&nbsp;&nbsp;&nbsp;
                <telerik:RadNumericTextBox ID="txtAmount" runat="server" Width="155px" EmptyMessage="Quantity">
                    <NumberFormat DecimalDigits="2" />
                </telerik:RadNumericTextBox>
                &nbsp;&nbsp;&nbsp;
                        <telerik:RadNumericTextBox ID="txtTimeSel" runat="server" Width="155px" MaxLength="5" EmptyMessage="Hours">
                            <NumberFormat DecimalDigits="2" />
                        </telerik:RadNumericTextBox>
                &nbsp;&nbsp;&nbsp;
                        <telerik:RadNumericTextBox ID="txtRates" runat="server" Width="155px" EmptyMessage="Rates">
                            <NumberFormat DecimalDigits="2" />
                        </telerik:RadNumericTextBox>

            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 800px">
                    <tr>
                        <td>
                            <small>if [Quantity] or [Hours] 'is blank' then Total = [1] * [1] * [Rates]</small>
                        </td>
                        <td style="width: 180px; text-align: right">
                            <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-default" Width="150px" CausesValidation="false" Text="Cancel">
                            </asp:LinkButton>
                        </td>
                        <td style="width: 180px; text-align: right">
                            <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success" Width="150px" ValidationGroup="TaskUpdate" UseSubmitBehavior="false" Text="Insert Task">
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="text-align: center"></td>
        </tr>
    </table>
    <div style="padding-top: 10px;">
        <asp:ValidationSummary ID="ValidationSummaryTaskUpdate" Font-Size="X-Small" runat="server" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="TaskUpdate" />
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
