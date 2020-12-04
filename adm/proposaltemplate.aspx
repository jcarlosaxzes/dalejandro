<%@ Page Title="Proposal Template" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposaltemplate.aspx.vb" Inherits="pasconcept20.proposaltemplate" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
            </asp:LinkButton>
            Proposal Template
        </span>
    </div>

    <div>
        <asp:ValidationSummary ID="vsPre_Project" runat="server" ValidationGroup="Template"
            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
    </div>
    <div class="pasconcept-bar">
        <h4 style="text-align: center">Templates are used as a predefined Structure to create a new Proposal</h4>
        <table class="table-sm" style="width: 98%">
            <tr>
                <td style="width: 220px; text-align: right">Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="NameTextBox" runat="server" MaxLength="80" Width="100%">
                    </telerik:RadTextBox>
                </td>

            </tr>


            <tr>
                <td></td>
                <td style="text-align: right">
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
                        TextMode="MultiLine" Rows="3" Width="100%">
                    </telerik:RadTextBox>
                </td>

            </tr>

            <tr>
                <td style="text-align: right">Proposal Concluding Text:
                </td>
                <td>
                    <telerik:RadTextBox ID="TextEndTextBox" runat="server"
                        TextMode="MultiLine" Rows="3" Width="100%" EmptyMessage="Proposal Concluding Text">
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
        </table>

        <h3>Service Fee(s)</h3>


        <%--Proposal Tasks--%>
        <div class="pasconcept-bar noprint">
            <span class="pasconcept-pagetitle">Proposal Tasks</span>
        </div>
        <table class="table-sm">
            <tr>
                <td style="text-align: right;">
                    <asp:Label ID="lblPhaseLabel" runat="server" Text="Phase:"></asp:Label>
                </td>
                <td style="width:350px">
                    <telerik:RadComboBox runat="server" ID="cboPhase" DataValueField="Id" Width="100%" Height="250px"
                        DataTextField="Name" DataSourceID="SqlDataSourcePhases" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Text="(Select phase...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="text-align: right">Related Task ID:
                </td>
                <td style="vertical-align: top;width:450px">
                    <telerik:RadComboBox ID="cboTask" runat="server" Height="350px" ToolTip="To find out the 'task id' codes, show 'Task List'"
                        DataSourceID="SqlDataSourceTask" DataTextField="Description" DataValueField="TaskId" EmptyMessage="Select Task and Add to List..."
                        Width="100%" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains">
                        <Localization AllItemsCheckedString="All Task Checked" CheckAllString="Check All..." ItemsCheckedString="task checked"></Localization>
                    </telerik:RadComboBox>
                </td>
                <td style="width: auto; vertical-align: middle; text-align: start">
                    <asp:LinkButton ID="btnAddTaskID" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false">
                            Add Task
                    </asp:LinkButton>

                </td>
            </tr>
        </table>
        <telerik:RadGrid ID="RadGridFees" runat="server" AllowAutomaticDeletes="True"
            AutoGenerateColumns="False" DataSourceID="SqlDataSourceServiceFees" CellSpacing="0" Width="100%"
            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small"
            AllowAutomaticUpdates="True">
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
                            <asp:LinkButton ID="btnEditDetail" runat="server" CommandName="edit" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
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
                        <EditItemTemplate>
                            <div style="margin: 5px">
                                <telerik:RadTextBox ID="subtypeNameTextBox" runat="server" Text='<%# Bind("taskcode") %>' MaxLength="80" Width="600px"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="subtypeNameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                            </div>
                        </EditItemTemplate>
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




                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table class="table-sm" style="width: 100%">

                            <tr>
                                <td style="text-align: right; width: 220px;">Phase:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboPhaseUpdate" runat="server" DataSourceID="SqlDataSourcePhases"
                                        DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("phaseId")%>' AppendDataBoundItems="true"
                                        Width="300px" MarkFirstMatch="True" Filter="Contains"
                                        Height="300px">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="(Type Not Defined...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right; width: 220px;">Task:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboTaskUpdate" runat="server" DataSourceID="SqlDataSourceTask"
                                        DataTextField="Description" DataValueField="TaskId" SelectedValue='<%# Bind("TaskId")%>' AppendDataBoundItems="true"
                                        Width="300px" MarkFirstMatch="True" Filter="Contains"
                                        Height="300px">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="(Tasks Not Defined...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;">Name:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="SubjectTextBox" runat="server" Text='<%# Bind("Description") %>'
                                        Width="800px" MaxLength="255">
                                    </telerik:RadTextBox>
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
                                <td style="text-align: right;">Quantity:
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ID="txtAmount" runat="server" Width="100%" EmptyMessage="Optional" Text='<%# Bind("Amount") %>'>
                                        <NumberFormat DecimalDigits="4" />
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;">Hours:
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ID="txtTimeSel" runat="server" MaxLength="5" Width="100%" EmptyMessage="Optional" Text='<%# Bind("Hours") %>'>
                                        <NumberFormat DecimalDigits="2" />
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;">Rates:
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ID="txtRates" runat="server" Width="100%" EmptyMessage="Optional" Text='<%# Bind("Rates") %>'>
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;">Bill Type:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboBillType" runat="server" SelectedValue='<%# Bind("BillTypeId")%>'>
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="Undefined" Value="0" />
                                            <telerik:RadComboBoxItem runat="server" Text="Flat Rate" Value="1" />
                                            <telerik:RadComboBoxItem runat="server" Text="Hourly Rate" Value="2" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>

                            <tr>
                                <td></td>
                                <td>
                                    <asp:LinkButton ID="btnUpdate" CssClass="btn-success btn-lg"
                                        Text="Update" runat="server" CommandName="Update"></asp:LinkButton>
                                    &nbsp;&nbsp;
                                    <asp:LinkButton ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" CssClass="btn-secondary btn-lg"
                                        CommandName="Cancel"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </FormTemplate>
                </EditFormSettings>

            </MasterTableView>
        </telerik:RadGrid>

    </div>


    <div class="pasconcept-bar noprint">
        <span style="float: right; vertical-align: middle;">
            <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" Text="Insert" CausesValidation="true" ValidationGroup="Template">
            </asp:LinkButton>
        </span>
    </div>

    <div>
        <asp:RequiredFieldValidator ID="rName"
            ControlToValidate="NameTextBox" Display="None" runat="server" Text="*"
            ErrorMessage="<span><b>Template Name</b> is required</span>" SetFocusOnError="true" ValidationGroup="Template">
        </asp:RequiredFieldValidator>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="Proposal_type_v20_UPDATE" UpdateCommandType="StoredProcedure"
        InsertCommand="Proposal_type_v20_INSERT" InsertCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:ControlParameter ControlID="NameTextBox" Name="Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="PaymentsScheduleListTextBox" Name="PaymentsScheduleList" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="PaymentsTextListTextBox" Name="PaymentsTextList" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBeginTextBox" Name="TextBegin" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextEndTextBox" Name="TextEnd" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboTandCtemplates" Name="tandcId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboPaymentSchedules" Name="paymentscheduleId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblTemplateId" Name="Id" PropertyName="Text" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="NameTextBox" Name="Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="PaymentsScheduleListTextBox" Name="PaymentsScheduleList" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="PaymentsTextListTextBox" Name="PaymentsTextList" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBeginTextBox" Name="TextBegin" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextEndTextBox" Name="TextEnd" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboTandCtemplates" Name="tandcId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboPaymentSchedules" Name="paymentscheduleId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTask" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id as TaskId, taskcode, '['+taskcode+'] '+Description as Description FROM Proposal_tasks WHERE (companyId = @companyId) and not Description is null ORDER BY taskcode">
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

    <asp:SqlDataSource ID="SqlDataSourceServiceFees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="PROPOSAL_types_details_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="PROPOSAL_types_details_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="PROPOSAL_types_details_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="PROPOSAL_types_details_Update" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="String" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblTemplateId" Name="Proposal_typeId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="phaseId"  />
            <asp:Parameter Name="taskId" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="DescriptionPlus" Type="String" />
            <asp:Parameter Name="Amount" Type="String" />
            <asp:Parameter Name="Hours" Type="String" />
            <asp:Parameter Name="Rates" Type="String" />
            <asp:Parameter Name="BillTypeId" Type="String" />
            <asp:Parameter Name="Id" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="cboPhase" Name="phaseId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblTemplateId" Name="Proposal_typeId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblTaskCode" Name="taskcode" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePhases" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], Code+' '+[Name] As Name From [Proposal_phases_template] where companyId = @companyId ">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTemplateId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblTaskCode" runat="server" Visible="False" Text="0"></asp:Label>

</asp:Content>

