<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="useragree.aspx.vb" Inherits="pasconcept20.useragree" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="~/Content/bootstrap.css" rel="stylesheet" />
    <title>Term & Conditions</title>
</head>
<body bgcolor="white" >
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <table align="center" style="background-color:white">
            <tr>
                <td>
                    <div style="text-align:center">
                        <asp:Label ID="lblTitle" runat="server" Text="Welcome to PASConcept" CssClass="Titulo1" />
                        <br />
                        <asp:Label ID="lblTitle1" runat="server" Text="A new concept to provide Project Administration Services online" CssClass="NormalNegrita" />
                        <br />
                        <asp:Label ID="lblTitle2" runat="server" Text="Please, read and <b>Agree</b> Term & Conditions" CssClass="Normal" />
                    </div>
                    <div style="padding-left:50px">
                        <asp:Label ID="lblTerms" runat="server" />
                    </div>
                    <div style="text-align:center">
                        <telerik:RadButton ID="btnDISAGREE" runat="server" CausesValidation="False" Text="Disagree" Width="150px" />
                        &nbsp;&nbsp;&nbsp;

                        <asp:LinkButton ID="btnAGREE" runat="server" CssClass="btn btn-success" UseSubmitBehavior="false" Width="150px">
                             Agree
                    </asp:LinkButton>


                        &nbsp;&nbsp;&nbsp;<telerik:RadButton ID="btnREADLATER" runat="server" CausesValidation="False" Text="Read Later" Width="150px" />
                    </div>
                    <div>
                        <telerik:RadButton ID="btnSENDByEMAIL" runat="server" CausesValidation="False" Text="Send By Email" Width="120px" Visible="False"/>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>