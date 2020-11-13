<%@ Page Title="Client Marketing" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="clientsmarketing.aspx.vb" Inherits="pasconcept20.clientsmarketing" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadWizard1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadWizard1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"  EnableEmbeddedSkins="false" />

    <table class="table-sm" style="width: 100%">
        <tr>
            <td>
                <telerik:RadTextBox ID="txtCampaignName" runat="server" MaxLength="80" Width="90%"></telerik:RadTextBox>
            </td>
            <td style="width: 150px">
                <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" ToolTip="Update Campaign">
                    Update Title
                </asp:LinkButton>
            </td>
        </tr>
    </table>

    <telerik:RadWizard ID="RadWizard1" runat="server" Height="1000px" Width="100%" DisplayCancelButton="false" DisplayProgressBar="false" Localization-Finish="Run Campaign"
        RenderMode="Lightweight" Skin="Material">
        <WizardSteps>
            <telerik:RadWizardStep Title="Email Template" runat="server" StepType="Start">
                <script type="text/javascript">
                    function PasteTextInEditor(text) {
                        var editor = $find("<%=txtBody.ClientID%>"); //get a reference to RadEditor client object    
                        editor.pasteHtml(text); //PasteHtml is a method from the editor client side API
                    }
                </script>
                <asp:Panel ID="PanelEmail" runat="server" Width="100%">
                    <table class="table-sm">
                        <tr>
                            <td colspan="7">Available Information/Ecconomic Client Fiels</td>
                        </tr>
                        <tr>
                            <td>
                                <input id="ClientName" type="button" value="[Client Name]" onclick="PasteTextInEditor('[Client Name]');" style="width: 110px; font-family: calibri; font-size: 12px;" />
                            </td>
                            <td>
                                <input id="ClientCompany" type="button" value="[Client Company]" onclick="PasteTextInEditor('[Client Company]');" style="width: 110px; font-family: calibri; font-size: 12px;" />
                            </td>
                            <td>
                                <input id="Company" type="button" value="[Company]" title="Your Company Name" onclick="PasteTextInEditor('[Company]');" style="width: 110px; font-family: calibri; font-size: 12px;" />
                            </td>
                            <td>
                                <input id="Sign" type="button" value="[Sign]" title="Sign Company Profile" onclick="PasteTextInEditor('[Sign]');" style="width: 110px; font-family: calibri; font-size: 12px;" />
                            </td>
                            <td>
                                <input id="Balance" type="button" title="Client Balance" value="[Balance]" onclick="PasteTextInEditor('[Balance]');" style="width: 110px; font-family: calibri; font-size: 12px;" />
                            </td>
                            <td>
                                <input id="NJobs" type="button" title="Total number of Jobs of Client" value="[#Jobs]" onclick="PasteTextInEditor('[#Jobs]');" style="width: 110px; font-family: calibri; font-size: 12px;" />
                            </td>
                            <td>
                                <input id="TJobs" type="button" value="[$Jobs]" title="Job Budget Total of Client" onclick="PasteTextInEditor('[$Jobs]');" style="width: 110px; font-family: calibri; font-size: 12px;" />
                            </td>
                        </tr>
                    </table>
                    <table style="width: 100%" class="table-sm Formulario">
                        <tr>
                            <td width="50px" class="Normal">Subject:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtSubject" runat="server" Width="100%">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left">
                                <telerik:RadEditor ID="txtBody" runat="server" Height="315px" ToolsFile="~/BasicTools.xml" RenderMode="Auto"
                                    AllowScripts="True" Width="98%">
                                </telerik:RadEditor>
                            </td>
                        </tr>
                    </table>
                    <div style="padding-top: 10px;">
                        <telerik:RadCheckBox ID="chkEmail" runat="server" Text="   Email Campaign" Checked="true" />
                    </div>
                </asp:Panel>
            </telerik:RadWizardStep>
            <telerik:RadWizardStep Title="SMS Template" runat="server" StepType="Start">
                <asp:Panel ID="PanelSMS" runat="server" Width="100%">
                    <table style="width: 100%" class="table-sm Formulario">
                        <tr>
                            <td width="50px" class="Normal" valign="top">SMS Message:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtSMS" runat="server" Width="100%" Rows="6" EmptyMessage="SMS message" RenderMode="Classic" TextMode="MultiLine" MaxLength="255">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>
                    <div style="padding-top: 30px;">
                        <telerik:RadCheckBox ID="chkSMS" runat="server" Text="   SMS Campaign" Checked="true" />
                    </div>
                </asp:Panel>
            </telerik:RadWizardStep>
            <telerik:RadWizardStep Title="Target Clients" runat="server" StepType="Start">
                <div>
                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1"
                        Width="99%" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" AllowMultiRowSelection="True" ShowFooter="true"
                        CellSpacing="0" PageSize="250" Height="450px">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            <Selecting AllowRowSelect="true" />
                        </ClientSettings>
                        <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="Id">
                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                            <Columns>
                                <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="Name" HeaderText="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center"
                                    Aggregate="Count" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Company" HeaderText="Company" UniqueName="Company" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="HaveCellular" FilterControlAltText="Filter HaveCellular column" HeaderStyle-Width="80px"
                                    HeaderText="Cellular" SortExpression="HaveCellular" UniqueName="HaveCellular"
                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="NameHaveCellular" runat="server" Text='<%# Eval("HaveCellular")%>' ToolTip='<%# Eval("Cellular")%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="HaveEmail" FilterControlAltText="Filter HaveEmail column" HeaderStyle-Width="80px"
                                    HeaderText="Email" SortExpression="HaveEmail" UniqueName="HaveEmail"
                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="NameHaveEmail" runat="server" Text='<%# Eval("HaveEmail")%>' ToolTip='<%# Eval("Email")%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="ClientId" HeaderText="ClientId" UniqueName="ClientId" Display="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Email" HeaderText="Email" UniqueName="Email" Display="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Cellular" HeaderText="Cellular" UniqueName="Cellular" Display="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="JobAmount" HeaderText="JobAmount" UniqueName="JobAmount" Display="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TotalBudget" HeaderText="TotalBudget" UniqueName="TotalBudget" Display="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Balance" HeaderText="Balance" UniqueName="Balance" Display="false">
                                </telerik:GridBoundColumn>

                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>

                </div>
            </telerik:RadWizardStep>
            <telerik:RadWizardStep Title="Confirmation" runat="server" StepType="Finish">
                <div style="text-align: center; padding-top: 50px">
                    <h4>
                        <asp:Label ID="lblEmailCampaign" runat="server" Text="Email Campaign Selected"></asp:Label></h4>
                    <h4>
                        <asp:Label ID="lblSMSCampaign" runat="server" Text="SMS Campaign Selected"></asp:Label></h4>
                    <h4>
                        <asp:Label ID="lblTargetClients" runat="server" Text="0 Clients Selected"></asp:Label></h4>
                    <br />
                    <h3>
                        <asp:Label ID="lblFin" runat="server" Text="Press Bottom to 'Run Campaign'"></asp:Label></h3>
                    <br />
                    <h3>
                        <asp:Label ID="lblEmailsResult" runat="server" Text=""></asp:Label></h3>
                    <br />
                    <h4>
                        <asp:Label ID="lblSMSResult" runat="server" Text=""></asp:Label></h4>
                </div>

                <div style="padding-top: 100px">
                    <telerik:RadCheckBox ID="chkAgree" runat="server" Text="I accept and agree to the terms and conditions of the marketing campaign" />
                    <asp:Label ID="lblValidateAgree" runat="server" Text="<br/>(*)You must accept the terms and conditions" CssClass="Error" Visible="false"></asp:Label>
                </div>

                <h6>
                    <asp:Label ID="lblAgree" runat="server" Text="The marketing campaign includes the following additional service charges: $0.01 per Email and $0.05 per SMS"></asp:Label>
                </h6>

            </telerik:RadWizardStep>
        </WizardSteps>

    </telerik:RadWizard>



    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Clients_MarketingCampaign_details_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE Clients_MarketingCampaign SET Name = @Name, Subject = @Subject, EmailBody = @EmailBody, SMSText = @SMSText WHERE (Id = @Id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblMarketingId" Name="MarketingCampaignId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="txtCampaignName" Name="Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtSubject" Name="Subject" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtBody" Name="EmailBody" PropertyName="Content" Type="String" />
            <asp:ControlParameter ControlID="txtSMS" Name="SMSText" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblMarketingId" Name="Id" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblMarketingId" runat="server" Visible="False"></asp:Label>

</asp:Content>

