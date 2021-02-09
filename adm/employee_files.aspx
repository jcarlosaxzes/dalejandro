<%@ Page Title="Uploaded Files" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master"
    CodeBehind="employee_files.aspx.vb" Inherits="pasconcept20.employee_files" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False" Visible="false" OnClick="btnBack_Click">
                       Back to List
            </asp:LinkButton>
            Employee Documents
        </span>
        <span style="float: right; vertical-align: middle;">Employee: 
           
            <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmpl" AutoPostBack="true"
                DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Width="400px" Height="300px"
                AppendDataBoundItems="true">
                <Items>
                    <telerik:RadComboBoxItem runat="server" Text="(Select Employee...)" Value="-1" Selected="true" />
                </Items>
            </telerik:RadComboBox>
        </span>
    </div>

    <div class="pas-container" style="width: 100%">
        <telerik:RadWizard ID="RadWizardFiles" runat="server" DisplayCancelButton="false" DisplayProgressBar="false" DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Silk">
            <WizardSteps>
                <%--Upload Files--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep4" Title="Upload Files" StepType="Step">
                    <asp:Panel ID="UploadPanel" runat="server">
                        <div style="width: 100%; height: 700px; position: relative">
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
                            <div class="uploadfiles-canvas">
                                <%--<telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" RenderMode="Lightweight" MultipleFileSelection="Automatic" OnFileUploaded="RadCloudUpload1_FileUploaded" CssClass="fileUploadRad" DropZones=".uploadfiles-canvas,#UploadPanel" ProviderType="Azure" MaxFileSize="1048576">
                                    <FileListPanelSettings PanelContainerSelector=".uploadfiles-canvas" />
                                </telerik:RadCloudUpload>
                                <p style="text-align: center; vertical-align: middle; padding-top: 100px; font-size: 36px">Upload your files</p>--%>
                                <p style="text-align: center; vertical-align: middle; padding-top: 150px;">
                                    <i style="font-size: 96px" class="fas fa-cloud-upload-alt"></i>
                                    <br />
                                    <span style="font-size: 36px">Drop Files here, or
                                                    </span>
                                    <br />
                                    <br />
                                    <br />
                                    <span style="font-size: 36px">
                                        <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" RenderMode="Lightweight" MultipleFileSelection="Automatic" ProviderType="Azure" MaxFileSize="1048576"
                                            OnFileUploaded="RadCloudUpload1_FileUploaded"
                                            CssClass="fileUploadRad"
                                            DropZones=".uploadfiles-canvas,#UploadPanel">
                                            <Localization SelectButtonText="Select Files" />
                                        </telerik:RadCloudUpload>
                                    </span>
                                </p>
                                <p style="text-align: center; margin: 0">
                                    <asp:Label runat="server" ID="lblMaxSize" ForeColor="Gray" Font-Size="Small" Text="[Maximum upload size per file: 1MB]"></asp:Label>
                                </p>

                            </div>


                        </div>
                    </asp:Panel>
                </telerik:RadWizardStep>

                <%--Files--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep21" Title="Files" StepType="Step">
                    <div>

                        <asp:Panel ID="pnlFind" runat="server" >
                            <table class="table-sm pasconcept-bar noprint" style="width: 100%">
                                <tr>
                                    <td>

                                    </td>

                                    <td style="width: 550px; text-align: right">
                                        
                                        <asp:LinkButton ID="btnTablePage" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnTablePage_Click">
                                               <i class="fas fa-align-justify"></i> Table
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnGridPage" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnTablePage_Click" Visible="false">
                                               <i class="fas fa-th"></i> Grid
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
                                    <div class="card-body">
                                        <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                                            <table style="width: 100%; flex-wrap: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                                <tr>
                                                    <td style="height: 108px">
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

                                                        <asp:Label ID="lblPubicHide" runat="server" Visible="False" Text='<%# Eval("Public") %>'></asp:Label>
                                                        <asp:Label ID="lblTypeHide" runat="server" Visible="False" Text='<%# Eval("Type") %>'></asp:Label>
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
        SelectCommand="Employee_azureuploads_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="azureuploads_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboEmployee" Name="EmployeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="lblSelectedId" Name="Id" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </DeleteParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDocTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Employee_azureuploads_types] ORDER BY [Id]"></asp:SqlDataSource>
   

    <asp:SqlDataSource ID="SqlDataSourceEmpl" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EMPLOYEES2_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

  
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedSource" runat="server" Visible="False"></asp:Label>
</asp:Content>


