﻿<%@ Page Title="QuickBooks Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="qb_refreshtoken.aspx.vb" Inherits="pasconcept20.qb_refreshtoken" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <br />
        <br />
        <br />

        <div style="text-align: center">
            <asp:Label ID="lblResutl" runat="server" Text="" Font-Size="Medium" Font-Bold="true" ForeColor="Red"></asp:Label>
        </div>
        <br />

        <span class="pasconcept-pagetitle">

            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark btn-lg" UseSubmitBehavior="false" CausesValidation="False">
                       Cancel
            </asp:LinkButton>
            QuickBooks Connect to Refresh Token
            <span style="float: right; vertical-align: middle;">
                <asp:LinkButton ID="btnConnect" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false">
                    QuickBooks Connect
                </asp:LinkButton>
            </span>

        </span>
        <asp:Panel runat="server" ID="PanelInstructions">
            <br />
            <br />
            <h4>Obtain the access token</h4>
            <p>
                Before your application can access data using QuickBooks Online API, it must obtain an access token that grants access to the API. A single access token can grant varying degrees of access to multiple APIs. Scope parameter used while requesting the access token controls the set of resources and operations that an access token permits. During the access-token request, your application sends one or more values in the scope parameter.
            </p>
            <p>
                Obtaining the token requires an authentication step where the user logs in with their QuickBooks Online account. After logging in, the user is asked whether they are willing to grant the permissions that your application is requesting. This process is called user consent.
            </p>
            <p>
                If the user grants the permission, the Intuit Authorization Server sends your application an authorization code at the callback endpoint that you defined in the Redirect URL section of the Keys tab of your app. This authorization code can be exchanged to obtain the access token. If the user does not grant the permission, the server returns an error.
            </p>

        </asp:Panel>

        <asp:Panel runat="server" ID="PanelSuccess" Visible="false">
            <div class="alert alert-success" role="alert">
                <h4 class="alert-heading">Well done!</h4>
                <p>
                    QuickBooks Connect Process have been completed successfully!
                </p>
                <p>
                    The connection Token with QuickBook has been authorized for the next 60 minutes.
                    <br />
                    You can now return (Back button) to the previous page to continue with the transaction between PASconcept and QuickBook
                </p>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
