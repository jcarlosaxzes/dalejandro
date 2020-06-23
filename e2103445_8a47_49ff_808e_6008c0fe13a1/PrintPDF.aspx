<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PrintPDF.aspx.vb" Inherits="pasconcept20.PrintPDF"  Async="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="txtGuID" runat="server" Text="cc3ba6bc-74b9-44b6-bdb4-bb0b0d152cbb"></asp:TextBox>
            <asp:Button id="createPdf" runat="server" Text="Create PDF" OnClick="createPdf_Click"></asp:Button>
        </div>
    </form>

     <%-- SqlDataSources --%>
    
    


        <%-- Hidden Labels --%>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalId" runat="server" Visible="False"></asp:Label>
</body>
</html>
