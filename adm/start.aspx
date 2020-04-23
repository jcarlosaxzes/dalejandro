<%@ Page Title="Getting Started" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="start.aspx.vb" Inherits="pasconcept20.start" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadFormDecorator ID="FormDecorator1" runat="server" DecoratedControls="all" DecorationZoneID="starttbl"></telerik:RadFormDecorator>

    <table id="starttbl" class="table-condensed" style="width: 100%">
        <tr>
            <td><h4>Getting started with PASconcept is Simple</h4>
            </td>
        </tr>
        <tr>
            <td style="padding-left: 50px;">
                <fieldset style="width: 700px; padding-left: 50px">
                    <legend class="TituloDeFieldset">&nbsp;To-do list&nbsp;</legend>

                    <table class="table-condensed">
                        <tr>
                            <td style="width: 50px">
                                <asp:CheckBox ID="chkCompanyInfo" runat="server" Enabled="false" Checked="false" />
                            </td>
                            <td>
                                <asp:HyperLink Font-Size="X-Large" ID="lblCompanyInfo" runat="server" NavigateUrl="~/ADM/Company.aspx" Text="1.	Complete company information" Target="_blank"></asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkEmployee" runat="server" Enabled="false" Checked="false" /></td>
                            <td>
                                <asp:HyperLink Font-Size="X-Large" ID="lnkEmployee" runat="server" NavigateUrl="~/ADM/Employees.aspx" Text="2.	Create first employee profile" Target="_blank"></asp:HyperLink></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkClient" runat="server" Enabled="false" Checked="false" /></td>
                            <td>
                                <asp:HyperLink Font-Size="X-Large" ID="lblClient" NavigateUrl="~/ADM/Clients.aspx" Text="3.	Create first client profile" Target="_blank" runat="server"></asp:HyperLink></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkTyC" runat="server" Enabled="false" Checked="false" /></td>
                            <td>
                                <asp:HyperLink Font-Size="X-Large" ID="lblTyC" NavigateUrl="~/ADM/TandCtemplates.aspx" Text="4.	Define Terms & Conditions for proposals" Target="_blank" runat="server"></asp:HyperLink></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkPaymentSch" runat="server" Enabled="false" Checked="false" /></td>
                            <td>
                                <asp:HyperLink Font-Size="X-Large" ID="lblPaymentSch" NavigateUrl="~/ADM/InvoicesTypes.aspx" Text="5. Define payment schedules for proposals" Target="_blank" runat="server"> </asp:HyperLink></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkProposal" runat="server" Enabled="false" Checked="false" /></td>
                            <td>
                                <asp:HyperLink Font-Size="X-Large" ID="lblProposal" NavigateUrl="~/ADM/Proposals.aspx" Text="6.	Create first proposal" runat="server" Target="_blank"></asp:HyperLink></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkJobsCodes" runat="server" Enabled="false" Checked="false" /></td>
                            <td>
                                <asp:HyperLink Font-Size="X-Large" ID="lblJobsCodes" NavigateUrl="~/ADM/JobTypes.aspx" Text="7.	Define job codes" Target="_blank" runat="server"> </asp:HyperLink></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkJob" runat="server" Enabled="false" Checked="false" /></td>
                            <td>
                                <asp:HyperLink Font-Size="X-Large" ID="lblJob" NavigateUrl="~/ADM/Jobs.aspx" Text="8. Create first job" runat="server" Target="_blank"></asp:HyperLink></td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td style="padding-left: 550px;">
                <asp:LinkButton ID="btnSettingStatus" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false">
                                        <span class="glyphicon glyphicon-share"></span>&nbsp;Go Setting Status
                    </asp:LinkButton>
            </td>
        </tr>
    </table>
    <br /><br /><br /><br /><br />
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>

</asp:Content>

