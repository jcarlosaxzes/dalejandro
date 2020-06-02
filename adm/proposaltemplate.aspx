<%@ Page Title="Proposal Template" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposaltemplate.aspx.vb" Inherits="pasconcept20.proposaltemplate" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="Formulario">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="width: 120px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                       Back to List
                    </asp:LinkButton>
                </td>
                <td style="text-align: center">
                    <h3 style="margin: 0">Proposal Template</h3>
                </td>

            </tr>
        </table>
    </div>

    <div>
        <asp:ValidationSummary ID="vsPre_Project" runat="server" ValidationGroup="Template"
            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
    </div>
    <div class="pas-container">
        <h4 style="text-align: center">Templates are used as a predefined Structure to create a new Proposal</h4>
        <table class="table-condensed" style="width: 98%">
            <tr>
                <td style="width: 220px; text-align: right">Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="NameTextBox" runat="server" MaxLength="80" Width="100%">
                    </telerik:RadTextBox>
                </td>

            </tr>
            <tr>
                <td style="text-align: right">Related Task ID:
                </td>
                <td>
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td style="vertical-align: top">
                                <telerik:RadComboBox ID="cboTask" runat="server" Height="350px" ToolTip="To find out the 'task id' codes, show 'Task List'"
                                    DataSourceID="SqlDataSourceTask" DataTextField="Description" DataValueField="taskcode" EmptyMessage="Select Task and Add to List..."
                                    Width="100%" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains">
                                    <Localization AllItemsCheckedString="All Task Checked" CheckAllString="Check All..." ItemsCheckedString="task checked"></Localization>
                                </telerik:RadComboBox>
                            </td>
                            <td style="width: 10%; vertical-align: middle; text-align: center">
                                <asp:LinkButton ID="btnAddTaskID" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false">
                                        Add Selected ->
                                </asp:LinkButton>

                            </td>
                            <td style="width: 45%; vertical-align: top">

                                <telerik:RadTextBox ID="TaskIdListTextBox" runat="server" EmptyMessage="Insert 'task id' separated by commas; e.g. 201,202,203"
                                    MaxLength="255" Width="100%">
                                </telerik:RadTextBox>

                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td></td>
                <td style="text-align:right">
                    <telerik:RadComboBox ID="cboPaymentSchedules" runat="server" DataSourceID="SqlDataSourcePaymentSchedules"
                        DataTextField="Name" DataValueField="Id" Width="400px" MarkFirstMatch="True" AppendDataBoundItems="true"
                        Filter="Contains" ToolTip="Select Payment Schedules to define first time or modify the current">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Payment Schedules...)" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                    &nbsp;
                    <asp:LinkButton ID="btnGeneratePaymentSchedules" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false" Width="120px">
                                Generate
                    </asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Payment Schedule(%):
                </td>
                <td>
                    <telerik:RadTextBox ID="PaymentsScheduleListTextBox" runat="server"
                        MaxLength="50" Width="100%" EmptyMessage="Insert payments percentages separated by commas; e.g. 50,50">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Schedule Description:
                </td>
                <td>
                    <telerik:RadTextBox ID="PaymentsTextListTextBox" runat="server"
                         Width="100%" Rows="3" MaxLength="512"
                        EmptyMessage="Insert descriptions of payments separated by commas; e.g. Due at Time of Signed Contract Agreement,50% Due at 100% Submittal">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Proposal Introductory Text:
                </td>
                <td>
                    <telerik:RadTextBox ID="TextBeginTextBox" runat="server" EmptyMessage="Proposal Introductory Text"
                        TextMode="MultiLine" Rows="3" MaxLength="1024" Width="100%">
                    </telerik:RadTextBox>
                </td>

            </tr>

            <tr>
                <td style="text-align: right">Proposal Concluding Text:
                </td>
                <td>
                    <telerik:RadTextBox ID="TextEndTextBox" runat="server"
                        TextMode="MultiLine" Rows="3" MaxLength="1024" Width="100%" EmptyMessage="Proposal Concluding Text">
                    </telerik:RadTextBox>
                </td>

            </tr>
            <tr>
                <td style="text-align: right">Terms & Conditions Template:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboTandCtemplates" runat="server" Width="100%" AppendDataBoundItems="true" DataSourceID="SqlDataSourceTandCtemplates"
                        DataTextField="Name" DataValueField="Id" ToolTip="Select T&amp;C Template and press 'Change T&amp;C'">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select T&amp;C Template...)" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td></td>

                <td style="text-align: right;">
                    <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" Text="Insert" CausesValidation="true" ValidationGroup="Template">
                    </asp:LinkButton>

                </td>
            </tr>
        </table>
    </div>


    <div>
        <asp:RequiredFieldValidator ID="rName"
            ControlToValidate="NameTextBox" Display="None" runat="server" Text="*"
            ErrorMessage="<span><b>Template Name</b> is required</span>" SetFocusOnError="true" ValidationGroup="Template">
        </asp:RequiredFieldValidator>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="Proposal_type2_UPDATE" UpdateCommandType="StoredProcedure"
        InsertCommand="Proposal_type2_INSERT" InsertCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:ControlParameter ControlID="NameTextBox" Name="Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TaskIdListTextBox" Name="TaskIdList" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="PaymentsScheduleListTextBox" Name="PaymentsScheduleList" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="PaymentsTextListTextBox" Name="PaymentsTextList" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBeginTextBox" Name="TextBegin" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextEndTextBox" Name="TextEnd" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboTandCtemplates" Name="tandcId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblTemplateId" Name="Id" PropertyName="Text" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="NameTextBox" Name="Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TaskIdListTextBox" Name="TaskIdList" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="PaymentsScheduleListTextBox" Name="PaymentsScheduleList" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="PaymentsTextListTextBox" Name="PaymentsTextList" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBeginTextBox" Name="TextBegin" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextEndTextBox" Name="TextEnd" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboTandCtemplates" Name="tandcId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTask" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT taskcode, '['+taskcode+'] '+Description as Description FROM Proposal_tasks WHERE (companyId = @companyId) and not Description is null ORDER BY taskcode">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTandCtemplates" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Proposal_TandCtemplates] WHERE ([companyId] = @companyId) ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePaymentSchedules" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Invoices_types WHERE (companyId = @companyId) ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTemplateId" runat="server" Visible="False" Text="0"></asp:Label>

</asp:Content>

