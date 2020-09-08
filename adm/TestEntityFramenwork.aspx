<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TestEntityFramenwork.aspx.vb" Inherits="pasconcept20.TestEntityFramenwork" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:Button Id="btnTest1" Text="Insert Using DBContext" runat="server" OnClick="btnTest1_Click"/>
            <br />
            <br />
            <asp:Button Id="btnTest2" Text="Insert Using Reposytory" runat="server" OnClick="btnTest2_Click"/>
        </div>
    </form>
</body>
</html>
