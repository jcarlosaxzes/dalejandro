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
            .RadTabStrip .rtsLI, .RadTabStripVertical .rtsLI {
                line-height: 10px;
            }

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

    </telerik:RadCodeBlock>

    <div class="container">
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
                                    <div style="width: 100%; height: 200px; background-color: lightgray; margin-top: 20px; position:relative">                
                
                                        <table class="table-sm" style="width: 100%; position:absolute;margin-top:0px;">
                                            <tr>
                                                <td style="width: 40%;">
                                                    <telerik:RadComboBox ID="cboDocType" runat="server" DataSourceID="SqlDataSourceDocTypes" Label="File type:" DataTextField="Name" DataValueField="Id" Width="100%">
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 30%;">
                                                    <telerik:RadCheckBox ID="chkPublic" runat="server" Text="Public" ToolTip="Public or private"></telerik:RadCheckBox>
                                                </td>                           
                                                <td style="width: 30%;" rowspan="2">
                                                    <asp:LinkButton ID="btnDeleteSelected" runat="server"
                                                        CssClass="btn btn-danger float-right mr-3" UseSubmitBehavior="false">
                                                            <i class="fas fa-trash"></i>&nbsp;Bulk Delete
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnBulkEdit" runat="server"
                                                        CssClass="btn btn-primary float-right mr-3" UseSubmitBehavior="false">
                                                             <i class="fas fa-pencil-alt"></i>&nbsp; Bulk Update
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnSaveUpload" runat="server" CssClass="btn btn-success btn float-right  mr-3" UseSubmitBehavior="false" ToolTip="Upload and Save selected files">
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

    <telerik:RadToolTip ID="RadToolTipDeleteFiles" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
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


    <br />
    <telerik:RadWindowManager ID="RadWindowManager2" runat="server">
        <Windows>
            <telerik:RadWindow ID="RadWindowDropBox"
                NavigateUrl="~/ADMCLI/DropboxChooser.aspx?Origen=1&JobId=<%=lblId.Text%>"
                VisibleOnPageLoad="false" Behaviors="Close, Move" Modal="true" Top="20" Left="100" Height="450px" Width="650px" runat="server" VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

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
</asp:Content>

