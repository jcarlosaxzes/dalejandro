﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="uploadphoto.aspx.vb" Inherits="pasconcept20.uploadphoto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upload photo</title>

    <link href="~/Content/bootstrap.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" EnableCdn="true" runat="server">
        </telerik:RadScriptManager>

        <div class="pas-container">

            <div class="DropZone1" style="height: 350px; background-color: whitesmoke; text-align: center;width:605px;margin:10px">
                <h4 style="color: black">Select or Drag and Drop (jpg,png,gif,bmp) files (up to 10Mb)</h4>
                <br />
                <br />
                <div style="padding-left: 150px">
                    <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" DropZones=".DropZone1" MultipleFileSelection="Disabled"
                        MaxFileSize="2097152" AllowedFileExtensions="jpg,png,gif,bmp"
                        AutoAddFileInputs="false" RenderMode="Classic" />
                </div>
                <br />
                <asp:Label runat="server" ID="lblMessage" ForeColor="Red"></asp:Label>

            </div>

            <div style="text-align: center; padding-top: 20px">
                <asp:LinkButton ID="btnSave" runat="server" CommandName="Photo" ToolTip="Upload and Save photo"
                    CssClass="btn btn-success btn-lg" UseSubmitBehavior="false">
                <span class="glyphicon glyphicon-user"></span> Upload Photo
                </asp:LinkButton>


            </div>
        </div>



        <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblCodeId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblEntity" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblPath" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblEmail" runat="server" Visible="False"></asp:Label>
    </form>
</body>
</html>
