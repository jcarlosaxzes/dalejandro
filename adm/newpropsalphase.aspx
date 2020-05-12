<%@ Page Title="New Propsal Phase" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="newpropsalphase.aspx.vb" Inherits="pasconcept20.newpropsalphase" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cboPhaseTemplate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="decorationZone" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>

    <telerik:RadFormDecorator ID="FormDecorator1" runat="server" DecoratedControls="all" DecorationZoneID="decorationZone"></telerik:RadFormDecorator>

    <div id="decorationZone" style="width: 600px; padding-top: 10px; padding-left: 50px">

        <h2>Select Phase template</h2>
        <div style="text-align: left">
            <telerik:RadComboBox runat="server" ID="cboPhaseTemplate" DataValueField="Id" Width="500px" Height="250px" AutoPostBack="true" CausesValidation="false"
                DataTextField="Name" DataSourceID="SqlDataSource1" AppendDataBoundItems="true">
                <Items>
                    <telerik:RadComboBoxItem Text="(Select template...)" Value="0" />
                </Items>
            </telerik:RadComboBox>
        </div>
        <h2>Complete Phase details</h2>
        <div style="text-align: left">
            <table style="width: 600px; text-align: left">
                <tr>
                    <td>
                        <telerik:RadTextBox ID="CodeTextBox" runat="server" MaxLength="3" Width="150px" EmptyMessage="Code"></telerik:RadTextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CodeTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>

                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadTextBox ID="NameTextBox" runat="server" MaxLength="80" Width="500px" EmptyMessage="Name"></telerik:RadTextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>

                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        <telerik:RadEditor ID="DescriptionEditor" runat="server" ToolsFile="~/BasicTools.xml" RenderMode="Auto" EmptyMessage="Description"
                            Height="250px" AllowScripts="True" Width="490px">
                        </telerik:RadEditor>

                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadTextBox ID="PeriodoTextBox" runat="server" MaxLength="50" Width="500px" EmptyMessage="Period, ex .: (two weeks)"></telerik:RadTextBox>

                    </td>
                </tr>
            </table>
        </div>
        <div style="text-align: right; padding-right: 50px; padding-top: 25px; padding-bottom: 15px">
            <telerik:RadButton ID="btnNew" runat="server" Text="Create Phase" Width="150px">
                <Icon PrimaryIconCssClass="rbAdd" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
            </telerik:RadButton>
            &nbsp;&nbsp;&nbsp;
            <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" Width="150px" CausesValidation="false">
                <Icon PrimaryIconCssClass="rbCancel" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
            </telerik:RadButton>

        </div>

    </div>



    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="PROPOSAL_phases_INSERT" InsertCommandType="StoredProcedure"
        SelectCommand="Select Id, [Code] + ' ' + [Name] As Name from Proposal_phases_template where companyId=@companyId Order By Id">
        <InsertParameters>
            <asp:ControlParameter ControlID="lblproposalId" Name="proposalId" PropertyName="Text" />
            <asp:ControlParameter ControlID="CodeTextBox" Name="Code" PropertyName="Text" />
            <asp:ControlParameter ControlID="NameTextBox" Name="Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="DescriptionEditor" Name="Description" PropertyName="Content" Type="String" />
            <asp:ControlParameter ControlID="PeriodoTextBox" Name="Period" PropertyName="Text" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblproposalId" runat="server" Visible="false"></asp:Label>
</asp:Content>
