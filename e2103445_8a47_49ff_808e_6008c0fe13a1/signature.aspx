<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="signature.aspx.vb" Inherits="pasconcept20.signature" %>

<!DOCTYPE html>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>PASconcept Signature 3</title>
    <script src="../Scripts/signature-pad/signature_pad132.js" type="text/javascript"></script>
    <%--<link href="~/Content/bootstrap.min.css" rel="stylesheet" />--%>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>


    <link href="~/Content/Site.css" rel="stylesheet" />
    <style>
        .signature-div {
            position: relative;
            width: 100%;
            height: 810px;
            top: 0px;
            left: 0px;
        }

        .signature-div-canvas {
            position: absolute;
            top: 2px;
            left: 2px;
            right: 2px;
            bottom: 78px;
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
            width: 100%;
            height: 110px;
            bottom: 0px;
            border: 0;
        }

        .signature-btn {
            position: absolute;
            top: 65px;
            bottom: 2px;
            width: 180px;
            height: 42px;
            border: 1px solid rgb(56, 78, 115);
            ;
            text-align: center;
            border-radius: 3px;
            color: rgb(56, 78, 115);
            cursor: pointer;
            font-family: 'Segoe UI', Arial, Helvetica, sans-serif;
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
            right: 20px;
            position: absolute;
            top: 52px;
            width: 180px;
            height: 48px;
        }

        .signature-clear {
            right: 240px;
            position: absolute;
            top: 52px;
            width: 180px;
            height: 48px;
        }

        .container {
            width: 100% !important;
        }
        .alert {
            padding: 5px;
            margin-bottom: 0px;
            border: 1px solid transparent;
            border-radius: 4px;
    }
       
    </style>
</head>
<body style="background-color:black">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <br />
                    <asp:Label ID="lblTitle" runat="server" Font-Bold="true" Text="Sign here" ForeColor="White"></asp:Label>
                    
                    <div style="align-content: center; padding-top: 15px">

                        <div class="signature-div panel panel-primary">
                            <div class="signature-div-canvas">
                                <canvas id="signature-canvas"></canvas>
                            </div>
                            <div class="signature-footer alert alert-success">
                                <telerik:RadTextBox ID="txtNombre" runat="server" Width="99%" Skin="MetroTouch" ToolTip="Name of the person signing" EmptyMessage="Name of the person signing" Font-Size="32px"></telerik:RadTextBox>

                                <span id="btnSave" runat="server" class="btn btn-primary btn-lg signature-save">
                                    Accept</span>
                                <span id="btnClear" runat="server" class="btn btn-default btn-lg signature-clear">Clear</span>
                            </div>
                        </div>
                        <p>
                            <asp:Label ID="lblExplication" runat="server" Text="I 'Accepted' the Proposal and Sign it" Font-Size="18px" ForeColor="White"></asp:Label>
                            <asp:Label ID="lblReferencia" runat="server" Text="0000" Font-Bold="true" Font-Size="18px" ForeColor="White"></asp:Label>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <asp:Label ID="lblId" runat="server" Style="display: none;">0</asp:Label>
        <asp:Label ID="lblObjType" runat="server" Style="display: none;">0</asp:Label>
        <asp:Label ID="lblGuiId" runat="server" Style="display: none;"></asp:Label>
        <asp:Label ID="lblBase64" runat="server" Style="display: none;">Base64</asp:Label>
        <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>

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

    </form>
</body>
</html>
