<%@ Page Title="Send Proposal" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="sendproposal.aspx.vb" Inherits="pasconcept20.sendproposal" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadWizard1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadWizard1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PanelEmail" />
                    <telerik:AjaxUpdatedControl ControlID="PanelSMS" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <div class="Formulario">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 120px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
                    </asp:LinkButton>
                </td>
                <td style="text-align: center">
                    <h3 style="margin:0">Send Proposal to Client</h3>
                </td>

            </tr>
        </table>
    </div>
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
                    <br />

                    <asp:FormView ID="FormViewClientBalance" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceClientBalance" Width="100%">
                        <ItemTemplate>

                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="text-align: left; vertical-align: top; width: 33%">
                                        <h3 style="margin: 0"><span class="card bg-dark text-white">Client</span></h2>

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
                                        <h3 style="margin: 0"><span class="card bg-dark text-white">Projects</span></h2>
                                        <table class="table-sm" style="width: 100%">
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
                                        <h3 style="margin: 0"><span class="card bg-dark text-white">Balance</span></h2>
                                        <table class="table-sm" style="width: 100%">
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
                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td style="width: 270px;text-align:right">Proposal By:
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboProjectManagerId" runat="server" ValidationGroup="Confirmation"
                                    DataSourceID="SqlDataSourceEmployees2" DataTextField="Name" DataValueField="Id" MarkFirstMatch="true" Filter="Contains"
                                    Width="400px" Height="350px" AppendDataBoundItems="True">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="?" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:right">Notification Type:
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
                            <td style="text-align:right">Automatic Retainer (Yes or No):
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboRetainer" runat="server" Width="150px" ValidationGroup="Confirmation">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="?" Value="-1" Selected="true" />
                                        <telerik:RadComboBoxItem Text="Yes" Value="1" />
                                        <telerik:RadComboBoxItem Text="No" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr style="text-align:right">
                            <td>Share Attached Documents (Yes or No):
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboAttached" runat="server" Width="150px" ValidationGroup="Confirmation">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="?" Value="-1" Selected="true" />
                                        <telerik:RadComboBoxItem Text="Yes" Value="1" />
                                        <telerik:RadComboBoxItem Text="No" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>

                            </td>
                        </tr>
                        <tr style="text-align:right">
                            <td>Sent to Agile Campaign (Yes or No):
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboAgile" runat="server" Width="150px" ValidationGroup="Confirmation">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="?" Value="-1" Selected="true" />
                                        <telerik:RadComboBoxItem Text="Yes" Value="1" />
                                        <telerik:RadComboBoxItem Text="No" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr style="text-align:right">
                            <td>Totals:
                            </td>
                            <td>
                                <table style="width:400px">
                                    <tr>
                                        <td style="text-align:center;width:50%">
                                            Proposal Total
                                        </td>
                                        <td style="text-align:center;">
                                            Payment Schedule Total
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center">
                                            <asp:Label ID="lblProposalTotal" runat="server"></asp:Label>
                                        </td>
                                        <td style="text-align:center">
                                            <asp:Label ID="lblScheduleTotal" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align:center">
                                            <asp:Label ID="lblTotalAlert" runat="server" ForeColor="Red"  ></asp:Label>
                                        </td>
                                    </tr>

                                </table>
                            </td>
                        </tr>

                    </table>
                    <div>
                        <asp:CompareValidator runat="server" ID="Comparevalidator5" ValueToCompare="?" ValidationGroup="Confirmation" Operator="NotEqual" SetFocusOnError="true"
                            ControlToValidate="cboRetainer" Text="*"
                            ErrorMessage="Define Automatic Retainer (Yes or No)">
                        </asp:CompareValidator>
                        <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="?" ValidationGroup="Confirmation" Operator="NotEqual" SetFocusOnError="true"
                            ControlToValidate="cboAttached" Text="*"
                            ErrorMessage="Define Share Attached Documents (Yes or No)">
                        </asp:CompareValidator>
                        <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="?" ValidationGroup="Confirmation" Operator="NotEqual" SetFocusOnError="true"
                            ControlToValidate="cboAgile" Text="*"
                            ErrorMessage="Define Sent to Agile Campaign (Yes or No)">
                        </asp:CompareValidator>
                        <asp:CompareValidator runat="server" ID="Comparevalidator3" ValueToCompare="?" ValidationGroup="Confirmation" Operator="NotEqual" SetFocusOnError="true"
                            ControlToValidate="cboProjectManagerId" Text="*"
                            ErrorMessage="Define Proposal By">
                        </asp:CompareValidator>
                        <asp:CompareValidator runat="server" ID="Comparevalidator4" ValueToCompare="?" ValidationGroup="Confirmation" Operator="NotEqual" SetFocusOnError="true"
                            ControlToValidate="cboNotification" Text="*"
                            ErrorMessage="Define Notification Type">
                        </asp:CompareValidator>
                    </div>
                </telerik:RadWizardStep>

                <telerik:RadWizardStep runat="server" Title="Message" ID="Message" Enabled="false" StepType="Finish">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Panel ID="PanelEmail" runat="server">
                                <table style="width: 100%" class="table-sm">
                                    <tr>
                                        <td>To:
                                        </td>
                                        <td style="width: 45%">
                                            <telerik:RadTextBox ID="txtTo" runat="server" Width="100%">
                                            </telerik:RadTextBox>
                                        </td>
                                        <td>CC:
                                        </td>
                                        <td style="width: 45%">
                                            <telerik:RadTextBox ID="txtCC" runat="server" Width="100%">
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
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Panel ID="PanelSMS" runat="server">
                                <table style="width: 100%" class="table-sm">
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

                <telerik:RadWizardStep runat="server" Title="Complete " StepType="Complete ">
                    <br />
                    <br />
                    <br />
                    <br />
                    <div>

                        <div class="alert alert-success" role="alert">
                            <h4 class="alert-heading">Well done!</h4>
                            Proposal Notification Process have been completed successfully!
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

    <asp:SqlDataSource ID="SqlDataSourceEmployees2" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [FullName] As Name FROM [Employees] WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY [FullName]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
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
    <asp:Label ID="lblProposalId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblClientId" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblJobId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblBackSource" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>
