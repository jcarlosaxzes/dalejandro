<%@ Page Title="QuickBooks Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="qb_refreshtoken.aspx.vb" Inherits="pasconcept20.qb_refreshtoken" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <br />
        <div class="pasconcept-bar">
            <span class="pasconcept-pagetitle">
                <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark btn-lg" UseSubmitBehavior="false" CausesValidation="False">
                       Back
                </asp:LinkButton>
                &nbsp;&nbsp;&nbsp;
                Connect PASconcept to QuickBooks Online
            </span>
        </div>
        <div class="pasconcept-bar">
            <asp:Panel runat="server" ID="PanelInstructions">
                <br />
                <br />
                <h4>Obtain the access token</h4>
                <p>
                    Before <b>PASconcept</b> can access data using <b>QuickBooks Online</b> API, it must obtain an access token that grants access to the API. A single access token can grant varying degrees of access to multiple APIs. Scope parameter used while requesting the access token controls the set of resources and operations that an access token permits. During the access-token request, <b>PASconcept</b> sends one or more values in the scope parameter.
                </p>
                <p>
                    Obtaining the token requires an authentication step where the user logs in with their <b>QuickBooks Online</b> account. After logging in, the user is asked whether they are willing to grant the permissions that <b>PASconcept</b> is requesting. This process is called user consent.
                </p>
                <p>
                    If the user grants the permission, the Intuit Authorization Server sends <b>PASconcept</b> an authorization code at the callback endpoint that you defined in the Redirect URL section of the Keys tab of your app. This authorization code can be exchanged to obtain the access token. If the user does not grant the permission, the server returns an error.
                </p>

            </asp:Panel>
            <div style="text-align: center">
                <br />
                <asp:LinkButton ID="btnConnect" runat="server" CssClass="btn" UseSubmitBehavior="false">
                <img src="../Images/C2QB_green_btn_lg_default.png" height="70" />
                </asp:LinkButton>
                <br />
                <asp:Label ID="lblResutl" runat="server" Text="" Font-Size="Medium" Font-Bold="true" ForeColor="Red"></asp:Label>

            </div>
            <asp:Panel runat="server" ID="PanelSuccess" Visible="false">
                <div class="alert alert-success" role="alert">
                    <h4 class="alert-heading">Well done!</h4>
                    <p>
                        QuickBooks Connect Process have been completed successfully!
                    </p>
                    <p>
                        The connection Token with QuickBook has been authorized.
                    <br />
                        You can now return (Back button) to the previous page to continue with the transaction between PASconcept and QuickBook
                    </p>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
