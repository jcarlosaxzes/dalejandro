<%@ Page Title="Subconsultants" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="subconsultants.aspx.vb" Inherits="pasconcept20.subconsultants" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    </telerik:RadWindowManager>

    <div class="Formulario">
        <table class="table-condensed">
            <tr>
                <td>
                    <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                        <span class="glyphicon glyphicon-filter"></span>&nbsp;Filter
                    </button>
                </td>
                <td>
                    <asp:LinkButton ID="btnNewSubconsultant" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    <span class="glyphicon glyphicon-plus"></span> Subconsultant
                    </asp:LinkButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnprint" OnClientClicked="PrintPage" Text="Print Page" runat="server" AutoPostBack="false" UseSubmitBehavior="false">
                        <Icon PrimaryIconCssClass=" rbPrint"></Icon>
                    </telerik:RadButton>
                </td>
                <td>
                    <telerik:RadLinkButton ID="btnImport" runat="server" Text="Import Data" NavigateUrl="~/ADM/ImportData.aspx?source=subconsultants" ToolTip="Import records from CSV files" UseSubmitBehavior="false">
                        <Icon CssClass="rbUpload"></Icon>
                    </telerik:RadLinkButton>
                </td>
            </tr>
        </table>
    </div>

    <div class="collapse" id="collapseFilter">
        <div class="card card-body">
            <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                <table class="table-condensed">
                    <tr>
                        <td>
                            <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="600px"
                                EmptyMessage="Search for Name, Organization... ">
                            </telerik:RadTextBox>
                        </td>
                        <td>
                            <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-search"></span> Search
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
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
                <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" AllowAutomaticDeletes="true"
            DataSourceID="SqlDataSource1" GridLines="None" AllowPaging="True" PageSize="250" Height="700px"
            CellSpacing="0" AllowSorting="True" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" CommandItemDisplay="None" ShowFooter="True" EditMode="PopUp">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridTemplateColumn Aggregate="Count" DataField="Name" FilterControlAltText="Filter Name column"
                        FooterAggregateFormatString="{0:N0}" HeaderText="Name & Company" SortExpression="Name"
                        UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div>
                                <strong>
                                    <asp:LinkButton ID="btnEditSubconsultant" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Subconsultant"
                                        CommandName="EditSubconsultant" Text='<%# Eval("Name")%>' UseSubmitBehavior="false">
                                    </asp:LinkButton>
                                </strong>
                            </div>
                            <b><%# Eval("Organization")%></b> &nbsp;&nbsp;&nbsp;<%# Eval("Position") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Code" FilterControlAltText="Filter Code column"
                        HeaderText="SubC. Code" SortExpression="Code" UniqueName="Code" HeaderStyle-HorizontalAlign="Center" Display="false">
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="disciplineId" DataType="System.Int32" Display="False"
                        FilterControlAltText="Filter disciplineId column" HeaderText="Discipline" SortExpression="disciplineId"
                        UniqueName="disciplineId">
                        <ItemTemplate>
                            <asp:Label ID="disciplineIdLabel" runat="server" Text='<%# Eval("disciplineId") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Address" FilterControlAltText="Filter Address column"
                        HeaderText="Address" SortExpression="Address" UniqueName="Address" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div><a class="lnkGrid" href="http://maps.google.com/?q=<%# Eval("Address")%> <%# Eval("Address2")%>,<%# Eval("City")%>,<%# Eval("State")%> <%# Eval("ZipCode")%>" target="_blank" title="view google subconsultant address"><%# Eval("Address")%> &nbsp;<%# Eval("Address2")%>,&nbsp;<%# Eval("City")%>,&nbsp;<%# Eval("State")%>&nbsp;<%# Eval("ZipCode")%></a></div>
                            <%# String.Concat(Eval("Telephone"), " ", Eval("CellPhone"))%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                   
                    <telerik:GridTemplateColumn DataField="Email" FilterControlAltText="Filter Email column"
                        HeaderText="Email & Web" SortExpression="Email" UniqueName="Email" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="250px">
                        <ItemTemplate>
                            <div><a href='<%#String.Concat("mailto:", Eval("Email")) %>' title="Mail to"><%#Eval("Email") %></a></div>
                            <a class="lnkGrid" href='<%# Eval("WebPage")%>' target="_blank" title="View web"><%#Eval("WebPage")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn ReadOnly="True" HeaderText="Actions" UniqueName="credentials" HeaderTooltip="Actions"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>

                            <table style="width:100%">
                                <tr>
                                    <td style="width:50%;text-align:center">
                                        <a href='<%# LocalAPI.GetSharedLink_URL(2001, Eval("Id"))%>' target="_blank" title="View Subconsultant Portal">
                                            <span class="glyphicon glyphicon-share"></span></a>
                                        </a>
                                    </td>
                                    <td style="text-align:center">
                                        <asp:LinkButton ID="btnCredentials" runat="server" UseSubmitBehavior="false" ToolTip="Send Email with credentials"
                                                CommandName="SendCredential" CommandArgument='<%#Eval("Id")%>'>
                                                <span class="glyphicon glyphicon-envelope"></span></a>
                                            </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this Subconsultant and asociate user?" ConfirmTitle="Delete"
                        ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                        HeaderText="" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings>
                    <PopUpSettings Modal="true" Width="800px" />
                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                    </EditColumn>
                </EditFormSettings>

            </MasterTableView>
        </telerik:RadGrid>

    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SUBCONSULTANS_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="SUBCONSULTANT_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter"
                PropertyName="Text" Type="String" />
        </SelectParameters>

    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelected" runat="server" Visible="False"></asp:Label>
</asp:Content>
