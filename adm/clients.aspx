<%@ Page Title="Clients" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="clients.aspx.vb" Inherits="pasconcept20.clients" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="ImageClientPhoto" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lblSelectedClientId" />
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipNewActivity" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNewClient">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" EnableEmbeddedSkins="false" />

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }

        </script>
       <%-- <style>
            .table-sm td, .table-sm th {
                padding-top: .05rem;
                padding-bottom: .05rem;
            }
        </style>--%>
    </telerik:RadCodeBlock>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Clients</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
           
            </button>

            <asp:LinkButton ID="btnNewClient" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    Add Client
            </asp:LinkButton>

        </span>


    </div>

    <div class="collapse" id="collapseFilter">

        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="width: 200px">
                        <telerik:RadComboBox ID="cboStatus" runat="server" AppendDataBoundItems="True"
                            Width="100%">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="Active Clients" Value="0" />
                                <telerik:RadComboBoxItem runat="server" Text="(All Clients)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="100%"
                            EmptyMessage="Search for Client Name, Organization, TAGS... ">
                        </telerik:RadTextBox>
                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>

    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" GridLines="None" AllowPaging="True"
            CellSpacing="0" AllowSorting="True" PageSize="15" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" CommandItemDisplay="None" ShowFooter="True" HeaderStyle-Font-Size="Small">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridTemplateColumn HeaderText="Photo" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                        <ItemTemplate>

                            <asp:LinkButton ID="btnEditClient2" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to Edit Client Photo"
                                CommandName="EditPhoto" UseSubmitBehavior="false">
                                <asp:Image runat="server" ID="ImageClientPhoto" ImageUrl='<%# LocalAPI.GetClientPhotoURL(Eval("Id"))%>' CssClass="photo50" AlternateText='<%# Eval("Name", "{0} photo")%>'></asp:Image>
                            </asp:LinkButton>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn Aggregate="Count" DataField="Name" FooterAggregateFormatString="{0:N0}" HeaderText="Name - Company" SortExpression="Name" ItemStyle-HorizontalAlign="Left"
                        UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td rowspan="2" style="width: 30px; text-align: left">
                                        <%--Three Point Action Menu--%>
                                        <asp:HyperLink runat="server" ID="lblAction" NavigateUrl="javascript:void(0);" Style="text-decoration: none;">
                                                <i title="Click to menu for this row" style="color:dimgray" class="fas fa-ellipsis-v"></i>
                                        </asp:HyperLink>
                                        <telerik:RadToolTip ID="RadToolTipAction" runat="server" TargetControlID="lblAction" RelativeTo="Element"
                                            RenderMode="Lightweight" EnableViewState="true" ShowCallout="false" RenderInPageRoot="true"
                                            Position="BottomRight" Modal="True" Title="" ShowEvent="OnClick"
                                            HideDelay="100" HideEvent="LeaveToolTip" IgnoreAltAttribute="true">

                                            <table class="table-borderless" style="width: 200px; font-size: medium">
                                                <tr>
                                                    <td>

                                                        <asp:LinkButton ID="btnEdit1" runat="server" UseSubmitBehavior="false" CommandName="EditClient" CommandArgument='<%# Eval("Id")%>' CssClass="dropdown-item">
                                                            <i class="fas fa-pencil-alt"></i>&nbsp;&nbsp;View/Edit Client Profile
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="dropdown-divider"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton ID="btnAddEvent" runat="server" UseSubmitBehavior="false" CommandName="AddActivity" CommandArgument='<%# Eval("Id")%>'
                                                            CssClass="dropdown-item">
                                                                 <i class="far fa-calendar"></i>&nbsp;&nbsp;Add Activity
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="dropdown-divider"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton ID="btnClone" runat="server" UseSubmitBehavior="false" CommandName="Duplicate" CommandArgument='<%# Eval("Id")%>' CssClass="dropdown-item">
                                                            <i class="far fa-clone"></i>&nbsp;&nbsp;Duplicate/Clone Client 
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="dropdown-divider"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <a href='<%# "clientfiles?client=" & Eval("guid").ToString()%>' class="dropdown-item">
                                                            <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp;Upload Files
                                                        </a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <a href='<%# LocalAPI.GetSharedLink_URL(91, Eval("Id"))%>' target="_blank" class="dropdown-item">
                                                            <i class="far fa-share-square"></i>&nbsp;&nbsp;View Client Portal
                                                        </a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="dropdown-divider"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton ID="LinkButton2" runat="server" UseSubmitBehavior="false" CommandName="SendAcknowledgment" CommandArgument='<%# Eval("Id")%>' CssClass="dropdown-item">
                                                            <i class="far fa-envelope"></i>&nbsp;&nbsp;Send Acknowledgment Email to Client
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <a href='<%# LocalAPI.GetSharedLink_URL(3001, Eval("Id"))%>' target="_blank" class="dropdown-item">
                                                            <i class="far fa-check-square"></i>&nbsp;&nbsp;View Client Acknowledgment
                                                        </a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-left: 24px">
                                                        <asp:LinkButton ID="btnToAgile" runat="server" UseSubmitBehavior="false" CommandName="ClientToAgile" CommandArgument='<%# Eval("Id")%>'
                                                            CssClass="dropdown-item" Visible='<%# lblCompanyId.Text = "260962" %>'>
                                                                Send Client to Agile CRM
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton ID="btnAddNotification" runat="server" UseSubmitBehavior="false" CommandName="AddNotifications" CommandArgument='<%# Eval("Id")%>'
                                                            CssClass="dropdown-item">
                                                                 <i class="far fa-bell"></i>&nbsp;&nbsp; Add Notification
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </telerik:RadToolTip>


                                    </td>
                                    <td>
                                        <asp:LinkButton ID="btnEditCli" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Client"
                                            CommandName="EditClient" Text='<%# Eval("Name")%>' UseSubmitBehavior="false">
                                        </asp:LinkButton>
                                        <span><%# Eval("Position") %></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%# Eval("Company")%>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Type" FilterControlAltText="Filter Type column"
                        HeaderText="Type - NAICS Code" SortExpression="Type" UniqueName="Type" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <%# Eval("nType")%>
                            <br />
                            <%# Eval("NAICSCodeAndTitle")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="Email" FilterControlAltText="Filter Email column"
                        HeaderText="Contact info - Customer Rep." SortExpression="Email" UniqueName="Email" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div>
                                <a href='<%#String.Concat("mailto:", Eval("Email")) %>' title="Mail to"><%#Eval("Email") %></a>
                                <%# String.Concat(LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone")), " ", LocalAPI.PhoneHTML(Request.UserAgent, Eval("Cellular")))%>
                                <a href='<%# Eval("Web")%>' target="_blank" title="View client web"><%#Eval("Web")%>
                                    <div>
                                        <small style="color: black"><%# Eval("SalesRep1")%></small>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="LastDateActivity" HeaderTooltip="Last Activity, Proposals, Jobs, Files..."
                        HeaderText="Insights" SortExpression="LastDateActivity" UniqueName="LastDateActivity" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="230px">
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td style="text-align: right; width: 60px">
                                        <span style="font-size: x-small" title='<%# Eval("EntityActivity")%>'><%# Eval("LastDateActivity", "{0:d}")%></span>
                                    </td>
                                    <td style="text-align: center; width: 30px">
                                        <span title="Proposals of Client" class="badge badge-pill badge-dark" style='<%# IIf(Eval("Proposals ") = 0,"display:none","display:normal")%>'><%# Eval("Proposals")%></span>
                                    </td>
                                    <td style="text-align: center; width: 30px">
                                        <span title="Jobs of Client" class="badge badge-pill badge-warning" style='<%# IIf(Eval("Jobs ") = 0,"display:none","display:normal")%>'><%# Eval("Jobs")%></span>
                                    </td>
                                    <td style="text-align: center; width: 30px">
                                        <span title="Uploaded files" class="badge badge-pill badge-secondary"><%# LocalAPI.ClientFilesCount(Eval("Id"))  %></span>
                                    </td>
                                    <td style="text-align: center;">
                                        <span title="Client linked to QuickBooks" class="badge badge-pill badge-success" style='<%# IIf(Eval("qbCustomerId ") = 0,"display:none","display:normal")%>'>qb</span>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this client and asociate user?" ConfirmTitle="Delete"
                        ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                        HeaderText="" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px"
                        ItemStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>

        </telerik:RadGrid>
    </div>

    <div>
        <telerik:RadToolTip ID="RadToolTipNewActivity" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

            <table class="table-sm" style="width: 800px">
                <tr>
                    <td colspan="2">
                        <h3 style="margin: 0; text-align: center; color: white; width: 800px">
                            <span class="navbar navbar-expand-md bg-dark text-white">New Client Activity</span>
                        </h3>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:ValidationSummary ID="ValidationSummaryJobUpdate" runat="server" Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="vActivity" ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblClientName" runat="server" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 180px; text-align: right">Activity Type:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboActivityType" runat="server" DataSourceID="SqlDataSourceActivityType" DataTextField="Name" DataValueField="Id" Width="100%" ZIndex="50001" AppendDataBoundItems="True" ValidationGroup="vActivity" CausesValidation="false">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(Select Activity...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 180px; text-align: right">Employee:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboEmployees" runat="server" DataSourceID="SqlDataSourceEmployees" ZIndex="50001"
                            DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Subject:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtSubject" runat="server" MaxLength="255" Width="100%">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 180px; text-align: right">Due Date:
                    </td>
                    <td>
                        <telerik:RadDateTimePicker ID="RadDateTimePicker1" runat="server" Width="250px" ZIndex="50001">
                        </telerik:RadDateTimePicker>
                    </td>
                </tr>
                <tr>
                    <td style="width: 180px; text-align: right">Duration:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboDuration" runat="server" Width="100%" ZIndex="50001" AppendDataBoundItems="True" ValidationGroup="vActivity">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="15 Mins" Value="15" />
                                <telerik:RadComboBoxItem runat="server" Text="30 Mins" Value="30" />
                                <telerik:RadComboBoxItem runat="server" Text="45 Mins" Value="45" />
                                <telerik:RadComboBoxItem runat="server" Text="1 Hr" Value="60" />
                                <telerik:RadComboBoxItem runat="server" Text="2 Hrs" Value="120" />
                                <telerik:RadComboBoxItem runat="server" Text="4 Hrs" Value="240" />
                                <telerik:RadComboBoxItem runat="server" Text="8 Hrs" Value="480" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Description (optional):
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtDescription" runat="server"
                            TextMode="MultiLine" Rows="4" MaxLength="1024" Width="100%">
                        </telerik:RadTextBox>
                    </td>
                </tr>
            </table>
            <asp:Panel runat="server" ID="PanelLocation" Visible="false" >
                <table class="table-sm" style="width: 800px">
                    <tr>
                        <td style="width: 180px; text-align: right">Location:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBox1" runat="server"
                                TextMode="MultiLine" Rows="4" MaxLength="1024" Width="100%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table class="table-sm" style="width: 800px">
                <tr>
                    <td>
                        <telerik:RadCheckBox ID="chkMoreOptions" runat="server" Text="More Options...">
                        </telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center">
                        <asp:LinkButton ID="btnAddActivity" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ValidationGroup="vActivity">
                                    <i class="far fa-calendar"></i>&nbsp;Add Activity
                        </asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Select Activity...)" ValidationGroup="vActivity" Operator="NotEqual" ControlToValidate="cboActivityType" Display="None" ErrorMessage="Activity Type is mandatory" SetFocusOnError="true"> </asp:CompareValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="RadDateTimePicker1" ValidationGroup="vActivity"
                            Text="*" ErrorMessage="Due Date is required" SetFocusOnError="true" Display="None"></asp:RequiredFieldValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSubject" ValidationGroup="vActivity"
                        Text="*" ErrorMessage="Subject is required" SetFocusOnError="true" Display="None"></asp:RequiredFieldValidator>

                    </td>
                </tr>
            </table>
        </telerik:RadToolTip>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Client_DUPLICATE" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboStatus" Name="StatusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblSelectedClientId" Name="Id" PropertyName="Text" />
            <asp:Parameter Direction="InputOutput" Name="Id_OUT" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceActivityType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select Id, Name from [Appointments_types] order by name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [FullName] as Name FROM [Employees] WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedClientId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>

</asp:Content>
