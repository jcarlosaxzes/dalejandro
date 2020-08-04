<%@ Page Title="Pre-Projects" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="pre-projects.aspx.vb" Inherits="pasconcept20.pre_projects" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">

            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }

        </script>

    </telerik:RadCodeBlock>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <div class="pasconcept-bar noprint">

        <span class="pasconcept-pagetitle">Pre-Proposals</span>
        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
            <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                Add Pre-Proposal
            </asp:LinkButton>
        </span>

    </div>
    <div class="collapse" id="collapseFilter">
        <asp:Panel CssClass="PanelFilter noprint" ID="pnlFind" runat="server">
            <table class=" table-condensed pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 150px">
                        <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="Pending" Value="0" Selected="true" />
                                <telerik:RadComboBoxItem runat="server" Text="Processed" Value="1" />
                                <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 350px">
                        <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient"
                            Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px"
                            AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 300px">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name"
                            DataValueField="Id" Width="100%" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech"
                            EmptyMessage="Name, Description, Location..." Width="100%">
                        </telerik:RadTextBox>
                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                            <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>

    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
        AutoGenerateColumns="False" AllowAutomaticDeletes="True"
        AllowPaging="True" PageSize="25" AllowSorting="True" CellSpacing="0">
        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
            <PagerStyle Mode="Slider" AlwaysVisible="false" />
            <Columns>
                <telerik:GridTemplateColumn DataField="Id" HeaderText="Number"
                    SortExpression="Id" UniqueName="Id" ItemStyle-HorizontalAlign="Center"
                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                    <ItemTemplate>
                        <div>
                            <asp:LinkButton ID="btnEditProj" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Pre-Project"
                                CommandName="EditPre_Project">
                                                <%# Eval("Pre_ProjectNumber")%>
                                                <span title="Number of files uploaded" class="badge badge-pill badge-danger" style='<%# IIf(Eval("PreProjectUploadFiles")=0,"display:none","display:normal")%>'>
                                                <%#Eval("PreProjectUploadFiles")%>
                                            </span>
                            </asp:LinkButton>
                        </div>
                        <div>
                            <a href='<%# "clientfiles?client=" & LocalAPI.GetClientProperty(LocalAPI.GetPreProjectProperty(Eval("Id"), "clientId"), "guid") %>' target="_blank" title="Upload Files">
                                    <i class="fas fa-cloud-upload-alt"></i>                                                
                            </a>
                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnNewProposal" runat="server" CommandName="NewProposal" CommandArgument='<%# Eval("Id") %>' Visible='<%# Eval("statusId") = 0 %>' ToolTip="Create new Proposal">
                                                <i class="fas fa-file-export"></i>
                                            </asp:LinkButton>
                            <asp:LinkButton ID="btnEditProp" runat="server" CommandArgument='<%# Eval("proposalId") %>' ToolTip="Click to View/Edit Proposal" Font-Size="X-Small"
                                CommandName="EditProposal" Text='<%# Eval("ProposalNumber")%>' Visible='<%# Eval("statusId") = 1 And Eval("proposalId") > 0 %>'>
                            </asp:LinkButton>

                        </div>

                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridBoundColumn DataField="DateIn" DataFormatString="{0:MM/dd/yy}" DataType="System.DateTime"
                    HeaderText="Date" SortExpression="DateIn" UniqueName="DateIn"
                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" AllowFiltering="False" HeaderStyle-Width="80px">
                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn DataField="Name" ItemStyle-HorizontalAlign="Left"
                    FilterControlAltText="Filter Name column" HeaderText="Name<br/>Type" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <div>
                            <%# Eval("Name") %>
                        </div>
                        <div>
                           <small> <%# Eval("nProjectType") %></small>
                        </div>

                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="clientId" ItemStyle-HorizontalAlign="Left"
                    FilterControlAltText="Filter ClientName column" HeaderText="Client <br/>Proposal By - Prepared By" SortExpression="ClientName" UniqueName="ClientName" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <div>
                            <%# Eval("ClientName") %>
                        </div>
                        <div>
                           <small><%# String.Concat(Eval("ProposalByName"), " - ", Eval("PreparedByName")) %></small>
                        </div>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>


                <telerik:GridTemplateColumn DataField="Status" HeaderText="Status" SortExpression="Status"
                    UniqueName="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="true" HeaderStyle-Width="120px">
                    <ItemTemplate>
                        <div style="font-size: 12px; width: 100%"
                            class='<%# LocalAPI.GetPre_ProjectsStatusLabelCSS(Eval("statusId")) %>'>
                            <%# Eval("Status") %>
                        </div>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                </telerik:GridButtonColumn>
            </Columns>
            <EditFormSettings>
                <PopUpSettings Modal="true" Width="700px" />
                <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                </EditColumn>
            </EditFormSettings>
        </MasterTableView>
        <FilterMenu EnableImageSprites="False">
        </FilterMenu>
        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
        </HeaderContextMenu>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Pre_Projects_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="DELETE FROM Clients_pre_projects WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="statusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>


