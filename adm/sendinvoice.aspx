<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="sendinvoice.aspx.vb" Inherits="pasconcept20.sendinvoice" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function onClientUploadFailed(sender, eventArgs) {
            alert(eventArgs.get_message())
        }
    </script>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadWizard1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadWizard1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txtBody" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridLinks" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <div class="pas-container">

        <telerik:RadWizard ID="RadWizard1" runat="server" Height="680px" DisplayProgressBar="false"
            RenderMode="Lightweight" Skin="Material" Localization-Cancel="Back" Localization-Finish="Send">
            <WizardSteps>

                <%-- Contact Information --%>
                <telerik:RadWizardStep runat="server" ID="Confirmation" Title="Confirmation" ValidationGroup="Confirmation" StepType="Start">
                    <div>
                        <asp:ValidationSummary ID="vsConfirmation" runat="server" ValidationGroup="Confirmation"
                            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
                    </div>
                    
                     <asp:FormView ID="FormViewClientBalance" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceClientBalance" Width="100%">
                        <ItemTemplate>

                            <table class="table-condensed" style="width: 100%">
                                <tr>
                                    <td style="text-align: left; vertical-align: top; width: 33%">
                                        <h3 style="margin: 0"><span class="badge badge-info center-block">Client</span></h2>

                                        <table style="width: 100%">
                                            <tr>
                                                <td>
                                                    <h4 style="margin: 3px"><%# Eval("ClientName")%></h4>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <%# Eval("ClientCompany") %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <small><%# Eval("ClientFullAddress")%></small>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone"))%>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 33%; text-align: center; vertical-align: top">
                                        <h3 style="margin: 0"><span class="badge badge-info center-block">Projects</span></h2>
                                        <table class="table-condensed" style="width: 100%">
                                            <tr>
                                                <td style="text-align: right"># Pending Proposals:</td>
                                                <td style="width: 120px; text-align: right">
                                                    <b><%# Eval("NumberPendingProposal", "{0:N0}") %></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Acepted Proposals:</td>
                                                <td style="text-align: right">
                                                    <b><%# Eval("ProposalAmount", "{0:C2}") %></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right;">Jobs Total Amount:</td>
                                                <td style="text-align: right">
                                                    <b><%# Eval("ContractAmount", "{0:C2}") %></b>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="text-align: right; vertical-align: top">
                                        <h3 style="margin: 0"><span class="badge badge-info center-block">Balance</span></h2>
                                        <table class="table-condensed" style="width: 100%">
                                            <tr>
                                                <td style="text-align: right;">Amount Paid:</td>
                                                <td>
                                                    <b><%# Eval("AmountPaid", "{0:C2}") %></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right;">Remaining Balance:</td>
                                                <td>
                                                    <b><%# Eval("Balance","{0:C2}") %></b>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>


                        </ItemTemplate>
                    </asp:FormView>
                    <hr style="margin:0" />
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td style="text-align: left; vertical-align: top; width: 33%">

                            </td>
                            <td style="text-align: left; vertical-align: top; width: 33%">
                                <telerik:RadTextBox ID="txtInvoiceNumber" runat="server" Width="100%" Label="Invoice Number:"  ReadOnly="true" Skin="Material">
                                            </telerik:RadTextBox>
                            </td>
                            <td style="text-align: right; vertical-align: top">
                                <telerik:RadTextBox ID="txtInvoiceAmount" runat="server" Width="100%" Label="Invoice Amount:" ReadOnly="true" Skin="Material">
                                            </telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>
                    <hr style="margin:0" />
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td style="width: 270px">Client Notification Type:
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboNotification" runat="server" Width="150px" ValidationGroup="Confirmation">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="?" Value="-1" Selected="true" />
                                        <telerik:RadComboBoxItem Text="Only by Email" Value="1" />
                                        <telerik:RadComboBoxItem Text="Email and SMS" Value="2" />
                                        <telerik:RadComboBoxItem Text="Only by SMS" Value="3" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 270px">Internal Notification (Yes or No):
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboInternalNotification" runat="server" Width="150px" ValidationGroup="Confirmation">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="No" Value="0" Selected="true" />
                                        <telerik:RadComboBoxItem Text="Yes" Value="1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>


                        <tr>
                            <td>Emission Recurrence Days: 
                            </td>
                            <td>
                                <telerik:RadNumericTextBox ID="txtEmissionRecurrenceDays" runat="server" Width="60px" MaxLength="2" MinValue="0" MaxValue="99" ToolTip="Define frequency of automated email reccurence">
                                    <NumberFormat DecimalDigits="0" />
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Upload Documents (Yes or No):
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboAttached" runat="server" Width="150px" ValidationGroup="Confirmation">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="No" Value="0" Selected="true" />
                                        <telerik:RadComboBoxItem Text="Yes" Value="1" />
                                    </Items>
                                </telerik:RadComboBox>

                            </td>
                        </tr>

                    </table>
                    <div>
                        <asp:CompareValidator runat="server" ID="Comparevalidator4" ValueToCompare="?" ValidationGroup="Confirmation" Operator="NotEqual" SetFocusOnError="true"
                            ControlToValidate="cboNotification" Text="*"
                            ErrorMessage="Define Notification Type">
                        </asp:CompareValidator>

                        <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="?" ValidationGroup="Confirmation" Operator="NotEqual" SetFocusOnError="true"
                            ControlToValidate="cboInternalNotification" Text="*"
                            ErrorMessage="Define Internal Notification (Yes or No)">
                        </asp:CompareValidator>
                        <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="?" ValidationGroup="Confirmation" Operator="NotEqual" SetFocusOnError="true"
                            ControlToValidate="cboAttached" Text="*"
                            ErrorMessage="Define Share Attached Documents (Yes or No)">
                        </asp:CompareValidator>
                    </div>
                </telerik:RadWizardStep>

                <%-- Send --%>
                <telerik:RadWizardStep runat="server" Title="Message" ID="Message" Enabled="false" StepType="Finish">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Panel ID="PanelEmail" runat="server">
                                <table style="width: 100%" class="table-condensed">
                                    <tr>
                                        <td >To:
                                        </td>
                                        <td style="width:45%">
                                            <telerik:RadAutoCompleteBox runat="server" ID="txtTo" EmptyMessage="Client Email Address" DataSourceID="SqlDataSourceClient" DataTextField="Name" DataValueField="Email" AllowCustomEntry="false"
                                                InputType="Token" Width="100%" DropDownWidth="150px">
                                            </telerik:RadAutoCompleteBox>
                                        </td>
                                        <td>CC:
                                        </td >
                                        <td>
                                            <telerik:RadTextBox ID="txtCC" runat="server" Width="100%" EmptyMessage="Billing contact email">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Subject:
                                        </td>
                                        <td colspan="3">
                                            <telerik:RadTextBox ID="txtSubject" runat="server" Width="100%">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <telerik:RadEditor ID="txtBody" runat="server" Height="250px" RenderMode="Auto"
                                                AllowScripts="True" EditModes="Design" Width="100%">
                                                <Tools>
                                                    <telerik:EditorToolGroup>
                                                        <telerik:EditorTool Name="Cut" />
                                                        <telerik:EditorTool Name="Copy" />
                                                        <telerik:EditorTool Name="Paste" />
                                                    </telerik:EditorToolGroup>
                                                </Tools>
                                            </telerik:RadEditor>
                                        </td>
                                    </tr>

                                </table>
                            </asp:Panel>

                            <asp:Panel ID="PanelUpload" runat="server">
                                <table style="width: 100%" class="table-condensed">
                                    <tr>
                                        <td colspan="2">
                                            <p style="font-size: x-small">Upload your files</p>
                                            <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" MultipleFileSelection="Automatic"
                                                OnClientUploadFailed="onClientUploadFailed"
                                                OnFileUploaded="RadCloudUpload1_FileUploaded" ProviderType="Azure"
                                                MaxFileSize="10145728">
                                            </telerik:RadCloudUpload>
                                        </td>
                                        <td>
                                            <telerik:RadButton ID="btnSave" runat="server" Text="Upload" ToolTip="Upload and Save selected files" Width="120px" UseSubmitBehavior="false">
                                                <Icon PrimaryIconCssClass=" rbUpload" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
                                            </telerik:RadButton>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <telerik:RadGrid ID="RadGridLinks" runat="server" DataSourceID="SqlDataSourceLinks" GridLines="None" CellSpacing="0" AllowMultiRowSelection="true">
                                                <ClientSettings>
                                                    <Selecting AllowRowSelect="true" />
                                                </ClientSettings>
                                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceLinks">
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px" HeaderStyle-HorizontalAlign="Center">
                                                        </telerik:GridClientSelectColumn>
                                                        <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="ID" ReadOnly="True"
                                                            SortExpression="Id" UniqueName="Id" Display="False">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn DataField="Descripciption" FilterControlAltText="Filter Title column"
                                                            HeaderText="Select the links you want to Send" SortExpression="Descripciption" UniqueName="Descripciption" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true">
                                                            <ItemTemplate>
                                                                <telerik:RadButton ID="btnLink" ButtonType="LinkButton" runat="server" Text='<%# Eval("Title")%>' NavigateUrl='<%# Eval("link")%>' ToolTip='<%# Eval("link")%>' Target="_blank">
                                                                </telerik:RadButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn DataField="link" HeaderText="link" ReadOnly="True" SortExpression="link" UniqueName="link" Display="False">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Title" HeaderText="Title" ReadOnly="True" SortExpression="Title" UniqueName="Title" Display="False">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="LinkType" HeaderText="LinkType" ReadOnly="True" SortExpression="LinkType" UniqueName="LinkType" Display="False">
                                                        </telerik:GridBoundColumn>
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
                            </asp:Panel>

                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-12">
                            <asp:Panel ID="PanelSMS" runat="server">
                                <table style="width: 100%" class="table-condensed">
                                    <tr>
                                        <td width="50px">To:
                                        </td>
                                        <td>
                                            <telerik:RadMaskedTextBox ID="txtCellular" runat="server" Mask="(###) ###-####" Width="120px" EmptyMessage="Cellular Number"></telerik:RadMaskedTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Message:
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtSMS" runat="server" Width="100%" Rows="4" EmptyMessage="SMS message" RenderMode="Classic" TextMode="MultiLine" MaxLength="255">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>

                        </div>
                    </div>
                </telerik:RadWizardStep>

                <%-- Complete --%>
                <telerik:RadWizardStep runat="server" Title="Complete " StepType="Complete ">
                    <br />
                    <br />
                    <br />
                    <br />
                    <div>

                        <div class="alert alert-success" role="alert">
                            <h4 class="alert-heading">Well done!</h4>
                            Invoice Notification Process have been completed successfully!
                        </div>
                    </div>

                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>

    </div>




    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <telerik:RadNotification ID="RadNotificationWarning" runat="server" RenderMode="Lightweight" Skin="Material"
                Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" OffsetX="250"
                Position="TopLeft" Title="Notification" Width="300px" Height="140px">
            </telerik:RadNotification>

            <telerik:RadNotification ID="RadNotificationError" runat="server" Skin="Sunset"
                Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" Width="350px"
                TitleIcon="deny" Text="Error" Position="TopCenter">
            </telerik:RadNotification>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="SqlDataSourceLinks" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Invoices_ShareLinks_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" DefaultValue="0" Name="JobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Name, Email FROM Clients WHERE Id = (select Client from Jobs where Id=@JobId) union all SELECT Billing_contact, Billing_Email FROM Clients WHERE Id = (select Client from Jobs where Id=@JobId)">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" DefaultValue="0" Name="JobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientBalance" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Client_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblClientId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblInvoice" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblOrigen" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeName" runat="server" Visible="False"></asp:Label>
</asp:Content>
