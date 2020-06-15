<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="CreateCompany.aspx.vb" Inherits="pasconcept20.CreateCompany" Async="true" %>

<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <h2 style="margin: 10px">Cretate New Company Wizard</h2>
        <asp:Label ID="lblMsg" runat="server" CssClass="Error"></asp:Label>
    </div>
    <div style="height: 750px">
        <telerik:RadWizard ID="RadWizard1" runat="server" Height="650px" Width="100%" BorderColor="LightBlue" BorderStyle="Solid" RenderMode="Lightweight" Skin="Material">
            <WizardSteps>
                <telerik:RadWizardStep ID="RadWizardStep1" Title="Identification" runat="server" StepType="Start" ValidationGroup="accountInfo" CausesValidation="true">
                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td style="width: 180px; text-align: right">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCompanyName" EnableClientScript="true" ValidationGroup="accountInfo" ErrorMessage="Name is required" Text="*" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                Company Name:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtCompanyName" runat="server" ValidationGroup="accountInfo" Width="90%" MaxLength="80"></telerik:RadTextBox>
                            </td>
                        </tr>

                        <tr>
                            <td style="text-align: right">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtContact"
                                    EnableClientScript="true" ValidationGroup="accountInfo" ErrorMessage="Representative is required" Text="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                Representative:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtContact" runat="server" ValidationGroup="accountInfo" Width="90%" MaxLength="80"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtEmail" EnableClientScript="true" ValidationGroup="accountInfo" ErrorMessage="Email is required" Text="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                Email:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtEmail" runat="server" ValidationGroup="accountInfo" Width="90%" MaxLength="128"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Select Version...)" Operator="NotEqual" ControlToValidate="cboVersion" ErrorMessage="Define Version" Text="(*)" SetFocusOnError="true" ValidationGroup="accountInfo"></asp:CompareValidator>
                                Version:
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboVersion" runat="server" DataSourceID="SqlDataSourceVersion" DataTextField="Name" DataValueField="Id" Width="90%">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Select Type...)" Operator="NotEqual" ControlToValidate="cboType" ErrorMessage="Define Type" Text="*" SetFocusOnError="true" ValidationGroup="accountInfo"></asp:CompareValidator>
                                Company Type:
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceTypes"
                                    DataTextField="Name" DataValueField="Id" Width="90%" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="(Select Type...)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Address Line 1:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtAddressLine1" runat="server" ValidationGroup="accountInfo" Width="90%" MaxLength="255"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Address Line 2:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtAddressLine2" runat="server" ValidationGroup="accountInfo" Width="90%" MaxLength="255"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">City:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtCity" runat="server" ValidationGroup="accountInfo" Width="90%" MaxLength="50"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">State:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtState" runat="server" ValidationGroup="accountInfo" Width="90%" MaxLength="50"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Zip Code:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtZipCode" runat="server" ValidationGroup="accountInfo" Width="160px" MaxLength="25"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Telephone:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtTelephone" runat="server" ValidationGroup="accountInfo" Width="160px" MaxLength="30"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Cell Phone:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtCellPhone" runat="server" ValidationGroup="accountInfo" Width="160px" MaxLength="30"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Fax:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtFax" runat="server" ValidationGroup="accountInfo" Width="160px" MaxLength="30"></telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>
                    <div>
                        <asp:ValidationSummary ID="ValidationSummaryaccountInfo" Font-Size="X-Small" runat="server" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="accountInfo" />
                    </div>
                </telerik:RadWizardStep>

                <telerik:RadWizardStep Title="Billing Plan" runat="server" StepType="Step" ValidationGroup="billingInfo" CausesValidation="true">
                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td style="text-align: right; width: 180px">Select Billing Plan:
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboPlans" runat="server" DataSourceID="SqlDataSourceBillingPlans" DataTextField="Name" DataValueField="Id" AutoPostBack="true" Width="90%">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>

                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Name" DataSourceID="SqlDataSourceBillingPlan"
                        Width="100%">
                        <ItemTemplate>

                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="text-align: right; width: 180px">
                                        Price/Period:
                                    </td>
                                    <td style="text-align: left; ">
                                        <%# Eval("Price","{0:C2}") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">
                                        Maximum number of users:
                                    </td>
                                    <td style="text-align: left; ">

                                        <%# Eval("MaxUsers") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">
                                        Billing Period:
                                    </td>
                                    <td style="text-align: left; ">
                                        <%# Eval("BillingPeriod") %>
                                    </td>
                                </tr>
                            </table>

                        </ItemTemplate>
                    </asp:FormView>
                    <div>
                        <asp:ValidationSummary ID="ValidationSummary1" Font-Size="X-Small" runat="server" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="billingInfo" />
                    </div>
                </telerik:RadWizardStep>

                <telerik:RadWizardStep runat="server" StepType="Finish" Title="Finish">

                    <table class="table table-condensed" style="width: 100%">
                        <tr>
                            <td>
                                <h3>Send Emails with PASconcept Notifications? </h3>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 100px">
                                <telerik:RadCheckBox runat="server" ID="chkSendAdminCredentials" Checked="true" Font-Size="Large" Text="Send Emails with Administartor Credentials" />
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 100px">
                                <telerik:RadCheckBox runat="server" ID="chkSendGetStarted" Checked="true" Font-Size="Large" Text="Send Emails with Help to Get Started PASconcept" />
                            </td>
                        </tr>
                    </table>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" StepType="Complete" Title="Complete">
                    <h2>Complete</h2>

                    <asp:Label ID="lblCompanyRegistred" runat="server"></asp:Label><br />
                    <asp:Label ID="lblCredentials" runat="server"></asp:Label><br />
                    <asp:Label ID="lblGetStartedEmail" runat="server"></asp:Label><br />

                    <table class="table table-condensed" style="width: 100%">
                        <tr>
                            <td>
                                <h4>2.- Bind Company to Axzes Client</h4>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: center">
                                <telerik:RadComboBox ID="cboClient" runat="server" DataSourceID="SqlDataSourceClientes" AutoPostBack="true"
                                    DataTextField="Name" DataValueField="Id" Width="400px" AppendDataBoundItems="True" ZIndex="50001" Height="350px"
                                    MarkFirstMatch="True" Filter="Contains">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(Create NEW Axzes Client...)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h4>2.- Bind Company to Axzes Job</h4>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: center">
                                <telerik:RadComboBox ID="cboJob" runat="server" DataSourceID="SqlDataSourceJobs"
                                    DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="True" ZIndex="50001" Height="350px"
                                    MarkFirstMatch="True" Filter="Contains">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(Create NEW Axzes Job...)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>

                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: center">
                                <asp:LinkButton ID="btnBindCompanyToAxzes" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false">
                                    Bind Company to Axzes
                                </asp:LinkButton>
                                <br />
                                <asp:Label ID="lblBinding" runat="server" ForeColor="Green"></asp:Label><br />
                                <hr />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: center">
                                <asp:LinkButton ID="btnGoCompanyList" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" Visible="false">
                                    Goto Company List
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>
    </div>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="Company_NEW_Extended" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:cnnProjectsAccounting.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="txtCompanyName" Name="Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboType" Name="Type" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtContact" Name="Contact" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCellPhone" Name="Phone" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtAddressLine1" Name="Address" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCity" Name="City" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtState" Name="State" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtZipCode" Name="ZipCode" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCellPhone" Name="Movile" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtFax" Name="Fax" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboPlans" Name="Billing_plan" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtAddressLine2" Name="Address2" PropertyName="Text" Type="String" />
            <asp:Parameter Name="webEmailSMTP" Type="String" />
            <asp:Parameter Name="webEmailUserName" Type="String" />
            <asp:Parameter Name="webEmailPassword" Type="String" />
            <asp:Parameter Name="webEmailEnableSsl" Type="Boolean" />
            <asp:Parameter Name="webEmailPort" Type="Int16" />
            <asp:Parameter Name="webEmailProfitWarningCC" Type="String" />
            <asp:Parameter Name="webEmailProfitWarningCCO" Type="String" />
            <asp:Parameter Name="web" Type="String" />
            <asp:Parameter Name="EmailSign" Type="String" />
            <asp:Parameter Name="EmailSign2" Type="String" />
            <asp:ControlParameter ControlID="cboVersion" Name="Version" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="OUT_companylId" Type="Int32" Direction="InputOutput" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_types] ORDER BY [Name]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceVersion" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM sys_Versiones ORDER BY Id"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceBillingPlans" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM Billing_plans where isnull(Inactive,0)=0 ORDER BY billing_period_Id, Id"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceBillingPlan" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Billing_plans].[Name], billing_baseprice as Price, billing_baseusers as MaxUsers, [Billing_periods].Name As BillingPeriod FROM [Billing_plans] inner join [Billing_periods] ON [Billing_plans].[billing_period_Id]=[Billing_periods].Id WHERE [Billing_plans].[Id]=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboPlans" Name="Id" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]+' [' + isnull(Company,'...') + ']' As Name FROM Clients WHERE companyId=260973 ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], Code+'  '+Job Name FROM Jobs WHERE companyId=260973 and Client=@clientId and Status in(0,2) ORDER BY Code DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboClient" Name="clientId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>

</asp:Content>

