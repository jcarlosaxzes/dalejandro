<%@ Page Title="Clients Collection" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="clientscolletion.aspx.vb" Inherits="pasconcept20.clientscolletion" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <table style="width: 100%" class="table-sm">
        <tr>
            <td>
                <div class="PanelFilter">
                    <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                        <table style="width: 100%" class="table-condensed Formulario">
                            <tr>
                                <td style="width: 300px">
                                    <telerik:RadComboBox ID="cboStatus" runat="server" AppendDataBoundItems="true" Width="100%" Label="Collection Status:">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="Active" Selected="true" Value="1" />
                                            <telerik:RadComboBoxItem Text="Closed" Selected="true" Value="2" />
                                            <telerik:RadComboBoxItem Text="(All Status...)" Value="-1" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="100%"
                                        EmptyMessage="Find for Name, Company, Phone, Email">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 120px">
                                    <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                            <i class="fas fa-search"></i> Search
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
            </td>
        </tr>
    </table>

    <table class="table-sm" style="width: 100%">
        <tr>
            <td style="width: 150px">
                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Add New Proposal Template">
                                    <i class="fas fa-plus"></i> Client to Collection
                </asp:LinkButton>
            </td>
            <td style="text-align: center">
                <h3 style="margin: 0">Clients Colletion
                </h3>
            </td>
        </tr>
    </table>



    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False"
            AllowPaging="True" AllowSorting="True" PageSize="25" HeaderStyle-HorizontalAlign="Center"
            ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" AllowAutomaticDeletes="true">
            <PagerStyle Mode="Slider" AlwaysVisible="false" />
            <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="Id">
                <Columns>
                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" SortExpression="Id" UniqueName="Id" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Name" HeaderText="Client Name" UniqueName="Name">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="btnEdit" CommandName="Notification" CommandArgument='<%# Eval("Id") %>' ToolTip="Edit Record">
                                        <%# String.Concat(Eval("Name"), IIf(Len(Eval("Company")) > 0, ", ", ""), Eval("Company")) %>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Notes" HeaderText="Notes" UniqueName="Notes">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AttorneyFirm" HeaderText="Attorney Firm" UniqueName="AttorneyFirm">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DateIn" HeaderText="Date In" UniqueName="DateIn" DataFormatString="{0:d}" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DateOut" HeaderText="Date Out" UniqueName="DateOut" DataFormatString="{0:d}" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Status" HeaderText="Status" UniqueName="Status" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <span class="<%# LocalAPI.GetCollectionStatusLabelCSS(Eval("Status")) %>"><%# Eval("Status") %></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" AllowFiltering="False"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                        <ItemTemplate>
                            <div style="text-align: center; width: 100%">
                                <asp:LinkButton runat="server" ID="btnNotification" CommandName="Notification" CommandArgument='<%# Eval("Id") %>' ToolTip="Send Notifications">
                                        <i class="far fa-envelope"></i>
                                </asp:LinkButton>
                                &nbsp;
                                        <asp:LinkButton runat="server" ID="btnClose" CommandName="Close" CommandArgument='<%# Eval("Id") %>' ToolTip="Close/Re-Open Expedient">
                                        <i class="fas fa-folder-minus"></i>
                                        </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="It may be better to 'Close' record and leave a trace instead of deleting. Are you sure to Delete this record?"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                    </telerik:GridButtonColumn>

                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Clients_collection_SELECT" SelectCommandType="StoredProcedure" DeleteCommand="delete from [Clients_collection] where Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboStatus" Name="StatusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </DeleteParameters>

    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>

</asp:Content>
