<%@ Page Title="Log in" Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="pasconcept20.Login" Async="true" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <meta name="DESCRIPTION" content="A web-based application conceived and designed to provide an all-inclusive management tool for architectural and engineering firms who wish to integrate the interaction." />

    <meta name="KEYWORDS" content="pasconcept,saas,online project administration,architectural app,engineering app,project app,time sheet,proposals online,job online,civil app,mechanical app,structural app,
          electrical app,request for proposal, rfp,subconsultant,
          engineering Software,cloud accounting software,billing system,engineering services,A/E online app,A/E online services,Rational Engineering, Lifecycle Manager, engineering data, engineering lifecycle,
          systems engineering, lifecycle data, open architecture,architectural firm,A/E online administration,proposal for architectural,budget for architectural,budeget for engineering,proposal for engineering,
          proposal for A/E,budget for A/E,agreement for architectural, agreement for engineering,contract for engineering,contract for architectural,agreement for engineering,invoice for engineering,
          invoice for architectural,invoice service, invoice online,time sheet for architectural,time sheet for engineering,rfp for architectural,rfp for engineering,rfp for subconsultant" />

    <meta name="KEYWORDS" content="online,saas,architectural,engineering,saas,platform,web browser,site,pasconcept,project,platform,proposals,gaq,saas,notifications,document,account,var,solution" />
    <meta name="AUTHOR" content="PASconcept Team" />
    <meta name="Resource-type" content="Homepage" />
    <meta name="DateCreated" content="Mon, 12 December 2011 12:53:00 GMT+1" />
    <meta name="Revisit-after" content="7 days" />

    <meta name='url' content='https://pasconcept.com/' />
    <meta name='identifier-URL' content='https://pasconcept.com/' />
    <meta name="image" content="https://pasconcept.com/images/header-pasconcept-logo.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>PASconcept. Your complete online platform of Project </title>

    <link href="~/App_Themes/Estandar/Estandar.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/pasconcept.css" rel="stylesheet" />
    <%--Bootstrap reference begin--%>
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
    <%--Bootstrap reference end--%>
</head>
<body title="Welcome to PASconcept. Project Administration Services" style="background-color: white">
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" EnableCdn="true" ID="RadScriptManager1" />
        <div class="container">

            <div class="row " style="margin-top: 12em">
                <div style="margin-left:150px">
                    <asp:ValidationSummary ID="vsConfirmation" runat="server" ValidationGroup="Login2" ForeColor="Red"
                        HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on Login:"></asp:ValidationSummary>
                </div>
                <div class="col-md-9 col-md-offset-1">
                    <table class="table-condensed well" style="width: 100%">
                    <tr>
                        <td style="width: 40%" rowspan="2">

                            <asp:Image runat="server" CssClass="img-thumbnail" ImageUrl="~/Images/logo/vertical logo on light bg.svg" Width="100%" />

                        </td>
                        <td style="vertical-align: middle">

                            <asp:Panel ID="pnlLogin" runat="server" DefaultButton="LoginButton">
                            </asp:Panel>


                            <table class="table-condensed" style="width: 100%">
                                <tr>
                                    <td>
                                        <label for="email" class="control-label" style="font-size: large">User Email</label>
                                        <telerik:RadTextBox ID="UserName" runat="server" Width="100%" Skin="MetroTouch" Font-Size="Large"></telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="password" class="control-label" style="font-size: large">Password</label>
                                        <telerik:RadTextBox ID="Password" runat="server" TextMode="Password" Width="100%" Skin="MetroTouch" Font-Size="Large"></telerik:RadTextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadCheckBox runat="server" ID="RememberMe" class="RememberMe" TextAlign="Left" Text="Remember me?" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="ResetPassword.aspx">Forgot password?</a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; vertical-align: bottom">
                            <asp:LinkButton ID="LoginButton" runat="server" CssClass="btn btn-success btn-block btn-lg"
                                UseSubmitBehavior="false" CommandName="Login" ValidationGroup="Login2" OnClick="OnClickHandler">
                                <span class="glyphicon glyphicon-log-in"></span>&nbsp;&nbsp;&nbsp;Sign in
                            </asp:LinkButton>
                            <div style="text-align: center;margin-top:10px">
                                <a href="../Legal/ENG/Terms.html" target="_blank">By clicking Sign In, you agree to our Terms & Conditions</a>
                            </div>

                        </td>
                    </tr>
                </table>
                </div>
                <div class="row">
                    <div class="col-md-4 col-lg-offset-4 ">
                    
                        <a href="http://blog.pasconcept.com" target="_blank">Help</a> &nbsp;|&nbsp; <a href="../Legal/ENG/Terms.html" target="_blank">Terms & Condition</a>
                    </div>
                    <div>
                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                    </div>

                </div>
                <asp:Label runat="server" ID="lblError"></asp:Label>
            </div>

            <div>
                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" Display="None"
                    ErrorMessage="User Name is required." ValidationGroup="Login2"></asp:RequiredFieldValidator>

                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server"
                    ControlToValidate="Password" ErrorMessage="Password is required."
                    Font-Bold="False" Font-Size="Small" ForeColor="#00A8E4"
                    ToolTip="Password is required." ValidationGroup="Login2">*</asp:RequiredFieldValidator>

            </div>

        </div>
    </form>
</body>
</html>
