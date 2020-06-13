<%@ Page Title="Proposal" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposal.aspx.vb" Inherits="pasconcept20.proposal" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">
            function DataProcessing(sender, args) {
                var RadWindow = $find("<%=RadWindowDataProcessing.ClientID%>");
                RadWindow.show();
            }
            function onClientUploadFailed(sender, eventArgs) {
                alert(eventArgs.get_message())
            }
        </script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLuxW5zYQh_ClJfDEBpTLlT_tf8JVcxf0&libraries=places&callback=initAutocomplete"
            async defer></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.min.js"></script>
        <script>
            // Autocompletes all address inputs using google maps js api
            function initAutocomplete() {
                // Address Fields
                var addressInput = document.getElementsByClassName("input-address")[0];
                //var cityInput = document.getElementsByClassName("input-city")[0];
                //var stateInput = document.getElementsByClassName("input-state")[0];
                //var zipInput = document.getElementsByClassName("input-zip")[0];
                // autocomplete var
                var autocomplete = new google.maps.places.Autocomplete(addressInput);

                autocomplete.addListener('place_changed', function () {
                    var place = autocomplete.getPlace();
                    var components = place.address_components;
                    // Getting all separate fields from place object
                    var loader = {
                        locality: '',
                        administrative_area_level_1: '',
                        postal_code: '',
                        street_number: '',
                        route: '',
                        subpremise: ''
                    }
                    for (var i = 0; i < components.length; i++) {
                        var ac = components[i];
                        var types = ac.types;
                        if (types) {
                            t = types[0];
                            loader[t] = ac.short_name;
                        }
                    }

                    // Setting results
                    //cityInput.value = loader.locality;
                    //stateInput.value = loader.administrative_area_level_1;
                    //zipInput.value = loader.postal_code;
                    //// Just mandatory formats for address_line
                    //// route
                    //if (loader.route !== '')
                    //    loader.route = ' ' + loader.route;
                    //// apt number
                    //if (loader.subpremise !== '')
                    //    load.subpremise = ' #' + loader.subpremise
                    //// complete address line
                    //addressInput.value = loader.street_number + loader.route + loader.subpremise;
                });
            }
        </script>
        <style>
            .RadTabStrip .rtsLI, .RadTabStripVertical .rtsLI {
                line-height: 10px;
            }
        </style>

    </telerik:RadCodeBlock>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook"></telerik:RadWindowManager>
    <telerik:RadWindowManager ID="RadWindowManager2" runat="server">
        <Windows>
            <telerik:RadWindow ID="RadWindowDataProcessing"
                VisibleOnPageLoad="false" Behaviors="Close, Move" Modal="true" Top="10" Left="50" Height="750px" Width="850px" runat="server" VisibleStatusbar="false" DestroyOnClose="true" NavigateUrl="~/ADM/DataProcessing.aspx?ProposalId=<%=lblProposalId.Text%>">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <asp:Panel ID="panelToolbar" runat="server" CssClass="pas-container">
        <table class="table-condensed">
            <tr>
                <td>
                    <asp:LinkButton ID="btnTotals" runat="server" CssClass="btn btn-danger" UseSubmitBehavior="false">
                       $ Dashboard
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" CausesValidation="false">
                       Back to List
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="btnUpdate1" runat="server" CssClass="btn btn-success" ValidationGroup="Proposal" UseSubmitBehavior="false" ToolTip="Update Proposal">
                             Update
                    </asp:LinkButton>

                </td>
                <td>
                    <asp:LinkButton ID="btnDeleteProposal" runat="server" CssClass="btn btn-danger" UseSubmitBehavior="false" ToolTip="Delete" CausesValidation="false">
                             Delete
                    </asp:LinkButton>

                </td>
                <td>
                    <asp:LinkButton ID="btnSaveAs" runat="server" CssClass="btn btn-default" UseSubmitBehavior="false" ToolTip="Save Proposal As New Propsal"
                        CausesValidation="true" ValidationGroup="Proposal">
                             Save As
                    </asp:LinkButton>

                </td>
                <td>
                    <asp:LinkButton ID="btnSaveAsTemplate" runat="server" CssClass="btn btn-default" UseSubmitBehavior="false" ToolTip="Save Proposal As Proposal Template "
                        CausesValidation="true" ValidationGroup="Proposal">
                             Save Template
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="btnPrintProposal" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="Proposal"
                        ToolTip="Print/Send Email with Proposal Information">
                             View/Send
                    </asp:LinkButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnDataProcecing" runat="server" Text="Processing" OnClientClicked="DataProcessing" AutoPostBack="false" UseSubmitBehavior="false" CausesValidation="false" Width="120px" Visible="false">
                        <Icon PrimaryIconCssClass="rbRefresh"></Icon>
                    </telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnHelp" runat="server" Text="Help" ButtonType="LinkButton" AutoPostBack="false" Font-Bold="true" CausesValidation="false" Visible="false"
                        UseSubmitBehavior="false" Width="100px" Target="_blank" NavigateUrl="http://blog.pasconcept.com/2012/04/fee-proposal-edit-proposal-page.html">
                        <Icon PrimaryIconCssClass="rbHelp"></Icon>
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
        <div id="collapseTotals">
            <div class="card card-body">
                <asp:FormView ID="FormViewClientBalance" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceClientBalance" Width="100%" Visible="false">
                    <ItemTemplate>
                        <table class="table-condensed" style="width: 100%">
                            <tr>
                                <td colspan="9">
                                    <hr style="margin: 0" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="9" style="text-align: center">
                                    <h2 style="margin: 0"><%# Eval("ClientName")%>, <%# Eval("ClientCompany") %></h2>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 19%; text-align: center; background-color: #039be5">
                                    <span class="DashboardFont2"># Pending Props.</span><br />
                                    <asp:Label ID="lblTotalBudget" CssClass="DashboardFont1" runat="server" Text='<%# Eval("NumberPendingProposal", "{0:N0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 19%; text-align: center; background-color: #546e7a">
                                    <span class="DashboardFont2">Acepted Props.</span><br />
                                    <asp:Label ID="lblTotalBilled" runat="server" CssClass="DashboardFont1" Text='<%# Eval("ProposalAmount", "{0:C0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 19%; text-align: center; background-color: #43a047">
                                    <span class="DashboardFont2">Jobs Budget</span><br />
                                    <asp:Label ID="lblTotalCollected" runat="server" CssClass="DashboardFont1" Text='<%# Eval("ContractAmount", "{0:C0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 19%; text-align: center; background-color: #43a047">
                                    <span class="DashboardFont2">Amount Paid</span><br />
                                    <asp:Label ID="lblTotalPending" runat="server" CssClass="DashboardFont1" Text='<%# Eval("AmountPaid", "{0:C0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 19%; text-align: center; background-color: #e53935">
                                    <span class="DashboardFont2">Remaining Balance</span><br />
                                    <asp:Label ID="LabelblTotalBalance" runat="server" CssClass="DashboardFont1" Text='<%# Eval("Balance", "{0:C0}") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>

            </div>
        </div>
    </asp:Panel>
    <div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server"
            Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="Proposal" />

    </div>
    <div class="pas-container" style="width: 100%">

        <asp:FormView ID="FormViewProp1" runat="server" DataKeyNames="Id" DefaultMode="Edit" DataSourceID="SqlDataSourceProp1" Width="100%" EnableViewState="false">
            <EditItemTemplate>

                <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="false" Height="580px" DisplayProgressBar="false" DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Silk">
                    <WizardSteps>
                        <%--Proposal Details--%>
                        <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Proposal Details" StepType="Step">
                            <table class="table-condensed" style="width: 100%;">

                                <tr>
                                    <td style="text-align: right; width: 100px">Number:
                                    </td>
                                    <td style="width: 450px">
                                        <table>
                                            <tr>
                                                <td style="width: 125px">
                                                    <telerik:RadTextBox ID="txtProposalNumber" runat="server" Text='<%# Eval("ProposalNumber")%>' ReadOnly="true" Width="100%" Font-Bold="true" BackColor="#f1f1f1"></telerik:RadTextBox>
                                                </td>
                                                <td style="width: 75px; text-align: right">Job:</td>
                                                <td>
                                                    <asp:HyperLink ID="lnkRelatedJob" runat="server" CssClass="Normal" NavigateUrl='<%# Eval("jobId", "~/ADM/Job_job.aspx?JobId={0}")%>' Text='<%# Eval("JobCode")%>'></asp:HyperLink>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>

                                    <td style="text-align: right; width: 250px">Date Created:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox19" runat="server" Text='<%# Eval("Date", "{0:d}")%>' ReadOnly="true" Width="200px" Font-Bold="true" BackColor="#f1f1f1">
                                        </telerik:RadTextBox>
                                    </td>



                                </tr>

                                <tr>
                                    <td style="text-align: right;">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Text="*" ValidationGroup="Proposal" SetFocusOnError="true"
                                            ControlToValidate="txtProposalName"
                                            ErrorMessage="Name is required">
                                        </asp:RequiredFieldValidator>
                                        Name:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtProposalName" runat="server" Width="100%" Text='<%# Bind("ProjectName") %>' MaxLength="80">
                                        </telerik:RadTextBox>
                                    </td>



                                    <td style="text-align: right">Status:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtStatus" runat="server" Text='<%# Eval("Status")%>' ReadOnly="true" Width="200px" Font-Bold="true" BackColor="#f1f1f1">
                                        </telerik:RadTextBox>
                                    </td>

                                </tr>

                                <tr>
                                    <td style="text-align: right;">
                                        <asp:CompareValidator runat="server" ID="Comparevalidator3" SetFocusOnError="true" Text="*" Operator="NotEqual"
                                            ControlToValidate="cboClient"
                                            ErrorMessage="Job Type is required"
                                            ValueToCompare="(Not defined...)"
                                            ValidationGroup="Proposal">
                                        </asp:CompareValidator>
                                        Client:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboClient" runat="server" DataSourceID="SqlDataSourceClient"
                                            DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("ClientId") %>'
                                            Width="100%" Height="200" MarkFirstMatch="True">
                                        </telerik:RadComboBox>
                                    </td>



                                    <td style="text-align: right">Units:
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="txtUnit" runat="server" Width="200px" Text='<%# Bind("Unit")%>' ToolTip='<%# Eval("ProjectArea")%>'>
                                        </telerik:RadNumericTextBox>
                                    </td>

                                </tr>

                                <tr>
                                    <td style="text-align: right;">Template:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox20" runat="server" Text='<%# Eval("Template")%>' ReadOnly="true" Width="100%" BackColor="#f1f1f1">
                                        </telerik:RadTextBox>
                                    </td>



                                    <td style="text-align: right">Measure:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboMeasure" runat="server" DataSourceID="SqlDataSourceMeasure" DataTextField="Name" DataValueField="Id"
                                            SelectedValue='<%# Bind("Measure")%>' Width="200px" AppendDataBoundItems="True">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Not defined...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>

                                </tr>

                                <tr>
                                    <td style="text-align: right;">
                                        <asp:CompareValidator runat="server" ID="Comparevalidator1" SetFocusOnError="true" Text="*" Operator="NotEqual"
                                            ControlToValidate="DropDownListProjectType"
                                            ErrorMessage="Job Type is required"
                                            ValueToCompare="(Not defined...)"
                                            ValidationGroup="Proposal">
                                        </asp:CompareValidator>
                                        Job Type:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="DropDownListProjectType" runat="server" AppendDataBoundItems="True"
                                            DataSourceID="SqlDataSourceProjectType" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("ProjectType") %>' Width="100%" MarkFirstMatch="True"
                                            Filter="Contains" Height="400px">
                                        </telerik:RadComboBox>
                                    </td>



                                    <td style="text-align: right">
                                        <asp:CompareValidator runat="server" ID="Comparevalidator4" SetFocusOnError="true" Text="*" Operator="NotEqual"
                                            ControlToValidate="cboSector"
                                            ErrorMessage="Sector is required"
                                            ValueToCompare="(Not Defined...)"
                                            ValidationGroup="Proposal">
                                        </asp:CompareValidator>

                                        Sector:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboSector" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceProjectSector" DataTextField="Name" DataValueField="Id"
                                            SelectedValue='<%# Bind("ProjectSector")%>' Width="200px" MarkFirstMatch="True" Filter="Contains" Height="400px">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Selected="True" Text="(Not Defined...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>

                                </tr>

                                <tr>
                                    <td style="text-align: right;">Owner Name:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="TextBoxOwner" runat="server" Width="100%" Text='<%# Bind("Owner")%>' MaxLength="80">
                                        </telerik:RadTextBox>
                                    </td>



                                    <td style="text-align: right">
                                        <asp:CompareValidator runat="server" ID="Comparevalidator5" SetFocusOnError="true" Text="*" Operator="NotEqual"
                                            ControlToValidate="cboUse"
                                            ErrorMessage="Use & Occupancy is required"
                                            ValueToCompare="(Not Defined...)"
                                            ValidationGroup="Proposal">
                                        </asp:CompareValidator>

                                        Use & Occupancy:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboUse" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceProjectUse" DataTextField="Name" DataValueField="Id"
                                            SelectedValue='<%# Bind("ProjectUse")%>' Width="200px" MarkFirstMatch="True" Filter="Contains" Height="400px">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Selected="True" Text="(Not Defined...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>

                                </tr>

                                <tr>
                                    <td style="text-align: right;">Location:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox14" runat="server" Width="100%" Text='<%# Bind("ProjectLocation")%>' MaxLength="80"
                                            CssClass="input-address">
                                        </telerik:RadTextBox>
                                    </td>



                                    <td style="text-align: right">Client Deadline:
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker ID="RadDatePickerDeadline" runat="server" Width="200px" DbSelectedDate='<%# Bind("Deadline")%>'>
                                            <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                    </td>

                                </tr>

                                <tr>
                                    <td style="text-align: right;">
                                        <asp:CompareValidator runat="server" ID="Comparevalidator6" SetFocusOnError="true" Text="*" Operator="NotEqual"
                                            ControlToValidate="cboDepartment"
                                            ErrorMessage="Department is required"
                                            ValueToCompare="(Not Defined...)"
                                            ValidationGroup="Proposal">
                                        </asp:CompareValidator>
                                        Department:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboDepartment" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id"
                                            SelectedValue='<%# Bind("DepartmentId")%>' Width="100%" MarkFirstMatch="True" Filter="Contains" Height="400px">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Not Defined...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>



                                    <td style="text-align: right">Estimated Working Days:
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="txtWorkDays" runat="server" MaxLength="3" MinValue="1" ShowSpinButtons="True" ButtonsPosition="Right" ToolTip="five-day work week"
                                            Value="1" Width="100px" MaxValue="999" Text='<%# Bind("Workdays")%>'>
                                            <NumberFormat DecimalDigits="0" />
                                            <IncrementSettings Step="1" />
                                        </telerik:RadNumericTextBox>
                                    </td>

                                </tr>


                                <tr>
                                    <td style="text-align: right;">
                                        <asp:CompareValidator runat="server" ID="Comparevalidator7" SetFocusOnError="true" Text="*" Operator="NotEqual"
                                            ControlToValidate="cboProjectManager"
                                            ErrorMessage="Proposal by is required"
                                            ValueToCompare="(Not Defined...)"
                                            ValidationGroup="Proposal">
                                        </asp:CompareValidator>
                                        Proposal by:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboProjectManager" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceEmployee"
                                            DataTextField="Name" DataValueField="Id" Height="400px"
                                            SelectedValue='<%# Bind("ProjectManagerId")%>' Width="100%" MarkFirstMatch="True" Filter="Contains">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Not Defined...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                        <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Not Defined...)"
                                            Operator="NotEqual" ControlToValidate="cboProjectManager" Text="*" ErrorMessage="<span><b>Proposal by</b> is required</span>" ValidationGroup="Proposal">
                                        </asp:CompareValidator>

                                    </td>



                                    <td style="text-align: right;">Share with Client:</td>
                                    <td>
                                        <telerik:RadCheckBox ID="chkSharePublicLinks" runat="server" Text="Public Upload Documents" Checked='<%# Bind("SharePublicLinks")%>'
                                            ToolTip="Include file links in Proposal Acceptance" AutoPostBack="false">
                                        </telerik:RadCheckBox>
                                    </td>

                                </tr>



                                <tr>
                                    <td style="text-align: right;">Retainer:</td>
                                    <td colspan="2">
                                        <telerik:RadCheckBox ID="chkRetainer" runat="server" Checked='<%# Bind("Retainer")%>'
                                            Text="On acceptance, the first invoice will be emitted"
                                            ToolTip="If selected, upon the clients acceptance of the proposal, the first invoice of the payment schedule will be sent to the client"
                                            AutoPostBack="false">
                                        </telerik:RadCheckBox>

                                    </td>
                                    <td style="text-align: right;"></td>

                                </tr>

                            </table>
                        </telerik:RadWizardStep>

                        <%--Payment Schedules--%>
                        <telerik:RadWizardStep runat="server" ID="RadWizardStepPaymentSchedules" Title="Payment Schedules" StepType="Step">
                            <table class="table-condensed" style="width: 100%;">
                                <tr>
                                    <td style="text-align: right; width: 15px"></td>
                                    <td style="width: 400px">
                                        <telerik:RadComboBox ID="cboPaymentSchedules" runat="server" DataSourceID="SqlDataSourcePaymentSchedules" SelectedValue='<%# Bind("paymentscheduleId")%>' 
                                            DataTextField="Name" DataValueField="Id" Width="400px" MarkFirstMatch="True" AppendDataBoundItems="true"
                                            Filter="Contains"
                                            ToolTip="Select Payment Schedules to define first time or modify the current"
                                            Visible='<%# LocalAPI.IsGeneralPS(Eval("Id")) %>'>
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Select other Payment Schedules...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="btnGeneratePaymentSchedules" runat="server" CssClass="btn btn-success" UseSubmitBehavior="false" 
                                            ToolTip="Define Payment Schedules"
                                            CausesValidation="false" CommandName="Update"
                                            Visible='<%# LocalAPI.IsGeneralPS(Eval("Id")) %>'>
                                        Update
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>

                            <telerik:RadGrid ID="RadGridPS" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                                AutoGenerateColumns="False" DataSourceID="SqlDataSourcePS" HeaderStyle-HorizontalAlign="Center"
                                CellSpacing="0" Width="100%">
                                <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePS" ShowFooter="true">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="Id" HeaderText="ID" SortExpression="Id" UniqueName="Id" Display="False">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="Order" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                            HeaderText="Order" SortExpression="Order" UniqueName="Order">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Percentage" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                            HeaderText="(%)" SortExpression="Percentage" UniqueName="Percentage">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Description"
                                            HeaderText="Description" SortExpression="Description" UniqueName="Description">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="Amount" HeaderText="Total" ReadOnly="True"
                                            SortExpression="Amount" DataFormatString="{0:N2}" UniqueName="Amount" Aggregate="Sum"
                                            FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>

                        </telerik:RadWizardStep>

                        <%--Begin and Concluding Text--%>
                        <telerik:RadWizardStep runat="server" ID="RadWizardStep3" Title="Begin and Concluding Text" StepType="Step">
                            <table class="table-condensed" style="width: 100%;">
                                <tr>
                                    <td>
                                        <h4>Introductory Text:</h4>
                                        <telerik:RadTextBox ID="RadTextBoxBegin" runat="server" Text='<%# Bind("TextBegin") %>'
                                            TextMode="MultiLine" Rows="6" MaxLength="1024" Width="100%">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Concluding Text:</h4>
                                        <telerik:RadTextBox ID="RadTextBoxEnd" runat="server" Text='<%# Bind("TextEnd") %>'
                                            TextMode="MultiLine" Rows="6" MaxLength="1024" Width="100%">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%# Eval("Link") %>
                                    </td>
                                </tr>
                            </table>
                        </telerik:RadWizardStep>

                        <%--Documents--%>
                        <telerik:RadWizardStep runat="server" ID="RadWizardStep4" Title="Documents" StepType="Step">
                            <table class="table-condensed" style="width: 100%">
                                <tr>
                                    <td colspan="3">
                                        <asp:Panel runat="server" class="DropZoneClient">
                                            <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" MultipleFileSelection="Automatic" OnClientUploadFailed="onClientUploadFailed"
                                                OnFileUploaded="RadCloudUpload1_FileUploaded" ProviderType="Azure"
                                                MaxFileSize="100145728"
                                                DropZones=".DropZoneClient">
                                            </telerik:RadCloudUpload>
                                            <h4>Select or Drag and Drop files (up to 100Mb)</h4>
                                        </asp:Panel>
                                    </td>
                                    <tr>
                                        <td style="width: 350px;">
                                            <telerik:RadComboBox ID="cboDocType" runat="server" DataSourceID="SqlDataSourceDocTypes" DataTextField="Name" DataValueField="Id" ToolTip="Select file type to Upload" Label="Type:">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="width: 200px">
                                            <telerik:RadCheckBox ID="chkPublic" runat="server" Text="Public" ToolTip="Public or private" AutoPostBack="False">
                                            </telerik:RadCheckBox>
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:LinkButton ID="btnSaveUpload" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" ToolTip="Upload and Save selected files">
                                        <span class="glyphicon glyphicon-cloud-upload"></span>&nbsp;&nbsp;Upload
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                            </table>
                            <div style="padding-top: 10px">

                                <telerik:RadGrid ID="RadGridAzureFiles" runat="server" DataSourceID="SqlDataSourceAzureFiles" GroupPanelPosition="Top" ShowFooter="true"
                                    AllowAutomaticUpdates="True" AllowPaging="True" PageSize="25" AllowSorting="True" AllowAutomaticDeletes="True">
                                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id, Source" DataSourceID="SqlDataSourceAzureFiles"
                                        ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                                        <Columns>
                                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                                HeaderText="" HeaderStyle-Width="40px">
                                            </telerik:GridEditCommandColumn>

                                            <telerik:GridTemplateColumn DataField="Source" FilterControlAltText="Filter Source column" HeaderText="Source" SortExpression="Source"
                                                UniqueName="Source" HeaderStyle-Width="100px" ItemStyle-Font-Size="X-Small">
                                                <ItemTemplate>
                                                    <%# Eval("Source")%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Document" FilterControlAltText="Filter Document column" HeaderText="Document" SortExpression="Document"
                                                UniqueName="Document" HeaderStyle-Width="80px" ReadOnly="true">
                                                <ItemTemplate>
                                                    <%# Eval("Document")%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="File Name" SortExpression="Name" UniqueName="Name"
                                                ItemStyle-Font-Size="Medium" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                                <EditItemTemplate>
                                                    <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="255" Width="100%"></telerik:RadTextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)">
                                                    </asp:RequiredFieldValidator>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <a href='<%# Eval("url")%>' target="_blank" download='<%# Eval("Name") %>'><%# String.Concat(Eval("Name"), " (", Eval("ContentType"), ")")%></a>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date" SortExpression="Date" UniqueName="Date"
                                                HeaderStyle-Width="80px" ReadOnly="true">
                                                <ItemTemplate>
                                                    <%# Eval("Date", "{0:d}")%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Type" FilterControlAltText="Filter nType column" HeaderText="Type" SortExpression="nType" UniqueName="Type"
                                                HeaderStyle-Width="80px">
                                                <ItemTemplate>
                                                    <%# Eval("nType")%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox ID="cboDocType2" runat="server" DataSourceID="SqlDataSourceDocTypes" DataTextField="Name"
                                                        DataValueField="Id" Width="100%" ToolTip="Select file type to Upload" SelectedValue='<%# Bind("Type")%>'>
                                                    </telerik:RadComboBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Public" FilterControlAltText="Filter Public column" HeaderText="Public" SortExpression="Public" UniqueName="Public"
                                                HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                <EditItemTemplate>
                                                    <telerik:RadCheckBox ID="chkPublicEdit" runat="server" ToolTip="Public or private" Checked='<%# Bind("Public") %>' AutoPostBack="false"></telerik:RadCheckBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <telerik:RadCheckBox ID="chkPublicEdit" runat="server" ToolTip="Public or private" Checked='<%# Eval("Public") %>'></telerik:RadCheckBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn UniqueName="KBytes" DataFormatString="{0:N0}" ReadOnly="true" Aggregate="Sum"
                                                SortExpression="KBytes" HeaderText="KBytes" DataField="KBytes"
                                                HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                            </telerik:GridButtonColumn>
                                        </Columns>
                                        <EditFormSettings>
                                            <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </div>
                        </telerik:RadWizardStep>
                    </WizardSteps>
                </telerik:RadWizard>

            </EditItemTemplate>
        </asp:FormView>
    </div>
    <div class="pas-container" style="width: 100%">

        <telerik:RadWizard ID="RadWizard2" runat="server" DisplayCancelButton="false" DisplayProgressBar="false" DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Silk">
            <WizardSteps>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep21" Title="Task Compensation" StepType="Step">
                    <table class="table-condensed" style="width: 100%;">
                        <tr>
                            <td>
                                <asp:LinkButton ID="btnNewTask" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ValidationGroup="Proposal">
                                   <span class="glyphicon glyphicon-plus"></span> Task
                                </asp:LinkButton>

                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 10px; padding-bottom: 10px">
                                <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticDeletes="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceProposalDetails"
                                    CellSpacing="0" ValidationGroup="Proposal"
                                    ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceProposalDetails" ShowFooter="true" CommandItemDisplay="None">
                                        <BatchEditingSettings EditType="Cell" />
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="Id" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id" Display="False">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="phaseId" FilterControlAltText="Filter PhaseCode column"
                                                HeaderText="Phase" SortExpression="PhaseCode" UniqueName="phaseId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblphaseId" runat="server" Text='<%# Eval("PhaseCode") %>' ToolTip='<%# Eval("PhaseName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <div>
                                                        <telerik:RadDropDownList runat="server" ID="PhaseDropDown" DataValueField="Id" Width="95%" DataTextField="Code" DataSourceID="SqlDataSourcePhases"
                                                            AppendDataBoundItems="true" DropDownWidth="150px">
                                                            <Items>
                                                                <telerik:DropDownListItem Text="?" Value="0" />
                                                            </Items>
                                                        </telerik:RadDropDownList>
                                                    </div>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="positionId" FilterControlAltText="Filter positionCode column" Display="false"
                                                HeaderText="Position" SortExpression="positionCode" UniqueName="positionId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblpositionId" runat="server" Text='<%# Eval("Position") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <div>
                                                        <telerik:RadDropDownList runat="server" ID="positionDropDown" DataValueField="Id" Width="95%" DataTextField="Name" DataSourceID="SqlDataSourcePositions"
                                                            AppendDataBoundItems="true" DropDownWidth="400px">
                                                            <Items>
                                                                <telerik:DropDownListItem Text="?" Value="0" />
                                                            </Items>
                                                        </telerik:RadDropDownList>
                                                    </div>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="taskcode" HeaderText="Task" ReadOnly="True" SortExpression="taskcode"
                                                UniqueName="taskcode" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkDetailId" runat="server" CommandName="EditTask" CommandArgument='<%# Eval("Id") %>' ValidationGroup="Proposal" UseSubmitBehavior="false"
                                                        Text='<%# Eval("taskcode")%>' ToolTip="Click to Edit detail"></asp:LinkButton>

                                                    <asp:LinkButton ID="btnDuplicate" runat="server" CommandName="DetailDuplicate" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false"
                                                        ToolTip="Click to duplicate record">
                                                    <span class="glyphicon glyphicon-duplicate"></span>
                                                    </asp:LinkButton>

                                                </ItemTemplate>

                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                                                HeaderText="Name" SortExpression="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescrip" runat="server" Text='<%# Eval("Description") %>' ToolTip='<%# Eval("DescriptionPlus") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadTextBox ID="DescriptionTextBox" runat="server" MaxLength="80" Text='<%# Bind("Description") %>' Width="98%">
                                                    </telerik:RadTextBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Amount" DataType="System.Double" HeaderText="Qty"
                                                SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount", "{0:N2}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadNumericTextBox ID="txtAmount" runat="server" Text='<%# Bind("Amount") %>' Width="95%">
                                                        <NumberFormat DecimalDigits="2" />
                                                    </telerik:RadNumericTextBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Hours" DataType="System.Double" HeaderText="Hours"
                                                SortExpression="Hours" UniqueName="Hours" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblHours" runat="server" Text='<%# Eval("Hours", "{0:N2}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadNumericTextBox ID="txtTimeSel" runat="server" MaxLength="5" Text='<%# Bind("Hours") %>' Width="95%">
                                                        <NumberFormat DecimalDigits="2" />
                                                    </telerik:RadNumericTextBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Rates" DataType="System.Double" HeaderText="Rates"
                                                SortExpression="Rates" UniqueName="Rates" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRates" runat="server" Text='<%# Eval("Rates", "{0:N2}")%>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadNumericTextBox ID="RatesTextBox" runat="server" Text='<%# Bind("Rates") %>' Width="95%">
                                                        <NumberFormat DecimalDigits="6" />
                                                    </telerik:RadNumericTextBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="Estimator" HeaderText="Estimated" ReadOnly="True"
                                                SortExpression="Estimator" DataFormatString="{0:N2}" UniqueName="Estimated" Aggregate="Sum"
                                                FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TotalRow" HeaderText="Total" ReadOnly="True"
                                                SortExpression="TotalRow" DataFormatString="{0:N2}" UniqueName="TotalRow" Aggregate="Sum"
                                                FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?"
                                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                                UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                            </telerik:GridButtonColumn>
                                        </Columns>
                                        <EditFormSettings>
                                            <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep22" Title="Phases" StepType="Step">
                    <div style="width: 100%; padding-left: 18px; padding-top: 12px">
                        <asp:LinkButton ID="btnNewPhase" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Add New Phase">
                                   <span class="glyphicon glyphicon-plus"></span> Phase
                        </asp:LinkButton>

                        &nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnPivotPhases" runat="server" CssClass="btn btn-default" UseSubmitBehavior="false" ToolTip="Add New Phase">
                                   <span class="glyphicon glyphicon-plus"></span> Project Phases
                        </asp:LinkButton>
                    </div>
                    <div style="padding-top: 12px; padding-left: 18px; padding-bottom: 10px">
                        <telerik:RadGrid ID="RadGridPhases" runat="server" DataSourceID="SqlDataSourcePhases" GridLines="None" AllowAutomaticDeletes="true"
                            AutoGenerateColumns="False" CellSpacing="0" ShowFooter="true"
                            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePhases">
                                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                <BatchEditingSettings EditType="Cell" />
                                <CommandItemSettings ShowAddNewRecordButton="false" />
                                <Columns>
                                    <telerik:GridTemplateColumn DataField="Code" HeaderStyle-Width="100px"
                                        FilterControlAltText="Filter Code column" HeaderText="Code" SortExpression="Code" UniqueName="Code" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkPhaseEdit" runat="server" CommandName="EditPhase" CommandArgument='<%# Eval("Id") %>'
                                                Text='<%# Eval("Code")%>' ToolTip="Click to Edit Phase"></asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="Name"
                                        FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="300px">
                                        <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator ForeColor="Red" Text="*" Display="Dynamic">
                                            </RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Period" HeaderStyle-Width="180px"
                                        FilterControlAltText="Filter Period column" HeaderText="Period" SortExpression="Period" UniqueName="Period" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Task" HeaderText="Task" ReadOnly="True" SortExpression="Task" DataFormatString="{0:N0}" UniqueName="Task" Aggregate="Sum"
                                        FooterAggregateFormatString="{0:N0}" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" DataFormatString="{0:N2}" UniqueName="Total" Aggregate="Sum"
                                        FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this phase?"
                                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                        UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>

                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep23" Title="Schedule" StepType="Step">
                    <div style="width: 100%; padding-left: 18px; padding-top: 12px">
                        <asp:LinkButton ID="btnSchedule" runat="server" CssClass="btn btn-default" UseSubmitBehavior="false">
                             Project Schedule
                        </asp:LinkButton>
                    </div>
                    <div style="padding-top: 12px; padding-left: 18px; padding-bottom: 10px">
                        <telerik:RadGrid ID="RadGridPheseSchedule" runat="server" DataSourceID="SqlDataSourcePhasesSchedule" GridLines="None" AllowAutomaticUpdates="true"
                            AutoGenerateColumns="False" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                            <ClientSettings>
                                <Selecting AllowRowSelect="true"></Selecting>
                            </ClientSettings>
                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePhasesSchedule">
                                <PagerStyle Mode="Slider" AlwaysVisible="false" />

                                <Columns>
                                    <telerik:GridTemplateColumn DataField="Id" FilterControlAltText="Filter Department column" HeaderText="Edit" SortExpression="Id" UniqueName="Id"
                                        HeaderStyle-HorizontalAlign="Center" ReadOnly="true" HeaderStyle-Width="150px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEditPhaseSc" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="Edit" Text='<%# (Eval("Task")) %>' ToolTip="Click to edit" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="Name" ReadOnly="true"
                                        FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="DateFrom" HeaderText="Date From" SortExpression="DateFrom" UniqueName="DateFrom" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDateFrom" runat="server" Text='<%# Eval("DateFrom", "{0:d}")%>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="DateTo" HeaderText="Date To" SortExpression="DateTo" UniqueName="DateTo" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDateTo" runat="server" Text='<%# Eval("DateTo", "{0:d}")%>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <EditFormSettings EditFormType="Template">
                                    <FormTemplate>
                                        <table class="table-condensed" style="width: 100%;">
                                            <tr>
                                                <td style="width: 150px">Phase Date From
                                                </td>
                                                <td style="width: 150px">Phase Date End
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" Width="90%" DbSelectedDate='<%# Bind("DateFrom")%>' Culture="en-us">
                                                        <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" Width="90%" DbSelectedDate='<%# Bind("DateTo")%>' Culture="en-us">
                                                        <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                                <td style="text-align: center">
                                                    <telerik:RadButton ID="ddd" Text="Update" runat="server" CommandName="Update" Width="100px">
                                                    </telerik:RadButton>
                                                    <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success" CommandName="Update">
                                                    Update
                                                    </asp:LinkButton>
                                                    &nbsp;&nbsp;
                                                <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-default" CommandName="Cancel" CausesValidation="False">
                                                    Cancel
                                                </asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <h3 style="margin: 3px">Task of the selected phase</h3>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <telerik:RadGrid ID="RadGridTaskSchedule" runat="server" DataSourceID="SqlDataSourceTaskSchedule" GridLines="None" Width="100%"
                                                        AllowAutomaticUpdates="true" AutoGenerateColumns="False" CellSpacing="0">
                                                        <ClientSettings AllowKeyboardNavigation="true"></ClientSettings>
                                                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceTaskSchedule" CommandItemDisplay="Top" EditMode="Batch">
                                                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                                            <BatchEditingSettings EditType="Cell" />
                                                            <CommandItemSettings ShowAddNewRecordButton="false" />
                                                            <Columns>
                                                                <telerik:GridBoundColumn DataField="Name" ReadOnly="true"
                                                                    FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridTemplateColumn DataField="DateFrom" HeaderText="Date From" SortExpression="DateFrom" UniqueName="DateFrom" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDateFrom" runat="server" Text='<%# Eval("DateFrom", "{0:d}")%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <telerik:RadDatePicker ID="RadDatePickerFromTask" runat="server" Width="90%" DbSelectedDate='<%# Bind("DateFrom")%>' Culture="en-us"
                                                                            MinDate='<%# Bind("MinDate")%>' MaxDate='<%# Bind("MaxDate")%>'>
                                                                            <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                                                                            </DateInput>
                                                                        </telerik:RadDatePicker>

                                                                    </EditItemTemplate>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn DataField="DateTo" HeaderText="Date To" SortExpression="DateTo" UniqueName="DateTo" HeaderStyle-Width="150" HeaderStyle-HorizontalAlign="Center">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDateTo" runat="server" Text='<%# Eval("DateTo", "{0:d}")%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <telerik:RadDatePicker ID="RadDatePickerToTask" runat="server" Width="90%" DbSelectedDate='<%# Bind("DateTo")%>' Culture="en-us"
                                                                            MinDate='<%# Bind("MinDate")%>' MaxDate='<%# Bind("MaxDate")%>'>
                                                                            <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                                                                            </DateInput>
                                                                        </telerik:RadDatePicker>
                                                                    </EditItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                </td>
                                            </tr>
                                        </table>
                                    </FormTemplate>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>

                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep24" Title="Term & Conditions" StepType="Step">
                    <table class="table-condensed" style="width: 100%;">
                        <tr>
                            <td>
                                <asp:FormView ID="FormViewTC" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourcePropTC" Width="100%" EnableViewState="false">
                                    <ItemTemplate>
                                        <div style="padding-bottom: 5px">
                                            <asp:LinkButton ID="btnEditTyC" runat="server" CssClass="btn btn-success" UseSubmitBehavior="false" CommandName="Edit" ToolTip="Edit Term & Conditions" CausesValidation="false">
                                                 Term & Conditions
                                            </asp:LinkButton>

                                        </div>
                                        <div style="padding-left: 20px">
                                            <asp:Label ID="lblTyC" runat="server" Text='<%# Eval("Agreements")%>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table class="table-condensed" style="width: 100%;">
                                            <tr>
                                                <td colspan="2">
                                                    <table class="table-condensed" style="width: 100%;">
                                                        <tr>
                                                            <td colspan="3" class="Pequena">To modify T&C, you can select a template from the dropdown menu. You can also modify the text manually or copy and paste from the clipboard. Press Update to save chances</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 300px">
                                                                <telerik:RadComboBox ID="cboTandCtemplates" runat="server" DataSourceID="SqlDataSourceTandCtemplates"
                                                                    DataTextField="Name" DataValueField="Id" Width="100%" Height="200px" AppendDataBoundItems="true" ToolTip="To modify the current, select T&C template">
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem runat="server" Text="(Select other T&C Template...)" Value="-1" />
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                            </td>
                                                            <td style="width: 160px">
                                                                <%-- <telerik:RadButton ID="btnUpdateTandCTemplate" runat="server" CommandName="UpdateTandC"
                                                                OnClick="btnUpdateTandCTemplate_Click" Text="Set T&amp;C Template" Width="140px" CausesValidation="false">
                                                                <Icon PrimaryIconCssClass="rbConfig"></Icon>
                                                            </telerik:RadButton>--%>
                                                                <asp:LinkButton ID="btnUpdateTandCTemplate" runat="server" CommandName="UpdateTandC" CssClass="btn btn-success" UseSubmitBehavior="false" CausesValidation="false">
                                                                Apply
                                                                </asp:LinkButton>

                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btnUpdateTyC" runat="server" CommandName="Update" CssClass="btn btn-success" UseSubmitBehavior="false" CausesValidation="false">
                                                                Update
                                                                </asp:LinkButton>
                                                                &nbsp;
                                                            <asp:LinkButton ID="btnCancelTyC" runat="server" CommandName="Cancel" CssClass="btn btn-default" UseSubmitBehavior="false" CausesValidation="false">
                                                                Cancel
                                                            </asp:LinkButton>

                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td colspan="2">
                                                    <telerik:RadEditor ID="radEditor_TandC" runat="server" Content='<%# Bind("Agreements") %>'
                                                        Height="600px" ToolsFile="~/BasicTools.xml" AllowScripts="True" EditModes="Design" RenderMode="Auto"
                                                        Width="98%">
                                                    </telerik:RadEditor>
                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </asp:FormView>
                            </td>
                        </tr>
                    </table>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep25" Title="Actions" StepType="Step">
                    <div style="width: 100%; padding-left: 15px; padding-top: 5px">
                        <h4 style="margin: 0">Other Actions</h4>
                    </div>
                    <table class="table-condensed" style="width: 100%;">
                        <tr>
                            <td style="text-align: right;">Change Status:</td>
                            <td>
                                <telerik:RadComboBox ID="cboStatus" runat="server" DataSourceID="SqlDataSourceStatus" Width="100%"
                                    DataTextField="Status" DataValueField="Id" Height="200px" AutoPostBack="true">
                                </telerik:RadComboBox>

                            </td>
                            <td>
                                <asp:LinkButton ID="btnUpdateStatus" runat="server" CssClass="btn btn-success" Enabled="False" UseSubmitBehavior="false" ToolTip="Update Status" CausesValidation="false">
                                     Update
                                </asp:LinkButton>

                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right; width: 150px">Change Template:
                            </td>
                            <td style="width: 350px">
                                <telerik:RadComboBox ID="cboProposalType" runat="server" DataSourceID="SqlDataSourceProposalType" DataTextField="Name"
                                    DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" AutoPostBack="true"
                                    Height="300px">
                                </telerik:RadComboBox>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnModifyType" runat="server" CssClass="btn btn-success" UseSubmitBehavior="false" ToolTip="Set Selected Proposal Type" CausesValidation="false">
                                     Update
                                </asp:LinkButton>

                            </td>

                        </tr>
                        <tr>
                            <td style="text-align: right;">Change Assigned Job:
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboJobs" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceJob" AutoPostBack="true"
                                    DataTextField="Code" DataValueField="Id"
                                    Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Selected="True" Text="(Select Active Job...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnModifyJob" runat="server" CssClass="btn btn-success" Enabled="False" UseSubmitBehavior="false" ToolTip="Set Assigned Job" CausesValidation="false">
                                     Update
                                </asp:LinkButton>

                            </td>
                        </tr>
                    </table>
                    <div style="width: 100%; padding-left: 15px; padding-top: 5px">
                        <h4 style="margin: 0">Aditional Info</h4>
                    </div>
                    <table class="table-condensed" style="width: 100%;">
                        <tr>
                            <td style="text-align: right; width: 150px">Prepared by:</td>
                            <td style="width: 350px">
                                <telerik:RadTextBox ID="lblEmployeeName" runat="server" Width="100%" ReadOnly="true" Font-Bold="true" BackColor="#f1f1f1" />
                            </td>
                            <td></td>
                        </tr>

                        <tr>
                            <td style="text-align: right">Notification Date:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="lblEmailDate" runat="server" Width="100%" ReadOnly="true" Font-Bold="true" BackColor="#f1f1f1" />
                            </td>
                            <td></td>

                        </tr>
                        <tr>
                            <td style="text-align: right; vertical-align: top">Signed by:
                            </td>
                            <td style="text-align: center">
                                <telerik:RadBinaryImage ID="RadBinaryImageAceptanceSignature" runat="server" AlternateText="" BorderStyle="Solid" BorderWidth="1" BorderColor="LightGray"
                                    Width="120px" Height="90px" ResizeMode="Fit"></telerik:RadBinaryImage>
                                <br />
                                <asp:Label ID="lblAceptanceName" runat="server" CssClass="NormalNegrita" ToolTip="Acceptance"></asp:Label>
                            </td>
                            <td></td>

                        </tr>
                    </table>


                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>
    </div>


    <telerik:RadToolTip ID="RadToolTipDelete" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color:white; width: 500px">
            <span class="navbar bg-dark">Delete Proposal
            </span>
        </h2>
        <table class="table-condensed" style="width: 500px">
            <tr>
                <td>Are you sure you want to delete the active Proposal?
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="btnConfirmDelete" runat="server" CssClass="btn btn-danger" Width="125px" UseSubmitBehavior="false">
                             Delete Proposal
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancelDelete" runat="server" CssClass="btn btn-default" Width="125px" UseSubmitBehavior="false">
                             Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSourceProp1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_SIN_TC_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="PROPOSAL_v20_UPDATE" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:Parameter Name="ClientId" Type="Int32" />
            <asp:Parameter Name="ProjectType" Type="String" />
            <asp:Parameter Name="ProjectName" Type="String" />
            <asp:Parameter Name="ProjectLocation" Type="String" />
            <asp:Parameter Name="ProjectArea" Type="String" />
            <asp:Parameter Name="TextBegin" Type="String" />
            <asp:Parameter Name="TextEnd" Type="String" />
            <asp:Parameter Name="AceptedDate" Type="DateTime" />
            <asp:Parameter Name="JobId" Type="Int32" />
            <asp:Parameter Name="PaymentSchedule1" Type="Double" />
            <asp:Parameter Name="PaymentText1" Type="String" />
            <asp:Parameter Name="PaymentSchedule2" Type="Double" />
            <asp:Parameter Name="PaymentText2" Type="String" />
            <asp:Parameter Name="PaymentSchedule3" Type="Double" />
            <asp:Parameter Name="PaymentText3" Type="String" />
            <asp:Parameter Name="PaymentSchedule4" Type="Double" />
            <asp:Parameter Name="PaymentText4" Type="String" />
            <asp:Parameter Name="PaymentSchedule5" Type="Double" />
            <asp:Parameter Name="PaymentText5" Type="String" />
            <asp:Parameter Name="PaymentSchedule6" Type="Double" />
            <asp:Parameter Name="PaymentText6" Type="String" />
            <asp:Parameter Name="PaymentSchedule7" Type="Double" />
            <asp:Parameter Name="PaymentText7" Type="String" />
            <asp:Parameter Name="PaymentSchedule8" Type="Double" />
            <asp:Parameter Name="PaymentText8" Type="String" />
            <asp:Parameter Name="PaymentSchedule9" Type="Double" />
            <asp:Parameter Name="PaymentText9" Type="String" />
            <asp:Parameter Name="PaymentSchedule10" Type="Double" />
            <asp:Parameter Name="PaymentText10" Type="String" />
            <asp:Parameter Name="Link" Type="String" />
            <asp:Parameter Name="ProjectSector" Type="Int32" />
            <asp:Parameter Name="ProjectUse" Type="String" />
            <asp:Parameter Name="Owner" Type="String" />
            <asp:Parameter Name="DepartmentId" Type="Int32" />
            <asp:Parameter Name="Unit" Type="Double" />
            <asp:Parameter Name="Measure" Type="Int16" />
            <asp:Parameter Name="Deadline" Type="DateTime" />
            <asp:Parameter Name="Workdays" Type="Int16" />
            <asp:Parameter Name="Retainer" Type="Boolean" />
            <asp:Parameter Name="SharePublicLinks" Type="Boolean" />
            <asp:Parameter Name="ProjectManagerId" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="paymentscheduleId" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProposalDetails" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="PROPOSAL_details_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="PROPOSAL_details_SELECT" SelectCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="String" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProposaldDetailDuplicate" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="PROPOSAL_details_DUPLICATE" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="lblDetailSelectedId" Name="ProposaldetailsId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePropTC" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Agreements FROM Proposal WHERE (Id = @Id)"
        UpdateCommand="Proposal_TC_Ext_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Agreements" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJob" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_cboJobs_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="proposalId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePrint" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id] FROM [Proposal] WHERE ([Id] = @Id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTask" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [taskcode]+'. '+[Description] AS Description, [Hours], [Rates] FROM [Proposal_tasks] WHERE (companyId = @companyId) ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT 0 AS [Id], '(Not defined...)' AS Name  UNION ALL SELECT [Id], [Name]+' [' + isnull(Company,'...') + ']' As Name FROM [Clients] WHERE (companyId = @companyId) ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProjectType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT '' AS [Id], '(Not defined...)' AS Name  UNION ALL SELECT [Id], [Name] FROM [Jobs_types] WHERE (companyId = @companyId) ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Status] FROM [Proposal_status] ORDER BY [Status]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTandCtemplates" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM [Proposal_TandCtemplates] WHERE ([companyId] = @companyId) ORDER BY [Name]">
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
    <asp:SqlDataSource ID="SqlDataSourceProposalType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Proposal_types WHERE (companyId = @companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId"
                PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProjectSector" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_sectors ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProjectUse" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_uses ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceMeasure" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_measures ORDER BY Id"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePhases" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_phases_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="PROPOSAL_phases_DELETE" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="proposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePhasesSchedule" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], Task=(select count(*) from Proposal_details where Proposal_details.phaseId=Proposal_phases.Id), Code+' '+[Name] As Name, DateFrom, DateTo  FROM [Proposal_phases] WHERE proposalId=@proposalId ORDER BY [nOrder]"
        UpdateCommand="UPDATE Proposal_phases SET DateFrom=@DateFrom, DateTo=@DateTo WHERE Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="proposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="DateFrom" />
            <asp:Parameter Name="DateTo" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTaskSchedule" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_phaseTask_schedule_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE Proposal_details SET DateFrom=@DateFrom, DateTo=@DateTo WHERE Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblPhaseSelectedId" Name="phaseId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="DateFrom" />
            <asp:Parameter Name="DateTo" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePositions" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Employees_Position where companyId=@companyId Order By Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceAzureFiles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="ClientProsalJob_azureuploads_v20_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="ClientProsalJob_azureuploads_v20_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommand="ClientProsalJob_azureuploads_v20_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblClientId" Name="clientId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblProposalId" Name="proposalId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="JobId" DefaultValue="0" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Source" />
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" />
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="Public" DbType="Boolean" />
            <asp:Parameter Name="Source" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDocTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_azureuploads_types] ORDER BY [Id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE (companyId=@companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientBalance" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Client_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePS" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Proposal_PaymentSchedule_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Proposal_PS_v20_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="cboPaymentSchedules" Name="paymentscheduleId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblOriginalStatus" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblOriginalType" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblSelectedJobId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblPhaseSelectedId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblDetailSelectedId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblClientId" runat="server" Visible="false" Text="0"></asp:Label>
</asp:Content>




