<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterPROPOSAL.Master" CodeBehind="pro_proposal.aspx.vb" Inherits="pasconcept20.pro_proposal" %>

<%@ MasterType VirtualPath="~/adm/MasterPROPOSAL.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLuxW5zYQh_ClJfDEBpTLlT_tf8JVcxf0&libraries=places&callback=initAutocomplete"
            async defer></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.min.js"></script>
        <script>
            // Autocompletes all address inputs using google maps js api
            function initAutocomplete() {
                // Address Fields
                var addressInput = document.getElementsByClassName("input-address")[0];
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
                });
            }
        </script>
    </telerik:RadCodeBlock>
    <div class="pasconcept-bar">
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
                             Send to Client
            </asp:LinkButton>
            <asp:LinkButton ID="btnPdf" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="Proposal"
                ToolTip="Export PDF">
                             PDF
            </asp:LinkButton>
            <asp:LinkButton ID="btnTotals" runat="server" CssClass="btn btn-secondary" UseSubmitBehavior="false">
                       View Summary
            </asp:LinkButton>
            &nbsp;
            <asp:Panel runat="server" ID="panelViewProposalPage" Style="float: right; vertical-align: middle;">
                <a href='<%# LocalAPI.GetSharedLink_URL(111, lblProposalId.Text, False)%>' target="_blank" class="btn btn-primary">
                    <i class="far fa-share-square"></i>&nbsp;&nbsp;View Proposal
                </a>
            </asp:Panel>
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
                                        <asp:LinkButton ID="btnViewJob" runat="server" Visible='<%# Len(Eval("JobCode")) > 0 %>' CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false" CommandName="ViewJob" CommandArgument='<%# Eval("JobId")%>'
                                            ToolTip="View Job of Proposal" Text='<%#  Eval("JobCode")%>'></asp:LinkButton>
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



                        <td style="text-align: right">Quantity:
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



                        <td style="text-align: right">Units
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
                        <td style="text-align: right;">Proposal by:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboProjectManager" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceEmployee"
                                DataTextField="Name" DataValueField="Id" Height="400px"
                                SelectedValue='<%# Bind("ProjectManagerId")%>' Width="100%" MarkFirstMatch="True" Filter="Contains">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Not Defined...)" Value="0" />
                                </Items>
                            </telerik:RadComboBox>

                        </td>

                        <td style="text-align: right;">Prepared by:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboPreparedBy" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceEmployee"
                                DataTextField="Name" DataValueField="Id" Height="400px"
                                SelectedValue='<%# Bind("EmployeeAprovedId")%>' Width="350px" MarkFirstMatch="True" Filter="Contains">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Not Defined...)" Value="0" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>

                    </tr>

                    <tr>
                        <td style="text-align: right;">Retainer:
                        </td>
                        <td>
                            <telerik:RadCheckBox ID="chkRetainer" runat="server" Checked='<%# Bind("Retainer")%>'
                                Text="On acceptance, the first invoice will be emitted"
                                ToolTip="If selected, upon the clients acceptance of the proposal, the first invoice of the payment schedule will be sent to the client"
                                AutoPostBack="false">
                            </telerik:RadCheckBox>

                        </td>

                        <td style="text-align: right;">Share with Client:</td>
                        <td>
                            <telerik:RadCheckBox ID="chkSharePublicLinks" runat="server" Text="Public Upload Documents" Checked='<%# Bind("SharePublicLinks")%>'
                                ToolTip="Include file links in Proposal Acceptance" AutoPostBack="false">
                            </telerik:RadCheckBox>
                        </td>

                    </tr>

                    <tr>
                        <td style="text-align: right;"></td>
                        <td></td>
                        <td style="text-align: right;">Lump Sum:</td>
                        <td>
                            <telerik:RadCheckBox ID="chkLumpSum" runat="server" Text="Detail Totals" Checked='<%# Bind("LumpSum")%>'
                                ToolTip="Hide details Totals for Task in Client View" AutoPostBack="false">
                            </telerik:RadCheckBox>
                        </td>

                    </tr>

                </table>

                <div>

                    <asp:CompareValidator runat="server" ID="Comparevalidator7" SetFocusOnError="true" Text="*" Operator="NotEqual" Display="None"
                        ControlToValidate="cboProjectManager"
                        ErrorMessage="Proposal by is required"
                        ValueToCompare="(Not Defined...)"
                        ValidationGroup="Proposal">
                    </asp:CompareValidator>


                    <asp:CompareValidator runat="server" ID="Comparevalidator8" SetFocusOnError="true" Text="*" Operator="NotEqual"
                        ControlToValidate="cboProjectManager"
                        ErrorMessage="Prepared by is required"
                        ValueToCompare="(Not Defined...)"
                        ValidationGroup="Proposal">
                    </asp:CompareValidator>

                    <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Not Defined...)"
                        Operator="NotEqual" ControlToValidate="cboProjectManager" Text="*" ErrorMessage="<span><b>Proposal by</b> is required</span>" ValidationGroup="Proposal">
                    </asp:CompareValidator>

                    <asp:CompareValidator runat="server" ID="Comparevalidator9" ValueToCompare="(Not Defined...)"
                        Operator="NotEqual" ControlToValidate="cboPreparedBy" Text="*" ErrorMessage="<span><b>Prepared by</b> is required</span>" ValidationGroup="Proposal">
                    </asp:CompareValidator>
                </div>
            </EditItemTemplate>
        </asp:FormView>
    </div>

    <%--Task Compemsation--%>
    <table class="table-sm" style="width: 100%;">
        <tr>
            <td>
                <asp:LinkButton ID="btnNewTask" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ValidationGroup="ProposalDetail">
                                   Add Task
                </asp:LinkButton>

            </td>
        </tr>
        <tr>
            <td style="padding-top: 10px; padding-bottom: 10px">
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticDeletes="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceProposalDetails"
                    CellSpacing="0" ValidationGroup="ProposalDetail" HeaderStyle-HorizontalAlign="Center"
                    ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceProposalDetails" ShowFooter="true" CommandItemDisplay="None">
                        <BatchEditingSettings EditType="Cell" />
                        <Columns>
                            <telerik:GridBoundColumn DataField="Id" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id" Display="False">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="phaseId" HeaderText="Phase" SortExpression="PhaseCode" UniqueName="phaseId" HeaderStyle-Width="80px">
                                <ItemTemplate>
                                    <asp:Label ID="lblphaseId" runat="server" Text='<%# Eval("PhaseCode") %>' ToolTip='<%# Eval("PhaseName") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="positionId" Display="false" HeaderText="Position" SortExpression="positionCode" UniqueName="positionId" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblpositionId" runat="server" Text='<%# Eval("Position") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="taskcode" HeaderText="Task" ReadOnly="True" SortExpression="taskcode"
                                UniqueName="taskcode" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDetailId" runat="server" CommandName="EditTask" CommandArgument='<%# Eval("Id") %>' ValidationGroup="ProposalDetail" UseSubmitBehavior="false"
                                        Text='<%# Eval("taskcode")%>' ToolTip="Click to Edit detail"></asp:LinkButton>
                                    &nbsp;
                                                        <asp:LinkButton ID="btnOrderDown" runat="server" CommandName="OrderDown" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
                                                            ToolTip="Click to Order Down">
                                                                <i class="fas fa-arrow-down"></i>
                                                        </asp:LinkButton>
                                    &nbsp;
                                                        <asp:LinkButton ID="btnOrderUp" runat="server" CommandName="OrderUp" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
                                                            ToolTip="Click to Order Up">
                                                                <i class="fas fa-arrow-up"></i>
                                                        </asp:LinkButton>
                                    &nbsp;
                                                    <asp:LinkButton ID="btnDuplicate" runat="server" CommandName="DetailDuplicate" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false"
                                                        ToolTip="Click to duplicate record">
                                                    <i class="far fa-clone"></i>
                                                    </asp:LinkButton>

                                </ItemTemplate>

                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                                HeaderText="Name" SortExpression="Description" UniqueName="Description" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnklblDescrip" runat="server" CommandName="EditTask" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false"
                                        Text='<%# Eval("Description")%>' ToolTip="Click to Edit detail"></asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Amount" DataType="System.Double" HeaderText="Qty"
                                SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount", "{0:N4}") %>'></asp:Label>
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
    <%--RadToolTips Dialogs--%>
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


    <%--SQLDataSources--%>
    <asp:SqlDataSource ID="SqlDataSourceClientBalance" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Client_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProp1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_SIN_TC_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="PROPOSAL_v21_UPDATE" UpdateCommandType="StoredProcedure">
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
            <asp:Parameter Name="EmployeeAprovedId" Type="Int32" />
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
    <asp:SqlDataSource ID="SqlDataSourceDocTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_azureuploads_types] ORDER BY [Id]"></asp:SqlDataSource>

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
    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE (companyId=@companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProposaldDetailDuplicate" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="PROPOSAL_details_DUPLICATE" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="lblDetailSelectedId" Name="ProposaldetailsId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblOriginalStatus" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblClientId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblDetailSelectedId" runat="server" Visible="false"></asp:Label>
</asp:Content>
