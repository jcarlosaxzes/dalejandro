<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="tandcedit.aspx.vb" Inherits="pasconcept20.tandcedit" %>


<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="padding-left:50px;padding-top:10px;padding-bottom:10px">
        <telerik:RadButton ID="btnSave" runat="server" Text="Save Term & Conditions">
        </telerik:RadButton>
    </div>
    <div>
        <telerik:RadEditor ID="RadEditor1" Runat="server" Width="960px" Height="768px" AllowScripts="True" ConvertFontToSpan="Fase"  ToolbarMode="RibbonBar" RenderMode="Auto">
        </telerik:RadEditor>
    </div>
</asp:Content>


