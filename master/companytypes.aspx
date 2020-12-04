<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="companytypes.aspx.vb" Inherits="pasconcept20.companytypes" %>

<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td width="100%">
                <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1"
                    SelectedIndex="0" Width="100%">
                    <Tabs>
                        <telerik:RadTab Text="Types" Selected="True">
                        </telerik:RadTab>
                        <telerik:RadTab Text="Templates">
                        </telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" Width="100%">
                    <telerik:RadPageView ID="RadPageView1" runat="server">
                        <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
                            AllowAutomaticUpdates="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
                            GridLines="None" CellSpacing="0">
                            <ExportSettings>
                                <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                                    PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in" />
                            </ExportSettings>
                            <MasterTableView CommandItemDisplay="Top" DataKeyNames="Id" DataSourceID="SqlDataSource1">
                                <Columns>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                        HeaderText="Edit" ItemStyle-Width="20px">
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridBoundColumn DataField="Id" HeaderText="ID" SortExpression="Id" UniqueName="Id"
                                        DataType="System.Int32" ReadOnly="True">
                                        <ItemStyle Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column"
                                        HeaderText="Name" SortExpression="Name" UniqueName="Name">
                                        <EditItemTemplate>
                                            <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80"
                                                Width="400px">
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <ExpandCollapseColumn Resizable="False" Visible="False">
                                    <HeaderStyle Width="20px" />
                                </ExpandCollapseColumn>
                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                <RowIndicatorColumn Visible="False">
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <EditFormSettings>
                                    <EditColumn ButtonType="PushButton" UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                            </HeaderContextMenu>
                        </telerik:RadGrid>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView2" runat="server">
                        <table style="width: 100%">
                            <tr>
                                <td width="100%">&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="100%">Select Company Type:
                                    <telerik:RadComboBox ID="cboCompanyTypes" runat="server" DataSourceID="SqlDataSourceCompanyTypes"
                                        DataTextField="Name" DataValueField="Id" AutoPostBack="True" Width="200px">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td width="100%">&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <telerik:RadTabStrip ID="RadTabStripTemplates" runat="server" MultiPageID="RadMultiPageTemplates"
                                        SelectedIndex="0" Width="95%">
                                        <Tabs>
                                            <telerik:RadTab Text="Jobs Types" Selected="True">
                                            </telerik:RadTab>
                                            <telerik:RadTab Text="Proposal Task">
                                            </telerik:RadTab>
                                            <telerik:RadTab Text="Proposal Templates">
                                            </telerik:RadTab>
                                            <telerik:RadTab Text="Terms &amp; Conditios">
                                            </telerik:RadTab>
                                            <telerik:RadTab Text="Billings Schedules">
                                            </telerik:RadTab>
                                        </Tabs>
                                    </telerik:RadTabStrip>
                                    <telerik:RadMultiPage ID="RadMultiPageTemplates" runat="server" SelectedIndex="0"
                                        Width="95%">
                                        <telerik:RadPageView ID="RadPageView3" runat="server">
                                            <telerik:RadGrid ID="RadGridJobTypes" runat="server" AllowAutomaticDeletes="True"
                                                AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AutoGenerateColumns="False"
                                                DataSourceID="SqlDataSourceJobsTypes" GridLines="None" CellSpacing="0">
                                                <ExportSettings>
                                                    <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                                                        PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in" />
                                                </ExportSettings>
                                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="templateId" DataSourceID="SqlDataSourceJobsTypes">
                                                    <ExpandCollapseColumn Resizable="False" Visible="False">
                                                        <HeaderStyle Width="20px" />
                                                    </ExpandCollapseColumn>
                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                    <RowIndicatorColumn Visible="False">
                                                        <HeaderStyle Width="20px" />
                                                    </RowIndicatorColumn>
                                                    <Columns>
                                                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                                            HeaderText="Edit" ItemStyle-Width="20px">
                                                        </telerik:GridEditCommandColumn>
                                                        <telerik:GridBoundColumn DataField="Id" HeaderText="Job Code" SortExpression="Id"
                                                            UniqueName="Id" ItemStyle-Width="40px" HeaderStyle-HorizontalAlign="Center">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column"
                                                            HeaderText="Description" SortExpression="Name" UniqueName="Name">
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' Width="400px"
                                                                    MaxLength="80">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                                            CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                                        </telerik:GridButtonColumn>
                                                    </Columns>
                                                    <EditFormSettings>
                                                        <EditColumn ButtonType="PushButton" UniqueName="EditCommandColumn1">
                                                        </EditColumn>
                                                    </EditFormSettings>
                                                </MasterTableView>
                                                <FilterMenu EnableImageSprites="False">
                                                    <WebServiceSettings>
                                                        <ODataSettings InitialContainerName="">
                                                        </ODataSettings>
                                                    </WebServiceSettings>
                                                </FilterMenu>
                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                                    <WebServiceSettings>
                                                        <ODataSettings InitialContainerName="">
                                                        </ODataSettings>
                                                    </WebServiceSettings>
                                                </HeaderContextMenu>
                                            </telerik:RadGrid>
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="RadPageView4" runat="server">
                                            <telerik:RadGrid ID="RadGridProposalTtasks" runat="server" AllowAutomaticDeletes="True"
                                                AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AutoGenerateColumns="False"
                                                DataSourceID="SqlDataSourceProposalTtasks" GridLines="None" CellSpacing="0">
                                                <ExportSettings>
                                                    <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                                                        PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in" />
                                                </ExportSettings>
                                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="templateId" DataSourceID="SqlDataSourceProposalTtasks">
                                                    <ExpandCollapseColumn Resizable="False" Visible="False">
                                                        <HeaderStyle Width="20px" />
                                                    </ExpandCollapseColumn>
                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                    <RowIndicatorColumn Visible="False">
                                                        <HeaderStyle Width="20px" />
                                                    </RowIndicatorColumn>
                                                    <Columns>
                                                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                                            HeaderText="Edit" ItemStyle-Width="20px">
                                                        </telerik:GridEditCommandColumn>
                                                        <telerik:GridBoundColumn DataField="taskcode" HeaderText="Task ID" SortExpression="taskcode"
                                                            UniqueName="taskcode" ItemStyle-Width="40px" HeaderStyle-HorizontalAlign="Center">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                                                            HeaderText="Description" SortExpression="Description" UniqueName="Description">
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Description") %>'
                                                                    MaxLength="80" Width="600px">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn DataField="DescriptionPlus" Display="False" HeaderText="Description Plus"
                                                            SortExpression="DescriptionPlus" UniqueName="DescriptionPlus">
                                                            <ItemTemplate>
                                                                <asp:Label ID="DescriptionPlusLabel" runat="server" Text='<%# Eval("DescriptionPlus") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="DescriptionPlusTextBox" runat="server" Text='<%# Bind("DescriptionPlus") %>'
                                                                    TextMode="MultiLine" Width="600px" Rows="15">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn DataField="Hours" DataType="System.Double" HeaderText="Hours"
                                                            SortExpression="Hours" UniqueName="Hours" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="40px"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Rates" DataType="System.Double" HeaderText="Hours Rates"
                                                            SortExpression="Rates" UniqueName="Rates" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="40px"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridCheckBoxColumn DataField="HourRatesService" DataType="System.Boolean"
                                                            HeaderText="Hour Rates Service" SortExpression="HourRatesService" UniqueName="HourRatesService"
                                                            ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="40px"></ItemStyle>
                                                        </telerik:GridCheckBoxColumn>
                                                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                                            CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                                        </telerik:GridButtonColumn>
                                                    </Columns>
                                                    <EditFormSettings>
                                                        <EditColumn ButtonType="PushButton" UniqueName="EditCommandColumn1">
                                                        </EditColumn>
                                                    </EditFormSettings>
                                                </MasterTableView>
                                                <FilterMenu EnableImageSprites="False">
                                                    <WebServiceSettings>
                                                        <ODataSettings InitialContainerName="">
                                                        </ODataSettings>
                                                    </WebServiceSettings>
                                                </FilterMenu>
                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                                    <WebServiceSettings>
                                                        <ODataSettings InitialContainerName="">
                                                        </ODataSettings>
                                                    </WebServiceSettings>
                                                </HeaderContextMenu>
                                            </telerik:RadGrid>
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="RadPageView5" runat="server">
                                            <telerik:RadGrid ID="RadGridProposalTemplates" runat="server" AllowAutomaticDeletes="True"
                                                AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AutoGenerateColumns="False"
                                                DataSourceID="SqlDataSourceProposalTemplates" GridLines="None" CellSpacing="0">
                                                <ExportSettings>
                                                    <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                                                        PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in" />
                                                </ExportSettings>
                                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="templateId" DataSourceID="SqlDataSourceProposalTemplates">
                                                    <ExpandCollapseColumn Resizable="False" Visible="False">
                                                        <HeaderStyle Width="20px" />
                                                    </ExpandCollapseColumn>
                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                    <RowIndicatorColumn Visible="False">
                                                        <HeaderStyle Width="20px" />
                                                    </RowIndicatorColumn>
                                                    <Columns>
                                                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                                            HeaderText="Edit" ItemStyle-Width="20px">
                                                        </telerik:GridEditCommandColumn>
                                                        <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column"
                                                            HeaderText="Description" SortExpression="Name" UniqueName="Name">
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80"
                                                                    Width="650px">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="NameLabel1" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn DataField="TaskIdList" FilterControlAltText="Filter TaskIdList column"
                                                            HeaderText="Related Task ID" SortExpression="TaskIdList" UniqueName="TaskIdList"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <EditItemTemplate>
                                                                <telerik:RadDockLayout runat="server" ID="RadDockLayout1">
                                                                    <table style="width: 100%">
                                                                        <tr>
                                                                            <td class="Pequena">To find out the 'task id' codes, show 'Task List'
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td valign="top">
                                                                                <telerik:RadTextBox ID="TaskIdListTextBox" runat="server" EmptyMessage="Insert 'task id' separated by commas; e.g. 201,202,203"
                                                                                    MaxLength="255" Text='<%# Bind("TaskIdList") %>' TextMode="MultiLine" Width="198px">
                                                                                </telerik:RadTextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </telerik:RadDockLayout>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="TaskIdListLabel" runat="server" Text='<%# Eval("TaskIdList") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn DataField="PaymentsScheduleList" FilterControlAltText="Filter PaymentsScheduleList column"
                                                            HeaderText="Payment Schedule(%)" SortExpression="PaymentsScheduleList" UniqueName="PaymentsScheduleList">
                                                            <EditItemTemplate>
                                                                <b>To change, select Payment Schedules:</b>&nbsp;
                                                                    <telerik:RadComboBox ID="cboPaymentSchedules" runat="server" DataSourceID="SqlDataSourcePaymentSchedules"
                                                                        DataTextField="Name" DataValueField="templateId" Width="180px" MarkFirstMatch="True"
                                                                        Filter="Contains" 
                                                                        Height="300px" EnableAutomaticLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true" ItemsPerRequest="20">
                                                                    </telerik:RadComboBox>
                                                                &nbsp; &nbsp;
                                                                        <telerik:RadButton ID="btnGeneratePaymentSchedules" runat="server" Text="Generate" Width="100px" CommandName="GeneratePaymentSchedules"
                                                                            OnClick="btnPaymentSchedules_Click" />
                                                                <br />
                                                                <telerik:RadTextBox ID="PaymentsScheduleListTextBox" runat="server" Text='<%# Bind("PaymentsScheduleList") %>'
                                                                    MaxLength="50" Width="650px" EmptyMessage="Insert payments percentages separated by commas; e.g. 50,50">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="PaymentsScheduleListLabel" runat="server" Text='<%# Eval("PaymentsScheduleList") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn DataField="PaymentsTextList" Display="False" HeaderText="Schedule Description"
                                                            SortExpression="PaymentsTextList" UniqueName="PaymentsTextList">
                                                            <ItemTemplate>
                                                                <asp:Label ID="PaymentsTextListLabel" runat="server" Text='<%# Eval("PaymentsTextList") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="PaymentsTextListTextBox" runat="server" Text='<%# Bind("PaymentsTextList") %>'
                                                                    TextMode="MultiLine" Width="650px" Rows="4" MaxLength="512" EmptyMessage="Insert descriptions of payments separated by commas; e.g. Due at Time of Signed Contract Agreement,50% Due at 100% Submittal">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn DataField="TextBegin" Display="False" HeaderText="Proposal Introductory Text"
                                                            SortExpression="TextBegin" UniqueName="TextBegin">
                                                            <ItemTemplate>
                                                                <asp:Label ID="TextBeginLabel" runat="server" Text='<%# Eval("TextBegin") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="TextBeginTextBox" runat="server" Text='<%# Bind("TextBegin") %>'
                                                                    TextMode="MultiLine" Rows="4" Width="650px">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn DataField="TextEnd" Display="False" HeaderText="Proposal Concluding Text"
                                                            SortExpression="TextEnd" UniqueName="TextEnd">
                                                            <ItemTemplate>
                                                                <asp:Label ID="TextEndLabel" runat="server" Text='<%# Eval("TextEnd") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="TextEndTextBox" runat="server" Height="75px" Text='<%# Bind("TextEnd") %>'
                                                                    TextMode="MultiLine" Rows="4" Width="650px">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn DataField="Agreement" Display="False" HeaderText="Terms &amp; Conditions"
                                                            SortExpression="Agreement" UniqueName="Agreement">
                                                            <ItemTemplate>
                                                                <asp:Label ID="AgreementLabel" runat="server" Text='<%# Eval("Agreement") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <panel id="panelTancC" runat="server">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <table width="650px">
                                                                                    <tr>
                                                                                        <td align="right" width="230px">
                                                                                            <b>To change, select any T&C template:</b>
                                                                                        </td>
                                                                                        <td width="300px">
                                                                                            <telerik:RadComboBox ID="cboTandCtemplates" runat="server" Width="280px" DataSourceID="SqlDataSourceTandCTemplates"
                                                                                                DataTextField="Name" DataValueField="templateId">
                                                                                            </telerik:RadComboBox>
                                                                                        </td>
                                                                                        <td>
                                                                                            <telerik:RadButton ID="btnUpdateTandCTemplate" runat="server" Text="Change T &amp; C" 
                                                                                                CommandName="UpdateTandC" OnClick="btnUpdateTandCTemplate_Click">
                                                                                                <Icon PrimaryIconCssClass="rbSave" PrimaryIconLeft="4"  PrimaryIconTop="4"></Icon>
                                                                                            </telerik:RadButton>
                                                           
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <telerik:RadEditor ID="gridEditor_TandC" runat="server" Content='<%# Bind("Agreement") %>'
                                                                                    Height="300px" ToolsFile="~/BasicTools.xml" AllowScripts="True" EditModes="Design,Preview"
                                                                                    Width="650px" RenderMode="Auto">
                                                                                </telerik:RadEditor>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </panel>
                                                            </EditItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                                            CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                                        </telerik:GridButtonColumn>
                                                    </Columns>
                                                    <EditFormSettings>
                                                        <EditColumn ButtonType="PushButton" UniqueName="EditCommandColumn1">
                                                        </EditColumn>
                                                    </EditFormSettings>
                                                </MasterTableView>
                                                <FilterMenu EnableImageSprites="False">
                                                    <WebServiceSettings>
                                                        <ODataSettings InitialContainerName="">
                                                        </ODataSettings>
                                                    </WebServiceSettings>
                                                </FilterMenu>
                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                                    <WebServiceSettings>
                                                        <ODataSettings InitialContainerName="">
                                                        </ODataSettings>
                                                    </WebServiceSettings>
                                                </HeaderContextMenu>
                                            </telerik:RadGrid>
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="RadPageView6" runat="server">
                                            <telerik:RadGrid ID="RadGridTandCTemplates" runat="server" AllowAutomaticDeletes="True"
                                                AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AutoGenerateColumns="False"
                                                DataSourceID="SqlDataSourceTandCTemplates" GridLines="None" CellSpacing="0">
                                                <ExportSettings>
                                                    <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                                                        PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in" />
                                                </ExportSettings>
                                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="templateId" DataSourceID="SqlDataSourceTandCTemplates">
                                                    <ExpandCollapseColumn Resizable="False" Visible="False">
                                                        <HeaderStyle Width="20px" />
                                                    </ExpandCollapseColumn>
                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                    <RowIndicatorColumn Visible="False">
                                                        <HeaderStyle Width="20px" />
                                                    </RowIndicatorColumn>
                                                    <Columns>
                                                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                                            HeaderText="Edit" ItemStyle-Width="20px">
                                                        </telerik:GridEditCommandColumn>
                                                        <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column"
                                                            HeaderText="Name" SortExpression="Name" UniqueName="Name">
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80"
                                                                    Width="600px">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="NameLabel2" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn DataField="Descripction" Display="False" HeaderText="Terms &amp; Conditions"
                                                            SortExpression="Descripction" UniqueName="Descripction">
                                                            <ItemTemplate>
                                                                <asp:Label ID="DescripctionLabel" runat="server" Text='<%# Eval("Descripction")%>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadEditor ID="gridEditor_Saludo" runat="server" Content='<%# Bind("Descripction")%>'
                                                                    Height="300px" ToolsFile="~/BasicTools.xml" AllowScripts="True" EditModes="Design,Preview" RenderMode="Auto"
                                                                    Width="600px">
                                                                </telerik:RadEditor>
                                                            </EditItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                                            CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                                        </telerik:GridButtonColumn>
                                                    </Columns>
                                                    <EditFormSettings>
                                                        <EditColumn ButtonType="PushButton" UniqueName="EditCommandColumn1">
                                                        </EditColumn>
                                                    </EditFormSettings>
                                                </MasterTableView>
                                                <FilterMenu EnableImageSprites="False">
                                                    <WebServiceSettings>
                                                        <ODataSettings InitialContainerName="">
                                                        </ODataSettings>
                                                    </WebServiceSettings>
                                                </FilterMenu>
                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                                    <WebServiceSettings>
                                                        <ODataSettings InitialContainerName="">
                                                        </ODataSettings>
                                                    </WebServiceSettings>
                                                </HeaderContextMenu>
                                            </telerik:RadGrid>
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="RadPageView7" runat="server">
                                            <telerik:RadGrid ID="RadGridInvoicesTypes" runat="server" AllowAutomaticDeletes="True"
                                                AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AutoGenerateColumns="False"
                                                DataSourceID="SqlDataSourceInvoicesTypes" GridLines="None" CellSpacing="0">
                                                <ExportSettings>
                                                    <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                                                        PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in" />
                                                </ExportSettings>
                                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="templateId" DataSourceID="SqlDataSourceInvoicesTypes">
                                                    <ExpandCollapseColumn Resizable="False" Visible="False">
                                                        <HeaderStyle Width="20px" />
                                                    </ExpandCollapseColumn>
                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                    <RowIndicatorColumn Visible="False">
                                                        <HeaderStyle Width="20px" />
                                                    </RowIndicatorColumn>
                                                    <Columns>
                                                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                                            HeaderText="Edit" ItemStyle-Width="20px">
                                                        </telerik:GridEditCommandColumn>
                                                        <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column"
                                                            HeaderText="Billing Schedule Name" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-Width="150px">
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' Width="400px"
                                                                    MaxLength="80" EmptyMessage="Insert billing name; e.g. 30%, 60%, 10%">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="NameLabel3" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn DataField="PaymentsScheduleList" FilterControlAltText="Filter PaymentsScheduleList column"
                                                            HeaderText="Schedule List" SortExpression="PaymentsScheduleList" UniqueName="PaymentsScheduleList"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="PaymentsScheduleListTextBox" runat="server" Text='<%# Bind("PaymentsScheduleList") %>' ToolTip="Insert billing percentages separated by commas(,)"
                                                                    Width="400px" MaxLength="50" EmptyMessage="Insert billing percentages separated by commas(,) e.g. 30,60,10">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="PaymentsScheduleListLabel" runat="server" Text='<%# Eval("PaymentsScheduleList") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn DataField="PaymentsTextList" Display="False" HeaderText="Schedule Description"
                                                            SortExpression="PaymentsTextList" UniqueName="PaymentsTextList">
                                                            <ItemTemplate>
                                                                <asp:Label ID="PaymentsTextListLabel" runat="server" Text='<%# Eval("PaymentsTextList") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="PaymentsTextListTextBox" runat="server" Text='<%# Bind("PaymentsTextList") %>' ToolTip="Insert descriptions of percentages separated by commas(,)"
                                                                    Width="400px" TextMode="MultiLine" MaxLength="512" Rows="4" EmptyMessage="Insert descriptions of percentages separated by commas(,) e.g. Due at time of signed contract,Due at time of project submittal,Due at time of project approval">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                                            CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                                        </telerik:GridButtonColumn>
                                                    </Columns>
                                                    <EditFormSettings>
                                                        <EditColumn ButtonType="PushButton" UniqueName="EditCommandColumn1">
                                                        </EditColumn>
                                                    </EditFormSettings>
                                                </MasterTableView>
                                                <FilterMenu EnableImageSprites="False">
                                                    <WebServiceSettings>
                                                        <ODataSettings InitialContainerName="">
                                                        </ODataSettings>
                                                    </WebServiceSettings>
                                                </FilterMenu>
                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                                    <WebServiceSettings>
                                                        <ODataSettings InitialContainerName="">
                                                        </ODataSettings>
                                                    </WebServiceSettings>
                                                </HeaderContextMenu>
                                            </telerik:RadGrid>
                                        </telerik:RadPageView>
                                    </telerik:RadMultiPage>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Company_types_DELETE" DeleteCommandType="StoredProcedure" 
        InsertCommand="INSERT INTO [Company_types] ([Name]) VALUES (@Name)"
        SelectCommand="SELECT * FROM [Company_types] ORDER BY [Name]" UpdateCommand="UPDATE [Company_types] SET [Name] = @Name WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCompanyTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Company_types]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTandCTemplates" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Company_Proposal_TandC_TEMPLATE] WHERE [templateId] = @templateId"
        InsertCommand="INSERT INTO [Company_Proposal_TandC_TEMPLATE] ([Name], [Descripction], [companyType]) VALUES (@Name, @Descripction, @companyType)"
        SelectCommand="SELECT [templateId], [Name], [Descripction] FROM [Company_Proposal_TandC_TEMPLATE] WHERE ([companyType] = @companyType) ORDER BY [Name]"
        UpdateCommand="UPDATE [Company_Proposal_TandC_TEMPLATE] SET [Name] = @Name, [Descripction] = @Descripction WHERE [templateId] = @templateId">
        <DeleteParameters>
            <asp:Parameter Name="templateId" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Descripction" Type="String" />
            <asp:ControlParameter ControlID="cboCompanyTypes" Name="companyType" PropertyName="SelectedValue"
                Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboCompanyTypes" Name="companyType" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Descripction" Type="String" />
            <asp:Parameter Name="templateId" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobsTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Company_Jobs_types_TEMPLATE] WHERE [templateId] = @templateId"
        InsertCommand="INSERT INTO Company_Jobs_types_TEMPLATE(Id, Name, companyType) VALUES (@Id, @Name, @companyTypeId)"
        SelectCommand="SELECT [templateId], [Id], [Name] FROM [Company_Jobs_types_TEMPLATE] WHERE ([companyType] = @companyType) ORDER BY [Name]"
        UpdateCommand="UPDATE Company_Jobs_types_TEMPLATE SET Id = @Id, Name = @Name WHERE (templateId = @templateId)">
        <DeleteParameters>
            <asp:Parameter Name="templateId" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Id" Type="String" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:ControlParameter ControlID="cboCompanyTypes" Name="companyTypeId" PropertyName="SelectedValue" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboCompanyTypes" Name="companyType" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="String" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="templateId" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceInvoicesTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Company_Invoices_types_TEMPLATE] WHERE [templateId] = @templateId"
        InsertCommand="INSERT INTO [Company_Invoices_types_TEMPLATE] ([Name], [PaymentsScheduleList], [PaymentsTextList], [companyType]) VALUES (@Name, @PaymentsScheduleList, @PaymentsTextList, @companyType)"
        SelectCommand="SELECT [templateId], [Name], [PaymentsScheduleList], [PaymentsTextList], [companyType] FROM [Company_Invoices_types_TEMPLATE] WHERE ([companyType] = @companyType) ORDER BY [Name]"
        UpdateCommand="UPDATE [Company_Invoices_types_TEMPLATE] SET [Name] = @Name, [PaymentsScheduleList] = @PaymentsScheduleList, [PaymentsTextList] = @PaymentsTextList WHERE [templateId] = @templateId">
        <DeleteParameters>
            <asp:Parameter Name="templateId" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="PaymentsScheduleList" Type="String" />
            <asp:Parameter Name="PaymentsTextList" Type="String" />
            <asp:ControlParameter ControlID="cboCompanyTypes" Name="companyType" PropertyName="SelectedValue"
                Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboCompanyTypes" Name="companyType" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="PaymentsScheduleList" Type="String" />
            <asp:Parameter Name="PaymentsTextList" Type="String" />
            <asp:Parameter Name="templateId" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProposalTtasks" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Company_Proposal_tasks_TEMPLATE] WHERE [templateId] = @templateId"
        InsertCommand="INSERT INTO Company_Proposal_tasks_TEMPLATE(taskcode, Description, DescriptionPlus, Hours, Rates, HourRatesService, companyType) VALUES (@taskcode, @Description, @DescriptionPlus, @Hours, @Rates, @HourRatesService, @companyType)"
        SelectCommand="SELECT [templateId], [taskcode], [Description], [DescriptionPlus], [Hours], [Rates], [HourRatesService], [companyType] FROM [Company_Proposal_tasks_TEMPLATE] WHERE ([companyType] = @companyType) ORDER BY [taskcode]"
        UpdateCommand="UPDATE Company_Proposal_tasks_TEMPLATE SET taskcode = @taskcode, Description = @Description, DescriptionPlus = @DescriptionPlus, Hours = @Hours, Rates = @Rates, HourRatesService = @HourRatesService WHERE (templateId = @templateId)">
        <DeleteParameters>
            <asp:Parameter Name="templateId" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="taskcode" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="DescriptionPlus" Type="String" />
            <asp:Parameter Name="Hours" Type="Double" />
            <asp:Parameter Name="Rates" Type="Double" />
            <asp:Parameter Name="HourRatesService" Type="Boolean" />
            <asp:ControlParameter ControlID="cboCompanyTypes" Name="companyType" PropertyName="SelectedValue"
                Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboCompanyTypes" Name="companyType" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="taskcode" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="DescriptionPlus" Type="String" />
            <asp:Parameter Name="Hours" Type="Double" />
            <asp:Parameter Name="Rates" Type="Double" />
            <asp:Parameter Name="HourRatesService" Type="Boolean" />
            <asp:Parameter Name="templateId" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProposalTemplates" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Company_Proposal_types_TEMPLATE] WHERE [templateId] = @templateId"
        InsertCommand="INSERT INTO [Company_Proposal_types_TEMPLATE] ([Name], [TaskIdList], [PaymentsScheduleList], [PaymentsTextList], [TextBegin], [TextEnd], [Agreement], [companyType]) VALUES (@Name, @TaskIdList, @PaymentsScheduleList, @PaymentsTextList, @TextBegin, @TextEnd, @Agreement, @companyType)"
        SelectCommand="SELECT [templateId], [Name], [TaskIdList], [PaymentsScheduleList], [PaymentsTextList], [TextBegin], [TextEnd], [Agreement], [companyType] FROM [Company_Proposal_types_TEMPLATE] WHERE ([companyType] = @companyType) ORDER BY [Name]"
        UpdateCommand="UPDATE [Company_Proposal_types_TEMPLATE] SET [Name] = @Name, [TaskIdList] = @TaskIdList, [PaymentsScheduleList] = @PaymentsScheduleList, [PaymentsTextList] = @PaymentsTextList, [TextBegin] = @TextBegin, [TextEnd] = @TextEnd, [Agreement] = @Agreement  WHERE [templateId] = @templateId">
        <DeleteParameters>
            <asp:Parameter Name="templateId" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="TaskIdList" Type="String" />
            <asp:Parameter Name="PaymentsScheduleList" Type="String" />
            <asp:Parameter Name="PaymentsTextList" Type="String" />
            <asp:Parameter Name="TextBegin" Type="String" />
            <asp:Parameter Name="TextEnd" Type="String" />
            <asp:Parameter Name="Agreement" Type="String" />
            <asp:ControlParameter ControlID="cboCompanyTypes" Name="companyType" PropertyName="SelectedValue"
                Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboCompanyTypes" Name="companyType" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="TaskIdList" Type="String" />
            <asp:Parameter Name="PaymentsScheduleList" Type="String" />
            <asp:Parameter Name="PaymentsTextList" Type="String" />
            <asp:Parameter Name="TextBegin" Type="String" />
            <asp:Parameter Name="TextEnd" Type="String" />
            <asp:Parameter Name="Agreement" Type="String" />
            <asp:Parameter Name="templateId" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePaymentSchedules" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT templateId, Name FROM Company_Invoices_types_TEMPLATE WHERE (companyType = @companyType) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboCompanyTypes" Name="companyType" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
