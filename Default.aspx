<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="pasconcept20._Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <%-- Favicons and the like --%>
    <link rel="apple-touch-icon" sizes="180x180" href="~/Content/favicons/apple-touch-icon.png" />
    <link rel="icon" type="image/png" sizes="32x32" href="~/Content/favicons/favicon-32x32.png" />
    <link rel="icon" type="image/png" sizes="16x16" href="~/Content/favicons/favicon-16x16.png" />
    <link rel="manifest" href="~/Content/favicons/site.webmanifest" />

    <title>Welcome to PASconcept. Project Administration Services</title>
</head>
<body>
    <form id="form1" runat="server">
        
        <h3>Connection Failure or Firewall violation</h3>
        <p>
            We apologize for the inconveniences.
            <br />
            Contact the PASconcept Administrator
        </p>
            
        
        <asp:Label ID="lblIPAddress" runat="server" Text="" ></asp:Label>
    </form>
</body>
</html>
