<%@ Page Title="Payment Schedules" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterPROPOSAL.Master" CodeBehind="pro_paymentschedules.aspx.vb" Inherits="pasconcept20.pro_paymentschedules" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/adm/MasterPROPOSAL.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">Payment Schedules</span>
    </div>
    <div>
        <table class="table-sm" style="width: 100%;">
            <tr>
                <td style="text-align: right; width: 180px">Select first time or modify the current Payment Schedules:
                </td>
                <td style="width: 400px">
                    <telerik:RadComboBox ID="cboPaymentSchedules" runat="server" DataSourceID="SqlDataSourcePaymentSchedules"
                        DataTextField="Name" DataValueField="Id" Width="400px" MarkFirstMatch="True" AppendDataBoundItems="true"
                        Filter="Contains"
                        ToolTip="Select Payment Schedules to define first time or modify the current">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select other Payment Schedules...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <asp:LinkButton ID="btnGeneratePaymentSchedules" runat="server" CssClass="btn btn-success" UseSubmitBehavior="false"
                        ToolTip="Define Payment Schedules" CausesValidation="false">
                                            Update
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <telerik:RadGrid ID="RadGridPS" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
            AutoGenerateColumns="False" DataSourceID="SqlDataSourcePS" HeaderStyle-HorizontalAlign="Center"
            CellSpacing="0" Width="100%">
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePS" ShowFooter="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                        HeaderText="" HeaderStyle-Width="50px">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="Id" HeaderText="ID" SortExpression="Id" UniqueName="Id" Display="False" ReadOnly="true">
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="Order" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center" ReadOnly="true"
                        HeaderText="Order" SortExpression="Order" UniqueName="Order">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Description" HeaderText="Description" SortExpression="Description" UniqueName="Description">
                        <ItemTemplate>
                            <%# Eval("Description") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadTextBox Width="960px" ID="txtPSDescrip" runat="server" MaxLength="512" RenderMode="Lightweight" TextMode="MultiLine" Rows="2" Text='<%# Bind("Description") %>'>
                            </telerik:RadTextBox>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Percentage" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center" ReadOnly="true"
                        HeaderText="(%)" SortExpression="Percentage" UniqueName="Percentage">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Amount" HeaderText="Total" ReadOnly="True"
                        SortExpression="Amount" DataFormatString="{0:N2}" UniqueName="Amount" Aggregate="Sum"
                        FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right"
                        HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                </Columns>
                <EditFormSettings EditColumn-ItemStyle-Width="900px">
                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <div>
        <table class="table-sm" style="width: 100%">
            <tr style="text-align: right">
                <td>Totals:
                </td>
                <td>
                    <table style="width: 400px">
                        <tr>
                            <td style="text-align: center; width: 50%">Proposal Total
                            </td>
                            <td style="text-align: center;">Payment Schedule Total
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">
                                <asp:Label ID="lblProposalTotal" runat="server"></asp:Label>
                            </td>
                            <td style="text-align: center">
                                <asp:Label ID="lblScheduleTotal" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center">
                                <asp:Label ID="lblTotalAlert" runat="server" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="SqlDataSourcePaymentSchedules" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Invoices_types WHERE (companyId = @companyId) ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePS" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Proposal_PaymentSchedule_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Proposal_PaymentScheduleDescription_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProposalPSUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="Proposal_PS_v20_UPDATE" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:ControlParameter ControlID="cboPaymentSchedules" Name="paymentscheduleId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblOriginalStatus" runat="server" Visible="False"></asp:Label>
</asp:Content>
