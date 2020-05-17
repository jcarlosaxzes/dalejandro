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
                <telerik:RadWizardStep runat="server" ID="Client" Title="Client" ValidationGroup="Client" StepType="Start">
                    <div>
                        <asp:ValidationSummary ID="vsConfirmation" runat="server" ValidationGroup="Confirmation"
                            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
                    </div>
                    <h4>Client to Collection</h4>
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td style="width: 180px; text-align: right">Client:
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient" Width="90%"
                                    DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="250px"
                                    AppendDataBoundItems="true" >
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(Select client...)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </telerik:RadWizardStep>

                <%-- Send --%>
                <telerik:RadWizardStep runat="server" Title="Message" ID="Message" Enabled="false" StepType="Finish">
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Client Email</h4>
                            <table style="width: 100%" class="table-condensed">
                                <tr>
                                    <td>Clieent To:
                                    </td>
                                    <td style="width: 45%">
                                        <telerik:RadTextBox ID="txtClientTo" runat="server" Width="100%" EmptyMessage="Client email">
                                        </telerik:RadTextBox>
                                    </td>
                                    <td>Client CC:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtClientCC" runat="server" Width="100%" EmptyMessage="CC email">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Client Subject:
                                    </td>
                                    <td colspan="3">
                                        <telerik:RadTextBox ID="txtClientSubject" runat="server" Width="100%">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <telerik:RadEditor ID="txtClientBody" runat="server" Height="250px" RenderMode="Auto"
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
                                        <telerik:RadTextBox ID="txtAttorneyTo" runat="server" Width="100%" EmptyMessage="Attorney email">
                                        </telerik:RadTextBox>
                                    </td>
                                    <td>Attorney CC:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtAttorneyCC" runat="server" Width="100%" EmptyMessage="Attorney CC email">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Attorney Subject:
                                    </td>
                                    <td colspan="3">
                                        <telerik:RadTextBox ID="txtAttorneySubject" runat="server" Width="100%">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <telerik:RadEditor ID="txtAttorneyBody" runat="server" Height="250px" RenderMode="Auto"
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
    <asp:SqlDataSource ID="SqlDataSourceClientes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]+' [' + isnull(Company,'...') + ']' As Name FROM Clients WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCollectionId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeName" runat="server" Visible="False"></asp:Label>
</asp:Content>
