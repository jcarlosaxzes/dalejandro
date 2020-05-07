<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="excelcalculator.aspx.vb" Inherits="pasconcept20.excelcalculator" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PASconcept calculator</title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:radscriptmanager runat="server" id="RadScriptManager1" />
<%--        <script type="text/javascript">
            var $ = $telerik.$;

            function exportFile() {
                var spreadsheet = $find("<%= RadSpreadsheet1.ClientID %>");
                spreadsheet.saveAsExcel();
            }

            function importFile(sender, args) {
                if (!(Telerik.Web.Browser.ie && Telerik.Web.Browser.version == "9")) {
                    var file = args.get_fileInputField().files[0];
                    var spreadsheet = $find("<%= RadSpreadsheet1.ClientID %>");
                    spreadsheet.fromFile(file);
                }

                $(args.get_row()).remove();
            }
        </script>--%>
        <div>
            <table class="ToolButtom" cellpadding="3" style="width: 400px">
                <tr>
                    <td>
                        <telerik:radbutton runat="server" id="btnExport" autopostback="false"
                            onclientclicked="exportFile" text="Export to Excel File">
                        </telerik:radbutton>
                    </td>
                    <td style="padding-top: 10px">
                        <telerik:radasyncupload runat="server" id="RadAsyncUpload1" hidefileinput="true" allowedfileextensions=".xlsx, .xls"
                            onclientfileselected="importFile" localization-select="Import" width="150px">
                        </telerik:radasyncupload>
                    </td>
                </tr>
            </table>

        </div>
<%--        <telerik:radspreadsheet runat="server" id="RadSpreadsheet1" height="700px">
            <ContextMenus>
                <RowHeaderContextMenu>
                    <Items>
                        <telerik:RadMenuItem Text="HideRow" Value="CommandHideRow"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Text="DeleteRow" Value="CommandDeleteRow"></telerik:RadMenuItem>
                    </Items>
                </RowHeaderContextMenu>

            </ContextMenus>
        </telerik:radspreadsheet>--%>

        
    <asp:label id="lblCompanyId" runat="server" visible="False"></asp:label>
    </form>
</body>
</html>
