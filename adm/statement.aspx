﻿<%@ Page Title="Statements" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="statement.aspx.vb" Inherits="pasconcept20.statement" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript">
            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }
        </script>
    </telerik:RadCodeBlock>

    <table class="table-sm" style="width: 100%">
        <tr>
            <td class="PanelFilter">
                <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                    <table width="100%" class="Formulario">
                        <tr>
                            <td width="80px" align="right" class="Normal">Period:
                            </td>
                            <td width="150px" align="left" class="Normal">
                                <telerik:RadComboBox ID="cboPeriod" runat="server" Width="100%" MarkFirstMatch="True">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="(Last 90 days)" Value="90" />
                                        <telerik:RadComboBoxItem Text="(Last 180 days)" Value="180" />
                                        <telerik:RadComboBoxItem Text="(Last 365 days)" Value="365" Selected="true" />
                                        <telerik:RadComboBoxItem Text="(This year)" Value="14" />
                                        <telerik:RadComboBoxItem Text="(All years...)" Value="13" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td width="400px">
                                <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClients"
                                    Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains"
                                    Height="300px" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="100%" EmptyMessage="Find...">
                                </telerik:RadTextBox>
                            </td>
                            <td style="text-align: right; width: 100px">
                                <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                            <i class="fas fa-search"></i> Search
                                </asp:LinkButton>

                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>

    <div class="Formulario">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 90px">
                    <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                <i class="fas fa-plus"></i> Statement
                    </asp:LinkButton>
                </td>
                <td style="width: 140px">
                    <script type="text/javascript">
                        function PrintPage(sender, args) {
                            window.print();
                        }
                    </script>
                    <telerik:RadButton ID="printbutton" OnClientClicked="PrintPage" Text="Print Page" runat="server" AutoPostBack="false" UseSubmitBehavior="false">
                        <Icon PrimaryIconCssClass=" rbPrint"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="text-align: center">
                    <h3 style="margin: 0">Statements
                    </h3>
                </td>
            </tr>
        </table>

    </div>



    <div>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                var popUp;
                function PopUpShowing(sender, eventArgs) {
                    popUp = eventArgs.get_popUp();
                    var gridWidth = sender.get_element().offsetWidth;
                    var gridHeight = sender.get_element().offsetHeight;
                    var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("px"));
                    var popUpHeight = "800px"//popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
                    popUp.style.left = ((gridWidth - popUpWidth) / 2 + sender.get_element().offsetLeft).toString() + "px";
                    popUp.style.top = "0px";
                }
            </script>
        </telerik:RadCodeBlock>
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticUpdates="True" AutoGenerateColumns="False"
            DataSourceID="SqlDataSource1" AllowAutomaticInserts="True" AllowAutomaticDeletes="True" AllowSorting="True"
            PageSize="100" AllowPaging="true" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" CommandItemDisplay="None" ShowFooter="True" EditMode="PopUp">
                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                <Columns>
                    <telerik:GridTemplateColumn DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column"
                        HeaderText="Number" SortExpression="Id" UniqueName="Id"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# Eval("Id") %>'
                                CommandName="Edit" Text='<%# Eval("Number")%>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="InvoiceDate" DataType="System.DateTime" FilterControlAltText="Filter InvoiceDate column"
                        HeaderText="Date" SortExpression="InvoiceDate" UniqueName="InvoiceDate"
                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <%# Eval("InvoiceDate", "{0:MM/dd/yy}")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="clientId" FilterControlAltText="Filter clientId column"
                        HeaderText="Client Name [Company]" SortExpression="clientId" UniqueName="clientId">
                        <ItemTemplate>
                            <%# Eval("ClientName")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="AmountBilled" FilterControlAltText="Filter AmountBilled column"
                        HeaderText="Amount" SortExpression="AmountBilled" UniqueName="AmountBilled"
                        ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px"
                        DataFormatString="{0:N2}" FooterAggregateFormatString="{0:N2}"
                        Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AmountDue" FilterControlAltText="Filter AmountDue column"
                        HeaderText="Amount Due" SortExpression="AmountDue" UniqueName="AmountDue"
                        ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="110px"
                        DataFormatString="{0:N2}" FooterAggregateFormatString="{0:N2}"
                        Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Emitted" FilterControlAltText="Filter Emitted column"
                        HeaderText="Emitted" SortExpression="Emitted" UniqueName="Emitted"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                        <ItemTemplate>
                            <asp:Label ID="EmittedLabel" runat="server" Text='<%# Eval("Emitted", "{0:N0}")%>' ToolTip='<%# "First Emission: " + Eval("FirstEmission", "{0:MM/dd/yy}")%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="LatestEmission" DataType="System.DateTime" FilterControlAltText="Filter LatestEmission column"
                        HeaderText="Last" SortExpression="LatestEmission" UniqueName="LatestEmission"
                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="LatestEmissionLabel" runat="server" Text='<%# Eval("LatestEmission", "{0:MM/dd/yy}")%>' Font-Size="Small"
                                ToolTip='<%# "Last Emission: " + Eval("LatestEmission", "{0:MM/dd/yy}")%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="InvoiceNotes" FilterControlAltText="Filter InvoiceNotes column"
                        HeaderText="Notes" SortExpression="InvoiceNotes" ItemStyle-Font-Size="X-Small"
                        UniqueName="InvoiceNotes">
                        <ItemTemplate>
                            <%# Eval("InvoiceNotes") %>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="column" AllowFiltering="False"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 33%; text-align: center">
                                        <asp:LinkButton runat="server" ID="btnSatementPrint" CommandName="EmailPrint" CommandArgument='<%# Eval("Id") %>' ToolTip="Send Email with Statement information">
                                                    <i class="far fa-envelope"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td style="width: 33%; text-align: center">
                                        <a class="far fa-share-square" title="View Statement Page to share link"
                                            href='<%# Eval("Id", "../adm/sharelink.aspx?ObjType=55&ObjId={0}")%>' target="_blank" aria-hidden="true"></a>

                                    </td>
                                    <td style="text-align: center">
                                        <asp:LinkButton runat="server" ID="LinkbtnInvoicePaymentutton1" CommandName="RecivePayment" CommandArgument='<%# Eval("Id") %>'
                                            ToolTip="Recive Payments" Visible='<%# Eval("AmountDue") > 0 %>'
                                            CssClass="badge-success label">
                                                    <i class="fas fa-dollar-sign"></i>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this Statement?" ConfirmTitle="Delete"
                        ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                        HeaderText="" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings EditFormType="Template" CaptionFormatString="Editing statement ID: {0}" CaptionDataField="Id"
                    PopUpSettings-ZIndex="7001">
                    <PopUpSettings Modal="true" Width="960px" />
                    <FormTemplate>

                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="text-align: right; width: 180px">Statement Number:
                                </td>
                                <td>
                                    <%# Eval("Id") %>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Client Name [Company]:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboClient" runat="server" DataSourceID="SqlDataSourceClients"
                                        DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("clientId") %>'
                                        Width="98%" MarkFirstMatch="True" Filter="Contains"
                                        Enabled='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "True", "False")%>'
                                        OnClientKeyPressing="(function(sender, e){ if (!sender.get_dropDownVisible()) sender.showDropDown(); })"
                                        Style="z-index: 7003">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Date Created:
                                </td>
                                <td>
                                    <telerik:RadDateInput ID="RadDatePicker1" runat="server" DbSelectedDate='<%# Bind("InvoiceDate", "{0:MM/dd/yy}")%>'>
                                    </telerik:RadDateInput>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="RadDatePicker1" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Notes:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="RadTextBox1" runat="server" EmptyMessage="Statement notes"
                                        Text='<%# Bind("InvoiceNotes") %>' Width="98%">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>


                        <fieldset style="width: 920px; padding-left: 10px;" id="PanelInvoices" runat="server" visible='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "False", "True") %>'>
                            <table class="table-condensed" width="100%">
                                <tr>
                                    <td>
                                        <h4>Invoices Selected</h4>
                                        <telerik:RadGrid ID="RadGridInvoicesSelected" runat="server" DataSourceID="SqlDataSourceInvoicesSelected" Skin="Bootstrap" FooterStyle-Font-Size="X-Small"
                                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="X-Small" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small"
                                            ShowFooter="true" AllowAutomaticDeletes="true" AllowPaging="true" PageSize="100" AllowSorting="true" ClientIDMode="AutoID">
                                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceInvoicesSelected">
                                                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="InvoiceNumber" FilterControlAltText="Filter InvoiceNumber column"
                                                        HeaderText="Number" SortExpression="InvoiceNumber" UniqueName="InvoiceNumber"
                                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px"
                                                        FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="JobName" FilterControlAltText="Filter JobName column" ReadOnly="false"
                                                        HeaderText="Job Name" SortExpression="JobName" UniqueName="JobName"
                                                        HeaderStyle-Width="200px">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="InvoiceDate" DataType="System.DateTime" FilterControlAltText="Filter InvoiceDate column"
                                                        HeaderText="Date" SortExpression="InvoiceDate" UniqueName="InvoiceDate"
                                                        DataFormatString="{0:MM/dd/yy}" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="80px">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Amount" FilterControlAltText="Filter Amount column"
                                                        HeaderText="Amount" SortExpression="Amount" UniqueName="Amount"
                                                        ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="80px"
                                                        FooterAggregateFormatString="{0:N2}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" DataFormatString="{0:N2}">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn DataField="AmountDue" FilterControlAltText="Filter AmountDue column"
                                                        HeaderText="Amount Due" SortExpression="AmountDue" UniqueName="AmountDue"
                                                        ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="80px"
                                                        FooterAggregateFormatString="{0:N2}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotal2" runat="server" Text='<%# Eval("AmountDue", "{0:N2}")%>'
                                                                ForeColor='<%# IIf(Eval("AmountDue") = 0, System.Drawing.Color.Red, System.Drawing.Color.Black)%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridCheckBoxColumn DataField="BadDebt" DataType="System.Boolean" FilterControlAltText="Filter BadDebt column" HeaderText="BadDebt"
                                                        SortExpression="BadDebt" UniqueName="BadDebt" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                                    </telerik:GridCheckBoxColumn>
                                                    <telerik:GridBoundColumn DataField="InvoiceNotes" FilterControlAltText="Filter InvoiceNotes column"
                                                        HeaderText="Notes" SortExpression="InvoiceNotes" UniqueName="InvoiceNotes">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Remove this Invoice from Statement?" ConfirmTitle="Remove"
                                                        CommandName="Delete" Text="Remove" UniqueName="DeleteColumn"
                                                        HeaderText="" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                                                    </telerik:GridButtonColumn>
                                                </Columns>
                                            </MasterTableView>
                                            <ClientSettings>
                                                <Virtualization EnableVirtualization="false" InitiallyCachedItemsCount="500" LoadingPanelID="RadAjaxLoadingPanel1"
                                                    ItemsPerView="100" EnableCurrentPageScrollOnly="true" />
                                                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="190px" />
                                            </ClientSettings>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                        To add invoices to this Statement; scroll down to the list of invoices pending collection to make your selection.
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">The invoices below, are not included in another statement and have not been collected from the Client. Click on the check-boxes to select invoices for this statement.
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table style="width: 100%">
                                            <tr>
                                                <td>
                                                    <asp:RadioButton ID="opcByClients" runat="server" GroupName="1" Checked="true" AutoPostBack="true" Text="Select by Statement Client Name" />
                                                </td>
                                                <td>
                                                    <asp:RadioButton ID="opcByCompany" runat="server" GroupName="1" AutoPostBack="true" Text="Select by Statement Client Company" />
                                                </td>
                                                <td>
                                                    <%--<telerik:RadButton ID="btnNewSelectedInvoices1" runat="server" Text="Add Selected Invoices"
                                                                CommandName="AddInvoices" CommandArgument='<%# Eval("Id") %>' OnClick="btnNewSelectedInvoices_Click">
                                                                <Icon PrimaryIconCssClass="rbAdd"></Icon>
                                                            </telerik:RadButton>--%>
                                                    <asp:LinkButton ID="btnNewSelectedInvoices" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false"
                                                        CommandName="AddInvoices" CommandArgument='<%# Eval("Id") %>' OnClick="btnNewSelectedInvoices_Click">
                                                            <i class="fas fa-plus"></i> Add Selected Invoices
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>



                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Uncollected Invoices</h4>
                                        <telerik:RadGrid ID="RadGridInvoicesClient" DataSourceID="SqlDataSourceInvoicesClient" runat="server" AllowSorting="true" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Font-Size="X-Small" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" Skin="Bootstrap" FooterStyle-Font-Size="X-Small"
                                            AllowPaging="True" PageSize="100" Width="100%" AllowMultiRowSelection="True" ShowFooter="true" ClientIDMode="AutoID">
                                            <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                                            <ClientSettings EnableRowHoverStyle="true">
                                                <Selecting AllowRowSelect="true" />
                                                <Virtualization EnableVirtualization="false" InitiallyCachedItemsCount="500" LoadingPanelID="RadAjaxLoadingPanel1"
                                                    ItemsPerView="100" EnableCurrentPageScrollOnly="true" />
                                                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="200px" />
                                            </ClientSettings>
                                            <SelectedItemStyle CssClass="SelectedItem" />
                                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceInvoicesClient">
                                                <Columns>
                                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px">
                                                    </telerik:GridClientSelectColumn>
                                                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" HeaderStyle-Width="40px">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="InvoiceNumber" FilterControlAltText="Filter InvoiceNotes column"
                                                        HeaderText="Number" SortExpression="InvoiceNumber" UniqueName="InvoiceNumber"
                                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px"
                                                        FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="JobName" FilterControlAltText="Filter JobName column" ReadOnly="false"
                                                        HeaderText="Job Name" SortExpression="JobName" UniqueName="JobName">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="InvoiceDate" DataType="System.DateTime" FilterControlAltText="Filter InvoiceDate column"
                                                        HeaderText="Date Created" SortExpression="InvoiceDate" UniqueName="InvoiceDate"
                                                        DataFormatString="{0:MM/dd/yy}" ItemStyle-HorizontalAlign="Right"
                                                        HeaderStyle-Width="80px">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Amount" FilterControlAltText="Filter Amount column"
                                                        HeaderText="Amount" SortExpression="Amount" UniqueName="Amount"
                                                        ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="80px"
                                                        FooterAggregateFormatString="{0:N2}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" DataFormatString="{0:N2}">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="AmountDue" FilterControlAltText="Filter AmountDue column"
                                                        HeaderText="Amount Due" SortExpression="AmountDue" UniqueName="AmountDue"
                                                        ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="80px"
                                                        DataFormatString="{0:N2}" FooterAggregateFormatString="{0:N2}"
                                                        Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="InvoiceNotes" FilterControlAltText="Filter InvoiceNotes column"
                                                        HeaderText="Notes" SortExpression="InvoiceNotes" UniqueName="InvoiceNotes">
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                            </table>
                            <asp:SqlDataSource ID="SqlDataSourceInvoicesClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                                SelectCommand="STATEMENT_INVOICES_NOCOLECTED"
                                ProviderName="<%$ ConnectionStrings:cnnProjectsAccounting.ProviderName %>" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblStatementId" Name="statementId" PropertyName="Text" Type="Int32" />
                                    <asp:ControlParameter ControlID="lblStatementClientId" Name="clientId" PropertyName="Text" />
                                    <asp:ControlParameter Name="ByOrganization" Type="Boolean" ControlID="opcByCompany" PropertyName="Checked" />
                                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </fieldset>
                        <%--<div style="text-align: right; padding-right: 50px; height: 40px; padding-top: 15px">--%>
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="text-align: right; padding-right: 15px">
                                    <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success"
                                        Text='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Insert Statement", "Update Statement")%>'
                                        Visible='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), True, False)%>'
                                        CommandName='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "PerformInsert", "Update")%>'>
                                    </asp:LinkButton>
                                </td>
                            </tr>

                        </table>
                    </FormTemplate>
                </EditFormSettings>
            </MasterTableView>
            <ClientSettings>
                <Virtualization EnableVirtualization="false" InitiallyCachedItemsCount="1000" LoadingPanelID="RadAjaxLoadingPanel1"
                    ItemsPerView="100" EnableCurrentPageScrollOnly="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="687px" />
                <ClientEvents OnPopUpShowing="PopUpShowing" />
            </ClientSettings>
        </telerik:RadGrid>

    </div>
    <div>
        <telerik:RadToolTip ID="RadToolTipStatementsPayment" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
            <h2 style="margin: 0; text-align: center; color:white; width: 500px">
                <span class="navbar bg-dark">Receive Statement Payments
                </span>
            </h2>
            <table class="table-bordered" style="width: 500px">
                <tr>
                    <td style="width: 140px; text-align: right" class="Normal">Collected Date:
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="RadDatePickerPayment2" runat="server" ZIndex="50001">
                        </telerik:RadDatePicker>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right" class="Normal">Method:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboPaymentMethod_paym2" runat="server" DataSourceID="SqlDataSourcePaymentMethod" DataTextField="Name" DataValueField="Id"
                            Filter="Contains" MarkFirstMatch="True" Width="100%" ZIndex="50001">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right" class="Normal">Notes:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtPaymentNotes2" runat="server" Width="100%" MaxLength="1024" Rows="2">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center">
                        <asp:LinkButton ID="btnInsertStatementPayments" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="100px">
                                    <i class="fas fa-check"></i> Insert
                        </asp:LinkButton>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancelStatementPayments" runat="server" CssClass="btn btn-default btn" CausesValidation="false" UseSubmitBehavior="false" Width="100px">
                                     Cancel
                    </asp:LinkButton>

                    </td>
                </tr>
            </table>
        </telerik:RadToolTip>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Style="z-index: 7001">
    </telerik:RadWindowManager>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="UPDATE [Invoices_statements] SET [InvoiceDate] = @InvoiceDate, [clientId] = @clientId, [InvoiceNotes] = @InvoiceNotes  WHERE [Id] = @Id"
        SelectCommand="Statement2_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="STATEMENT_DELETE"
        InsertCommand="Statement_INSERT" InsertCommandType="StoredProcedure"
        DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="InvoiceDate" Type="DateTime" />
            <asp:Parameter Name="clientId" Type="Int32" />
            <asp:Parameter Name="InvoiceNotes" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" DefaultValue="" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboClients" Name="Client" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="InvoiceDate" Type="DateTime" />
            <asp:Parameter Name="clientId" Type="Int32" />
            <asp:Parameter Name="InvoiceNotes" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePayments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="STATEMENT_PAYMENTS_INSERT" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblStatementId" Name="statementId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerPayment2" Name="CollectedDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboPaymentMethod_paym2" Name="Method" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtPaymentNotes2" Name="CollectedNotes" PropertyName="Text" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClients" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name+' [' + isnull(Company,'...') + ']' As Name  FROM Clients WHERE (companyId = @companyId)  Order by Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceInvoicesSelected" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT dbo.InvoiceNumber(Invoices.Id) AS InvoiceNumber, Jobs.Job AS JobName, Invoices.Id, Invoices.InvoiceDate, Invoices.Amount, ISNULL(Invoices.AmountDue, 0) AS AmountDue, isnull(BadDebt,0) as BadDebt, left(Invoices.InvoiceNotes,50) as InvoiceNotes FROM Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id WHERE (Invoices.statementId = @statementId) ORDER BY Invoices.Id"
        DeleteCommand="UPDATE Invoices SET statementId = NULL WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblStatementId" Name="statementId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePaymentMethod" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Payment_methods ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False">1</asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblStatementId" runat="server"></asp:Label>
    <asp:Label ID="lblStatementClientId" runat="server"></asp:Label>

    <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="100%" Culture="en-US" Visible="false" ToolTip="Date From of the filter">
    </telerik:RadDatePicker>
    <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="100%" Culture="en-US" Visible="false" ToolTip="Date To of the filter">
    </telerik:RadDatePicker>
</asp:Content>
