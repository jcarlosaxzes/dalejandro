<%@ Page Title="Department" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="department_form.aspx.vb" Inherits="pasconcept20.department_form" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="Formulario">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="width: 80px">
                    <asp:Panel ID="panelTotals" runat="server" UseSubmitBehavior="false">
                        <button class="btn btn-danger" type="button" data-toggle="collapse" data-target="#collapseTotals" aria-expanded="false" aria-controls="collapseTotals">
                            $ Dashboard
                        </button>
                    </asp:Panel>
                </td>
                <td style="width: 120px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                       Back to List
                    </asp:LinkButton>
                </td>
                <td></td>
            </tr>
        </table>
        <div class="collapse" id="collapseTotals">
            <div class="card card-body">
                <asp:FormView ID="FormViewDepartmentBalance" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceDepartmentBalance" Width="100%">
                    <ItemTemplate>
                        <table class="table-condensed" style="width: 100%">
                            <tr>
                                <td colspan="9">
                                    <hr style="margin: 0" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="9" style="text-align: center">
                                    <h2 style="margin: 0"><%# Eval("DepartmentName")%></h2>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; text-align: center; background-color: #039be5">
                                    <span class="DashboardFont2"># Pending Props.</span><br />
                                    <asp:Label ID="lblTotalBudget" CssClass="DashboardFont1" runat="server" Text='<%# Eval("NumberPendingProposal", "{0:N0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 15%; text-align: center; background-color: #546e7a">
                                    <span class="DashboardFont2">Acepted Proposal</span><br />
                                    <asp:Label ID="lblTotalBilled" runat="server" CssClass="DashboardFont1" Text='<%# Eval("ProposalAmount", "{0:C0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 15%; text-align: center; background-color: #43a047">
                                    <span class="DashboardFont2">Jobs Budget</span><br />
                                    <asp:Label ID="lblTotalCollected" runat="server" CssClass="DashboardFont1" Text='<%# Eval("ContractAmount", "{0:C0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 15%; text-align: center; background-color: #43a047">
                                    <span class="DashboardFont2">Subcont. Amount</span><br />
                                    <asp:Label ID="Label1" runat="server" CssClass="DashboardFont1" Text='<%# Eval("Subcontrated", "{0:C0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 15%; text-align: center; background-color: #43a047">
                                    <span class="DashboardFont2">Amount Paid</span><br />
                                    <asp:Label ID="lblTotalPending" runat="server" CssClass="DashboardFont1" Text='<%# Eval("AmountPaid", "{0:C0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 15%; text-align: center; background-color: #e53935">
                                    <span class="DashboardFont2">Balance</span><br />
                                    <asp:Label ID="LabelblTotalBalance" runat="server" CssClass="DashboardFont1" Text='<%# Eval("Balance", "{0:C0}") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>

            </div>
        </div>
    </div>
    <div class="pas-container">
        <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="false" RenderMode="Lightweight" Skin="Material" DisplayNavigationButtons="false" DisplayProgressBar="false">
            <WizardSteps>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Department Details" StepType="Step">
                    <div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NameTextBox" ErrorMessage=" Name is mandatory"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator554" runat="server" ControlToValidate="CodeTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                    </div>
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td style="width: 180px; text-align: right">Name:</td>
                            <td>
                                <telerik:RadTextBox ID="NameTextBox" runat="server" MaxLength="80" Width="100%"></telerik:RadTextBox>
                                
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Code:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="CodeTextBox" runat="server" MaxLength="32" Width="50%"></telerik:RadTextBox>

                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Description:</td>
                            <td>
                                <telerik:RadTextBox ID="DescriptionTextBox" runat="server" MaxLength="512" Width="100%" TextMode="MultiLine" Rows="2">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Employee Head:
                            </td>
                            <td>
                                <telerik:RadComboBox runat="server" ID="cboHead" DataValueField="Id" Width="100%" Height="250px"
                                    DataTextField="Name" DataSourceID="SqlDataSourceEmployees" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="(Select Employee Head...)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>

                        <tr>
                            <td style="text-align: right">Parent Department:</td>
                            <td>
                                <telerik:RadComboBox runat="server" ID="cboParent" DataValueField="Id" Width="100%" Height="250px"
                                    DataTextField="Name" DataSourceID="SqlDataSourceDepartments" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="(Select Parent Department...)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>

                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Is Productive:
                            </td>
                            <td>
                                <telerik:RadCheckBox runat="server" ID="chkProductive"></telerik:RadCheckBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Proposal Tracking Email:</td>
                            <td>
                                <telerik:RadTextBox ID="ProposalStatusTrackingEmailTextBox" runat="server" MaxLength="128" Width="100%">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Billing Contact Name:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="BillingContactNameTextBox" runat="server" MaxLength="80" Width="100%">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Billing Contact Email:
                            </td>
                            <td>
                                <telerik:RadTextBox ID="BillingContactEmailTextBox" runat="server" MaxLength="80" Width="100%">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center">
                                <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false" CausesValidation="true">
                                                <span class="glyphicon glyphicon-save"></span>&nbsp;Update
                                </asp:LinkButton>

                            </td>
                        </tr>
                    </table>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Department Tags" StepType="Step">
                    Department Tags
                    <%--<telerik:GridBoundColumn DataField="TagCategoryLabel0" HeaderText="TagCategoryLabel0" UniqueName="TagCategoryLabel0" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TagCategoryLabel1" HeaderText="TagCategoryLabel1" UniqueName="TagCategoryLabel1" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TagCategoryLabel2" HeaderText="TagCategoryLabel2" UniqueName="TagCategoryLabel2" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TagCategoryLabel3" HeaderText="TagCategoryLabel3" UniqueName="TagCategoryLabel3" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TagCategoryLabel4" HeaderText="TagCategoryLabel4" UniqueName="TagCategoryLabel4" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TagCategoryLabel5" HeaderText="TagCategoryLabel5" UniqueName="TagCategoryLabel5" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TagCategoryLabel6" HeaderText="TagCategoryLabel6" UniqueName="TagCategoryLabel6" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TagCategoryLabel7" HeaderText="TagCategoryLabel7" UniqueName="TagCategoryLabel7" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TagCategoryLabel8" HeaderText="TagCategoryLabel8" UniqueName="TagCategoryLabel8" Display="false">
                    </telerik:GridBoundColumn>--%>
                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>
    </div>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="Company_Department_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="Company_Department_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblDepartmentId" Name="Id" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="NameTextBox" Name="Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="CodeTextBox" Name="Code" PropertyName="Text" />
            <asp:ControlParameter ControlID="DescriptionTextBox" Name="Description" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboHead" Name="Head" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboParent" Name="ParentID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="chkProductive" Name="Productive" PropertyName="Checked" />
            <asp:ControlParameter ControlID="ProposalStatusTrackingEmailTextBox" Name="ProposalStatusTrackingEmail" PropertyName="Text" />
            <asp:ControlParameter ControlID="BillingContactNameTextBox" Name="BillingContactName" PropertyName="Text" />
            <asp:ControlParameter ControlID="BillingContactEmailTextBox" Name="BillingContactEmail" PropertyName="Text" />

            <asp:ControlParameter ControlID="lblDepartmentId" Name="Id" PropertyName="Text" />
<%--            <asp:Parameter Name="TagCategoryLabel0" />
            <asp:Parameter Name="TagCategoryLabel1" />
            <asp:Parameter Name="TagCategoryLabel2" />
            <asp:Parameter Name="TagCategoryLabel3" />
            <asp:Parameter Name="TagCategoryLabel4" />
            <asp:Parameter Name="TagCategoryLabel5" />
            <asp:Parameter Name="TagCategoryLabel6" />
            <asp:Parameter Name="TagCategoryLabel7" />
            <asp:Parameter Name="TagCategoryLabel8" />--%>
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="NameTextBox" Name="Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="CodeTextBox" Name="Code" PropertyName="Text" />
            <asp:ControlParameter ControlID="DescriptionTextBox" Name="Description" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboHead" Name="Head" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboParent" Name="ParentID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="chkProductive" Name="Productive" PropertyName="Checked" />
            <asp:ControlParameter ControlID="ProposalStatusTrackingEmailTextBox" Name="ProposalStatusTrackingEmail" PropertyName="Text" />
            <asp:ControlParameter ControlID="BillingContactNameTextBox" Name="BillingContactName" PropertyName="Text" />
            <asp:ControlParameter ControlID="BillingContactEmailTextBox" Name="BillingContactEmail" PropertyName="Text" />

<%--            <asp:Parameter Name="TagCategoryLabel0" />
            <asp:Parameter Name="TagCategoryLabel1" />
            <asp:Parameter Name="TagCategoryLabel2" />
            <asp:Parameter Name="TagCategoryLabel3" />
            <asp:Parameter Name="TagCategoryLabel4" />
            <asp:Parameter Name="TagCategoryLabel5" />
            <asp:Parameter Name="TagCategoryLabel6" />
            <asp:Parameter Name="TagCategoryLabel7" />
            <asp:Parameter Name="TagCategoryLabel8" />--%>
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDepartmentBalance" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Department_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblDepartmentId" Name="DepartmentId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, FullName as Name from Employees where companyId=@companyId Order By FullName">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Company_Department where companyId=@companyId Order By Name">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblDepartmentId" runat="server" Visible="False" Text="0"></asp:Label>

</asp:Content>
