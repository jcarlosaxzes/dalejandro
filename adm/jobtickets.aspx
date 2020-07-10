<%@ Page Title="Tickets" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="jobtickets.aspx.vb" Inherits="pasconcept20.jobtickets" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pasconcept-bar">
        <div class="collapse" id="collapseFilter">
            <div class="card card-body">

                <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">
                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td style="width: 250px">
                                <telerik:RadComboBox ID="cboType" runat="server"
                                    DataSourceID="SqlDataSourceTicketTypes" DataTextField="Name" DataValueField="Id"
                                    Width="100%" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains">
                                    <Localization AllItemsCheckedString="All Types Checked" CheckAllString="Check All..." ItemsCheckedString="types checked"></Localization>
                                </telerik:RadComboBox>
                            </td>
                            <td style="width: 250px">
                                <telerik:RadComboBox ID="cboLocationModule" runat="server" AppendDataBoundItems="true" Width="100%"
                                    DataSourceID="SqlDataSourceTicketLocationModule" DataTextField="Name" DataValueField="Id">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="(All Locations/Modules...)" Selected="true" />
                                    </Items>
                                </telerik:RadComboBox>

                            </td>
                            <td style="width: 250px">
                                <telerik:RadComboBox ID="cboAppName" runat="server" AppendDataBoundItems="true" Width="100%"
                                    DataSourceID="SqlDataSourceTicketAppName" DataTextField="Name" DataValueField="Id">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="(All App Names...)" Selected="true" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td>
                                <telerik:RadDropDownList ID="cboFilterEmployee" runat="server" AppendDataBoundItems="true" Width="100%"
                                    DataSourceID="SqlDataSourceEmpl_activos" DataTextField="Name" DataValueField="Id">
                                    <Items>
                                        <telerik:DropDownListItem Text="(All Assined/Notified Employees...)" Selected="true" Value="0" />
                                    </Items>
                                </telerik:RadDropDownList>

                            </td>
                            <td style="text-align: right; width: 120px"></td>

                        </tr>
                        <tr>
                            <td>
                                <telerik:RadComboBox ID="cboStatus" runat="server"
                                    DataSourceID="SqlDataSourceTicketsStatus" DataTextField="Name" DataCheckedField="EmployeeFilterChecked"
                                    Width="100%" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains">
                                    <Localization AllItemsCheckedString="All Status Checked" CheckAllString="Check All..." ItemsCheckedString="status checked"></Localization>
                                </telerik:RadComboBox>
                            </td>
                            <td colspan="2">
                                <telerik:RadComboBox ID="cboJobs" runat="server" AppendDataBoundItems="true" Width="100%" MarkFirstMatch="True" Filter="Contains"
                                    DataSourceID="SqlDataSourceJobs" DataTextField="Name" DataValueField="Id" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="(All Jobs...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td style="text-align: left">
                                <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Text=""
                                    EmptyMessage="Find Text in Tite, Tags, Description, Notes..."
                                    LabelWidth="" Width="100%">
                                </telerik:RadTextBox>
                            </td>

                            <td>
                                <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>

            </div>
        </div>

        <table class="table-sm noprint" style="width: 100%">
            <tr>
                <td style="width: 100px; text-align: left">
                    <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                        <i class="fas fa-filter"></i>&nbsp;Filter
                    </button>
                </td>

                <td style="width: 100px; text-align: left">
                    <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="New Ticket">
                    <i class="fas fa-plus"></i> Ticket
                    </asp:LinkButton>
                </td>
                <td>
                    <h3 style="margin: 0">
                        <asp:Label ID="lblJob" runat="server"></asp:Label>
                    </h3>
                </td>
                <td style="text-align: center; width: 32px">
                    <asp:LinkButton ID="btnStatusUpdate" runat="server" UseSubmitBehavior="false" ToolTip="Update Status on selected tickets" CausesValidation="false">
                                        <span style="color:green" class="fas fa-check"></span>
                    </asp:LinkButton>
                </td>
                <td style="text-align: center; width: 32px">
                    <asp:LinkButton ID="btnDelete" runat="server" UseSubmitBehavior="false" ToolTip="Delete 'Pending Approval' selected tickets" CausesValidation="false">
                                        <i class="far fa-trash-alt"></i>
                    </asp:LinkButton>
                </td>
                <td style="text-align: center; width: 32px">
                    <asp:LinkButton ID="btnMeetingRequest" runat="server" UseSubmitBehavior="false" ToolTip="Send Email with Meeting Request on selected tickets" CausesValidation="false">
                                        <i class="far fa-calendar-alt"></i>
                    </asp:LinkButton>
                </td>
                <td style="text-align: center; width: 32px">
                    <asp:LinkButton ID="btnURLClientNotification" runat="server" UseSubmitBehavior="false" ToolTip="Send Client Email with url Page of Tickets" CausesValidation="false">
                                        <i class="far fa-envelope"></i>
                    </asp:LinkButton>
                </td>
                <td style="text-align: center; width: 32px">
                    <a runat="server" id="urlPublicLink" class="far fa-share-square" title="Click to View Public View" href='<%# GetJobGUID() %>' target="_blank" aria-hidden="true"></a>
                </td>
                <td style="text-align: center; width: 100px">
                    <asp:LinkButton ID="btnImport" runat="server" ToolTip="Import records from CSV File" Width="100px"
                        CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                    <i class="fas fa-upload"></i> Import
                    </asp:LinkButton>
                </td>
                <td style="text-align: center; width: 100px">
                    <asp:LinkButton ID="btnExport" runat="server" ToolTip="Export records to Excel" Width="100px"
                        CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                    <i class="fas fa-download"></i> Export
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }

            function PrintPage(sender, args) {
                window.print();
            }
        </script>
    </telerik:RadCodeBlock>
    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" GroupingEnabled="false" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="100%"
            PageSize="50" AllowPaging="true" Height="1000px" RenderMode="Auto" Skin="Bootstrap" AllowAutomaticDeletes="true"
            HeaderStyle-HorizontalAlign="Center" AllowMultiRowSelection="True"
            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" ShowFooter="True" CommandItemDisplay="None">
                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                <Columns>
                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                    </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" HeaderStyle-Width="40px">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Id" HeaderText="Ticket" SortExpression="Id" UniqueName="Ticket" HeaderStyle-Width="135px"
                        FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <table style="width: 100%; text-align: center">
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="btnView" runat="server" Text='<%# Eval("Id")%>' CommandArgument='<%# Eval("Id")%>' ToolTip="View/Edit Ticket"
                                            CommandName="ViewEditTicket" UseSubmitBehavior="false">
                                        </asp:LinkButton>
                                    </td>
                                    <td style="width: 24px; text-align: right">
                                        <asp:LinkButton ID="btnNewTime" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to Add Time"
                                            CommandName="NewTime" UseSubmitBehavior="false">
                                                <i class="fas fa-user-clock"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td style="width: 24px; text-align: right">
                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("Id")%>'
                                            Visible='<%# LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Deny_InvoicesList") %>' ToolTip="Click to View Ticket Balance"
                                            CommandName="TicketBalance" UseSubmitBehavior="false">
                                                <span style="font-size: 16px" aria-hidden="true" class="fas fa-chart-bar"></span>
                                        </asp:LinkButton>
                                    </td>
                                    <td style="width: 24px; text-align: right">
                                        <asp:LinkButton ID="btnInvoice" runat="server" CommandArgument='<%# Eval("Id")%>' ForeColor='<%# GetInvoiceColor(Eval("InvoiceId")) %>'
                                            Visible='<%#IIf(Eval("Billable") = 0, False, LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Deny_InvoicesList")) %>' ToolTip="Click to Add/View Invoice"
                                            CommandName="Invoice" UseSubmitBehavior="false">
                                                <i class="fas fa-file-invoice-dollar"></i>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Title" HeaderText="Title - Urls / Tags" UniqueName="Title" HeaderStyle-Width="250px" ItemStyle-Font-Size="X-Small">
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td style="text-align: left; font-weight: bold">
                                        <%# Eval("Title") %>
                                    </td>
                                    <td style="width: 20px; text-align: center">
                                        <asp:Panel runat="server" Visible='<%# IIf(Len(Eval("trelloURL")) > 0, True, False) %>'>
                                            <a runat="server" class="fas fa-link" style="color: saddlebrown;" title="Click to view the related Trello card" href='<%# Eval("trelloURL") %>' target="_blank" aria-hidden="true"></a>
                                        </asp:Panel>
                                    </td>
                                    <td style="width: 20px; text-align: center">
                                        <asp:Panel runat="server" Visible='<%# IIf(Len(Eval("jiraURL")) > 0, True, False) %>'>
                                            <a runat="server" class="fas fa-link" title="Click to view the related Jira card" href='<%# Eval("jiraURL") %>' target="_blank" aria-hidden="true"></a>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="color: brown; text-align: left"><%# Eval("Tags") %></td>
                                </tr>
                            </table>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="AppName" HeaderText="Application -- Module" UniqueName="AppName" HeaderStyle-Width="160px" ItemStyle-Font-Size="X-Small" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <%# Eval("AppName") %>
                            <br />
                            <%# Eval("LocationModule") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="ClientDescription" HeaderText="Description" UniqueName="ClientDescription"
                        HeaderStyle-Width="260px" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Size="X-Small">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Type" HeaderText="Type" UniqueName="Type" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <span class="<%# LocalAPI.GetTickectTypeLabelCSS(Eval("Type")) %>"><%# Eval("Type") %></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="StagingDate" HeaderText="Stag-Date" UniqueName="StagingDate" HeaderStyle-Width="100px" SortExpression="StagingDate">
                        <ItemTemplate>
                            <span class="<%# GetStagingDateLabelCSS(Eval("Id")) %>"><%# Eval("StagingDate", "{0:d}") %></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Status" HeaderText="Status" UniqueName="Status" HeaderStyle-Width="160px">
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td style="text-align: center">
                                        <span class="<%# LocalAPI.GetTickectStatusLabelCSS(Eval("Status")) %>"><%# Eval("Status") %></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center">
                                        <span style="font-size: x-small" title="Number of Hours"><%# Eval("Hours") %> / <%# Eval("EstimatedHours") %></span>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this Ticket?"
                        ConfirmTitle="Delete" CommandName="Delete" UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <%--Export RadGrid--%>
    <div class="container" style="height: 1px; overflow: auto">
        <asp:Panel ID="ExportPanel" runat="server" Height="1px">
            <telerik:RadGrid ID="RadGridToExport" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False"
                AllowPaging="True" Height="5px">
                <MasterTableView DataSourceID="SqlDataSource1" ShowFooter="True" DataKeyNames="Id">
                    <Columns>
                        <telerik:GridBoundColumn DataField="Id" HeaderText="Ticket#" SortExpression="Id" UniqueName="Id">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="AppName" HeaderText="App Name" UniqueName="AppName">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="LocationModule" HeaderText="Location/Module" UniqueName="LocationModule">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Title" HeaderText="Title" UniqueName="Title">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Tags" HeaderText="Tags" UniqueName="Tags">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="StagingDate" HeaderText="Due Date" UniqueName="StagingDate" DataFormatString="{0:d}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ClientDescription" HeaderText="ClientDescription" UniqueName="ClientDescription">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Type" HeaderText="Type" UniqueName="Type">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Priority" HeaderText="Priority" UniqueName="Priority">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Status" HeaderText="Status" UniqueName="Status">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ApprovedStatus" HeaderText="ApprovedStatus" UniqueName="ApprovedStatus">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CompanyDescription" HeaderText="CompanyDescription" UniqueName="CompanyDescription">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="ExpectedStartDate" HeaderText="ExpectedStartDate" UniqueName="ExpectedStartDate" DataFormatString="{0:d}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="LastStatusDate" HeaderText="LastStatusDate" UniqueName="LastStatusDate" DataFormatString="{0:d}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="StagingDate" HeaderText="StagingDate" UniqueName="StagingDate" DataFormatString="{0:d}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ProductionDate" HeaderText="ProductionDate" UniqueName="ProductionDate" DataFormatString="{0:d}">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="Notes" HeaderText="Notes" UniqueName="Notes">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="trelloURL" HeaderText="trelloURL" UniqueName="trelloURL">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="jiraURL" HeaderText="jiraURL" UniqueName="jiraURL">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="Hours" HeaderText="Hours" UniqueName="Hours">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="EstimatedHours" HeaderText="EstimatedHours" UniqueName="EstimatedHours">
                        </telerik:GridBoundColumn>

                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </asp:Panel>
    </div>


    <%--SendRequest Form--%>
    <div>
        <telerik:RadToolTip ID="RadToolSendRequest" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode" Skin="Default">
            <h2 style="margin: 0">
               <span class="navbar navbar-expand-md bg-dark text-white">Request Meeting
                </span>
            </h2>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true"
                ValidationGroup="EditTicket" />

            <table class="table-sm" style="width: 960px; text-align: left">
                <tr>
                    <td style="width: 150px">To:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtTo" runat="server" Width="100%" EmptyMessage="Contact Email">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td>BCC:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtBCC" runat="server" Width="100%" EmptyMessage="Contact Copy Email">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td>Subject:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtSubject" runat="server" Width="100%">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td>Date/Time:
                    </td>
                    <td>
                        <telerik:RadDateTimePicker ID="RadDatePickerDate" Width="250px" runat="server" Culture="en-US" ZIndex="50001">
                        </telerik:RadDateTimePicker>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="margin: 10px; border: solid">
                        <asp:Label runat="server" ID="lblBody"></asp:Label>

                    </td>
                </tr>

            </table>
            <div style="text-align: center; padding-top: 10px">
                <asp:LinkButton runat="server" ID="btnSent" CssClass="btn btn-info" ToolTip="Send Email" CausesValidation="true" ValidationGroup="SendRequest">
                      <i class="far fa-calendar-alt"> Send</i>
                </asp:LinkButton>
            </div>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" runat="server" ValidationGroup="SendRequest" SetFocusOnError="true"
                ControlToValidate="txtTo"
                ErrorMessage="<span class='val-msg'><b>Location/To Email</b> is required</span>">
            </asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" runat="server" ValidationGroup="SendRequest" SetFocusOnError="true"
                ControlToValidate="txtSubject"
                ErrorMessage="<span class='val-msg'><b>Subject</b> is required</span>">
            </asp:RequiredFieldValidator>

        </telerik:RadToolTip>
    </div>

    <%--EditTicket Form--%>
    <div>
        <telerik:RadToolTip ID="RadToolTipEditTicket" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode"
            Skin="Default">
            <h2 style="margin: 0; text-align: center; color:white; width: 960px">
               <span class="navbar navbar-expand-md bg-dark text-white">View/Edit Ticket #
                    <asp:Label ID="lblTicketId" runat="server"></asp:Label>
                </span>
            </h2>
            <asp:ValidationSummary ID="ValidationSummary2" runat="server" DisplayMode="BulletList"
                HeaderText="Following error occurs:" ShowMessageBox="false" ShowSummary="true" CssClass="alert alert-danger alert-dismissable"
                ValidationGroup="Ticket" />

            <table class="table-sm" style="width: 960px; text-align: left">
                <tr>
                    <td style="width: 150px; text-align: right">Title:
                    </td>
                    <td colspan="3">
                        <telerik:RadTextBox ID="txtTitle" runat="server" MaxLength="512" Width="100%" EmptyMessage="(*)required..." ToolTip="Title">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                </tr>
                <tr>
                    <td style="text-align: right">App. Name:
                    </td>
                    <td style="width: 330px">
                        <telerik:RadDropDownList ID="cboAppNameEdit" runat="server" AppendDataBoundItems="true" Width="100%"
                            DataSourceID="SqlDataSourceTicketAppName" DataTextField="Name" DataValueField="Id" ZIndex="50001">
                            <Items>
                                <telerik:DropDownListItem Text="(Select App Name...)" Selected="true" />
                            </Items>
                        </telerik:RadDropDownList>
                        <asp:Label ID="lblAppNameEdit" runat="server" Visible="false"></asp:Label>
                    </td>
                    <td style="width: 150px; text-align: right">Location/Module:
                    </td>
                    <td>
                        <telerik:RadDropDownList ID="cboLocationModuleEdit" runat="server" AppendDataBoundItems="true" Width="100%"
                            DataSourceID="SqlDataSourceTicketLocationModule" DataTextField="Name" DataValueField="Id" ZIndex="50001">
                            <Items>
                                <telerik:DropDownListItem Text="(Select Location/Module...)" Selected="true" />
                            </Items>
                        </telerik:RadDropDownList>
                        <asp:Label ID="lblLocationModuleEdit" runat="server" Visible="false"></asp:Label>
                    </td>
                </tr>


                <tr>
                    <td style="text-align: right">Client Description:
                    </td>
                    <td colspan="3">
                        <telerik:RadTextBox ID="txtClientDescription" runat="server" Rows="2" TextMode="MultiLine" Width="100%" ToolTip="Client Description">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Company Description:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtCompanyDescription" runat="server" Rows="2" TextMode="MultiLine" Width="100%" ToolTip="Company Description">
                        </telerik:RadTextBox>
                    </td>
                    <td style="text-align: right">Client Feedback:
                    </td>
                    <td colspan="3">
                        <telerik:RadTextBox ID="txtNotes" runat="server" Rows="2" TextMode="MultiLine" Width="100%" ToolTip="Notes">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Type:
                    </td>
                    <td>
                        <telerik:RadDropDownList ID="cboTypeEdit" runat="server" AppendDataBoundItems="true" Width="100%"
                            DataSourceID="SqlDataSourceTicketTypes" DataTextField="Name" DataValueField="Id" ZIndex="50001">
                            <%--<Items>
                        <telerik:DropDownListItem Text="(Select Type...)" Selected="true" />
                    </Items>--%>
                        </telerik:RadDropDownList>
                    </td>
                    <td style="text-align: right">Priority:
                    </td>
                    <td>
                        <telerik:RadDropDownList ID="cboPriority" runat="server" AppendDataBoundItems="true" Width="100%" ZIndex="50001">
                            <Items>
                                <telerik:DropDownListItem Text="Low" />
                                <telerik:DropDownListItem Text="Medium" />
                                <telerik:DropDownListItem Text="High" />
                            </Items>
                        </telerik:RadDropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Status:
                    </td>
                    <td>
                        <telerik:RadDropDownList ID="cboStatusEdit" runat="server" AppendDataBoundItems="true" Width="100%" ZIndex="50001"
                            DataSourceID="SqlDataSourceTicketsStatus" DataTextField="Name">
                        </telerik:RadDropDownList>
                    </td>
                    <td style="text-align: right">Tags:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtTags" runat="server" MaxLength="80" Width="100%" ToolTip="Tags" EmptyMessage="Tags for grouping tickets">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Client Approved Status:
                    </td>
                    <td>
                        <telerik:RadDropDownList ID="cboApprovedStatus" runat="server" AppendDataBoundItems="true" Width="100%" ZIndex="50001">
                            <Items>
                                <telerik:DropDownListItem runat="server" Text="Pending" Selected="true" />
                                <telerik:DropDownListItem runat="server" Text="Approved" />
                                <telerik:DropDownListItem runat="server" Text="Rejected" />
                            </Items>
                        </telerik:RadDropDownList>
                    </td>
                    <td style="text-align: right">Expected Start:
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="RadDatePickerExpectedStartDate" runat="server" DateFormat="MM/dd/yyyy" Width="150px" Culture="en-US" ZIndex="50001">
                        </telerik:RadDatePicker>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Expected Staging:
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="RadDatePickerStagingDate" runat="server" Width="150px" Culture="en-US" ZIndex="50001">
                        </telerik:RadDatePicker>
                    </td>
                    <td style="text-align: right">Expected Production:
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="RadDatePickerProductionDate" runat="server" Width="150px" Culture="en-US" ZIndex="50001">
                        </telerik:RadDatePicker>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Employee:
                    </td>
                    <td>
                        <telerik:RadDropDownList ID="cboEmployee" runat="server" AppendDataBoundItems="true" Width="100%"
                            DataSourceID="SqlDataSourceEmployee" DataTextField="FullName" DataValueField="employeeId" ZIndex="50001">
                            <Items>
                                <telerik:DropDownListItem Text="(Select Assined Employee...)" Selected="true" Value="0" />
                            </Items>
                        </telerik:RadDropDownList>
                    </td>
                    <td style="text-align: right">Employee to be notified:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboNotificationBCCEmail" runat="server" DataSourceID="SqlDataSourceEmployee" DataTextField="Email" DataValueField="employeeId"
                            Width="100%" CheckBoxes="true" Height="250px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains" ZIndex="50001">
                            <Localization AllItemsCheckedString="All Emails Checked" CheckAllString="Check All..." ItemsCheckedString="emails checked"></Localization>
                        </telerik:RadComboBox>

                    </td>
                </tr>

                <tr>
                    <td style="text-align: right">Business Client Name:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtNotificationClientName" runat="server" MaxLength="80" Width="100%" ToolTip="Notification Client Name">
                        </telerik:RadTextBox>
                    </td>
                    <td style="text-align: right">Client Emails to be notified:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtNotificationClientEmail" runat="server" MaxLength="128" Width="100%" ToolTip="Notification Client Email">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Trello URL:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txttrelloURL" runat="server" MaxLength="128" Width="100%" ToolTip="Link to Trello Card">
                        </telerik:RadTextBox>
                    </td>
                    <td style="text-align: right">Jira URL:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtJiraURL" runat="server" MaxLength="128" Width="100%" ToolTip="Link to Jira Card">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                </tr>

            </table>
            <table class="table-sm" style="width: 960px">
                <tr>
                    <td style="width: 150px"></td>
                    <td style="width: 330px">
                        <asp:CheckBox ID="chkNotifyClient" runat="server" ToolTip="Notifiy changes to client when Save?" Text="&nbsp;Notify client on Save?" />
                    </td>
                    <td style="width: 150px; text-align: right">Estimated Hours:</td>
                    <td>
                        <telerik:RadTextBox ID="txtEstimatedHours" runat="server" Width="150px" ToolTip="Estimated Hours for Complete Ticket">
                        </telerik:RadTextBox>

                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:CheckBox ID="chkIsBillable" runat="server" ToolTip="Is Billable?" Text="&nbsp;Is Billable?" />
                    </td>
                    <td></td>
                    <td>
                        <asp:CheckBox ID="chkNotifyEmployee" runat="server" ToolTip="Notifiy changes to employee when Save?" Text="&nbsp;Notify employee(s) on Save?" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:CheckBox ID="chkIsPrivate" runat="server" ToolTip="Is Private?" Text="&nbsp;Is Private?" />
                    </td>
                    <td></td>
                    <td style="text-align: center;">
                        <asp:LinkButton runat="server" ID="btnSave" CssClass="btn btn-success btn-lg" ToolTip="Save Ticket" ValidationGroup="Ticket">
                            Update
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>

            <div>
                <asp:CompareValidator runat="server" ID="Comparevalidator3" ForeColor="Red" Operator="NotEqual" SetFocusOnError="true" ValidationGroup="Ticket"
                    ControlToValidate="cboLocationModuleEdit"
                    ValueToCompare="(Select Location/Module...)"
                    ErrorMessage="<span class='val-msg'><b>Location/Module</b> is required</span>">
                </asp:CompareValidator>
                <asp:CompareValidator runat="server" ID="Comparevalidator2" ForeColor="Red" Operator="NotEqual" SetFocusOnError="true" ValidationGroup="Ticket"
                    ControlToValidate="cboAppNameEdit"
                    ValueToCompare="(Select App Name...)"
                    ErrorMessage="<span class='val-msg'><b>App Name</b> is required</span>">
                </asp:CompareValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ValidationGroup="Ticket" SetFocusOnError="true"
                    ControlToValidate="txtTitle"
                    ErrorMessage="<span class='val-msg'><b>Location/Title</b> is required</span>">
                </asp:RequiredFieldValidator>
                <asp:CompareValidator runat="server" ID="Comparevalidator1" ForeColor="Red" Operator="NotEqual" SetFocusOnError="true" ValidationGroup="Ticket"
                    ControlToValidate="cboTypeEdit"
                    ValueToCompare="(Select Type...)"
                    ErrorMessage="<span class='val-msg'><b>Type</b> is required</span>">
                </asp:CompareValidator>
            </div>

        </telerik:RadToolTip>
    </div>

    <div>
        <telerik:RadToolTip ID="RadToolTipStatusUpdate" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

            <table class="table table-bordered" style="width: 600px">
                <tr>
                    <td>
                        <h2 style="margin: 0; text-align: center; color:white; width: 600px">
                           <span class="navbar navbar-expand-md bg-dark text-white">Update Status of Selected Ticket(s)
                            </span>
                        </h2>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadComboBox ID="cboNewStatus" runat="server" AppendDataBoundItems="true" Width="100%" ZIndex="50001" Height="300px">
                            <Items>
                                <telerik:RadComboBoxItem Text="(Select New Status to Update...)" Selected="true" />
                                <telerik:RadComboBoxItem Text="Pending Approval" />
                                <telerik:RadComboBoxItem Text="Blocked" />

                                <telerik:RadComboBoxItem Text="Ready for Development" />
                                <telerik:RadComboBoxItem Text="In Progress" />
                                <telerik:RadComboBoxItem Text="Development Closed" />

                                <telerik:RadComboBoxItem Text="In Staging" />
                                <telerik:RadComboBoxItem Text="In Production" />
                                <telerik:RadComboBoxItem Text="Closed" />
                                <telerik:RadComboBoxItem Text="Answered" />
                                <telerik:RadComboBoxItem Text="Dismissed" />

                            </Items>
                        </telerik:RadComboBox>

                    </td>
                </tr>
                <tr>
                    <td style="text-align: center">
                        <asp:LinkButton ID="btnStatusUpdateConfirm" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false" ValidationGroup="TicketStatus">
                                    <i class="fas fa-check"></i> Update
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
            <div>
                <asp:CompareValidator runat="server" ID="Comparevalidator4" ForeColor="Red" Operator="NotEqual" SetFocusOnError="true" ValidationGroup="TicketStatus"
                    ControlToValidate="cboNewStatus"
                    ValueToCompare="(Select New Status to Update...)"
                    ErrorMessage="Select Previously New Status to Update!">
                </asp:CompareValidator>

            </div>
        </telerik:RadToolTip>
    </div>

    <div>
        <telerik:RadToolTip ID="RadToolTipEditInvoice" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
            <h2 style="margin: 0; text-align: center; color:white; width: 600px">
                   <span class="navbar navbar-expand-md bg-dark text-white">Invoice
                    </span>
                </h2>
            <asp:FormView ID="FormViewInvoice" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceInvoice" DefaultMode="Edit">
                <EditItemTemplate>
                    <table class="table-sm" style="width: 600px">
                        <tr>
                            <td colspan="2">
                                <h4><%#IIf(Eval("InvoiceType") = 1, "Invoice Hourly Rate", "Invoice Simple Charge") %></h4>
                            </td>
                        </tr>

                        <tr>
                            <td style="width: 120px">Invoice Date:
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="RadDatePicker1" runat="server" ZIndex="50001" DbSelectedDate='<%# Bind("InvoiceDate") %>'>
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 120px">Due Date:
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="RadDatePickerMaturityDate" runat="server" ZIndex="50001" DbSelectedDate='<%# Bind("MaturityDate") %>'>
                                </telerik:RadDatePicker>
                            </td>
                        </tr>


                        <tr>
                            <td style="width: 120px">Amount:
                            </td>
                            <td>
                                <telerik:RadNumericTextBox ID="AmountRadNumericTextBoxInv" runat="server" DbValue='<%# Bind("Amount") %>'
                                    Enabled='<%# iif(Eval("InvoiceType")=1,"false","true") %>'>
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel runat="server" ID="Panel1" Visible='<%# iif(Eval("InvoiceType")=1,"true","false") %>'>
                        <table class="table-sm" style="width: 600px">
                            <tr>
                                <td style="width: 120px">Hours:</td>
                                <td>
                                    <telerik:RadNumericTextBox ID="RadNumericTimeInv" runat="server" DbValue='<%# Bind("Time") %>'>
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>x Rate</td>
                                <td>
                                    <telerik:RadNumericTextBox ID="RadNumericTextBoxRateInv" runat="server" DbValue='<%# Bind("Rate") %>'>
                                    </telerik:RadNumericTextBox>
                                    <span class="small"><%# iif(Eval("InvoiceType")=1,"Invoice Amount update, affects the Job.Budget!!!","") %></span>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table class="table-sm" style="width: 600px">
                        <tr>
                            <td style="width: 120px">Notes</td>
                            <td>
                                <telerik:RadTextBox ID="txtInvoiceNotes" runat="server" MaxLength="1024" Text='<%# Bind("InvoiceNotes") %>'
                                    TextMode="MultiLine" Width="100%" Rows="4">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 120px">Recurrence Days:</td>
                            <td>
                                <telerik:RadNumericTextBox ID="RadNumericTextBoxRecurrence" runat="server" DbValue='<%# Bind("EmissionRecurrenceDays") %>'
                                    MinValue="0" MaxValue="365">
                                    <NumberFormat DecimalDigits="0" />
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
            </asp:FormView>
            <table class="table-sm" style="width: 600px">
                <tr>
                    <td style="text-align: center">
                        <asp:LinkButton ID="btnUpdateInvoice" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false"
                            CommandName="Update"> Update
                        </asp:LinkButton>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancelInvoice" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false" Text=""
                        CommandName="Cancel"> Cancel
                    </asp:LinkButton>
                    </td>
                </tr>

            </table>

        </telerik:RadToolTip>
    </div>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Jobs_EMP_tickets_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="Jobs_tickets_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboJobs" Name="jobId" PropertyName="SelectedValue" />
            <asp:Parameter Name="LocationModule" Type="String" />
            <asp:Parameter Name="AppName" Type="String" />
            <asp:Parameter Name="TypeIN_List" Type="String" />
            <asp:Parameter Name="StatusIN_List" Type="String" />
            <asp:ControlParameter ControlID="cboFilterEmployee" Name="employeeId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTicket" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="Jobs_ticket_UPDATE" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:ControlParameter ControlID="RadDatePickerExpectedStartDate" Name="ExpectedStartDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboLocationModuleEdit" Name="LocationModule" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboAppNameEdit" Name="AppName" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="txtTitle" Name="Title" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtTags" Name="Tags" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtClientDescription" Name="ClientDescription" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCompanyDescription" Name="CompanyDescription" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtNotes" Name="Notes" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboTypeEdit" Name="Type" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboPriority" Name="Priority" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboStatusEdit" Name="Status" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboApprovedStatus" Name="ApprovedStatus" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="RadDatePickerStagingDate" Name="StagingDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerProductionDate" Name="ProductionDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtNotificationClientName" Name="NotificationClientName" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtNotificationClientEmail" Name="NotificationClientEmail" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboNotificationBCCEmail" Name="NotificationBCClientEmail" PropertyName="Text" />
            <asp:ControlParameter ControlID="txttrelloURL" Name="trelloURL" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtJiraURL" Name="jiraURL" PropertyName="Text" />

            <asp:ControlParameter ControlID="chkIsBillable" Name="Billable" PropertyName="Checked" />
            <asp:ControlParameter ControlID="chkIsPrivate" Name="IsPrivate" PropertyName="Checked" />

            <asp:ControlParameter ControlID="txtEstimatedHours" Name="EstimatedHours" PropertyName="Text" />

            <asp:ControlParameter ControlID="lblTicketId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTicketTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [jobs_ticket_Types] WHERE companyId=@companyId ORDER BY [Id]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTicketAppName" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_ticket_AppName] WHERE jobId=@jobId ORDER BY [Id]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTicketLocationModule" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_ticket_LocationModule] WHERE jobId=@jobId ORDER BY [Id]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select employeeId, Employees.FullName, jobId, Employees.Email from Jobs_Employees_assigned inner join Employees on Jobs_Employees_assigned.employeeId=Employees.Id WHERE jobId=@jobId">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpl_activos" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JobsTicketsEmployee_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" Name="EmployeeId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTicketsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name], [EmployeeFilterChecked] FROM [Jobs_tickets_Status] ORDER BY [Id]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceInvoice" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="INVOICE2_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="INVOICE2_UPDATE" UpdateCommandType="StoredProcedure"
        InsertCommand="INVOICE2_INSERT" InsertCommandType="StoredProcedure">
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
            <asp:Parameter Name="EmissionRecurrenceDays" Type="Int16" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" />
            <asp:Parameter Name="InvoiceDate" Type="DateTime" />
            <asp:Parameter Name="Time" Type="Double" />
            <asp:Parameter Name="Rate" Type="Double" />
            <asp:Parameter Name="Amount" Type="Double" />
            <asp:Parameter Name="InvoiceNotes" Type="String" />
            <asp:Parameter Name="MaturityDate" Type="DateTime" />
            <asp:Parameter Name="EmissionRecurrenceDays" Type="Int16" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblInvoiceId" runat="server" Visible="False"></asp:Label>
</asp:Content>
