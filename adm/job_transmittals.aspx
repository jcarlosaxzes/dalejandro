<%@ Page Title="Trasmittal" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_transmittals.aspx.vb" Inherits="pasconcept20.job_transmittals" %>

<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">
        <div class="row">
            <div class="form-group">
                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false">
             <span class="glyphicon glyphicon-plus"></span> Transmittal
                </asp:LinkButton>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                    <script type="text/javascript">
                        function OnClientClose(sender, args) {
                            var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                            masterTable.rebind();
                        }
                    </script>
                </telerik:RadCodeBlock>
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" GroupingEnabled="false" AutoGenerateColumns="False" DataSourceID="SqlDataSourceTransmittals" Width="100%"
                    AllowAutomaticDeletes="true" AllowPaging="True">
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceTransmittals" ShowFooter="True" EditMode="PopUp"
                        ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small">
                        <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                        <Columns>
                            <telerik:GridTemplateColumn DataField="TransmittalID" Groupable="False" HeaderText="Transmittal ID"
                                SortExpression="TransmittalID" UniqueName="TransmittalID" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="160px"
                                FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}" ReadOnly="true">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEditTransmittal" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Transmittal"
                                        CommandName="EditTransmittal" Text='<%# Eval("TransmittalID")%>'>
                                    </asp:LinkButton>
                                    <span title="Number of Packages" class="badge" style='<%# IIf(Eval("PackageContent")=0,"display:none","display:normal")%>'>
                                        <%#Eval("PackageContent")%>
                                    </span>
                                    <a class="glyphicon glyphicon-share" title="Preview Trasmittal " href='<%# LocalAPI.GetSharedLink_URL(6,Eval("Id")) %>' target="_blank" aria-hidden="true"></a>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="TransmittalDate" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime" ReadOnly="true"
                                HeaderText="Date Opened" SortExpression="TransmittalDate" UniqueName="TransmittalDate"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ReadyDate" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime" ReadOnly="true"
                                HeaderText="Ready Date" SortExpression="ReadyDate" UniqueName="ReadyDate"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PickUpDate" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime" ReadOnly="true"
                                HeaderText="Pick Up Date" SortExpression="PickUpDate" UniqueName="PickUpDate"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="nStatus" HeaderText="Status" SortExpression="nStatus" ReadOnly="true"
                                UniqueName="nStatus" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="true" HeaderStyle-Width="150px">
                                <ItemTemplate>
                                    <asp:Label ID="nStatusLabel" runat="server" Text='<%# Eval("nStatus")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Ready for Pick Up" UniqueName="column" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnReadyToSign" runat="server"
                                        Visible='<%# LocalAPI.IsTransmittalReadyToSigned(Eval("Id"))%>'
                                        CommandName="EmailReadyToPickUp"
                                        CommandArgument='<%# Eval("Id") %>'
                                        ToolTip="Send Email to Client with Ready For Pick Up Notification"
                                        CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                        <span class="glyphicon glyphicon-envelope"></span>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridButtonColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </div>
    </div>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    </telerik:RadWindowManager>

    <asp:SqlDataSource ID="SqlDataSourceTransmittals" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Transmittals_JOB_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Transmittal2_INSERT" InsertCommandType="StoredProcedure"
        DeleteCommand="DELETE FROM Transmittals WHERE Id=@Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>

</asp:Content>

