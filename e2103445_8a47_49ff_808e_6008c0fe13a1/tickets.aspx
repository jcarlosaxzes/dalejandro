<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.Master" CodeBehind="tickets.aspx.vb" Inherits="pasconcept20.tickets" %>

<%@ MasterType VirtualPath="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.master" %>

<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main-content">
        <div class="Formulario">
            <table class="table-sm noprint" style="width: 100%">
                <tr>
                    <td style="width: 100px">
                        <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                            <i class="fas fa-filter"></i>&nbsp;Filter
                        </button>
                    </td>
                    <td style="width: 100px">
                        <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="New Ticket">
                        <i class="fas fa-plus"></i> Ticket
                        </asp:LinkButton>
                    </td>
                    <td style="text-align: right">
                        <asp:LinkButton ID="btnRefreshGrid" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false" ToolTip="Refresh List">
                        <i class="fas fa-redo"></i> Refresh
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
            <div class="collapse" id="collapseFilter">
                <div class="card card-body">

                    <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="width: 300px">
                                    <telerik:RadComboBox ID="cboType" runat="server"
                                        DataSourceID="SqlDataSourceTicketTypes" DataTextField="Name" DataValueField="Id"
                                        Width="100%" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains">
                                        <Localization AllItemsCheckedString="All Types Checked" CheckAllString="Check All..." ItemsCheckedString="types checked"></Localization>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="width: 350px">
                                    <telerik:RadComboBox ID="cboModuleFilter" runat="server" AppendDataBoundItems="true" Width="350px"
                                        DataSourceID="SqlDataSourceTicketLocationModule" DataTextField="Name" DataValueField="Id">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="(All Locations/Modules...)" Selected="true" />
                                        </Items>
                                    </telerik:RadComboBox>

                                </td>
                                <td style="width: 350px">
                                    <telerik:RadComboBox ID="cboAppFilter" runat="server" AppendDataBoundItems="true" Width="350px"
                                        DataSourceID="SqlDataSourceTicketAppName" DataTextField="Name" DataValueField="Id">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="(All App Names...)" Selected="true" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="text-align: right"></td>

                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadComboBox ID="cboStatus" runat="server" 
                                        DataSourceID="SqlDataSourceTicketsStatus" DataTextField="Name" DataCheckedField="ClientFilterChecked"
                                        Width="100%" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains">
                                        <Localization AllItemsCheckedString="All Status Checked" CheckAllString="Check All..." ItemsCheckedString="status checked"></Localization>
                                    </telerik:RadComboBox>
                                </td>
                                <td colspan="2" style="text-align: left">
                                    <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Text=""
                                        EmptyMessage="Find Text in Tite, Description, Notes..."
                                        LabelWidth="" Width="100%">
                                    </telerik:RadTextBox>
                                </td>

                                <td>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Search
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>

                </div>
            </div>
        </div>

        <h2 style="margin: 0">
           <span class="card bg-danger text-white">
                <asp:Label ID="lblJob" runat="server"></asp:Label></span>
        </h2>
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" GroupingEnabled="false" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="100%"
            PageSize="50" AllowPaging="true" Height="1000px" RenderMode="Auto" Skin="Bootstrap" AllowAutomaticDeletes="true"
            HeaderStyle-HorizontalAlign="Center"
            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" ShowFooter="True" CommandItemDisplay="None">
                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                <Columns>
                    <telerik:GridTemplateColumn DataField="Id" Groupable="False" HeaderText="Ticket" SortExpression="Id" UniqueName="Id" HeaderStyle-Width="60px"
                        FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnView" runat="server" Text='<%# Eval("Id")%>' CommandArgument='<%# Eval("Id")%>' ToolTip="View/Edit Ticket" 
                                CommandName="ViewEditTicket" UseSubmitBehavior="false">
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="LocationModule" HeaderText="Location/Module" UniqueName="LocationModule" HeaderStyle-Width="130px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AppName" HeaderText="App. Name" UniqueName="AppName" HeaderStyle-Width="120px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Title" HeaderText="Title" UniqueName="Title" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Size="X-Small">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ClientDescription" HeaderText="Description" UniqueName="ClientDescription" HeaderStyle-Width="350px" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Size="X-Small">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Type" HeaderText="Type" UniqueName="Type" HeaderStyle-Width="120px">
                        <ItemTemplate>
                            <span class="<%# LocalAPI.GetTickectTypeLabelCSS(Eval("Type")) %>"><%# Eval("Type") %></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Status" HeaderText="Status" UniqueName="Status" HeaderStyle-Width="180px">
                        <ItemTemplate>
                            <span class="<%# LocalAPI.GetTickectStatusLabelCSS(Eval("Status")) %>"><%# Eval("Status") %></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="ApprovedStatus" HeaderText="Approved Status" UniqueName="ApprovedStatus" HeaderStyle-Width="180px">
                        <ItemTemplate>
                            <span class="<%# LocalAPI.GetTickectApprovedStatusLabelCSS(Eval("ApprovedStatus")) %>"><%# Eval("ApprovedStatus") %></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Notes" HeaderText="Client Feedback" UniqueName="Notes" HeaderStyle-Width="350px" ItemStyle-HorizontalAlign="Left">
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this Ticket?"
                        ConfirmTitle="Delete" CommandName="Delete" UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <%--EditTicket Form--%>
    <div>
        <telerik:RadToolTip ID="RadToolTipEditTicket" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode"
            Skin="Default">
            <h2 style="margin: 0">
               <span class="card bg-danger text-white">View/Edit Ticket
                </span>
            </h2>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true"
                ValidationGroup="EditTicket" />

            <table class="table-sm" style="width: 800px; text-align: left">
                <tr>
                    <td style="text-align: right; width: 180px">Ticket #:</td>
                    <td>
                        <asp:Label ID="lblTicketId" runat="server" Font-Bold="true" Font-Size="Medium" Text="New"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;">Module/App. Name:</td>
                    <td>
                        <asp:Label ID="lblModuleApp" runat="server" Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;">Title:</td>
                    <td>
                        <asp:Label ID="lblTitle" runat="server" Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Description:</td>
                    <td>
                        <asp:Label ID="lblClientDescription" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Type:</td>
                    <td>
                        <asp:Label ID="lblType" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Status:</td>
                    <td>
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Priority:
                    </td>
                    <td>
                        <telerik:RadDropDownList ID="cboPriorityEdit" runat="server" AppendDataBoundItems="true" Width="350px" ZIndex="50001">
                            <Items>
                                <telerik:DropDownListItem Text="Low" />
                                <telerik:DropDownListItem Text="Medium" />
                                <telerik:DropDownListItem Text="High" />
                            </Items>
                        </telerik:RadDropDownList>
                    </td>
                </tr>

                <tr>
                    <td style="text-align: right">Client Approved Status:</td>
                    <td>
                        <telerik:RadDropDownList ID="cboApprovedStatus" runat="server" AppendDataBoundItems="true" Width="350px" ZIndex="50001">
                            <Items>
                                <telerik:DropDownListItem Text="Pending" Selected="true" />
                                <telerik:DropDownListItem Text="Approved" />
                                <telerik:DropDownListItem Text="Rejected" />
                            </Items>
                        </telerik:RadDropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Client Feedback:</td>
                    <td>
                        <telerik:RadTextBox ID="txtNotes" runat="server" Rows="3" TextMode="MultiLine" Width="100%" ToolTip="Notes">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Business Client:</td>
                    <td>
                        <telerik:RadTextBox ID="txtNotificationClientName" runat="server" MaxLength="80" Width="100%" ToolTip="Notification Client Name">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Notification Client Email:</td>
                    <td>
                        <telerik:RadTextBox ID="txtNotificationClientEmail" runat="server" MaxLength="128" Width="100%" ToolTip="Notification Client Email">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td>Trello URL
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txttrelloURLInsert" runat="server" MaxLength="128" Width="100%"  ToolTip="Link to Trello Card">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td>Jira URL
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtJiraURLInsert" runat="server" MaxLength="128" Width="100%"  ToolTip="Link to Jira Card">
                        </telerik:RadTextBox>
                    </td>
                </tr>
            </table>

            <br />
            <table style="width: 100%">
                <tr>
                    <td style="text-align: center">
                        <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-info btn-lg" UseSubmitBehavior="false" Width="120px" CausesValidation="true" 
                            ValidationGroup="EditTicket">
                        Update Ticket
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>

        </telerik:RadToolTip>
    </div>

    <%--InsertTicket Form--%>
    <div>
        <telerik:RadToolTip ID="RadToolTipInsertTicket" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode"
            Skin="Default">
            <h2 style="margin: 0">
               <span class="card bg-danger text-white">Insert New Ticket
                </span>
            </h2>
            <asp:ValidationSummary ID="ValidationSummary2" runat="server"
                Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true"
                ValidationGroup="InsertTicket" />

            <table class="table-sm" style="width: 800px; text-align: left">


                <tr>
                    <td style="width: 180px; text-align: right;">Location/Module:
                    </td>
                    <td>
                        <telerik:RadDropDownList ID="cboLocationModule" runat="server" AppendDataBoundItems="true" Width="350px"
                            DataSourceID="SqlDataSourceTicketLocationModule" DataTextField="Name" DataValueField="Id" ZIndex="50001">
                            <Items>
                                <telerik:DropDownListItem Text="" Selected="true" />
                            </Items>
                        </telerik:RadDropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;">App. Name:
                    </td>
                    <td>
                        <telerik:RadDropDownList ID="cboAppName" runat="server" AppendDataBoundItems="true" Width="350px"
                            DataSourceID="SqlDataSourceTicketAppName" DataTextField="Name" DataValueField="Id" ZIndex="50001">
                            <Items>
                                <telerik:DropDownListItem Text="" Selected="true" />
                            </Items>
                        </telerik:RadDropDownList>
                    </td>
                </tr>

                <tr>
                    <td style="text-align: right;">Title:</td>
                    <td>
                        <telerik:RadTextBox ID="txtTitle" runat="server" MaxLength="512" Width="100%" EmptyMessage="(*)required..." ToolTip="Title">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Description:</td>
                    <td>
                        <telerik:RadTextBox ID="txtClientDescription" runat="server" Rows="4" TextMode="MultiLine" Width="100%" ToolTip="Client Description">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Priority:
                    </td>
                    <td>
                        <telerik:RadDropDownList ID="cboPriorityInsert" runat="server" AppendDataBoundItems="true" Width="350px" ZIndex="50001">
                            <Items>
                                <telerik:DropDownListItem Text="Low" />
                                <telerik:DropDownListItem Text="Medium" />
                                <telerik:DropDownListItem Text="High" />
                            </Items>
                        </telerik:RadDropDownList>
                    </td>
                </tr>

                <tr>
                    <td style="text-align: right">Business Client:</td>
                    <td>
                        <telerik:RadTextBox ID="txtNotificationClientNameInsert" runat="server" MaxLength="80" Width="100%" ToolTip="Notification Client Name">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Notification Client Email:</td>
                    <td>
                        <telerik:RadTextBox ID="txtNotificationClientEmailInsert" runat="server" MaxLength="128" Width="100%" ToolTip="Notification Client Email">
                        </telerik:RadTextBox>
                    </td>
                </tr>

                <tr>
                    <td>Trello URL:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txttrelloURL" runat="server" MaxLength="128" Width="100%"  ToolTip="Link to Trello Card">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td>Jira URL:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtJiraURL" runat="server" MaxLength="128" Width="100%"  ToolTip="Link to Jira Card">
                        </telerik:RadTextBox>
                    </td>
                </tr>


            </table>

            <br />
            <table style="width: 100%">
                <tr>
                    <td style="text-align: center">
                        <asp:LinkButton ID="btnNewConfirm" runat="server" CssClass="btn btn-info btn-lg" UseSubmitBehavior="false" Width="120px" CausesValidation="true" ValidationGroup="InsertTicket">
                        Insert Ticket
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>

            <div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ValidationGroup="InsertTicket" SetFocusOnError="true"
                    ControlToValidate="txtTitle"
                    ErrorMessage="<span class='val-msg'><b>Location/Title</b> is required</span>">
                </asp:RequiredFieldValidator>
            </div>
        </telerik:RadToolTip>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Jobs_tickets_by_client__SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="Jobs_tickets_by_client_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="LocationModule" Type="String" />
            <asp:Parameter Name="AppName" Type="String" />
            <%--            <asp:Parameter Name="Type" Type="String" />--%>
            <asp:Parameter Name="TypeIN_List" Type="String" />
            <asp:Parameter Name="StatusIN_List" Type="String" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTicket" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="Jobs_ticket_by_client_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="Jobs_ticket_by_client_UPDATE" UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboLocationModule" Name="LocationModule" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboAppName" Name="AppName" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="txtTitle" Name="Title" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtClientDescription" Name="ClientDescription" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboPriorityInsert" Name="Priority" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="txtNotificationClientNameInsert" Name="NotificationClientName" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtNotificationClientEmailInsert" Name="NotificationClientEmail" PropertyName="Text" />
            <asp:ControlParameter ControlID="txttrelloURLInsert" Name="trelloURL" PropertyName="Text"  />
            <asp:ControlParameter ControlID="txtJiraURLInsert" Name="jiraURL" PropertyName="Text"  />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="txtNotes" Name="Notes" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboPriorityEdit" Name="Priority" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboApprovedStatus" Name="ApprovedStatus" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="txtNotificationClientName" Name="NotificationClientName" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtNotificationClientEmail" Name="NotificationClientEmail" PropertyName="Text" />
            <asp:ControlParameter ControlID="txttrelloURL" Name="trelloURL" PropertyName="Text"  />
            <asp:ControlParameter ControlID="txtJiraURL" Name="jiraURL" PropertyName="Text"  />

            <asp:ControlParameter ControlID="lblTicketId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
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

    <asp:SqlDataSource ID="SqlDataSourceTicketTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [jobs_ticket_Types] WHERE companyId=@companyId ORDER BY [Id]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTicketsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name], [ClientFilterChecked] FROM [Jobs_tickets_Status] ORDER BY [Id]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedTicketId" runat="server" Visible="False" Text=""></asp:Label>

</asp:Content>

