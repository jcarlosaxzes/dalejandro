<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="signature.aspx.vb" Inherits="pasconcept20.signature1" %>


<!DOCTYPE html>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>PASconcept Signature</title>
    <script src="../Scripts/signature_pad132.js" type="text/javascript"></script>
</head>
<body style="background-color:lightgray ">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
            <Rows>
                <telerik:LayoutRow>
                    <Columns>
                        <telerik:LayoutColumn Span="2"></telerik:LayoutColumn>
                        <telerik:LayoutColumn Span="8">
                            <div style="align-content:center; padding-top: 30px">

                                <h2>
                                    <asp:Label ID="lblTitle" runat="server" Text="To Accept Proposal, Sign Here"></asp:Label>
                                </h2>
                                <h4>
                                    <asp:Label ID="lblExplication" runat="server" Text="I 'Accepted' the Proposal and Sign it"></asp:Label>
                                    <asp:Label ID="lblReferencia" runat="server" Text="0000"></asp:Label>
                                </h4>
                                <h4></h4>
                                <br />
                                <style>
                                    .signature-div {
                                        position: relative;
                                        width: 320px;
                                        height: 256px;
                                        border: 2px black solid;
                                        top: 0px;
                                        left: 0px;
                                    }

                                    .signature-div-canvas {
                                        position: absolute;
                                        top: 2px;
                                        left: 2px;
                                        right: 2px;
                                        bottom: 72px;
                                        border: 0;
                                    }

                                    .signature-div canvas {
                                        border-style: none;
                                        border-color: inherit;
                                        border-width: 0;
                                        position: relative;
                                        width: 100%;
                                        height: 100%;
                                        background-color: #fff;
                                        box-shadow: 0 0 5px rgba(0, 0, 0, 0.02) inset;
                                        top: 0px;
                                        left: 0px;
                                    }

                                    .signature-footer {
                                        position: absolute;
                                        left: 1px;
                                        width: 100%;
                                        height: 68px;
                                        bottom: 0px;
                                        border: 0;
                                    }

                                    .signature-btn {
                                        position: absolute;
                                        top: 30px;
                                        bottom: 2px;
                                        width: 100px;
                                        height: 26px;
                                        border: 1px solid rgb(56, 78, 115);
                                        ;
                                        text-align: center;
                                        border-radius: 3px;
                                        color: rgb(56, 78, 115);
                                        cursor: pointer;
                                        font-family: 'Segoe UI', Arial, Helvetica, sans-serif;
                                        ;
                                        font-size: 16px;
                                        padding-top: 3px;
                                        background: #fafbfd; /* Old browsers */
                                        background: -moz-linear-gradient(top, #fafbfd 0%, #bfcddf 100%); /* FF3.6+ */
                                        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#fafbfd), color-stop(100%,#bfcddf)); /* Chrome,Safari4+ */
                                        background: -webkit-linear-gradient(top, #fafbfd 0%,#bfcddf 100%); /* Chrome10+,Safari5.1+ */
                                        background: -o-linear-gradient(top, #fafbfd 0%,#bfcddf 100%); /* Opera 11.10+ */
                                        background: -ms-linear-gradient(top, #fafbfd 0%,#bfcddf 100%); /* IE10+ */
                                        background: linear-gradient(to bottom, #fafbfd 0%,#bfcddf 100%); /* W3C */
                                        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fafbfd', endColorstr='#bfcddf',GradientType=0 ); /* IE6-9 */
                                    }

                                        .signature-btn:hover {
                                            background-color: #eee;
                                        }

                                    .signature-save {
                                        right: 2px;
                                    }

                                    .signature-clear {
                                        right: 116px;
                                    }
                                </style>

                                <div class="signature-div">
                                    <div class="signature-div-canvas">
                                        <canvas id="signature-canvas"></canvas>
                                    </div>
                                    <div class="signature-footer">
                                        <telerik:RadTextBox ID="txtNombre" runat="server" Width="99%" ToolTip="Name of the person signing" EmptyMessage="Name of the person signing"></telerik:RadTextBox>
                                        <span id="btnSave" runat="server" class="signature-btn signature-save">Sign</span>
                                        <span id="btnClear" runat="server" class="signature-btn signature-clear">Clear</span>
                                    </div>
                                </div>

                                <asp:Label ID="lblId" runat="server" Style="display: none;">0</asp:Label>
                                <asp:Label ID="lblObjId" runat="server" Style="display: none;">0</asp:Label>
                                <asp:Label ID="lblBase64" runat="server" Style="display: none;">Base64</asp:Label>

                                <script src="signature_pad.js"></script>
                                <script type="text/javascript">
                                    var canvas = document.getElementById("signature-canvas");
                                    var clearButton = document.getElementById("btnClear");
                                    var saveButton = document.getElementById("btnSave");
                                    var signaturePad;

                                    function resizeCanvas() {
                                        var ratio = window.devicePixelRatio || 1;
                                        canvas.width = canvas.offsetWidth * ratio;
                                        canvas.height = canvas.offsetHeight * ratio;
                                        canvas.getContext("2d").scale(ratio, ratio);
                                    }

                                    window.onresize = resizeCanvas;
                                    resizeCanvas();
                                    signaturePad = new SignaturePad(canvas);

                                    clearButton.addEventListener("click", function (event) {
                                        signaturePad.clear();
                                    });

                                    saveButton.addEventListener("click", function (event) {
                                        if (signaturePad.isEmpty()) {
                                            alert("Please provide signature first.");
                                        } else {
                                            __doPostBack("CommandSave", signaturePad.toDataURL());
                                        }
                                    });
                                </script>
                            </div>
                        </telerik:LayoutColumn>
                        <telerik:LayoutColumn Span="2"></telerik:LayoutColumn>
                    </Columns>
                </telerik:LayoutRow>
            </Rows>
        </telerik:RadPageLayout>

    </form>
</body>
</html>
