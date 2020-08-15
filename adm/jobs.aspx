<%@ Page Title="Jobs" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="jobs.aspx.vb" Inherits="pasconcept20.jobs" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManagerJob"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipJobStatus"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lblSelectedJobId"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnUpdateJobStatus">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManagerJob"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManagerPrint"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cboPeriod" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerTo" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerFrom" />
                    <telerik:AjaxUpdatedControl ControlID="cboEmployee" />
                    <telerik:AjaxUpdatedControl ControlID="cboDepartments" />
                    <telerik:AjaxUpdatedControl ControlID="lblDepartmentIdIN_List" />
                    <telerik:AjaxUpdatedControl ControlID="lblExcludeClientId_List" />

                    <telerik:AjaxUpdatedControl ControlID="lblTotalBudget" />
                    <telerik:AjaxUpdatedControl ControlID="lblTotalBilled" />
                    <telerik:AjaxUpdatedControl ControlID="lblTotalCollected" />
                    <telerik:AjaxUpdatedControl ControlID="lblTotalBudgetUsed" />
                    <telerik:AjaxUpdatedControl ControlID="LabelblTotalBalance" />
                    <telerik:AjaxUpdatedControl ControlID="lblTotalSubFees" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnHideClient">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnApplyStatus">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManagerJob"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboPeriod">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerFrom" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerTo" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />


    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">
            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }


            $(document).on("click", ".toggle-on", function (event) {
                var masterTableView = $find("<%= RadGrid1.ClientID %>").get_masterTableView();


                columnIndex = masterTableView.getColumnByUniqueName("Profit").get_element().cellIndex;
                masterTableView.showColumn(columnIndex);

                columnIndex = masterTableView.getColumnByUniqueName("Budget").get_element().cellIndex;
                masterTableView.hideColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("Collected").get_element().cellIndex;
                masterTableView.hideColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("Balance").get_element().cellIndex;
                masterTableView.hideColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("SubFees").get_element().cellIndex;
                masterTableView.hideColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("DeleteColumn").get_element().cellIndex;
                masterTableView.hideColumn(columnIndex);

                <%--var tabStrip = $find("<%= RadTabStrip1.ClientID %>");
                var tab = tabStrip.findTabByText("Totals");
                tab.set_cssClass("hidden");--%>
            });

            $(document).on("click", ".toggle-off", function (event) {
                var masterTableView = $find("<%= RadGrid1.ClientID %>").get_masterTableView();

                columnIndex = masterTableView.getColumnByUniqueName("Profit").get_element().cellIndex;
                masterTableView.hideColumn(columnIndex);

                columnIndex = masterTableView.getColumnByUniqueName("Budget").get_element().cellIndex;
                masterTableView.showColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("Collected").get_element().cellIndex;
                masterTableView.showColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("Balance").get_element().cellIndex;
                masterTableView.showColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("SubFees").get_element().cellIndex;
                masterTableView.showColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("DeleteColumn").get_element().cellIndex;
                masterTableView.showColumn(columnIndex);

              <%--  var tabStrip = $find("<%= RadTabStrip1.ClientID %>");
                var tab = tabStrip.findTabByText("Totals");
                tab.set_cssClass("");--%>

            });

        </script>
        <style>
            .RadProgressBar_Material.rpbHorizontal {
                margin: 0 !important;
            }

            .toggle.ios, .toggle-on.ios, .toggle-off.ios {
                border-radius: 20px;
            }

                .toggle.ios .toggle-handle {
                    border-radius: 20px;
                }


            .table-sm td, .table-sm th {
                padding-top: .05rem;
                padding-bottom: .05rem;
            }
            /*Job Action Buttom*/
            .RadComboBox_Material .rcbInner {
                padding: 4px 20px 4px 4px;
            }
            .rcbActionButton {
                padding-top: 0 !important;
            }
        </style>
    </telerik:RadCodeBlock>
    <telerik:RadWindowManager ID="RadWindowManagerJob" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="RadWindowManagerPrint" runat="server">
    </telerik:RadWindowManager>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Jobs</span>
        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>

            <span id="spanViewSummary" runat="server">
                <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseSummary" aria-expanded="false" aria-controls="collapseSummary" title="Show/Hide Summary panel">
                    View Summary
                </button>
            </span>


            <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                Add Job
            </asp:LinkButton>

            <asp:LinkButton ID="btnPrivate" runat="server" UseSubmitBehavior="false" ToolTip="Private/Public Mode" Font-Underline="false">
                <input type="checkbox" data-toggle="toggle" data-onstyle="danger" />
            </asp:LinkButton>
        </span>
    </div>
    <div class="collapse" id="collapseFilter">

        <asp:Panel ID="pnlFind" runat="server" class="pasconcept-bar" DefaultButton="btnRefresh">
            <table style="width: 100%;border-collapse: separate; border-spacing: 3px;" >
                <tr>
                    <td style="width: 200px">
                        <telerik:RadComboBox ID="cboPeriod" runat="server" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True">
                            <Items>
                                <telerik:RadComboBoxItem Text="Last 30 days" Value="30" Selected="true" />
                                <telerik:RadComboBoxItem Text="Last 60 days" Value="60" />
                                <telerik:RadComboBoxItem Text="Last 90 days" Value="90" />
                                <telerik:RadComboBoxItem Text="Last 120 days" Value="120" />
                                <telerik:RadComboBoxItem Text="Last 180 days" Value="180" />
                                <telerik:RadComboBoxItem Text="Last 365 days" Value="365" />
                                <telerik:RadComboBoxItem Text="(This year...)" Value="14" />
                                <telerik:RadComboBoxItem Text="(Last year...)" Value="15" />
                                <telerik:RadComboBoxItem Text="(All years...)" Value="13" />
                                <telerik:RadComboBoxItem Text="Custom Range..." Value="99" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 130px">
                        <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="100%" Culture="en-US" ToolTip="Date From for filter">
                        </telerik:RadDatePicker>
                    </td>
                    <td style="width: 130px">
                        <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="100%" Culture="en-US" ToolTip="Date To for filter">
                        </telerik:RadDatePicker>
                    </td>
                    <td style="width: 250px">
                        <telerik:RadComboBox ID="cboBalanceStatus" runat="server"
                            Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true" DropDownAutoWidth="Enabled">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Balance Status...)" Value="-1" Selected="true" />
                                <telerik:RadComboBoxItem runat="server" Text="Pending Balance" Value="100" Selected="true" />
                                <telerik:RadComboBoxItem runat="server" Text="Existing Pending Balance, Invoice Not Emitted" Value="1" ForeColor="White" BackColor="Blue" />
                                <telerik:RadComboBoxItem runat="server" Text="Existing Pending Balance, Invoice Emitted One Time" Value="2" ForeColor="White" BackColor="Green" />
                                <telerik:RadComboBoxItem runat="server" Text="Existing Pending Balance, Invoice Emitted Two Times" Value="3" ForeColor="White" BackColor="Orange" />
                                <telerik:RadComboBoxItem runat="server" Text="Existing Pending Balance, Invoice Emitted Three Time" Value="4" ForeColor="White" BackColor="Red" />
                                <telerik:RadComboBoxItem runat="server" Text="Closed and Paid in Full." Value="0" ForeColor="White" BackColor="Black" />
                                <telerik:RadComboBoxItem runat="server" Text="Warning: No Pending Balance but Budget is Not Equal to the Billed Amount" Value="99" ForeColor="White" BackColor="Purple" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>

                        <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmpl" MarkFirstMatch="True" ToolTip="Select active Employye (this year)"
                            Width="100%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="0" />
                                <telerik:RadComboBoxItem runat="server" Text="(PM Unassigned...)" Value="-2" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <telerik:RadComboBox ID="cboStatus" runat="server" DataSourceID="SqlDataSourceJobStatus" DataTextField="Name" DataValueField="Id"
                            Width="100%" AppendDataBoundItems="true" MarkFirstMatch="True">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Active Jobs...)" Value="1001" Selected="true" />
                                <telerik:RadComboBoxItem runat="server" Text="(All Inactive Jobs...)" Value="1002" />
                                <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="1000" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td colspan="2">
                        <telerik:RadComboBox ID="cboJobType" runat="server" DataSourceID="SqlDataSourceJobTypes" DataTextField="Name" DataValueField="Id" Width="100%"
                            AppendDataBoundItems="true" Height="300px" MarkFirstMatch="True">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Job Types...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id"
                            Width="100%" CheckBoxes="true" Height="300px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains" EmptyMessage="(All Departments...)">
                            <Localization AllItemsCheckedString="All Items Checked" CheckAllString="Check All..." ItemsCheckedString="items checked"></Localization>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient"
                            Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboFilterTags" runat="server" DataSourceID="SqlDataSourceDepartment_USED_tags" DataTextField="Tag" DataValueField="Tag"
                            Width="100%" CheckBoxes="true" Height="300px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains"
                            EmptyMessage="(All Tags...)">
                            <Localization AllItemsCheckedString="All Items Checked" CheckAllString="Check All..." ItemsCheckedString="items checked"></Localization>
                        </telerik:RadComboBox>


                    </td>
                </tr>

                <tr>
                    <td colspan="4">
                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Text="" Skin="Bootstrap"
                            EmptyMessage="Job: Number, Name, Type, Location or Client: Code, Name, Company" Width="100%">
                        </telerik:RadTextBox>
                    </td>
                    <td style="text-align: right">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>
    <div runat="server" id="panelSubbar" class="pasconcept-subbar" visible="false">

        <telerik:RadComboBox ID="cboStatusLotes" runat="server" DataSourceID="SqlDataSourceJobStatus" ToolTip="Update Job Status to selected records"
            Width="175px" DataTextField="Name" DataValueField="Id" Height="200px" AppendDataBoundItems="true" Font-Size="Small">
            <Items>
                <telerik:RadComboBoxItem runat="server" Text="(Bulk Status Update)" Value="-1" />
            </Items>
        </telerik:RadComboBox>
        <asp:LinkButton ID="btnApplyStatus" runat="server" UseSubmitBehavior="false" CssClass="btn btn-primary btn-sm" ToolTip="Apply selected status to selected records">
              Update Status
        </asp:LinkButton>

        <span style="float: right; vertical-align: middle; padding-top: 3px">

            <asp:LinkButton ID="btnPrint" runat="server" UseSubmitBehavior="false">
                                            <i class="fas fa-print" style="padding-right:10px"></i>
            </asp:LinkButton>

            <asp:LinkButton ID="btnClientUnhide" runat="server" UseSubmitBehavior="false" ToolTip="Share">
            <i class="fas fa-eye" style="padding-right:10px"></i>
            </asp:LinkButton>


            <asp:LinkButton ID="btnCopyF" runat="server" UseSubmitBehavior="false" ToolTip="Copy/Save Filter combinations">
                                        <i class="far fa-copy" style="padding-right:10px"></i> 
            </asp:LinkButton>

            <asp:LinkButton ID="btnPasteF" runat="server" UseSubmitBehavior="false" ToolTip="Get Paste/Shared Filter combinations">
                                        <i class="fas fa-paste" style="padding-right:10px"></i>
            </asp:LinkButton>
            <asp:LinkButton ID="btnShare" runat="server" UseSubmitBehavior="false" ToolTip="Share">
            <i class="far fa-share-square" style="padding-right:10px"></i>
            </asp:LinkButton>
        </span>


    </div>

    <div class="collapse" id="collapseSummary">
        <table class="table-sm pasconcept-subbar" style="width: 100%; text-align: center">
            <tr>
                <td style="width: 14%; text-align: center; background-color: #039be5;">
                    <span class="DashboardFont2">Budget</span><br />
                    <asp:Label ID="lblTotalBudget" CssClass="DashboardFont1" runat="server" Text="$0.00"></asp:Label>
                </td>
                <td></td>
                <td style="width: 14%; text-align: center; background-color: #e53935">
                    <span class="DashboardFont2">Budged Used</span><br />
                    <asp:Label ID="lblTotalBudgetUsed" runat="server" CssClass="DashboardFont1" Text="$0.00"></asp:Label>
                </td>
                <td></td>
                <td style="width: 14%; text-align: center; background-color: #546e7a;">
                    <span class="DashboardFont2">Billed</span>
                    <br />
                    <asp:Label ID="lblTotalBilled" runat="server" CssClass="DashboardFont1" Text="$0.00"></asp:Label>
                </td>
                <td></td>
                <td style="width: 14%; text-align: center; background-color: #43a047;">
                    <span class="DashboardFont2">Collected</span><br />
                    <asp:Label ID="lblTotalCollected" runat="server" CssClass="DashboardFont1" Text="$0.00"></asp:Label>
                </td>
                <td></td>
                <td style="width: 14%; text-align: center; background-color: #546e7a;">
                    <span class="DashboardFont2">Balance</span><br />
                    <asp:Label ID="LabelblTotalBalance" runat="server" CssClass="DashboardFont1" Text="$0.00"></asp:Label>
                </td>
                <td></td>
                <td style="width: 14%; text-align: center; background-color: #343a40;">
                    <span class="DashboardFont2">Sub Fee(s)</span><br />
                    <asp:Label ID="lblTotalSubFees" runat="server" CssClass="DashboardFont1" Text="$0.00"></asp:Label>
                </td>

            </tr>
        </table>
    </div>

    <table class="table-sm" style="width: 100%;">
        <tr>
            <td>
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" GroupingEnabled="false" AutoGenerateColumns="False" DataSourceID="SqlDataSourceJobs" Width="100%"
                    PageSize="50" AllowPaging="true" Height="850px" RenderMode="Lightweight"
                    AllowMultiRowSelection="True" AllowAutomaticDeletes="true"
                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                    FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                    <ClientSettings Selecting-AllowRowSelect="true">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceJobs" ShowFooter="True" CommandItemDisplay="None">
                        <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                        <Columns>
                            <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="ClientSelectColumn" Visible="false">
                            </telerik:GridClientSelectColumn>
                            <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" HeaderStyle-Width="20px">
                            </telerik:GridBoundColumn>

                            <telerik:GridTemplateColumn DataField="Code" UniqueName="Code" HeaderStyle-Width="120px" HeaderText="Code" ItemStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEditJob" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to View/Edit Info" CommandName="View/Edit Info" UseSubmitBehavior="false" Font-Bold="true">
                                                <%#Eval("Code")%> 
                                    </asp:LinkButton>
                                    <div style="float: right; vertical-align: top; margin: 0;">
                                        <telerik:RadComboBox ID="cboActions" runat="server" Font-Size="X-Small" Width="30px" OnSelectedIndexChanged="cboActions_SelectedIndexChanged" AutoPostBack="true" RenderMode="Lightweight" AppendDataBoundItems="true" DropDownAutoWidth="Enabled" Skin="Material">
                                        </telerik:RadComboBox>
                                    </div>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Open_date" HeaderText="Date" UniqueName="Open_date" HeaderStyle-Width="100px" SortExpression="Open_date" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("Open_date", "{0:MM/dd/yyyy}")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Job" FilterControlAltText="Filter Job column" HeaderText="Job Name - Type - Client" SortExpression="Job" UniqueName="Job">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hlkLocation" runat="server" NavigateUrl='<%# LocalAPI.urlProjectLocationGmap(Eval("ProjectLocation"))%>'
                                        ToolTip='<%# String.Concat("Click to view [", Eval("ProjectLocation"), "] in Google Maps")%>' Target="_blank">
                                        <i class="fa fa-map-marker" aria-hidden="true"></i>
                                    </asp:HyperLink>

                                    <asp:Label runat="server" Text='<%#Eval("Job")%>' Font-Bold="true">
                                    </asp:Label>
                                    <span title="Number of files uploaded" class="badge badge-pill badge-light" style='<%# IIf(Eval("JobUploadFiles")=0,"display:none","display:normal")%>'>
                                        <%#Eval("JobUploadFiles")%>
                                    </span>
                                    <a title="Click here to view Scope Of Work" href='<%#String.Concat("../adm/scopeofwork.aspx?guid=", Eval("guid")) %>' target="_blank"
                                        style='<%# IIf(Eval("companyId")=260962,"display:normal;font-size:x-small","display:none")%>'>
                                        <i class="fas fa-th-list"></i>
                                    </a>
                                    <a title="Click here to download titlebox file" href='<%#String.Concat("../adm/titleblock.aspx?guid=", Eval("guid")) %>' target="_blank"
                                        style='<%# IIf(Eval("companyId")=260962,"display:normal;font-size:x-small","display:none")%>'>
                                        <i class="fas fa-cloud-download-alt"></i>
                                    </a>
                                    <%# Eval("JobType") %>
                                    <br />
                                    <asp:HyperLink ID="InitialsLabel" runat="server" NavigateUrl="javascript:void(0);"><%# Eval("ClientandCompany") %></asp:HyperLink>
                                    <telerik:RadToolTip ID="RadToolTipContact" runat="server" TargetControlID="InitialsLabel" RelativeTo="Element" 
                                        RenderMode="Lightweight" EnableViewState="true" ShowCallout="false" RenderInPageRoot="true"
                                        Position="BottomCenter" Modal="True" Title="" ShowEvent="OnClick"
                                        HideDelay="300" HideEvent="ManualClose" IgnoreAltAttribute="true">
                                        <table class="table-sm">
                                            <tr>
                                                <td colspan="2">
                                                    <asp:LinkButton ID="btnEditCli" runat="server" CommandArgument='<%# Eval("Id") %>'
                                                        CommandName="View/Edit Client Profile" Text='<%# Eval("ClientName")%>' UseSubmitBehavior="false" Font-Size="Medium"
                                                        CssClass="badge badge-info ">
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="margin-top: 10px">
                                                    <%# Eval("Company") %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 60px">Phone:
                                                </td>
                                                <td>
                                                    <telerik:RadMaskedTextBox ID="PhoneTextBox" runat="server" ReadOnly="true"
                                                        Text='<%# LocalAPI.GetClientProperty(Eval("ClientID"), "Phone")%>' Mask="(###) ###-####" BorderStyle="None" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Cellular:
                                                </td>
                                                <td>
                                                    <telerik:RadMaskedTextBox ID="RadMaskedTextBox1" runat="server" ReadOnly="true"
                                                        Text='<%# LocalAPI.GetClientProperty(Eval("ClientID"), "Cellular")%>' Mask="(###) ###-####" BorderStyle="None" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Email:
                                                </td>
                                                <td>
                                                    <a href='<%#String.Concat("mailto:", Eval("Email")) %>' title="Mail to"><%#Eval("Email") %></a>
                                                </td>
                                            </tr>
                                        </table>
                                    </telerik:RadToolTip>
                                    <%# IIf(Eval("Tags") > 0, String.Concat(" (", Eval("Tags"), ")"), "") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <%--PM - Employees--%>
                            <telerik:GridTemplateColumn DataField="EmployeeName" HeaderText="PM - Employees" SortExpression="EmployeeName" HeaderStyle-Width="200px"
                                UniqueName="EmployeeName" AllowFiltering="true">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEmployeeName" runat="server" CommandName="View/Edit Employees" CommandArgument='<%# Eval("Id") %>' ToolTip='<%# Eval("EmployeesSeparateComma") %>'>
                                                    <span aria-hidden="true" style='<%# IIf(Left(Eval("EmployeeName"),2)="PM","color:red","color:#23527c")%>'><%# Eval("EmployeeName")%></span>
                                                    <span class="badge badge-pill badge-primary" style='<%# IIf(Eval("OthersEmployeesCount")=0,"display:none","display:normal;font-size:x-small")%>'>
                                                        +<%# Eval("OthersEmployeesCount") %>
                                                    </span>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <%--Collected - Used--%>
                            <telerik:GridTemplateColumn DataField="Profit" HeaderText="Collected - Used" SortExpression="Profit"
                                UniqueName="Profit" ItemStyle-HorizontalAlign="Right" HeaderTooltip="Budget Collected / Budget Used" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <table style="width: 100%; padding: 0 !important; margin: 0 !important; border-spacing: 0 !important">
                                        <tr>
                                            <td style="width: 32px; text-align: right">
                                                <%# GetCollectedPercent(Eval("Budget"), Eval("Collected")) %>%
                                            </td>
                                            <td>
                                                <telerik:RadProgressBar ID="RadProgressBar98" runat="server" Font-Size="10px"
                                                    RenderMode="Lightweight"
                                                    Height="8px"
                                                    ShowLabel="false"
                                                    BarType="Percent"
                                                    Skin="Bootstrap"
                                                    ToolTip="Budget Collected"
                                                    MaxValue="100"
                                                    Value='<%# GetCollectedPercent(Eval("Budget"), Eval("Collected")) %>'
                                                    Width="100%">
                                                    <AnimationSettings Duration="0" />
                                                </telerik:RadProgressBar>
                                            </td>
                                            <td style="width: 32px;"></td>
                                        </tr>
                                    </table>
                                    <table style="width: 100%; padding: 0 !important; margin: 0 !important; border-spacing: 0 !important">
                                        <tr>
                                            <td style="width: 32px;"></td>
                                            <td>
                                                <telerik:RadProgressBar ID="RadProgressBar99" runat="server"
                                                    RenderMode="Lightweight"
                                                    Height="8px" ShowLabel="false"
                                                    BarType="Value"
                                                    Skin="Material"
                                                    MaxValue="100"
                                                    ToolTip="Budget Used"
                                                    Value='<%# Eval("Profit")%>'
                                                    Width="100%"
                                                    CssClass='<%# GetBudgetUsedCss(Eval("Profit"))%>'>
                                                    <AnimationSettings Duration="0" />
                                                </telerik:RadProgressBar>
                                            </td>
                                            <td style="width: 32px; text-align: left">
                                                <%# Eval("Profit", "{0:N0}")%>%
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <%--Status--%>
                            <telerik:GridTemplateColumn DataField="Status" HeaderText="Status" SortExpression="Status" ItemStyle-HorizontalAlign="Center"
                                UniqueName="Status" AllowFiltering="true" HeaderStyle-Width="150px">
                                <ItemTemplate>
                                    <div title="Clic to edit Job Status" class='<%# LocalAPI.GetJobStatusLabelCSS(Eval("StatusId")) %>' style="font-size: 12px; width: 120px"><%# Eval("Status") %></div>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <%--Private Mode--%>
                            <telerik:GridTemplateColumn DataField="Budget" HeaderText="Budget Used" SortExpression="Budget" Display="false"
                                UniqueName="Budget" HeaderTooltip="Budget Used of Budget"
                                Aggregate="Sum" FooterAggregateFormatString="{0:C0}" HeaderStyle-Width="140px">
                                <ItemTemplate>
                                    <table style="width: 100%; padding: 0 !important; margin: 0 !important; border-spacing: 0 !important">
                                        <tr>
                                            <td style="width: 45%; text-align: right">

                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("BudgetUsed", "{0:C0}")%>' Font-Bold="true" ToolTip="Budget Used"></asp:Label>
                                            </td>
                                            <td style="width: 5%; text-align: center">of
                                            </td>
                                            <td style="text-align: right">
                                                <asp:Label ID="lblBudget" runat="server" Text='<%# Eval("Budget", "{0:C0}")%>' Font-Bold="true" ToolTip="Job Budget"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; font-size: x-small">
                                                <%# Eval("Profit", "{0:N0}")%>%
                                            </td>
                                            <td colspan="2">
                                                <telerik:RadProgressBar ID="RadProgressBar96" runat="server"
                                                    RenderMode="Lightweight"
                                                    Height="8px" ShowLabel="false"
                                                    BarType="Value"
                                                    Skin="Material"
                                                    MaxValue="100"
                                                    ToolTip="Budget Used"
                                                    Value='<%# Eval("Profit")%>'
                                                    Width="100%"
                                                    CssClass='<%# GetBudgetUsedCss(Eval("Profit"))%>'>
                                                    <AnimationSettings Duration="0" />
                                                </telerik:RadProgressBar>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Collected" Display="false" HeaderText="Billing Collected" SortExpression="Collected" ItemStyle-HorizontalAlign="Right"
                                UniqueName="Collected" Aggregate="Sum" FooterAggregateFormatString="{0:C0}" HeaderStyle-Width="140px">
                                <ItemTemplate>
                                    <table style="width: 100%; padding: 0 !important; margin: 0 !important; border-spacing: 0 !important">
                                        <tr>
                                            <td style="width: 45%; text-align: right">
                                                <asp:Label ID="lblCollected" runat="server" Text='<%# Eval("Collected", "{0:C0}")%>' ToolTip="Total Invoices Collected" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td style="width: 5%; text-align: center">of
                                            </td>
                                            <td style="text-align: right">
                                                <asp:Label ID="lblJobBilledAmount" runat="server" Text='<%# Eval("AmountBilled", "{0:C0}")%>' ToolTip="Total Invoice Billed" Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; font-size: x-small">
                                                <asp:Label ID="lblColectedPercent" runat="server" Text='<%# GetCollectedPercent(Eval("Budget"), Eval("Collected")) %>'></asp:Label>%    
                                            </td>
                                            <td colspan="2">
                                                <telerik:RadProgressBar ID="RadProgressBar88" runat="server" Font-Size="10px"
                                                    RenderMode="Lightweight"
                                                    Height="8px"
                                                    ShowLabel="false"
                                                    BarType="Percent"
                                                    Skin="Bootstrap"
                                                    ToolTip="Budget Collected"
                                                    MaxValue="100"
                                                    Value='<%# GetCollectedPercent(Eval("Budget"), Eval("Collected")) %>'
                                                    Width="100%">
                                                    <AnimationSettings Duration="0" />
                                                </telerik:RadProgressBar>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Balance" Display="false" HeaderText="Balance" SortExpression="Balance" ItemStyle-HorizontalAlign="Right"
                                UniqueName="Balance" Aggregate="Sum" FooterAggregateFormatString="{0:C0}" HeaderStyle-Width="100px" >
                                <ItemTemplate>
                                    <asp:Label ID="lblBalance" runat="server" Text='<%# Eval("Balance", "{0:C0}")%>' ToolTip="Total Billed - Collected" Font-Bold="true"></asp:Label>
                                    <asp:Label ID="lblBalanceSymbol" runat="server">
                                                    <i class="fas fa-circle"></i>
                                                </asp:Label>

                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="SubFees" Display="false" HeaderText="Sub Fee(s)" SortExpression="SubFees" ItemStyle-HorizontalAlign="Right"
                                UniqueName="SubFees" Aggregate="Sum" FooterAggregateFormatString="{0:C0}" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblSubFee" runat="server" Text='<%# Eval("SubFees", "{0:C0}")%>' ToolTip="Total Subconsultant Fees" Font-Bold="true"></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <%--Columnas No visibles para propositos de calculos--%>
                            <telerik:GridBoundColumn DataField="AmountPending" UniqueName="JobInvoiceAmountPendingHide" Aggregate="Sum" FooterAggregateFormatString="{0:C0}" Visible="false" />
                            <telerik:GridBoundColumn DataField="AmountBilled" UniqueName="Billed" Aggregate="Sum" FooterAggregateFormatString="{0:C0}" Visible="false" />
                            <telerik:GridBoundColumn DataField="BudgetUsed" UniqueName="BudgetUsed" Aggregate="Sum" FooterAggregateFormatString="{0:C0}" Visible="false" />

                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this Job?"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete" Display="false"
                                UniqueName="DeleteColumn" HeaderText="" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                            </telerik:GridButtonColumn>

                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>

    <telerik:RadToolTip ID="RadToolTipJobStatus" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table table-bordered" style="width: 600px">
            <tr>
                <td colspan="2">
                    <h2 style="margin: 0; text-align: center; color: white; width: 600px">
                        <span class="navbar navbar-expand-md bg-dark text-white">Update Job Status</span>
                        </>
                    </h2>
                </td>
            </tr>
            <tr>
                <td style="width: 140px; text-align: right" class="Normal">New Status:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboJobNewStatus" runat="server" DataSourceID="SqlDataSourceJobNewStatus" DataTextField="Name" DataValueField="Id"
                        Filter="Contains" MarkFirstMatch="True" Width="100%" ZIndex="50001">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnUpdateJobStatus" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="120px">
                                    <i class="fas fa-check"></i> Update
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCanceUpdateJobStatus" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="120px">
                                     Cancel
                    </asp:LinkButton>

                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipShareFilter" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 500px">
            <span class="navbar navbar-expand-md bg-dark text-white">Share Copied Filters
            </span>
        </h2>
        <table class="table-sm" style="width: 500px">
            <tr>
                <td style="width: 80px">Employee To:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboEmployeeShare" runat="server" DataSourceID="SqlDataSourceEmpl_activos" ZIndex="50001"
                        Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <small>Complete the body of the email about the shared filters:
                    </small>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <telerik:RadTextBox ID="txtShareFilter" runat="server" Skin="Bootstrap" EmptyMessage="Share Filter Message" Width="100%" TextMode="MultiLine" Rows="6">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding-top: 50px; padding-bottom: 10px; text-align: right; padding-right: 15px">
                    <asp:LinkButton ID="btnShareF" runat="server" CssClass="btn btn-success" UseSubmitBehavior="false" ToolTip="Share Filters with other Employee">
                                        <i class="far fa-share-square"></i>&nbsp;Share
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSourceJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_v_20_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="JOB_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboEmployee" Name="Employee" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboClients" Name="Client" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="cboStatus" Name="Status" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblDepartmentIdIN_List" Name="DepartmentIdIN_List" PropertyName="Text" Type="String" ConvertEmptyStringToNull="False" />
            <asp:ControlParameter ControlID="cboJobType" Name="Type" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="cboBalanceStatus" Name="BalanceStatus" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblExcludeClientId_List" Name="ExcludeClientList" PropertyName="Text" Type="String" ConvertEmptyStringToNull="False" />
            <asp:ControlParameter ControlID="lblTagIN_List" Name="TagIN_List" PropertyName="Text" Type="String" ConvertEmptyStringToNull="False" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_of_JobsList_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpl" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EMPLOYEES2_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpl_activos" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_status] ORDER BY [OrderBy]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_types] WHERE companyId=@companyId ORDER BY [Id]">
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

    <asp:SqlDataSource ID="SqlDataSourceDepartment_USED_tags" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_USED_tags_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="EmployeeId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceJobNewStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Jobs_NewStatus_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSelectedJobId" Name="jobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProjectSector" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_sectors ORDER BY Name"></asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblDepartmentIdIN_List" runat="server" Visible="False" Text=""></asp:Label>
    <asp:Label ID="lblExcludeClientId_List" runat="server" Visible="False" Text=""></asp:Label>
    <asp:Label ID="lblSelectedJobId" runat="server" Visible="False" Text=""></asp:Label>
    <asp:Label ID="lblTagId" runat="server" Visible="False" Text=""></asp:Label>
    <asp:Label ID="lblTagIN_List" runat="server" Visible="False" Text=""></asp:Label>
    <asp:Label ID="lblJobIdInput" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>
