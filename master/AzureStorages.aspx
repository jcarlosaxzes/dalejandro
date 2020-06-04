<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AzureStorages.aspx.vb" Inherits="pasconcept20.AzureStorages" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Companies Move Azure Store</title>
    <%--Bootstrap reference begin--%>
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
    <%--Bootstrap reference end--%>
    <link href="~/Content/fontawesome-free-5.1.1-web/css/all.min.css" rel="stylesheet" />
    <link href="~/css/Menu.PASMenuBlackMetroTouch.min.css" rel="stylesheet" />
    <link href="~/Content/pasconcept.min.css" rel="stylesheet" />

    <meta name="DESCRIPTION" content="A web-based application conceived and designed to provide an all-inclusive management tool for architectural and engineering firms who wish to integrate the interaction." />
    <meta name="KEYWORDS" content="pasconcept,saas,online project administration,architectural app,engineering app,project app,time sheet,proposals online,job online,civil app,mechanical app,structural app,
          electrical app,request for proposal, rfp,subconsultant,
          engineering Software,cloud accounting software,billing system,engineering services,A/E online app,A/E online services,Rational Engineering, Lifecycle Manager, engineering data, engineering lifecycle,
          systems engineering, lifecycle data, open architecture,architectural firm,A/E online administration,proposal for architectural,budget for architectural,budeget for engineering,proposal for engineering,
          proposal for A/E,budget for A/E,agreement for architectural, agreement for engineering,contract for engineering,contract for architectural,agreement for engineering,invoice for engineering,
          invoice for architectural,invoice service, invoice online,time sheet for architectural,time sheet for engineering,rfp for architectural,rfp for engineering,rfp for subconsultant" />
    <meta name="google-site-verification" content="-YpSUSprv2srj8BMkivDa3xokq246v05MmoAXtqSF38" />
    <meta name="AUTHOR" content="AXZES, LLC" />
    <meta name="COPYRIGHT" content="Copyright (c) 2005-2020 PASconcept" />
    <meta name="RESOURCE-TYPE" content="DOCUMENT" />
    <meta name="DISTRIBUTION" content="GLOBAL" />
    <meta name="AUTHOR" content="AXZES, LLC" />
    <meta name="ROBOTS" content="INDEX, FOLLOW" />
    <meta name="REVISIT-AFTER" content="1 DAYS" />
    <meta name="RATING" content="GENERAL" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />


    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />

    <%-- CSS And JS Toogle Nutton --%>
    <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet" />
    <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager 
            runat="server" 
            ID="RadScriptManager1" 
            CdnSettings-CombinedResource="Disabled"
            EnableCdn="true"> 
        </telerik:RadScriptManager>
        
        <telerik:RadStyleSheetManager 
            runat="server" 
            ID="RadStyleSheetManager1">
            <CdnSettings TelerikCdn="Enabled" CombinedResource="Enabled" />
        </telerik:RadStyleSheetManager>

        <div>
            Company Id&nbsp;&nbsp;
            <telerik:RadComboBox ID="cboCompany" runat="server" DataSourceID="SqlDataSourceCompany" ToolTip="Company" ZIndex="50001" Width="300px"
                 DataTextField="Name" DataValueField="companyId" Height="200px" >
             </telerik:RadComboBox>

            &nbsp;&nbsp;&nbsp;&nbsp;Count Files&nbsp;&nbsp;
            <asp:TextBox ID="txtCount" runat="server" Text="100"></asp:TextBox>

            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="Move Jobs Files" />&nbsp;&nbsp;  <asp:Label ID="lbResutl" runat="server" Text=""></asp:Label>
            <br />
&nbsp;&nbsp;&nbsp;
            <br />

            <asp:Button ID="Button2" runat="server" Text="Move Proposal Files" />&nbsp;&nbsp;  <asp:Label ID="lblProposal" runat="server" Text=""></asp:Label>
            <br />
&nbsp;&nbsp;&nbsp;
            <br />
            <br />

             <asp:Button ID="Button3" runat="server" Text="Move Client Files" />&nbsp;&nbsp;  <asp:Label ID="lblCliet" runat="server" Text=""></asp:Label>
            <br />
&nbsp;&nbsp;&nbsp;
            <br />
            <br />

             <asp:Button ID="Button4" runat="server" Text="Move RequestFroProporsal Files" />&nbsp;&nbsp;  <asp:Label ID="lblrfproporsal" runat="server" Text=""></asp:Label>
            <br />
&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <br />

             <asp:Button ID="Invoices_payment" runat="server" Text="Move Invoces payments Files" />&nbsp;&nbsp;  <asp:Label ID="lblInvoice_payment" runat="server" Text=""></asp:Label>
            <br />
&nbsp;&nbsp;&nbsp;
            <br />            
            <br />
            <br />

             <asp:Button ID="move2016" runat="server" Text="Move Files to old_2016" />&nbsp;&nbsp;  <asp:Label ID="lblmove" runat="server" Text=""></asp:Label>
            <br /><br />
&nbsp;&nbsp;&nbsp;
            <br />            
            <br />
            <br />

             <asp:Button ID="Button5" runat="server" Text="Detete Files" />&nbsp;&nbsp;  <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            <br />

        </div>

        <asp:SqlDataSource ID="SqlDataSourceCompany" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="Select [companyId] ,[Name] from [Company] " SelectCommandType="Text"
            >
        </asp:SqlDataSource>

    </form>
</body>
</html>
