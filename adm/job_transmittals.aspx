<%@ Page Title="Trasmittal" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_transmittals.aspx.vb" Inherits="pasconcept20.job_transmittals" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td>
                    <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                        Add Transmittal
                    </asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td>
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
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceTransmittals" ShowFooter="True" EditMode="PopUp">
                            <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                            <Columns>
                                <telerik:GridTemplateColumn DataField="TransmittalID" Groupable="False" HeaderText="Transmittal ID"
                                    SortExpression="TransmittalID" UniqueName="TransmittalID"  HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Center" 
                                    FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}" ReadOnly="true">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEditTransmittal" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Transmittal"
                                            CommandName="EditTransmittal" Text='<%# Eval("TransmittalID")%>'>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="TransmittalDate" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime" ReadOnly="true"
                                    HeaderText="Date Opened" SortExpression="TransmittalDate" UniqueName="TransmittalDate" HeaderStyle-Width="150px"
                                    ItemStyle-HorizontalAlign="Center" >
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ReadyDate" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime" ReadOnly="true"
                                    HeaderText="Ready Date" SortExpression="ReadyDate" UniqueName="ReadyDate" HeaderStyle-Width="150px"
                                    ItemStyle-HorizontalAlign="Center" >
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="PickUpDate" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime" ReadOnly="true"
                                    HeaderText="Pick Up Date" SortExpression="PickUpDate" UniqueName="PickUpDate" HeaderStyle-Width="150px"
                                    ItemStyle-HorizontalAlign="Center" >
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="nStatus" HeaderText="Status" SortExpression="nStatus" ReadOnly="true"
                                    UniqueName="nStatus"  ItemStyle-HorizontalAlign="Center" AllowFiltering="true" HeaderStyle-Width="150px">
                                    <ItemTemplate>
                                        <asp:Label ID="nStatusLabel" runat="server" Text='<%# Eval("nStatus")%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div style="font-size: x-small; vertical-align: middle">
                                            <a href='<%# LocalAPI.GetSharedLink_URL(6, Eval("Id"))%>' target="_blank" title="View Transmittal Private Client Page">
                                                <i style="font-size: small;" class="far fa-share-square"></i></a>
                                            </a>
                                            &nbsp;        
                                            <asp:LinkButton ID="btnSendEmail" runat="server" CommandName="Email" CommandArgument='<%# Eval("Id")%>' ToolTip="Send Email to Client with Ready For Pick Up Notification"
                                                UseSubmitBehavior="false" Visible='<%# LocalAPI.IsTransmittalReadyToSigned(Eval("Id"))%>'>
                                                   <i style="font-size:small;" class="far fa-envelope"></i>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnSendEmail2" runat="server" CommandName="EmailDeliveryTransmittalDigital" CommandArgument='<%# Eval("Id")%>' ToolTip="Send Email to Client with Transmittal Digital Delivery Notification"
                                                UseSubmitBehavior="false" Visible='<%# IIf(LocalAPI.GetTransmittalDigitalFilesCount(Eval("Id")) = 0, False, True)%>'>
                                                   <i style="font-size:small;color:olivedrab" class="far fa-envelope"></i>
                                            </asp:LinkButton>
                                                        &nbsp;
                                            <span title="Number of Packages" class="badge badge-pill badge-secondary" style='<%# IIf(Eval("PackageContent")=0,"display:none","display:normal")%>'>
                                                <%#Eval("PackageContent")%>
                                            </span>
                                                &nbsp;
                                            <span title="Signed And Sealed Items" class="badge badge-pill badge-warning" style='<%# IIf(Eval("PackageContent")=0,"display:none","display:normal")%>'>
                                                <%#Eval("SignedAndSealed")%>
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
                </td>
            </tr>

        </table>



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

