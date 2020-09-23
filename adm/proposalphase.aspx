<%@ Page Title="Propsal Phase" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposalphase.aspx.vb" Inherits="pasconcept20.proposalphase" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pasconcept-bar">
        <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
            Back
        </asp:LinkButton>

        <span class="pasconcept-pagetitle">&nbsp;&nbsp;Proposal Phase:&nbsp;<asp:Label ID="lblProposal" runat="server"></asp:Label></span>

    </div>
    <div>
        <asp:ValidationSummary ID="vsPhase" runat="server" ValidationGroup="NewPhase" ForeColor="Red"
            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were this errors:"></asp:ValidationSummary>
    </div>

    <div class="pasconcept-bar">

        <h4>Select Template</h4>
        <table class="table-sm" style="width: 90%">
            <tr>
                <td style="text-align: right; width: 180px">Source Phase Template:
                    </td>
                <td>
                    <telerik:RadComboBox runat="server" ID="cboPhaseTemplate" DataValueField="Id" Width="100%" Height="250px" AutoPostBack="true" CausesValidation="false"
                        DataTextField="Name" DataSourceID="SqlDataSource1" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Text="(Select template...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>

                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr />
                </td>
            </tr>
        </table>
        <h4>Phase Details</h4>
        <table class="table-sm" style="width: 90%">
            <tr>
                <td style="text-align: right; width: 180px">Phase Code:
                    </td>
                <td>
                    <telerik:RadTextBox ID="CodeTextBox" runat="server" MaxLength="3" Width="250px" EmptyMessage="Code"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right; width: 180px">Order:
                    </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtOrder" runat="server" Width="250px" MinValue="0" MaxValue="99" ButtonsPosition="Right" Step="1">
                        <NumberFormat DecimalDigits="0" />
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Phase Name:
                    </td>
                <td>
                    <telerik:RadTextBox ID="NameTextBox" runat="server" MaxLength="80" Width="100%" EmptyMessage="Name"></telerik:RadTextBox>


                </td>
            </tr>
            <tr>
                <td style="text-align: right">Phase Subtitle:
                    </td>
                <td>
                    <telerik:RadTextBox ID="PeriodoTextBox" runat="server" MaxLength="50" Width="100%" EmptyMessage="(i.e. Two Weeks, Off-Site, etc)"></telerik:RadTextBox>

                </td>
            </tr>
            <tr>
                <td style="text-align: right">Phase Description:
                    </td>
                <td style="text-align: left">
                    <telerik:RadEditor ID="DescriptionEditor" runat="server" ToolsFile="~/BasicTools.xml" RenderMode="Auto" EmptyMessage="Description"
                        Height="250px" AllowScripts="True" Width="100%">
                    </telerik:RadEditor>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Period From:
                    </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" Culture="en-us">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Period To:
                    </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" Culture="en-us">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Progress (0 to 100)%:
                    </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtProgress" runat="server">
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right">
                    <asp:LinkButton ID="btnNewUpdate" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ValidationGroup="NewPhase" Text="Add Phase">
                        </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnUpdateAndBack" runat="server" CssClass="btn btn-success btn-lg" ValidationGroup="NewPhase" UseSubmitBehavior="false" Text="Update and Back">
                    </asp:LinkButton>
                </td>
            </tr>
        </table>

        <div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CodeTextBox" Display="None" ValidationGroup="NewPhase"
                ErrorMessage="Phase Code is required"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NameTextBox" Display="None" ValidationGroup="NewPhase"
                ErrorMessage="Phase Name is required"></asp:RequiredFieldValidator>
        </div>
    </div>



    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, [Code] + ' ' + [Name] As Name from Proposal_phases_template where companyId=@companyId Order By Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblproposalId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblphaseId" runat="server" Visible="false"></asp:Label>
</asp:Content>
