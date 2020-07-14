<%@ Page Title="Vendor" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="vendor.aspx.vb" Inherits="pasconcept20.vendor" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnUpdateVendor1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="EditionZone" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnUpdateVendor2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="EditionZone" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnCredentials">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="EditionZone" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="FormView1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadMultiPage1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGridProposals">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridProposals" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGridJobs">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridJobs" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>

    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
            </asp:LinkButton>
            Vendor
        </span>
    </div>

    <div class="pasconcept-bar">
        <div>
            <asp:ValidationSummary ID="vsClient" runat="server" ValidationGroup="UpdateVendor" ForeColor="Red"
                HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were this errors:"></asp:ValidationSummary>
        </div>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%" DefaultMode="Edit">
            <EditItemTemplate>
                <div style="text-align: center">
                    <br />
                    <asp:LinkButton ID="btnUpdateVendor1" runat="server" CommandName="Update" CausesValidation="True" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ValidationGroup="UpdateVendor">
                     Update
                    </asp:LinkButton>
                    <hr style="margin: 0" />
                </div>
                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td style="text-align: right; width: 180px">Name:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtVendorName" runat="server" Text='<%# Bind("Name") %>' MaxLength="80"
                                Width="90%" EmptyMessage="Required">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Compamy:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBox4" runat="server" Text='<%# Bind("Company")%>'
                                MaxLength="80" Width="90%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Position:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBox3" runat="server" Text='<%# Bind("Position") %>'
                                MaxLength="80" Width="90%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Type:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceTypes"
                                DataTextField="Name" DataValueField="Id" Width="300px" SelectedValue='<%# Bind("Type") %>' AppendDataBoundItems="true" AutoPostBack="True">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Types Not Defined...)" Value="0" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Subtype:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboSubtype" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceSubtypes" DataTextField="Name" DataValueField="Id"
                                SelectedValue='<%# DataBinder.Eval(Container.DataItem, "Subtype")%>' Width="300px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Subtypes Not Defined...)" Value="0" />
                                </Items>
                            </telerik:RadComboBox>
                            <asp:SqlDataSource ID="SqlDataSourceSubtypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                                SelectCommand="SELECT [Id], [Name] FROM [Vendor_subtypes] Where typeId=@typeId ORDER BY Name">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="cboType" Name="typeId" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right"><a href="https://www.census.gov/eos/www/naics/" target="_blank">NAICS</a> US Code:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboNAICS" runat="server" DataSourceID="SqlDataSourceNAICS"
                                DataTextField="CodeAndTitle" DataValueField="Code" Width="90%" SelectedValue='<%# Bind("NAICS_code") %>'
                                AppendDataBoundItems="true" MarkFirstMatch="True" Filter="Contains">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(NAICS Code Not Defined...)" Value="0" />
                                </Items>
                            </telerik:RadComboBox>

                        </td>
                    </tr>

                    <tr>
                        <td style="text-align: right">Address Line 1:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtAddress" runat="server" Text='<%# Bind("Address") %>'
                                MaxLength="80" Width="90%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Address Line 2:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtAddress2" runat="server" Text='<%# Bind("Address2") %>'
                                MaxLength="80" Width="90%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">City:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtCity" runat="server" Text='<%# Bind("City") %>' MaxLength="50"
                                Width="300px">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">State:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtState" runat="server" Text='<%# Bind("State") %>'
                                MaxLength="50" Width="300px">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Zip Code:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtZipCode" runat="server" Text='<%# Bind("ZipCode") %>'
                                MaxLength="50">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Email:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' MaxLength="128" Width="90%" EmptyMessage="Required">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Telephone:
                        </td>
                        <td>
                            <telerik:RadMaskedTextBox ID="RadMaskedTextBox1" runat="server" Text='<%# Bind("Phone")%>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Cell Phone:
                        </td>
                        <td>
                            <telerik:RadMaskedTextBox ID="RadMaskedTextBox2" runat="server" Text='<%# Bind("Cellular")%>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Facsimile:
                        </td>
                        <td>
                            <telerik:RadMaskedTextBox ID="RadMaskedTextBox3" runat="server" Text='<%# Bind("Fax")%>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Web Page:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBox1" runat="server" Text='<%# Bind("Web")%>' MaxLength="50"
                                Width="90%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Notes:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBox14" runat="server" Text='<%# Bind("Notes") %>'
                                TextMode="MultiLine" Width="90%" MaxLength="1024">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                </table>

                <div style="text-align: center">
                    <hr style="margin: 0" />
                    <asp:LinkButton ID="btnUpdateVendor2" runat="server" CommandName="Update" CausesValidation="True" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ValidationGroup="UpdateVendor">
                     Update
                    </asp:LinkButton>
                </div>

                <div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtVendorName" ValidationGroup="UpdateVendor"
                        ErrorMessage="Name is Required" Display="None"></asp:RequiredFieldValidator>

                </div>
            </EditItemTemplate>

        </asp:FormView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="Vendor_v20_UPDATE" UpdateCommandType="StoredProcedure"
        SelectCommand="Vendor_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblVendorId" Name="Id" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Position" Type="String" />
            <asp:Parameter Name="Company" Type="String" />
            <asp:Parameter Name="Type" Type="Int16" />
            <asp:Parameter Name="Subtype" Type="Int16" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="Address2" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="State" Type="String" />
            <asp:Parameter Name="ZipCode" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="Cellular" Type="String" />
            <asp:Parameter Name="Fax" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="Web" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="NAICS_code" Type="String" />
            <asp:ControlParameter ControlID="lblVendorId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Vendor_types] Where companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceNAICS" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="NAICS_US_Codes_FromCombobox_SELECT" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblVendorId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblBackSource" runat="server" Visible="False" Text="0"></asp:Label>

</asp:Content>

