<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ResetPasswordSuccess.aspx.vb" Inherits="pasconcept20.ResetPasswordSuccess" %>



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
    <%--Bootstrap reference begin--%>
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
    <%--Bootstrap reference end--%>
</head>
<body title="Welcome to PASconcept. Project Administration Services" style="background-color: white">
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server"  EnableCdn="true" ID="RadScriptManager1" />
        <div class="container">

            <div class="row">
                <div class="col-md-5 col-lg-offset-4" style="margin-top: 5em">
                        <LayoutTemplate>
                            <asp:Panel ID="pnlLogin" runat="server">
                                <div class="well">

                                    <asp:Image runat="server" class="img-thumbnail" ImageUrl="~/Images/logo/pas_horizontal_logo_big.png" Width="100%" />

                                    <form>
                                        <div class="form-group" style="margin-top: 1em">
                                            <p><H3>Your password has been changed. Click <asp:HyperLink ID="login" runat="server" NavigateUrl="~/Account/Login">here</asp:HyperLink> to login </p></H3>                                  
                                        </div>                                       
                                    </form>
                                </div>
                            </asp:Panel>
                        </LayoutTemplate>
                    
                </div>
            </div>
            <div class="row">
                <div class="col-md-3 col-lg-offset-5 ">
                    <a href="http://blog.pasconcept.com" target="_blank">Help</a>
                    &nbsp;|&nbsp;
                    <a href="../Legal/ENG/Terms.html" target="_blank">Terms & Conditions</a>
                </div>
            </div>
            
        </div>

    </form>
</body>
</html>