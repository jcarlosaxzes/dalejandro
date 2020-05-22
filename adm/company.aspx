<%@ Page Title="Company" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="company.aspx.vb" Inherits="pasconcept20.company" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        wizardStep {
            height: 100%;
        }

        .wizardStepHidden {
            height: 100%;
            display: none !important;
        }
    </style>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>
    <table class="table-condensed" style="padding-left: 50px; padding-top: 10px">
        <tr>
            <td colspan="2">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="companyId" DataSourceID="SqlDataSource1" Width="100%">
                    <ItemTemplate>
                        <telerik:RadWizard ID="RadWizard1" runat="server" Height="720px" DisplayCancelButton="false"
                            RenderMode="Lightweight" Skin="Material" DisplayNavigationButtons="false">
                            <WizardSteps>
                                <telerik:RadWizardStep runat="server" ID="RadWizardStepsCompanyInfo" Title="Company Information" ValidationGroup="Company" StepType="Start">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h3 style="margin: 0">Company Information</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton1" runat="server" ToolTip="Update changes to Company Profile" CommandName="Edit" CausesValidation="False"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                        <span class="glyphicon glyphicon-pencil"></span> Edit
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>

                                    <table class="table-condensed">
                                        <tr>
                                            <td width="160px">Company ID:
                                            </td>
                                            <td>
                                                <asp:Label ID="companyIdLabel" runat="server" Text='<%# Eval("companyId") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Company Name:
                                            </td>
                                            <td>
                                                <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Name")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="160px">Administrator Email:
                                            </td>
                                            <td>
                                                <asp:Label ID="EmailLabel" runat="server" Text='<%# Eval("Email")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Company Type:
                                            </td>
                                            <td>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("TypeName") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Representative:
                                            </td>
                                            <td>
                                                <asp:Label ID="ContactLabel" runat="server" Text='<%# Eval("Contact")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Address Line 1:
                                            </td>
                                            <td>
                                                <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Address Line 2:
                                            </td>
                                            <td>
                                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("Address2")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>City:
                                            </td>
                                            <td>
                                                <asp:Label ID="CityLabel" runat="server" Text='<%# Eval("City")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>State:
                                            </td>
                                            <td>
                                                <asp:Label ID="StateLabel" runat="server" Text='<%# Eval("State")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Zip Code:
                                            </td>
                                            <td>
                                                <asp:Label ID="ZipCodeLabel" runat="server" Text='<%# Eval("ZipCode")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Telephone:
                                            </td>
                                            <td>
                                                <asp:Label ID="PhoneLabel" runat="server" Text='<%# Eval("Phone")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Cell Phone:
                                            </td>
                                            <td>
                                                <asp:Label ID="MovileLabel" runat="server" Text='<%# Eval("Movile")%>' />
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        &nbsp;&nbsp;&nbsp;
                                        <telerik:RadButton ID="btnSMS" runat="server" Text="Send Test SMS" OnClick="btnSMS_Click" ToolTip="Send SMS to CellPhone" Visible='<%# LocalAPI.IsCompanySMSservice(lblCompanyId.Text)%>'>
                                        </telerik:RadButton>
                                                &nbsp;

                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Fax:
                                            </td>
                                            <td>
                                                <asp:Label ID="FaxLabel" runat="server" Text='<%# Eval("Fax")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Website:
                                            </td>
                                            <td>
                                                <asp:HyperLink ID="webLabel" runat="server" Target="_blank" Text='<%# Eval("web")%>' NavigateUrl='<%# Eval("web")%>'></asp:HyperLink>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Language</td>
                                            <td>
                                                <asp:Label ID="LanguageLabel" runat="server" Text='<%# Eval("Language")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Accountant's Email:
                                            </td>
                                            <td>
                                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("AccountantEmail")%>' ToolTip="Email of the Accountant for send BCC Invoices and Statements copy" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>HR Manager Name:
                                            </td>
                                            <td>
                                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("HR_Name")%>' ToolTip="Human Resource manager" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>HR Manager's Email:
                                            </td>
                                            <td>
                                                <asp:Label ID="Label8" runat="server" Text='<%# Eval("HR_Email")%>' ToolTip="Email of Time off Request (Vacations/Personal days)" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Expiration Date:
                                            </td>
                                            <td>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("billingExpirationDate", "{0:d}")%>' ToolTip="Due Date to renove your PASconcept subscription." />
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepSMTP" Title="Email/Storage" ValidationGroup="SMTP" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h3 style="margin: 0">Email Outgoing Settings</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton4" runat="server" ToolTip="Update changes to Company SMTP" CommandName="Edit" CausesValidation="False"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                        <span class="glyphicon glyphicon-pencil"></span> Edit
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>

                                    <table class="table-condensed">
                                        <tr>
                                            <td style="width: 180px">Outgoing Email From:
                                            </td>
                                            <td>
                                                <asp:Label ID="labelwebEmailUserNameTextBox" runat="server" Text='<%# Eval("webEmailUserName")%>' ToolTip="Outgoing account name (username@company_domain.com)"></asp:Label>

                                            </td>
                                        </tr>

                                        <tr>
                                            <td style="width: 180px">SMTP Server:
                                            </td>
                                            <td>
                                                <asp:Label ID="webEmailSMTPLabel" runat="server" Text='<%# Eval("webEmailSMTP")%>' ToolTip="Outgoing mail SMTP (smtp.company_domain.com)" />

                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 180px">SMTP TLS/SSL Required:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox655" runat="server" Checked='<%# Eval("webEmailEnableSsl")%>' Enabled="false" />

                                            </td>
                                        </tr>
                                        <tr>
                                            <td>SMTP Port:
                                            </td>
                                            <td>
                                                <asp:Label ID="labelBox4ff" runat="server" Text='<%# Eval("webEmailPort")%>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 180px">SMTP Use Default Credentials:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox13" runat="server" Checked='<%# Eval("webUseDefaultCredentials")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:LinkButton ID="btnEmail" runat="server" ToolTip="Send Test Email" CommandName="SendTestEmail" CausesValidation="False"
                                                    CssClass="btn btn-primary" UseSubmitBehavior="false">
                                                        <span class="glyphicon glyphicon-envelope"></span> Test Email
                                                </asp:LinkButton>

                                            </td>
                                        </tr>

                                    </table>

                                    <table style="width: 98%">
                                        <tr>
                                            <td colspan="2">
                                                <h3 style="margin: 0">Storage Info</h3>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 180px">Number of Files:
                                            </td>
                                            <td>
                                                <%# Eval("StorageFiles")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Storage Occupied:</td>
                                            <td>
                                                <%# Eval("StoregeSize")%>
                                            </td>
                                        </tr>
                                    </table>


                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepNotifications" Title="Notifications" ValidationGroup="Notifications" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h3 style="margin: 0">Notification Alerts</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton5" runat="server" ToolTip="Update changes to Company Alerts" CommandName="Edit" CausesValidation="False"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                        <span class="glyphicon glyphicon-pencil"></span> Edit
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="table-condensed">
                                        <tr>
                                            <td width="160px">Job Profit:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="Notification_invoiceemittedCheckBox" runat="server" Checked='<%# Eval("Notification_JobProfit")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Proposal Accepted/Declined:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("Notification_AceptedProposal")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>RFP Accepted/Declined:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox5" runat="server" Checked='<%# Eval("Notification_AceptedRFP")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Invoice Emitted:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Eval("Notification_EmittedInvoice")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Invoice Collected:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Eval("Notification_CollectedInvoice")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Notification Cc... Email:
                                            </td>
                                            <td>
                                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("webEmailProfitWarningCC")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Notification Bcc... Email:
                                            </td>
                                            <td>
                                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("webEmailProfitWarningCCO")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Email Signature:
                                            </td>
                                            <td>
                                                <asp:Label ID="EmailSignLabel" runat="server" Text='<%# Eval("EmailSign")%>' />
                                            </td>
                                        </tr>
                                    </table>
                                    <fieldset style="width: 250px;">
                                        <legend class="TituloDeFieldset">&nbsp;SMS Notification Service&nbsp;</legend>
                                        <table class="table-condensed">
                                            <tr>
                                                <td width="160px">Activate SMS:
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="CheckBox6" runat="server" Checked='<%# Bind("SMSservice")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>

                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepPayPal" Title="PayPal " ValidationGroup="PayPal" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h3 style="margin: 0">PayPal Setting</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton6" runat="server" ToolTip="Update changes to Company PayPal" CommandName="Edit" CausesValidation="False"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                        <span class="glyphicon glyphicon-pencil"></span> Edit
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <p>
                                        Below are the instructions for how to generate and get the information needed to connect the API. 
                                        This is a very very simple process, but sometimes users can feel overwhelmed when they see words like Developer, App, or Token. 
                                        If you feel you need any additional help generating this information, simply contact us, and we can provide whatever help might be necessary.
                                    </p>
                                    <ol>
                                        <li>Login to <a href="https://developer.paypal.com/developer/applications" target="_blank">paypal.com</a></li>
                                        <li>Once in, the page should look something like the one captured below. Once there one must click on the create app button</li>
                                        <li>Once the "Create App" button is selected you will be directed to a simple form (seen Below). You can then just enter the name of the app and then hit the "Create App" Button. In this case, we suggest calling the App "PASConcept"</li>
                                        <li>Once the above step is done, you will be taken to the API token page. It is important that once you are there, under the area labeled "Secret" you click the "Show" button. The following are the fields you should provide to Form in <b>Edit Profile</b></li>
                                    </ol>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepCollection" Title="Collection " ValidationGroup="PayPal" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h3 style="margin: 0">Collection Attorney Firm</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton13" runat="server" ToolTip="Update changes to Company PayPal" CommandName="Edit" CausesValidation="False"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                        <span class="glyphicon glyphicon-pencil"></span> Edit
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <p>
                                        Profile of the law firm that processes client files that go into debt collection status and temporarily lock their accounts.
                                    </p>
                                    <table class="table-condensed">
                                        <tr>
                                            <td style="width: 160px">Attorney Firm :
                                            </td>
                                            <td>
                                                <%# Eval("AttorneyFirm") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Attorney Firm:
                                            </td>
                                            <td>
                                                <%# Eval("AttorneyName")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Attorney Email:
                                            </td>
                                            <td>
                                                <%# Eval("AttorneyEmail")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Phone:
                                            </td>
                                            <td>
                                                <%# Eval("AttorneyPhone")%>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadWizardStep>


                                <telerik:RadWizardStep runat="server" ID="RadWizardStepLogo" Title="Logo & Signature" StepType="Step">
                                    <h3 style="margin: 0">Logo & Signature Setting</h3>
                                    <table class="table-condensed">
                                        <tr>
                                            <td>Picture quality recommended for company letter head: 1700 x 225 pixels, 200 dpi resolution equivalent to 8,5" x 1,5"
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 50%; vertical-align: top">
                                                <h3>Company Logo</h3>
                                                <telerik:RadGrid runat="server" AutoGenerateColumns="False" ID="RadGridLogo" DataSourceID="SqlDataSourceLogo" AllowAutomaticUpdates="True">
                                                    <MasterTableView DataKeyNames="companyId" DataSourceID="SqlDataSourceLogo">
                                                        <Columns>
                                                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                                                HeaderText="Edit" ItemStyle-Width="20px" HeaderStyle-Width="20px">
                                                            </telerik:GridEditCommandColumn>
                                                            <telerik:GridBinaryImageColumn DataField="shortLogo" HeaderText="Proposal/Invoice Logo" UniqueName="shortLogo"
                                                                ImageAlign="NotSet" ImageWidth="180px" ImageHeight="170px" ResizeMode="Fit">
                                                            </telerik:GridBinaryImageColumn>
                                                        </Columns>
                                                        <EditFormSettings CaptionFormatString="Edit Proposal/Invoice Logo" FormCaptionStyle-ForeColor="#ff8c00">
                                                            <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                                            <FormMainTableStyle GridLines="None" CellSpacing="0" CellPadding="3" BackColor="White"
                                                                Width="100%" />
                                                            <FormTableStyle CellSpacing="0" CellPadding="2" BackColor="White" />
                                                            <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                                                            <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1"
                                                                CancelText="Cancel">
                                                            </EditColumn>
                                                            <FormTableButtonRowStyle HorizontalAlign="Left" CssClass="EditFormButtonRow"></FormTableButtonRowStyle>
                                                        </EditFormSettings>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="vertical-align: top">
                                                <h3>Signature Pictures</h3>
                                                <telerik:RadGrid runat="server" AutoGenerateColumns="False" ID="RadGridSign" DataSourceID="SqlDataSourceSign" AllowAutomaticUpdates="True">
                                                    <MasterTableView DataKeyNames="companyId" DataSourceID="SqlDataSourceSign">
                                                        <Columns>
                                                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderText="Edit"
                                                                ItemStyle-Width="20px" HeaderStyle-Width="20px">
                                                            </telerik:GridEditCommandColumn>
                                                            <telerik:GridBinaryImageColumn DataField="imgSign" HeaderText="Proposal Signature" UniqueName="imgSign"
                                                                ImageAlign="NotSet" ImageHeight="180px" ImageWidth="180px" ResizeMode="Fit">
                                                            </telerik:GridBinaryImageColumn>
                                                        </Columns>
                                                        <EditFormSettings CaptionFormatString="Edit Proposal Signature" FormCaptionStyle-ForeColor="#ff8c00">
                                                            <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                                            <FormMainTableStyle GridLines="None" CellSpacing="0" CellPadding="3" BackColor="White"
                                                                Width="100%" />
                                                            <FormTableStyle CellSpacing="0" CellPadding="2" BackColor="White" />
                                                            <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                                                            <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1"
                                                                CancelText="Cancel">
                                                            </EditColumn>
                                                            <FormTableButtonRowStyle HorizontalAlign="Left" CssClass="EditFormButtonRow"></FormTableButtonRowStyle>
                                                        </EditFormSettings>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStep4" Title="QuickBooks" ValidationGroup="QuickBooks" StepType="Step" CssClass="wizardStepHidden">
                                    <div class="Formulario">
                                        <table class="table-condensed">
                                            <tr>
                                                <td colspan="2">
                                                    <h3 style="padding-left: 50px; margin: 3px">Sign In to authorize PASconcept to connect to Intuit</h3>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 250px; text-align: right; padding-right: 5px">
                                                    <telerik:RadButton ID="btnQB" runat="server" OnClick="btnQB_Click" ToolTip="QuickBooks Connect" Enabled='<%#LocalAPI.IsQuickBookModule(Eval("companyId"))%>' Width="298px" Height="102px">
                                                        <Image ImageUrl="~/images/qb_btn.png" />
                                                    </telerik:RadButton>
                                                </td>
                                                <td>PASconcept will be able to access your QuickBooks data, but will not be able to see your Intuit account password. 
                                                <br />
                                                    You can revoke access under 'Manage My Apps' in Intuit App Center by clicking 'Disconnect' next to the app name.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <h3 style="color: red; padding-left: 50px; margin: 0"><%# Eval("qbConnected")%></h3>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <hr />
                                                    <h3 style="padding-left: 50px; margin: 3px">Intuit Quick Book Company Settings</h3>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td style="width: 250px; text-align: right; padding-right: 5px">Company ID:
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("qbCompnyID")%>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <h4 style="padding-left: 50px; margin: 3px">Employee Connection</h4>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 250px; text-align: right; padding-right: 5px">Synchronize Employees:
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="ckhSynchronizeEmployeesRO" runat="server" Checked='<%# Eval("qbSynchronizeEmployees")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; padding-right: 5px">Synchronize Employees Time:
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkqbSynchronizeEmployeesTimeRO" runat="server" Checked='<%# Eval("qbSynchronizeEmployeesTime")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; padding-right: 5px">Synchronize Employee Vacations:
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkqbSynchronizeEmployeesVacationRO" runat="server" Checked='<%# Eval("qbSynchronizeEmployeesVacation")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; padding-right: 5px">Synchronize Employees Personal Time:
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkqbSynchronizeEmployeesPersonalRO" runat="server" Checked='<%# Eval("qbSynchronizeEmployeesPersonal")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <h4 style="padding-left: 50px; margin: 3px">Clients Connection</h4>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 250px; text-align: right; padding-right: 5px">Synchronize Clients:
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkqbSynchronizeClientsRO" runat="server" Checked='<%# Eval("qbSynchronizeClients")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 250px; text-align: right; padding-right: 5px">Online Payment:
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="CheckBox9" runat="server" Checked='<%# Eval("qbOnlinePayment")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; padding-right: 5px">Synchronize Invoices:
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="CheckBox11" runat="server" Checked='<%# Eval("qbSynchronizeInvoices")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                        </table>
                                        <br />

                                    </div>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStep5" Title="Add-Ons" ValidationGroup="Add-Ons" StepType="Step" CssClass="wizardStepHidden">
                                    <div class="Formulario" style="width: 800px">
                                        <h3>List of modules available</h3>

                                        <div class="checkbox">
                                            <label>
                                                <asp:CheckBox ID="chkPayPal" runat="server" Text="PayPal Connection" Checked='<%# Eval("PayPalModule")%>' Enabled="false" />
                                                <p class="text-muted" style="padding-left: 20px">'Pay here' button in Invoices and Statements</p>
                                            </label>
                                        </div>

                                        <div class="checkbox">
                                            <label>
                                                <asp:CheckBox ID="chkqbModule" runat="server" Text="Quick Book Connection" Checked='<%# Eval("qbModule")%>' Enabled="false" />
                                                <p class="text-muted" style="padding-left: 20px">Connect the jobs and invoices directly to QB</p>
                                            </label>
                                        </div>

                                        <div class="checkbox">
                                            <label>
                                                <asp:CheckBox ID="chkazureStorage" runat="server" Text="File Storage" Checked='<%# Eval("azureStorage")%>' Enabled="false" />
                                                <p class="text-muted" style="padding-left: 20px">Allows you to upload files to the cloud associated projects</p>
                                            </label>
                                        </div>

                                        <div class="checkbox">
                                            <label>
                                                <asp:CheckBox ID="chkSMSservice" runat="server" Text="SMS Service" Checked='<%# Eval("SMSservice")%>' Enabled="false" />
                                                <p class="text-muted" style="padding-left: 20px">Allows send SMS text like Emails</p>
                                            </label>
                                        </div>

                                        <div class="checkbox">
                                            <label>
                                                <asp:CheckBox ID="chkbillingModule" runat="server" Text="Additional Billing Options" Checked='<%# Eval("billingModule")%>' Enabled="false" />
                                                <p class="text-muted" style="padding-left: 20px">Schedule periodic sending invoices and other options</p>
                                            </label>
                                        </div>
                                        <h4>To request the hiring of these modules, contact:  matt@axzes.com</h4>
                                    </div>
                                </telerik:RadWizardStep>
                            </WizardSteps>
                        </telerik:RadWizard>

                    </ItemTemplate>

                    <EditItemTemplate>
                        <telerik:RadWizard ID="RadWizard2" runat="server" Height="720px" DisplayCancelButton="false"
                            RenderMode="Lightweight" Skin="Material" DisplayNavigationButtons="false">
                            <WizardSteps>
                                <telerik:RadWizardStep runat="server" ID="RadWizardStepsCompanyInfo2" Title="Company Information" ValidationGroup="Company" StepType="Start">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h3 style="margin: 0">Company Information</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton2" runat="server" ToolTip="Update changes to Company Profile" CommandName="Update" CausesValidation="True"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                    <span class="glyphicon glyphicon-save"></span> Update
                                                </asp:LinkButton>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="LinkButton3" runat="server" ToolTip="Cancel changes" CommandName="Cancel" CausesValidation="False"
                                                    CssClass="btn btn-default btn" UseSubmitBehavior="false">
                                                    Cancel
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="table-condensed">
                                        <tr>
                                            <td>Company ID:
                                            </td>
                                            <td>
                                                <asp:Label ID="companyIdLabel" runat="server" Text='<%# Eval("companyId") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Company Name:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Administrator Email:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email")%>' MaxLength="128" Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Company Type:
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceTypes"
                                                    DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("Type") %>'
                                                    Width="500px" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="(Type Not Defined...)" Value="0" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Representative:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="ContactTextBox" runat="server" Text='<%# Bind("Contact")%>'
                                                    Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Address Line 1:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address")%>'
                                                    Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Address Line 2:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox1" runat="server" Text='<%# Bind("Address2")%>'
                                                    Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>City:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="CityTextBox" runat="server" Text='<%# Bind("City")%>' Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>State:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="StateTextBox" runat="server" Text='<%# Bind("State")%>' Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Zip Code:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="ZipCodeTextBox" runat="server" Text='<%# Bind("ZipCode") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Telephone:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Cell Phone:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="MovileTextBox" runat="server" Text='<%# Bind("Movile")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Fax:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="FaxTextBox" runat="server" Text='<%# Bind("Fax")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Website:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="webTextBox" runat="server" Text='<%# Bind("web")%>' Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Language</td>
                                            <td>
                                                <telerik:RadComboBox ID="cboLanguage" runat="server" Width="150px" SelectedValue='<%# Bind("Language")%>'>
                                                    <Items>
                                                        <telerik:RadComboBoxItem runat="server" Text="English" Value="en" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Español" Value="es" />
                                                    </Items>
                                                </telerik:RadComboBox>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="160px">Accountant's Email:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtAccountantEmail" runat="server" Text='<%# Bind("AccountantEmail")%>' MaxLength="128" Width="500px" EmptyMessage="Email to send BCC invoices copy" ToolTip="Email of the Accountant for send BCC Invoices and Statements copy" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="160px">HR Manager Name:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox4" runat="server" Text='<%# Bind("HR_Name")%>' MaxLength="80" Width="500px" EmptyMessage="Human Resource manager Name" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="160px">HR Manager's Email:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox5" runat="server" Text='<%# Bind("HR_Email")%>' MaxLength="128" Width="500px" EmptyMessage="Email to send Time off Request" />
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepSMTP2" Title="SMTP Settings" ValidationGroup="SMTP" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h3 style="margin: 0">Email SMTP Outgoing Settings</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton7" runat="server" ToolTip="Update changes to Company Email SMTP Settings" CommandName="Update" CausesValidation="True"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                    <span class="glyphicon glyphicon-save"></span> Update
                                                </asp:LinkButton>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="LinkButton8" runat="server" ToolTip="Cancel changes" CommandName="Cancel" CausesValidation="False"
                                                    CssClass="btn btn-default btn" UseSubmitBehavior="false">
                                                    Cancel
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="table-condensed">
                                        <tr>
                                            <td style="width: 220px">Outgoing Email From:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="webEmailUserNameTextBox" runat="server" Text='<%# Bind("webEmailUserName")%>' ToolTip="Outgoing account name (username@company_domain.com)"
                                                    Width="500px" EmptyMessage="Outgoing account name (username@company_domain.com)" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>SMTP Server:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="webEmailSMTPTextBox" runat="server" Text='<%# Bind("webEmailSMTP")%>' ToolTip="Outgoing mail SMTP (smtp.company_domain.com)" Width="500px"></telerik:RadTextBox>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <telerik:RadButton ID="btnHelp" runat="server" Text="Help" ButtonType="LinkButton" AutoPostBack="false" Font-Bold="true"
                                                        UseSubmitBehavior="false" CausesValidation="false" Width="100px" Target="_blank" NavigateUrl="http://blog.pasconcept.com/2015/04/company-profile-smtp.html">
                                                        <Icon PrimaryIconCssClass="rbHelp"></Icon>
                                                    </telerik:RadButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><small>If you do not fill the [SMTP Server] field, the app send emails with PASconcept default account!</small>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>SMTP Password:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="webEmailPasswordTextBox" runat="server" Text='<%# Bind("webEmailPassword")%>' Width="150px"
                                                    TextMode="Password" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>SMTP Port:
                                            </td>
                                            <td>
                                                <telerik:RadNumericTextBox ID="RadTextBox4ff" runat="server" Text='<%# Bind("webEmailPort")%>' EmptyMessage="25" Width="150px">
                                                    <NumberFormat DecimalDigits="0" />
                                                </telerik:RadNumericTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>SMTP TLS/SSL Required:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox6jj" runat="server" Checked='<%# Bind("webEmailEnableSsl")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>SMTP Use Default Credentials:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox14" runat="server" Checked='<%# Bind("webUseDefaultCredentials")%>' />
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepNotifications2" Title="Notifications" ValidationGroup="Notifications" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h3 style="margin: 0">Notification Alerts</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton9" runat="server" ToolTip="Update changes to Company Notification Alerts" CommandName="Update" CausesValidation="True"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                    <span class="glyphicon glyphicon-save"></span> Update
                                                </asp:LinkButton>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="LinkButton10" runat="server" ToolTip="Cancel changes" CommandName="Cancel" CausesValidation="False"
                                                    CssClass="btn btn-default btn" UseSubmitBehavior="false">
                                                    Cancel
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="table-condensed">
                                        <tr>
                                            <td width="180px">Job Profit:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox11_EDIT" runat="server" Checked='<%# Bind("Notification_JobProfit")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Proposal Accepted/Declined:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox1_EDIT" runat="server" Checked='<%# Bind("Notification_AceptedProposal")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>RFP Accepted/Declined:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox4" runat="server" Checked='<%# Bind("Notification_AceptedRFP")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Invoice Emitted:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox2_EDIT" runat="server" Checked='<%# Bind("Notification_EmittedInvoice")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Invoice Collected:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox3_EDIT" runat="server" Checked='<%# Bind("Notification_CollectedInvoice")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Notification Cc... Email:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox2" runat="server" Text='<%# Bind("webEmailProfitWarningCC")%>' Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Notification Bcc... Email:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox3" runat="server" Text='<%# Bind("webEmailProfitWarningCCO")%>' Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Email Signature:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="EmailSignTextBox" runat="server" Text='<%# Bind("EmailSign")%>'
                                                    Width="500px" EmptyMessage="Outgoing mail signature Line 1 (Robert Clinton)" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <h3>SMS Notification Service</h3>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td width="160px">Activate SMS:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBoxSMSservice" runat="server" Checked='<%# Bind("SMSservice")%>' />
                                            </td>
                                        </tr>

                                    </table>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepPayPal2" Title="PayPal " ValidationGroup="PayPal" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h3 style="margin: 0">
                                                    <h3>PayPal Setting</h3>
                                                </h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton11" runat="server" ToolTip="Update changes to Company <h3></h3>" CommandName="Update" CausesValidation="True"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                    <span class="glyphicon glyphicon-save"></span> Update
                                                </asp:LinkButton>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="LinkButton12" runat="server" ToolTip="Cancel changes" CommandName="Cancel" CausesValidation="False"
                                                    CssClass="btn btn-default btn" UseSubmitBehavior="false">
                                                    Cancel
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="table-condensed" style="width: 100%">
                                        <tr>
                                            <td width="180px">Activate PayPal Module:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox12" runat="server" Checked='<%# Bind("PayPalModule")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>PayPal Client ID:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox9" runat="server" Text='<%# Bind("PayPalClientId") %>' Width="100%" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>PayPal Secret:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox10" runat="server" Text='<%# Bind("PayPalClientSecret") %>' Width="100%" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Maximum Amount ($):
                                            </td>
                                            <td>
                                                <telerik:RadNumericTextBox ID="txtPayHereMax" Type="Currency" DbValue='<%# Bind("PayHereMax")%>'
                                                    ToolTip="Limit the maximum amount ($) allowed to pay for the customer using PayHere. Zero implies that there is no limit" runat="server"
                                                    Width="150px">
                                                    <NumberFormat DecimalDigits="0" />
                                                </telerik:RadNumericTextBox>
                                                <small>Limit the maximum amount ($) allowed to pay for the customer using PayHere. Zero implies that there is no limit</small>
                                            </td>
                                        </tr>

                                    </table>
                                </telerik:RadWizardStep>


                                <telerik:RadWizardStep runat="server" ID="RadWizardStepCollection2" Title="Collection " ValidationGroup="Collection" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h3 style="margin: 0">
                                                    <h3>Collection Setting</h3>
                                                </h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton14" runat="server" ToolTip="Update changes to Company" CommandName="Update" CausesValidation="True"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                    <span class="glyphicon glyphicon-save"></span> Update
                                                </asp:LinkButton>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="LinkButton15" runat="server" ToolTip="Cancel changes" CommandName="Cancel" CausesValidation="False"
                                                    CssClass="btn btn-default btn" UseSubmitBehavior="false">
                                                    Cancel
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="table-condensed" style="width: 100%">
                                        <tr>
                                            <td width="180px">Attorney Firm:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox6" runat="server" Text='<%# Bind("AttorneyFirm") %>' Width="100%" MaxLength="80" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Attorney Name:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox7" runat="server" Text='<%# Bind("AttorneyName") %>' Width="100%" MaxLength="80" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Attorney Phone:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox8" runat="server" Text='<%# Bind("AttorneyPhone") %>' Width="100%" MaxLength="10" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Attorney Email:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox11" runat="server" Text='<%# Bind("AttorneyEmail") %>' Width="100%" MaxLength="80" />
                                            </td>
                                        </tr>

                                    </table>
                                </telerik:RadWizardStep>


                                <telerik:RadWizardStep runat="server" ID="RadWizardStepQuickBooks2" Title="QuickBooks" ValidationGroup="QuickBooks" StepType="Step" CssClass="wizardStepHidden">
                                    <table class="table-condensed">
                                        <tr>
                                            <td colspan="2">
                                                <h3 style="padding-left: 50px; margin: 3px">Intuit Quick Book Company Settings</h3>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td style="width: 260px; text-align: right; padding-right: 5px">Company ID:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox runat="server" ID="qbCompanyID" Text='<%# Bind("qbCompnyID")%>'
                                                    ToolTip="Find Company ID in Your Company->Your Account" Width="200px">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <h4 style="padding-left: 50px; margin: 3px">Employee Connection</h4>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 260px; text-align: right; padding-right: 5px">Synchronize Employees:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="ckhSynchronizeEmployees" runat="server" Checked='<%# Bind("qbSynchronizeEmployees")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 5px">Synchronize Employees Time:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkqbSynchronizeEmployeesTime" runat="server" Checked='<%# Bind("qbSynchronizeEmployeesTime")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 5px">Synchronize Employee Vacations:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkqbSynchronizeEmployeesVacationRO" runat="server" Checked='<%# Bind("qbSynchronizeEmployeesVacation")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 5px">Synchronize Employees Personal Time:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkqbSynchronizeEmployeesPersonalRO" runat="server" Checked='<%# Bind("qbSynchronizeEmployeesPersonal")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <h4 style="padding-left: 50px; margin: 3px">Clients Connection</h4>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 260px; text-align: right; padding-right: 5px">Synchronize Clients:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox7" runat="server" Checked='<%# Bind("qbSynchronizeClients")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 260px; text-align: right; padding-right: 5px">Online Payment:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox8" runat="server" Checked='<%# Bind("qbOnlinePayment")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 5px">Synchronize Invoices:
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="CheckBox10" runat="server" Checked='<%# Bind("qbSynchronizeInvoices")%>' />
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadWizardStep>

                            </WizardSteps>
                        </telerik:RadWizard>

                    </EditItemTemplate>

                </asp:FormView>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <telerik:RadTabStrip runat="server" ID="RadTabStripOther" MultiPageID="RadMultiPageOther" SelectedIndex="0" Skin="Material" RenderMode="Lightweight">
                    <Tabs>
                        <telerik:RadTab Text="Holidays"></telerik:RadTab>
                        <telerik:RadTab Text="Expenses"></telerik:RadTab>

                        <telerik:RadTab Text="Logo & Signature" Visible="false"></telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
                <telerik:RadMultiPage runat="server" ID="RadMultiPageOther" SelectedIndex="0">
                    <telerik:RadPageView runat="server" ID="RadPageViewOther2">
                        <table class="table-condensed" style="width: 100%">
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="RadGridHoliday" GridLines="None" runat="server" AllowAutomaticDeletes="True"
                                        AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AllowPaging="True"
                                        AutoGenerateColumns="False" DataSourceID="SqlDataSourceHoliday" Height="350px" PageSize="100">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" SaveScrollPosition="true"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="Id"
                                            DataSourceID="SqlDataSourceHoliday" HorizontalAlign="NotSet" AutoGenerateColumns="False">
                                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                            <Columns>
                                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                                    HeaderText="Edit" HeaderStyle-Width="40px">
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridDateTimeColumn DataField="Holiday" HeaderStyle-Width="150px" PickerType="DatePicker" HeaderText="Holiday"
                                                    SortExpression="Holiday" UniqueName="Holiday" DataFormatString="{0:d}">
                                                </telerik:GridDateTimeColumn>
                                                <telerik:GridBoundColumn DataField="Description" HeaderText="Description"
                                                    SortExpression="Description" UniqueName="Description">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridButtonColumn ConfirmText="Delete this record?" ConfirmDialogType="RadWindow"
                                                    ConfirmTitle="Delete" HeaderText="Delete" HeaderStyle-Width="50px"
                                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                                </telerik:GridButtonColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>

                    </telerik:RadPageView>
                    <telerik:RadPageView runat="server" ID="RadPageViewOther3">

                        <table class="table-condensed">
                            <tr>
                                <td style="text-align: center; width: 80px">
                                    <telerik:RadNumericTextBox ID="txtExpensesYear" ToolTip="Year" runat="server" Width="100px"
                                        EmptyMessage="Year" ShowSpinButtons="True">
                                        <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                        <IncrementSettings Step="1" />
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td style="text-align: center">
                                    <small>Structure of the CSV file to import(ExpDate, Category, Amount)</small>
                                </td>
                                <td style="width: 200px; text-align: right">
                                    <telerik:RadAsyncUpload ID="RadUploadExpenses1" runat="server" Width="100%" ControlObjectsVisibility="None" MultipleFileSelection="Disabled" EnableFileInputSkinning="true"
                                        AllowedFileExtensions="csv,txt">
                                    </telerik:RadAsyncUpload>
                                </td>
                                <td style="width: 110px; text-align: right">

                                    <asp:LinkButton ID="btnExpensesImport" runat="server" ToolTip="Import Company Overhead.CSV files with columns(Date, Category, Amount)"
                                        CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-upload"></span> Import
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <telerik:RadGrid ID="RadGridExpenses" GridLines="None" runat="server" AllowAutomaticDeletes="True" ItemStyle-Font-Size="Small"
                            AlternatingItemStyle-Font-Size="Small" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AllowPaging="True" ShowFooter="true"
                            AutoGenerateColumns="False" DataSourceID="SqlDataSourceExpenses" Height="400px" PageSize="100" AllowSorting="true">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView CommandItemDisplay="Top" DataKeyNames="Id"
                                DataSourceID="SqlDataSourceExpenses" HorizontalAlign="NotSet" AutoGenerateColumns="False">
                                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                <Columns>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                        HeaderText="Edit" HeaderStyle-Width="40px">
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridDateTimeColumn DataField="ExpDate" HeaderStyle-Width="150px" PickerType="DatePicker" HeaderText="Date"
                                        SortExpression="ExpDate" UniqueName="ExpDate" DataFormatString="{0:d}">
                                    </telerik:GridDateTimeColumn>
                                    <telerik:GridBoundColumn DataField="Category" HeaderText="Category"
                                        SortExpression="Category" UniqueName="Category">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridNumericColumn DataField="Amount" HeaderStyle-Width="150px" HeaderText="Amount"
                                        SortExpression="Amount" UniqueName="Amount" DataFormatString="{0:N2}" Aggregate="Sum">
                                    </telerik:GridNumericColumn>
                                    <telerik:GridButtonColumn ConfirmText="Delete this record?" ConfirmDialogType="RadWindow"
                                        ConfirmTitle="Delete" HeaderText="Delete" HeaderStyle-Width="50px"
                                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                    </telerik:RadPageView>
                    <telerik:RadPageView runat="server" ID="RadPageViewOther4">
                        <table class="table-condensed">
                            <tr>
                                <td>
                                    <%--<h3>Letterhead (obsolete !, use Logo)</h3>--%>
                                    <telerik:RadGrid runat="server" AutoGenerateColumns="False" ID="RadGridLetterHead" DataSourceID="SqlDataSourceLetterHead" AllowAutomaticUpdates="True" Visible="false">
                                        <MasterTableView DataKeyNames="companyId" DataSourceID="SqlDataSourceLetterHead">
                                            <Columns>
                                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                                    HeaderText="Edit" ItemStyle-Width="20px" HeaderStyle-Width="20px">
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridBinaryImageColumn DataField="imgLogo" HeaderText="Proposal/Invoice Letterhead" UniqueName="imgLogo"
                                                    ImageAlign="NotSet" ImageWidth="800px" ImageHeight="140px" ResizeMode="Fit">
                                                </telerik:GridBinaryImageColumn>
                                            </Columns>
                                            <EditFormSettings CaptionFormatString="Edit Proposal/Invoice Letterhead" FormCaptionStyle-ForeColor="#ff8c00">
                                                <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                                <FormMainTableStyle GridLines="None" CellSpacing="0" CellPadding="3" BackColor="White"
                                                    Width="100%" />
                                                <FormTableStyle CellSpacing="0" CellPadding="2" BackColor="White" />
                                                <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                                                <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1"
                                                    CancelText="Cancel">
                                                </EditColumn>
                                                <FormTableButtonRowStyle HorizontalAlign="Left" CssClass="EditFormButtonRow"></FormTableButtonRowStyle>
                                            </EditFormSettings>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
        <tr>
            <td>
                <asp:HyperLink ID="lnkExp" runat="server" Target="_blank" NavigateUrl="~/OPE/CompanyExperience.aspx">Public Company Experience site</asp:HyperLink>
            </td>
            <td style="text-align: right; padding-right: 150px">
                <telerik:RadButton ID="btnNotification" runat="server" Text="Send Test Notification" ToolTip="Send Notification">
                </telerik:RadButton>

            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="SqlDataSourceLogo" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT companyId, shortLogo FROM [Company] WHERE ([companyId] = @companyId)"
        UpdateCommand="UPDATE [Company] SET [shortLogo] = @shortLogo WHERE [companyId] = @companyId"
        ProviderName="<%$ ConnectionStrings:cnnProjectsAccounting.ProviderName %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="shortLogo" DbType="Binary" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceLetterHead" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT companyId, imgLogo FROM [Company] WHERE ([companyId] = @companyId)"
        UpdateCommand="UPDATE [Company] SET [imgLogo] = @imgLogo WHERE [companyId] = @companyId"
        ProviderName="<%$ ConnectionStrings:cnnProjectsAccounting.ProviderName %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="imgLogo" DbType="Binary" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSign" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT companyId, imgSign  FROM [Company] WHERE ([companyId] = @companyId)"
        UpdateCommand="UPDATE [Company] SET [imgSign] = @imgSign  WHERE [companyId] = @companyId"
        ProviderName="<%$ ConnectionStrings:cnnProjectsAccounting.ProviderName %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="imgSign" DbType="Binary" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CompanyProfile_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="CompanyProfile_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="Contact" Type="String" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="Address2" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="State" Type="String" />
            <asp:Parameter Name="ZipCode" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="Movile" Type="String" />
            <asp:Parameter Name="Fax" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="webEmailSMTP" Type="String" />
            <asp:Parameter Name="webEmailEnableSsl" />
            <asp:Parameter Name="webEmailPort" />
            <asp:Parameter Name="webUseDefaultCredentials" />
            <asp:Parameter Name="webEmailUserName" Type="String" />
            <asp:Parameter Name="webEmailPassword" Type="String" />
            <asp:Parameter Name="webEmailProfitWarningCC" Type="String" />
            <asp:Parameter Name="webEmailProfitWarningCCO" Type="String" />
            <asp:Parameter Name="web" Type="String" />
            <asp:Parameter Name="EmailSign" Type="String" />
            <asp:Parameter Name="Notification_AceptedProposal" />
            <asp:Parameter Name="Notification_EmittedInvoice" />
            <asp:Parameter Name="Notification_CollectedInvoice" />
            <asp:Parameter Name="Notification_JobProfit" />
            <asp:Parameter Name="Notification_AceptedRFP" />
            <asp:Parameter Name="Language" Type="String" />
            <asp:Parameter Name="AccountantEmail" Type="String" />
            <asp:Parameter Name="SMSservice" />
            <asp:Parameter Name="HR_Name" Type="String" />
            <asp:Parameter Name="HR_Email" Type="String" />
            <asp:Parameter Name="qbCompnyID" Type="String" />

            <asp:Parameter Name="qbSynchronizeEmployees" />
            <asp:Parameter Name="qbSynchronizeEmployeesTime" />
            <asp:Parameter Name="qbSynchronizeEmployeesVacation" />
            <asp:Parameter Name="qbSynchronizeClients" />
            <asp:Parameter Name="qbSynchronizeInvoices" />
            <asp:Parameter Name="qbOnlinePayment" />

            <asp:Parameter Name="PayPalModule" />
            <asp:Parameter Name="PayPalClientId" />
            <asp:Parameter Name="PayPalClientSecret" />
            <asp:Parameter Name="PayHereMax" />

            <asp:Parameter Name="AttorneyFirm" />
            <asp:Parameter Name="AttorneyName" />
            <asp:Parameter Name="AttorneyPhone" />
            <asp:Parameter Name="AttorneyEmail" />

            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Company_types ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceHoliday" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Holiday, Description FROM Company_hollidays WHERE ([companyId] = @companyId) ORDER BY Holiday DESC"
        InsertCommand="INSERT INTO Company_hollidays(Holiday, Description, companyId) VALUES(@Holiday, @Description, @companyId)"
        DeleteCommand="DELETE FROM Company_hollidays WHERE Id=@Id"
        UpdateCommand="UPDATE Company_hollidays SET Holiday=@Holiday, Description=@Description WHERE Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Holiday" />
            <asp:Parameter Name="Description" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Holiday" />
            <asp:Parameter Name="Description" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceExpenses" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, ExpDate, Category, Amount FROM Company_Expenses WHERE ([companyId] = @companyId) and Year(ExpDate)=@Year ORDER BY ExpDate DESC, Category "
        InsertCommand="INSERT INTO Company_Expenses(ExpDate, Amount, Category, companyId) VALUES(@ExpDate, @Amount, @Category, @companyId)"
        DeleteCommand="DELETE FROM Company_Expenses WHERE Id=@Id"
        UpdateCommand="UPDATE Company_Expenses SET ExpDate=@ExpDate, Amount=@Amount, Category=@Category WHERE Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtExpensesYear" Name="Year" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ExpDate" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="Category" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="ExpDate" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="Category" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="btnActiveTab" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>
