<%@ Page Title="Vendor" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="vendor.aspx.vb" Inherits="pasconcept20.vendor" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
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

    <div style="padding-left: 25px">
        <asp:Label ID="lblStatus" runat="server" Style="font-size: 10pt; color: #cc0000; font-family: Calibri, Verdana"></asp:Label>
    </div>
    <div>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%" DefaultMode="Edit">
            <EditItemTemplate>
                <div style="padding-left: 170px; padding-top: 10px;">
                    <asp:LinkButton ID="btnUpdateVendor1" runat="server" CommandName="Update" CausesValidation="True" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    <span class="glyphicon glyphicon-save"></span> Update
                    </asp:LinkButton>
                </div>
                <fieldset style="width: 710px;">
                    <legend class="TituloDeFieldset">&nbsp;Vendor Information&nbsp;</legend>
                    <table width="700px" class="Formulario" cellpadding="2" cellspacing="2">
                        <tr>
                            <td style="width: 150px" class="Normal">Name:
                                        <asp:Label ID="IdLabel1" runat="server" Text='<%# Eval("Id") %>' Visible="false" />
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtVendorName" runat="server" Text='<%# Bind("Name") %>' MaxLength="80"
                                    Width="500px" EmptyMessage="Required">
                                </telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtVendorName"
                                    ErrorMessage="(*) Name is Required" Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="Normal">Compamy:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="RadTextBox4" runat="server" Text='<%# Bind("Company")%>'
                                    MaxLength="80" Width="500px">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="Normal">Position:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="RadTextBox3" runat="server" Text='<%# Bind("Position") %>'
                                    MaxLength="80" Width="500px">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="Normal">Type:
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
                            <td style="width: 150px" class="Normal">Subtype:
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
                            <td style="width: 150px" class="Normal">Address Line 1:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtAddress" runat="server" Text='<%# Bind("Address") %>'
                                    MaxLength="80" Width="500px">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="Normal">Address Line 2:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtAddress2" runat="server" Text='<%# Bind("Address2") %>'
                                    MaxLength="80" Width="500px">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="Normal">City:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtCity" runat="server" Text='<%# Bind("City") %>' MaxLength="50"
                                    Width="300px">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="Normal">State:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtState" runat="server" Text='<%# Bind("State") %>'
                                    MaxLength="50" Width="300px">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="Normal">Zip Code:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtZipCode" runat="server" Text='<%# Bind("ZipCode") %>'
                                    MaxLength="50">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="Normal">Email:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' MaxLength="128" Width="500px" EmptyMessage="Required">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="Normal">Telephone:
                            </td>
                            <td>
                                <telerik:RadMaskedTextBox ID="RadMaskedTextBox1" runat="server" Text='<%# Bind("Phone")%>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="Normal">Cell Phone:
                            </td>
                            <td>
                                <telerik:RadMaskedTextBox ID="RadMaskedTextBox2" runat="server" Text='<%# Bind("Cellular")%>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="Normal">Facsimile:
                            </td>
                            <td>
                                <telerik:RadMaskedTextBox ID="RadMaskedTextBox3" runat="server" Text='<%# Bind("Fax")%>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="Normal">Web Page:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="RadTextBox1" runat="server" Text='<%# Bind("Web")%>' MaxLength="50"
                                    Width="500px">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="Normal">Notes:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="RadTextBox14" runat="server" Text='<%# Bind("Notes") %>'
                                    TextMode="MultiLine" Width="500px" MaxLength="1024">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <div style="padding-left: 170px; padding-top: 10px; padding-bottom: 15px">
                    <asp:LinkButton ID="btnUpdateVendor2" runat="server" CommandName="Update" CausesValidation="True" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    <span class="glyphicon glyphicon-save"></span> Update
                    </asp:LinkButton>
                </div>
            </EditItemTemplate>

        </asp:FormView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="Vendor_UPDATE" UpdateCommandType="StoredProcedure"
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
            <asp:ControlParameter ControlID="lblVendorId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Vendor_types] Where companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblVendorId" runat="server" Visible="False"></asp:Label>

</asp:Content>

