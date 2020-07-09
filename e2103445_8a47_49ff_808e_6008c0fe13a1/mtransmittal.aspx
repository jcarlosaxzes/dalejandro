<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="mtransmittal.aspx.vb" Inherits="pasconcept20.mtransmittal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>m.transmittal</title>

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="~/Content/Site.css" rel="stylesheet" />
    <style>
        table {
            border-collapse: separate;
            border-spacing: 1em 1em;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <div class="container">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%">
                <ItemTemplate>
                    <div class=" jumbotron h1" style="margin-top: 15px; text-align: center">
                        Transmittal Letter
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <table class="table-condensed" style="width: 100%;">
                                <tr>
                                    <td class="section-label-movil" style="text-align: right; width: 180px">Transmittal ID:
                                    </td>
                                    <td class="stats-label">
                                        <%# Eval("TransmittalID")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="section-label-movil" style="text-align: right;">Client Name:
                                    </td>
                                    <td class="stats-label">
                                        <%# Eval("ClientName")%>
                                    </td>

                                </tr>

                                <tr>
                                    <td class="section-label-movil" style="text-align: right;">Date Created:
                                    </td>
                                    <td class="stats-label">
                                        <%# Eval("TransmittalDate", "{0:d}")%>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="section-label-movil" style="text-align: right;">Job No. & Name:
                                    </td>
                                    <td class="stats-label">
                                        <%# Eval("JobNo")%>
                                        &nbsp;&nbsp;&nbsp;
                                    <%# Eval("JobName")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="section-label-movil" style="text-align: right">A/E of Record:
                                    </td>
                                    <td class="stats-label">
                                        <%# Eval("RecordBy_Name")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="section-label-movil" style="text-align: right;">Status:
                                    </td>
                                    <td class="stats-label">
                                        <%# Eval("nStatus")%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <br />
                            <telerik:RadGrid ID="RadGridDetails" runat="server" DataSourceID="SqlDataSourceDetails" RenderMode="Lightweight" Width="100%"
                                AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                                <MasterTableView DataSourceID="SqlDataSourceDetails">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="AmountCopy" HeaderText="Qty" UniqueName="AmountCopy"
                                            HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="PakageContent" HeaderText="Package Content" UniqueName="PakageContent">
                                            <ItemTemplate>
                                                <%# Eval("PakageContent") %>
                                                <p>
                                                    <i><%# Eval("Description") %></i>
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
                            <br />
                            <br />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <table class="table-condensed" style="width: 100%">
                                <tr>
                                    <td class="section-label-movil" style="text-align: right; width: 180px">Notes:
                                    </td>
                                    <td>
                                        <%# (Eval("Notes")).Replace(vbCr, "").Replace(vbLf, vbCrLf).Replace(Environment.NewLine, "<br />")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="section-label-movil" style="text-align: right;">Receive By:
                                    </td>
                                    <td class="stats-label">
                                        <%# Eval("ReceiveBy")%>
                                    </td>

                                </tr>

                                <tr>
                                    <td class="section-label-movil" style="text-align: right; vertical-align: top">Receiver signature:
                                    </td>
                                    <td>
                                        <telerik:RadBinaryImage ID="RadBinaryClientSign" runat="server" AlternateText="(Not Signed...)" CssClass="thumbnail" Visible='<%# Eval("Status") <> 1 %>'
                                            Width="370px" Height="240px" ResizeMode="Fit" DataValue='<%# IIf(Eval("SignImage") Is DBNull.Value, Nothing, Eval("SignImage"))%>'></telerik:RadBinaryImage>
                                        <asp:LinkButton ID="btnSignature" runat="server" CssClass="btn btn-success  btn-lg noprint" Visible='<%# Eval("Status") = 1 %>'
                                            UseSubmitBehavior="false" OnClick="btnPickUp_Click" Width="350px">
                                            <span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Sign to Pick Up
                                        </asp:LinkButton>
                                    </td>
                                </tr>


                                <tr>
                                    <td class="section-label-movil" style="text-align: right">Pick Up Date:
                                    </td>
                                    <td class="stats-label">
                                        <%# Eval("PickUpDate", "{0:d}")%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>


                </ItemTemplate>
            </asp:FormView>
        </div>
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
    </form>
</body>
</html>
