<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ErrorPage.aspx.vb" Inherits="pasconcept20.ErrorPage" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <%-- Favicons and the like --%>
    <link rel="apple-touch-icon" sizes="180x180" href="~/Content/favicons/apple-touch-icon.png" />
    <link rel="icon" type="image/png" sizes="32x32" href="~/Content/favicons/favicon-32x32.png" />
    <link rel="icon" type="image/png" sizes="16x16" href="~/Content/favicons/favicon-16x16.png" />
    <link rel="manifest" href="~/Content/favicons/site.webmanifest" />

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
    <meta name="image" content="https://pasconcept.com/images/logo/pas_horizontal_logo.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>PASconcept. Your complete online platform of Project </title>

    <link href="App_Themes/Estandar/Estandar.css" rel="stylesheet" type="text/css" />
    <%--Bootstrap reference begin--%>
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
    <%--Bootstrap reference end--%>
</head>
<body title="Welcome to PASconcept. Project Administration Services" style="background-color: white">
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <div class="container">

            <div class="row">
                <div class="col-md-5 col-lg-offset-4" style="margin-top: 5em">

                    <asp:Panel ID="pnlLogin" runat="server">
                        <div class="well">

                            <%--<img class="img-thumbnail" src="/images/logopasconcept-index.png"  />--%>
                            <asp:Image runat="server" class="img-thumbnail" ImageUrl="~/Images/logo/pas_horizontal_logo_big.png" Width="100%" />

                            <div class="form-group" style="margin-top: 1em">
                                <h3 style="color: red;">An Error has Occurred</h3>
                                <p>
                                    An unexcepted error has occurred on our webapp. The website administrator has been notified.<br />
                                    Please, <a href="Default.aspx">click here </a> to continue with PASconcept
                                </p>
                            </div>

                        </div>
                    </asp:Panel>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3 col-lg-offset-5 ">
                    <a href="http://blog.pasconcept.com" target="_blank">Help</a>
                    &nbsp;|&nbsp;
                    <a href="https://pasconcept.com/Legal/ENG/Terms.html" target="_blank">Terms & Conditions</a>
                </div>
            </div>

        </div>

    </form>
</body>
</html>
