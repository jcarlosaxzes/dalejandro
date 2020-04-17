<%@ Page Title="Subconsultant" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="subconsultant.aspx.vb" Inherits="pasconcept20.subconsultant" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="EditionZone" style="padding-left: 10px; padding-top: 10px">

        <telerik:RadTabStrip runat="server" ID="RadTabStrip1" MultiPageID="RadMultiPage1" SelectedIndex="0" CausesValidation="True"
            RenderMode="Lightweight">
            <Tabs>
                <telerik:RadTab Text="Subconsultant Details"></telerik:RadTab>
                <telerik:RadTab Text="History"></telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>

        <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0" Width="100%" CausesValidation="True">
            <telerik:RadPageView runat="server" ID="RadPageView1">

                <div style="padding-left: 10px">
                    <asp:Label ID="lblStatus" runat="server" Style="font-size: 10pt; color: forestgreen; font-family: Calibri, Verdana"></asp:Label>
                </div>

                <div>
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%" DefaultMode="Edit">
                        <EditItemTemplate>
                            <div style="padding-left: 170px; padding-top: 10px;">
                                <asp:LinkButton ID="btnUpdateSubconsultant1" runat="server" CommandName="Update" CausesValidation="True" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                        <span class="glyphicon glyphicon-save"></span> Update
                                </asp:LinkButton>

                            </div>
                            <fieldset style="width: 95%">
                                <legend class="TituloDeFieldset">&nbsp;Subconsultant Information&nbsp;</legend>
                                <table class="table-condensed" style="width: 100%">
                                    <tr>
                                        <td style="width: 150px" class="Normal">Code:
                                        <asp:Label ID="IdLabel1" runat="server" Text='<%# Eval("Id") %>' Visible="false" />
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtCode" runat="server" Text='<%# Bind("Code")%>' EmptyMessage="Up to 5 characters"
                                                MaxLength="5">
                                            </telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCode"
                                                ErrorMessage=" (*) Subconsultant code is required"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px" class="Normal">Name:
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtSubconsultantName" runat="server" Text='<%# Bind("Name") %>' MaxLength="80"
                                                Width="500px" EmptyMessage="Required">
                                            </telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSubconsultantName"
                                                ErrorMessage="(*) Name is Required" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px" class="Normal">Email:
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' MaxLength="128" Width="500px" EmptyMessage="Required">
                                            </telerik:RadTextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtEmail"
                                                runat="server" ErrorMessage="(*) Enter an valid email address" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                Display="Dynamic"></asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail"
                                                ErrorMessage="(*) Email is Required" Display="Dynamic"></asp:RequiredFieldValidator>
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
                                        <td style="width: 150px" class="Normal">Organization:
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="RadTextBox4" runat="server" Text='<%# Bind("Organization")%>'
                                                MaxLength="80" Width="500px">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px" class="Normal">Discipline:
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cboDiscipline" runat="server" ReadOnly="True" DataSourceID="SqlDataSourceDiscipline"
                                                DataTextField="Name" DataValueField="Id" Width="250px" SelectedValue='<%# Bind("disciplineId") %>' AppendDataBoundItems="true">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="(Select discipline...)" Value="0" />
                                                </Items>
                                            </telerik:RadComboBox>
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
                                        <td style="width: 150px" class="Normal">Telephone:
                                        </td>
                                        <td>
                                            <telerik:RadMaskedTextBox ID="RadMaskedTextBox1" runat="server" Text='<%# Bind("Telephone")%>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px" class="Normal">Cell Phone:
                                        </td>
                                        <td>
                                            <telerik:RadMaskedTextBox ID="RadMaskedTextBox2" runat="server" Text='<%# Bind("CellPhone")%>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px" class="Normal">Facsimile:
                                        </td>
                                        <td>
                                            <telerik:RadMaskedTextBox ID="RadMaskedTextBox3" runat="server" Text='<%# Bind("Fascimile")%>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px" class="Normal">Web Page:
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="RadTextBox1" runat="server" Text='<%# Bind("WebPage")%>' MaxLength="50"
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
                            <fieldset style="width: 95%">
                                <legend class="TituloDeFieldset">&nbsp;Billing Contact&nbsp;</legend>
                                <table class="table-condensed" style="width: 100%">
                                    <tr>
                                        <td style="width: 150px" class="Normal">Name:
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="RadTextBox12" runat="server" Text='<%# Bind("Billing_contact") %>'
                                                MaxLength="80" Width="500px">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px" class="Normal">Telephone:
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="RadTextBox13" runat="server" Text='<%# Bind("Billing_Telephone") %>'
                                                MaxLength="25">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <fieldset style="width: 95%">
                                <legend class="TituloDeFieldset">&nbsp;Notification&nbsp;</legend>
                                <table class="table-condensed" style="width: 100%">
                                    <tr>
                                        <td style="width: 150px" class="Normal">R.F.Proposal Accepted:
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="Notification_acceptedproposalCheckBox1" runat="server" Checked='<%# Bind("Notification_acceptedrfp")%>' Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px" class="Normal">R.F.Proposal Declined:
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="Notification_declinedproposalCheckBox1" runat="server" Checked='<%# Bind("Notification_declinedrfp")%>' Enabled="false" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <div style="padding-left: 170px; padding-top: 10px; padding-bottom: 15px">
                                <asp:LinkButton ID="btnUpdateSubconsultant2" runat="server" CommandName="Update" CausesValidation="True" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                        <span class="glyphicon glyphicon-save"></span> Update
                                </asp:LinkButton>

                            </div>
                        </EditItemTemplate>

                    </asp:FormView>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView runat="server" ID="RadPageView2">
                 <div>
                    <asp:FormView ID="FormViewBalance" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceSubconsultantBalance" Width="100%">
                        <ItemTemplate>

                            <table class="table-condensed" style="width: 100%">
                                <tr>
                                    <td style="width: 50%; text-align: center; vertical-align: top">
                                        <h3 style="margin: 0"><span class="label label-info center-block">Projects</span></h2>
                                        <table class="table-condensed" style="width: 100%">
                                            <tr>
                                                <td style="text-align: right"># Pending RFPs:</td>
                                                <td style="width: 120px; text-align: right">
                                                    <b><%# Eval("NumberPendingRFP", "{0:N0}") %></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">$ Acepted RFPs:</td>
                                                <td style="text-align: right">
                                                    <b><%# Eval("AmountAcceptedTotal", "{0:C2}") %></b>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="text-align: right; vertical-align: top">
                                        <h3 style="margin: 0"><span class="label label-info center-block">Balance</span></h2>
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
                                                    <b><%# Eval("Balance", "{0:C2}") %></b>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>


                        </ItemTemplate>
                    </asp:FormView>
                </div>
                <div>
                    <h4>Request for Proposals History</h4>
                    <telerik:RadGrid ID="RadGridRFPs" runat="server" DataSourceID="SqlDataSourceRFP" AutoGenerateColumns="False" AllowSorting="True"
                        PageSize="10" AllowPaging="true"
                        ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                        </ClientSettings>
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceRFP" ShowFooter="True" ClientDataKeyNames="Id">
                            <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                            <Columns>
                            <telerik:GridBoundColumn DataField="Id" HeaderText="Number"
                                SortExpression="Id" UniqueName="Id" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DateCreated" DataFormatString="{0:d}"
                                DataType="System.DateTime" HeaderText="Date" SortExpression="DateCreated"
                                UniqueName="DateCreated" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                                HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ProjectName" HeaderText="Project" SortExpression="ProjectName"
                                UniqueName="ProjectName" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Client" HeaderText="Client" SortExpression="ProjectName"
                                UniqueName="Client" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Discipline" FilterControlAltText="Filter Discipline column"
                                HeaderText="Discipline" SortExpression="Discipline" UniqueName="Discipline"
                                ItemStyle-HorizontalAlign="Center" 
                                HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Total" DataFormatString="{0:C2}"
                                Groupable="False" HeaderText="Total" SortExpression="Total" UniqueName="Total"
                                HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AmountPaid" DataFormatString="{0:C2}"
                                Groupable="False" HeaderText="Fee" SortExpression="AmountPaid" UniqueName="AmountPaid"
                                HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Balance" DataFormatString="{0:C2}"
                                Groupable="False" HeaderText="Balance" SortExpression="Balance" UniqueName="Balance"
                                HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Code" HeaderText="Job" SortExpression="Code"
                                UniqueName="Code"  ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="Status" HeaderText="Status" UniqueName="Status"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px"
                                HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <span title="Clic to edit Job Status" class='<%# LocalAPI.GetRFPStatusLabelCSS(Eval("Status")) %>'><%# Eval("Status") %></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </telerik:RadPageView>
        </telerik:RadMultiPage>

    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="SUBCONSULTAN_UPDATE" UpdateCommandType="StoredProcedure"
        SelectCommand="SUBCONSULTANT_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblSubconsultantId" Name="SubconsultantId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="disciplineId" Type="Int32" />
            <asp:Parameter Name="Organization" Type="String" />
            <asp:Parameter Name="Position" Type="String" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="Address2" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="State" Type="String" />
            <asp:Parameter Name="ZipCode" Type="String" />
            <asp:Parameter Name="Telephone" Type="String" />
            <asp:Parameter Name="CellPhone" Type="String" />
            <asp:Parameter Name="Fascimile" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="WebPage" Type="String" />
            <asp:Parameter Name="Code" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="Billing_contact" Type="String" />
            <asp:Parameter Name="Billing_Telephone" Type="String" />
            <asp:Parameter Name="Notification_acceptedrfp" Type="Boolean" />
            <asp:Parameter Name="Notification_declinedrfp" Type="Boolean" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, companyId, Name FROM SubConsultans_disciplines WHERE (companyId = @companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

     <asp:SqlDataSource ID="SqlDataSourceSubconsultantBalance" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Subconsultant_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblSubconsultantId" Name="subconsultantId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRFP" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="RFP_by_Subconsultant_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSubconsultantId" Name="subconsultantId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSubconsultantId" runat="server" Visible="False"></asp:Label>

</asp:Content>

