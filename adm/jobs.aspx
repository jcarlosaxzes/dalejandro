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
                    <telerik:AjaxUpdatedControl ControlID="cboStatusLotes"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lblSelectedJobId"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnUpdateJobStatus">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboStatusLotes">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cboStatusLotes"></telerik:AjaxUpdatedControl>
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
                    <telerik:AjaxUpdatedControl ControlID="lblTotalPending" />
                    <telerik:AjaxUpdatedControl ControlID="LabelblTotalBalance" />
                    <telerik:AjaxUpdatedControl ControlID="lblTotalSubContract" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnUnhide">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnHideClient">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="btnUnhide" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManagerJob"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnPrint">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManagerPrint" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
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
           <%-- function PrintReport(sender, args) {
                var RadWindow = $find("<%=RadWindowReport.ClientID%>");
                RadWindow.show();
            }--%>

            function NewJob() {
                window.open('Job.aspx?Job=-1', '_blank');
            }


            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                masterTable.rebind();


            }


            $(document).on("click", ".toggle-on", function (event) {
                var masterTableView = $find("<%= RadGrid1.ClientID %>").get_masterTableView();

                var columnIndex = masterTableView.getColumnByUniqueName("Profit").get_element().cellIndex;
                masterTableView.hideColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("Budget").get_element().cellIndex;
                masterTableView.hideColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("Balance").get_element().cellIndex;
                masterTableView.hideColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("DeleteColumn").get_element().cellIndex;
                masterTableView.hideColumn(columnIndex);

                <%--var tabStrip = $find("<%= RadTabStrip1.ClientID %>");
                var tab = tabStrip.findTabByText("Totals");
                tab.set_cssClass("hidden");--%>
            });

            $(document).on("click", ".toggle-off", function (event) {
                var masterTableView = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                var columnIndex = masterTableView.getColumnByUniqueName("Profit").get_element().cellIndex;
                masterTableView.showColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("Budget").get_element().cellIndex;
                masterTableView.showColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("Balance").get_element().cellIndex;
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
        </style>
    </telerik:RadCodeBlock>
    <telerik:RadWindowManager ID="RadWindowManagerJob" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="RadWindowManagerPrint" runat="server">
    </telerik:RadWindowManager>


    <div class="Formulario">

        <table class="noprint table-condensed" style="width: 100%">
            <tr>
                <td style="width: 80px; text-align: center">
                    <button class="btn btn-warning" type="button" data-toggle="collapse"
                        data-target="#collapseFilter"
                        aria-expanded="false"
                        aria-controls="collapseFilter" title="Show/Hide Filter panel">
                        <span class="glyphicon glyphicon-filter"></span>&nbsp;Filter
                    </button>
                </td>
                <td style="width: 80px; text-align: center">
                    <asp:Panel ID="panelTotals" runat="server" UseSubmitBehavior="false">
                        <button class="btn btn-danger" type="button" data-toggle="collapse" data-target="#collapseTotals" aria-expanded="false" aria-controls="collapseTotals">
                            $ Dashboard
                        </button>
                    </asp:Panel>

                </td>
                <td style="width: 70px; text-align: center">
                    <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                        <span class="glyphicon glyphicon-plus"></span>&nbsp;Job
                    </asp:LinkButton>
                </td>
                <td></td>
                <td style="width: 180px">
                    <telerik:RadComboBox ID="cboStatusLotes" runat="server" DataSourceID="SqlDataSourceJobStatus" ZIndex="50001" ToolTip="Update Job Status to selected records"
                        Width="100%" DropDownAutoWidth="Enabled" DataTextField="Name" DataValueField="Id" Height="300px"
                        AppendDataBoundItems="true" AutoPostBack="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Update Status...)" Value="-1" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="width: 24px; text-align: center">
                    <asp:LinkButton ID="btnPrint" runat="server" UseSubmitBehavior="false">
                                            <span style="width:20px;color:black" class="glyphicon glyphicon-print"></span>
                    </asp:LinkButton>
                </td>
                <td style="width: 24px; text-align: center">
                    <asp:LinkButton ID="btnUnhide" runat="server" UseSubmitBehavior="false" ToolTip="Show all hidden clients">
                                        <span style="width:20px;color:black" class="glyphicon glyphicon-eye-open"></span> 
                    </asp:LinkButton>
                </td>
                <td style="width: 24px; text-align: center">
                    <asp:LinkButton ID="btnCopyF" runat="server" UseSubmitBehavior="false" ToolTip="Copy/Save Filter combinations">
                                        <span style="width:20px;color:black" class="glyphicon glyphicon-copy"></span> 
                    </asp:LinkButton>
                </td>
                <td style="width: 24px; text-align: center">
                    <asp:LinkButton ID="btnPasteF" runat="server" UseSubmitBehavior="false" ToolTip="Get Paste/Shared Filter combinations">
                                        <span style="width:20px;color:black" class="glyphicon glyphicon-paste"></span>
                    </asp:LinkButton>
                </td>
                <td style="width: 24px; text-align: center">
                    <asp:LinkButton ID="btnShare" runat="server" UseSubmitBehavior="false" ToolTip="Share">
                                        <span style="width:20px;color:black" class="glyphicon glyphicon-share"></span> 
                    </asp:LinkButton>
                </td>

                <td style="width: 100px; text-align: right">
                    <asp:LinkButton ID="btnPrivate" runat="server" UseSubmitBehavior="false" class="checkbox-inline" ToolTip="Private/Public Mode">
                        <input data-toggle="toggle" data-size="mini" type="checkbox" />
                    </asp:LinkButton>
                </td>

            </tr>
        </table>

        <div class="collapse" id="collapseFilter">
            <div class="card card-body">
                <asp:Panel ID="pnlFind" runat="server" class="Formulario" DefaultButton="btnRefresh">
                    <table class="table-condensed" style="width: 100%">
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
                                    Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Balance Status...)" Value="-1" Selected="true" />
                                        <telerik:RadComboBoxItem runat="server" Text="Pending Balance" Value="100" Selected="true" />
                                        <telerik:RadComboBoxItem runat="server" Text="Balance>0. and Emitted=0" Value="1" ForeColor="White" BackColor="Blue" />
                                        <telerik:RadComboBoxItem runat="server" Text="Balance>0. and Emitted=1" Value="2" ForeColor="White" BackColor="Green" />
                                        <telerik:RadComboBoxItem runat="server" Text="Balance>0. and Emitted=2" Value="3" ForeColor="White" BackColor="Orange" />
                                        <telerik:RadComboBoxItem runat="server" Text="Balance>0. and Emitted>=3" Value="4" ForeColor="White" BackColor="OrangeRed" />
                                        <telerik:RadComboBoxItem runat="server" Text="Balance=0. Close" Value="0" ForeColor="White" BackColor="Black" />
                                        <telerik:RadComboBoxItem runat="server" Text="Balance=0. Budget ? Invoice" Value="99" ForeColor="White" BackColor="Purple" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td>

                                <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmpl" MarkFirstMatch="True" ToolTip="Select active Employye (this year)"
                                    Width="100%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="0" />
                                        <telerik:RadComboBoxItem runat="server" Text="(PM not defined...)" Value="-2" />
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
                                <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-search"></span> Search
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
        </div>

        <div class="collapse" id="collapseTotals">
            <div class="card card-body">
                <table class="table-condensed" style="width: 100%">
                    <tr>
                        <td colspan="11">
                            <hr style="margin: 0" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="11" style="text-align: center">
                            <h2 style="margin: 0">Job Dashboard</h2>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 14%; text-align: center; background-color: #039be5;">
                            <span class="DashboardFont2">Budget</span>
                            <asp:Label ID="lblTotalBudget" CssClass="DashboardFont1" runat="server" Text="$0.00"></asp:Label>
                        </td>
                        <td></td>
                        <td style="width: 14%; text-align: center; background-color: #546e7a;">
                            <span class="DashboardFont2">Billed</span>
                            <asp:Label ID="lblTotalBilled" runat="server" CssClass="DashboardFont1" Text="$0.00"></asp:Label>
                        </td>
                        <td></td>
                        <td style="width: 14%; text-align: center; background-color: #43a047;">
                            <span class="DashboardFont2">Collected</span>
                            <asp:Label ID="lblTotalCollected" runat="server" CssClass="DashboardFont1" Text="$0.00"></asp:Label>
                        </td>
                        <td></td>
                        <td style="width: 14%; text-align: center; background-color: #e53935;">
                            <span class="DashboardFont2">Pending</span>
                            <asp:Label ID="lblTotalPending" runat="server" CssClass="DashboardFont1" Text="$0.00"></asp:Label>
                        </td>
                        <td></td>
                        <td style="width: 14%; text-align: center; background-color: #43a047;">
                            <span class="DashboardFont2">Balance</span>
                            <asp:Label ID="LabelblTotalBalance" runat="server" CssClass="DashboardFont1" Text="$0.00"></asp:Label>
                        </td>
                        <td></td>
                        <td style="width: 14%; text-align: center; background-color: #e53935;">
                            <span class="DashboardFont2">SubContract</span>
                            <asp:Label ID="lblTotalSubContract" runat="server" CssClass="DashboardFont1" Text="$0.00"></asp:Label>
                        </td>

                    </tr>
                </table>
            </div>
        </div>
    </div>

    <table class="table-condensed" style="width: 100%;">
        <tr>
            <td>
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" GroupingEnabled="false" AutoGenerateColumns="False" DataSourceID="SqlDataSourceJobs" Width="100%"
                    PageSize="50" AllowPaging="true" Height="1200px" RenderMode="Auto"
                    AllowMultiRowSelection="True" AllowAutomaticDeletes="true" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                    <ClientSettings Selecting-AllowRowSelect="true">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceJobs" ShowFooter="True" CommandItemDisplay="None">
                        <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                        <Columns>
                            <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridClientSelectColumn>
                            <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" HeaderStyle-Width="10px">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="Code" Groupable="False" HeaderText="Number<br/>Actions"
                                SortExpression="Code" UniqueName="Code" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="140px"
                                FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}" ReadOnly="true">
                                <ItemTemplate>

                                    <div style="text-align: center">
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="text-align: left">
                                                    <asp:LinkButton ID="btnEditJob" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to Edit Job"
                                                        CommandName="EditJob" UseSubmitBehavior="false" ForeColor="Black">
                                            <%#Eval("Code")%> 
                                            <span title="Number of files uploaded" class="badge" style='<%# IIf(Eval("JobUploadFiles")=0,"display:none","display:normal")%>'>
                                                <%#Eval("JobUploadFiles")%>
                                            </span>
                                                    </asp:LinkButton>
                                                </td>
                                                <td style="width: 16px; text-align: right">
                                                    <asp:Label ID="lblShare" runat="server"> <span class="glyphicon glyphicon-share-alt"></asp:Label>
                                                    <telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTipShareJob" runat="server" TargetControlID="lblShare" Width="300px"
                                                        RelativeTo="Element" Position="MiddleLeft" HideEvent="ManualClose">
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td style="text-align: center">
                                                                    <telerik:RadSocialShare RenderMode="Lightweight" ID="RadSocialShare1" runat="server" Skin="Telerik"
                                                                        UrlToShare='<%# String.Concat(LocalAPI.GetHostAppSite() & "/ope/ope_project.aspx?guId=", Eval("guid"), "&Id=", Eval("id"))%>'
                                                                        TitleToShare='<%# Eval("Job")%>'>
                                                                        <MainButtons>
                                                                            <telerik:RadSocialButton SocialNetType="ShareOnFacebook"></telerik:RadSocialButton>
                                                                            <telerik:RadSocialButton SocialNetType="ShareOnTwitter"></telerik:RadSocialButton>
                                                                            <telerik:RadSocialButton SocialNetType="ShareOnGooglePlus"></telerik:RadSocialButton>
                                                                            <telerik:RadSocialButton SocialNetType="LinkedIn"></telerik:RadSocialButton>
                                                                        </MainButtons>
                                                                    </telerik:RadSocialShare>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <telerik:RadTextBox ID="txtURL" SelectionOnFocus="SelectAll" runat="server" Width="100%"
                                                                        Text='<%# String.Concat(LocalAPI.GetHostAppSite() & "/ope/ope_project.aspx?guId=", Eval("guid"), "&Id=", Eval("id"))%>'>
                                                                    </telerik:RadTextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </telerik:RadToolTip>
                                                </td>
                                            </tr>

                                        </table>


                                    </div>

                                    <div style="text-align: center">
                                        <table style="width: 100%; text-align: center">
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="btnAccounting" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to View/Edit Accounting"
                                                        CommandName="Accounting" UseSubmitBehavior="false" Visible='<%# LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Deny_InvoicesList") %>'>
                                                <span aria-hidden="true" class="glyphicon glyphicon-usd"></span>
                                                    </asp:LinkButton>
                                                </td>
                                                <td>
                                                    <a class="glyphicon glyphicon-share" title="Click to View Job" href='<%#String.Concat("../e2103445_8a47_49ff_808e_6008c0fe13a1/job.aspx?guid=", Eval("guid")) %>' target="_blank" aria-hidden="true"></a>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="btnImages" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to View/Edit Images"
                                                        CommandName="Images" UseSubmitBehavior="false" Visible='<%# LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Deny_InvoicesList") %>'>
                                                <span aria-hidden="true" class="glyphicon glyphicon-picture"></span>
                                                    </asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="btnNotes" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to View/Edit Notes"
                                                        CommandName="Notes" UseSubmitBehavior="false">
                                                <span aria-hidden="true" class="glyphicon glyphicon-edit"></span>
                                                    </asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="btnNewTime" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to Add New Time"
                                                        CommandName="NewTime" UseSubmitBehavior="false">
                                                <span aria-hidden="true" class="glyphicon glyphicon-time"></span>
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Job" FilterControlAltText="Filter Job column" HeaderText="Job Name - Type<br/>Client - Company" SortExpression="Job" UniqueName="Job" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div>
                                        <asp:LinkButton ID="btnAzureStorage" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Upload files"
                                            CommandName="AzureUpload" UseSubmitBehavior="false">
                                                    <span aria-hidden="true" class="glyphicon glyphicon-cloud-upload"></span>
                                        </asp:LinkButton>

                                        <asp:HyperLink ID="hlkJobLabel" runat="server" Text='<%# Eval("Job")%>' NavigateUrl='<%# LocalAPI.urlProjectLocationGmap(Eval("ProjectLocation"))%>' CssClass="lnkGrid"
                                            ToolTip='<%# String.Concat("Click to view [", Eval("ProjectLocation"), "] in Google Maps")%>' Target="_blank"></asp:HyperLink>

                                        <%# String.Concat(" - ",Eval("TypeName")) %>
                                    </div>
                                    <div>
                                        <asp:LinkButton ID="btnHideClient" runat="server" CommandArgument='<%# Eval("Client")%>' ToolTip="Hide client from list"
                                            CommandName="HideClient" UseSubmitBehavior="false">
                                                    <span aria-hidden="true" class="glyphicon glyphicon-eye-close"></span>
                                        </asp:LinkButton>
                                        <a title="Click here to view Scope Of Work" href='<%#String.Concat("../adm/scopeofwork.aspx?guid=", Eval("guid")) %>' target="_blank">
                                            <span class="glyphicon glyphicon glyphicon-th-list"></span>
                                        </a>
                                        <asp:Label ID="InitialsLabel" runat="server" Text='<%# String.Concat(Eval("Name")," - ",Eval("Company"))%>' CssClass="lnkGrid"></asp:Label>
                                        <telerik:RadToolTip ID="RadToolTipContact" runat="server" TargetControlID="InitialsLabel" RelativeTo="Element"
                                            Position="BottomCenter" RenderInPageRoot="true" Modal="True" Title="" ShowEvent="OnClick"
                                            HideDelay="300" HideEvent="ManualClose" IgnoreAltAttribute="true">
                                            <table class="table-condensed">
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:LinkButton ID="btnEditCli" runat="server" CommandArgument='<%# Eval("Client") %>'
                                                            CommandName="EditClient" Text='<%# Eval("Name")%>' UseSubmitBehavior="false" Font-Size="Medium"
                                                            CssClass="label label-info ">
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
                                                            Text='<%# LocalAPI.GetClientProperty(Eval("Client"), "Phone")%>' Mask="(###) ###-####" BorderStyle="None" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Cellular:
                                                    </td>
                                                    <td>
                                                        <telerik:RadMaskedTextBox ID="RadMaskedTextBox1" runat="server" ReadOnly="true"
                                                            Text='<%# LocalAPI.GetClientProperty(Eval("Client"), "Cellular")%>' Mask="(###) ###-####" BorderStyle="None" />
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

                                        <%-- Representacion previa de Tags en forma de <span.../>
                                            <asp:LinkButton ID="lnkViewTag1" runat="server" CommandName="JobTags" CommandArgument='<%# Eval("Id") %>' ToolTip="View/Edit Job TAGs">
                                            <span aria-hidden="true" class="glyphicon glyphicon-tags" style='<%# IIf(len(Eval("Tags"))>0,"display:none","display:normal")%>'></span>
                                             <%# LocalAPI.ConvertSpanTags(Eval("Tags")) %>
                                        </asp:LinkButton>--%>
                                        <asp:LinkButton ID="lnkViewTag1" runat="server" CommandName="JobTags" CommandArgument='<%# Eval("Id") %>' ToolTip="View/Edit Job TAGs">
                                            <span aria-hidden="true" class="glyphicon glyphicon-tags"></span>
                                             <%# IIf(Eval("Tags") > 0, String.Concat(" (", Eval("Tags"), ")"), "") %>
                                        </asp:LinkButton>


                                    </div>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Status" HeaderText="PM & Employees</br>Status" SortExpression="nStatus"
                                UniqueName="Status" HeaderStyle-HorizontalAlign="Center" AllowFiltering="true" HeaderStyle-Width="200px">
                                <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lnkEmployeeName" runat="server" CommandName="SetEmployee" CommandArgument='<%# Eval("Id") %>' ToolTip='<%# Eval("EmployeesSeparateComma") %>'>
                                                    <%# Eval("EmployeeName")%>
                                                    <span aria-hidden="true" class="glyphicon glyphicon-user"  style='<%# IIf(Eval("employeeNumbers")=0,"color:red","color:#23527c")%>'></span>
                                                    <span class="badge" style='<%# IIf(Eval("employeeNumbers")=0,"display:none","display:normal")%>'>
                                                        <%#Eval("employeeNumbers")%>
                                                    </span>
                                                </asp:LinkButton>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lnkEditStatus" runat="server" CommandName="EditStatus" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to edit Job Status">
                                                    <span title="Clic to edit Job Status" class="label  <%# LocalAPI.GetJobStatusLabelCSS(Eval("Status")) %>"><%# Eval("nStatus") %></span>
                                                </asp:LinkButton>
                                                <a title="Click here to download titlebox file" href='<%#String.Concat("../adm/titleblock.aspx?guid=", Eval("guid")) %>' target="_blank">
                                                    <span class="glyphicon glyphicon-cloud-download"></span>
                                                </a>
                                            </td>

                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Profit" HeaderText="Collected (%)<br/>Budget Used (%)" SortExpression="Profit"
                                UniqueName="Profit" ItemStyle-HorizontalAlign="Right"
                                FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C0}"
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="160px">
                                <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td>

                                                <telerik:RadProgressBar ID="RadProgressBar98" runat="server"
                                                    RenderMode="Lightweight"
                                                    Height="5px" ShowLabel="false"
                                                    BarType="Value"
                                                    Skin="Bootstrap"
                                                    MaxValue='<%# Eval("Budget")%>'
                                                    Value='<%# Eval("Collected")%>'
                                                    Width="100%"
                                                    Visible='<%# Eval("Collected")>0%>'>
                                                    <AnimationSettings Duration="0" />
                                                </telerik:RadProgressBar>

                                            </td>
                                            <td style="width: 32px; text-align: right">
                                                <%# GetCollectedPercent( Eval("Budget"),Eval("Collected")) %>%
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <telerik:RadProgressBar ID="RadProgressBar99" runat="server"
                                                        RenderMode="Lightweight"
                                                        Height="15px" ShowLabel="false"
                                                        BarType="Value"
                                                        Skin="Material"
                                                        MaxValue='<%# Eval("Budget")%>'
                                                        Value='<%# Eval("Coste")%>'
                                                        Width="100%"
                                                        CssClass='<%# GetBudgetUsedCss(Eval("Profit"))%>'
                                                        Visible='<%# Eval("Profit")>0%>'>
                                                        <AnimationSettings Duration="0" />
                                                    </telerik:RadProgressBar>
                                                </div>
                                            </td>
                                            <td style="text-align: right">
                                                <%# Eval("Profit", "{0:N0}")%>%
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Budget" HeaderText="Date - Budget<br/>Budget Used ($%)" SortExpression="Budget" Display="false"
                                UniqueName="Budget" ItemStyle-HorizontalAlign="Right" HeaderTooltip="Balance = [Total Invoice Amount] - [Amount Collected] - [Amount BadDebt]"
                                FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C0}"
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="160px">
                                <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="text-align: center">
                                                <asp:Label ID="lblDate1" runat="server" Text='<%# Eval("Open_date","{0:MM/dd/yyyy}")%>'></asp:Label>
                                            </td>
                                            <td style="width: 60px; text-align: right">
                                                <asp:Label ID="lblBudget" runat="server" Text='<%# Eval("Budget", "{0:N0}")%>' Font-Bold="true" ToolTip="Balance = [Total Invoice Amount] - [Amount Collected] - [Amount BadDebt]"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:LinkButton ID="lnkTime" runat="server" CommandName="JobTimes" CommandArgument='<%# Eval("Id") %>'>
                                                    <telerik:RadProgressBar ID="RadProgressBar1" runat="server" BarType="Value" Skin="Metro"
                                                        ShowLabel="true"
                                                        MaxValue='<%# Eval("Budget")%>'
                                                        Value='<%# Eval("Coste")%>'
                                                        Label='<%# GetFormatString(Eval("Coste", "{0:C0}"), Eval("Profit", "{0:N0}"))%>' Width="100%"
                                                        ToolTip='<%# String.Concat(Eval("Profit", "{0:N0}"), " %")%>' CssClass='<%# GetBudgetUsedCss(Eval("Profit"))%>'>
                                                        <AnimationSettings Duration="0" />
                                                    </telerik:RadProgressBar>
                                                </asp:LinkButton>
                                            </td>
                                            <td style="text-align: right">
                                                <span style="font-size: 12px"><%# Eval("Coste", "{0:N0}")%></span>

                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Balance" Display="false"
                                Groupable="False" HeaderText="Billed - Collected<br/> Subc.Fee - Balance" SortExpression="Balance"
                                UniqueName="Balance" FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C0}"
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="180px">
                                <ItemTemplate>
                                    <table style="width: 100%; vertical-align: top">
                                        <tr>
                                            <td style="text-align: right; width: 80px">
                                                <asp:Label ID="lblJobInvoiceAmount" runat="server" Text='<%# Eval("JobInvoiceAmount", "{0:N0}")%>' ForeColor="White" ToolTip="Total Invoice Amount"></asp:Label>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:Label ID="lblCollected" runat="server" Text='<%# Eval("Collected", "{0:N0}")%>' ToolTip="Total Invoice Collected"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="btnEditJob2" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Job"
                                                    CommandName="EditJob" Text='<%# Eval("SubContract","{0:N0}")%>' UseSubmitBehavior="false">
                                                </asp:LinkButton>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:Label ID="lblBalance" runat="server" Text='<%# Eval("Balance", "{0:N0}")%>' Font-Bold="true" ToolTip="Balance = [Total Invoice Amount] - [Amount Collected] - [Amount BadDebt]"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <%--Columnas No visibles para propositos de calculos--%>
                            <telerik:GridBoundColumn DataField="JobInvoiceAmount" UniqueName="JobInvoiceAmountHide" Aggregate="Sum" FooterAggregateFormatString="{0:C0}" Visible="false" />
                            <telerik:GridBoundColumn DataField="Collected" UniqueName="CollectedtHide" Aggregate="Sum" FooterAggregateFormatString="{0:C0}" Visible="false" />
                            <telerik:GridBoundColumn DataField="SubContract" UniqueName="SubContractHide" Aggregate="Sum" FooterAggregateFormatString="{0:C0}" Visible="false" />
                            <telerik:GridBoundColumn DataField="JobInvoiceAmountPending" UniqueName="JobInvoiceAmountPendingHide" Aggregate="Sum" FooterAggregateFormatString="{0:C0}" Visible="false" />

                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this Job?"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete" Display="false"
                                UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                            </telerik:GridButtonColumn>

                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>

            </td>
        </tr>
    </table>

    <telerik:RadToolTip ID="RadToolTipJobStatus" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table table-bordered" style="width: 500px">
            <tr>
                <td colspan="2">
                    <h2 style="margin: 0; text-align: center; width: 500px">
                        <span class="label label-default center-block">Update Job Status
                        </span>
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
                    <asp:LinkButton ID="btnUpdateJobStatus" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="100px">
                                    <span class="glyphicon glyphicon-ok"></span> Update
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCanceUpdateJobStatus" runat="server" CssClass="btn btn-default btn" CausesValidation="false" UseSubmitBehavior="false" Width="100px">
                                     Cancel
                    </asp:LinkButton>

                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipShareFilter" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; width: 500px">
            <span class="label label-default center-block">Share Copied Filters
            </span>
        </h2>
        <table class="table-condensed" style="width: 500px">
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
                                        <span class="glyphicon glyphicon-share"></span>&nbsp;Share
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSourceJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_99C_SELECT" SelectCommandType="StoredProcedure"
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

    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_types WHERE companyId=@companyId ORDER BY Name">
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
