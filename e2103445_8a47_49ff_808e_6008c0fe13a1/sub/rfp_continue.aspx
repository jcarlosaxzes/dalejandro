<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rfp_continue.aspx.vb" Inherits="pasconcept20.rfp_continue" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Request For Proposal Edit</title>
    <%--Bootstrap reference begin--%>
    <link href="~/Content/bootstrap.css" rel="stylesheet" />
    <%--Bootstrap reference end--%>

    <style type="text/css">
        .pas-container .RadWizard {
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            *border: 1px solid #ddd;
        }

        .pas-container .RadWizard_BlackMetroTouch {
            border: 1px solid #333;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" EnableCdn="true" runat="server">
        </telerik:RadScriptManager>

        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                var popUp;
                function PopUpShowing(sender, eventArgs) {
                    popUp = eventArgs.get_popUp();
                    var gridWidth = sender.get_element().offsetWidth;
                    var gridHeight = sender.get_element().offsetHeight;
                    var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("px"));
                    var popUpHeight = popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
                    popUp.style.left = ((gridWidth - popUpWidth) / 2 + sender.get_element().offsetLeft).toString() + "px";
                    popUp.style.top = 150 + "px";
                }
                function OnClientClose(sender, args) {
                    var masterTable = $find("<%= RadGridRFPDet.ClientID %>").get_masterTableView();
                    masterTable.rebind();
                }
            </script>
        </telerik:RadCodeBlock>

        <div class="container pas-container">
            <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="true" RenderMode="Lightweight" Skin="Material" Height="800px">
                <WizardSteps>

                    <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Task & Fee(s)" StepType="Start">
                        <h3 style="margin: 0">Task & Fees</h3>
                        <table style="width: 100%" class="table-sm">
                            <tr>
                                <td>
                                    <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                        <i class="fas fa-plus"></i>&nbsp;Service Fee
                                    </asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="RadGridRFPDet" runat="server" RenderMode="Lightweight"
                                        AllowAutomaticInserts="True" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" DataSourceID="SqlDataSourceRFPdetalles"
                                        ShowFooter="True" AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small"
                                        ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small">
                                        <MasterTableView DataSourceID="SqlDataSourceRFPdetalles" DataKeyNames="Id" EditMode="PopUp">
                                            <Columns>
                                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderText="" HeaderStyle-Width="50px">
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridTemplateColumn DataField="TaskCode"
                                                    HeaderText="Task ID" SortExpression="TaskCode" UniqueName="TaskCode" HeaderStyle-Width="150px">
                                                    <ItemTemplate>
                                                        <%# Eval("TaskCode") %>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="Description"
                                                    HeaderText="Task Name" SortExpression="Description" UniqueName="Description">
                                                    <ItemTemplate>
                                                        <b><%# Eval("Description") %></b>
                                                        <br />
                                                        <small>
                                                            <%# Eval("DescriptionPlus")%>
                                                        </small>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <%--<telerik:GridTemplateColumn DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity"
                                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="80px" Display="false">
                                                    <ItemTemplate>
                                                        <%# Eval("Quantity", "{0:N2}") %>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>--%>
                                                <telerik:GridTemplateColumn DataField="UnitPrice"
                                                    HeaderText="Task Fee" SortExpression="UnitPrice" UniqueName="UnitPrice" ItemStyle-HorizontalAlign="Right"
                                                    HeaderStyle-Width="120px" Display="false" >
                                                    <ItemTemplate>
                                                        <%# Eval("UnitPrice", "{0:N2}") %>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="LineTotal" DataType="System.Double" FilterControlAltText="Filter LineTotal column"
                                                    FooterStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                    HeaderStyle-Width="150px" HeaderText="Total" ReadOnly="True" SortExpression="LineTotal" UniqueName="LineTotal" Aggregate="Sum"
                                                    DataFormatString="{0:N2}" FooterAggregateFormatString="{0:N2}">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this task?"
                                                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                                    UniqueName="DeleteColumn" HeaderText="" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                                </telerik:GridButtonColumn>
                                            </Columns>

                                            <EditFormSettings EditFormType="Template">
                                                <PopUpSettings ScrollBars="Auto" Modal="true" Width="960px" />
                                                <FormTemplate>
                                                    <table style="width: 100%" class="table-sm">

                                                        <tr>
                                                            <td style="text-align: right; width: 180px">Task ID:
                                                            </td>
                                                            <td>
                                                                <telerik:RadTextBox ID="txtTaskCode" runat="server" Text='<%# Bind("TaskCode") %>' EmptyMessage="Optional"
                                                                    MaxLength="16" Width="200px">
                                                                </telerik:RadTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right">Task Name:
                                                            </td>
                                                            <td>
                                                                <telerik:RadTextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>'
                                                                    MaxLength="80" Width="100%">
                                                                </telerik:RadTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right">Task Fee:
                                                            </td>
                                                            <td>
                                                                <telerik:RadNumericTextBox ID="UnitPriceTextBox" runat="server" DbValue='<%# Bind("UnitPrice", "{0:N2}") %>'
                                                                    Width="200px">
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right; vertical-align: top">Description (optional):
                                                            </td>
                                                            <td>
                                                                <telerik:RadTextBox ID="DescriptionPlusTextBox1" runat="server" Text='<%# Bind("DescriptionPlus") %>' EmptyMessage="Optional"
                                                                    Width="100%" TextMode="MultiLine" Rows="5">
                                                                </telerik:RadTextBox>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td colspan="2" style="text-align: center">
                                                                <asp:LinkButton runat="server" ID="btnUpdate"
                                                                    CssClass="btn btn-primary"
                                                                    Text='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Insert Task", "Update Task") %>'
                                                                    CommandName='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "PerformInsert", "Update")%>'>
                                                                </asp:LinkButton>
                                                                &nbsp;
                                                                &nbsp;
                                                                &nbsp;
                                                                <asp:LinkButton ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                                                                    CssClass="btn btn-default"
                                                                    CommandName="Cancel">
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <div style="padding-left: 180px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                            ControlToValidate="DescriptionTextBox"
                                                            ForeColor="Red"
                                                            ErrorMessage="Task Name is required!"></asp:RequiredFieldValidator>
                                                    </div>


                                                </FormTemplate>
                                            </EditFormSettings>
                                        </MasterTableView>
                                        <ClientSettings>
                                            <ClientEvents OnPopUpShowing="PopUpShowing" />
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadWizardStep>
                    <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="My Term & Conditions" StepType="Step">
                        <h3 style="margin: 0">My Term & Conditions</h3>
                        <table style="width: 100%" class="table-sm">
                            <tr>
                                <td>
                                    <telerik:RadEditor ID="txtSubconsultaTandC" runat="server" RenderMode="Auto"
                                        Height="450px" ToolsFile="~/BasicTools.xml" AllowScripts="True" EditModes="Design"
                                        Width="100%">
                                    </telerik:RadEditor>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadWizardStep>
                    <telerik:RadWizardStep runat="server" ID="RadWizardStep3" Title="Review & Submit" StepType="Finish">
                        <h3 style="margin: 0">Review  & Submit</h3>

                        <asp:FormView ID="FormViewReview" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceRFPReview">
                            <ItemTemplate>

                                <table style="width: 400px" class="table-sm">
                                    <tr>
                                        <td style="text-align: right">Prime (sender) Name:
                                        </td>
                                        <td>
                                            <h5><%# Eval("Sender") %></h5>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 180px">RFP Number:
                                        </td>
                                        <td>
                                            <h5><%# Eval("RFPNumber") %></h5>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">Project Name:
                                        </td>
                                        <td>
                                            <h5><%# Eval("ProjectName") %></h5>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">Total Fees:
                                        </td>
                                        <td>
                                            <h5><%# Eval("Total", "{0:C2}") %></h5>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:FormView>

                        <table style="width: 100%" class="table-sm">
                            <tr>
                                <td><b>Additional Notes (optional):</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadTextBox ID="txtSubconsultantNotes" runat="server" Width="100%" MaxLength="512" TextMode="MultiLine" Rows="6">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%" class="table-sm">
                            <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center; width: 50%">
                                    <telerik:RadRadioButton runat="server" ID="opcUpdate" Text="Save Changes" Font-Size="X-Large" />
                                </td>
                                <td style="text-align: center">
                                    <telerik:RadRadioButton runat="server" ID="opcUpdateAndSubmit" Text="Save Changes And Submit" Font-Size="X-Large" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadLabel runat="server" ID="lblValidate" ForeColor="Red"></telerik:RadLabel>
                                </td>
                            </tr>

                        </table>

                    </telerik:RadWizardStep>
                    <telerik:RadWizardStep runat="server" ID="RadWizardStepComplete" Title="Complete" StepType="Complete">
                        <h3>Complete</h3>
                        <br />
                        <br />

                        <table style="width: 100%" class="table-sm">
                            <tr>
                                <td>
                                    <div class="alert alert-success" role="alert">
                                        <h4 class="alert-heading">Well done!</h4>
                                        <telerik:RadLabel runat="server" ID="lblComplete"></telerik:RadLabel>
                                    </div>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadTextBox ID="txtRFPurl" runat="server" Width="100%">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center">
                                    <br />
                                    <br />
                                    <br />
                                    <br />
                                    <br />
                                    <asp:LinkButton ID="btnViewProposal" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false">
                                                    <span class="glyphicon glyphicon-backward"></span>&nbsp; View Proposal
                                    </asp:LinkButton>
                                </td>

                            </tr>
                        </table>
                    </telerik:RadWizardStep>
                </WizardSteps>
            </telerik:RadWizard>
        </div>

        <asp:SqlDataSource ID="SqlDataSourceRFPdetalles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="RFP_Details_SELECT" SelectCommandType="StoredProcedure"
            DeleteCommand="RFP_Details_DELETE" DeleteCommandType="StoredProcedure"
            InsertCommand="RFP_Details_INSERT" InsertCommandType="StoredProcedure"
            UpdateCommand="RFP_Details_UPDATE" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="lblRFPId" Name="rfpId" PropertyName="Text" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Name="TaskCode" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="DescriptionPlus" Type="String" />
                <asp:Parameter Name="Quantity" Type="Double" />
                <asp:Parameter Name="UnitPrice" Type="Double" />
                <asp:ControlParameter ControlID="lblRFPId" Name="rfpId" PropertyName="Text" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="TaskCode" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="DescriptionPlus" Type="String" />
                <asp:Parameter Name="Quantity" Type="Double" />
                <asp:Parameter Name="UnitPrice" Type="Double" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlDataSourceRFPReview" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="RFP_Review_SELECT" SelectCommandType="StoredProcedure"
            UpdateCommand="RFP_subconsultant_continue_UPDATE" UpdateCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblRFPId" Name="Id" PropertyName="Text" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Agreements" Type="String" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="Submitted" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblRFPId" runat="server" Visible="False"></asp:Label>
    </form>
</body>
</html>
