<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_links.aspx.vb" Inherits="pasconcept20.job_links" %>

<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
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

    </telerik:RadCodeBlock>

    <div class="container">
        <table class="table" style="width: 100%">
            <tr>
                <td>
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td colspan="3">
                                <asp:Panel runat="server" class="DropZoneClient">
                                    <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" MultipleFileSelection="Automatic" OnClientUploadFailed="onClientUploadFailed"
                                        OnFileUploaded="RadCloudUpload1_FileUploaded" ProviderType="Azure"
                                        MaxFileSize="100145728"
                                        DropZones=".DropZoneClient">
                                    </telerik:RadCloudUpload>
                                    <p style="margin: 0">To Add/Upload documents to client: </p>
                                    <ol style="text-align: left; padding-left: 25px">
                                        <li>Select or Drag and Drop source files</li>
                                        <li>Select document Type</li>
                                        <li>Check/Uncheck Public</li>
                                        <li>Press Upload</li>
                                    </ol>
                                    <h4>Select or Drag and Drop files (up to 100Mb)</h4>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 350px;">
                                <telerik:RadComboBox ID="cboDocType" runat="server" DataSourceID="SqlDataSourceDocTypes" Label="File type:" DataTextField="Name" DataValueField="Id" Width="100%">
                                </telerik:RadComboBox>
                            </td>
                            <td style="width: 250px;">
                                <telerik:RadCheckBox ID="chkPublic" runat="server" Text="Public" ToolTip="Public or private"></telerik:RadCheckBox>
                            </td>
                            <td style="text-align: right">
                                <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" ToolTip="Upload and Save selected files">
                    <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp;Upload
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="RadGridAzureFiles" runat="server" DataSourceID="SqlDataSourceAzureFiles" GroupPanelPosition="Top" ShowFooter="true"
                        AllowAutomaticUpdates="True" AllowPaging="True" PageSize="25" AllowSorting="True" AllowAutomaticDeletes="True">
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id, Source" DataSourceID="SqlDataSourceAzureFiles"
                            ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                    HeaderText="" HeaderStyle-Width="40px">
                                </telerik:GridEditCommandColumn>

                                <telerik:GridTemplateColumn DataField="Source" FilterControlAltText="Filter Source column" HeaderText="Source" SortExpression="Source"
                                    UniqueName="Source" HeaderStyle-Width="100px" ItemStyle-Font-Size="X-Small">
                                    <ItemTemplate>
                                        <%# Eval("Source")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
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
                                        <a class="btn btn-primary" href='<%# Eval("url")%>' target="_blank" download='<%# Eval("Name") %>'><%# String.Concat(Eval("Name"), " (", Eval("ContentType"), ")")%></a>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date" SortExpression="Date" UniqueName="Date"
                                    HeaderStyle-Width="80px" ReadOnly="true">
                                    <ItemTemplate>
                                        <%# Eval("Date", "{0:d}")%>
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
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
            <tr>
                <td>
                    <h3>Job Links</h3>
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td style="padding-left: 15px">
                                <asp:LinkButton ID="btnNewFileLink" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false" ToolTip="Attached uploaded file">
                                        <i class="fas fa-plus"></i> Hyperlink
                                </asp:LinkButton>
                                &nbsp;&nbsp;&nbsp;

                            <asp:LinkButton ID="btnDropbox" runat="server" CssClass="btn btn-default" UseSubmitBehavior="false" CausesValidation="false" ToolTip="Upload or attached file" Visible="false"
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
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" HeaderText="Edit" HeaderStyle-Width="30px" UniqueName="EditCommandColumn">
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
                                        <telerik:RadButton ID="btnLink" ButtonType="LinkButton" runat="server" Text='<%# Eval("Title")%>' NavigateUrl='<%# Eval("link")%>' ToolTip='<%# Eval("link")%>' Target="_blank">
                                        </telerik:RadButton>
                                        <br />
                                        <asp:Label ID="linkLabel" runat="server" Text='<%# Eval("Descripciption")%>' CssClass="Pequena"></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Descripciption" FilterControlAltText="Filter Descripciption column" Display="false"
                                    HeaderText="Description" SortExpression="Descripciption" UniqueName="Descripciption" HeaderStyle-HorizontalAlign="Center">
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="DescripciptionTextBox" runat="server" Rows="3" Text='<%# Bind("Descripciption") %>' Width="600px" MaxLength="1024"></telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Link" FilterControlAltText="Filter Link column"
                                    HeaderText="Link (url)" SortExpression="Link" UniqueName="Link" HeaderStyle-HorizontalAlign="Center" Display="false">
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="LinkTextBox" runat="server" Text='<%# Bind("Link") %>' Width="600px" MaxLength="256"></telerik:RadTextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:HyperLink ID="HyperLink11" runat="server" Target="_blank" Text='<%# Eval("Link") %>'
                                            NavigateUrl='<%# Eval("Link") %>'></asp:HyperLink>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this link?"
                                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                    UniqueName="DeleteColumn" HeaderText="Delete" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
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

