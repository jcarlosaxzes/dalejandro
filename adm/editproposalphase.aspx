<%@ Page Title="Edit Phase" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="editproposalphase.aspx.vb" Inherits="pasconcept20.editproposalphase" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cboTaskTemplate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="decorationZone" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>

    <telerik:RadFormDecorator ID="FormDecorator1" runat="server" DecoratedControls="all" DecorationZoneID="decorationZone"></telerik:RadFormDecorator>

    <div id="decorationZone" style="width: 650px; padding-top: 10px; padding-left: 25px">

        <h3>Complete Phase details</h3>
        <div style="text-align: left">
            <table style="width: 620px; text-align: left">
                <tr>
                    <td>
                        <telerik:RadNumericTextBox ID="txtOrder" runat="server" Width="100px" EmptyMessage="Order" MinValue="0" MaxValue="99">
                            <NumberFormat DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadTextBox ID="txtPhaseCode" runat="server" MaxLength="3" Width="100px" EmptyMessage="Code"></telerik:RadTextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPhaseCode" CssClass="Error" ValidationGroup="PhaseUpdate" Text="*" ErrorMessage="Define Phase Code">
                        </asp:RequiredFieldValidator>

                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadTextBox ID="txtName" runat="server" MaxLength="80" Width="600px" EmptyMessage="Phase Name"></telerik:RadTextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtName" CssClass="Error" ValidationGroup="PhaseUpdate" Text="*" ErrorMessage="Define Phase Name">
                        </asp:RequiredFieldValidator>

                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        <telerik:RadEditor ID="txtDescription" runat="server" Height="300px" EmptyMessage="Phase Description"
                            AllowScripts="True" Width="600px"
                            ToolbarMode="Default" ToolsFile="~/BasicTools.xml" EditModes="All">
                        </telerik:RadEditor>

                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadTextBox ID="txtPeriod" runat="server" MaxLength="50" Width="600px" EmptyMessage="Phase Period Ex. (two weeks)"></telerik:RadTextBox>

                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" Culture="en-us">
                            <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                            </DateInput>
                        </telerik:RadDatePicker>

                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" Culture="en-us">
                            <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                            </DateInput>
                        </telerik:RadDatePicker>

                    </td>
                </tr>
            </table>
        </div>
        <div style="text-align: right; padding-right: 50px; padding-top: 15px; padding-bottom: 15px">
            <telerik:RadButton ID="btnUpdate" runat="server" Text="Update Phase" Width="150px" ValidationGroup="PhaseUpdate">
                <Icon PrimaryIconCssClass="rbSave" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
            </telerik:RadButton>
            &nbsp;&nbsp;&nbsp;
            <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" Width="150px" CausesValidation="false">
                <Icon PrimaryIconCssClass="rbCancel" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
            </telerik:RadButton>

        </div>
        <div style="padding-top: 10px;">
            <asp:ValidationSummary ID="ValidationSummaryPhaseUpdate" Font-Size="X-Small" runat="server" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="PhaseUpdate" />
        </div>
    </div>



    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="PROPOSAL_phases_UPDATE" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="txtOrder" Name="nOrder" PropertyName="Text" Type="Int16" />
            <asp:ControlParameter ControlID="txtPhaseCode" Name="Code" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtName" Name="Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter Name="Description" Type="String" ControlID="txtDescription" PropertyName="Content" />
            <asp:ControlParameter Name="Period" Type="String" ControlID="txtPeriod" PropertyName="Text" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="lblphaseId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblphaseId" runat="server" Visible="false"></asp:Label>
</asp:Content>
