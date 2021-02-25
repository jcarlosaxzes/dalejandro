﻿<%@ Page Title="Pre-Projects" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="pre-projects.aspx.vb" Inherits="pasconcept20.pre_projects" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1" />
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipNewActivity" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" EnableEmbeddedSkins="false" />

    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">

            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }

        </script>

    </telerik:RadCodeBlock>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <div class="pasconcept-bar noprint">

        <span class="pasconcept-pagetitle">Pre-Proposals</span>
        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
            <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                Add Pre-Proposal
            </asp:LinkButton>
        </span>

    </div>
    <div class="collapse" id="collapseFilter">
        <asp:Panel CssClass="PanelFilter noprint" ID="pnlFind" runat="server">
            <table class=" table-condensed pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 150px">
                        <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="Pending" Value="0" Selected="true" />
                                <telerik:RadComboBoxItem runat="server" Text="Processed" Value="1" />
                                <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 350px">
                        <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient"
                            Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px"
                            AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 300px">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name"
                            DataValueField="Id" Width="100%" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech"
                            EmptyMessage="Name, Description, Location..." Width="100%">
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

    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" AllowAutomaticDeletes="True" AllowSorting="True"
        PageSize="50" AllowPaging="true" Height="850px" RenderMode="Lightweight" BorderStyle="None"
        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
        <ClientSettings Selecting-AllowRowSelect="true">
            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
        </ClientSettings>
        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
            <PagerStyle Mode="Slider" AlwaysVisible="false" />
            <Columns>
                <telerik:GridTemplateColumn DataField="Id" HeaderText="Number"
                    SortExpression="Id" UniqueName="Id" ItemStyle-HorizontalAlign="Center"
                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEditProj" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Pre-Project"
                            CommandName="EditPre_Project">
                                                <%# Eval("Pre_ProjectNumber")%>
                                                <span title="Number of files uploaded" class="badge badge-pill badge-danger" style='<%# IIf(Eval("PreProjectUploadFiles")=0,"display:none","display:normal")%>'>
                                                <%#Eval("PreProjectUploadFiles")%>
                                            </span>
                        </asp:LinkButton>
                        <div style="float: right; vertical-align: top; margin: 0;">

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

                                            <asp:LinkButton ID="btnEditProj2" runat="server" UseSubmitBehavior="false" CommandName="EditPre_Project" CommandArgument='<%# Eval("Id")%>' CssClass="dropdown-item">
                                                            <i class="fas fa-pencil-alt"></i>&nbsp;&nbsp;View/Edit Pre-Project
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
                                            <a href='<%# "clientfiles?client=" & LocalAPI.GetClientProperty(LocalAPI.GetPreProjectProperty(Eval("Id"), "clientId"), "guid") & "&preproject=true" %>' title="Upload Files" class="dropdown-item">
                                                <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp;Upload Files
                                            </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="View/Edit Client Profile" CommandArgument='<%# Eval("clientId") %>' CssClass="dropdown-item">
                                                &nbsp;&nbsp;View/Edit Client Profile
                                            </asp:LinkButton>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="padding-left: 24px">
                                            <asp:LinkButton ID="btnNewProposal" runat="server" CommandName="NewProposal" CommandArgument='<%# Eval("Id") %>' Visible='<%# Eval("statusId") = 0 %>' ToolTip="Create new Proposal">
                                                Add Proposal
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </telerik:RadToolTip>
                        </div>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="Proposal" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="130px" HeaderText="Proposal" SortExpression="Proposal" UniqueName="Proposal" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>

                        <asp:LinkButton ID="btnEditProp" runat="server" CommandArgument='<%# Eval("proposalId") %>' ToolTip="Click to View/Edit Proposal"
                            CommandName="EditProposal" Text='<%# Eval("ProposalNumber")%>' Visible='<%# Eval("statusId") = 1 And Eval("proposalId") > 0 %>'>
                        </asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="DateIn" DataFormatString="{0:MM/dd/yy}" DataType="System.DateTime"
                    HeaderText="Date" SortExpression="DateIn" UniqueName="DateIn"
                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" AllowFiltering="False" HeaderStyle-Width="80px">
                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn DataField="Name" ItemStyle-HorizontalAlign="Left"
                    FilterControlAltText="Filter Name column" HeaderText="Name - Type" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <b><%# Eval("Name") %></b>
                        <%# Eval("nProjectType") %>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="clientId" ItemStyle-HorizontalAlign="Left"
                    FilterControlAltText="Filter ClientName column" HeaderText="Client - Proposal By - Prepared By" SortExpression="ClientName" UniqueName="ClientName" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <b><%# Eval("ClientName") %></b>
                        <%# String.Concat(Eval("ProposalByName"), " - ", Eval("PreparedByName")) %>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>


                <telerik:GridTemplateColumn DataField="Status" HeaderText="Status" SortExpression="Status"
                    UniqueName="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="true" HeaderStyle-Width="120px">
                    <ItemTemplate>
                        <div style="font-size: 12px; width: 100%" class='<%# LocalAPI.GetPre_ProjectsStatusLabelCSS(Eval("statusId")) %>'><%# Eval("Status") %></div>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                </telerik:GridButtonColumn>
            </Columns>
            <EditFormSettings>
                <PopUpSettings Modal="true" Width="700px" />
                <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                </EditColumn>
            </EditFormSettings>
        </MasterTableView>
        <FilterMenu EnableImageSprites="False">
        </FilterMenu>
        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
        </HeaderContextMenu>
    </telerik:RadGrid>

    <%--New Activity Dialog--%>
    <div>
        <telerik:RadToolTip ID="RadToolTipNewActivity" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

            <table class="table-sm" style="width: 800px">
                <tr>
                    <td colspan="2">
                        <h3 style="margin: 0; text-align: center; color: white; width: 800px">
                            <span class="navbar navbar-expand-md bg-dark text-white">New Pre-Proposal Activity</span>
                        </h3>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:ValidationSummary ID="ValidationSummaryActivity" runat="server" Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="vActivity" ForeColor="Red" />
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
                        <telerik:RadComboBox ID="cboActivityEmployees" runat="server" DataSourceID="SqlDataSourceEmployees" ZIndex="50001"
                            DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Subject:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtActivitySubject" runat="server" MaxLength="255" Width="100%">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 180px; text-align: right">Due Date:
                    </td>
                    <td>
                        <telerik:RadDateTimePicker ID="RadDateTimePickerActivityDueDate" runat="server" Width="250px" ZIndex="50001">
                        </telerik:RadDateTimePicker>
                    </td>
                </tr>
                <tr>
                    <td style="width: 180px; text-align: right">Estimated Duration:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboActivityDuration" runat="server" Width="100%" ZIndex="50001" AppendDataBoundItems="True" ValidationGroup="vActivity">
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
                        <telerik:RadTextBox ID="txtActivityDescription" runat="server"
                            TextMode="MultiLine" Rows="4" MaxLength="1024" Width="100%">
                        </telerik:RadTextBox>
                    </td>
                </tr>
            </table>
            <asp:Panel runat="server" ID="PanelLocation" Visible="false">
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
                        <telerik:RadCheckBox ID="chkMoreOptions" runat="server" Text="More Options..." AutoPostBack="false">
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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtActivitySubject" ValidationGroup="vActivity"
                            Text="*" ErrorMessage="Subject is required" SetFocusOnError="true" Display="None"></asp:RequiredFieldValidator>

                    </td>
                </tr>
            </table>
        </telerik:RadToolTip>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Pre_Projects_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="DELETE FROM Clients_pre_projects WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="statusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
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

    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    
    <asp:Label ID="lblSelectedClientId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelected" runat="server" Visible="False"></asp:Label>
</asp:Content>


