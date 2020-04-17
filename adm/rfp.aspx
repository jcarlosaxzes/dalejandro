<%@ Page Title="Request for Proposal" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="rfp.aspx.vb" Inherits="pasconcept20.rfp" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <script type="text/javascript">
        function onClientUploadFailed(sender, eventArgs) {
            alert(eventArgs.get_message())
        }

    </script>
    <div class="pas-container">
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceRFP" DefaultMode="Edit" Width="100%">
            <EditItemTemplate>
                <table style="width: 100%" class="table-condensed">
                    <tr>
                        <td>
                            <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="false" Height="720px" BorderStyle="Solid" BorderColor="LightGray"
                                DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Material">
                                <WizardSteps>
                                    <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Project Information" StepType="Step">
                                        <table style="width: 100%" class="table-condensed">
                                            <tr>
                                                <td style="width: 150px; text-align: right">Date Created:</td>
                                                <td>
                                                    <%# Eval("DateCreated", "{0:d}")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right"><b>Project Name</b>: </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txtProjectName" runat="server" MaxLength="80" SelectionOnFocus="SelectAll" Text='<%# Bind("ProjectName")%>' Width="100%">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">RFP Status:
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="cboStatusEdit" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceStatus" DataTextField="State" DataValueField="Id"
                                                        Width="250px" SelectedValue='<%# Bind("StateId")%>'>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text="(Select Status...)" Value="-1" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Project Location: </td>
                                                <td>
                                                    <telerik:RadTextBox ID="RadTextBox1" runat="server" MaxLength="80" SelectionOnFocus="SelectAll" Text='<%# Bind("ProjectLocation")%>' Width="100%">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Project Area: </td>
                                                <td>
                                                    <telerik:RadTextBox ID="RadTextBox2" runat="server" MaxLength="80" SelectionOnFocus="SelectAll" Text='<%# Bind("ProjectArea")%>' Width="100%">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; vertical-align: top">Project Description: </td>
                                                <td>
                                                    <telerik:RadTextBox ID="RadTextBox3" runat="server" EmptyMessage="Max amount of characters 2048" MaxLength="2048" Rows="4" SelectionOnFocus="SelectAll" Text='<%# Bind("ProjectDescription")%>' TextMode="MultiLine" Width="100%">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td style="text-align: right">Sender:</td>

                                                <td>
                                                    <telerik:RadTextBox ID="txtSender" runat="server" MaxLength="80" Text='<%# Bind("Sender")%>' Width="100%">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Sent Date:
                                                </td>
                                                <td>
                                                    <%# Eval("DateSended", "{0:d}")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; vertical-align: top">Introductory Text:</td>
                                                <td>
                                                    <telerik:RadTextBox ID="txtIntroductoryText" runat="server" MaxLength="512" Rows="3" Text='<%# Bind("IntroductoryText")%>' TextMode="MultiLine" Width="100%">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                        </table>
                                        <table style="width: 100%" class="table-condensed">

                                            <tr>
                                                <td style="width: 150px; text-align: right">Accepted Date:</td>
                                                <td>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("AceptedDate", "{0:d}")%>'> </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Declined Notes: </td>

                                                <td>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("DeclinedNotes")%>'> </asp:Label>
                                                </td>

                                            </tr>


                                        </table>
                                        <table style="width: 100%" class="table-condensed">
                                            <tr>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtProjectName"
                                                        CssClass="Error" ErrorMessage=" Project Name is required!"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; padding-right: 25px">
                                                    <asp:LinkButton ID="btnUpdate1" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false"
                                                        CommandName="Update" CausesValidation="true">
                                        Update
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </telerik:RadWizardStep>
                                    <telerik:RadWizardStep runat="server" ID="RadWizardStep3" Title="Payment Schedules" StepType="Step">
                                        <div>
                                            <table style="width: 100%" class="table-condensed">
                                                <tr>
                                                    <td style="text-align: right; width: 350px">To change, select Payment Schedules and Apply:
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cboPaymentSchedules" runat="server" DataSourceID="SqlDataSourcePaymentSchedules"
                                                            DataTextField="Name" DataValueField="Id" Filter="Contains" MarkFirstMatch="True" Width="100%">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td style="text-align: left; width: 250px">
                                                        <telerik:RadButton ID="btnGeneratePaymentSchedules" runat="server" CommandName="GeneratePaymentSchedules" Primary="true"
                                                            OnClick="btnPaymentSchedules_Click" Text="Apply" Width="100px" />
                                                    </td>
                                                </tr>

                                            </table>
                                            <table style="width: 100%" class="table-condensed">
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="PanelPS1" runat="server" Visible='<%# Eval("PaymentSchedule1") > 0%>'>
                                                            <table style="width: 100%">
                                                                <tr>
                                                                    <td style="width: 180px; text-align: right">Payment Schedule 1:
                                                                    </td>
                                                                    <td style="width: 80px">
                                                                        <telerik:RadTextBox ID="txtValue1" runat="server" Text='<%# Bind("PaymentSchedule1") %>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadTextBox ID="txtText1" runat="server" EmptyMessage="Schedule Description 1" MaxLength="200" Text='<%# Bind("PaymentText1") %>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="PanelPS2" runat="server" Visible='<%# Eval("PaymentSchedule2") > 0%>'>
                                                            <table style="width: 100%">
                                                                <tr>
                                                                    <td style="width: 180px; text-align: right">Payment Schedule 2:
                                                                    </td>
                                                                    <td style="width: 80px">
                                                                        <telerik:RadTextBox ID="txtValue2" runat="server" Text='<%# Bind("PaymentSchedule2") %>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadTextBox ID="txtText2" runat="server" EmptyMessage="Schedule Description 2" MaxLength="200" Text='<%# Bind("PaymentText2")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="PanelPS3" runat="server" Visible='<%# Eval("PaymentSchedule3") > 0%>'>
                                                            <table style="width: 100%">
                                                                <tr>
                                                                    <td style="width: 180px; text-align: right">Payment Schedule 3:
                                                                    </td>
                                                                    <td style="width: 80px">
                                                                        <telerik:RadTextBox ID="txtValue3" runat="server" Text='<%# Bind("PaymentSchedule3") %>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadTextBox ID="txtText3" runat="server" EmptyMessage="Schedule Description 3" MaxLength="200" Text='<%# Bind("PaymentText3")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="PanelPS4" runat="server" Visible='<%# Eval("PaymentSchedule4") > 0%>'>
                                                            <table style="width: 100%">
                                                                <tr>
                                                                    <td style="width: 180px; text-align: right">Payment Schedule 4:
                                                                    </td>
                                                                    <td style="width: 80px">
                                                                        <telerik:RadTextBox ID="txtValue4" runat="server" Text='<%# Bind("PaymentSchedule4") %>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadTextBox ID="txtText4" runat="server" EmptyMessage="Schedule Description 4" MaxLength="200" Text='<%# Bind("PaymentText4")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="PanelPS5" runat="server" Visible='<%# Eval("PaymentSchedule5") > 0%>'>
                                                            <table style="width: 100%">
                                                                <tr>
                                                                    <td style="width: 180px; text-align: right">Payment Schedule 5:
                                                                    </td>
                                                                    <td style="width: 80px">
                                                                        <telerik:RadTextBox ID="txtValue5" runat="server" Text='<%# Bind("PaymentSchedule5")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadTextBox ID="txtText5" runat="server" EmptyMessage="Schedule Description 5" MaxLength="200" Text='<%# Bind("PaymentText5")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="PanelPS6" runat="server" Visible='<%# Eval("PaymentSchedule6") > 0%>'>
                                                            <table style="width: 100%">
                                                                <tr>
                                                                    <td style="width: 180px; text-align: right">Payment Schedule 6:
                                                                    </td>
                                                                    <td style="width: 80px">
                                                                        <telerik:RadTextBox ID="txtValue6" runat="server" Text='<%# Bind("PaymentSchedule6")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadTextBox ID="txtText6" runat="server" EmptyMessage="Schedule Description 6" MaxLength="200" Text='<%# Bind("PaymentText6")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="PanelPS7" runat="server" Visible='<%# Eval("PaymentSchedule7") > 0%>'>
                                                            <table style="width: 100%">
                                                                <tr>
                                                                    <td style="width: 180px; text-align: right">Payment Schedule 7:
                                                                    </td>
                                                                    <td style="width: 80px">
                                                                        <telerik:RadTextBox ID="txtValue7" runat="server" Text='<%# Bind("PaymentSchedule7")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadTextBox ID="txtText7" runat="server" EmptyMessage="Schedule Description 7" MaxLength="200" Text='<%# Bind("PaymentText7")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="PanelPS8" runat="server" Visible='<%# Eval("PaymentSchedule8") > 0%>'>
                                                            <table style="width: 100%">
                                                                <tr>
                                                                    <td style="width: 180px; text-align: right">Payment Schedule 8:
                                                                    </td>
                                                                    <td style="width: 80px">
                                                                        <telerik:RadTextBox ID="txtValue8" runat="server" Text='<%# Bind("PaymentSchedule8")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadTextBox ID="txtText8" runat="server" EmptyMessage="Schedule Description 8" MaxLength="200" Text='<%# Bind("PaymentText8")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="PanelPS9" runat="server" Visible='<%# Eval("PaymentSchedule9") > 0%>'>
                                                            <table style="width: 100%">
                                                                <tr>
                                                                    <td style="width: 180px; text-align: right">Payment Schedule 9:
                                                                    </td>
                                                                    <td style="width: 80px">
                                                                        <telerik:RadTextBox ID="txtValue9" runat="server" Text='<%# Bind("PaymentSchedule9")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadTextBox ID="txtText9" runat="server" EmptyMessage="Schedule Description 9" MaxLength="200" Text='<%# Bind("PaymentText9")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="PanelPS10" runat="server" Visible='<%# Eval("PaymentSchedule10") > 0%>'>
                                                            <table style="width: 100%">
                                                                <tr>
                                                                    <td style="width: 180px; text-align: right">Payment Schedule 10:
                                                                    </td>
                                                                    <td style="width: 80px">
                                                                        <telerik:RadTextBox ID="txtValue10" runat="server" Text='<%# Bind("PaymentSchedule10")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadTextBox ID="txtText10" runat="server" EmptyMessage="Schedule Description 10" MaxLength="200" Text='<%# Bind("PaymentText10")%>' Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <table style="width: 100%" class="table-condensed">
                                            <tr>
                                                <td style="text-align: right; padding-right: 25px">
                                                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false"
                                                        CommandName="Update" CausesValidation="true">
                                        Update
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>

                                    </telerik:RadWizardStep>
                                    <telerik:RadWizardStep runat="server" ID="RadWizardStep4" Title="Term & Conditions" StepType="Step">

                                        <table style="width: 100%" class="table-condensed">
                                            <tr>
                                                <td style="text-align: right; width: 300px">To change, Select Template and Apply:
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="cboTandCtemplates" runat="server" DataSourceID="SqlDataSourceTandCtemplates"
                                                        DataTextField="Name" DataValueField="Id" Height="400px" Width="100%">
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="text-align: left; width: 250px">
                                                    <telerik:RadButton ID="btnUpdateTandCTemplate" runat="server" CommandName="UpdateTandC" OnClick="btnUpdateTandCTemplate_Click"
                                                        Text="Apply" Primary="true" Width="100px">
                                                    </telerik:RadButton>
                                                </td>
                                            </tr>

                                        </table>
                                        <table style="width: 100%" class="table-condensed">
                                            <tr>
                                                <td>
                                                    <telerik:RadEditor ID="radEditor_TandC" runat="server" AllowScripts="True" Content='<%# Bind("MyAgreements")%>'
                                                        EditModes="Design" Height="470px" ToolsFile="~/BasicTools.xml" Width="100%" RenderMode="Auto">
                                                    </telerik:RadEditor>
                                                </td>
                                            </tr>
                                        </table>
                                        <table style="width: 100%" class="table-condensed">
                                            <tr>
                                                <td style="text-align: right; padding-right: 25px">
                                                    <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false"
                                                        CommandName="Update" CausesValidation="true">
                                        Update
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>

                                    </telerik:RadWizardStep>
                                    <telerik:RadWizardStep runat="server" ID="RadWizardStep5" Title="References" StepType="Step">
                                        <fieldset>
                                            <legend>Uploaded files (JPG, PDF, DOC, XLS, ...) </legend>
                                            <table class="table-condensed" style="width: 100%">
                                                <tr>
                                                    <td colspan="3">
                                                        <asp:Panel runat="server" class="DropZoneClient">
                                                            <h4>Select or Drag and Drop files (up to 100Mb)</h4>
                                                            <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" MultipleFileSelection="Automatic" OnClientUploadFailed="onClientUploadFailed"
                                                                OnFileUploaded="RadCloudUpload1_FileUploaded" ProviderType="Azure"
                                                                MaxFileSize="100145728"
                                                                DropZones=".DropZoneClient">
                                                            </telerik:RadCloudUpload>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right;">
                                                        <asp:LinkButton ID="btnSaveUpload" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" ToolTip="Upload and Save selected files">
                                                                    <span class="glyphicon glyphicon-cloud-upload"></span>&nbsp;&nbsp;Upload
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div>
                                                <telerik:RadGrid ID="RadGridAzureuploads" runat="server" DataSourceID="SqlDataSourceAzureFiles" GroupPanelPosition="Top" ShowFooter="true"
                                                    AllowAutomaticUpdates="True" AllowPaging="True" PageSize="25" AllowSorting="True" AllowAutomaticDeletes="True">
                                                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceAzureFiles"
                                                        ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                                                        <Columns>
                                                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                                                HeaderText="" HeaderStyle-Width="40px">
                                                            </telerik:GridEditCommandColumn>
                                                            <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name"
                                                                ItemStyle-Font-Size="Medium" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                                                <EditItemTemplate>
                                                                    <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="255" Width="100%"></telerik:RadTextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <a href='<%# Eval("url")%>' target="_blank" download='<%# Eval("Name") %>'><%# String.Concat(Eval("Name"), " (", Eval("ContentType"), ")")%></a>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date" SortExpression="Date" UniqueName="Date"
                                                                HeaderStyle-Width="100px" ReadOnly="true">
                                                                <ItemTemplate>
                                                                    <%# Eval("Date", "{0:d}")%>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn DataField="nType" FilterControlAltText="Filter nType column" HeaderText="Type" SortExpression="nType" UniqueName="nType"
                                                                HeaderStyle-Width="100px">
                                                                <EditItemTemplate>
                                                                    <telerik:RadComboBox ID="cboDocTypeEdit" runat="server" DataSourceID="SqlDataSourceDocTypes" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("Type") %>' Width="100%">
                                                                    </telerik:RadComboBox>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <%# Eval("nType")%>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn DataField="Public" FilterControlAltText="Filter Public column" HeaderText="Public" SortExpression="Public" UniqueName="Public"
                                                                HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                <EditItemTemplate>
                                                                    <telerik:RadCheckBox ID="chkPublicEdit" runat="server" ToolTip="Public or private" Checked='<%# Bind("Public") %>' AutoPostBack="false">
                                                                    </telerik:RadCheckBox>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <telerik:RadCheckBox ID="chkPublicEdit" runat="server" ToolTip="Public or private" Checked='<%# Eval("Public") %>' Enabled="false">
                                                                    </telerik:RadCheckBox>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn UniqueName="ContentBytes" Aggregate="Sum" DataFormatString="{0:N0}" ReadOnly="true"
                                                                SortExpression="ContentBytes" HeaderText="Bytes" DataField="ContentBytes"
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
                                            </div>
                                        </fieldset>
                                    </telerik:RadWizardStep>
                                    <telerik:RadWizardStep runat="server" ID="Fees" Title="Task & Fee(s)" StepType="Step">
                                        <table style="width: 100%" class="table-condensed">
                                            <tr>
                                                <td>
                                                    <telerik:RadGrid ID="RadGridRFPDet" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceRFPdetalles" ShowFooter="true"
                                                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                                                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceRFPdetalles">
                                                            <Columns>
                                                                <telerik:GridBoundColumn DataField="TaskCode" HeaderStyle-Width="150px" HeaderText="Task ID" UniqueName="TaskCode" ItemStyle-HorizontalAlign="Center">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridTemplateColumn DataField="Description" HeaderText="Task" UniqueName="Description">
                                                                    <ItemTemplate>
                                                                        <b><%# Eval("Description") %></b>
                                                                        <small>
                                                                            <%# iif(Len(Eval("DescriptionPlus")) > 0, String.Concat("<br/>", Eval("DescriptionPlus")), "") %>
                                                                        </small>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridBoundColumn DataField="Quantity" DataFormatString="{0:N2}" HeaderStyle-Width="80px" HeaderText="Qty" ItemStyle-HorizontalAlign="Center" UniqueName="Quantity"
                                                                    Display="false">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="UnitPrice" DataFormatString="{0:N2}" HeaderStyle-Width="100px" HeaderText="Price" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="60px" SortExpression="UnitPrice" UniqueName="UnitPrice"
                                                                    Display="false">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn Aggregate="Sum" DataField="LineTotal" DataFormatString="{0:N2}"
                                                                    FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="150px" HeaderText="Total" ItemStyle-HorizontalAlign="Right" UniqueName="LineTotal">
                                                                </telerik:GridBoundColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                </td>
                                            </tr>
                                        </table>
                                    </telerik:RadWizardStep>
                                </WizardSteps>
                            </telerik:RadWizard>
                        </td>
                    </tr>

                </table>
            </EditItemTemplate>
        </asp:FormView>
    </div>


    <asp:SqlDataSource ID="SqlDataSourceRFP" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="RFP_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="RFP_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblRFPId" Name="Id" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ProjectName" />
            <asp:Parameter Name="ProjectLocation" />
            <asp:Parameter Name="ProjectArea" />
            <asp:Parameter Name="ProjectDescription" />
            <asp:Parameter Name="PaymentSchedule1" Type="Int16" />
            <asp:Parameter Name="PaymentText1" />
            <asp:Parameter Name="PaymentSchedule2" Type="Int16" />
            <asp:Parameter Name="PaymentText2" />
            <asp:Parameter Name="PaymentSchedule3" Type="Int16" />
            <asp:Parameter Name="PaymentText3" />
            <asp:Parameter Name="PaymentSchedule4" Type="Int16" />
            <asp:Parameter Name="PaymentText4" />
            <asp:Parameter Name="PaymentSchedule5" Type="Int16" />
            <asp:Parameter Name="PaymentText5" />
            <asp:Parameter Name="PaymentSchedule6" Type="Int16" />
            <asp:Parameter Name="PaymentText6" />
            <asp:Parameter Name="PaymentSchedule7" Type="Int16" />
            <asp:Parameter Name="PaymentText7" />
            <asp:Parameter Name="PaymentSchedule8" Type="Int16" />
            <asp:Parameter Name="PaymentText8" />
            <asp:Parameter Name="PaymentSchedule9" Type="Int16" />
            <asp:Parameter Name="PaymentText9" />
            <asp:Parameter Name="PaymentSchedule10" Type="Int16" />
            <asp:Parameter Name="PaymentText10" />
            <asp:Parameter Name="MyAgreements" />
            <asp:Parameter Name="Sender" />
            <asp:Parameter Name="DateSended" />
            <asp:Parameter Name="IntroductoryText" />
            <asp:Parameter Name="StateId" />
            <asp:ControlParameter ControlID="lblRFPId" Name="Id" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>

 <asp:SqlDataSource ID="SqlDataSourceAzureFiles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="RequestForProposals_azureuploads_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="RequestForProposals_azureuploads_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommand="RequestForProposals_azureuploads_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblRFPId" Name="requestforproposalId" PropertyName="Text" />
        </SelectParameters>
        <DeleteParameters>
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
<asp:SqlDataSource ID="SqlDataSourceRFPdetalles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, TaskCode, Description, isnull(DescriptionPlus,'') as DescriptionPlus, Quantity, UnitPrice, LineTotal FROM RequestForProposals_details WHERE (rfpId = @rfpId) ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblRFPId" Name="rfpId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTandCtemplates" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Proposal_TandCtemplates] WHERE ([companyId] = @companyId) ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePaymentSchedules" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Invoices_types WHERE (companyId = @companyId) ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [State] FROM [RequestForProposals_state] ORDER BY Id"></asp:SqlDataSource>



    <asp:Label ID="lblGuiId" runat="server" Visible="False" Text="e2103445-8a47-49ff-808e-6008c0fe13a1"></asp:Label>
    
    <asp:Label ID="lblRFPId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>

</asp:Content>

