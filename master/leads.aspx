<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="leads.aspx.vb" Inherits="pasconcept20.leads" %>

<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnFind"  LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                    <telerik:AjaxUpdatedControl ControlID="lblSELECTed_ID" />
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnConfirmExport">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnConfirmExport"  LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipExport" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />--%>

    <table style="width: 100%">
        <tr>
            <td colspan="2">
                <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                    <table class="table-sm pasconcept-bar" style="width: 100%">
                        <tr>
                            <td style="width: 120px; text-align: right">State:
                            </td>
                            <td style="width: 130px">
                                <telerik:RadTextBox ID="txtState" runat="server" MaxLength="15" Width="100%">
                                </telerik:RadTextBox>
                            </td>
                            <td style="width: 140px; text-align: right">Zip Code Starting:
                            </td>
                            <td style="width: 130px">
                                <telerik:RadTextBox ID="txtZipCode" runat="server" Text="" MaxLength="10" Width="100%">
                                </telerik:RadTextBox>
                            </td>
                            <td style="width: 130px; text-align: right">Phone Starting:</td>
                            <td style="width: 130px">
                                <telerik:RadTextBox ID="txtPhone" runat="server" Text="" MaxLength="10" Width="100%">
                                </telerik:RadTextBox>
                            </td>
                            <td style="width: 100px; text-align: right">City:
                            </td>
                            <td style="width: 180px;">
                                <telerik:RadTextBox ID="txtCity" runat="server" Text="" MaxLength="50" Width="100%">
                                </telerik:RadTextBox>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboOnOff" runat="server" Width="150px" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Contact On" Value="0" Selected="true" />
                                        <telerik:RadComboBoxItem runat="server" Text="Contact Off" Value="1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td>
                                 <telerik:RadTextBox ID="txtFind" runat="server" Text="" EmptyMessage="Contact or Company Name..." MaxLength="80" Width="100%">
                                </telerik:RadTextBox>
                            </td>

                        </tr>
                        <tr>
                            <td style="text-align: right">Contain Tags:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtTags" runat="server" Text="" MaxLength="100" Width="100%">
                                </telerik:RadTextBox>
                            </td>
                            <td style="text-align: right">Not Contain Tags:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtNoTags" runat="server" MaxLength="100" Width="100%">
                                </telerik:RadTextBox>
                            </td>
                            <td style="text-align: right">Page Size:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtPageSize" runat="server" MaxLength="5" Width="100%" Text="100">
                                </telerik:RadTextBox>
                            </td>
                            <td style="text-align: right">Source:
                            </td>
                            <td style="width: 300px">
                                <telerik:RadComboBox ID="cboSource" runat="server" DataSourceID="SqlDataSourceSources" DataTextField="Name" DataValueField="Id" Width="100%"
                                    AppendDataBoundItems="true" Height="300px" MarkFirstMatch="True">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Sources List...)" Value="-1" Selected="true" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboInAgile" runat="server" Width="150px" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Not In Agile" Value="0" Selected="true" />
                                        <telerik:RadComboBoxItem runat="server" Text="In Agile" Value="1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>

                            <td style="text-align: right">
                                <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    Filter/Search
                                </asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="10" style="text-align: right">

                                <span style="float: right; vertical-align: middle;">
                                    <asp:LinkButton ID="btnBulkTag" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" ToolTip="Tag Selected records">
                                         Bulk Tag
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnImport" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" ToolTip="Import csv List">
                                         Import
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnExport" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" ToolTip="Export and (optional)Tag current List">
                                         Export
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnAgile" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Export selected records to Agile">
                                         Agile
                                    </asp:LinkButton>
                                </span>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None" Width="100%" AutoGenerateColumns="False" CellSpacing="0" AllowSorting="True"
                    AllowPaging="True" PageSize="100" ShowHeader="true" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-HorizontalAlign="Center"
                    Height="800px" AllowMultiRowSelection="True">
                    <ClientSettings Selecting-AllowRowSelect="true">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataSourceID="SqlDataSource1">
                        <Columns>
                            <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="ClientSelectColumn">
                            </telerik:GridClientSelectColumn>
                            <telerik:GridBoundColumn DataField="ID" HeaderText="ID" SortExpression="ID" UniqueName="ID" HeaderStyle-Width="60px" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Company" HeaderText="Company" SortExpression="Company" UniqueName="Company" HeaderStyle-Width="180px" ItemStyle-Font-Bold="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="ContactName" HeaderText="Contact Name" SortExpression="ContactName" UniqueName="ContactName" HeaderStyle-Width="150px" ItemStyle-Font-Bold="true">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEditLead" runat="server" UseSubmitBehavior="false" CommandName="EditLead" CommandArgument='<%# Eval("Id") %>'>
                                        <%# Eval("ContactName") %>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="Position" HeaderText="Position" SortExpression="Position" UniqueName="Position" HeaderStyle-Width="120px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="JobTitle" HeaderText="Job Title - Capabiliy" SortExpression="JobTitle" UniqueName="JobTitle" HeaderStyle-Width="280px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Email" HeaderText="Email" SortExpression="Email" UniqueName="Email" HeaderStyle-Width="150px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Phone" HeaderText="Phone" SortExpression="Phone" UniqueName="Phone" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="WebSite" HeaderText="WebSite" SortExpression="WebSite" UniqueName="WebSite" HeaderStyle-Width="150px">
                                <ItemTemplate>
                                    <a href='<%# Eval("WebSite") %>' target="_blank"><%# Eval("WebSite") %></a>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="Address" HeaderText="Address" SortExpression="Address" UniqueName="Address" HeaderStyle-Width="180px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Source" HeaderText="Source" SortExpression="Source" UniqueName="Source" HeaderStyle-Width="150px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Tags" HeaderText="Tags" SortExpression="Tags" UniqueName="Tags" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>

    <telerik:RadToolTip ID="RadToolTipExport" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h3 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">
                <asp:Label runat="server" ID="lblExportTitle" Text="Export to CSV File"></asp:Label>
            </span>
        </h3>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td style="text-align: right; width: 150px">TAG (exported rows):
                </td>
                <td>
                    <telerik:RadTextBox ID="txtExportTag" runat="server" Text="" MaxLength="100" Width="100%">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnConfirmExport" runat="server" CssClass="btn btn-success" Width="150px" UseSubmitBehavior="false" Text="Export to CSV">
                              
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipTagSelected" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h3 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Bulk Tag Update
            </span>
        </h3>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td style="text-align: right; width: 150px">TAG (selected rows):
                </td>
                <td>
                    <telerik:RadTextBox ID="txtBulkTag" runat="server" Text="" MaxLength="100" Width="100%">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnBulkTagConfirm" runat="server" CssClass="btn btn-success" Width="150px" UseSubmitBehavior="false">
                             Export 
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipLead" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h3 style="margin: 0; text-align: center; color: white; width: 800px">
            <span class="navbar navbar-expand-md bg-dark text-white">Edit Contact
            </span>
        </h3>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceLead" Width="100%" DefaultMode="Edit">
            <EditItemTemplate>
                <table class="table-sm" style="width: 800px">
                    <tr>
                        <td style="width: 220px; text-align: right">First Name:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtClientName" runat="server" Text='<%# Bind("FirstName") %>' MaxLength="80"
                                Width="100%" EmptyMessage="Required">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Last Name:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBox1" runat="server" Text='<%# Bind("LastName") %>' MaxLength="80"
                                Width="100%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Position:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBox3" runat="server" Text='<%# Bind("Position") %>' MaxLength="80" Width="100%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Job Title:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBox4" runat="server" Text='<%# Bind("JobTitle") %>' MaxLength="80" Width="100%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Email:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' MaxLength="80" Width="100%" EmptyMessage="Required">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Phone/Cell/Fax:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBoxPhone" runat="server" Text='<%# Bind("Phone") %>' ToolTip="Phone" />
                            &nbsp;
                                                                <telerik:RadTextBox ID="RadMaskedTextBox2" runat="server" Text='<%# Bind("Cellular") %>' ToolTip="Cell" />
                            &nbsp;
                                                                <telerik:RadTextBox ID="RadMaskedTextBox3" runat="server" Text='<%# Bind("Fax") %>' ToolTip="Facsimile" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Web Site:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBox11" runat="server" Text='<%# Bind("WebSite") %>' MaxLength="128" Width="100%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Source:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cbos" runat="server" DataSourceID="SqlDataSourceSources"
                                DataTextField="Name" DataValueField="Id" Width="100%" SelectedValue='<%# Bind("SourceId") %>'
                                AppendDataBoundItems="true">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Source Not Defined...)" Value="0" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align: right">Address Line 1:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtAddress" runat="server" Text='<%# Bind("AddressLine1") %>' MaxLength="80" Width="100%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Address Line 2:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtAddress2" runat="server" Text='<%# Bind("AddressLine2") %>' MaxLength="80" Width="100%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">City/State/Zip:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBox2" runat="server" Text='<%# Bind("City") %>' MaxLength="50"
                                Width="160px" ToolTip="City" EmptyMessage="City" CssClass="input-city">
                            </telerik:RadTextBox>
                            &nbsp;
                                                                <telerik:RadTextBox ID="RadTextBox5" runat="server" Text='<%# Bind("State") %>'
                                                                    MaxLength="50" Width="160px" ToolTip="State" EmptyMessage="State" CssClass="input-state">
                                                                </telerik:RadTextBox>
                            &nbsp;
                                                                <telerik:RadTextBox ID="RadTextBox6" runat="server" Text='<%# Bind("ZipCode") %>' ToolTip="Zip Code" EmptyMessage="Zip Code"
                                                                    MaxLength="50" Width="160px" CssClass="input-zip">
                                                                </telerik:RadTextBox>
                        </td>
                    </tr>


                    <tr>
                        <td style="text-align: right">Tags:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBox14" runat="server" Text='<%# Bind("Tags") %>' Width="100%" MaxLength="80">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Contact:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboOnOffEdit" runat="server" Width="100px" AppendDataBoundItems="true" SelectedValue='<%# Bind("ContactOff") %>' ZIndex="50001">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="On" Value="0" />
                                    <telerik:RadComboBoxItem runat="server" Text="Off" Value="1" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
        </asp:FormView>
        <div style="width: 100%; text-align: right">
            <asp:LinkButton ID="btnUpdateContact" runat="server" CommandName="Update" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false">
                Update Contact
            </asp:LinkButton>
        </div>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipImport" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h3 style="margin: 0; text-align: center; color: white; width: 800px">
            <span class="navbar navbar-expand-md bg-dark text-white">Import CSV Lead File
            </span>
        </h3>
        <table class="table-sm" style="width: 800px">
            <tr>
                <td colspan="2">
                    <h4 style="margin: 0">Instructions for importing csv Lead files</h4>
                    <ul>
                        <li>Ensure your CSV file adheres to the structure: (Company, FirstName, LastName, Email, Phone, Cellular, Website, AddressLine1, AddressLine2, City, State, ZipCode, JobTitle, Position, Tags). 
                    <a href="https://app.pasconcept.com/csv/pascoceptleads.csv" target="_blank">Click to download</a> sample csv file.</li>
                        <li>FirstName, Email are mandatory fields</li>
                        <li>Select Source, Select File and click Import button</li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td style="text-align: right; width: 150px">Source:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboSourceImport" runat="server" DataSourceID="SqlDataSourceSources" DataTextField="Name" DataValueField="Id" Width="100%" ZIndex="50001"
                        AppendDataBoundItems="true" Height="300px" MarkFirstMatch="True" ValidationGroup="Import">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Sources List...)" Value="-1" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right; width: 150px"></td>
                <td>
                    <telerik:RadAsyncUpload ID="RadUpload1" runat="server" ControlObjectsVisibility="None" MultipleFileSelection="Disabled" EnableFileInputSkinning="true"
                        AllowedFileExtensions="csv,txt" RenderMode="Classic">
                    </telerik:RadAsyncUpload>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnConfirmImport" runat="server"
                        CssClass="btn btn-info btn" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="Import">
                                     <i class="fas fa-upload"></i>&nbsp;Import Leads
                    </asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Select Sources List...)" ForeColor="Red"
                        Operator="NotEqual" ControlToValidate="cboSourceImport" Display="Dynamic" ErrorMessage="Select Source" SetFocusOnError="true" ValidationGroup="Import">
                    </asp:CompareValidator>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnAxzesLeads %>"
        SelectCommand="Leads_v20_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Leads_Tags_Bulk_UPDATE" UpdateCommandType="StoredProcedure"
        InsertCommand="Leads_Tags_UPDATE" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtPageSize" Name="PageSize" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtState" Name="State" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtZipCode" Name="ZipCode" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtPhone" Name="Phone" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtCity" Name="City" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtTags" Name="Tag" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtNoTags" Name="NoTag" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtFind" Name="Find" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="cboSource" Name="sourceId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboInAgile" Name="InAgile" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboOnOff" Name="ContactOff" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="txtPageSize" Name="PageSize" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtState" Name="State" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtZipCode" Name="ZipCode" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtPhone" Name="Phone" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtCity" Name="City" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtNoTags" Name="NoTag" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtExportTag" Name="UpdateTag" PropertyName="Text" ConvertEmptyStringToNull="false" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblSelected_ID" Name="ID" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtBulkTag" Name="Tag" PropertyName="Text" ConvertEmptyStringToNull="false" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceLead" runat="server" ConnectionString="<%$ ConnectionStrings:cnnAxzesLeads %>"
        SelectCommand="Lead_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Lead_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSelected_ID" Name="Id" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FirstName" />
            <asp:Parameter Name="LastName" />
            <asp:Parameter Name="Email" />
            <asp:Parameter Name="Fax" />
            <asp:Parameter Name="Phone" />
            <asp:Parameter Name="Cellular" />
            <asp:Parameter Name="WebSite" />
            <asp:Parameter Name="AddressLine1" />
            <asp:Parameter Name="AddressLine2" />
            <asp:Parameter Name="City" />
            <asp:Parameter Name="State" />
            <asp:Parameter Name="ZipCode" />
            <asp:Parameter Name="JobTitle" />
            <asp:Parameter Name="Position" />
            <asp:Parameter Name="Tags" />
            <asp:Parameter Name="SourceId" />
            <asp:Parameter Name="ContactOff" />
            <asp:ControlParameter ControlID="lblSelected_ID" Name="Id" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSources" runat="server" ConnectionString="<%$ ConnectionStrings:cnnAxzesLeads %>"
        SelectCommand="SELECT [Id], [Name] FROM [Leads_sources] ORDER BY [Id]"></asp:SqlDataSource>

    <asp:Label ID="lblSelected_ID" runat="server" Visible="False"></asp:Label>

</asp:Content>
