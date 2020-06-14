<%@ Page Title="Upload Documents" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="azurestorage_client.aspx.vb" Inherits="pasconcept20.azurestorage_client" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function onClientUploadFailed(sender, eventArgs) {
                alert(eventArgs.get_message())
            }
        </script>
    </telerik:RadCodeBlock>
    <table class="table-condensed" style="width: 100%">
        <tr>
            <td colspan="4">
                <asp:Panel runat="server" class="DropZoneClient">
                    <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" MultipleFileSelection="Automatic" OnClientUploadFailed="onClientUploadFailed"
                        OnFileUploaded="RadCloudUpload1_FileUploaded" ProviderType="Azure"
                        MaxFileSize="100145728"
                        DropZones=".DropZoneClient">
                    </telerik:RadCloudUpload>
                    <p style="margin: 0">To Add/Upload documents to client: </p>
                    <ol style="text-align: left">
                        <li>Select or Drag and Drop source files</li>
                        <li>Select Pre-Project (or Insert if not exist)</li>
                        <li>Select document Type</li>
                        <li>Check/Uncheck Public</li>
                        <li>Press Upload</li>
                    </ol>
                    <h4>Select or Drag and Drop files (up to 100Mb)</h4>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td style="width: 300px;">
                <telerik:RadComboBox ID="cboPreProject" runat="server" DataSourceID="SqlDataSourcePreProjects" DataTextField="Name" DataValueField="Id"
                    Width="100%" AppendDataBoundItems="true">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(Select Pre-Project...)" Value="0" />
                    </Items>
                </telerik:RadComboBox>
            </td>
            <td style="width: 170px;">
                <telerik:RadComboBox ID="cboDocType" runat="server" DataSourceID="SqlDataSourceDocTypes" DataTextField="Name" DataValueField="Id" Width="95%">
                </telerik:RadComboBox>
            </td>
            <td style="width: 150px;">
                <telerik:RadCheckBox ID="chkPublic" runat="server" Text="Public" ToolTip="Public or private"></telerik:RadCheckBox>
            </td>
            <td style="text-align: right">
                <asp:LinkButton ID="btnSaveUpload" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" ToolTip="Upload and Save selected files">
                    <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp;Upload
                </asp:LinkButton>
            </td>
        </tr>
    </table>

    <div style="padding-top: 10px">
        <telerik:RadGrid ID="RadGridAzureFiles" runat="server" DataSourceID="SqlDataSourceAzureFiles" GroupPanelPosition="Top" ShowFooter="true"
            AllowAutomaticUpdates="True" AllowPaging="True" PageSize="25" AllowSorting="True" AllowAutomaticDeletes="True">
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id, Source" DataSourceID="SqlDataSourceAzureFiles"
                ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                        HeaderText="" HeaderStyle-Width="40px">
                    </telerik:GridEditCommandColumn>

                    <telerik:GridTemplateColumn DataField="Source" FilterControlAltText="Filter Source column" HeaderText="Source" SortExpression="Source"
                        UniqueName="Source" HeaderStyle-Width="120px">
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
                            <a style="font-size:x-small" href='<%# Eval("url")%>' target="_blank"><%# String.Concat(Eval("Name"), " (", Eval("ContentType"), ")")%></a>
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
                        HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>

    <asp:SqlDataSource ID="SqlDataSourcePreProjects" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Clients_pre_projects] WHERE clientId=@clientId  ORDER BY [Name]"
        InsertCommand="INSERT INTO [Clients_pre_projects] ([clientId],[Name],[DateIn]) VALUES(@clientId,@Name,GetDate())">
        <InsertParameters>
            <asp:ControlParameter ControlID="lblClientId" Name="clientId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtPre_ProjectName" Name="Name" PropertyName="Text" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblClientId" Name="clientId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceAzureFiles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Client_azureuploads_v20_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="ClientProsalJob_azureuploads_v20_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommand="ClientProsalJob_azureuploads_v20_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblClientId" Name="clientId" PropertyName="Text" Type="Int32" />
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
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDocTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_azureuploads_types] ORDER BY [Id]"></asp:SqlDataSource>


    <asp:Label ID="lblClientId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>

</asp:Content>

