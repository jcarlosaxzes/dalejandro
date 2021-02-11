﻿<%@ Page Title="Company" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="company.aspx.vb" Inherits="pasconcept20.company" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        wizardStep {
            height: 100%;
        }

        .wizardStepHidden {
            height: 100%;
            height: 100%;
            display: none !important;
        }
    </style>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Company Profile</span>
    </div>



    <div class="pasconcept-bar" style="width:100%">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="companyId" DataSourceID="SqlDataSource1" Width="100%">
                    <ItemTemplate>
                        <telerik:RadWizard ID="RadWizard1" runat="server" Height="800px" DisplayCancelButton="false"
                            RenderMode="Lightweight" Skin="Silk" DisplayNavigationButtons="false" DisplayProgressBar="false" Width="100%" RenderedSteps="Active">
                            <WizardSteps>
                                <telerik:RadWizardStep runat="server" ID="RadWizardStepsCompanyInfo" Title="Company Information" ValidationGroup="Company" StepType="Start">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h4 style="margin: 0">
                                                Company Information</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton1" runat="server" ToolTip="Update changes to Company Profile" CommandName="Edit" CausesValidation="False"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                        <i class="fas fa-pen"></i> Edit
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>

                                    <table class="table-sm">
                                        <tr>
                                            <td style="width:250px; text-align:right">Company ID:
                                            </td>
                                            <td>
                                                <%# Eval("companyId") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Company Name:
                                            </td>
                                            <td>
                                                <%# Eval("Name")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Administrator Name:
                                            </td>
                                            <td>
                                                <%# Eval("Contact")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Administrator Email:
                                            </td>
                                            <td>
                                                <%# Eval("Email")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Company Type:
                                            </td>
                                            <td>
                                                <%# Eval("TypeName") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Address Line 1:
                                            </td>
                                            <td>
                                                <%# Eval("Address")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Address Line 2:
                                            </td>
                                            <td>
                                                <%# Eval("Address2")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">City:
                                            </td>
                                            <td>
                                                <%# Eval("City")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">State:
                                            </td>
                                            <td>
                                                <%# Eval("State")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Zip Code:
                                            </td>
                                            <td>
                                                <%# Eval("ZipCode")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Telephone:
                                            </td>
                                            <td>
                                                <%# Eval("Phone")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Cell Phone:
                                            </td>
                                            <td>
                                                <%# Eval("Movile")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Fax:
                                            </td>
                                            <td>
                                                <%# Eval("Fax")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Website:
                                            </td>
                                            <td>
                                                <asp:HyperLink ID="webLabel" runat="server" Target="_blank" Text='<%# Eval("web")%>' NavigateUrl='<%# Eval("web")%>'></asp:HyperLink>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Language</td>
                                            <td>
                                                <%# Eval("Language")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Accounting Email:
                                            </td>
                                            <td>
                                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("AccountantEmail")%>' ToolTip="This email will receive BCC copies of invoices" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Human Resources Manager Name:
                                            </td>
                                            <td>
                                                <%# Eval("HR_Name")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Human Resources Manager Email:
                                            </td>
                                            <td>
                                                <asp:Label ID="Label8" runat="server" Text='<%# Eval("HR_Email")%>' ToolTip="Human Resources Manager Email to Vacation Request" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">HR Pay Frequency:
                                            </td>
                                            <td>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("HR_payfrequency")%>' ToolTip="Payment Frequency" />
                                            </td>
                                        </tr>


                                        <tr>
                                            <td style="text-align:right">Expiration Date:
                                            </td>
                                            <td>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("billingExpirationDate", "{0:d}")%>' ToolTip="Due Date to renove your PASconcept subscription." />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Time Zone (UTC):
                                            </td>
                                            <td>
                                                <%# Eval("TimeZone")%>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small>hourly offset from GMT, example: ET Eastern Time UTC -5:00 / -4:00</small>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepSMTP" Title="Email/SMS/Storage" ValidationGroup="SMTP" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h4 style="margin: 0">
                                                Email Outgoing Settings</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton4" runat="server" ToolTip="Update changes to Company SMTP" CommandName="Edit" CausesValidation="False"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                        <i class="fas fa-pen"></i> Edit
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>

                                    <table class="table-sm">
                                        <tr>
                                            <td style="width: 250px">Outgoing Email From:
                                            </td>
                                            <td>
                                                <asp:Label ID="labelwebEmailUserNameTextBox" runat="server" Text='<%# Eval("webEmailUserName")%>' ToolTip="Outgoing account name (username@company_domain.com)"></asp:Label>

                                            </td>
                                        </tr>

                                        <tr>
                                            <td>SMTP Server:
                                            </td>
                                            <td>
                                                <asp:Label ID="webEmailSMTPLabel" runat="server" Text='<%# Eval("webEmailSMTP")%>' ToolTip="Outgoing mail SMTP (smtp.company_domain.com)" />

                                            </td>
                                        </tr>
                                        <tr>
                                            <td>SMTP TLS/SSL Required:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox655" runat="server" Checked='<%# Eval("webEmailEnableSsl")%>' Enabled="false" />

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
                                            <td>SMTP Use Default Credentials:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox13" runat="server" Checked='<%# Eval("webUseDefaultCredentials")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:LinkButton ID="btnEmail" runat="server" ToolTip="Send Test Email" CommandName="SendTestEmail" CausesValidation="False"
                                                    CssClass="btn btn-primary" UseSubmitBehavior="false">
                                                        <i class="far fa-envelope"></i> Test Email
                                                </asp:LinkButton>

                                            </td>
                                        </tr>

                                    </table>

                                     <table style="width: 98%">
                                        <tr>
                                            <td colspan="2">
                                                <h4 style="margin: 0">
                                                SMS Setting</h3>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 250px">Active/Inactive:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox15" runat="server" Checked='<%# Eval("Active")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:LinkButton ID="btnSMS" runat="server" ToolTip="Send Test SMS" CommandName="SendTestSMS" CausesValidation="False" CssClass="btn btn-primary" UseSubmitBehavior="false"
                                                    Visible='<%# Eval("Active")%>'>
                                                        <i class="fas fa-sms"></i> Test SMS
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>


                                    <table style="width: 98%">
                                        <tr>
                                            <td colspan="2">
                                                <h4 style="margin: 0">
                                                Storage Info</h3>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 250px">Number of Files:
                                            </td>
                                            <td>
                                                <%# Eval("StorageFiles")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Storage Occupied:</td>
                                            <td>
                                                <%#  LocalAPI.FormatByteSize(Eval("StorageSize"))%>
                                            </td>
                                        </tr>
                                    </table>


                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepNotifications" Title="Notifications" ValidationGroup="Notifications" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h4 style="margin: 0">
                                                Notification Alerts</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton5" runat="server" ToolTip="Update changes to Company Alerts" CommandName="Edit" CausesValidation="False"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                        <i class="fas fa-pen"></i> Edit
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="table-sm">
                                        <tr>
                                            <td width="160px">Job Profit:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="Notification_invoiceemittedCheckBox" runat="server" Checked='<%# Eval("Notification_JobProfit")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Proposal Accepted/Declined:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("Notification_AceptedProposal")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>RFP Accepted/Declined:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox5" runat="server" Checked='<%# Eval("Notification_AceptedRFP")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Invoice Emitted:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox2" runat="server" Checked='<%# Eval("Notification_EmittedInvoice")%>' Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Invoice Collected:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox3" runat="server" Checked='<%# Eval("Notification_CollectedInvoice")%>' Enabled="false" />
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
                                        <table class="table-sm">
                                            <tr>
                                                <td width="160px">Activate SMS:
                                                </td>
                                                <td>
                                                    <telerik:RadCheckBox ID="CheckBox6" runat="server" Checked='<%# Bind("SMSservice")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>

                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepPayPal" Title="PayPal " ValidationGroup="PayPal" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h4 style="margin: 0">
                                                PayPal Setting</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton6" runat="server" ToolTip="Update changes to Company PayPal" CommandName="Edit" CausesValidation="False"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                        <i class="fas fa-pen"></i> Edit
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
                                                <h4 style="margin: 0">
                                                Collection Attorney Firm</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton13" runat="server" ToolTip="Update changes to Company PayPal" CommandName="Edit" CausesValidation="False"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                        <i class="fas fa-pen"></i> Edit
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <p>
                                        Profile of the law firm that processes client files that go into debt collection status and temporarily lock their accounts.
                                    </p>
                                    <table class="table-sm">
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
                                    <h4 style="margin: 0">Logo & Signature Setting</h3>
                                    <table class="table-sm" style="width:100%">
                                        <tr>
                                            <td style="width: 60%; vertical-align: top">
                                                <h3>Company Logo</h3>
                                                <small>
                                                    The Company Logo is used in the header of client communication pages, such as Proposal, Invoices, Statements
                                                </small>
                                                <telerik:RadGrid runat="server" AutoGenerateColumns="False" ID="RadGridLogo" DataSourceID="SqlDataSourceLogo" AllowAutomaticUpdates="True" AllowAutomaticDeletes="true">
                                                    <MasterTableView DataKeyNames="companyId" DataSourceID="SqlDataSourceLogo">
                                                        <Columns>
                                                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                                                HeaderText="Edit" ItemStyle-Width="20px" HeaderStyle-Width="20px">
                                                            </telerik:GridEditCommandColumn>
                                                            <telerik:GridBinaryImageColumn DataField="shortLogo" HeaderText="Proposal/Invoice Logo" UniqueName="shortLogo"
                                                                ImageAlign="NotSet" ImageWidth="180px" ImageHeight="170px" ResizeMode="Fit">
                                                            </telerik:GridBinaryImageColumn>
                                                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Remove Company Logo Image?" ConfirmTitle="Delete"
                                                                ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                                                                HeaderText="Remove" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px"
                                                                ItemStyle-HorizontalAlign="Center">
                                                            </telerik:GridButtonColumn>
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
                                                <small>
                                                    Signature is used in Proposals sent to clients
                                                </small>
                                                <telerik:RadGrid runat="server" AutoGenerateColumns="False" ID="RadGridSign" DataSourceID="SqlDataSourceSign" AllowAutomaticUpdates="True" AllowAutomaticDeletes="true">
                                                    <MasterTableView DataKeyNames="companyId" DataSourceID="SqlDataSourceSign">
                                                        <Columns>
                                                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderText="Edit"
                                                                ItemStyle-Width="20px" HeaderStyle-Width="20px">
                                                            </telerik:GridEditCommandColumn>
                                                            <telerik:GridBinaryImageColumn DataField="imgSign" HeaderText="Proposal Signature" UniqueName="imgSign"
                                                                ImageAlign="NotSet" ImageHeight="180px" ImageWidth="180px" ResizeMode="Fit">
                                                            </telerik:GridBinaryImageColumn>
                                                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Remove Company Signature Pictures?" ConfirmTitle="Delete"
                                                                ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                                                                HeaderText="Remove" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px"
                                                                ItemStyle-HorizontalAlign="Center">
                                                            </telerik:GridButtonColumn>
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

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepQuickBook" Title="QuickBooks" ValidationGroup="QuickBooks" StepType="Step" CssClass='<%# IIf(LocalAPI.IsQuickBookModule(lblCompanyId.Text), "wizardStep", "wizardStepHidden") %>'>
                                    <div class="pasconcept-bar">
                                        <table class="table-sm" style="width:100%">
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
                                                    <telerik:RadCheckBox ID="ckhSynchronizeEmployeesRO" runat="server" Checked='<%# Eval("qbSynchronizeEmployees")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; padding-right: 5px">Synchronize Employees Time:
                                                </td>
                                                <td>
                                                    <telerik:RadCheckBox ID="chkqbSynchronizeEmployeesTimeRO" runat="server" Checked='<%# Eval("qbSynchronizeEmployeesTime")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; padding-right: 5px">Synchronize Employee Vacations:
                                                </td>
                                                <td>
                                                    <telerik:RadCheckBox ID="chkqbSynchronizeEmployeesVacationRO" runat="server" Checked='<%# Eval("qbSynchronizeEmployeesVacation")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; padding-right: 5px">Synchronize Employees Personal Time:
                                                </td>
                                                <td>
                                                    <telerik:RadCheckBox ID="chkqbSynchronizeEmployeesPersonalRO" runat="server" Checked='<%# Eval("qbSynchronizeEmployeesPersonal")%>' Enabled="false" />
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
                                                    <telerik:RadCheckBox ID="chkqbSynchronizeClientsRO" runat="server" Checked='<%# Eval("qbSynchronizeClients")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 250px; text-align: right; padding-right: 5px">Online Payment:
                                                </td>
                                                <td>
                                                    <telerik:RadCheckBox ID="CheckBox9" runat="server" Checked='<%# Eval("qbOnlinePayment")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; padding-right: 5px">Synchronize Invoices:
                                                </td>
                                                <td>
                                                    <telerik:RadCheckBox ID="CheckBox11" runat="server" Checked='<%# Eval("qbSynchronizeInvoices")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                        </table>
                                        <br />

                                    </div>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStep5" Title="Add-Ons and Integration" ValidationGroup="Add-Ons" StepType="Step" CssClass='<%# IIf(LocalAPI.IsQuickBookModule(lblCompanyId.Text), "wizardStep", "wizardStepHidden") %>'>
                                    <div class="pasconcept-bar" style="width: 98%">
                                        <h3>PASconcept Add-Ons and  Integrations</h3>
                                        <br />
                                        <table class="table-sm">
                                            <tr>
                                                <td colspan="3">
                                                    <hr />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width:20px">
                                                    <telerik:RadCheckBox ID="chkazureStorage" runat="server" Checked='<%# Eval("azureStorage")%>' Enabled="false" />
                                                </td>
                                                <td style="width:400px">
                                                    <h4>PASconcept Cloud Files Storage</h4>
                                                </td>
                                                <td>
                                                    Activating this Add-on allows PASconcept users to upload files directly to Jobs, Clients and Proposals.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadCheckBox ID="chkbillingModule" runat="server" Checked='<%# Eval("billingModule")%>' Enabled="false" />
                                                </td>
                                                <td>
                                                    <h4>PASconcept Additional Billing Options</h4>
                                                </td>
                                                <td>
                                                    Activating this Add-on opens PASconcept to include additional billing options such as periodic billing.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <hr />
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <telerik:RadCheckBox ID="chkPayPal" runat="server" Checked='<%# Eval("PayPalModule")%>' Enabled="false" />
                                                </td>
                                                <td>
                                                    <h4>PayPal Integration</h4>
                                                </td>
                                                <td>
                                                    Activating the PayPal integrations allows your clients to process payment for invoices and statements though a 'Pay Here' button. Any payments made are tracked in PASconcept.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadCheckBox ID="chkqbModule" runat="server" Checked='<%# Eval("qbModule")%>' Enabled="false" />
                                                </td>
                                                <td>
                                                    <h4>Quick Book Integration</h4>
                                                </td>
                                                <td>
                                                    Activating this integration allows for an exchange of information between PASconcept and QuickBooks. This exchange of information includes Clients, Employees, Invoices and Payments.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadCheckBox ID="chkSMSservice" runat="server" Checked='<%# Eval("SMSservice")%>' Enabled="false" />
                                                </td>
                                                <td>
                                                    <h4>Twillio Integration</h4>
                                                </td>
                                                <td>
                                                    Activating this integration allows for PASconcept to sent messages via SMS to Clients and Users.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadCheckBox ID="RadCheckBox1" runat="server" Checked='<%# Eval("IsEbilityModule")%>' Enabled="false" />
                                                </td>
                                                <td>
                                                    <h4>eBillity Integrations</h4>
                                                </td>
                                                <td>
                                                    Activating this integration allows for an exchange of information between PASconcept and eBillity. This exchange of information includes Clients, Employees, Projects, Time Entires and Time Activities.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <hr />
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <small>To activate any of the above integrations or add-ons please contact Matthew Mur at <a href="mailto:matt@axzes.com" title="Mail to">matt@axzes.com</a></small>


                                        
                                    </div>
                                </telerik:RadWizardStep>
                            </WizardSteps>
                        </telerik:RadWizard>

                    </ItemTemplate>

                    <EditItemTemplate>
                        <telerik:RadWizard ID="RadWizard2" runat="server" Height="750px" DisplayCancelButton="false"
                            RenderMode="Lightweight" Skin="Silk" DisplayNavigationButtons="false" DisplayProgressBar="false">
                            <WizardSteps>
                                <telerik:RadWizardStep runat="server" ID="RadWizardStepsCompanyInfo2" Title="Company Information" ValidationGroup="Company" StepType="Start">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h4 style="margin: 0">
                                                Company Information</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton2" runat="server" ToolTip="Update changes to Company Profile" CommandName="Update" CausesValidation="True"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                     Update
                                                </asp:LinkButton>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="LinkButton3" runat="server" ToolTip="Cancel changes" CommandName="Cancel" CausesValidation="False"
                                                    CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                                    Cancel
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="table-sm">
                                        <tr>
                                            <td style="width:250px; text-align:right">Company Name:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Administrator Name:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="ContactTextBox" runat="server" Text='<%# Bind("Contact")%>'
                                                    Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Administrator Email:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email")%>' MaxLength="128" Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Company Type:
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
                                            <td style="text-align:right">Address Line 1:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address")%>'
                                                    Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Address Line 2:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox1" runat="server" Text='<%# Bind("Address2")%>'
                                                    Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">City:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="CityTextBox" runat="server" Text='<%# Bind("City")%>' Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">State:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="StateTextBox" runat="server" Text='<%# Bind("State")%>' Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Zip Code:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="ZipCodeTextBox" runat="server" Text='<%# Bind("ZipCode") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Telephone:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Cell Phone:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="MovileTextBox" runat="server" Text='<%# Bind("Movile")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Fax:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="FaxTextBox" runat="server" Text='<%# Bind("Fax")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Website:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="webTextBox" runat="server" Text='<%# Bind("web")%>' Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Accounting Email:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtAccountantEmail" runat="server" Text='<%# Bind("AccountantEmail")%>' MaxLength="128" Width="500px" ToolTip="This email will receive BCC copies of invoices" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Human Resources Manager Name:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox4" runat="server" Text='<%# Bind("HR_Name")%>' MaxLength="80" Width="500px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">Human Resources Manager Email:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox5" runat="server" Text='<%# Bind("HR_Email")%>' MaxLength="128" Width="500px" EmptyMessage="Email to send Time off Request" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right">HR Pay Frequency:
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="cboHR_payfrequency" runat="server" Width="300px" SelectedValue='<%# Bind("HR_payfrequencyId")%>'>
                                                    <Items>
                                                        <telerik:RadComboBoxItem runat="server" Text="Not defined" Value="0" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Every Week" Value="7" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Every Other Week" Value="14" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Every Month" Value="1" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td style="text-align:right">Language:</td>
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
                                            <td style="text-align:right">Time Zone:</td>
                                            <td>
                                                <telerik:RadNumericTextBox ID="RadTextBox15" runat="server" Text='<%# Bind("TimeZone")%>' Width="150px" />
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small>hourly offset from GMT, example: ET Eastern Time UTC -5:00 / -4:00</small>
                                            </td>
                                        </tr>

                                    </table>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepSMTP2" Title="SMTP Settings" ValidationGroup="SMTP" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h4 style="margin: 0">
                                                Email SMTP Outgoing Settings</h4>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton7" runat="server" ToolTip="Update changes to Company Email SMTP Settings" CommandName="Update" CausesValidation="True"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                     Update
                                                </asp:LinkButton>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="LinkButton8" runat="server" ToolTip="Cancel changes" CommandName="Cancel" CausesValidation="False"
                                                    CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                                    Cancel
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="table-sm">
                                        <tr>
                                            <td style="width: 250px">Outgoing Email From:
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
                                                <telerik:RadCheckBox ID="CheckBox6jj" runat="server" Checked='<%# Bind("webEmailEnableSsl")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>SMTP Use Default Credentials:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox14" runat="server" Checked='<%# Bind("webUseDefaultCredentials")%>' />
                                            </td>
                                        </tr>
                                    </table>

                                     <table class="table-sm">
                                        <tr>
                                            <td colspan="2">
                                                <hr />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <h4>
                                                Twilio SMS Settings (https://www.twilio.com/console)</h4>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Active:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox16" runat="server" Checked='<%# Bind("Active")%>' />
                                            </td>
                                        </tr>
                                         <tr>
                                            <td style="width: 250px">Account SID:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox12" runat="server" Text='<%# Bind("accountSid")%>' 
                                                    Width="500px" EmptyMessage="" />
                                            </td>
                                        </tr>
                                         <tr>
                                            <td>Auth Token:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox13" runat="server" Text='<%# Bind("authToken")%>' 
                                                    Width="500px"  />
                                            </td>
                                        </tr>
                                         <tr>
                                            <td>Twilio Phone:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="RadTextBox14" runat="server" Text='<%# Bind("TwilioPhone")%>' 
                                                    Width="500px"  />
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepNotifications2" Title="Notifications" ValidationGroup="Notifications" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h4 style="margin: 0">
                                                Notification Alerts</h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton9" runat="server" ToolTip="Update changes to Company Notification Alerts" CommandName="Update" CausesValidation="True"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                     Update
                                                </asp:LinkButton>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="LinkButton10" runat="server" ToolTip="Cancel changes" CommandName="Cancel" CausesValidation="False"
                                                    CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                                    Cancel
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="table-sm">
                                        <tr>
                                            <td width="180px">Job Profit:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox11_EDIT" runat="server" Checked='<%# Bind("Notification_JobProfit")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Proposal Accepted/Declined:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox1_EDIT" runat="server" Checked='<%# Bind("Notification_AceptedProposal")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>RFP Accepted/Declined:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox4" runat="server" Checked='<%# Bind("Notification_AceptedRFP")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Invoice Emitted:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox2_EDIT" runat="server" Checked='<%# Bind("Notification_EmittedInvoice")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Invoice Collected:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox3_EDIT" runat="server" Checked='<%# Bind("Notification_CollectedInvoice")%>' />
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
                                                <telerik:RadCheckBox ID="CheckBoxSMSservice" runat="server" Checked='<%# Bind("SMSservice")%>' />
                                            </td>
                                        </tr>

                                    </table>
                                </telerik:RadWizardStep>

                                <telerik:RadWizardStep runat="server" ID="RadWizardStepPayPal2" Title="PayPal " ValidationGroup="PayPal" StepType="Step">
                                    <table style="width: 98%">
                                        <tr>
                                            <td>
                                                <h4 style="margin: 0">
                                                    <h3>PayPal Setting</h3>
                                                </h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton11" runat="server" ToolTip="Update changes to Company <h3></h3>" CommandName="Update" CausesValidation="True"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                     Update
                                                </asp:LinkButton>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="LinkButton12" runat="server" ToolTip="Cancel changes" CommandName="Cancel" CausesValidation="False"
                                                    CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                                    Cancel
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="table-sm" style="width: 100%">
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
                                                <h4 style="margin: 0">
                                                    <h3>Collection Setting</h3>
                                                </h3>
                                            </td>
                                            <td style="text-align: right">
                                                <asp:LinkButton ID="LinkButton14" runat="server" ToolTip="Update changes to Company" CommandName="Update" CausesValidation="True"
                                                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                     Update
                                                </asp:LinkButton>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:LinkButton ID="LinkButton15" runat="server" ToolTip="Cancel changes" CommandName="Cancel" CausesValidation="False"
                                                    CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                                    Cancel
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="table-sm" style="width: 100%">
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
                                    <table class="table-sm">
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
                                                <telerik:RadCheckBox ID="ckhSynchronizeEmployees" runat="server" Checked='<%# Bind("qbSynchronizeEmployees")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 5px">Synchronize Employees Time:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="chkqbSynchronizeEmployeesTime" runat="server" Checked='<%# Bind("qbSynchronizeEmployeesTime")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 5px">Synchronize Employee Vacations:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="chkqbSynchronizeEmployeesVacationRO" runat="server" Checked='<%# Bind("qbSynchronizeEmployeesVacation")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 5px">Synchronize Employees Personal Time:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="chkqbSynchronizeEmployeesPersonalRO" runat="server" Checked='<%# Bind("qbSynchronizeEmployeesPersonal")%>' />
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
                                                <telerik:RadCheckBox ID="CheckBox7" runat="server" Checked='<%# Bind("qbSynchronizeClients")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 260px; text-align: right; padding-right: 5px">Online Payment:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox8" runat="server" Checked='<%# Bind("qbOnlinePayment")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 5px">Synchronize Invoices:
                                            </td>
                                            <td>
                                                <telerik:RadCheckBox ID="CheckBox10" runat="server" Checked='<%# Bind("qbSynchronizeInvoices")%>' />
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadWizardStep>

                            </WizardSteps>
                        </telerik:RadWizard>

                    </EditItemTemplate>

                </asp:FormView>

       
    </div>

    <asp:SqlDataSource ID="SqlDataSourceLogo" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT companyId, shortLogo FROM [Company] WHERE ([companyId] = @companyId)"
        UpdateCommand="UPDATE [Company] SET [shortLogo] = @shortLogo WHERE [companyId] = @companyId" 
        DeleteCommand="UPDATE [Company] SET [shortLogo] = Null WHERE [companyId] = @companyId" 
        ProviderName="<%$ ConnectionStrings:cnnProjectsAccounting.ProviderName %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="shortLogo" DbType="Binary" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourceSign" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT companyId, imgSign  FROM [Company] WHERE ([companyId] = @companyId)"
        UpdateCommand="UPDATE [Company] SET [imgSign] = @imgSign  WHERE [companyId] = @companyId"
        DeleteCommand="UPDATE [Company] SET [imgSign] = Null WHERE [companyId] = @companyId" 
        ProviderName="<%$ ConnectionStrings:cnnProjectsAccounting.ProviderName %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="imgSign" DbType="Binary" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CompanyProfile_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="CompanyProfile_v21_UPDATE" UpdateCommandType="StoredProcedure">
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

            <asp:Parameter Name="Active" />
            <asp:Parameter Name="accountSid" />
            <asp:Parameter Name="authToken" />
            <asp:Parameter Name="TwilioPhone" />

            <asp:Parameter Name="TimeZone" />
            <asp:Parameter Name="HR_payfrequencyId" />

            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Company_types ORDER BY Name"></asp:SqlDataSource>
    



    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="btnActiveTab" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>
