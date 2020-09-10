<%@ Page Title="Client Acknowledgment" Language="vb" AutoEventWireup="false" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.Master" CodeBehind="acknowledgment.aspx.vb" Inherits="pasconcept20.acknowledgment" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceClient" Width="100%">
        <ItemTemplate>

            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="text-align: left; vertical-align: top; width: 33%">
                        <h2 style="margin: 0"><span class="navbar navbar-expand-md bg-dark text-white d-print-flex">Client Acknowledgment</span></h2>

                        <h3 style="margin: 5px"><%# Eval("Name") %></h3>
                        <%# Eval("Company") %><br>
                        <i class="fas fa-map-marker-alt"></i>&nbsp;<%# Eval("FullAddress") %><br>
                        <i class="fas fa-phone"></i>&nbsp;<%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone"))%><br>
                        <i class="far fa-envelope"></i>&nbsp;<%# Eval("Email") %><br>
                        <i class="fas fa-globe"></i>&nbsp;<a href='<%# Eval("web") %>' target="_blank"><%# Eval("web") %></a>

                    </td>
                </tr>
            </table>

        </ItemTemplate>
    </asp:FormView>
    <br />

    <asp:Panel runat="server" ID="PanelAcknowledgment" Visible='<%# LocalAPI.GetClientAcknowledgments(lblClientId.Text) = False %>'>
        <p style="text-align: justify; font-size: large">
            <asp:Label runat="server" ID="lblAcknowledgment" Text="I consent and agree that <b>[CompanyName]</b> may contact me by telephone at any telephone number associated with my account that I provide now or in the future, including cellular phones, wireless telephone numbers or any other wireless devices, regardless of whether I incur charges as a result. I expressly consent and agree to <b>[CompanyName]</b>, agents and assigns, contacting me by the following methods including, but not limited to, any telephone dialing system, sending text messages or e-mails using any e-mail address I provide now or in the future, using manual calling methods, pre-recorded/artificial voice messages and/or use of an automatic dialing device or system, as applicable. I understand that my consent is not a condition of purchase.">
            </asp:Label>
        </p>
        <div style="text-align: center;">
            <telerik:RadTextBox runat="server" ID="txtInitials" Width="300px" EmptyMessage="Initials" Skin="Material" MaxLength="50"></telerik:RadTextBox>
            <br />
            <br />
            <br />
            <asp:LinkButton ID="btnAccept" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="Acknowledgment">
                <i class="fa fa-check-square" aria-hidden="true"></i>&nbsp;&nbsp;I Agree
            </asp:LinkButton>
        </div>
    </asp:Panel>
    <asp:FormView ID="FormViewCancel" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceAcknowledgment" Width="100%" DefaultMode="Edit" Visible='<%# LocalAPI.GetClientAcknowledgments(lblClientId.Text) %>'>
        <EditItemTemplate>
            <h2><span class="navbar navbar-expand-md bg-dark text-white d-print-flex">Current Acknowledgment</span></h2>
            <p style="text-align: justify; font-size: large">
                <%# Eval("Acknowledment") %>
            </p>
            Initials: <%# Eval("Initials") %><br />
            Start Date: <%# Eval("StartDate", "{0:d}") %><br />
            <br />
            <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-warning btn-lg" UseSubmitBehavior="false" CommandName="Update">
                <i class="fas fa-ban"></i>&nbsp;&nbsp;Cancel Acknowledgment
            </asp:LinkButton>
        </EditItemTemplate>
    </asp:FormView>
    <br />
    <asp:Panel runat="server" ID="PanelAlert" Visible="false">
        <div class="alert alert-success" role="alert">
            <h4 class="alert-heading"><asp:Label runat="server" ID="lblAlert"></asp:Label></h4>
        </div>
    </asp:Panel>
        <div style="text-align: left">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtInitials" ValidationGroup="Acknowledgment" Display="None" ErrorMessage="Complete Initials" SetFocusOnError="true"></asp:RequiredFieldValidator>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                ForeColor="Red" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="Acknowledgment" />
        </div>
        <br />
        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="Client_v20_SELECT" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:ControlParameter ControlID="lblClientId" Name="Id" PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceAcknowledgment" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="ClientCurrentAcknowledgment_SELECT" SelectCommandType="StoredProcedure"
            UpdateCommand="ClientCurrentAcknowledgment_CANCEL" UpdateCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblClientId" Name="clientId" PropertyName="Text" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Id" />
                <asp:ControlParameter ControlID="lblClientId" Name="clientId" PropertyName="Text" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblClientId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblInvoiceGuid" runat="server" Visible="False"></asp:Label>
</asp:Content>
