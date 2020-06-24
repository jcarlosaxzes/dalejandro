<%@ Page Title="Uploaded Files" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="clientfiles.aspx.vb" Inherits="pasconcept20.clientfiles" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />--%>

    <style>
        .card-body {
            padding: 0.25rem;
        }

        .card-header {
            padding: 0 .50rem;
        }

        img {
            max-height: 96px;
            max-width: 200px;
            height: auto;
            width: auto;
        }
    </style>
    <div class="PanelFilter noprint">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
            <table onclick="table-sm pasconcept-bar noprint" width="100%">
                <tr>
                    <td style="width: 500px">
                        <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient" AutoPostBack="true"
                            DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Width="100%" Height="300px"
                            AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td style="width: 200px">
                        <telerik:RadComboBox ID="cboProposals" runat="server" DataSourceID="SqlDataSourceProposals" AutoPostBack="true"
                            DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Width="100%" Height="300px"
                            AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Proposals...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td style="width: 200px">
                        <telerik:RadTextBox ID="txtJob" runat="server" MaxLength="6" EmptyMessage="Job Code"></telerik:RadTextBox>
                    </td>
                    <td>
                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                            <i class="fas fa-search"></i> Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>


    <div class="pasconcept-bar noprint">
        <asp:LinkButton ID="btnDeleteSelected" runat="server"
            CssClass="btn btn-danger btn" UseSubmitBehavior="false">
                                     Delete selected!
        </asp:LinkButton>
        <span class="pasconcept-pagetitle" style="padding-left: 250px;">Client Files</span>
    </div>



    <div>
        <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="SqlDataSourceAzureFiles" DataKeyNames="Id" ItemPlaceholderID="Container1" BorderStyle="Solid">
            <LayoutTemplate>
                <fieldset style="width: 100%; text-align: center">
                    <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                </fieldset>

            </LayoutTemplate>
            <ItemTemplate>

                <div class="card" style="float: left; width: 230px; margin: 2px">
                    <div class="card-header">

                        <b style="display: inline-block; height: 22px; overflow: hidden; margin-top: 5px"><%# Eval("Name")%></b>

                    </div>
                    <div class="card-body">
                        <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                            <table style="width: 100%; flex-wrap: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                <tr>
                                    <td style="height:104px">
                                        <%# CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"))%>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td style="font-size:12px; padding-top:10px;">
                                         <%# FormatSource(Eval("Source"))%>:&nbsp<b><%# Eval("Document")%></b>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-size:12px">
                                         <%# Eval("Date", "{0:d}")%>,&nbsp;&nbsp;
                                         <%#  LocalAPI.FormatByteSize(Eval("ContentBytes"))%>
                                    </td>
                                </tr>                                
                            </table>
                        </asp:LinkButton>

                    </div>
                </div>

            </ItemTemplate>

        </telerik:RadListView>

        <%--        <telerik:RadGrid ID="RadGridAzureFiles" runat="server" DataSourceID="SqlDataSourceAzureFiles" GroupPanelPosition="Top" ShowFooter="true"
            AllowAutomaticUpdates="True" AllowPaging="True" PageSize="25" AllowSorting="True" AllowAutomaticDeletes="True">
            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id, Source" DataSourceID="SqlDataSourceAzureFiles"
                ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                <Columns>
                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridClientSelectColumn>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                        HeaderText="" HeaderStyle-Width="40px">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="Id" ReadOnly="True" HeaderText="Id" UniqueName="Id" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Source" ReadOnly="True" HeaderText="Source" UniqueName="Source" ItemStyle-Font-Size="X-Small"
                        HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Document" FilterControlAltText="Filter Document column" HeaderText="Document" SortExpression="Document"
                        UniqueName="Document" HeaderStyle-Width="80px" ReadOnly="true">
                        <ItemTemplate>
                            <%# Eval("Document")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="File Name" SortExpression="Name" UniqueName="Name"
                        ItemStyle-Font-Size="Medium" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="255" Width="100%"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)">
                            </asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <a href='<%# Eval("url")%>' target="_blank" download='<%# Eval("Name") %>'><%# Eval("Name")%></a>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date" SortExpression="Date" UniqueName="Date"
                        HeaderStyle-Width="80px" ReadOnly="true">
                        <ItemTemplate>
                            <%# Eval("Date", "{0:d}")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="ContentType" FilterControlAltText="Filter ContentType column" HeaderText="ContentType" SortExpression="ContentType"
                        UniqueName="ContentType" HeaderStyle-Width="80px" ReadOnly="true">
                        <ItemTemplate>
                            <%# Eval("ContentType")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="Type" FilterControlAltText="Filter nType column" HeaderText="Type" SortExpression="nType" UniqueName="Type"
                        HeaderStyle-Width="80px">
                        <ItemTemplate>
                            <%# Eval("nType")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="cboDocType2" runat="server" DataSourceID="SqlDataSourceDocTypes" DataTextField="Name"
                                DataValueField="Id" Width="100%" ToolTip="Select file type to Upload" SelectedValue='<%# Bind("Type")%>'>
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Public" FilterControlAltText="Filter Public column" HeaderText="Public" SortExpression="Public" UniqueName="Public"
                        HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        <EditItemTemplate>
                            <telerik:RadCheckBox ID="chkPublicEdit" runat="server" ToolTip="Public or private" Checked='<%# Bind("Public") %>' AutoPostBack="false"></telerik:RadCheckBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadCheckBox ID="chkPublicEdit" runat="server" ToolTip="Public or private" Checked='<%# Eval("Public") %>'></telerik:RadCheckBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn UniqueName="KBytes" DataFormatString="{0:N0}" ReadOnly="true" Aggregate="Sum"
                        SortExpression="KBytes" HeaderText="KBytes" DataField="KBytes"
                        HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>--%>
    </div>


    <asp:SqlDataSource ID="SqlDataSourceAzureFiles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="ClientProsalJob_azureuploads_v20_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="ClientProsalJob_azureuploads_v20_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommand="ClientProsalJob_azureuploads_v20_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboProposals" Name="proposalId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="JobId" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="lblSelectedSource" Name="Source" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblSelectedId" Name="Id" PropertyName="Text" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" />
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="Public" DbType="Boolean" />
            <asp:Parameter Name="Source" />
        </UpdateParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDocTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_azureuploads_types] ORDER BY [Id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_for_Files_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProposals" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSALS_for_Files_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_for_Files_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboProposals" Name="proposalId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblproposalId" runat="server" Visible="false" Text="0"></asp:Label>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedSource" runat="server" Visible="False"></asp:Label>
</asp:Content>


