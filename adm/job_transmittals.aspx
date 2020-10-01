<%@ Page Title="Trasmittal" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_transmittals.aspx.vb" Inherits="pasconcept20.job_transmittals" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">
        <div class="pasconcept-bar">
            <span class="pasconcept-pagetitle">Notes</span>
            <span style="float: right; vertical-align: middle;">
                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                        Add Transmittal
                    </asp:LinkButton>
            </span>
        </div>

        <div>
            <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                <script type="text/javascript">
                    function OnClientClose(sender, args) {
                        var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                        masterTable.rebind();
                    }
                        </script>
            </telerik:RadCodeBlock>
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" GroupingEnabled="false" AutoGenerateColumns="False" DataSourceID="SqlDataSourceTransmittals" Width="100%"
                AllowAutomaticDeletes="true" AllowPaging="True" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceTransmittals" ShowFooter="True" FooterStyle-Font-Size="Small">
                    <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                    <Columns>
                        <telerik:GridTemplateColumn DataField="TransmittalID" Groupable="False" HeaderText="Transmittal ID"
                            SortExpression="TransmittalID" UniqueName="TransmittalID" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center"
                            FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}" ReadOnly="true">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEditTransmittal" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Transmittal"
                                    CommandName="EditTransmittal" Text='<%# Eval("TransmittalID")%>'>
                                        </asp:LinkButton>

                                <div style="float: right; vertical-align: top; margin: 0;">
                                    <%--Three Point Action Menu--%>
                                    <asp:HyperLink runat="server" ID="lblAction" NavigateUrl="javascript:void(0);" Style="text-decoration: none;">
                                                        <i title="Click to menu for this row" style="color:dimgray" class="fas fa-ellipsis-v"></i>
                                            </asp:HyperLink>
                                    <telerik:RadToolTip ID="RadToolTipAction" runat="server" TargetControlID="lblAction" RelativeTo="Element"
                                        RenderMode="Lightweight" EnableViewState="true" ShowCallout="false" RenderInPageRoot="true"
                                        Position="BottomRight" Modal="True" Title="" ShowEvent="OnClick"
                                        HideDelay="100" HideEvent="LeaveToolTip" IgnoreAltAttribute="true">
                                        <table class="table-borderless" style="width: 200px; font-size: medium">
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="btnEdit2" runat="server" UseSubmitBehavior="false" CommandName="EditTransmittal" CommandArgument='<%# Eval("Id")%>' CssClass="dropdown-item">
                                                            <i class="fas fa-pencil-alt"></i>&nbsp;&nbsp;View/Edit Transmittal
                                                            </asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="btnSendEmailEmailEmailPickUp" runat="server" CommandName="EmailEmailPickUp" CommandArgument='<%# Eval("Id")%>' UseSubmitBehavior="false" Visible='<%# LocalAPI.IsTransmittalReadyToSigned(Eval("Id"))%>' CssClass="dropdown-item">
                                                        <i class="far fa-envelope"></i>&nbsp;&nbsp;Send 'Ready For Pick Up' to Client
                                                            </asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="btnSendEmailEmailDeliveryTransmittalDigital" runat="server" CommandName="EmailDeliveryTransmittalDigital" CommandArgument='<%# Eval("Id")%>' ToolTip="Send Email to Client with Transmittal Digital Delivery Notification" UseSubmitBehavior="false" Visible='<%# IIf(LocalAPI.GetTransmittalDigitalFilesCount(Eval("Id")) = 0, False, True)%>' CssClass="dropdown-item">
                                                       <i style="color:olivedrab" class="far fa-envelope"></i>&nbsp;&nbsp;Send 'Digital Delivery' to Client
                                                            </asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href='<%# LocalAPI.GetSharedLink_URL(6, Eval("Id"))%>' target="_blank" class="dropdown-item">
                                                        <i class="far fa-share-square"></i>&nbsp;&nbsp;View Transmittal Client Page
                                                            </a>
                                                </td>
                                            </tr>
                                        </table>
                                    </telerik:RadToolTip>
                                </div>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="TransmittalDate" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime" ReadOnly="true"
                            HeaderText="Date Opened" SortExpression="TransmittalDate" UniqueName="TransmittalDate" HeaderStyle-Width="150px"
                            ItemStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ReadyDate" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime" ReadOnly="true"
                            HeaderText="Ready Date" SortExpression="ReadyDate" UniqueName="ReadyDate" HeaderStyle-Width="150px"
                            ItemStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="PickUpDate" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime" ReadOnly="true"
                            HeaderText="Pick Up Date" SortExpression="PickUpDate" UniqueName="PickUpDate" HeaderStyle-Width="150px"
                            ItemStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn DataField="nStatus" HeaderText="Status" SortExpression="nStatus" ReadOnly="true"
                            UniqueName="nStatus" ItemStyle-HorizontalAlign="Center" AllowFiltering="true" HeaderStyle-Width="150px">
                            <ItemTemplate>
                                <div style="font-size: 12px; width: 100%"
                                    class='<%# LocalAPI.GetTransmittalStatusLabelCSS(Eval("Status")) %>'>
                                    <%# Eval("nStatus") %>
                                </div>

                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Insights" UniqueName="Insights" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <div>

                                    <span title="Number of Packages" class="badge badge-pill badge-light">
                                        <%#Eval("PackageContent")%>
                                            </span>
                                    <span title="Package Signed And Sealed Items" class="badge badge-pill badge-secondary">
                                        <%#Eval("SignedAndSealed")%>
                                            </span>
                                    <span title="Digital Package Items" class="badge badge-pill badge-dark">
                                        <%#Eval("DigitalPackage")%>
                                            </span>
                                    <span title="Number of times the Client has visited the your Transmittal Page" class="badge badge-pill badge-warning">
                                        <%#Eval("clientvisits")%>
                                            </span>

                                </div>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                            CommandName="Delete" Text="" UniqueName="DeleteColumn" HeaderText=""
                            HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                        </telerik:GridButtonColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>

    </div>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <asp:SqlDataSource ID="SqlDataSourceTransmittals" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Transmittals_JOB_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Transmittal_v20_INSERT" InsertCommandType="StoredProcedure"
        DeleteCommand="Transmittal_DELETE" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" />
            <asp:Parameter Direction="InputOutput" Name="OUT_Id" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>

</asp:Content>

