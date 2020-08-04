<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="rfpnewwizard.aspx.vb" Inherits="pasconcept20.rfpnewwizard" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function onClientUploadFailed(sender, eventArgs) {
            alert(eventArgs.get_message())
        }

    </script>
    <style>
        #wrap {
            /*width: 600px;*/
            /*height: 390px;*/
            padding: 0;
            overflow: hidden;
        }

        #frame {
            zoom: 0.75;
            -moz-transform: scale(0.75);
            -moz-transform-origin: 0 0;
        }

        .borderless table {
            border-top-style: none;
            border-left-style: none;
            border-right-style: none;
            border-bottom-style: none;
        }

        /*.rlbItem {
            float: left !important;
            width: 300px;
        }*/

        /*.rlbGroup, .RadListBox {
            width: auto !important;
        }*/

        .mycheckbox input[type="checkbox"] {
            margin-right: 5px !important;
        }

        .leftcheckbox input[type="checkbox"] {
            margin-left: 20px !important;
        }

        label {
            font-weight: normal;
        }

        .RadListBox label > input {
            margin-right: 5px !important;
        }
    </style>

    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
            </asp:LinkButton>
            Request for Proposal
        </span>
    </div>

    <div class="pasconcept-bar">
        <asp:Label ID="lblMsg" runat="server" CssClass="Error"></asp:Label>
        <telerik:RadWizard ID="RadWizard1" runat="server" Height="800px" DisplayCancelButton="false" RenderMode="Lightweight" Skin="Material">
            <WizardSteps>
                <%-- Subconsultants 0--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepsSubconsultants" Title="Subconsultants" ValidationGroup="Subconsultants" StepType="Start">
                    <div>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Subconsultants"
                            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>

                    </div>
                    <div>
                        <fieldset>
                            <legend>Discipline and Subconsultants</legend>

                            <table style="width: 100%" class="table-sm">
                                <tr>
                                    <td style="text-align: center">Select One Discipline to view the list of related Subconsultants below.
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center">
                                        <telerik:RadComboBox ID="cboDiscipline" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceDiscipline"
                                            DataTextField="Name" DataValueField="Id" Width="400px" AppendDataBoundItems="True" CausesValidation="false">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(All disciplines...)" Value="-1" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center">
                                        <telerik:RadListBox ID="RadListBoxSourceSubContrator" runat="server" AllowTransfer="True"
                                            AutoPostBackOnTransfer="True" CausesValidation="False" DataKeyField="Id"
                                            DataSortField="Name" DataSourceID="SqlDataSourceSubConsultans" DataTextField="Name"
                                            DataValueField="Id" Height="300px" TransferToID="RadListBoxDestinationSubContrator"
                                            Width="400px">
                                            <ButtonSettings TransferButtons="All" AreaWidth="35px" />
                                        </telerik:RadListBox>
                                        <telerik:RadListBox ID="RadListBoxDestinationSubContrator" runat="server" AutoPostBackOnDelete="true"
                                            AutoPostBackOnReorder="true" Height="300px" Width="400px" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                </telerik:RadWizardStep>

                <%-- Project Information 1--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepProject" Title="Project Information" Enabled="false" StepType="Step" ValidationGroup="ProjectInformation">
                    <div>
                        <asp:ValidationSummary ID="ProjectInformation" runat="server" ValidationGroup="ProjectInformation"
                            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>

                    </div>
                    <fieldset>
                        <legend>Project Information </legend>
                        <table style="width: 100%" class="table-sm">


                            <tr>
                                <td style="width: 180px; text-align: right">
                                    <b>Project Name</b>:
                                </td>
                                <td colspan="3">
                                    <telerik:RadTextBox ID="txtProjectName" runat="server" Width="100%" MaxLength="80"
                                        SelectionOnFocus="SelectAll" EmptyMessage="(*) Required">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>


                            <tr>
                                <td style="text-align: right">Sender Name:
                                </td>
                                <td colspan="3">
                                    <telerik:RadTextBox ID="txtSender" runat="server" Width="100%" MaxLength="80" SelectionOnFocus="SelectAll" EmptyMessage="(*) Required">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Sender Email:
                                </td>
                                <td colspan="3">
                                    <telerik:RadTextBox ID="txtSenderEmail" runat="server" Width="100%" MaxLength="80" SelectionOnFocus="SelectAll" EmptyMessage="(*) Required">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>

                            <tr>
                                <td style="text-align: right">Date:
                                </td>
                                <td style="width: 180px">
                                    <telerik:RadDatePicker ID="RadDatePicker1" runat="server">
                                    </telerik:RadDatePicker>
                                </td>
                                <td style="width: 180px; text-align: right">Project Area:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtProjectArea" runat="server" Width="100%" MaxLength="80"
                                        SelectionOnFocus="SelectAll">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right; vertical-align: top">Introductory Text:
                                </td>
                                <td colspan="3">
                                    <telerik:RadTextBox ID="txtIntroductoryText" runat="server" Width="100%" MaxLength="512" TextMode="MultiLine"
                                        SelectionOnFocus="SelectAll" Rows="3"
                                        Text="Our firm invites you to bid for a portion of the project referenced in the attached Request for Proposals. If you are interested, please submit you response and do not hesitate to contact our office at any time with questions you may have.">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Project Location:
                                </td>
                                <td colspan="3">
                                    <telerik:RadTextBox ID="txtProjectLocation" runat="server" Width="100%" MaxLength="80"
                                        SelectionOnFocus="SelectAll">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right; vertical-align: top">Description:
                                </td>
                                <td colspan="3">
                                    <telerik:RadTextBox ID="txtProjectDescription" runat="server" Width="100%"
                                        Rows="4" TextMode="MultiLine" SelectionOnFocus="SelectAll" EmptyMessage="(*) Required">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                        <%--Validation--%>
                        <div>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="None"
                                ControlToValidate="txtSender" ErrorMessage="Sender Name is Required" SetFocusOnError="true"
                                Style="color: red" ValidationGroup="ProjectInformation"></asp:RequiredFieldValidator>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="None"
                                ControlToValidate="txtSenderEmail" ErrorMessage="Sender Email is Required" SetFocusOnError="true"
                                Style="color: red" ValidationGroup="ProjectInformation"></asp:RequiredFieldValidator>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="None"
                                ControlToValidate="txtProjectName" ErrorMessage="Project Name is Required" SetFocusOnError="true"
                                Style="color: red" ValidationGroup="ProjectInformation"></asp:RequiredFieldValidator>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                ControlToValidate="txtProjectDescription" ErrorMessage="Project Description is Required" SetFocusOnError="true" Style="color: red"
                                ValidationGroup="ProjectInformation"></asp:RequiredFieldValidator>
                        </div>
                    </fieldset>
                </telerik:RadWizardStep>

                <%-- References (Links) 2--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepReferences" Title="References (Uploaded files)" Enabled="false" StepType="Step">

                    <fieldset>
                        <legend>Uploaded files (JPG, PDF, DOC, XLS, ...) </legend>
                        <table class="table-sm" style="width: 100%">
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
                                <td style="width: 350px;">
                                    <telerik:RadComboBox ID="cboDocType" runat="server" DataSourceID="SqlDataSourceDocTypes" DataTextField="Name" DataValueField="Id" Width="95%" ToolTip="Select file type to Upload" Label="Type:">
                                    </telerik:RadComboBox>
                                </td>
                                <td style="width: 200px;">
                                    <telerik:RadCheckBox ID="chkPublic" runat="server" Text="Public" ToolTip="Public or private" AutoPostBack="False" Checked="true">
                                    </telerik:RadCheckBox>
                                </td>
                                <td style="text-align: right;">
                                    <asp:LinkButton ID="btnSaveUpload" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" ToolTip="Upload and Save selected files">
                                    <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp;Upload
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

                <%-- Payment Schedules 3--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Payment Schedules" Enabled="false" StepType="Step" ValidationGroup="PaymentSchedules">
                    <div>
                        <asp:ValidationSummary ID="ValidationSummary3" runat="server" ValidationGroup="PaymentSchedules"
                            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
                    </div>
                    <fieldset>
                        <legend>Payment Schedules</legend>

                        <table style="width: 100%" class="table-sm">
                            <tr>
                                <td style="text-align: right">Select Payment Schedules Template:
                                </td>
                                <td style="width: 60%;">
                                    <telerik:RadComboBox ID="cboPaymentSchedules" runat="server" DataSourceID="SqlDataSourcePaymentSchedules" AutoPostBack="true"
                                        DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True" AppendDataBoundItems="true"
                                        Filter="Contains" ToolTip="Select Payment Schedules to define first time or modify the current">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Payment Schedules Template...)" Value="-1" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                        <div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="None"
                                ControlToValidate="txtText1" ErrorMessage="Payment Schedules is Required" SetFocusOnError="true"
                                Style="color: red" ValidationGroup="PaymentSchedules"></asp:RequiredFieldValidator>

                        </div>
                        <table style="width: 100%" class="table-sm">
                            <tr>
                                <td style="padding-left: 15px;">
                                    <asp:Panel ID="PanelPS1" runat="server">
                                        Payment Schedule 1:
                                        <telerik:RadTextBox ID="txtValue1" runat="server" Text="0"
                                            Width="8%">
                                        </telerik:RadTextBox>
                                        &nbsp
                                        <telerik:RadTextBox ID="txtText1" runat="server" Text=""
                                            Width="70%" MaxLength="200"
                                            EmptyMessage="Schedule Description 1">
                                        </telerik:RadTextBox>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 15px;">
                                    <asp:Panel ID="PanelPS2" runat="server">
                                        Payment Schedule 2:
                                        <telerik:RadTextBox ID="txtValue2" runat="server" Text="0"
                                            Width="8%">
                                        </telerik:RadTextBox>
                                        &nbsp;
                                        <telerik:RadTextBox ID="txtText2" runat="server" Text=""
                                            Width="70%" MaxLength="200"
                                            EmptyMessage="Schedule Description 2">
                                        </telerik:RadTextBox>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 15px;">
                                    <asp:Panel ID="PanelPS3" runat="server">
                                        Payment Schedule 3:
                                        <telerik:RadTextBox ID="txtValue3" runat="server" Text="0"
                                            Width="8%">
                                        </telerik:RadTextBox>
                                        &nbsp;
                                        <telerik:RadTextBox ID="txtText3" runat="server" Text=""
                                            Width="70%" MaxLength="200"
                                            EmptyMessage="Schedule Description 3">
                                        </telerik:RadTextBox>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 15px;">
                                    <asp:Panel ID="PanelPS4" runat="server">
                                        Payment Schedule 4:
                                        <telerik:RadTextBox ID="txtValue4" runat="server" Text="0"
                                            Width="8%">
                                        </telerik:RadTextBox>
                                        &nbsp;
                                        <telerik:RadTextBox ID="txtText4" runat="server" Text=""
                                            Width="70%" MaxLength="200"
                                            EmptyMessage="Schedule Description 4">
                                        </telerik:RadTextBox>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 15px;">
                                    <asp:Panel ID="PanelPS5" runat="server">
                                        Payment Schedule 5:
                                        <telerik:RadTextBox ID="txtValue5" runat="server" Text="0"
                                            Width="8%">
                                        </telerik:RadTextBox>
                                        &nbsp;
                                        <telerik:RadTextBox ID="txtText5" runat="server" Text=""
                                            Width="70%" MaxLength="200"
                                            EmptyMessage="Schedule Description 5">
                                        </telerik:RadTextBox>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 15px;">
                                    <asp:Panel ID="PanelPS6" runat="server" Visible="false">
                                        Payment Schedule 6:
                                        <telerik:RadTextBox ID="txtValue6" runat="server" Text="0"
                                            Width="8%">
                                        </telerik:RadTextBox>
                                        &nbsp;
                                        <telerik:RadTextBox ID="txtText6" runat="server" Text=""
                                            Width="70%" MaxLength="200"
                                            EmptyMessage="Schedule Description 6">
                                        </telerik:RadTextBox>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 15px;">
                                    <asp:Panel ID="PanelPS7" runat="server" Visible="false">
                                        Payment Schedule 7:
                                        <telerik:RadTextBox ID="txtValue7" runat="server" Text="0"
                                            Width="8%">
                                        </telerik:RadTextBox>
                                        &nbsp;
                                        <telerik:RadTextBox ID="txtText7" runat="server" Text=""
                                            Width="70%" MaxLength="200"
                                            EmptyMessage="Schedule Description 7">
                                        </telerik:RadTextBox>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 15px;">
                                    <asp:Panel ID="PanelPS8" runat="server" Visible="false">
                                        Payment Schedule 8:
                                        <telerik:RadTextBox ID="txtValue8" runat="server" Text="0"
                                            Width="8%">
                                        </telerik:RadTextBox>
                                        &nbsp;
                                        <telerik:RadTextBox ID="txtText8" runat="server" Text=""
                                            Width="70%" MaxLength="200"
                                            EmptyMessage="Schedule Description 8">
                                        </telerik:RadTextBox>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 15px;">
                                    <asp:Panel ID="PanelPS9" runat="server" Visible="false">
                                        Payment Schedule 9:
                                        <telerik:RadTextBox ID="txtValue9" runat="server" Text="0"
                                            Width="8%">
                                        </telerik:RadTextBox>
                                        &nbsp;
                                        <telerik:RadTextBox ID="txtText9" runat="server" Text=""
                                            Width="70%" MaxLength="200"
                                            EmptyMessage="Schedule Description 9">
                                        </telerik:RadTextBox>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 15px;">
                                    <asp:Panel ID="PanelPS10" runat="server" Visible="false">
                                        Payment Schedule 10:
                                        <telerik:RadTextBox ID="txtValue10" runat="server" Text="0"
                                            Width="8%">
                                        </telerik:RadTextBox>
                                        &nbsp;
                                        <telerik:RadTextBox ID="txtText10" runat="server" Text=""
                                            Width="70%" MaxLength="200"
                                            EmptyMessage="Schedule Description 10">
                                        </telerik:RadTextBox>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </telerik:RadWizardStep>

                <%-- Term & Conditions 4--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Term & Conditions" Enabled="false" StepType="Step" ValidationGroup="TermConditions">
                    <div>
                        <asp:ValidationSummary ID="ValidationSummary4" runat="server" ValidationGroup="TermConditions"
                            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
                    </div>
                    <fieldset>
                        <legend>Term & Conditions</legend>


                        <table style="width: 100%" class="table-sm">
                            <tr>
                            </tr>
                            <tr>
                                <td style="text-align: right">Select Term & Conditions Template:
                                </td>
                                <td style="width: 60%; padding-left: 50px">
                                    <telerik:RadComboBox ID="cboTandCtemplates" runat="server" DataSourceID="SqlDataSourceTandCtemplates" AutoPostBack="true"
                                        DataTextField="Name" DataValueField="Id" Width="100%" Height="450px" AppendDataBoundItems="true">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Term & Conditions Template...)" Value="-1" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%" class="table-sm">
                            <tr>
                                <td>
                                    <telerik:RadEditor ID="radEditor_TandC" runat="server" RenderMode="Auto"
                                        Height="380px" ToolsFile="~/BasicTools.xml" AllowScripts="True" EditModes="Design,Preview"
                                        Width="100%">
                                    </telerik:RadEditor>
                                </td>
                            </tr>
                        </table>
                        <div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="None"
                                ControlToValidate="radEditor_TandC" ErrorMessage="Term & Conditions is Required" SetFocusOnError="true"
                                Style="color: red" ValidationGroup="TermConditions"></asp:RequiredFieldValidator>
                        </div>
                    </fieldset>
                </telerik:RadWizardStep>

                <%--Confirmation 5--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepConfirmation" Title="Confirmation" Enabled="false" StepType="Finish" ValidationGroup="Confirmation">
                    <div>
                        <asp:ValidationSummary ID="ValidationSummary5" runat="server" ValidationGroup="!!!!!!!"
                            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
                    </div>

                    <table style="width: 100%" class="table-sm">
                        <tr>
                            <td style="width: 150px; text-align: right">Subject:	
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtSubject" runat="server" Width="100%" MaxLength="80" SelectionOnFocus="SelectAll">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right; vertical-align: top">Body:
                            </td>
                            <td>
                                <telerik:RadEditor ID="txtBody" runat="server" RenderMode="Auto"
                                    Height="300px" ToolsFile="~/BasicTools.xml" AllowScripts="True" EditModes="Design,Preview"
                                    Width="100%">
                                </telerik:RadEditor>

                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" style="text-align: center">
                                <h4>Send this notice to each Subconsultants selected by discipline?</h4>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <table style="width: 100%">
                                    <tr>
                                        <td style="text-align: center; width: 50%">
                                            <telerik:RadRadioButton runat="server" ID="opcUpdate" Text="Save Changes" Font-Size="Large" AutoPostBack="false" />
                                        </td>
                                        <td style="text-align: center">
                                            <telerik:RadRadioButton runat="server" ID="opcUpdateAndSubmit" Text="Save Changes And Submit" Font-Size="Large" AutoPostBack="false" />
                                        </td>

                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>

                </telerik:RadWizardStep>

                <%--Complete 6--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep4" Title="Complete" Enabled="false" StepType="Complete">

                    <fieldset>
                        <legend>Complete</legend>
                        <h3>The Request for Proposal has been created successfully!!!</h3>

                        <div>
                            <iframe id="iframeViewRFP" runat="server" style="border: none; width: 100%; height: 550px"></iframe>
                        </div>

                    </fieldset>
                </telerik:RadWizardStep>

            </WizardSteps>
        </telerik:RadWizard>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceRFP" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="RFP_INSERT" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="cboDiscipline" Name="disciplineId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblSubconsultaActiveId" Name="subconsultanId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtProjectName" Name="ProjectName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtProjectLocation" Name="ProjectLocation" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtProjectArea" Name="ProjectArea" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtProjectDescription" Name="ProjectDescription" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtValue1" Name="PaymentSchedule1" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtText1" Name="PaymentText1" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtValue2" Name="PaymentSchedule2" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtText2" Name="PaymentText2" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtValue3" Name="PaymentSchedule3" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtText3" Name="PaymentText3" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtValue4" Name="PaymentSchedule4" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtText4" Name="PaymentText4" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtValue5" Name="PaymentSchedule5" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtText5" Name="PaymentText5" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtValue6" Name="PaymentSchedule6" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtText6" Name="PaymentText6" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtValue7" Name="PaymentSchedule7" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtText7" Name="PaymentText7" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtValue8" Name="PaymentSchedule8" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtText8" Name="PaymentText8" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtValue9" Name="PaymentSchedule9" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtText9" Name="PaymentText9" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtValue10" Name="PaymentSchedule10" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtText9" Name="PaymentText10" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="radEditor_TandC" Name="MyAgreements" PropertyName="Content" Type="String" />
            <asp:Parameter Name="Sender" Type="String" />
            <asp:Parameter Name="SenderEmail" Type="String" />
            <asp:ControlParameter ControlID="RadDatePicker1" Name="DateSended" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="txtIntroductoryText" Name="IntroductoryText" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblGuiId" Name="guiId" PropertyName="Text" DbType="Guid" />

            <asp:ControlParameter ControlID="lblParentId" Name="ParentID" PropertyName="Text" Type="Int32" />

            <asp:ControlParameter ControlID="lblRFPLastId" Direction="InputOutput" Name="rfpId_OUT" PropertyName="Text" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM SubConsultans_disciplines WHERE (companyId = @companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSubConsultans" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM SubConsultans WHERE (companyId = @companyId) AND (disciplineId = CASE WHEN @disciplineId=-1 THEN disciplineId ELSE @disciplineId END) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="cboDiscipline" Name="disciplineId" PropertyName="SelectedValue" />
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

    <asp:SqlDataSource ID="SqlDataSourceDocTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_azureuploads_types] ORDER BY [Id]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceAzureFiles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="RequestForProposalsGUID_azureuploads_v20_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="RequestForProposals_azureuploads_v20_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommand="RequestForProposals_azureuploads_v20_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblAzureGuiId" Name="guid" PropertyName="Text" />
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

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSubconsultaActiveId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblRFPLastId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblGuiId" runat="server" Visible="False" Text="e2103445-8a47-49ff-808e-6008c0fe13a1"></asp:Label>
    <asp:Label ID="lblAzureGuiId" runat="server" Visible="False" Text="e2103445-8a47-49ff-808e-6008c0fe13a1"></asp:Label>

    <asp:Label ID="lblParentId" runat="server" Visible="False" Text="0"></asp:Label>

    <asp:Label ID="lblBackSource" runat="server" Visible="False" Text="0"></asp:Label>

</asp:Content>

