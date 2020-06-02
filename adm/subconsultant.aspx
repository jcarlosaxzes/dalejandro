<%@ Page Title="Subconsultant" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="subconsultant.aspx.vb" Inherits="pasconcept20.subconsultant" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="Formulario">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="width: 80px">
                    <asp:LinkButton ID="btnTotals" runat="server" CssClass="btn btn-danger" UseSubmitBehavior="false">
                       $ Dashboard
                    </asp:LinkButton>
                </td>
                <td style="width: 120px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
                    </asp:LinkButton>
                </td>
                <td></td>
            </tr>
        </table>
        <div id="collapseTotals">
            <div class="card card-body">
                <asp:FormView ID="FormViewSubconsultBalance" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceSubconsultantBalance" Width="100%">
                    <ItemTemplate>
                        <table class="table-condensed" style="width: 100%">
                            <tr>
                                <td colspan="7">
                                    <hr style="margin: 0" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="7" style="text-align: center">
                                    <h2 style="margin: 0"><%# Eval("SubconsultanName")%>, <%# Eval("SubconsultanCompany") %></h2>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 23%; text-align: center; background-color: #039be5">
                                    <span class="DashboardFont2">RFP Pending:</span><br />
                                    <asp:Label ID="lblTotalBudget" CssClass="DashboardFont1" runat="server" Text='<%# Eval("NumberPendingRFP", "{0:N0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 23%; text-align: center; background-color: #546e7a">
                                    <span class="DashboardFont2">RFP Accepted</span><br />
                                    <asp:Label ID="lblTotalBilled" runat="server" CssClass="DashboardFont1" Text='<%# Eval("AmountAcceptedTotal", "{0:C0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 23%; text-align: center; background-color: #43a047">
                                    <span class="DashboardFont2">Amount Paid</span><br />
                                    <asp:Label ID="lblTotalPending" runat="server" CssClass="DashboardFont1" Text='<%# Eval("AmountPaid", "{0:C0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 23%; text-align: center; background-color: #e53935">
                                    <span class="DashboardFont2">Balance</span><br />
                                    <asp:Label ID="LabelblTotalBalance" runat="server" CssClass="DashboardFont1" Text='<%# Eval("Balance", "{0:C0}") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>

            </div>
        </div>
    </div>
    <div class="pas-container">
        <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="false" RenderMode="Lightweight" Skin="Material" DisplayNavigationButtons="false" DisplayProgressBar="false">
            <WizardSteps>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Subconsultant Details" StepType="Step">
                    <div style="padding-left: 10px">
                        <asp:Label ID="lblStatus" runat="server" Style="font-size: 10pt; color: forestgreen; font-family: Calibri, Verdana"></asp:Label>
                    </div>

                    <div>
                        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%" DefaultMode="Edit">
                            <EditItemTemplate>
                                <div style="text-align:center">
                                    <asp:LinkButton ID="btnUpdateSubconsultant1" runat="server" CommandName="Update" CausesValidation="True" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false">
                                        <span class="glyphicon glyphicon-save"></span> Update
                                    </asp:LinkButton>

                                </div>
                                    <table class="table-condensed" style="width: 100%">
                                        <tr>
                                            <td style="text-align:right;width: 200px">Name:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtSubconsultantName" runat="server" Text='<%# Bind("Name") %>' MaxLength="80"
                                                    Width="90%" EmptyMessage="Required">
                                                </telerik:RadTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSubconsultantName"
                                                    ErrorMessage="(*) Name is Required" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >Email:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' MaxLength="128" Width="90%" EmptyMessage="Required">
                                                </telerik:RadTextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtEmail"
                                                    runat="server" ErrorMessage="(*) Enter an valid email address" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                    Display="Dynamic"></asp:RegularExpressionValidator>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail"
                                                    ErrorMessage="(*) Email is Required" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >Position:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox3" runat="server" Text='<%# Bind("Position") %>'
                                                    MaxLength="80" Width="90%">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >Organization:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox4" runat="server" Text='<%# Bind("Organization")%>'
                                                    MaxLength="80" Width="90%">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >Discipline:
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="cboDiscipline" runat="server" ReadOnly="True" DataSourceID="SqlDataSourceDiscipline"
                                                    DataTextField="Name" DataValueField="Id" Width="90%" SelectedValue='<%# Bind("disciplineId") %>' AppendDataBoundItems="true">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="(Select discipline...)" Value="0" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td style="text-align: right"><a href="https://www.census.gov/eos/www/naics/" target="_blank">NAICS</a> US Code:
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="cboNAICS" runat="server" DataSourceID="SqlDataSourceNAICS"
                                                    DataTextField="CodeAndTitle" DataValueField="Code" Width="90%" SelectedValue='<%# Bind("NAICS_code") %>'
                                                    AppendDataBoundItems="true" MarkFirstMatch="True" Filter="Contains">
                                                    <Items>
                                                        <telerik:RadComboBoxItem runat="server" Text="(NAICS Code Not Defined...)" Value="0" />
                                                    </Items>
                                                </telerik:RadComboBox>

                                            </td>
                                        </tr>

                                        <tr>
                                            <td style="text-align:right" >Address Line 1:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtAddress" runat="server" Text='<%# Bind("Address") %>'
                                                    MaxLength="80" Width="90%">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >Address Line 2:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtAddress2" runat="server" Text='<%# Bind("Address2") %>'
                                                    MaxLength="80" Width="90%">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >City:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtCity" runat="server" Text='<%# Bind("City") %>' MaxLength="50"
                                                    Width="300px">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >State:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtState" runat="server" Text='<%# Bind("State") %>'
                                                    MaxLength="50" Width="300px">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >Zip Code:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtZipCode" runat="server" Text='<%# Bind("ZipCode") %>'
                                                    MaxLength="50">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >Telephone:
                                            </td>
                                            <td>
                                                <telerik:RadMaskedTextBox ID="RadMaskedTextBox1" runat="server" Text='<%# Bind("Telephone")%>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >Cell Phone:
                                            </td>
                                            <td>
                                                <telerik:RadMaskedTextBox ID="RadMaskedTextBox2" runat="server" Text='<%# Bind("CellPhone")%>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >Facsimile:
                                            </td>
                                            <td>
                                                <telerik:RadMaskedTextBox ID="RadMaskedTextBox3" runat="server" Text='<%# Bind("Fascimile")%>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >Web Page:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox1" runat="server" Text='<%# Bind("WebPage")%>' MaxLength="50"
                                                    Width="90%">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >Notes:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox14" runat="server" Text='<%# Bind("Notes") %>'
                                                    TextMode="MultiLine" Width="90%" MaxLength="1024">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >Subconsultant Code:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtCode" runat="server" Text='<%# Bind("Code")%>' EmptyMessage="Up to 5 characters"
                                                    MaxLength="5">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                    <h4>Billing Contact</h4>
                                    <table class="table-condensed" style="width: 100%">
                                        <tr>
                                            <td style="width:200px;text-align:right" >Name:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox12" runat="server" Text='<%# Bind("Billing_contact") %>'
                                                    MaxLength="80" Width="90%">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >Telephone:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox13" runat="server" Text='<%# Bind("Billing_Telephone") %>'
                                                    MaxLength="25">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                <h4>Notification</h4>
                                    <table class="table-condensed" style="width: 100%">
                                        <tr>
                                            <td style="width:200px;text-align:right" >R.F.Proposal Accepted:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="Notification_acceptedproposalCheckBox1" runat="server" Checked='<%# Bind("Notification_acceptedrfp")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right" >R.F.Proposal Declined:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="Notification_declinedproposalCheckBox1" runat="server" Checked='<%# Bind("Notification_declinedrfp")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                    </table>
                                
                                <div style="text-align:center">
                                    <asp:LinkButton ID="btnUpdateSubconsultant2" runat="server" CommandName="Update" CausesValidation="True" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false">
                                        <span class="glyphicon glyphicon-save"></span> Update
                                    </asp:LinkButton>

                                </div>
                            </EditItemTemplate>

                        </asp:FormView>
                    </div>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Request for Proposal History" StepType="Step">
                    <div>
                        <telerik:RadGrid ID="RadGridRFPs" runat="server" DataSourceID="SqlDataSourceRFP" AutoGenerateColumns="False" AllowSorting="True"
                            PageSize="10" AllowPaging="true"
                            ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceRFP" ShowFooter="True" ClientDataKeyNames="Id">
                                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Id" HeaderText="Number"
                                        SortExpression="Id" UniqueName="Id" ItemStyle-HorizontalAlign="Center"
                                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DateCreated" DataFormatString="{0:d}"
                                        DataType="System.DateTime" HeaderText="Date" SortExpression="DateCreated"
                                        UniqueName="DateCreated" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                                        HeaderStyle-HorizontalAlign="Center">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ProjectName" HeaderText="Project" SortExpression="ProjectName"
                                        UniqueName="ProjectName" HeaderStyle-HorizontalAlign="Center">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Client" HeaderText="Client" SortExpression="ProjectName"
                                        UniqueName="Client" HeaderStyle-HorizontalAlign="Center">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Discipline" FilterControlAltText="Filter Discipline column"
                                        HeaderText="Discipline" SortExpression="Discipline" UniqueName="Discipline"
                                        ItemStyle-HorizontalAlign="Center"
                                        HeaderStyle-HorizontalAlign="Center">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Total" DataFormatString="{0:C2}"
                                        Groupable="False" HeaderText="Total" SortExpression="Total" UniqueName="Total"
                                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                        FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmountPaid" DataFormatString="{0:C2}"
                                        Groupable="False" HeaderText="Fee" SortExpression="AmountPaid" UniqueName="AmountPaid"
                                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                        FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Balance" DataFormatString="{0:C2}"
                                        Groupable="False" HeaderText="Balance" SortExpression="Balance" UniqueName="Balance"
                                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                        FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Code" HeaderText="Job" SortExpression="Code"
                                        UniqueName="Code" ItemStyle-HorizontalAlign="Center"
                                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="Status" HeaderText="Status" UniqueName="Status"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px"
                                        HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <span title="Clic to edit Job Status" class='<%# LocalAPI.GetRFPStatusLabelCSS(Eval("Status")) %>'><%# Eval("Status") %></span>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="SUBCONSULTAN_v20_UPDATE" UpdateCommandType="StoredProcedure"
        SelectCommand="SUBCONSULTANT_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblSubconsultantId" Name="SubconsultantId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="disciplineId" Type="Int32" />
            <asp:Parameter Name="Organization" Type="String" />
            <asp:Parameter Name="Position" Type="String" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="Address2" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="State" Type="String" />
            <asp:Parameter Name="ZipCode" Type="String" />
            <asp:Parameter Name="Telephone" Type="String" />
            <asp:Parameter Name="CellPhone" Type="String" />
            <asp:Parameter Name="Fascimile" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="WebPage" Type="String" />
            <asp:Parameter Name="Code" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="Billing_contact" Type="String" />
            <asp:Parameter Name="Billing_Telephone" Type="String" />
            <asp:Parameter Name="Notification_acceptedrfp" Type="Boolean" />
            <asp:Parameter Name="Notification_declinedrfp" Type="Boolean" />
            <asp:Parameter Name="NAICS_code" />

            <asp:ControlParameter ControlID="lblSubconsultantId" Name="Id" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, companyId, Name FROM SubConsultans_disciplines WHERE (companyId = @companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceRFP" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="RFP_by_Subconsultant_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSubconsultantId" Name="subconsultantId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSubconsultantBalance" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Subconsultant_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblSubconsultantId" Name="subconsultantId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceNAICS" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="NAICS_US_Codes_FromCombobox_SELECT" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSubconsultantId" runat="server" Visible="False"></asp:Label>

</asp:Content>

