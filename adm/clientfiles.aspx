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
        .fileUploadRad {
            position:absolute;
            margin-top:80px;
            width:100%;
        }
    </style>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False" Visible="false" OnClick="btnBack_Click">
                       Back to List
            </asp:LinkButton>
            Client Uploaded Files
        </span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
            <asp:LinkButton ID="btnDeleteSelected" runat="server"
                CssClass="btn btn-danger" UseSubmitBehavior="false">
                   <i class="fas fa-trash"></i>&nbsp;Bulk Delete
            </asp:LinkButton>
            <asp:LinkButton ID="btnBulkEdit" runat="server"
                CssClass="btn btn-primary" UseSubmitBehavior="false">
                   <i class="fas fa-pencil-alt"></i>&nbsp; Bulk Update
            </asp:LinkButton>
        </span>


    </div>


    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
            <table onclick="table-sm pasconcept-bar noprint" width="100%">
                <tr>
                    <td style="width: 500px">
                        <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient" AutoPostBack="true"
                            DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Width="100%" Height="300px"
                            AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(Select Client...)" Value="-1" Selected="true" />
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
                    <td >
                        <telerik:RadTextBox ID="txtJob" runat="server" MaxLength="6" EmptyMessage="Job Code" Width="250px"></telerik:RadTextBox>
                    </td>
                    <td style="width: 150px;text-align:right">
                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                            <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>




    <div>
        <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="SqlDataSourceAzureFiles" DataKeyNames="Id" ItemPlaceholderID="Container1" BorderStyle="Solid" AllowMultiItemSelection="true">
            <LayoutTemplate>
                <fieldset style="width: 100%; text-align: center">
                    <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                </fieldset>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="card" style="float: left; width: 230px; margin: 2px">
                    <div class="card-header">
                        <asp:LinkButton ID="LinkButton1" CssClass="selectedButtons" runat="server" CommandName="Select">
                            <i class="far fa-square" aria-hidden="true" style="float: left;margin-top: 10px;color: black;"></i>
                        </asp:LinkButton>
                        
                        <b style="display: inline-block; height: 22px; overflow: hidden; margin-top: 5px; width: 80%;"><%# FormatSource(Eval("Source"))%>:&nbsp <%# Eval("Document")%></b>

                    </div>
                    <div class="card-body">
                        <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                            <table style="width: 100%; flex-wrap: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                <tr>
                                    <td style="height:108px">
                                        <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"))%>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td style="font-size:12px; padding-top:5px;padding-bottom: 0px;">
                                        <%# LocalAPI.TruncateString(Eval("Name"), 30)%> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-size:12px;padding: 0;">
                                         <%# Eval("Date", "{0:d}")%>,&nbsp;&nbsp;
                                         <%#  LocalAPI.FormatByteSize(Eval("ContentBytes"))%>
                                    </td>
                                </tr>                                 
                                <tr>
                                    <td style="font-size:12px;padding: 0;">
                                       Type:   <%# Eval("nType")%>
                                    </td>
                                </tr> 
                                <tr>
                                    <td style="font-size:12px;padding: 0;">
                                     <%#IIf(Eval("Public"), "Public", "Private") %>
                                    </td>
                                </tr>
                               
                            </table>
                        </asp:LinkButton>

                    </div>
                </div>

            </ItemTemplate>
            <SelectedItemTemplate>
                <div class="card" style="float: left; width: 230px; margin: 2px">
                    <div class="card-header">
                        <asp:LinkButton ID="LinkButton1" CssClass="selectedButtons" runat="server" CommandName="Deselect">
                            <i class="fa fa-check-square" aria-hidden="true" style="float: left;margin-top: 10px;color: black;"></i>
                        </asp:LinkButton>

                        <b style="display: inline-block; height: 22px; overflow: hidden; margin-top: 5px; width: 80%;"><%# FormatSource(Eval("Source"))%>:&nbsp <%# Eval("Document")%></b>

                    </div>
                    <div class="card-body">
                        <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                            <table style="width: 100%; flex-wrap: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                <tr>
                                    <td style="height:108px">
                                        <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"))%>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td style="font-size:12px; padding-top:5px;padding-bottom: 0px;">
                                        <asp:Label ID="lblFileName" runat="server" Visible="False" Text='<%# Bind("Name") %>' ></asp:Label>
                                        <%# LocalAPI.TruncateString(Eval("Name"), 30)%> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-size:12px;padding: 0;">
                                         <%# Eval("Date", "{0:d}")%>,&nbsp;&nbsp;
                                         <%#  LocalAPI.FormatByteSize(Eval("ContentBytes"))%>
                                    </td>
                                </tr>                                 
                                <tr>
                                    <td style="font-size:12px;padding: 0;">
                                       Type:   <%# Eval("nType")%>
                                    </td>
                                </tr> 
                                <tr>
                                    <td style="font-size:12px;padding: 0;">
                                     <%#IIf(Eval("Public"), "Public", "Private") %>
                                    </td>
                                </tr>                             
                            </table>
                        </asp:LinkButton>

                    </div>
                </div>

            </SelectedItemTemplate>

        </telerik:RadListView>
        <asp:Panel ID="UploadPanel" runat="server">            
            <div style="width: 100%; height: 300px; background-color: lightgray; margin-top: 20px; position:relative">                
                
                <table class="table-sm" style="width: 100%; position:absolute;margin-top:0px;">
                    <tr>
                        <td style="width: 40%;">
                            <telerik:RadComboBox ID="cboDocType" runat="server" DataSourceID="SqlDataSourceDocTypes" Label="File type:" DataTextField="Name" DataValueField="Id" Width="100%">
                            </telerik:RadComboBox>
                        </td>
                        <td style="width: 30%;">
                            <telerik:RadCheckBox ID="chkPublic" runat="server" Text="Public" ToolTip="Public or private"  AutoPostBack="false"></telerik:RadCheckBox>
                        </td>                           
                        <td style="width: 30%;" rowspan="2">
                            <asp:LinkButton ID="btnSaveUpload" runat="server" CssClass="btn btn-success btn float-right" UseSubmitBehavior="false" ToolTip="Upload and Save selected files">
                            <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp;Upload
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%; position:absolute;margin-top:40px;" >
                    <tr>
                        <td style="width: 90%;">
                            <h3 class="additional-text">Select Files to Upload</h3>
                        </td>
                    </tr>
                </table>
                <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" RenderMode="Lightweight" MultipleFileSelection="Automatic" OnFileUploaded="RadCloudUpload1_FileUploaded"
                    ProviderType="Azure" MaxFileSize="1048576" CssClass="h-100 fileUploadRad">
                </telerik:RadCloudUpload>

            </div>
        </asp:Panel>

    </div>


    <telerik:RadToolTip ID="RadToolTipBulkEdit" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table table-bordered" style="width: 500px">
            <tr>
                <td colspan="2">
                    <h2 style="margin: 0; text-align: center; color: white; width: 600px">
                        <span class="navbar navbar-expand-md bg-dark text-white">Update Files</span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                        <telerik:RadComboBox ID="cboDocTypeBulk" runat="server" DataSourceID="SqlDataSourceDocTypes" ZIndex="10000" Label="File type:" DataTextField="Name" DataValueField="Id" Width="100%">
                        </telerik:RadComboBox>
                 </td> 
            </tr>
            <tr>                
                <td style="width: 20%;">
                    <telerik:RadCheckBox ID="chkPublicBulk" runat="server" Text="Public" ToolTip="Public or private"></telerik:RadCheckBox>
                </td> 
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnUpdateStatus" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="120px" ValidationGroup="Reconcile">
                                    <i class="fas fa-check"></i> Update
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCance" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="120px">
                                     Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipDelete" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Delete Proposal
            </span>
        </h2>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td>Are you sure you want to delete selected Files?
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="btnConfirmDelete" runat="server" CssClass="btn btn-danger" Width="150px" UseSubmitBehavior="false">
                             Delete 
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancelDelete" runat="server" CssClass="btn btn-secondary" Width="150px" UseSubmitBehavior="false">
                             Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSourceAzureFiles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="ClientProsalJob_azureuploads_v20_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="ClientProsalJob_azureuploads_v20_DELETE" DeleteCommandType="StoredProcedure">
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

     <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_azureuploads_types] ORDER BY [Id]"></asp:SqlDataSource>

    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblproposalId" runat="server" Visible="false" Text="0"></asp:Label>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedSource" runat="server" Visible="False"></asp:Label>
</asp:Content>


