<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WebForm1.aspx.vb" Inherits="pasconcept20.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <telerik:RadEditor ID="gridEditor" runat="server" AllowScripts="True" Width="800px" ToolsFile="~/BasicTools.xml" ContentFilters="FixUlBoldItalic, IECleanAnchors, MozEmStrong, ConvertFontToSpan, ConvertToXhtml, IndentHTMLContent, EncodeScripts, OptimizeSpans, ConvertCharactersToEntities, ConvertTags, StripCssExpressions, RemoveExtraBreaks" ExternalDialogsPath="~/RadEditorDialogs/">
                    </telerik:RadEditor>
        </div>
    </form>
</body>
</html>
