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

            .card-body {
                padding: 0.25rem;
            }

            .card-header {
                padding: 0 .50rem;
            }

            img {
                max-height: 96px;
                max-width: 200px;
                height: auto;
                width: auto;
            }

            .fileUploadRad {
                position: absolute;
                margin-top: 80px;
                width: 100%;
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





    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
            </asp:LinkButton>
            Proposal
        </span>


        <span style="float: right; vertical-align: middle;">
            <asp:LinkButton ID="btnUpdate1" runat="server" CssClass="btn btn-success" ValidationGroup="Proposal" UseSubmitBehavior="false" ToolTip="Update Proposal">
                             Update
            </asp:LinkButton>
            <asp:LinkButton ID="btnDeleteProposal" runat="server" CssClass="btn btn-danger" UseSubmitBehavior="false" ToolTip="Delete" CausesValidation="false">
                             Delete
            </asp:LinkButton>
            <asp:LinkButton ID="btnSaveAs" runat="server" CssClass="btn btn-secondary" UseSubmitBehavior="false" ToolTip="Save Proposal As New Propsal"
                CausesValidation="true" ValidationGroup="Proposal">
                             Save As
            </asp:LinkButton>
            <asp:LinkButton ID="btnSaveAsTemplate" runat="server" CssClass="btn btn-secondary" UseSubmitBehavior="false" ToolTip="Save Proposal As Proposal Template "
                CausesValidation="true" ValidationGroup="Proposal">
                             Save Template
            </asp:LinkButton>
            <asp:LinkButton ID="btnPrintProposal" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="Proposal"
                ToolTip="Print/Send Email with Proposal Information">
                             View/Send
            </asp:LinkButton>
            <asp:LinkButton ID="btnPdf" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="Proposal"
                ToolTip="Export PDF">
                             Export PDF
            </asp:LinkButton>
            <asp:LinkButton ID="btnTotals" runat="server" CssClass="btn btn-secondary" UseSubmitBehavior="false">
                       View Summary
            </asp:LinkButton>
        </span>
    </div>
    <div id="collapseTotals">
        <asp:FormView ID="FormViewClientBalance" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceClientBalance" Width="100%" Visible="false">
            <ItemTemplate>
                <table class="table-sm" style="width: 100%">
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
                            <span class="DashboardFont2">Accepted Props.</span><br />
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

    <div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server"
            Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="Proposal" ForeColor="Red" />

    </div>
    <div class="pas-container" style="width: 100%">

        <asp:FormView ID="FormViewProp1" runat="server" DataKeyNames="Id" DefaultMode="Edit" DataSourceID="SqlDataSourceProp1" Width="100%" EnableViewState="false">
            <EditItemTemplate>

                <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="false" Height="580px" DisplayProgressBar="false" DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Silk">
                    <WizardSteps>
                        <%--Proposal Details--%>
                        <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Proposal Details" StepType="Step">
                            <table class="table-sm" style="width: 100%;">

                                <tr>
                                    <td style="text-align: right; width: 180px">Number:
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
                                    <td>
                                        <telerik:RadCheckBox ID="chkRetainer" runat="server" Checked='<%# Bind("Retainer")%>'
                                            Text="On acceptance, the first invoice will be emitted"
                                            ToolTip="If selected, upon the clients acceptance of the proposal, the first invoice of the payment schedule will be sent to the client"
                                            AutoPostBack="false">
                                        </telerik:RadCheckBox>

                                    </td>
                                    <td style="text-align: right;">Lump Sum:</td>
                                    <td>
                                        <telerik:RadCheckBox ID="chkLumpSum" runat="server" Text="Detail Totals" Checked='<%# Bind("LumpSum")%>'
                                            ToolTip="Hide details Totals for Task in Client View" AutoPostBack="false">
                                        </telerik:RadCheckBox>
                                    </td>

                                </tr>

                            </table>
                        </telerik:RadWizardStep>

                        <%--Payment Schedules--%>
                        <telerik:RadWizardStep runat="server" ID="RadWizardStepPaymentSchedules" Title="Payment Schedules" StepType="Step">
                            <table class="table-sm" style="width: 100%;">
                                <tr>
                                    <td style="text-align: right; width: 15px"></td>
                                    <td style="width: 400px">
                                        <telerik:RadComboBox ID="cboPaymentSchedules" runat="server" DataSourceID="SqlDataSourcePaymentSchedules" SelectedValue='<%# Bind("paymentscheduleId")%>'
                                            DataTextField="Name" DataValueField="Id" Width="400px" MarkFirstMatch="True" AppendDataBoundItems="true"
                                            Filter="Contains"
                                            ToolTip="Select Payment Schedules to define first time or modify the current"
                                            >
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Select other Payment Schedules...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="btnGeneratePaymentSchedules" runat="server" CssClass="btn btn-success" UseSubmitBehavior="false"
                                            ToolTip="Define Payment Schedules"
                                            CausesValidation="false" CommandName="Update" OnClick="btnGeneratePaymentSchedules_Click"
                                           >
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

                            <table class="table-sm" style="width: 100%">
                                <tr style="text-align: right">
                                <td>Totals:
                                </td>
                                <td>
                                    <table style="width: 400px">
                                        <tr>
                                            <td style="text-align: center; width: 50%">Proposal Total
                                            </td>
                                            <td style="text-align: center;">Payment Schedule Total
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center">
                                                <asp:Label ID="lblProposalTotal" runat="server"></asp:Label>
                                            </td>
                                            <td style="text-align: center">
                                                <asp:Label ID="lblScheduleTotal" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="text-align: center">
                                                <asp:Label ID="lblTotalAlert" runat="server" ForeColor="Red"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                         </table>

                        </telerik:RadWizardStep>

                        <%--Begin and Concluding Text--%>
                        <telerik:RadWizardStep runat="server" ID="RadWizardStep3" Title="Begin and Concluding Text" StepType="Step">
                            <table class="table-sm" style="width: 100%;">
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

                    </WizardSteps>
                </telerik:RadWizard>

            </EditItemTemplate>
        </asp:FormView>
    </div>

    <div class="pas-container" style="width: 100%">
        <telerik:RadWizard ID="RadWizard2" runat="server" DisplayCancelButton="false" DisplayProgressBar="false" DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Silk">
            <WizardSteps>
                <%--Task Compemsation--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep21" Title="Task Compensation" StepType="Step">
                    <table class="table-sm" style="width: 100%;">
                        <tr>
                            <td>
                                <asp:LinkButton ID="btnNewTask" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ValidationGroup="ProposalDetail">
                                   Add Fee
                                </asp:LinkButton>

                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 10px; padding-bottom: 10px">
                                <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticDeletes="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceProposalDetails"
                                    CellSpacing="0" ValidationGroup="ProposalDetail" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceProposalDetails" ShowFooter="true" CommandItemDisplay="None">
                                        <BatchEditingSettings EditType="Cell" />
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="Id" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id" Display="False">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="phaseId" FilterControlAltText="Filter PhaseCode column"
                                                HeaderText="Phase" SortExpression="PhaseCode" UniqueName="phaseId" HeaderStyle-Width="80px">
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
                                                HeaderText="Position" SortExpression="positionCode" UniqueName="positionId" HeaderStyle-Width="100px">
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
                                                UniqueName="taskcode" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkDetailId" runat="server" CommandName="EditTask" CommandArgument='<%# Eval("Id") %>' ValidationGroup="ProposalDetail" UseSubmitBehavior="false"
                                                        Text='<%# Eval("taskcode")%>' ToolTip="Click to Edit detail"></asp:LinkButton>

                                                    <asp:LinkButton ID="btnDuplicate" runat="server" CommandName="DetailDuplicate" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false"
                                                        ToolTip="Click to duplicate record">
                                                    <i class="far fa-clone"></i>
                                                    </asp:LinkButton>

                                                </ItemTemplate>

                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                                                HeaderText="Name" SortExpression="Description" UniqueName="Description" ItemStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescrip" runat="server" Text='<%# Eval("Description") %>' ToolTip='<%# Eval("DescriptionPlus") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Amount" DataType="System.Double" HeaderText="Qty"
                                                SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount", "{0:N2}") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Hours" DataType="System.Double" HeaderText="Hours"
                                                SortExpression="Hours" UniqueName="Hours" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblHours" runat="server" Text='<%# Eval("Hours", "{0:N2}") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Rates" DataType="System.Double" HeaderText="Rates"
                                                SortExpression="Rates" UniqueName="Rates" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRates" runat="server" Text='<%# Eval("Rates", "{0:N2}")%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn DataField="BillType" HeaderText="Bill Type" SortExpression="BillType" UniqueName="BillType" HeaderStyle-Width="180px">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Estimator" HeaderText="Estimated" ReadOnly="True"
                                                SortExpression="Estimator" DataFormatString="{0:N2}" UniqueName="Estimated" Aggregate="Sum"
                                                FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right"
                                                FooterStyle-HorizontalAlign="Right">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TotalRow" HeaderText="Total" ReadOnly="True"
                                                SortExpression="TotalRow" DataFormatString="{0:N2}" UniqueName="TotalRow" Aggregate="Sum"
                                                FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right"
                                                FooterStyle-HorizontalAlign="Right">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="Paymentschedule" FilterControlAltText="Filter Paymentschedule column" ItemStyle-HorizontalAlign="Center"
                                                    HeaderText="Payment Shedule" SortExpression="Paymentschedule" UniqueName="Paymentschedule" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <%# Eval("Paymentschedule") %>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?"
                                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                                UniqueName="DeleteColumn" HeaderText=""
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
                 <%--Documents--%>
                        <telerik:RadWizardStep runat="server" ID="RadWizardStep4" Title="Documents" StepType="Step">
                             <div class="pas-container" style="width: 100%">
                            <asp:Panel ID="PanelUpload" runat="server">
                                            <table onclick="table-sm pasconcept-bar noprint" width="100%">
                                                <tr>
                                                    <td style="width: 550px; text-align: right">
                                                        <asp:LinkButton ID="btnListFiles" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnListFiles_Click">
                                                               <i class="fas fa-align-justify"></i>&nbsp;&nbsp;View Files
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                        <telerik:RadWizard ID="RadWizardFiles" runat="server" DisplayCancelButton="false" DisplayProgressBar="false" 
                            DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Silk" DisplayNavigationBar="false">
                            <WizardSteps>
                                <%--Upload Files--%>
                                <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Upload Files" StepType="Step">
                                    <asp:Panel ID="UploadPanel" runat="server">
                                        <div style="width: 100%; height: 500px; position: relative">
                                            <table class="table-sm" style="width: 100%; position: absolute; margin-top: 0px; background-color: lightgray;">
                                                <tr>
                                                    <td style="width: 40%;">
                                                        <telerik:RadComboBox ID="cboDocType" runat="server" DataSourceID="SqlDataSourceDocTypes" Label="File type:" DataTextField="Name" DataValueField="Id" Width="100%">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td style="width: 30%;">
                                                        <telerik:RadCheckBox ID="chkPublic" runat="server" Text="Public" ToolTip="Public or private" AutoPostBack="false"></telerik:RadCheckBox>
                                                    </td>
                                                    <td style="width: 30%;" rowspan="2">
                                                        <asp:LinkButton ID="btnSaveUpload" runat="server" CssClass="btn btn-success btn float-right" UseSubmitBehavior="false" ToolTip="Upload and Save selected files">
                                                    <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp;Upload
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table style="width: 100%; position: absolute; margin-top: 40px; background-color: lightgray; height: 100px;">
                                                <tr>
                                                    <td style="width: 90%; vertical-align: top;">
                                                        <h3 class="additional-text">Select Files to Upload</h3>
                                                    </td>
                                                </tr>
                                            </table>
                                            <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" RenderMode="Lightweight" MultipleFileSelection="Automatic" OnFileUploaded="RadCloudUpload1_FileUploaded"
                                                ProviderType="Azure" MaxFileSize="1048576" CssClass="h-100 fileUploadRad">
                                            </telerik:RadCloudUpload>
                                        </div>
                                    </asp:Panel>
                                </telerik:RadWizardStep>

                                <%--Files--%>
                                <telerik:RadWizardStep runat="server" ID="RadWizardStep5" Title="Files" StepType="Step">
                                    <div>
                                        <asp:Panel ID="pnlFind" runat="server">
                                            <table onclick="table-sm pasconcept-bar noprint" width="100%">
                                                <tr>
                                                    <td style="width: 550px; text-align: right">
                                                        <asp:LinkButton ID="btnTablePage" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnTablePage_Click">
                                                               <i class="fas fa-align-justify"></i> Table
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnGridPage" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnTablePage_Click" Visible="false">
                                                               <i class="fas fa-th"></i> Grid
                                                        </asp:LinkButton>                                                        
                                                        <asp:LinkButton ID="btnUploadFiles" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" OnClick="btnUploadFiles_Click">
                                                               <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp; Uploads
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnBulkDelete" runat="server"
                                                            CssClass="btn btn-danger" UseSubmitBehavior="false">
                                                               <i class="fas fa-trash"></i>&nbsp;Bulk Delete
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnBulkEdit" runat="server"
                                                            CssClass="btn btn-primary" UseSubmitBehavior="false">
                                                               <i class="fas fa-pencil-alt"></i>&nbsp; Bulk Update
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>

                                        <telerik:RadListView ID="RadListViewFiles" runat="server" DataSourceID="SqlDataSourceAzureFiles" DataKeyNames="Id" ItemPlaceholderID="Container1" BorderStyle="Solid" AllowMultiItemSelection="true">
                                            <LayoutTemplate>
                                                <fieldset style="width: 100%; text-align: center">
                                                    <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                                                </fieldset>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <div class="card" style="float: left; width: 230px; margin: 2px">
                                                    <div class="card-header">
                                                        <asp:LinkButton ID="LinkButton1" CssClass="selectedButtons" runat="server" CommandName="Select">
                                                                <i class="far fa-square" aria-hidden="true" style="float: left;margin-top: 10px;color: black;"></i>
                                                        </asp:LinkButton>

                                                        <b style="display: inline-block; height: 22px; overflow: hidden; margin-top: 5px; width: 80%;" title="<%# Eval("Name")%> "> <%# LocalAPI.TruncateString(Eval("Name"), 20)%> </b>

                                                        <asp:LinkButton ID="LinkButton2" CssClass="selectedButtons" runat="server" CommandName="Update">
                                                            <i class="far fa-edit" aria-hidden="true" style="float: right;margin-top: 10px;color: black;"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div class="card-body" style="padding:0px;margin-top:-6px;">
                                                        <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                                                                <table style="width: 100%; flex-wrap: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                                                    <tr>
                                                                        <td style="height:108px;padding:0px;">
                                                                            <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"), 96)%>
                                                                        </td>
                                                                    </tr>                                
                                                                    <tr>
                                                                        <td style="font-size:12px; padding-top:5px;padding-bottom: 0px;">
                                                                           <%# FormatSource(Eval("Source"))%>:&nbsp <%# Eval("Document")%>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="font-size:12px;padding: 0;">
                                                                             <%# Eval("Date", "{0:d}")%>,&nbsp;&nbsp;
                                                                             <%#  LocalAPI.FormatByteSize(Eval("ContentBytes"))%>
                                                                        </td>
                                                                    </tr>                                 
                                                                    <tr>
                                                                        <td style="font-size:12px;padding: 0;">
                                                                           Type:   <%# Eval("nType")%>
                                                                        </td>
                                                                    </tr> 
                                                                    <tr>
                                                                        <td style="font-size:12px;padding: 0;">
                                                                         <%#IIf(Eval("Public"), "Public", "Private") %>
                                                            
                                                                        <asp:Label ID="lblPubicHide" runat="server" Visible="False" Text='<%# Eval("Public") %>'></asp:Label>                                                            
                                                                        <asp:Label ID="lblTypeHide" runat="server" Visible="False"  Text='<%# Eval("Type") %>'></asp:Label>                                                           
                                                                        <asp:Label ID="lblNameHide" runat="server" Visible="False"  Text='<%# Eval("Name") %>'></asp:Label>
                                                                        </td>
                                                                    </tr>
                               
                                                                </table>
                                                        </asp:LinkButton>

                                                    </div>
                                                </div>

                                            </ItemTemplate>
                                            <SelectedItemTemplate>
                                                <div class="card" style="float: left; width: 230px; margin: 2px">
                                                    <div class="card-header">
                                                        <asp:LinkButton ID="LinkButton1" CssClass="selectedButtons" runat="server" CommandName="Deselect">
                                                            <i class="fa fa-check-square" aria-hidden="true" style="float: left;margin-top: 10px;color: black;"></i>
                                                        </asp:LinkButton>

                                                        <b style="display: inline-block; height: 22px; overflow: hidden; margin-top: 5px; width: 80%;" title="<%# Eval("Name")%> "> <%# LocalAPI.TruncateString(Eval("Name"), 20)%> </b>

                                                        <asp:LinkButton ID="LinkButton2" CssClass="selectedButtons" runat="server" CommandName="Update">
                                                            <i class="far fa-edit" aria-hidden="true" style="float: right;margin-top: 10px;color: black;"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div class="card-body" style="padding:0px;margin-top:-6px;">
                                                        <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                                                            <table style="width: 100%; flex-wrap: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                                                <tr>
                                                                    <td style="height: 108px;padding:0px;">
                                                                        <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"), 96)%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding-top: 5px; padding-bottom: 0px;">
                                                                        <asp:Label ID="lblFileName" runat="server" Visible="False" Text='<%# Bind("Name") %>'></asp:Label>
                                                                        <%# FormatSource(Eval("Source"))%>:&nbsp <%# Eval("Document")%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">
                                                                        <%# Eval("Date", "{0:d}")%>,&nbsp;&nbsp;
                                                                         <%#  LocalAPI.FormatByteSize(Eval("ContentBytes"))%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">Type:   <%# Eval("nType")%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">
                                                                        <%#IIf(Eval("Public"), "Public", "Private") %>
                                                            
                                                                        <asp:Label ID="lblPubicHide" runat="server" Visible="False" Text='<%# Eval("Type") %>'></asp:Label>                                                            
                                                                        <asp:Label ID="lblTypeHide" runat="server" Visible="False"  Text='<%# Eval("Name") %>'></asp:Label>                                                           
                                                                        <asp:Label ID="lblNameHide" runat="server" Visible="False"  Text='<%# Eval("Name") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:LinkButton>

                                                    </div>
                                                </div>
                                            </SelectedItemTemplate>
                                        </telerik:RadListView>

                                        <telerik:RadGrid ID="RadGridFiles" runat="server" DataSourceID="SqlDataSourceAzureFiles" GridLines="None" Visible="false"
                                            AllowPaging="True" PageSize="25" AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center" OnItemCommand="RadGridFiles_ItemCommand" AllowMultiRowSelection="true">
                                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceAzureFiles"
                                                HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                                                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                                <Columns>
                                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                                    </telerik:GridClientSelectColumn>
                                                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" HeaderStyle-Width="40px">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn DataField="Name" HeaderText="FileName" UniqueName="Name" SortExpression="Name" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-Width="300px" HeaderStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"), 16)%>
                                                            &nbsp;&nbsp;
                                                            <%# Eval("Name")%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="Type" HeaderText="Type" UniqueName="Type" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <%# Eval("nType")%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridCheckBoxColumn DataField="Public" HeaderText="Public" UniqueName="Public" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center">
                                                    </telerik:GridCheckBoxColumn>

                                                    <telerik:GridTemplateColumn DataField="Source" HeaderText="Source" UniqueName="Source" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <%# FormatSource(Eval("Source"))%>:&nbsp <%# Eval("Document")%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="Size" HeaderText="Size" UniqueName="Size" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <%#  LocalAPI.FormatByteSize(Eval("ContentBytes"))%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="Date" HeaderText="Date" UniqueName="Date" SortExpression="Date" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count">
                                                        <ItemTemplate>
                                                            <%# Eval("Date", "{0:d}")%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                                                        <ItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Update" CommandArgument='<%# Eval("Id") %>' ToolTip="Edit">
                                                                            <span class="fas fa-edit"></span>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                    <td>&nbsp;&nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("Id") %>' ToolTip="Edit">
                                                                            <span class="fas fa-trash"></span>
                                                                        </asp:LinkButton>
                                                                        <asp:Label ID="lblPubicHide" runat="server" Visible="False" Text='<%# Eval("Public") %>'></asp:Label>                                                            
                                                                        <asp:Label ID="lblTypeHide" runat="server" Visible="False"  Text='<%# Eval("Type") %>'></asp:Label>                                                           
                                                                        <asp:Label ID="lblNameHide" runat="server" Visible="False"  Text='<%# Eval("Name") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>

                                            </MasterTableView>

                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true" />
                                            </ClientSettings>
                                        </telerik:RadGrid>

                                    </div>
                                </telerik:RadWizardStep>
                            </WizardSteps>
                        </telerik:RadWizard>
                    </div> 
                        </telerik:RadWizardStep>
                <%--Phases--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep22" Title="Phases" StepType="Step">
                    <div style="width: 100%; padding-left: 18px; padding-top: 12px">
                        <asp:LinkButton ID="btnNewPhase" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Add Phase">
                                   <i class="fas fa-plus"></i> Phase
                        </asp:LinkButton>

                        &nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btnPivotPhases" runat="server" CssClass="btn btn-secondary" UseSubmitBehavior="false" ToolTip="Add Phase">
                                   <i class="fas fa-plus"></i> Project Phases
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
                <%--Schedule--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep23" Title="Schedule" StepType="Step">
                    <div style="width: 100%; padding-left: 18px; padding-top: 12px">
                        <asp:LinkButton ID="btnSchedule" runat="server" CssClass="btn btn-secondary" UseSubmitBehavior="false">
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
                                        <table class="table-sm" style="width: 100%;">
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
                                                <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary" CommandName="Cancel" CausesValidation="False">
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
                <%--Term & Conditions--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep24" Title="Term & Conditions" StepType="Step">
                    <table class="table-sm" style="width: 100%;">
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
                                        <table class="table-sm" style="width: 100%;">
                                            <tr>
                                                <td colspan="2">
                                                    <table class="table-sm" style="width: 100%;">
                                                        <tr>
                                                            <td colspan="3" class="Pequena">To modify T&C, you can select a template from the dropdown menu. You can also modify the text manually or copy and paste from the clipboard. Press Update to save chances</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 300px">
                                                                <telerik:RadComboBox ID="cboTandCtemplates" runat="server" DataSourceID="SqlDataSourceTandCtemplates" AutoPostBack="true" OnSelectedIndexChanged="cboTandCtemplates_SelectedIndexChanged"
                                                                    DataTextField="Name" DataValueField="Id" Width="100%" Height="200px" AppendDataBoundItems="true" ToolTip="To modify the current, select T&C template">
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem runat="server" Text="(Select other T&C Template...)" Value="-1" />
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                            </td>
                                                            <td style="width: 400px">

                                                                <asp:LinkButton ID="btnUpdateTandCTemplate" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" CommandName="Update">
                                                                    <i class="fas fa-check"></i>&nbsp;&nbsp;Update
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="btnCloseTC" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false" CommandName="Cancel">
                                                                    Cancel
                                                                </asp:LinkButton>

                                                                <%--  <asp:LinkButton ID="btnUpdateTandCTemplate" runat="server" CommandName="UpdateTandC" CssClass="btn btn-success" UseSubmitBehavior="false" CausesValidation="false">
                                                                Apply
                                                                </asp:LinkButton>

                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btnUpdateTyC" runat="server" CommandName="Update" CssClass="btn btn-success" UseSubmitBehavior="false" CausesValidation="false">
                                                                Update
                                                                </asp:LinkButton>
                                                                &nbsp;
                                                            <asp:LinkButton ID="btnCancelTyC" runat="server" CommandName="Cancel" CssClass="btn btn-secondary" UseSubmitBehavior="false" CausesValidation="false">
                                                                Cancel
                                                            </asp:LinkButton>--%>

                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td colspan="2">
                                                    <telerik:RadEditor ID="radEditor_TandC" runat="server" Content='<%# Bind("Agreements") %>'
                                                        Height="600px" ToolsFile="~/BasicTools.xml" AllowScripts="True" EditModes="Design,Preview" RenderMode="Auto"
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
                <%--Astions--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep25" Title="Actions" StepType="Step">
                    <div style="width: 100%; padding-left: 15px; padding-top: 5px">
                        <h4 style="margin: 0">Other Actions</h4>
                    </div>
                    <table class="table-sm" style="width: 100%;">
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
                    <table class="table-sm" style="width: 100%;">
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
        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Delete Proposal
            </span>
        </h2>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td>Are you sure you want to delete the active Proposal?
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="btnConfirmDelete" runat="server" CssClass="btn btn-danger" Width="150px" UseSubmitBehavior="false">
                             Delete Proposal
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancelDelete" runat="server" CssClass="btn btn-secondary" Width="150px" UseSubmitBehavior="false">
                             Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    
    <telerik:RadToolTip ID="RadToolTipBulkEdit" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table table-bordered" style="width: 500px">
            <tr>
                <td colspan="2">
                    <h3 style="margin: 0; text-align: center; color: white; width: 600px">
                        <span class="navbar navbar-expand-md bg-dark text-white">Update Files</span>
                    </h3>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    <telerik:RadComboBox ID="cboDocTypeBulk" runat="server" DataSourceID="SqlDataSourceDocTypes" ZIndex="10000" Label="File type:" DataTextField="Name" DataValueField="Id" Width="100%">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    <telerik:RadCheckBox ID="chkPublicBulk" runat="server" Text="Public" ToolTip="Public or private" AutoPostBack="false"></telerik:RadCheckBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnUpdateStatusFiles" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="120px" ValidationGroup="Reconcile">
                                    <i class="fas fa-check"></i> Update
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCance" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="120px">
                                     Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipBulkDelete" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h3 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Delete Files
            </span>
        </h3>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td>Are you sure you want to delete selected Files?
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="btnConfirmDeleteFiles" runat="server" CssClass="btn btn-danger" Width="150px" UseSubmitBehavior="false">
                             Delete 
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancelDeleteFiles" runat="server" CssClass="btn btn-secondary" Width="150px" UseSubmitBehavior="false">
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
            <asp:Parameter Name="LumpSum" Type="Boolean" />
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
            <asp:Parameter Name="clientId" DefaultValue="0" />
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
            <asp:ControlParameter ControlID="lblPaymentSchedules" Name="paymentscheduleId" PropertyName="Text" Type="Int32"  />
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <telerik:RadButton ID="btnDataProcecing" runat="server" Text="Processing" OnClientClicked="DataProcessing" AutoPostBack="false" UseSubmitBehavior="false" CausesValidation="false" Width="120px" Visible="false">
        <Icon PrimaryIconCssClass="rbRefresh"></Icon>
    </telerik:RadButton>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblOriginalStatus" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblOriginalType" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblSelectedJobId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblPhaseSelectedId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblDetailSelectedId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblClientId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblPaymentSchedules" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblSelectedId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedName" runat="server" Visible="False"></asp:Label>

</asp:Content>




