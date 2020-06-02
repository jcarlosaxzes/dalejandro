<%@ Page Title="Client Collection" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="newclientcollection.aspx.vb" Inherits="pasconcept20.newclientcollection" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="Formulario">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="width: 120px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                       Back to List
                    </asp:LinkButton>
                </td>
                <td style="text-align: center">
                    <h3>Client Collection Notification</h3>
                </td>

            </tr>
        </table>
    </div>


    <div class="pas-container">

        <telerik:RadWizard ID="RadWizard1" runat="server" Height="680px" DisplayProgressBar="false"
            RenderMode="Lightweight" Skin="Material" Localization-Cancel="Back" Localization-Finish="Send">
            <WizardSteps>

                <%-- Contact Information --%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepClient" Title="Client" ValidationGroup="Collection" StepType="Start">
                    <div>
                        <asp:ValidationSummary ID="vsConfirmation" runat="server" ValidationGroup="Collection" ForeColor="Red"
                            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
                    </div>
                    <h4>Client to Collection</h4>
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td style="width: 180px; text-align: right">Client:
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClients" Width="90%" AutoPostBack="true"
                                    DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="250px"
                                    AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(Select client...)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>

                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblClientAddress" Font-Size="Small" ></asp:Label>
                            </td>
                            
                        </tr>
                        <tr>
                            <td style="width: 180px; text-align: right">Notes:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtNotes" runat="server" Width="90%" EmptyMessage="Collection notes..." TextMode="MultiLine" Rows="4">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 180px; text-align: right">Attorney Firm:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtAttorneyFirm" runat="server" Width="90%" MaxLength="80">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 180px; text-align: right">Attorney Name:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtAttorneyName" runat="server" Width="90%" MaxLength="80">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 180px; text-align: right">Attorney Phone:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtAttorneyPhone" runat="server" Width="90%" MaxLength="10">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 180px; text-align: right">Attorney Email:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtAttorneyEmail" runat="server" Width="90%" MaxLength="80">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 180px; text-align: right">Past Due Balance:
                            </td>
                            <td>
                                <telerik:RadNumericTextBox ID="txtPastDueBalance" runat="server" MinValue="1" Width="150px" Type="Currency">
                                    <NumberFormat DecimalDigits="2" />
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 180px; text-align: right">Amount of Days Past Due:
                            </td>
                            <td>
                                <telerik:RadNumericTextBox ID="txtDaysPastDue" runat="server" MinValue="1" Width="150px">
                                    <NumberFormat DecimalDigits="0" />
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 180px; text-align: right">Date of Contract:
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="RadDatePickerDateofContract" runat="server" Width="150px" Culture="en-US">
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                    </table>

                    <div>
                        <asp:CompareValidator runat="server" ID="Comparevalidator5" ValueToCompare="(Select client...)"
                            Operator="NotEqual" ControlToValidate="cboClients" Text="*" ErrorMessage="<span><b>Client </b> is required</span>" ValidationGroup="Collection" Display="None">
                        </asp:CompareValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Collection" Display="None"
                            ControlToValidate="txtNotes"
                            ErrorMessage="<span><b>Notes/b> is required</span>">
                        </asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Collection" Display="None"
                            ControlToValidate="txtAttorneyFirm"
                            ErrorMessage="<span><b>Attorney Firm/b> is required</span>">
                        </asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Collection" Display="None"
                            ControlToValidate="txtAttorneyName"
                            ErrorMessage="<span><b>Attorney Name/b> is required</span>">
                        </asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Collection" Display="None"
                            ControlToValidate="txtAttorneyPhone"
                            ErrorMessage="<span><b>Attorney Phone/b> is required</span>">
                        </asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Collection" Display="None"
                            ControlToValidate="txtAttorneyEmail"
                            ErrorMessage="<span><b>Attorney Email/b> is required</span>">
                        </asp:RequiredFieldValidator>


                    </div>
                </telerik:RadWizardStep>

                <%-- Send --%>
                <telerik:RadWizardStep runat="server" Title="Message" ID="Message" Enabled="false" StepType="Finish">
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Client Email</h4>
                            <table style="width: 100%" class="table-condensed">
                                <tr>
                                    <td>Client To:
                                    </td>
                                    <td style="width: 45%">
                                        <telerik:RadTextBox ID="txtClientTo" runat="server" Width="90%" Enabled="false">
                                        </telerik:RadTextBox>
                                    </td>
                                    <td>Client CC:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtClientCC" runat="server" Width="90%" EmptyMessage="CC email">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Client Subject:
                                    </td>
                                    <td colspan="3">
                                        <telerik:RadTextBox ID="txtClientSubject" runat="server" Width="90%">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <telerik:RadEditor ID="txtClientBody" runat="server" Height="250px" RenderMode="Auto"
                                            AllowScripts="True" EditModes="Design" Width="90%">
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
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Attorney Email</h4>
                            <table style="width: 100%" class="table-condensed">
                                <tr>
                                    <td>Attorney To:
                                    </td>
                                    <td style="width: 45%">
                                        <telerik:RadTextBox ID="txtAttorneyTo" runat="server" Width="90%" Enabled="false">
                                        </telerik:RadTextBox>
                                    </td>
                                    <td>Attorney CC:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtAttorneyCC" runat="server" Width="90%" EmptyMessage="Attorney CC email">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Attorney Subject:
                                    </td>
                                    <td colspan="3">
                                        <telerik:RadTextBox ID="txtAttorneySubject" runat="server" Width="90%">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <telerik:RadEditor ID="txtAttorneyBody" runat="server" Height="250px" RenderMode="Auto"
                                            AllowScripts="True" EditModes="Design" Width="90%">
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
                            Client and Attorney Notification Process have been completed successfully!
                        </div>
                    </div>

                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>

    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="Clients_collection_INSERT" InsertCommandType="StoredProcedure" 
        UpdateCommand="Clients_collection_UPDATE" UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtNotes" Name="Notes" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtAttorneyFirm" Name="AttorneyFirm" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtAttorneyName" Name="AttorneyName" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtAttorneyPhone" Name="AttorneyPhone" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtAttorneyEmail" Name="AttorneyEmail" PropertyName="Text" />

            <asp:ControlParameter ControlID="txtPastDueBalance" Name="PastDueBalance" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtDaysPastDue" Name="DaysPastDue" PropertyName="Text" />
            <asp:ControlParameter ControlID="RadDatePickerDateofContract" Name="DateofContract" PropertyName="SelectedDate" />

            <asp:Parameter Direction="InputOutput" Name="Id_OUT" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtNotes" Name="Notes" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtAttorneyFirm" Name="AttorneyFirm" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtAttorneyName" Name="AttorneyName" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtAttorneyPhone" Name="AttorneyPhone" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtAttorneyEmail" Name="AttorneyEmail" PropertyName="Text" />

            <asp:ControlParameter ControlID="txtPastDueBalance" Name="PastDueBalance" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtDaysPastDue" Name="DaysPastDue" PropertyName="Text" />
            <asp:ControlParameter ControlID="RadDatePickerDateofContract" Name="DateofContract" PropertyName="SelectedDate" />

            <asp:ControlParameter ControlID="lblCollectionId" Name="d" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClients" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]+' [' + isnull(Company,'...') + ']' As Name FROM Clients WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCollectionId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeName" runat="server" Visible="False"></asp:Label>
</asp:Content>
