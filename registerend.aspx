<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="registerend.aspx.vb" Inherits="pasconcept20.registerend" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Register End</title>
</head>
<body style="background-color: white; padding-top: 50px;">
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <table align="center" class="RegisterEnd">
            <tr>
                <td style="text-align: center">
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/logo.png" />
                </td>
            </tr>
            <tr>
                <td class="Titulo3" align="center">Company setup 
                </td>
            </tr>
            <tr>
                <td style="padding-left: 15px;padding-top:10px;text-align:center" class="Normal">
                    Please fill out the form below
                    <br />
                    <asp:Label ID="lblMsg" runat="server" CssClass="Error"></asp:Label>
                    <br />
                </td>
            </tr>
            <tr>
                <td style="text-align: left; padding-left: 50px;">
                    <table cellpadding="3" cellspacing="3">
                        <tr>
                            <td class="NormalNegrita">Billing Plan<br />
                                <telerik:RadComboBox ID="cboBillingPlan" runat="server" DataSourceID="SqlDataSourceBillingPlan" DataTextField="Name" DataValueField="Id" Width="400px" Skin="MetroTouch">
                                </telerik:RadComboBox>
                                <br />
                                You have 30 days trial version, regardless of the selected billing plan
                            </td>
                        </tr>
                        <tr>
                            <td class="NormalNegrita">Email<br />
                                <telerik:RadTextBox ID="txtEmail" runat="server" EmptyMessage="Type your Email" Resize="None" Width="400px" Enabled="false" ReadOnly="true" Skin="MetroTouch">
                                </telerik:RadTextBox>
                                &nbsp;
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtEmail" ValidationGroup="SubmitInfo"
                                    runat="server" ErrorMessage="(*)" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" 
                                    ToolTip="Valid Email Required">
                                </asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" ValidationGroup="SubmitInfo" ErrorMessage="(*)" Display="Dynamic"
                                     ToolTip="Field Required">

                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="NormalNegrita">Company Name<br />
                                <telerik:RadTextBox ID="txtCompanyName" runat="server" Width="400px" MaxLength="80" Skin="MetroTouch">
                                </telerik:RadTextBox>
                                &nbsp;
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtCompanyName" ValidationGroup="SubmitInfo"
                                    runat="server" ErrorMessage="(*)" Display="Dynamic" ToolTip="Field Required"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="NormalNegrita">Company Type<br />
                                <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceTypes" DataTextField="Name" DataValueField="Id" Width="400px" Skin="MetroTouch">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="NormalNegrita">Contact Name<br />
                                <telerik:RadTextBox ID="txtContact" runat="server" Width="400px" MaxLength="80" Skin="MetroTouch">
                                </telerik:RadTextBox>
                                &nbsp;
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtContact" ValidationGroup="SubmitInfo"
                                    runat="server" ErrorMessage="(*) " Display="Dynamic" ToolTip="Field Required"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Phone (optional):<br />
                                <telerik:RadMaskedTextBox ID="PhoneTextBox" Width="400px" runat="server" Mask="(###) ###-####" Skin="MetroTouch" SelectionOnFocus="CaretToBeginning" />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td class="NormalNegrita">Password&nbsp;&nbsp;&nbsp;<asp:Label ID="lblPass" runat="server" CssClass="Pequena" Text="(6 characters and 1 nonalphanumeric)"></asp:Label><br />
                                <telerik:RadTextBox ID="txtPassword" runat="server" Width="400px" MaxLength="80" Skin="MetroTouch" TextMode="Password">
                                </telerik:RadTextBox>
                                &nbsp;
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtPassword" ValidationGroup="SubmitInfo"
                                    runat="server" ErrorMessage="(*) " Display="Dynamic" ToolTip="Field Required"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="NormalNegrita">
                                Confirm Password<br />
                                <telerik:RadTextBox ID="txtConfirmPassword" runat="server" Width="400px" MaxLength="80" Skin="MetroTouch" TextMode="Password">
                                </telerik:RadTextBox>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="(*)" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ToolTip="Password Not Match"></asp:CompareValidator>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="text-align: right; padding-right: 50px; padding-bottom:15px">
                    <telerik:RadButton ID="btnOk" runat="server" Text="Continue PASconcept setup" Skin="BlackMetroTouch" ValidationGroup="SubmitInfo">
                    </telerik:RadButton>
                </td>
            </tr>

        </table>
        <table align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center">
                    <asp:HyperLink ID="lnkHelp" runat="server" CssClass="EnlaceGrisSmall" NavigateUrl="http://blog.pasconcept.com"
                        Target="_blank">Help</asp:HyperLink>
                    &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; <asp:HyperLink ID="HyperLink2" runat="server" CssClass="EnlaceGrisSmall"
                        NavigateUrl="https://pasconcept.com/Legal/ENG/Terms.html" Target="_blank">Terms & Condition</asp:HyperLink>
                    &nbsp;</td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Company.companyId, Company.Name, Company.Type, Company_types.Name AS TypeName, Company.Contact, Company.Phone, Company.Email, Company.Version, sys_Versiones.Name AS VersionName,  FROM Company LEFT OUTER JOIN sys_Versiones ON Company.Version = sys_Versiones.Id LEFT OUTER JOIN Company_types ON Company.Type = Company_types.Id ORDER BY Company.Name"
        InsertCommand="Company_NEW_RegisterEnd" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:cnnProjectsAccounting.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="txtCompanyName" Name="Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtContact" Name="Contact" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="PhoneTextBox" Name="Phone" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboType" Name="Type" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboBillingPlan" Name="BillingPlan" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </InsertParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT [Id], [Name] FROM [Company_types] ORDER BY [Name]">
        </asp:SqlDataSource>
    
        <asp:SqlDataSource ID="SqlDataSourceBillingPlan" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT [Id], [Name] FROM [Billing_plans] where Id=103 ORDER BY [Id]">
        </asp:SqlDataSource>
    </form>
</body>
</html>
