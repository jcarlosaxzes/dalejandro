<%@ Page Title="Billing Assistant" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="billingmanager.aspx.vb" Inherits="pasconcept20.billingmanager" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        @media print {
            a[href]:after {
                content: none !important
            }
        }
    </style>

    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">

            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGridInvoices.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }
        </script>
    </telerik:RadCodeBlock>
    <div class="pasconcept-bar">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td class="PanelFilter">
                    <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh" CssClass="noprint">
                        <div>

                            <telerik:RadComboBox ID="cboClients" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceClient" ToolTip="Clients"
                                DataTextField="Name" DataValueField="Id" Filter="Contains" Height="250px" MarkFirstMatch="True" Width="200px" DropDownAutoWidth="Enabled">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Clients...)" Value="-1" />
                                </Items>
                            </telerik:RadComboBox>

                            &nbsp;

                                <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" ToolTip="Departments"
                                    Width="250px" CheckBoxes="true" Height="300px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains" EmptyMessage="(All Departments...)">
                                    <Localization AllItemsCheckedString="All Items Checked" CheckAllString="Check All..." ItemsCheckedString="departments checked"></Localization>
                                </telerik:RadComboBox>

                            &nbsp;

                                <telerik:RadComboBox ID="cboStatus" runat="server" DataSourceID="SqlDataSourceJobStatus" DataTextField="Name" DataValueField="Id"
                                    Width="150px" AppendDataBoundItems="true" ToolTip="Job Status">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Active Status...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>

                            &nbsp;
                                <telerik:RadComboBox ID="cboPasDueStatus" runat="server" ToolTip="Past Due Status"
                                    Width="250px" CheckBoxes="true" Height="300px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains">
                                    <Localization AllItemsCheckedString="All Past Due Checked" CheckAllString="Check All..." ItemsCheckedString="PastDue status checked"></Localization>
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Final Past Due (5)" Value="5" Checked="true" />
                                        <telerik:RadComboBoxItem runat="server" Text="90 Days Past Due (4)" Value="4" Checked="true" />
                                        <telerik:RadComboBoxItem runat="server" Text="60 Days Past Due (3)" Value="3" Checked="true" />
                                        <telerik:RadComboBoxItem runat="server" Text="First Past Due (2)" Value="2" Checked="true" />
                                        <telerik:RadComboBoxItem runat="server" Text="Pending to Emit (1)" Value="1" Checked="true" />
                                        <telerik:RadComboBoxItem runat="server" Text="Recently notified (0)" Value="0" Checked="false" />
                                    </Items>
                                </telerik:RadComboBox>

                            &nbsp;

                                <telerik:RadTextBox ID="txtFind" runat="server" EmptyMessage="Search for Invoice Number, Job Name, Client Name, ..."
                                    Width="250px" x-webkit-speech="x-webkit-speech">
                                </telerik:RadTextBox>



                            <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Search
                            </asp:LinkButton>

                        </div>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
    <div class="pasconcept-bar noprint">

        <span class="pasconcept-pagetitle" style="padding-left: 250px;">Billing Assistant</span>

    </div>

    <telerik:RadWizard ID="RadWizard1" runat="server" Width="100%" Height="800px" RenderMode="Lightweight" Skin="Silk"
        DisplayProgressBar="false" DisplayCancelButton="false" DisplayNavigationButtons="false">
        <WizardSteps>
            <telerik:RadWizardStep runat="server" Title="Reminders">
                <table>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkEmployeeRemaindersOnly" runat="server" Checked="true" Text="&nbsp;Show only my reminders" />
                        </td>
                    </tr>
                </table>
                <div style="padding-top: 5px">
                    <telerik:RadGrid ID="RadGridRemainders" runat="server" Skin="Bootstrap" AutoGenerateColumns="False" Height="650px"
                        DataSourceID="SqlDataSourceRemainders" AllowSorting="True" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                        PageSize="100" AllowPaging="true" AllowMultiRowSelection="true" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                        <ClientSettings Selecting-AllowRowSelect="true">
                            <Scrolling AllowScroll="True"></Scrolling>
                        </ClientSettings>

                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceRemainders" CommandItemDisplay="None" ShowFooter="True">
                            <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                            <Columns>
                                <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                                </telerik:GridBoundColumn>

                                <telerik:GridTemplateColumn DataField="Notes" FilterControlAltText="Filter ClientContactName column"
                                    HeaderText="Contact and Notes" SortExpression="ClientContactName" UniqueName="Notes" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>

                                        <asp:LinkButton ID="btnEditRemaider" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to Edit Remainder"
                                            CommandName="Edit" UseSubmitBehavior="false">
                                             <i class="fas fa-pen"></i>
                                        </asp:LinkButton>
                                        <%# Eval("ClientContactName")%>
                                        <br />
                                        <span class="small font-italic"><%# Eval("Notes")%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="employeeId" FilterControlAltText="Filter Employee column" HeaderStyle-Width="200px"
                                    HeaderText="Employee<br/>Date Created" SortExpression="Employee" UniqueName="employeeId" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%# Eval("Employee")%>
                                        <br />
                                        <%# Eval("DateCreated","{0:d}")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="AmountDue" HeaderText="Number<br/>Amount Due"
                                    SortExpression="AmountDue" UniqueName="AmountDue"
                                    Groupable="False" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# Eval("recordtypetitle")%>:
                                        <a href='<%# LocalAPI.GetSharedLink_URL(Eval("recordtypeId"),Eval("sourceId"))%>' target="_blank" title="view Invoice/statement"><%# Eval("InvoiceNumber")%></a>
                                        <br />
                                        <%# Eval("AmountDue", "{0:C2}")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridDateTimeColumn DataField="Remainder" DataType="System.DateTime" FilterControlAltText="Filter Remainder column"
                                    HeaderText="Reminder" SortExpression="Remainder" UniqueName="Remainder" PickerType="DatePicker" DataFormatString="{0:d}"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridDateTimeColumn>
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this record?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings EditFormType="Template">
                                <FormTemplate>
                                    <table class="table-sm" style="width: 100%">
                                        <tr>
                                            <td style="width: 150px; text-align: right">Notes
                                            </td>
                                            <td style="width: 600px;">
                                                <telerik:RadTextBox ID="txtEditRemainderNotes" runat="server" Width="100%" MaxLength="1024" Rows="8" TextMode="MultiLine" Text='<%# Bind("Notes") %>'>
                                                </telerik:RadTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEditRemainderNotes" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">Remainder:
                                            </td>
                                            <td>
                                                <telerik:RadDatePicker ID="RadDatePickerMaturityDate" runat="server" DbSelectedDate='<%# Bind("Remainder") %>'>
                                                </telerik:RadDatePicker>

                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right" colspan="3">
                                                <asp:LinkButton ID="btnSendRemaiderAgain" runat="server" CommandName="Update" CommandArgument='<%# Eval("Id") %>' ToolTip="Update changes and Send Email to client with Notes"
                                                    CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                                        <i class="far fa-envelope"></i> Update & Send
                                                </asp:LinkButton>


                                                &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="btnUpdate" Text="Update" runat="server" CommandName="Update"></asp:LinkButton>&nbsp;
                                                <asp:LinkButton ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" CommandName="Cancel"></asp:LinkButton>

                                            </td>

                                        </tr>
                                    </table>
                                </FormTemplate>
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </telerik:RadWizardStep>
            <telerik:RadWizardStep runat="server" Title="Invoices">
                <table style="width: 100%">
                    <tr class="noprint">
                        <td style="width: 120px">

                            <asp:LinkButton ID="btnEmail" runat="server" ToolTip="Send Email with Invoice information to selected records" Width="100px"
                                CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                    <i class="far fa-envelope"></i> Email
                            </asp:LinkButton>
                        </td>
                        <td style="width: 120px">

                            <asp:LinkButton ID="btnBadDebt" runat="server" ToolTip="Mark selected records like BadDebt" Width="100px"
                                CssClass="btn btn-danger btn" UseSubmitBehavior="false">
                                    <i class="far fa-thumbs-down"></i> BadDebt
                            </asp:LinkButton>
                        </td>
                        <td style="width: 120px">
                            <asp:LinkButton ID="btnReceivePayment" runat="server" ToolTip="Receive Payment to selected records" Width="100px"
                                CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                                    <i class="fas fa-dollar-sign"></i> Payment
                            </asp:LinkButton>
                        </td>
                        <td style="width: 120px">
                            <asp:LinkButton ID="btnStatement" runat="server" ToolTip="Convert to Statement the selected records" Width="100px"
                                CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                                    <i class="far fa-list-alt"></i> Statement
                            </asp:LinkButton>
                        </td>
                        <td style="width: 180px">
                            <telerik:RadNumericTextBox ID="txtEmissionRecurrenceDays" runat="server" Value="15" Width="30px" MaxLength="2" MinValue="0" MaxValue="99" ToolTip="Frequency days of automated email reccurence (Schedule)">
                                <NumberFormat DecimalDigits="0" />
                            </telerik:RadNumericTextBox>
                            <asp:LinkButton ID="btnSchedule" runat="server" ToolTip="Create recuring invoice emmisions every period (days)" Width="100px"
                                CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                                    <i class="far fa-calendar-alt"></i></span> Schedule
                            </asp:LinkButton>
                        </td>
                        <td style="width: 120px">
                            <asp:LinkButton ID="btnClientInvoicesUnhide" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false" ToolTip="Show all hidden clients " Width="80px">
                                        <i class="far fa-eye"></i>Unhide
                            </asp:LinkButton>
                        </td>
                        <td style="text-align: right">
                            <asp:LinkButton ID="btnExportInvoices" runat="server" ToolTip="Export records to Excel" Width="100px"
                                CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                    <i class="fas fa-download"></i> Export
                            </asp:LinkButton>
                        </td>

                    </tr>
                </table>
                <div style="padding-top: 5px">
                    <telerik:RadGrid ID="RadGridInvoices" runat="server" Skin="Bootstrap" AutoGenerateColumns="False" Height="650px"
                        DataSourceID="SqlDataSourceMainInvoice" AllowSorting="True"
                        PageSize="100" AllowPaging="true" AllowMultiRowSelection="true" ItemStyle-Font-Size="x-Small" AlternatingItemStyle-Font-Size="x-Small" FooterStyle-Font-Size="Small">
                        <ClientSettings Selecting-AllowRowSelect="true">
                            <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                        </ClientSettings>
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceMainInvoice" CommandItemDisplay="None" ShowFooter="True">
                            <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                            <Columns>
                                <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                                </telerik:GridBoundColumn>
                                <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Medium">
                                </telerik:GridClientSelectColumn>
                                <telerik:GridTemplateColumn DataField="InvoiceNumber" Aggregate="Count" FooterAggregateFormatString="{0:N0}" FilterControlAltText="Filter InvoiceNumber column" HeaderText="Invoice<br/>PastDue" SortExpression="InvoiceNumber" UniqueName="InvoiceNumber"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="130px" ItemStyle-Font-Size="Small">
                                    <ItemTemplate>
                                        <%--  <asp:LinkButton ID="btnEditInvoice" runat="server" CommandName="EditInvoice" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false">
                                                <%# Eval("InvoiceNumber")%>
                                        </asp:LinkButton>--%>
                                        <a href='<%# LocalAPI.GetSharedLink_URL(4,Eval("Id"))%>' target="_blank" title="view invoice"><%# Eval("InvoiceNumber")%></a>
                                        <br />
                                        <span title='<%# Eval("PastDueStatusTitle") %>' class="label badge-<%# IIf(Eval("PastDueStatus") = 5, "danger", IIf(Eval("PastDueStatus") = 4, "warning", IIf(Eval("PastDueStatus") = 3, "primary", IIf(Eval("PastDueStatus") = 2, "info", IIf(Eval("PastDueStatus") = 1, "default", "success"))))) %>"><%# Eval("PastDueStatusName") %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridBoundColumn DataField="JobId" DataType="System.Int32" HeaderText="JobId" ReadOnly="True" UniqueName="JobId" Display="false" HeaderStyle-Width="40px">
                                </telerik:GridBoundColumn>

                                <telerik:GridTemplateColumn DataField="JobName" FilterControlAltText="Filter JobName column" HeaderText="Job Info" SortExpression="JobName" UniqueName="JobName" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <a href='<%# LocalAPI.GetSharedLink_URL(7,Eval("JobId"))%>' target="_blank" title="view Job Roll-Up"><%# Eval("Code")%></a>
                                            <%# Eval("JobName") %>
                                        </div>
                                        <div>
                                            <span class="badge badge-warning"><%#Eval("nStatus")%></span>
                                            <%#Eval("ProjectManager") %>
                                        </div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="ClientName" FilterControlAltText="Filter ClientName column" HeaderText="Client Info" SortExpression="ClientName" UniqueName="ClientName"
                                    HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="btnNewRemainder" runat="server" UseSubmitBehavior="false" ToolTip="Schedule a new reminder"
                                                CommandName="NewInvoiceRemaider" CommandArgument='<%# Eval("Id")%>'>
                                                <i class="far fa-calendar-alt"></i>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnNewInvoiceEmail" runat="server" UseSubmitBehavior="false" ToolTip="Individual Email to Client"
                                                CommandName="NewInvoiceEmail" CommandArgument='<%# Eval("Id")%>'>
                                                <i class="far fa-envelope"></i>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnHideInvoiceClient" runat="server" CommandArgument='<%# Eval("ClientId")%>' ToolTip="Hide client from list"
                                                CommandName="HideInvoiceClient" UseSubmitBehavior="false">
                                                    <i class="fas fa-eye-slash"></i>
                                            </asp:LinkButton>

                                            <telerik:RadLabel runat="server" ID="RadLabel4" Text='<%# Eval("ClientName") %>' ToolTip='<%#Eval("ClientCompany")%>'></telerik:RadLabel>
                                        </div>
                                        <div>
                                            <i class="fas fa-phone"></i></a>
                                            <%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("ClientPhone"))%>
                                            &nbsp;
                                            <i class="fas fa-mobile-alt"></i></a>
                                            <%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("ClientCellular"))%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn DataField="Budget" HeaderText="Budget<br/>Balance" SortExpression="Budget" UniqueName="Budget"
                                    Groupable="False" Aggregate="Sum" FooterAggregateFormatString="{0:N2}"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <div><%# Eval("Budget", "{0:N2}")%></div>
                                        <div><%# Eval("Balance", "{0:N2}")%></div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="FirstEmission" DataType="System.DateTime" HeaderText="First<br/>Last"
                                    SortExpression="FirstEmission" UniqueName="FirstEmission"
                                    Groupable="False" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div><%#Eval("FirstEmission","{0:MM/dd/yyyy}") %> <span title="Emitted count" class="badge badge-default"><%# Eval("Emitted") %></span></div>
                                        <div><%#Eval("LatestEmission","{0:MM/dd/yyyy}") %></div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="AmountDue" HeaderText="Amount Due"
                                    SortExpression="AmountDue" UniqueName="AmountDue"
                                    Groupable="False" Aggregate="Sum" FooterAggregateFormatString="{0:N2}"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# Eval("AmountDue", "{0:N2}")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Notes" HeaderText="Invoice Description" SortExpression="Notes"
                                    UniqueName="Notes" Groupable="False" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div style="vertical-align: top; font-size: x-small">
                                            <%#Eval("Notes") %>
                                        </div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <div class="container" style="height: 1px; overflow: auto">
                        <asp:Panel ID="ExportPanel" runat="server" Height="1px">
                            <telerik:RadGrid ID="RadGridInvoiceExport" runat="server" DataSourceID="SqlDataSourceMainInvoice" AutoGenerateColumns="False"
                                AllowPaging="True" Height="5px">
                                <ExportSettings>
                                    <Excel Format="BIFF" />
                                    <Csv ColumnDelimiter="Comma" RowDelimiter="NewLine" FileExtension="csv" EncloseDataWithQuotes="true" />
                                </ExportSettings>
                                <MasterTableView DataSourceID="SqlDataSourceMainInvoice" ShowFooter="True" ClientDataKeyNames="Id">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id" Display="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="InvoiceNumber" FilterControlAltText="Filter InvoiceNumber column" HeaderText="Invoice#" ReadOnly="True" SortExpression="InvoiceNumber" UniqueName="InvoiceNumber">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="PastDueStatus" DataType="System.Int32" FilterControlAltText="Filter PastDueStatus column" HeaderText="PastDue Status" ReadOnly="True" SortExpression="PastDueStatus" UniqueName="PastDueStatus">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Emitted" DataType="System.Int16" FilterControlAltText="Filter Emitted column" HeaderText="Emitted" SortExpression="Emitted" UniqueName="Emitted">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="FirstEmission" DataType="System.DateTime" FilterControlAltText="Filter FirstEmission column" HeaderText="First Emission" SortExpression="FirstEmission" UniqueName="FirstEmission">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="LatestEmission" DataType="System.DateTime" FilterControlAltText="Filter LatestEmission column" HeaderText="Latest Emission" SortExpression="LatestEmission" UniqueName="LatestEmission">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="InvoiceAmount" DataType="System.Decimal" FilterControlAltText="Filter InvoiceAmount column" HeaderText="Amount" SortExpression="InvoiceAmount" UniqueName="InvoiceAmount">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AmountDue" DataType="System.Double" FilterControlAltText="Filter AmountDue column" HeaderText="Amount Due" ReadOnly="True" SortExpression="AmountDue" UniqueName="AmountDue">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Notes" FilterControlAltText="Filter Notes column" HeaderText="Notes" SortExpression="Notes" UniqueName="Notes">
                                        </telerik:GridBoundColumn>
                                        <%--<telerik:GridBoundColumn DataField="Code" FilterControlAltText="Filter Code column" HeaderText="Code" SortExpression="Code" UniqueName="Code">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="JobName" FilterControlAltText="Filter JobName column" HeaderText="JobName" SortExpression="JobName" UniqueName="JobName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Budget" DataType="System.Decimal" FilterControlAltText="Filter Budget column" HeaderText="Budget" SortExpression="Budget" UniqueName="Budget">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Balance" DataType="System.Double" FilterControlAltText="Filter Balance column" HeaderText="Balance" ReadOnly="True" SortExpression="Balance" UniqueName="Balance">
                                </telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn DataField="ClientName" FilterControlAltText="Filter ClientName column" HeaderText="Client" SortExpression="ClientName" UniqueName="ClientName">
                                        </telerik:GridBoundColumn>
                                        <%--<telerik:GridBoundColumn DataField="ClientCompany" FilterControlAltText="Filter ClientCompany column" HeaderText="ClientCompany" SortExpression="ClientCompany" UniqueName="ClientCompany">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ClientAddress" FilterControlAltText="Filter ClientAddress column" HeaderText="ClientAddress" ReadOnly="True" SortExpression="ClientAddress" UniqueName="ClientAddress">
                                </telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn DataField="ClientPhone" FilterControlAltText="Filter ClientPhone column" HeaderText="Phone" ReadOnly="True" SortExpression="ClientPhone" UniqueName="ClientPhone">
                                        </telerik:GridBoundColumn>
                                        <%--<telerik:GridBoundColumn DataField="ClientCellular" FilterControlAltText="Filter ClientCellular column" HeaderText="ClientCellular" ReadOnly="True" SortExpression="ClientCellular" UniqueName="ClientCellular">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ClientEmail" FilterControlAltText="Filter ClientEmail column" HeaderText="ClientEmail" ReadOnly="True" SortExpression="ClientEmail" UniqueName="ClientEmail">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ProjectManager" FilterControlAltText="Filter ProjectManager column" HeaderText="ProjectManager" ReadOnly="True" SortExpression="ProjectManager" UniqueName="ProjectManager">
                                </telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn DataField="nStatus" FilterControlAltText="Filter nStatus column" HeaderText="Status" SortExpression="nStatus" UniqueName="nStatus">
                                        </telerik:GridBoundColumn>
                                        <%--<telerik:GridBoundColumn DataField="PastDueStatusName" FilterControlAltText="Filter PastDueStatusName column" HeaderText="PastDueStatusName" ReadOnly="True" SortExpression="PastDueStatusName" UniqueName="PastDueStatusName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="PastDueStatusTitle" FilterControlAltText="Filter PastDueStatusTitle column" HeaderText="PastDueStatusTitle" ReadOnly="True" SortExpression="PastDueStatusTitle" UniqueName="PastDueStatusTitle">
                                </telerik:GridBoundColumn>--%>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </asp:Panel>
                    </div>
                </div>
            </telerik:RadWizardStep>
            <telerik:RadWizardStep runat="server" Title="Statements">
                <table>
                    <tr>
                        <td style="width: 120px">

                            <asp:LinkButton ID="btnSendStatement" runat="server" ToolTip="Send Email with Statement information to selected records" Width="100px"
                                CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                    <i class="far fa-envelope"></i> Email
                            </asp:LinkButton>
                        </td>
                        <td style="width: 120px">
                            <asp:LinkButton ID="btnReceivePaymentStatement" runat="server" ToolTip="Receive Payment to selected records" Width="100px"
                                CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                                    <i class="fas fa-dollar-sign"></i> Payment
                            </asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="btnClientStatementsUnhide" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false" ToolTip="Show all hidden clients " Width="80px">
                                        <i class="far fa-eye"></i>Unhide
                            </asp:LinkButton>

                        </td>
                    </tr>
                </table>
                <div style="padding-top: 5px">
                    <telerik:RadGrid ID="RadGridStatements" runat="server" Skin="Bootstrap" AutoGenerateColumns="False" Height="650px"
                        DataSourceID="SqlDataSourceStatements" AllowSorting="True" ItemStyle-Font-Size="x-Small" AlternatingItemStyle-Font-Size="x-Small" FooterStyle-Font-Size="Small"
                        PageSize="100" AllowPaging="true" AllowMultiRowSelection="true">
                        <ClientSettings Selecting-AllowRowSelect="true">
                            <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                        </ClientSettings>

                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceStatements" CommandItemDisplay="None" ShowFooter="True">
                            <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                            <Columns>
                                <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="recordtypeId" DataType="System.Int32" HeaderText="recordtypeId" ReadOnly="True" UniqueName="recordtypeId" Display="false" HeaderStyle-Width="40px">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="Number" FilterControlAltText="Filter Number column"
                                    HeaderText="Statement" SortExpression="Number" UniqueName="Number" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center"
                                    FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                    <ItemTemplate>
                                        <a href='<%# LocalAPI.GetSharedLink_URL(5,Eval("Id"))%>' target="_blank" title="view statement"><%# Eval("Number")%></a>
                                        <br />
                                        <span title='<%# Eval("PastDueStatusTitle") %>' class="label badge-<%# IIf(Eval("PastDueStatus") = 5, "danger", IIf(Eval("PastDueStatus") = 4, "warning", IIf(Eval("PastDueStatus") = 3, "primary", IIf(Eval("PastDueStatus") = 2, "info", IIf(Eval("PastDueStatus") = 1, "default", "success"))))) %>"><%# Eval("PastDueStatusName") %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="InvoiceDate" DataType="System.DateTime" FilterControlAltText="Filter InvoiceDate column"
                                    HeaderText="Date" SortExpression="InvoiceDate" UniqueName="InvoiceDate"
                                    HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%# Eval("InvoiceDate","{0:d}")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="ClientName" FilterControlAltText="Filter ClientName column" HeaderText="Client Info" SortExpression="ClientName" UniqueName="ClientName"
                                    HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="btnNewStatementRemainder" runat="server" UseSubmitBehavior="false" ToolTip="Schedule a new reminder"
                                                CommandName="NewStatementReminder" CommandArgument='<%# Eval("Id")%>'>
                                                <i class="far fa-calendar-alt"></i></a>
                                            </asp:LinkButton>

                                            <asp:LinkButton ID="btnNewStatementEmail" runat="server" UseSubmitBehavior="false" ToolTip="Individual Email to Client"
                                                CommandName="NewStatementEmail" CommandArgument='<%# Eval("Id")%>'>
                                                <i class="far fa-envelope"></i></a>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnHideStatementClient" runat="server" CommandArgument='<%# Eval("clientId")%>' ToolTip="Hide client from list"
                                                CommandName="HideStatementClient" UseSubmitBehavior="false">
                                                    <i class="fas fa-eye-slash"></i>
                                            </asp:LinkButton>


                                            <telerik:RadLabel runat="server" ID="RadLabel4" Text='<%# Eval("ClientName") %>' ToolTip='<%#Eval("ClientCompany")%>'></telerik:RadLabel>
                                        </div>
                                        <div>
                                            <i class="fas fa-phone"></i></a>
                                            <%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("ClientPhone"))%>
                                            &nbsp;
                                            <i class="fas fa-mobile-alt"></i></a>
                                            <%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("ClientCellular"))%>
                                        </div>

                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <%--  <telerik:GridBoundColumn DataField="AmountBilled" FilterControlAltText="Filter AmountBilled column"
                                    HeaderText="Amount" SortExpression="AmountBilled" UniqueName="AmountBilled"
                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                                    FooterStyle-Width="80px" DataFormatString="{0:N2}" FooterAggregateFormatString="{0:N2}"
                                    Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                </telerik:GridBoundColumn>--%>
                                <telerik:GridTemplateColumn DataField="FirstEmission" DataType="System.DateTime" HeaderText="First<br/>Last"
                                    SortExpression="FirstEmission" UniqueName="FirstEmission"
                                    Groupable="False" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div><%#Eval("FirstEmission","{0:MM/dd/yyyy}") %> <span title="Emitted count" class="badge badge-default"><%# Eval("Emitted") %></span></div>
                                        <div><%#Eval("LatestEmission","{0:MM/dd/yyyy}") %></div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <%-- <telerik:GridBoundColumn DataField="AmountDue" FilterControlAltText="Filter AmountDue column"
                                    HeaderText="Amount Due" SortExpression="AmountDue" UniqueName="AmountDue"
                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                                    FooterStyle-Width="80px" DataFormatString="{0:N2}" FooterAggregateFormatString="{0:N2}"
                                    Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                </telerik:GridBoundColumn>--%>
                                <telerik:GridTemplateColumn DataField="InvoiceNotes" FilterControlAltText="Filter InvoiceNotes column"
                                    HeaderStyle-HorizontalAlign="Center" HeaderText="Notes" SortExpression="InvoiceNotes"
                                    UniqueName="InvoiceNotes">
                                    <ItemTemplate>
                                        <asp:Label ID="InvoiceNotesLabel" runat="server" Text='<%# Eval("InvoiceNotes") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </telerik:RadWizardStep>

        </WizardSteps>
    </telerik:RadWizard>

    <telerik:RadToolTip ID="RadToolBillAction" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <table class="table table-bordered" style="width: 500px">
            <tr>
                <td>
                    <h2 style="margin: 0; text-align: center; color: white; width: 500px">
                        <span class="navbar navbar-expand-md bg-dark text-white">
                            <asp:Label ID="lblActionMesage" runat="server"></asp:Label>
                        </span>
                    </h2>
                </td>
            </tr>

            <tr>
                <td style="text-align: center">
                    <asp:LinkButton ID="btnOk" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="100px">
                                    <i class="fas fa-check"></i> Ok
                    </asp:LinkButton>

                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="100px">
                                    Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipStatementAction" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <table class="table table-bordered" style="width: 500px">
            <tr>
                <td>

                    <h2 style="margin: 0; text-align: center; color: white; width: 500px">
                        <span class="navbar navbar-expand-md bg-dark text-white">
                            <asp:Label ID="lblActionMesageStatement" runat="server"></asp:Label>Switch Company
                        </span>
                    </h2>
                </td>
            </tr>

            <tr>
                <td style="text-align: center">
                    <asp:LinkButton ID="btnOkStatement" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="100px">
                                    <i class="far fa-list-alt"></i> Ok
                    </asp:LinkButton>

                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancelStatementDlg" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="100px">
                                    Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipInvoicesPayment" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 500px">
            <span class="navbar navbar-expand-md bg-dark text-white">Receive Invoice Payments
            </span>
        </h2>
        <table class="table table-bordered" style="width: 500px">
            <tr>
                <td style="width: 140px; text-align: right" class="Normal">Collected Date:
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerPayment" runat="server" ZIndex="50001">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">Method:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboPaymentMethod_paym" runat="server" DataSourceID="SqlDataSourcePaymentMethod" DataTextField="Name" DataValueField="Id"
                        Filter="Contains" MarkFirstMatch="True" Width="100%" ZIndex="50001">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">Notes:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPaymentNotes" runat="server" Width="100%" MaxLength="1024" Rows="2">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnInsertPayment" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="100px">
                                    <i class="fas fa-check"></i> Insert
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancelPayment" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="100px">
                                     Cancel
                    </asp:LinkButton>

                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipStatementsPayment" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 500px">
            <span class="navbar navbar-expand-md bg-dark text-white">Receive Statement Payments
            </span>
        </h2>
        <table class="table table-bordered" style="width: 500px">
            <tr>
                <td style="width: 140px; text-align: right" class="Normal">Collected Date:
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerPayment2" runat="server" ZIndex="50001">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">Method:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboPaymentMethod_paym2" runat="server" DataSourceID="SqlDataSourcePaymentMethod" DataTextField="Name" DataValueField="Id"
                        Filter="Contains" MarkFirstMatch="True" Width="100%" ZIndex="50001">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">Notes:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPaymentNotes2" runat="server" Width="100%" MaxLength="1024" Rows="2">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnInsertStatementPayments" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="100px">
                                    <i class="fas fa-check"></i> Insert
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancelStatementPayments" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="100px">
                                     Cancel
                    </asp:LinkButton>

                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipEditInvoice" runat="server" Position="Center" RelativeTo="BrowserWindow"
        Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Edit Invoice
            </span>
        </h2>
        <asp:FormView ID="FormViewInvoice" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceEditInvoice" DefaultMode="Edit">
            <EditItemTemplate>
                <table class="table table-bordered" style="width: 600px">
                    <tr>
                        <td style="width: 150px; text-align: right" class="Normal">InvoiceNumber:
                        </td>
                        <td>
                            <%# Eval("InvoiceNumber") %>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="Normal">Invoice Date:
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="RadDatePickerInvoiceDate" runat="server" ZIndex="50001" SelectedDate='<%# Bind("InvoiceDate") %>'>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="Normal">Time:
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="RadNumericTextBoxTime" runat="server" DbValue='<%# Bind("Time") %>' MinValue="0">
                                <NumberFormat DecimalDigits="1" />
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="Normal">Rate:
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server" DbValue='<%# Bind("Rate") %>' MinValue="0">
                                <NumberFormat DecimalDigits="2" />
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="Normal">Amount:
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="RadNumericTextBoxAmount" runat="server" DbValue='<%# Bind("Amount") %>'>
                                <NumberFormat DecimalDigits="2" />
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="Normal">Bad Debt:
                        </td>
                        <td>
                            <asp:CheckBox ID="BadDebtCheckBox" runat="server" Checked='<%# Bind("BadDebt") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="Normal">Due Date:
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="RadDatePickerMaturityDate" runat="server" ZIndex="50001" DbSelectedDate='<%# Bind("MaturityDate") %>'>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="Normal">EmissionRecurrenceDays:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtEditEmissionRecurrenceDays" runat="server" Text='<%# Bind("EmissionRecurrenceDays") %>'>
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="Normal">Notes:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtInvoiceNotes" runat="server" Width="100%" Text='<%# Bind("InvoiceNotes") %>' MaxLength="1024" Rows="2">
                            </telerik:RadTextBox>
                        </td>
                    </tr>

                </table>
            </EditItemTemplate>

        </asp:FormView>


        <div style="text-align: center; padding-top: 25px">
            <asp:LinkButton ID="btnUpdateInvoice" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" CommandName="Update" Width="120px">
                                    <i class="fas fa-check"></i> Update
            </asp:LinkButton>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:LinkButton ID="btnCancelInvoice" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="120px">
                            Cancel
            </asp:LinkButton>

        </div>
    </telerik:RadToolTip>


    <telerik:RadToolTip ID="RadToolTipInvoiceRemaider" runat="server" Position="Center" RelativeTo="BrowserWindow"
        Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">New Invoice Reminder
            </span>
        </h2>
        <asp:FormView ID="FormViewRemaider" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceInvoiceRemaider">
            <ItemTemplate>

                <table class="table table-bordered" style="width: 600px">
                    <tr class="table-success">
                        <td style="width: 150px; text-align: right" class="Normal">Job:
                        </td>
                        <td>
                            <%# string.Concat(Eval("Code")," ",Eval("JobName")) %>
                        </td>
                    </tr>
                    <tr class="table-success">
                        <td style="width: 150px; text-align: right" class="Normal">Invoice Number:
                        </td>
                        <td>
                            <%# Eval("InvoiceNumber") %>
                        </td>
                    </tr>
                    <tr class="table-success">
                        <td style="width: 150px; text-align: right" class="Normal">First Emission:
                        </td>
                        <td>
                            <%# Eval("FirstEmission","{0:d}") %>
                        </td>
                    </tr>
                    <tr class="table-success">
                        <td style="width: 150px; text-align: right" class="Normal">Latest Emission:
                        </td>
                        <td>
                            <%# Eval("LatestEmission","{0:d}") %>
                        </td>
                    </tr>

                </table>
            </ItemTemplate>


        </asp:FormView>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td style="text-align: right" class="Normal">Reminder
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerRemaider" runat="server" ZIndex="50001">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRemainderContactName" CssClass="Error" ErrorMessage="*" ValidationGroup="Remainder"></asp:RequiredFieldValidator>
                    Contact Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemainderContactName" runat="server" Width="100%" MaxLength="80">
                    </telerik:RadTextBox>

                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtRemaiderEmail" CssClass="Error" ErrorMessage="*" ValidationGroup="Remainder"></asp:RequiredFieldValidator>
                    Email:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemaiderEmail" runat="server" Width="100%" MaxLength="80">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtRemainderNotes" CssClass="Error" ErrorMessage="*" ValidationGroup="Remainder"></asp:RequiredFieldValidator>
                    Notes:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemainderNotes" runat="server" Width="100%" MaxLength="1024" Rows="4" TextMode="MultiLine">
                    </telerik:RadTextBox>

                </td>
            </tr>
            <tr>
                <td colspan="2"></td>
            </tr>

        </table>

        <div style="text-align: center; padding-top: 25px">
            <asp:LinkButton ID="btnInsertRemaider" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="120px">
                                    <i class="fas fa-check"></i> Insert Remainder
            </asp:LinkButton>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:LinkButton ID="btnCancelRemaider" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="120px">
                            Cancel
            </asp:LinkButton>

        </div>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipStatementReminder" runat="server" Position="Center" RelativeTo="BrowserWindow"
        Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">New Statement Reminder
            </span>
        </h2>

        <asp:FormView ID="FormViewStatementReminder" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceStatementReminder">
            <ItemTemplate>

                <table class="table table-bordered" style="width: 600px">
                    <tr class="table-success">
                        <td style="width: 150px; text-align: right" class="Normal">Statement Number:
                        </td>
                        <td>
                            <%# Eval("StatementNumber") %>
                        </td>
                    </tr>
                    <tr class="table-success">
                        <td style="width: 150px; text-align: right" class="Normal">First Emission:
                        </td>
                        <td>
                            <%# Eval("FirstEmission","{0:d}") %>
                        </td>
                    </tr>
                    <tr class="table-success">
                        <td style="width: 150px; text-align: right" class="Normal">Latest Emission:
                        </td>
                        <td>
                            <%# Eval("LatestEmission","{0:d}") %>
                        </td>
                    </tr>

                </table>
            </ItemTemplate>


        </asp:FormView>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td style="text-align: right" class="Normal">Reminder
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerReminder2" runat="server" ZIndex="50001">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtRemainderContactName2" CssClass="Error" ErrorMessage="*" ValidationGroup="Remainder"></asp:RequiredFieldValidator>
                    Contact Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemainderContactName2" runat="server" Width="100%" MaxLength="80">
                    </telerik:RadTextBox>

                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtRemaiderEmail2" CssClass="Error" ErrorMessage="*" ValidationGroup="Remainder"></asp:RequiredFieldValidator>
                    Email:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemaiderEmail2" runat="server" Width="100%" MaxLength="80">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtRemainderNotes2" CssClass="Error" ErrorMessage="*" ValidationGroup="Remainder"></asp:RequiredFieldValidator>
                    Notes:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemainderNotes2" runat="server" Width="100%" MaxLength="1024" Rows="4" TextMode="MultiLine">
                    </telerik:RadTextBox>

                </td>
            </tr>
            <tr>
                <td colspan="2"></td>
            </tr>

        </table>

        <div style="text-align: center; padding-top: 25px">
            <asp:LinkButton ID="btnInsertStatementReminder" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="120px">
                                    <i class="fas fa-check"></i> Insert Remainder
            </asp:LinkButton>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:LinkButton ID="btnCancelStatementReminder" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="120px">
                            Cancel
            </asp:LinkButton>

        </div>
    </telerik:RadToolTip>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <asp:SqlDataSource ID="SqlDataSourceRemainders" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="BILLING_REMINDER_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="BILLING_REMINDER_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommand="BILLING_REMINDER_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="employeeId" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Remainder" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceMainInvoice" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="BILLINGMANAGER_INVOICES_JOB2_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboClients" Name="Client" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="statusId" PropertyName="SelectedValue" Type="Int32" />

            <asp:Parameter Name="DepartmentIdIN_List" Type="String" />
            <asp:Parameter Name="PastDueStatusIN_List" Type="String" />

            <asp:ControlParameter ControlID="lblExcludeInvoiceClientId_List" Name="ExcludeClientList" PropertyName="Text" Type="String" ConvertEmptyStringToNull="False" />

            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceMainInvoiceToExport" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="BILLINGMANAGER_INVOICES_JOB2_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientToExport" Name="Client" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="statusId" PropertyName="SelectedValue" Type="Int32" />

            <asp:Parameter Name="DepartmentIdIN_List" Type="String" />
            <asp:Parameter Name="PastDueStatusIN_List" Type="String" />

            <asp:ControlParameter ControlID="lblExcludeInvoiceClientId_List" Name="ExcludeClientList" PropertyName="Text" Type="String" ConvertEmptyStringToNull="False" />

            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceInvoicesDetails" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="BILLINGMANAGER_INVOICEDETAILS_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="JobId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEditInvoice" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="INVOICE2_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="INVOICE_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblInvoiceId" Name="Id" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="lblInvoiceId" Name="Id" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="InvoiceDate" Type="DateTime" />
            <asp:Parameter Name="Time" Type="Double" />
            <asp:Parameter Name="Rate" Type="Double" />
            <asp:Parameter Name="Amount" Type="Double" />
            <asp:Parameter Name="InvoiceNotes" Type="String" />
            <asp:Parameter Name="MaturityDate" Type="DateTime" />
            <asp:Parameter Name="BadDebt" Type="Boolean" />
            <asp:Parameter Name="EmissionRecurrenceDays" Type="Int16" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </UpdateParameters>


    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceInvoiceRemaider" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="INVOICE_JOB_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="INVOICE_REMAINDER_INSERT" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblInvoiceId" Name="invoiceId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblInvoiceId" Name="InvoiceId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtRemainderContactName" Name="ClientContactName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtRemaiderEmail" Name="Email" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtRemainderNotes" Name="Notes" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="RadDatePickerRemaider" Name="Remainder" PropertyName="SelectedDate" Type="DateTime" />
            <asp:Parameter Name="statusId" DefaultValue="0" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceStatementReminder" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="STATEMENT2_Adapter" SelectCommandType="StoredProcedure"
        InsertCommand="STATEMENT_REMAINDER_INSERT" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblStatementId" Name="statementId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblStatementId" Name="statementId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtRemainderContactName2" Name="ClientContactName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtRemaiderEmail2" Name="Email" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtRemainderNotes2" Name="Notes" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="RadDatePickerReminder2" Name="Remainder" PropertyName="SelectedDate" Type="DateTime" />
            <asp:Parameter Name="statusId" DefaultValue="0" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="BILLINGMANAGER_INVOICES_Clientes_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_status] where Id<>1 ORDER BY [OrderBy]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePayments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="INVOICE_PAYMENTS2_INSERT" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblInvoiceId" Name="InvoiceId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerPayment" Name="CollectedDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboPaymentMethod_paym" Name="Method" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtAmountPayment" Name="Amount" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtPaymentNotes" Name="CollectedNotes" PropertyName="Text" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePaymentMethod" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Payment_methods ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceStatements" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="BILLINGMANAGER_Statement5_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Statement_FROM_INVOICE_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="STATEMENT_PAYMENTS_INSERT" UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="lblInvoiceId" Name="InvoiceId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Direction="Output" Name="StatementId" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboClients" Name="Client" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="PastDueStatusIN_List" Type="String" />
            <asp:ControlParameter ControlID="lblExcludeStatementsClientId_List" Name="ExcludeClientList" PropertyName="Text" Type="String" ConvertEmptyStringToNull="False" />
            <%--            <asp:ControlParameter ControlID="cboStatus" Name="statusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />--%>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblStatementId" Name="statementId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerPayment2" Name="CollectedDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboPaymentMethod_paym2" Name="Method" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtPaymentNotes2" Name="CollectedNotes" PropertyName="Text" Type="String" />
        </UpdateParameters>


    </asp:SqlDataSource>


    <asp:Label ID="lblInvoiceId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblStatementId" runat="server" Visible="False"></asp:Label>
    <telerik:RadNumericTextBox ID="txtAmountPayment" runat="server" Visible="false">
    </telerik:RadNumericTextBox>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblClientToExport" runat="server" Visible="False" Text="999999"></asp:Label>
    <asp:Label ID="lblExcludeInvoiceClientId_List" runat="server" Visible="False" Text=""></asp:Label>
    <asp:Label ID="lblExcludeStatementsClientId_List" runat="server" Visible="False" Text=""></asp:Label>
</asp:Content>


