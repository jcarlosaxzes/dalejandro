<%@ Page Title="Disconnect from QuickBook" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="qb_disconnect.aspx.vb" Inherits="pasconcept20.qb_disconnect" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <br />
        <div class="pasconcept-bar">
            <span class="pasconcept-pagetitle">
                <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark btn-lg" UseSubmitBehavior="false" CausesValidation="False">
                       Back
                </asp:LinkButton>
                &nbsp;&nbsp;&nbsp;
                Disconnect PASconcept from QuickBooks Online
            </span>
        </div>
        <div class="pasconcept-bar">
            <asp:Panel runat="server" ID="PanelConnected">
                <br />
                <br />
                <h4>Revoke token/Disconnect</h4>
                <p>
                    <b>PASconcept</b> can programmatically revoke access given to it by a specific user when click the Disconnect button. 
                        <br />    
                    Use the revoke endpoint to request permissions granted to the application to be removed.
                </p>

            </asp:Panel>
            <div style="text-align: center">
                <br />
                <asp:LinkButton ID="btnDisconnect" runat="server" CssClass="btn btn-danger btn-lg" UseSubmitBehavior="false">
                    Disconnect from QuickBook
                </asp:LinkButton>
                <br />
                <asp:Label ID="lblResutl" runat="server" Text="" Font-Size="Medium" Font-Bold="true" ForeColor="Red"></asp:Label>

            </div>
            <asp:Panel runat="server" ID="PanelDisconnected">
                <div class="alert alert-success" role="alert">
                    <h4 class="alert-heading">QuickBooks Disconnected</h4>
                    <p>
                        <b>PASconcept</b> has been disconnected QuickBooks. 
                        <br />
                        You will no longer to be able to Get Customers and Sync Invoices directly to your QuickBooks account from PASconcept.
                    </p>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>

