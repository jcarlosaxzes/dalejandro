<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_links.aspx.vb" Inherits="pasconcept20.job_links" %>

<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">
            function CallDropbox(sender, args) {
                var RadWindow = $find("<%=RadWindowDropBox.ClientID%>");
                RadWindow.show();
            }
            function onClientUploadFailed(sender, eventArgs) {
                alert(eventArgs.get_message())
            }
        </script>
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
                position: absolute;
                margin-top: 80px;
                width: 100%;
            }
        </style>
    </telerik:RadCodeBlock>

    <div class="container">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td>
                    <div class="pas-container" style="width: 100%">
                        <asp:Panel ID="PanelUpload" runat="server">
                            <table onclick="table-sm pasconcept-bar noprint" width="100%">
                                <tr>
                                    <td style="width: 550px; text-align: right">
                                        <asp:LinkButton ID="btnListFiles" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnListFiles_Click">
                                                               <i class="fas fa-align-justify"></i>&nbsp;&nbsp;View Files
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <telerik:RadWizard ID="RadWizardFiles" runat="server" DisplayCancelButton="false" DisplayProgressBar="false"
                            DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Silk" DisplayNavigationBar="false">
                            <WizardSteps>
                                <%--Upload Files--%>
                                <telerik:RadWizardStep runat="server" ID="RadWizardStep4" Title="Upload Files" StepType="Step">
                                    <asp:Panel ID="UploadPanel" runat="server">
                                        <div style="width: 100%; height: 500px; position: relative">
                                            <table class="table-sm" style="width: 100%; position: absolute; margin-top: 0px; background-color: lightgray;">
                                                <tr>
                                                    <td style="width: 40%;">
                                                        <telerik:RadComboBox ID="cboDocType" runat="server" DataSourceID="SqlDataSourceDocTypes" Label="File type:" DataTextField="Name" DataValueField="Id" Width="100%">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td style="width: 30%;">
                                                        <telerik:RadCheckBox ID="chkPublic" runat="server" Text="Public" ToolTip="Public or private" AutoPostBack="false"></telerik:RadCheckBox>
                                                    </td>
                                                    <td style="width: 30%;" rowspan="2">
                                                        <asp:LinkButton ID="btnSaveUpload" runat="server" CssClass="btn btn-success btn float-right" UseSubmitBehavior="false" ToolTip="Upload and Save selected files">
                                                    <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp;Upload
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table style="width: 100%; position: absolute; margin-top: 40px; background-color: lightgray; height: 100px;">
                                                <tr>
                                                    <td style="width: 90%; vertical-align: top;">
                                                        <h3 class="additional-text">Select Files to Upload</h3>
                                                    </td>
                                                </tr>
                                            </table>
                                            <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" RenderMode="Lightweight" MultipleFileSelection="Automatic" OnFileUploaded="RadCloudUpload1_FileUploaded"
                                                ProviderType="Azure" MaxFileSize="1048576" CssClass="h-100 fileUploadRad">
                                            </telerik:RadCloudUpload>
                                        </div>
                                    </asp:Panel>
                                </telerik:RadWizardStep>

                                <%--Files--%>
                                <telerik:RadWizardStep runat="server" ID="RadWizardStep21" Title="Files" StepType="Step">
                                    <div>
                                        <asp:Panel ID="pnlFind" runat="server">
                                            <table onclick="table-sm pasconcept-bar noprint" width="100%">
                                                <tr>
                                                    <td style="width: 550px; text-align: right">
                                                        <asp:LinkButton ID="btnTablePage" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnTablePage_Click">
                                                               <i class="fas fa-align-justify"></i> Table
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnGridPage" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnTablePage_Click" Visible="false">
                                                               <i class="fas fa-th"></i> Grid
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnUploadFiles" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" OnClick="btnUploadFiles_Click">
                                                               <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp; Uploads
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnBulkDelete" runat="server"
                                                            CssClass="btn btn-danger" UseSubmitBehavior="false">
                                                               <i class="fas fa-trash"></i>&nbsp;Bulk Delete
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnBulkEdit" runat="server"
                                                            CssClass="btn btn-primary" UseSubmitBehavior="false">
                                                               <i class="fas fa-pencil-alt"></i>&nbsp; Bulk Update
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>

                                        <telerik:RadListView ID="RadListViewFiles" runat="server" DataSourceID="SqlDataSourceAzureFiles" DataKeyNames="Id" ItemPlaceholderID="Container1" BorderStyle="Solid" AllowMultiItemSelection="true">
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

                                                        <b style="display: inline-block; height: 22px; overflow: hidden; margin-top: 5px; width: 80%;" title="<%# Eval("Name")%> "><%# LocalAPI.TruncateString(Eval("Name"), 20)%> </b>

                                                        <asp:LinkButton ID="LinkButton2" CssClass="selectedButtons" runat="server" CommandName="Update">
                                                            <i class="far fa-edit" aria-hidden="true" style="float: right;margin-top: 10px;color: black;"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div class="card-body" style="padding: 0px; margin-top: -6px;">
                                                        <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                                                            <table style="width: 100%; flex-wrap: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                                                <tr>
                                                                    <td style="height: 108px; padding: 0px;">
                                                                        <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"), 96)%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding-top: 5px; padding-bottom: 0px;">
                                                                        <%# FormatSource(Eval("Source"))%>:&nbsp <%# Eval("Document")%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">
                                                                        <%# Eval("Date", "{0:d}")%>,&nbsp;&nbsp;
                                                                             <%#  LocalAPI.FormatByteSize(Eval("ContentBytes"))%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">Type:   <%# Eval("nType")%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">
                                                                        <%#IIf(Eval("Public"), "Public", "Private") %>

                                                                        <asp:Label ID="lblPubicHide" runat="server" Visible="False" Text='<%# Eval("Public") %>'></asp:Label>
                                                                        <asp:Label ID="lblTypeHide" runat="server" Visible="False" Text='<%# Eval("Type") %>'></asp:Label>
                                                                        <asp:Label ID="lblNameHide" runat="server" Visible="False" Text='<%# Eval("Name") %>'></asp:Label>
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

                                                        <b style="display: inline-block; height: 22px; overflow: hidden; margin-top: 5px; width: 80%;" title="<%# Eval("Name")%> "><%# LocalAPI.TruncateString(Eval("Name"), 20)%> </b>

                                                        <asp:LinkButton ID="LinkButton2" CssClass="selectedButtons" runat="server" CommandName="Update">
                                                            <i class="far fa-edit" aria-hidden="true" style="float: right;margin-top: 10px;color: black;"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div class="card-body" style="padding: 0px; margin-top: -6px;">
                                                        <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                                                            <table style="width: 100%; flex-wrap: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                                                <tr>
                                                                    <td style="height: 108px; padding: 0px;">
                                                                        <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"), 96)%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding-top: 5px; padding-bottom: 0px;">
                                                                        <asp:Label ID="lblFileName" runat="server" Visible="False" Text='<%# Bind("Name") %>'></asp:Label>
                                                                        <%# FormatSource(Eval("Source"))%>:&nbsp <%# Eval("Document")%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">
                                                                        <%# Eval("Date", "{0:d}")%>,&nbsp;&nbsp;
                                                                         <%#  LocalAPI.FormatByteSize(Eval("ContentBytes"))%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">Type:   <%# Eval("nType")%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">
                                                                        <%#IIf(Eval("Public"), "Public", "Private") %>

                                                                        <asp:Label ID="lblPubicHide" runat="server" Visible="False" Text='<%# Eval("Type") %>'></asp:Label>
                                                                        <asp:Label ID="lblTypeHide" runat="server" Visible="False" Text='<%# Eval("Name") %>'></asp:Label>
                                                                        <asp:Label ID="lblNameHide" runat="server" Visible="False" Text='<%# Eval("Name") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:LinkButton>

                                                    </div>
                                                </div>
                                            </SelectedItemTemplate>
                                        </telerik:RadListView>

                                        <telerik:RadGrid ID="RadGridFiles" runat="server" DataSourceID="SqlDataSourceAzureFiles" GridLines="None" Visible="false"
                                            AllowPaging="True" PageSize="25" AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center" OnItemCommand="RadGridFiles_ItemCommand" AllowMultiRowSelection="true">
                                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceAzureFiles"
                                                HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                                                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                                <Columns>
                                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                                    </telerik:GridClientSelectColumn>
                                                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" HeaderStyle-Width="40px">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn DataField="Name" HeaderText="FileName" UniqueName="Name" SortExpression="Name" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-Width="300px" HeaderStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"), 16)%>
                                                            &nbsp;&nbsp;
                                                            <%# Eval("Name")%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="Type" HeaderText="Type" UniqueName="Type" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <%# Eval("nType")%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="Public" HeaderText="Public" UniqueName="Public" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <%#IIf(Eval("Public"), "Public", "Private") %>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="Source" HeaderText="Source" UniqueName="Source" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <%# FormatSource(Eval("Source"))%>:&nbsp <%# Eval("Document")%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="Size" HeaderText="Size" UniqueName="Size" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <%#  LocalAPI.FormatByteSize(Eval("ContentBytes"))%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="Date" HeaderText="Date" UniqueName="Date" SortExpression="Date" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count">
                                                        <ItemTemplate>
                                                            <%# Eval("Date", "{0:d}")%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                                                        <ItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Update" CommandArgument='<%# Eval("Id") %>' ToolTip="Edit">
                                                                            <span class="fas fa-edit"></span>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                    <td>&nbsp;&nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("Id") %>' ToolTip="Edit">
                                                                            <span class="fas fa-trash"></span>
                                                                        </asp:LinkButton>
                                                                        <asp:Label ID="lblPubicHide" runat="server" Visible="False" Text='<%# Eval("Public") %>'></asp:Label>
                                                                        <asp:Label ID="lblTypeHide" runat="server" Visible="False" Text='<%# Eval("Type") %>'></asp:Label>
                                                                        <asp:Label ID="lblNameHide" runat="server" Visible="False" Text='<%# Eval("Name") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>

                                            </MasterTableView>

                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true" />
                                            </ClientSettings>
                                        </telerik:RadGrid>

                                    </div>
                                </telerik:RadWizardStep>
                            </WizardSteps>
                        </telerik:RadWizard>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <h3>Job Links</h3>
                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td style="padding-left: 15px">
                                <asp:LinkButton ID="btnNewFileLink" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false" ToolTip="Attached uploaded file">
                                        Add Hyperlink
                                </asp:LinkButton>
                                &nbsp;&nbsp;&nbsp;

                            <asp:LinkButton ID="btnDropbox" runat="server" CssClass="btn btn-secondary" UseSubmitBehavior="false" CausesValidation="false" ToolTip="Upload or attached file" Visible="false"
                                OnClientClick="CallDropbox">
                                           Dropbox
                            </asp:LinkButton>

                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="RadGridLinks" runat="server" DataSourceID="SqlDataSourceLinks" GridLines="None" AllowAutomaticInserts="true"
                        AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" CellSpacing="0">
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceLinks"
                            ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" HeaderText="" HeaderStyle-Width="40px" UniqueName="EditCommandColumn">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="ID" ReadOnly="True"
                                    SortExpression="Id" UniqueName="Id" Display="False">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="Title" FilterControlAltText="Filter Title column"
                                    HeaderText="Title" SortExpression="Title" UniqueName="Title" HeaderStyle-HorizontalAlign="Center">
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' MaxLength="80"></telerik:RadTextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <a href='<%# Eval("link")%>' target="_blank"><%# Eval("Title")%></a>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Descripciption" FilterControlAltText="Filter Descripciption column"
                                    HeaderText="Description" SortExpression="Descripciption" UniqueName="Descripciption" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%# Eval("Descripciption")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="DescripciptionTextBox" runat="server" Rows="3" Text='<%# Bind("Descripciption") %>' Width="600px" MaxLength="1024"></telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Link" FilterControlAltText="Filter Link column" Display="false"
                                    HeaderText="Link (url)" SortExpression="Link" UniqueName="Link" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%# Eval("Link")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="LinkTextBox" runat="server" Text='<%# Bind("Link") %>' Width="600px" MaxLength="256"></telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this link?"
                                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                    UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn FilterControlAltText="Filter EditCommandColumn1 column" ButtonType="PushButton"
                                    UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>




    </div>
    <br />
    <telerik:RadWindowManager ID="RadWindowManager2" runat="server">
        <Windows>
            <telerik:RadWindow ID="RadWindowDropBox"
                NavigateUrl="~/ADMCLI/DropboxChooser.aspx?Origen=1&JobId=<%=lblId.Text%>"
                VisibleOnPageLoad="false" Behaviors="Close, Move" Modal="true" Top="20" Left="100" Height="450px" Width="650px" runat="server" VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>


    <telerik:RadToolTip ID="RadToolTipBulkEdit" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table table-bordered" style="width: 500px">
            <tr>
                <td colspan="2">
                    <h3 style="margin: 0; text-align: center; color: white; width: 600px">
                        <span class="navbar navbar-expand-md bg-dark text-white">Update Files</span>
                    </h3>
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
                    <telerik:RadCheckBox ID="chkPublicBulk" runat="server" Text="Public" ToolTip="Public or private" AutoPostBack="false"></telerik:RadCheckBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnUpdateStatusFiles" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="120px" ValidationGroup="Reconcile">
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

    <telerik:RadToolTip ID="RadToolTipBulkDelete" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h3 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Delete Files
            </span>
        </h3>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td>Are you sure you want to delete selected Files?
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="btnConfirmDeleteFiles" runat="server" CssClass="btn btn-danger" Width="150px" UseSubmitBehavior="false">
                             Delete 
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancelDeleteFiles" runat="server" CssClass="btn btn-secondary" Width="150px" UseSubmitBehavior="false">
                             Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>


    <asp:SqlDataSource ID="SqlDataSourceAzureFiles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="ClientProsalJob_azureuploads_v20_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="ClientProsalJob_azureuploads_v20_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommand="ClientProsalJob_azureuploads_v20_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblClientId" Name="clientId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblproposalId" Name="proposalId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Source" />
            <asp:Parameter Name="Id" />
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

    <asp:SqlDataSource ID="SqlDataSourceLinks" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Jobs_links] WHERE [Id] = @Id"
        InsertCommand="INSERT INTO [Jobs_links] ([Job], [Title], [Descripciption], [Link]) VALUES (@Job, @Title, @Descripciption, @Link)"
        SelectCommand="SELECT Id, Job, Title, Descripciption, Link FROM Jobs_links WHERE (Job = @Job) ORDER BY Title"
        UpdateCommand="UPDATE [Jobs_links] SET  [Title] = @Title, [Descripciption] = @Descripciption, [Link] = @Link WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Descripciption" Type="String" />
            <asp:Parameter Name="Link" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" DefaultValue="0" Name="Job" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="Job" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Descripciption" Type="String" />
            <asp:Parameter Name="Link" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblClientId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblproposalId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedSource" runat="server" Visible="False"></asp:Label>
</asp:Content>

