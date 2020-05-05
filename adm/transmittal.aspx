<%@ Page Title="Transmittal" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="transmittal.aspx.vb" Inherits="pasconcept20.transmittal1" %>

<%@ MasterType VirtualPath="~/adm/BasicMasterPage.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%">
        <ItemTemplate>
            <table class="table-condensed" style="width: 100%">
                <tr>
                    <td>
                        <h1>TRANSMITTAL LETTER</h1>
                    </td>
                    <td class="noprint" style="width: 10px">
                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-success" UseSubmitBehavior="false" CausesValidation="false" CommandName="Edit">
                            Edit
                        </asp:LinkButton>
                    </td>
                    <td class="noprint" style="width: 100px">
                        <asp:LinkButton ID="btnPickUp" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false" OnClick="btnPickUp_Click">
                            <span class="glyphicon glyphicon-envelope"></span>&nbsp;Pick Up
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>


            <div style="text-align: center; padding-top: 10px; background-color: white">
            </div>
            <table class="table-condensed" style="width: 100%; background-color: white">
                <tr>
                    <td style="width: 65%; vertical-align: top">
                        <table class="table-condensed" style="width: 100%; background-color: white">
                            <tr>
                                <td style="text-align: right; width: 150px"><b>Transmittal ID:</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("TransmittalID")%>' />
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
                                    &nbsp;&nbsp;
                                    <asp:LinkButton ID="btnMailReadyToSign" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false" 
                                        OnClick="btnMailReadyToSign_Click" Visible="false">
                                        <span class="glyphicon glyphicon-envelope"></span>&nbsp;Ready to Pick Up Notification
                                    </asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right"><b>Remaining Balance:</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:Label ID="Label198" runat="server" Text='<%# Eval("RemainingBalance", "{0:C2}")%>' />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align: top; text-align: right; padding-right: 25px">
                        <div>
                            <telerik:RadBarcode runat="server" ID="RadBarcode1" Type="QRCode" Text="" Height="140px" Width="140px" Style="margin-left: 30px" OutputType="EmbeddedPNG">
                                <QRCodeSettings Version="5" DotSize="3" Mode="Byte" />
                            </telerik:RadBarcode>
                        </div>
                    </td>
                </tr>
            </table>

            <table class="table-condensed" style="width: 100%; background-color: white">
                <tr>
                    <td colspan="2">
                        <telerik:RadGrid ID="RadGridDetails" RenderMode="Lightweight" runat="server" DataSourceID="SqlDataSourceDetails" Skin="" Width="100%" CssClass="RemoveBorders" AutoGenerateColumns="False" GridLines="Both">
                            <MasterTableView DataSourceID="SqlDataSourceDetails" CssClass="RemoveBorders" HeaderStyle-BackColor="LightGray">
                                <ItemStyle CssClass="GridRow" />
                                <AlternatingItemStyle CssClass="GridRow" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="AmountCopy" HeaderText="Amount Copy" UniqueName="AmountCopy"
                                        HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PakageContent" HeaderText="Package Content" UniqueName="PakageContent"
                                        HeaderStyle-Width="180px" HeaderStyle-HorizontalAlign="Center">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Description" HeaderText="Description" UniqueName="Description"
                                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="400px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="Signed" HeaderText="Signed & Sealed" UniqueName="Signed"
                                        HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSigned" runat="server" Text='<%# IIf(Eval("Signed") = 0, "No", "Yes")%>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <HeaderStyle BackColor="LightGray" />
                            </MasterTableView>
                        </telerik:RadGrid>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 150px;">
                        <b>Notes:</b>
                    </td>
                    <td style="text-align:left">
                        <%# (Eval("Notes")).Replace(vbCr, "").Replace(vbLf, vbCrLf).Replace(Environment.NewLine, "<br />")%>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right"><b>Receive By:</b>
                    </td>
                    <td style="text-align:left"class="TituloHTML">
                        <%# Eval("ReceiveBy")%>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Receiver signature:</b>
                    </td>
                    <td style="text-align: left; vertical-align: middle">
                        <telerik:RadBinaryImage ID="RadBinaryClientSign" runat="server" AlternateText="(Not Signed...)"
                            Width="260px" Height="150px" ResizeMode="Fit" 
                            DataValue='<%# IIf(Eval("SignImage") Is DBNull.Value, Nothing, Eval("SignImage"))%>'></telerik:RadBinaryImage>
                    </td>
                </tr>

                <tr>
                    <td style="text-align: right"><b>Pick Up Date:</b>
                    </td>
                    <td style="text-align:left">
                        <%# Eval("PickUpDate", "{0:d}")%>
                    </td>
                </tr>
            </table>

            <p style="text-align: right; padding-top: 25px; padding-right: 20px; font-family: Calibri; font-size: xx-small; font-style: italic">
                This Transmittal was made &amp; sent using PASconcept ( www.pasconcept.com ) 
            </p>
        </ItemTemplate>
        <EditItemTemplate>
            <table class="table-condensed" style="width: 100%">
                <tr>
                    <td style="text-align: center;">
                        <h1 style="margin: 0">EDIT TRANSMITTAL LETTER</h1>
                    </td>
                    <td style="width: 90px">
                        <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success" UseSubmitBehavior="false" CommandName="Update">
                            Update
                        </asp:LinkButton>

                    </td>
                    <td style="width: 90px">
                        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-default" UseSubmitBehavior="false" CausesValidation="false" CommandName="Cancel">
                            Cancel
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
            <table class="table-condensed" style="width: 100%">
                <tr>
                    <td style="text-align: right;"><b>A/E of Record:</b></td>
                    <td style="text-align: left">
                        <telerik:RadComboBox ID="cboEngRecord" runat="server"
                            DataSourceID="SqlDataSourceEmployee" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("RecordBy")%>'
                            Width="350px" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(Select A/E of Record...)" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Status:</b>
                    </td>
                    <td style="text-align: left">
                        <telerik:RadComboBox ID="cboStatus" runat="server" DataSourceID="SqlDataSourceStatus"
                            DataTextField="Name" DataValueField="Id" Width="200px" SelectedValue='<%# Bind("Status")%>'>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Receive By:</b>
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtReceiveBy" runat="server" Text='<%# Bind("ReceiveBy")%>' MaxLength="50" Width="100%"></telerik:RadTextBox>
                    </td>
                </tr>

                <tr>
                    <td style="text-align: right;"><b>Notes:</b>
                    </td>
                    <td>
                        <telerik:RadTextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes")%>' MaxLength="255" Width="100%" Rows="2" TextMode="MultiLine"></telerik:RadTextBox>
                    </td>
                </tr>
            </table>
            <table class="table-condensed" style="width: 100%">
                <tr>
                    <td style="text-align: left">
                        <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" OnClick="btnNew_Click" CausesValidation="false">
                        <span class="glyphicon glyphicon-plus"></span> Package
                        </asp:LinkButton>

                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadGrid ID="RadGridEditDetails" runat="server" DataSourceID="SqlDataSourceDetails" GridLines="None"
                            AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
                            AllowAutomaticUpdates="True" AllowPaging="True" PageSize="100" AllowSorting="True" CellSpacing="0">
                            <MasterTableView DataSourceID="SqlDataSourceDetails" DataKeyNames="Id">
                                <Columns>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderText="Edit" ItemStyle-Width="30px">
                                        <ItemStyle Width="20px"></ItemStyle>
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridTemplateColumn DataField="AmountCopy" HeaderText="Amount Copy" UniqueName="AmountCopy"
                                        HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <EditItemTemplate>
                                            <telerik:RadNumericTextBox ID="AmountCopyTextBox" runat="server" Culture="en-US" DbValue='<%# Bind("AmountCopy")%>' Width="125px" ShowSpinButtons="True" ButtonsPosition="Right" MinValue="0">
                                                <NumberFormat DecimalDigits="0" />
                                                <IncrementSettings Step="1" />
                                            </telerik:RadNumericTextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="AmountCopyLabel" runat="server" Text='<%# Eval("AmountCopy")%>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="packageId" HeaderText="Package Content" UniqueName="packageId"
                                        HeaderStyle-Width="180px" ItemStyle-CssClass="GridColumn">
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cboPakageContent" runat="server" DataSourceID="SqlDataSourcePakageTypes"
                                                DataTextField="Name" DataValueField="Id" Width="300px" SelectedValue='<%# Bind("packageId") %>' AppendDataBoundItems="true">
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text="(Package Not Defined...)" Value="0" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="PakageContentLabel" runat="server" Text='<%# Eval("PakageContent")%>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" SortExpression="Description" UniqueName="Description">
                                        <EditItemTemplate>
                                            <telerik:RadTextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description")%>' MaxLength="80" Width="600px"></telerik:RadTextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description")%>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Signed" HeaderText="Signed & Sealed by" UniqueName="Signed"
                                        HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="SignedCheckBox1" runat="server" Checked='<%# Bind("Signed")%>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblSigned" runat="server" Text='<%# IIf(Eval("Signed") = 0, "No", "Yes")%>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                    <EditColumn ButtonType="PushButton">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>
    <telerik:RadToolTip ID="RadToolTipMail" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode"
        Title="<b>Email to Client</b>">
        <table class="table-condensed" style="width: 450px">
            <tr>
                <td>
                    <h3>Action to sent email</h3>
                </td>
            </tr>
            <tr>
                <td>Do you want to Send an Email to the Client Notifying your Transmittal is Signed and Seal?
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:LinkButton ID="btnConfirmMail" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false">
                            <span class="glyphicon glyphicon-envelope"></span>&nbsp;Send Email
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                     <asp:LinkButton ID="btnCancelMail" runat="server" CssClass="btn btn-default" UseSubmitBehavior="false" CausesValidation="false">
                            Cancel
                     </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="TRANSMITTAL_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="TRANSMITTAL2_UPDATE" UpdateCommandType="StoredProcedure">
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
            <asp:Parameter Name="ReceiveBy" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDetails" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="TRANSMITTAL_DETAILS_SELECT" SelectCommandType="StoredProcedure" UpdateCommand="TRANSMITTAL_DETAILS_UPDATE" UpdateCommandType="StoredProcedure" DeleteCommand="TRANSMITTAL_DETAILS_DELETE" DeleteCommandType="StoredProcedure" InsertCommand="TRANSMITTAL_DETAILS_INSERT" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblTransmittalId" Name="transmittalId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblTransmittalId" Name="TransmittalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="packageId" Type="Int32" />
            <asp:Parameter Name="AmountCopy" Type="Int32" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Signed" Type="Boolean" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePakageTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Transmittals_package_types] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Transmittals_status] ORDER BY [Id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE (companyId=@companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTransmittalId" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeName" runat="server" Visible="False"></asp:Label>
</asp:Content>
