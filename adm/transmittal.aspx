<%@ Page Title="Transmittal Letter" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="transmittal.aspx.vb" Inherits="pasconcept20.transmittal1" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/adm/ADM_Main_Responsive.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function OnClientClose(sender, args) {
                var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                ajaxManager.ajaxRequest();
            }
        </script>
        <telerik:RadAjaxManager
            ID="RadAjaxManager1" runat="server"
            OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        </telerik:RadAjaxManager>
    </telerik:RadCodeBlock>

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
            position: absolute;
            margin-top: 80px;
            width: 100%;
        }

        .checkRtl {
            direction: rtl;
            padding-top:7px !important;
        }
    </style>
    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">

            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
            </asp:LinkButton>
            Transmittal Letter
            <span style="float: right; vertical-align: middle;">
                <script type="text/javascript">
                    function PrintPage(sender, args) {
                        window.print();
                    }
                </script>
                <button type="button" class="btn btn-secondary noprint" onclick="PrintPage()">Print</button>
            </span>
        </span>
    </div>
    <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="false" RenderMode="Lightweight" Skin="Silk" DisplayNavigationButtons="false" DisplayProgressBar="false">
        <WizardSteps>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Transmittal Details" StepType="Step">

                <%--Body--%>
                <div>
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%">
                        <ItemTemplate>
                            <table class="table-sm noprint" style="width: 100%">
                                <tr>
                                    <td style="vertical-align: top">
                                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" CausesValidation="false" CommandName="Edit">
                                            Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnPickUp" runat="server" CssClass="btn btn-info btn-lg" UseSubmitBehavior="false" CausesValidation="false" OnClick="btnPickUp_Click" ToolTip="Send Email to Client with Ready For Pick Up Notification">
                                        <i class="fas fa-signature"></i>&nbsp;Sign & Pick Up
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnMailReadyToSign" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false" ToolTip="Send Email to Client that the Tranmittal was signed and delivered"
                                            OnClick="btnMailReadyToSign_Click" Visible="false">
                                            <i class="far fa-envelope"></i>&nbsp;Delivery Notification
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnMailDigitalDelivery" runat="server" CssClass="btn btn-info btn-lg" UseSubmitBehavior="false" CausesValidation="false" ToolTip="Send Email to Client with Transmittal Digital Delivery Notification"
                                            OnClick="btnMailDigitalDelivery_Click" Visible='<%# IIf(LocalAPI.GetTransmittalDigitalFilesCount(Eval("Id")) = 0, False, True)%>'>
                                            <i class="far fa-envelope"></i>&nbsp;Digital Notification
                                        </asp:LinkButton>
                                        <br />
                                        <table class="table-sm" style="width: 100%; background-color: white">
                                            <tr>
                                                <td style="width: 65%; vertical-align: top">
                                                    <table class="table-sm" style="width: 100%; background-color: white">
                                                        <tr>
                                                            <td style="text-align: right; width: 150px"><b>Transmittal ID:</b>
                                                            </td>
                                                            <td style="text-align: left">
                                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("TransmittalID")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right;"><b>Client Name:</b>
                                                            </td>
                                                            <td style="text-align: left;">
                                                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("ClientName")%>' />
                                                            </td>

                                                        </tr>

                                                        <tr>
                                                            <td style="text-align: right;"><b>Date Created:</b>
                                                            </td>
                                                            <td style="text-align: left;">
                                                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("TransmittalDate", "{0:d}")%>' />
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td style="text-align: right;"><b>Job No. & Name:</b>
                                                            </td>
                                                            <td style="text-align: left">
                                                                <asp:Label ID="Label9" runat="server" Text='<%# Eval("JobNo")%>' />
                                                                &nbsp;&nbsp;&nbsp;
                                        <asp:Label ID="Label10" runat="server" Text='<%# Eval("JobName")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right"><b>A/E of Record:</b>
                                                            </td>
                                                            <td style="text-align: left">
                                                                <asp:Label ID="Label11" runat="server" Text='<%# Eval("RecordBy_Name")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right;"><b>Status:</b>
                                                            </td>
                                                            <td style="text-align: left">
                                                                <asp:Label ID="ProposalNumberLabel" runat="server" Text='<%# Eval("nStatus")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right"><b>Remaining Balance:</b>
                                                            </td>
                                                            <td style="text-align: left">
                                                                <asp:Label ID="Label198" runat="server" Text='<%# Eval("RemainingBalance", "{0:C2}")%>' />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="text-align: right; vertical-align: top">
                                        <telerik:RadBarcode runat="server" ID="RadBarcode1" Type="QRCode" Text="" Height="140px" Width="140px" Style="margin-left: 30px" OutputType="EmbeddedPNG">
                                            <QRCodeSettings Version="5" DotSize="3" Mode="Byte" />
                                        </telerik:RadBarcode>
                                    </td>
                                </tr>
                            </table>



                            <telerik:RadGrid ID="RadGridDetails" RenderMode="Lightweight" runat="server" DataSourceID="SqlDataSourceDetails" Width="100%" AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                                <MasterTableView DataSourceID="SqlDataSourceDetails">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="AmountCopy" HeaderText="Amount Copy" UniqueName="AmountCopy"
                                            HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="PakageContent" HeaderText="Package Content" UniqueName="PakageContent"
                                            HeaderStyle-Width="180px" HeaderStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Description" HeaderText="Description" UniqueName="Description">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Signed" HeaderText="Signed & Sealed" UniqueName="Signed"
                                            HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSigned" runat="server" Text='<%# IIf(Eval("Signed") = 0, "No", "Yes")%>' />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>

                            <table class="table-sm" style="width: 100%; background-color: white">
                                <tr>
                                    <td style="text-align: right; width: 180px;">
                                        <b>Notes:</b>
                                    </td>
                                    <td style="text-align: left">
                                        <%# (Eval("Notes")).Replace(vbCr, "").Replace(vbLf, vbCrLf).Replace(Environment.NewLine, "<br />")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right"><b>Received By:</b>
                                    </td>
                                    <td style="text-align: left" class="TituloHTML">
                                        <%# Eval("ReceiveBy")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><b>Receiver signature:</b>
                                    </td>
                                    <td style="text-align: left; vertical-align: middle">
                                        <telerik:RadBinaryImage ID="RadBinaryClientSign" runat="server" AlternateText="(Not Signed...)"
                                            Width="260px" Height="150px" ResizeMode="Fit"
                                            DataValue='<%# IIf(Eval("SignImage") Is DBNull.Value, Nothing, Eval("SignImage"))%>'></telerik:RadBinaryImage>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="text-align: right"><b>Pick Up Date:</b>
                                    </td>
                                    <td style="text-align: left">
                                        <%# Eval("PickUpDate", "{0:d}")%>
                                    </td>
                                </tr>
                            </table>

                        </ItemTemplate>
                        <EditItemTemplate>
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" CommandName="Update">
                                Update
                                        </asp:LinkButton>
                                        &nbsp;
                            <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary btn-lg" UseSubmitBehavior="false" CausesValidation="false" CommandName="Cancel">
                                Cancel
                            </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="text-align: right; width: 180px"><b>A/E of Record:</b></td>
                                    <td style="text-align: left">
                                        <telerik:RadComboBox ID="cboEngRecord" runat="server"
                                            DataSourceID="SqlDataSourceEmployee" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("RecordBy")%>'
                                            Width="350px" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Select A/E of Record...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><b>Status:</b>
                                    </td>
                                    <td style="text-align: left">
                                        <telerik:RadComboBox ID="cboStatus" runat="server" DataSourceID="SqlDataSourceStatus"
                                            DataTextField="Name" DataValueField="Id" Width="200px" SelectedValue='<%# Bind("Status")%>'>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><b>Received By:</b>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtReceiveBy" runat="server" Text='<%# Bind("ReceiveBy")%>' MaxLength="50" Width="100%"></telerik:RadTextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="text-align: right;"><b>Notes:</b>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes")%>' MaxLength="255" Width="100%" Rows="2" TextMode="MultiLine"></telerik:RadTextBox>
                                    </td>
                                </tr>
                            </table>
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="text-align: left">
                                        <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" OnClick="btnNew_Click" CausesValidation="false">
                            Add Package
                                        </asp:LinkButton>

                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="RadGridEditDetails" runat="server" DataSourceID="SqlDataSourceDetails" GridLines="None"
                                            AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
                                            AllowAutomaticUpdates="True" AllowPaging="True" PageSize="100" AllowSorting="True"
                                            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center">
                                            <MasterTableView DataSourceID="SqlDataSourceDetails" DataKeyNames="Id">
                                                <Columns>
                                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderText="">
                                                        <ItemStyle Width="50px"></ItemStyle>
                                                    </telerik:GridEditCommandColumn>
                                                    <telerik:GridTemplateColumn DataField="AmountCopy" HeaderText="Amount Copy" UniqueName="AmountCopy"
                                                        HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                        <EditItemTemplate>
                                                            <telerik:RadNumericTextBox ID="AmountCopyTextBox" runat="server" Culture="en-US" DbValue='<%# Bind("AmountCopy")%>' Width="125px" ShowSpinButtons="True" ButtonsPosition="Right" MinValue="0">
                                                                <NumberFormat DecimalDigits="0" />
                                                                <IncrementSettings Step="1" />
                                                            </telerik:RadNumericTextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="AmountCopyLabel" runat="server" Text='<%# Eval("AmountCopy")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="packageId" HeaderText="Package Content" UniqueName="packageId"
                                                        HeaderStyle-Width="180px" ItemStyle-CssClass="GridColumn">
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox ID="cboPakageContent" runat="server" DataSourceID="SqlDataSourcePakageTypes"
                                                                DataTextField="Name" DataValueField="Id" Width="300px" SelectedValue='<%# Bind("packageId") %>' AppendDataBoundItems="true">
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text="(Package Not Defined...)" Value="0" />
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="PakageContentLabel" runat="server" Text='<%# Eval("PakageContent")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" SortExpression="Description" UniqueName="Description">
                                                        <EditItemTemplate>
                                                            <telerik:RadTextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description")%>' MaxLength="80" Width="600px"></telerik:RadTextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="Signed" HeaderText="Signed & Sealed by" UniqueName="Signed"
                                                        HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="SignedCheckBox1" runat="server" Checked='<%# Bind("Signed")%>' />
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSigned" runat="server" Text='<%# IIf(Eval("Signed") = 0, "No", "Yes")%>' />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridButtonColumn>
                                                </Columns>
                                                <EditFormSettings>
                                                    <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                                    <EditColumn ButtonType="PushButton">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                    </asp:FormView>

                    <telerik:RadToolTip ID="RadToolTipMail" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
                        <h2 style="margin: 0; text-align: center; color: white; width: 450px">
                            <span class="navbar navbar-expand-md bg-dark text-white">Email to Client
                            </span>
                        </h2>
                        <table class="table-sm" style="width: 450px">
                            <tr>
                                <td>
                                    <h3>Action to sent email</h3>
                                </td>
                            </tr>
                            <tr>
                                <td>Do you want to Send an Email to the Client Notifying your Transmittal is Signed and Seal?
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:LinkButton ID="btnConfirmMail" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false">
                                <i class="far fa-envelope"></i>&nbsp;Send Email
                                    </asp:LinkButton>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                         <asp:LinkButton ID="btnCancelMail" runat="server" CssClass="btn btn-secondary" UseSubmitBehavior="false" CausesValidation="false">
                                Cancel
                         </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadToolTip>
                </div>



            </telerik:RadWizardStep>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Transmittal Files" StepType="Step">


                <div class="pas-container" style="width: 100%">
                    <asp:Panel ID="PanelUpload" runat="server">
                        <table onclick="table-sm pasconcept-bar noprint" width="100%">
                            <tr>
                                <td style="width: 550px; text-align: right">
                                    <asp:LinkButton ID="btnListFiles" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnListFiles_Click">
                                                    <i class="fas fa-align-justify"></i>&nbsp;&nbsp;View Files
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <telerik:RadWizard ID="RadWizardFiles" runat="server" DisplayCancelButton="false" DisplayProgressBar="false"
                        DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Silk" DisplayNavigationBar="false">
                        <WizardSteps>


                            <%--Files--%>
                            <telerik:RadWizardStep runat="server" ID="RadWizardStep5" Title="Files" StepType="Step">
                                <div>
                                    <asp:Panel ID="pnlFind" runat="server">
                                        <table onclick="table-sm pasconcept-bar noprint" width="100%">
                                            <tr>
                                                <td style="width: 550px; text-align: right">
                                                    <asp:LinkButton ID="btnTablePage" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnTablePage_Click" Visible="false">
                                                               <i class="fas fa-align-justify"></i> Table
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnUploadFiles" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" OnClick="btnUploadFiles_Click">
                                                               <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp; Uploads
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnGridPage" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnTablePage_Click">
                                                               <i class="fas fa-th"></i> Grid
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnBulkEdit" runat="server"
                                                        CssClass="btn btn-primary" UseSubmitBehavior="false">
                                                               <i class="fas fa-pencil-alt"></i>&nbsp; Bulk Update
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnBulkDelete" runat="server"
                                                        CssClass="btn btn-danger" UseSubmitBehavior="false">
                                                               <i class="fas fa-trash"></i>&nbsp;Bulk Delete
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>

                                    <telerik:RadListView ID="RadListViewFiles" runat="server" DataSourceID="SqlDataSourceAzureFiles" DataKeyNames="Id" ItemPlaceholderID="Container1" BorderStyle="Solid" AllowMultiItemSelection="true" Visible="false">
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

                                                </div>
                                                <div class="card-body" style="padding: 0px; margin-top: -6px;">
                                                    <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                                                        <table style="width: 100%; flex-wrap: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                                            <tr>
                                                                <td style="height: 108px; padding: 0px;">
                                                                    <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"))%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 12px; padding-top: 5px; padding-bottom: 0px;">
                                                                    <%# FormatSource(Eval("Source"))%>
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
                                                                    <asp:Label ID="lblMaxDownloadeHide" runat="server" Visible="False" Text='<%# Eval("MaxDownload") %>'></asp:Label>
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

                                                </div>
                                                <div class="card-body" style="padding: 0px; margin-top: -6px;">
                                                    <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("MaxDownload")%>' ForeColor="Black" Font-Underline="false">
                                                        <table style="width: 100%; flex-wrap: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                                            <tr>
                                                                <td style="height: 108px; padding: 0px;">
                                                                    <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"))%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 12px; padding-top: 5px; padding-bottom: 0px;">
                                                                    <asp:Label ID="lblFileName" runat="server" Visible="False" Text='<%# Bind("Name") %>'></asp:Label>
                                                                    <%# FormatSource(Eval("Source"))%>
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
                                                                    <asp:Label ID="lblTypeHide" runat="server" Visible="False" Text='<%# Eval("Public") %>'></asp:Label>
                                                                    <asp:Label ID="lblMaxDownloadeHide" runat="server" Visible="False" Text='<%# Eval("Type") %>'></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:LinkButton>

                                                </div>
                                            </div>
                                        </SelectedItemTemplate>
                                    </telerik:RadListView>

                                    <telerik:RadGrid ID="RadGridFiles" runat="server" DataSourceID="SqlDataSourceAzureFiles" GridLines="None" Visible="True"
                                        AllowPaging="True" PageSize="25" AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center" OnItemCommand="RadGridFiles_ItemCommand" AllowMultiRowSelection="true">
                                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceAzureFiles"
                                            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                            <Columns>
                                                <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                                </telerik:GridClientSelectColumn>
                                                <telerik:GridBoundColumn DataField="Id" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" HeaderStyle-Width="40px">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridTemplateColumn DataField="Name" HeaderText="Name" UniqueName="Name" SortExpression="Name" ItemStyle-HorizontalAlign="Left"
                                                    HeaderStyle-Width="400px" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnDownload" runat="server" CommandName="EditForm" CommandArgument='<%# Eval("Id") %>'
                                                            Text='<%# Eval("Name")%>' ToolTip="Click to Download ">
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn DataField="Type" HeaderText="Type" UniqueName="Type" ItemStyle-HorizontalAlign="Center"
                                                    HeaderStyle-Width="180px" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <%# Eval("nType")%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridCheckBoxColumn DataField="Public" HeaderText="Public" UniqueName="Public" ItemStyle-HorizontalAlign="Center"
                                                    HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center">
                                                </telerik:GridCheckBoxColumn>

                                                <telerik:GridTemplateColumn DataField="Size" HeaderText="Size" UniqueName="Size" ItemStyle-HorizontalAlign="Center"
                                                    HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <%#  LocalAPI.FormatByteSize(Eval("ContentBytes"))%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn DataField="Date" HeaderText="Date" UniqueName="Date" SortExpression="Date" ItemStyle-HorizontalAlign="Center"
                                                    HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <%# Eval("Date", "{0:d}")%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="ExpirationDate" HeaderText="Expiration" UniqueName="ExpirationDate" SortExpression="ExpirationDate" ItemStyle-HorizontalAlign="Center"
                                                    HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <%# Eval("ExpirationDate", "{0:d}")%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px">
                                                    <ItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Update" CommandArgument='<%# Eval("Id") %>' ToolTip="Edit">
                                                                            <span class="fas fa-edit"></span>
                                                                    </asp:LinkButton>
                                                                    <asp:Label ID="lblPubicHide" runat="server" Visible="False" Text='<%# Eval("Public") %>'></asp:Label>
                                                                    <asp:Label ID="lblTypeHide" runat="server" Visible="False" Text='<%# Eval("Type") %>'></asp:Label>
                                                                    <asp:Label ID="lblMaxDownloadeHide" runat="server" Visible="False" Text='<%# Eval("MaxDownload") %>'></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("Id") %>' ToolTip="Edit">
                                                                            <span class="fas fa-trash"></span>
                                                                    </asp:LinkButton>
                                                                </td>
                                                                <td>
                                                                    <span title="Number of Downloaded" class="badge badge-pill badge-secondary">
                                                                        <%#Eval("DownloadCount")%>
                                                                    </span>
                                                                    <span title="Max Downloads" class="badge badge-pill badge-warning">
                                                                        <%#Eval("MaxDownload")%>
                                                                    </span>
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

                            <%--Upload Files--%>
                            <telerik:RadWizardStep runat="server" ID="RadWizardStep3" Title="Upload Files" StepType="Step">
                                <asp:Panel ID="UploadPanel" runat="server">
                                    <div class="pasconcept-bar noprint" style="font-size:small;vertical-align:middle;font-family:sans-serif">
                                        File type: 
                                        <telerik:RadComboBox ID="cboDocType" runat="server" DataSourceID="SqlDataSourceDocTypes" DataTextField="Name" DataValueField="Id" Width="250px">
                                        </telerik:RadComboBox>
                                        &nbsp;&nbsp;
                                        <telerik:RadCheckBox ID="chkPublic" runat="server" Text="Public:" ToolTip="Public or private" AutoPostBack="false" Checked="True"  CssClass="checkRtl">
                                        </telerik:RadCheckBox>
                                        &nbsp;&nbsp;
                                        Max Download:
                                        <telerik:RadTextBox ID="tbMaxDownload" runat="server" Width="50px" Text="3" />
                                        Expiration Date:
                                        <telerik:RadDatePicker ID="RadDatePickerExpiration" runat="server" ZIndex="50001" >
                                        </telerik:RadDatePicker>
                                        <span style="float: right; vertical-align: middle;">
                                            <asp:LinkButton ID="btnSaveUpload" runat="server" CssClass="btn btn-success btn float-right" UseSubmitBehavior="false" ToolTip="Upload and Save selected files">
                                                    <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp;Upload
                                            </asp:LinkButton>
                                        </span>
                                    </div>

                                    <div style="width: 99%; height: 450px; position: relative">
                                        <table style="width: 100%; position: absolute; margin-top: 3px; background-color: lightgray; height: 200px;">
                                            <tr>
                                                <td style="width: 90%; vertical-align: top;">
                                                    <h4 class="additional-text">Select Files to Upload</h4>
                                                </td>
                                            </tr>
                                        </table>
                                        <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" RenderMode="Lightweight" MultipleFileSelection="Automatic" OnFileUploaded="RadCloudUpload1_FileUploaded"
                                            ProviderType="Azure" MaxFileSize="1048576" CssClass="h-100 fileUploadRad">
                                        </telerik:RadCloudUpload>
                                    </div>
                                </asp:Panel>
                            </telerik:RadWizardStep>
                        </WizardSteps>
                    </telerik:RadWizard>
                </div>


            </telerik:RadWizardStep>


            <telerik:RadWizardStep runat="server" ID="RadWizardStep4" Title="Transmittal Links" StepType="Step">
                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td>
                            <h3>Job Links</h3>
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="padding-left: 15px">
                                        <asp:LinkButton ID="btnNewFileLink" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false" ToolTip="Add Links">
                                        Add Hyperlink
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
                                        <telerik:GridEditCommandColumn ButtonType="ImageButton" HeaderText="" HeaderStyle-Width="40px" UniqueName="EditCommandColumn">
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
                                                <a href='<%# Eval("link")%>' target="_blank"><%# Eval("Title")%></a>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="Descripciption" FilterControlAltText="Filter Descripciption column"
                                            HeaderText="Description" SortExpression="Descripciption" UniqueName="Descripciption" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <%# Eval("Descripciption")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox ID="DescripciptionTextBox" runat="server" Rows="3" Text='<%# Bind("Descripciption") %>' Width="600px" MaxLength="1024"></telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridDateTimeColumn DataField="ExpirationDate" HeaderText="Expiration" PickerType="DatePicker" UniqueName="ExpirationDate" SortExpression="ExpirationDate" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" DataFormatString="{0:d}">
                                        </telerik:GridDateTimeColumn>
                                        <telerik:GridTemplateColumn DataField="Link" FilterControlAltText="Filter Link column" Display="false"
                                            HeaderText="Link (url)" SortExpression="Link" UniqueName="Link" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <%# Eval("Link")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox ID="LinkTextBox" runat="server" Text='<%# Bind("Link") %>' Width="600px" MaxLength="256"></telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this link?"
                                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                            UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
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

            </telerik:RadWizardStep>

        </WizardSteps>
    </telerik:RadWizard>


    <telerik:RadToolTip ID="RadToolTipBulkEdit" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table-sm" style="width: 600px">
            <tr>
                <td colspan="2">
                    <h3 style="margin: 0; text-align: center; color: white; width: 600px">
                        <span class="navbar navbar-expand-md bg-dark text-white">Update File(s)</span>
                    </h3>
                </td>
            </tr>
            <tr>
                <td style="width: 180px;text-align:right">
                    File type:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboDocTypeBulk" runat="server" DataSourceID="SqlDataSourceDocTypes" ZIndex="10000" DataTextField="Name" DataValueField="Id" Width="100%">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align:right">
                    Public:
                </td>
                <td>
                    <telerik:RadCheckBox ID="chkPublicBulk" runat="server" ToolTip="Public or private" AutoPostBack="false"></telerik:RadCheckBox>
                </td>
            </tr>
            <tr>
                <td style="text-align:right">
                    Max Download:
                </td>
                <td>
                    <telerik:RadTextBox ID="tbMaxDownloadBulk" runat="server" Width="50px" Text="3" />
                </td>
            </tr>
            <tr>
                <td style="text-align:right">
                    Expiration Date:
                </td>
                <td>
                     <telerik:RadDatePicker ID="RadDatePickerExpirationBulk" runat="server" ZIndex="50001" >
                     </telerik:RadDatePicker>
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

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="TRANSMITTAL_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="TRANSMITTAL2_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblTransmittalId" Name="TransmittalId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Status" Type="Int16" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="ReceiveBy" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDetails" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="TRANSMITTAL_DETAILS_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="TRANSMITTAL_DETAILS_UPDATE" UpdateCommandType="StoredProcedure"
        DeleteCommand="TRANSMITTAL_DETAILS_DELETE" DeleteCommandType="StoredProcedure"
        InsertCommand="TRANSMITTAL_DETAILS_INSERT" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="packageId" Type="Int32" />
            <asp:Parameter Name="AmountCopy" Type="Int32" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Signed" Type="Boolean" />
            <asp:ControlParameter ControlID="lblTransmittalId" Name="transmittalId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblTransmittalId" Name="TransmittalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="packageId" Type="Int32" />
            <asp:Parameter Name="AmountCopy" Type="Int32" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Signed" Type="Boolean" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePakageTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Transmittals_package_types] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Transmittals_status] ORDER BY [Id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE (companyId=@companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceAzureFiles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Transmital_azureuploads_v20_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="ClientProsalJob_azureuploads_v20_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblTransmittalId" Name="transmittalId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Source" />
            <asp:Parameter Name="Id" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDocTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_azureuploads_types] ORDER BY [Id]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceLinks" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Jobs_links] WHERE [Id] = @Id"
        InsertCommand="INSERT INTO [Jobs_links] ([Job], [Title], [Descripciption], [Link], TransmittalId, [Date], [ExpirationDate]) VALUES (@Job, @Title, @Descripciption, @Link, @TransmittalId, dbo.CurrentTime(),@ExpirationDate)"
        SelectCommand="SELECT Id, Job, Title, Descripciption, Link, ExpirationDate FROM Jobs_links WHERE (TransmittalId = @TransmittalId) ORDER BY Title"
        UpdateCommand="UPDATE [Jobs_links] SET  [Title] = @Title, [Descripciption] = @Descripciption, [Link] = @Link,ExpirationDate=@ExpirationDate WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Descripciption" Type="String" />
            <asp:Parameter Name="Link" Type="String" />
            <asp:Parameter Name="ExpirationDate" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblTransmittalId" DefaultValue="0" Name="TransmittalId" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="Job" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblTransmittalId" Name="TransmittalId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Descripciption" Type="String" />
            <asp:Parameter Name="Link" Type="String" />
            <asp:Parameter Name="ExpirationDate" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTransmittalId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblBackPage" runat="server" Visible="False"></asp:Label>
</asp:Content>
