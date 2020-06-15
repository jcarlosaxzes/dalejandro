<%@ Page Title="Request For Proposals" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="requestforproposals.aspx.vb" Inherits="pasconcept20.requestforproposals" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        #wrap {
            /*width: 600px;*/
            /*height: 390px;*/
            padding: 0;
            overflow: hidden;
        }

        #frame {
            zoom: 0.75;
            -moz-transform: scale(0.75);
            -moz-transform-origin: 0 0;
        }
    </style>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipAccept"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipDecline"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="chkNotifyDecline"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="chkNotifyAccept"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipNewRFPforProject"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <div class="Formulario">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 80px">
                    <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                        <i class="fas fa-filter"></i>&nbsp;Filter
                    </button>
                </td>
                <td style="width: 80px">
                    <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Add new Project and RFP for selected Subconsultants">
                       <i class="fas fa-plus"></i>&nbsp;Project & RFPs
                    </asp:LinkButton>
                </td>
                <td style="width: 80px">
                    <asp:LinkButton ID="btnDecline" runat="server" UseSubmitBehavior="false" ToolTip="Decline on selected records"
                        CausesValidation="false" CssClass="btn btn-danger">
                        <i class="fas fa-cloud-download-alt"></i> Decline
                    </asp:LinkButton>
                </td>
                <td style="width: 100px">
                    <asp:LinkButton ID="btnTreePage" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="RFP Tree view Page">
                       <span class="fas fa-stream"> Tree</span>
                    </asp:LinkButton>

                </td>
                <td style="width: 100px; text-align: right">
                    <script type="text/javascript">
                        function PrintPage(sender, args) {
                            window.print();
                        }
                    </script>
                    <telerik:RadButton ID="printbutton" OnClientClicked="PrintPage" Text="Print" runat="server" AutoPostBack="false" UseSubmitBehavior="false">
                        <Icon PrimaryIconCssClass=" rbPrint"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="text-align:center">
                    <h2 style="margin:0">
                        Request for Proposals (table view)
                    </h2>
                </td>

            </tr>
        </table>
    </div>

    <div class="collapse" id="collapseFilter">
        <div class="card card-body">
            <asp:Panel ID="pnlFind" runat="server" class="Formulario" DefaultButton="btnRefresh">
                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td style="width: 200px">
                            <telerik:RadComboBox ID="cboPeriod" runat="server" Width="100%" MarkFirstMatch="True" DropDownAutoWidth="Enabled">
                                <Items>
                                    <telerik:RadComboBoxItem Text="(Last 30 days)" Value="30" Selected="true" />
                                    <telerik:RadComboBoxItem Text="(Last 60 days)" Value="60" />
                                    <telerik:RadComboBoxItem Text="(Last 90 days)" Value="90" />
                                    <telerik:RadComboBoxItem Text="(Last 120 days)" Value="120" />
                                    <telerik:RadComboBoxItem Text="(Last 180 days)" Value="180" />
                                    <telerik:RadComboBoxItem Text="(Last 365 days)" Value="365" />
                                    <telerik:RadComboBoxItem Text="(This year)" Value="14" />
                                    <telerik:RadComboBoxItem Text="(All years...)" Value="13" />
                                    <telerik:RadComboBoxItem Text="(Custom...)" Value="99" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td style="width: 130px">
                            <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="100%" Culture="en-US" ToolTip="Date From for filter">
                            </telerik:RadDatePicker>
                        </td>
                        <td style="width: 130px">
                            <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="100%" Culture="en-US" ToolTip="Date To for Filter">
                            </telerik:RadDatePicker>
                        </td>
                        <td style="width: 400px">
                            <telerik:RadComboBox ID="cboSubconsultant" runat="server" DataSourceID="SqlDataSourceSubconsultant"
                                DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Width="100%"
                                AppendDataBoundItems="True">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(All Subconsultants…)" Value="-1" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td></td>

                    </tr>

                    <tr>
                        <td>
                            <telerik:RadComboBox ID="cboStatus" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceStatus" DataTextField="State" DataValueField="Id" Filter="Contains" MarkFirstMatch="True" Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="-1" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td colspan="2">
                            <telerik:RadComboBox ID="cboDiscipline" runat="server" DataSourceID="SqlDataSourceDiscipline"
                                DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Width="100%"
                                AppendDataBoundItems="True">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(All disciplines...)" Value="-1" />
                                </Items>
                            </telerik:RadComboBox>

                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Text=""
                                EmptyMessage="Search for Number, Project Name, ..." Width="100%">
                            </telerik:RadTextBox>
                        </td>
                        <td style="padding-left: 50px">
                            <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Search
                            </asp:LinkButton>

                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </div>

    <div>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                var popUp;
                function PopUpShowing(sender, eventArgs) {
                    popUp = eventArgs.get_popUp();
                    var gridWidth = sender.get_element().offsetWidth;
                    var gridHeight = sender.get_element().offsetHeight;
                    var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("px"));
                    var popUpHeight = popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
                    popUp.style.left = ((gridWidth - popUpWidth) / 2 + sender.get_element().offsetLeft).toString() + "px";
                    popUp.style.top = 10 + "px";
                }
                function OnClientClose(sender, args) {
                    var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                    masterTable.rebind();
                }
            </script>
        </telerik:RadCodeBlock>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSourceRFP" GridLines="None" AllowAutomaticUpdates="True"
            AllowAutomaticDeletes="True" AllowSorting="True" AllowPaging="True" PageSize="25" AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center">
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceRFP" ShowFooter="True"
                HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                    </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" HeaderStyle-Width="40px">
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="RFPNumber" HeaderText="Number" UniqueName="RFPNumber" SortExpression="RFPNumber" ItemStyle-HorizontalAlign="Center"
                        HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="EditForm" CommandArgument='<%# Eval("Id") %>'
                                Text='<%# Eval("RFPNumber") %>' ToolTip="Click to View/Edit RFP"></asp:LinkButton>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="ProjectName" HeaderText="Project" SortExpression="ProjectName"
                        UniqueName="ProjectName" HeaderStyle-HorizontalAlign="Center" FooterStyle-Font-Size="Small">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("ProjectName") %>' Visible='<%# Eval("ParentID") = 0 %>' Font-Size="Medium" Font-Bold="true" ForeColor="DarkBlue"></asp:Label>
                            <asp:Label runat="server" Text='<%# Eval("ProjectName") %>' Visible='<%# Eval("ParentID") > 0 %>'></asp:Label>
                            <div>
                                <%# Eval("SubconsultanName") %>
                                <span title="Emitted count" class="badge badge-pill badge-danger" style='<%# IIf(Eval("Emitted")=0,"display:none","display:normal")%>'><%#Eval("Emitted")%></span>
                                <span style="font-style: italic; color: gray"><%# Eval("Discipline") %></span>
                            </div>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Total" DataFormatString="{0:N2}"
                        Groupable="False" HeaderText="Total" SortExpression="Total" UniqueName="Total"
                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                        FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N}">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TotalPayments" DataFormatString="{0:N2}"
                        Groupable="False" HeaderText="Payments" SortExpression="TotalPayments" UniqueName="TotalPayments"
                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                        FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N}">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DateCreated" DataFormatString="{0:MM/dd/yy}"
                        DataType="System.DateTime" HeaderText="Date" SortExpression="DateCreated"
                        UniqueName="DateCreated" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="jobId" HeaderText="Job" SortExpression="jobId"
                        UniqueName="jobId" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                        HeaderStyle-Width="80px">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnViewJob" runat="server" CommandName="ViewJobPage" CommandArgument='<%# Eval("jobId") %>'
                                ToolTip="View Job page">
                                                <%# Eval("Code")%>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="State" HeaderText="Status" UniqueName="State"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <span class='<%# LocalAPI.GetRFPStatusLabelCSS(Eval("StateId")) %>'><%# Eval("State") %></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px">
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td style="text-align: center; width: 20%">
                                        <asp:LinkButton ID="btnNewRFP" runat="server" CommandName="NewRFPforProject" CommandArgument='<%# Eval("Id") %>' Visible='<%# Eval("ParentID") = 0 %>'
                                            UseSubmitBehavior="false" ToolTip="Add RFP for this Project">
                                            <span style="font-size:small" class="fas fa-plus"></span>
                                        </asp:LinkButton>
                                    </td>
                                    <td style="text-align: center; width: 20%">
                                        <a href='<%# LocalAPI.GetSharedLink_URL(2002, Eval("Id"))%>' target="_blank" title="Subconsultant View of RFP">
                                            <i class="far fa-share-square"></i>
                                        </a>
                                    </td>

                                    <td style="text-align: center; width: 20%">
                                        <asp:LinkButton ID="btnSendRFP" runat="server" CommandName="SendRFP" CommandArgument='<%# Eval("Id") %>'
                                            Visible='<%# IIf(Eval("StateId") <= 1, "true", "false")%>'
                                            ToolTip="Click to Send Proposal">
                                                <i class="fas fa-minus-envelope"></i>
                                        </asp:LinkButton>
                                    </td>


                                    <td style="text-align: center; width: 20%">
                                        <asp:LinkButton ID="btnAceptRFP" runat="server" CommandName="AceptRFP" CommandArgument='<%# Eval("Id") %>'
                                            Visible='<%# IIf(Eval("StateId") = 2 Or Eval("StateId") = 3, "true", "false")%>'
                                            ToolTip="Click to Accept RFP">
                                                <span style="color:green" class="fas fa-check"></span>
                                        </asp:LinkButton>
                                    </td>
                                    <td style="text-align: center;">
                                        <asp:LinkButton ID="btnDecline1" runat="server" CommandName="DeclineRFP" CommandArgument='<%# Eval("Id") %>'
                                            Visible='<%# IIf(Eval("StateId") = 2, "true", "false")%>'
                                            ToolTip="Click to Decline RFP">
                                                <i class="fas fa-minus-circle"></i>
                                        </asp:LinkButton>

                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this RequestForProposals?" ConfirmTitle="Delete"
                        ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                        HeaderText=""
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                    </telerik:GridButtonColumn>
                </Columns>

            </MasterTableView>

            <ClientSettings>
                <ClientEvents OnPopUpShowing="PopUpShowing" />
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
        </telerik:RadGrid>

    </div>
    <div>
        <telerik:RadToolTip ID="RadToolTipAccept" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

            <table class="table table-bordered" style="width: 700px">
                <tr>
                    <td>
                        <h2 style="margin: 0; text-align: center; color:white; width: 700px">
                            <span class="navbar bg-dark">
                                <asp:Label ID="lblRFPNumber" runat="server"></asp:Label>
                            </span>
                        </h2>
                    </td>
                </tr>
                <tr>
                    <td>If you <a>accept</a> the service, fees, terms and other details contained in this response, please <b>Select associated Job</b> and press
                        <b>Accept</b>
                        <br />
                        This response will be recorded as a subcontract in the job and the Subconsultant will receive a notification of award.
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadComboBox ID="cboJob" runat="server" DataSourceID="SqlDataSourceJob" ZIndex="50001" Height="300px"
                            DataTextField="JobName" DataValueField="Id" AppendDataBoundItems="True" MarkFirstMatch="True" Filter="Contains"
                            ValidationGroup="AcceptStatus"
                            Width="100%">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(Select a Job...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadCheckBox runat="server" ID="chkNotifyAccept" Checked="true" Text="Notify subconsultant?"></telerik:RadCheckBox>
                    </td>
                </tr>

                <tr>
                    <td style="text-align: center">
                        <br />
                        <br />
                        <br />
                        <asp:LinkButton ID="btnAcceptConfirm" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false"
                            CausesValidation="true" ValidationGroup="AcceptStatus">
                                    <i class="fas fa-check"></i> Accept
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
            <div>
                <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Select a Job...)" ValidationGroup="AcceptStatus"
                    Operator="NotEqual" ControlToValidate="cboJob" ErrorMessage="(*) You must select associated Job!" ForeColor="red">
                </asp:CompareValidator>

            </div>
        </telerik:RadToolTip>
    </div>

    <div>
        <telerik:RadToolTip ID="RadToolTipDecline" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

            <table class="table table-bordered" style="width: 500px">
                <tr>
                    <td>
                        <h2 style="margin: 0; text-align: center; color:white; width: 500px">
                            <span class="navbar bg-dark">Decline Selected Records
                            </span>
                        </h2>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadTextBox ID="txtDeclineNotes" runat="server" EmptyMessage="Decline notes..." Width="100%" TextMode="MultiLine" Rows="4">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadCheckBox runat="server" ID="chkNotifyDecline" Checked="true" Text="Notify subconsultant?"></telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center">
                        <br />
                        <br />
                        <br />
                        <asp:LinkButton ID="btnDeclineConfirm" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false" ValidationGroup="Deline">
                                    <i class="fas fa-check"></i> Decline
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
            <div>
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator2"
                    runat="server"
                    ControlToValidate="txtDeclineNotes"
                    ValidationGroup="Deline"
                    ForeColor="Red"
                    ErrorMessage="Decline notes is required!"></asp:RequiredFieldValidator>
            </div>
        </telerik:RadToolTip>
    </div>
    <div>
        <telerik:RadToolTip ID="RadToolTipNewRFPforProject" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
            <h2 style="margin: 0; text-align: center; color:white; width: 600px">
                <span class="navbar bg-dark">New RFP for Project
                </span>
            </h2>
            <table class="table-sm" style="width: 600px">
                <tr>
                    <td colspan="2">
                        <h4>
                            <asp:Label ID="lblProjectName" runat="server"></asp:Label>
                        </h4>
                    </td>
                </tr>
                <tr>
                    <td style="width: 180px; text-align: right">Subconsultant:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboSubconsultantNew" runat="server" DataSourceID="SqlDataSourceSubconsultant" Height="250px"
                            DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Width="100%"
                            AppendDataBoundItems="True" ZIndex="50001">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(Select Subconsultant...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:CompareValidator runat="server" ID="Comparevalidator5" ValueToCompare="(Select Subconsultant...)"
                            Operator="NotEqual" ControlToValidate="cboSubconsultantNew"
                            ErrorMessage="<span><b>Subconsultant</b> is required</span>" ValidationGroup="NewRFPforProject">
                        </asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center">
                        <br />
                        <br />
                        <br />
                        <asp:LinkButton ID="btnInsertRFPforProject" runat="server" CssClass="btn btn-success btn btn-lg" UseSubmitBehavior="false"
                            CommandName="Update" CausesValidation="true" ValidationGroup="NewRFPforProject"> Insert
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </telerik:RadToolTip>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceSubconsultant" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM [SubConsultans] WHERE (companyId = @companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRFP" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="RFP_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="RFPs_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" DefaultValue="" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboSubconsultant" Name="SubconsultanId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="StateId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDiscipline" Name="DisciplineId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceMonths" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [id], [Month] FROM [Months] ORDER BY [id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYears" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Year], nYear FROM Years ORDER BY Year DESC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [SubConsultans_disciplines] WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [State] FROM [RequestForProposals_state] ORDER BY Id"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRFPdetalles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, TaskCode, Description, isnull(DescriptionPlus,'') as DescriptionPlus, Quantity, UnitPrice, LineTotal FROM RequestForProposals_details WHERE (rfpId = @rfpId) ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblRFPSelected" Name="rfpId" PropertyName="Text" />
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
    <asp:SqlDataSource ID="SqlDataSourceJob" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT  Jobs.Id, '(' + Jobs.Code + ') ' + Jobs.Job + ' [' + isnull(Jobs_status.Name,'...')+']' AS JobName FROM Jobs LEFT OUTER JOIN Jobs_status ON Jobs.Status = Jobs_status.Id WHERE companyId=@companyId AND ISNULL(Active,0)=1 ORDER BY Jobs.Code desc">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblGuiId" runat="server" Visible="False" Text="e2103445-8a47-49ff-808e-6008c0fe13a1"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblRFPSelected" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>
