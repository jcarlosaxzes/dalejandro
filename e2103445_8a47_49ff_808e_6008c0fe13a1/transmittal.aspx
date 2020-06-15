﻿<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.Master" CodeBehind="transmittal.aspx.vb" Inherits="pasconcept20.transmittal" %>

<%@ MasterType VirtualPath="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%">
        <ItemTemplate>
            <div style="text-align: center; padding-top: 10px; background-color: white">
                <h1>TRANSMITTAL LETTER</h1>
            </div>

            <table class="table-sm" style="width: 100%;" >
                <tr>
                    <td style="vertical-align: top">
                        <table class="table-sm" style="width: 100%;">
                            <tr>
                                <td style="text-align: right; width: 150px"><b>Transmittal ID:</b>
                                </td>
                                <td style="text-align: left">
                                    <%# Eval("TransmittalID")%>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;"><b>Client Name:</b>
                                </td>
                                <td style="text-align: left;">
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("ClientName")%>' />
                                </td>

                            </tr>

                            <tr>
                                <td style="text-align: right;"><b>Date Created:</b>
                                </td>
                                <td style="text-align: left;">
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("TransmittalDate", "{0:d}")%>' />
                                </td>
                            </tr>

                            <tr>
                                <td style="text-align: right;"><b>Job No. & Name:</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("JobNo")%>' />
                                    &nbsp;&nbsp;&nbsp;
                                    <asp:Label ID="Label10" runat="server" Text='<%# Eval("JobName")%>' />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right"><b>A/E of Record:</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:Label ID="Label11" runat="server" Text='<%# Eval("RecordBy_Name")%>' />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;"><b>Status:</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:Label ID="ProposalNumberLabel" runat="server" Text='<%# Eval("nStatus")%>' />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align: top; text-align: center; width:250px">
                        <div>
                            <asp:Label ID="lblTitle1" runat="server" Text="Sign on your mobile device" Font-Bold="true" Font-Size="Small"  Visible='<%# Eval("Status") = 1 %>'/>
                            <br />
                            <telerik:RadBarcode runat="server" ID="RadBarcode1" Type="QRCode" Text="" Height="140px" Width="140px" Style="margin-left: 30px" OutputType="EmbeddedPNG" Visible='<%# Eval("Status") = 1 %>'>
                                <QRCodeSettings Version="5" DotSize="3" Mode="Byte" />
                            </telerik:RadBarcode>
                            <br />
                            <asp:Label ID="lblTitle2" runat="server" Text="Scan the QR code with your mobile device's camara or with a QR code reader app" Font-Italic="true" Font-Size="Small"  Visible='<%# Eval("Status") = 1 %>'/>

                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <telerik:RadGrid ID="RadGridDetails" runat="server" DataSourceID="SqlDataSourceDetails" RenderMode="Lightweight" Width="100%"
                            AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                            <MasterTableView DataSourceID="SqlDataSourceDetails">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="AmountCopy" HeaderText="Qty" UniqueName="AmountCopy"
                                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="PakageContent" HeaderText="Package Content" UniqueName="PakageContent" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <%# Eval("PakageContent") %>
                                            <p>
                                                <%# Eval("Description") %>
                                            </p>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Signed" HeaderText="Signed & Sealed" UniqueName="Signed"
                                        HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%# IIf(Eval("Signed") = 0, "No", "Yes")%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </td>
                </tr>
            </table>

            <table class="table-sm" style="width: 100%;">
                <tr>
                    <td style="text-align: right; width: 150px;">
                        <b>Notes:</b>
                    </td>
                    <td colspan="2">
                        <%# (Eval("Notes")).Replace(vbCr, "").Replace(vbLf, vbCrLf).Replace(Environment.NewLine, "<br />")%>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Receive By:</b>
                    </td>
                    <td style="width: 330px; text-align: center; padding-top: 10px" class="TituloHTML">
                        <%# Eval("ReceiveBy")%>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Receiver signature:</b>
                    </td>
                    <td style="width: 330px; text-align: center; vertical-align: middle">
                        <telerik:RadBinaryImage ID="RadBinaryClientSign" runat="server" AlternateText="(Not Signed...)"
                            Width="320px" Height="200px" ResizeMode="Fit" DataValue='<%# IIf(Eval("SignImage") Is DBNull.Value, Nothing, Eval("SignImage"))%>'></telerik:RadBinaryImage>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td style="text-align: center">
                        <asp:LinkButton ID="btnSignature" runat="server" CssClass="btn btn-success  btn-lg noprint" Visible='<%# Eval("Status") = 1 %>' UseSubmitBehavior="false" OnClick="btnPickUp_Click">
                            <i class="fas fa-pen"></i>&nbsp;&nbsp;Sign to Pick Up
                        </asp:LinkButton>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Pick Up Date:</b>
                    </td>
                    <td style="text-align: center;">
                        <%# Eval("PickUpDate", "{0:d}")%>
                    </td>
                    <td></td>
                </tr>
            </table>

        </ItemTemplate>
        <EditItemTemplate>
        </EditItemTemplate>
    </asp:FormView>

    <p style="text-align: right; padding-top: 25px; padding-right: 20px; font-family: Calibri; font-size: xx-small; font-style: italic">
        This Transmittal was made &amp; sent using PASconcept ( www.pasconcept.com ) 
    </p>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="TRANSMITTAL_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblTransmittalId" Name="TransmittalId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Status" Type="Int16" />
            <asp:Parameter Name="Notes" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDetails" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="TRANSMITTAL_DETAILS_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblTransmittalId" Name="TransmittalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTransmittalId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblguid" runat="server" Visible="False"></asp:Label>
</asp:Content>
