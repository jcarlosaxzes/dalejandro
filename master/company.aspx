<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="company.aspx.vb" Inherits="pasconcept20.company1" %>



<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">

        <table class="table-condensed" style="width: 100%">
            <tr>
                <td colspan="2">
                    <telerik:RadToolBar ID="RadToolBar1" runat="server">
                        <Items>
                            <telerik:RadToolBarButton runat="server" Text="Users">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton runat="server" Text="Billing">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton runat="server" Text="Analytics">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>

            </tr>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete Company" CommandArgument='<%# Eval("Tag")%>' Primary="true">
                        <ConfirmSettings ConfirmText="Are you sure to Delete Company and all related information?" Title="Delete Company" Width="300" UseRadConfirm="true" />
                    </telerik:RadButton>

                </td>
                <td style="text-align: center">
                    <asp:LinkButton ID="btnSentContactAgain" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" Text="Get Started Email" ToolTip="Send Email with Help to Get Started with PASconcept!">
                    </asp:LinkButton>
                    <br />
                    <asp:Label ID="lblGetStartedEmailDate" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </div>

    <div class="row">

        <table class="table-condensed" style="width: 100%">
            <tr>
                <td></td>
            </tr>
            <tr>
                <td>Company properties
                </td>
            </tr>
            <tr>
                <td>
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="companyId" DataSourceID="SqlDataSource1"
                        Width="100%">
                        <EditItemTemplate>
                            <table class="table-condensed" style="width: 100%">
                                <tr>
                                    <td style="width=200px">Company ID:
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
                                    <td>Version:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboVersion" runat="server" DataSourceID="SqlDataSourceVersion"
                                            DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("Version") %>'
                                            Width="150px">
                                        </telerik:RadComboBox>
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
                                    <td>Billing Plan:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboBilling" runat="server" DataSourceID="SqlDataSourceBillingPlas"
                                            DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("Billing_plan") %>'
                                            Width="500px" Height="300px" AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="(Select Billing Plan..." Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td>Billing Expiracion Date:
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DbSelectedDate='<%# Bind("billingExpirationDate")%>'
                                            MaxDate="01/01/2099 0:00:00" MinDate="01/01/2017 0:00:00">
                                        </telerik:RadDatePicker>
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
                                        <telerik:RadTextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone")%>' Width="200px" />
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
                                        <telerik:RadTextBox ID="FaxTextBox" runat="server" Text='<%# Bind("Fax")%>' Width="200px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Email:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email")%>' Width="500px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Is Inactive:
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="InactiveCheckBox" runat="server" Checked='<%# Bind("Inactive") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Email SMTP:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="webEmailSMTPTextBox" runat="server" Text='<%# Bind("webEmailSMTP")%>'
                                            Width="500px" EmptyMessage="Outgoing mail SMTP (smtp.company_domain.com)" MaxLength="80" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Email for Profit Warning:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="webEmailProfitWarningCCTextBox" EmptyMessage="Email that receive System Profit Warning" runat="server" Text='<%# Bind("webEmailProfitWarningCC")%>'
                                            Width="500px" MaxLength="128" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Company Website:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="webTextBox" runat="server" Text='<%# Bind("web")%>' Width="500px" MaxLength="128" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Email Signature 1:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="EmailSignTextBox" runat="server" Text='<%# Bind("EmailSign")%>'
                                            Width="500px" EmptyMessage="Outgoing mail signature Line 1 (Robert Clinton)" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Email Signature 2:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="EmailSign2TextBox" runat="server" Text='<%# Bind("EmailSign2")%>'
                                            Width="500px" EmptyMessage="Outgoing mail signature Line 2 (President)" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>SMS service:
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("SMSservice")%>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>SMS Api ID:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox2" runat="server" Text='<%# Bind("SMS_api_id")%>' />
                                        <a href="https://central.clickatell.com/index" target="_blank">Clic to Login clickatell, username:axzes.com, Client ID: PJEY04 </a>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <telerik:RadButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                Text="Update" />
                            &nbsp;<telerik:RadButton ID="UpdateCancelButton" runat="server" CausesValidation="False"
                                CommandName="Cancel" Text="Cancel" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit"
                                Text="Edit Company Properties" />
                            <br />
                            <table class="table-condensed" style="width: 100%">
                                <tr>
                                    <td width="800px" valign="top">
                                        <table class="table-condensed" style="width: 100%">
                                            <tr>
                                                <td style="width: 200px">Company ID:
                                                </td>
                                                <td>
                                                    <asp:Label ID="companyIdLabel" runat="server" Text='<%# Eval("companyId") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Company Name:
                                                </td>
                                                <td>
                                                    <asp:Label ID="NameLabel0" runat="server" Text='<%# Bind("Name") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Version:
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("VersionName") %>' />
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
                                                <td>Billing Plan:
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("PlanName") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Billing Expiracion Date:
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("billingExpirationDate","{0:d}") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Representative:
                                                </td>
                                                <td>
                                                    <asp:Label ID="ContactLabel" runat="server" Text='<%# Bind("Contact") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Address Line 1:
                                                </td>
                                                <td>
                                                    <asp:Label ID="AddressLabel" runat="server" Text='<%# Bind("Address") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Address Line 2:
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Address2") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>City:
                                                </td>
                                                <td>
                                                    <asp:Label ID="CityLabel" runat="server" Text='<%# Bind("City") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>State:
                                                </td>
                                                <td>
                                                    <asp:Label ID="StateLabel" runat="server" Text='<%# Bind("State") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Zip Code:
                                                </td>
                                                <td>
                                                    <asp:Label ID="ZipCodeLabel" runat="server" Text='<%# Bind("ZipCode") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Telephone:
                                                </td>
                                                <td>
                                                    <asp:Label ID="PhoneLabel" runat="server" Text='<%# Bind("Phone") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Cell Phone:
                                                </td>
                                                <td>
                                                    <asp:Label ID="MovileLabel" runat="server" Text='<%# Bind("Movile") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Fax:
                                                </td>
                                                <td>
                                                    <asp:Label ID="FaxLabel" runat="server" Text='<%# Bind("Fax") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Email:
                                                </td>
                                                <td>
                                                    <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Start Date:
                                                </td>
                                                <td>
                                                    <asp:Label ID="StartDateLabel" runat="server" Text='<%# Bind("StartDate") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>End Date:
                                                </td>
                                                <td>
                                                    <asp:Label ID="EndDateLabel" runat="server" Text='<%# Bind("EndDate") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Is Inactive:
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="InactiveCheckBox" runat="server" Checked='<%# Bind("Inactive") %>'
                                                        Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Email SMTP:
                                                </td>
                                                <td>
                                                    <asp:Label ID="webEmailSMTPLabel" runat="server" Text='<%# Bind("webEmailSMTP") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Email for ProfitWarning:
                                                </td>
                                                <td>
                                                    <asp:Label ID="webEmailProfitWarningCCLabel" runat="server" Text='<%# Bind("webEmailProfitWarningCC") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Website:
                                                </td>
                                                <td>
                                                    <asp:Label ID="webLabel" runat="server" Text='<%# Bind("web") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Email Signature 1:
                                                </td>
                                                <td>
                                                    <asp:Label ID="EmailSignLabel" runat="server" Text='<%# Bind("EmailSign") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Email Signature 2:
                                                </td>
                                                <td>
                                                    <asp:Label ID="EmailSign2Label" runat="server" Text='<%# Bind("EmailSign2") %>' />
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>SMS service:
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("SMSservice")%>' Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>SMS Api ID:
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("SMS_api_id")%>' />
                                                </td>
                                            </tr>


                                        </table>
                                    </td>
                                    <td valign="top"><b>Users for role in the company</b>
                                        <br />
                                        <asp:FormView ID="FormView2" runat="server" DataSourceID="SqlDataSourceUserByCompany">
                                            <ItemTemplate>
                                                <table cellspacing="5" cellpadding="3">
                                                    <tr>
                                                        <td width="150px">Total Employees
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="EmployeesUsersLabel" runat="server" CssClass="NormalNegrita" Text='<%# Bind("EmployeesUsers")%>' />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="150px">Active Employees
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label3" runat="server" CssClass="NormalNegrita" Text='<%# Bind("EmployeesActive")%>' />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Clients
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="ClientUsersLabel" runat="server" CssClass="NormalNegrita" Text='<%# Bind("ClientUsers") %>' />
                                                        </td>
                                                        <tr>
                                                        </tr>
                                                        <td>Subconsultant
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="SubConsultansUsersLabel" runat="server" CssClass="NormalNegrita" Text='<%# Bind("SubConsultansUsers") %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:FormView>

                                    </td>
                                </tr>
                            </table>

                            <br />
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                Text="Edit Company Properties" />
                            &nbsp;&nbsp;
                        </ItemTemplate>
                    </asp:FormView>
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
            <tr>
                <td>Images properties
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid runat="server" AutoGenerateColumns="False" ID="RadGridImg" DataSourceID="SqlDataSourceImages"
                        GridLines="None" AllowAutomaticUpdates="True">
                        <MasterTableView DataKeyNames="companyId" DataSourceID="SqlDataSourceImages">
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                    <HeaderStyle Width="10px" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridBoundColumn DataField="companyId" HeaderText="companyId" SortExpression="companyId"
                                    UniqueName="companyId" ReadOnly="True" Display="False" HeaderStyle-Width="40px" ItemStyle-Width="40px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBinaryImageColumn DataField="imgSign" HeaderText="Sign" UniqueName="imgSign"
                                    ImageAlign="NotSet" ImageHeight="120px" ImageWidth="120px" ResizeMode="Fit" ItemStyle-Width="120px" HeaderStyle-Width="120px">
                                </telerik:GridBinaryImageColumn>
                                <telerik:GridBinaryImageColumn DataField="imgLogo" HeaderText="Logo" UniqueName="imgLogo"
                                    ImageAlign="NotSet" ImageHeight="120px" ResizeMode="Fit">
                                </telerik:GridBinaryImageColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn ButtonType="PushButton" />
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceImages" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT companyId, imgLogo, imgSign  FROM [Company] WHERE ([companyId] = @companyId)"
        UpdateCommand="UPDATE [Company] SET [imgLogo] = @imgLogo, [imgSign] = @imgSign  WHERE [companyId] = @companyId"
        ProviderName="<%$ ConnectionStrings:cnnProjectsAccounting.ProviderName %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="imgLogo" DbType="Binary" />
            <asp:Parameter Name="imgSign" DbType="Binary" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Company.companyId, Company.Name, Company.Version, Company.billingExpirationDate, isnull(Company.Type,0) as Type, Company.Contact, Company.Address, Company.Address2, Company.City, Company.State, Company.ZipCode, Company.Phone, Company.Movile, Company.Fax, Company.Email, Company.StartDate, Company.EndDate, Company.imgLogo, Company.imgSign, Company.Inactive, Company.webEmailSMTP, Company.webEmailProfitWarningCC, Company.AppTitle, Company.AppWebTitle, Company.FileWebPath, Company.ProposalScrPath, Company.ProposalDestPath, Company.web, Company.EmailSign, Company.EmailSign2, Company.Telerik_Skin, isnull(Company.Billing_plan,0) as Billing_plan, Company_types.Name AS TypeName, Billing_plans.Name AS PlanName, sys_Versiones.Name AS VersionName, isnull(SMSservice,0) as SMSservice, SMS_api_id FROM Company LEFT OUTER JOIN sys_Versiones ON Company.Version = sys_Versiones.Id LEFT OUTER JOIN Billing_plans ON Company.Billing_plan = Billing_plans.Id LEFT OUTER JOIN Company_types ON Company.Type = Company_types.Id WHERE (Company.companyId = @companyId)"
        UpdateCommand="UPDATE Company SET Name = @Name, Version = @Version, Type = @Type, billingExpirationDate=@billingExpirationDate,  Contact = @Contact, Address = @Address, Address2 = @Address2, City = @City, State = @State, ZipCode = @ZipCode, Phone = @Phone, Movile = @Movile, Fax = @Fax, Email = @Email, Inactive = @Inactive, webEmailSMTP = @webEmailSMTP, webEmailProfitWarningCC = @webEmailProfitWarningCC, web = @web, EmailSign = @EmailSign, EmailSign2 = @EmailSign2, Billing_plan = @Billing_plan, SMSservice = @SMSservice, SMS_api_id = @SMS_api_id WHERE (companyId = @companyId)"
        DeleteCommand="Company_DELETE" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Version" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="billingExpirationDate" />
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
            <asp:Parameter Name="Inactive" Type="Boolean" />
            <asp:Parameter Name="webEmailSMTP" Type="String" />
            <asp:Parameter Name="webEmailProfitWarningCC" Type="String" />
            <asp:Parameter Name="web" Type="String" />
            <asp:Parameter Name="EmailSign" Type="String" />
            <asp:Parameter Name="EmailSign2" Type="String" />
            <asp:Parameter Name="Billing_plan" />
            <asp:Parameter Name="SMSservice" />
            <asp:Parameter Name="SMS_api_id" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Company_types ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceBillingPlas" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Billing_plans ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceUserByCompany" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT dbo.EmployeesUsersByCompany(@companyId) AS EmployeesUsers, dbo.EmployeesActivesByCompany(@companyId) AS EmployeesActive, dbo.AdminUsersByCompany(@companyId) AS AdminUsers, dbo.ClientUsersByCompany(@companyId) As ClientUsers, dbo.SubConsultansUsersByCompany(@companyId) AS SubConsultansUsers">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceVersion" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM sys_Versiones ORDER BY Id"></asp:SqlDataSource>


    <asp:Label ID="lblMasterMail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

