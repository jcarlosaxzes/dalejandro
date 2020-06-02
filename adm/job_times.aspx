<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_times.aspx.vb" Inherits="pasconcept20.Job_times" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">
        <div class="row">
            <div class="form-group">
                <asp:LinkButton ID="btnExport" runat="server" ToolTip="Export records to Excel"
                    CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-save-file"></span> Export
                </asp:LinkButton>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticUpdates="True" AllowSorting="True" DataSourceID="SqlDataSource1"
                    Width="100%" AutoGenerateColumns="False" AllowPaging="True" PageSize="100" Height="700px"
                    ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small">
                    <ClientSettings>
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" ShowFooter="True">
                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                        <Columns>
                            <telerik:GridTemplateColumn AllowFiltering="False" DataField="nEmployee" HeaderText="Employee Name" ReadOnly="True"
                                SortExpression="nEmployee" UniqueName="nEmployee" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" Text='<%# Eval("nEmployee")%>' ToolTip="Click to edit" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn AllowFiltering="False" DataField="JobNumber" HeaderText="Job" ReadOnly="True"
                                SortExpression="JobNumber" UniqueName="JobNumber" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridDateTimeColumn DataField="Fecha" DataFormatString="{0:MM/dd/yy}" DataType="System.DateTime"
                                HeaderText="D.Work" SortExpression="Fecha" UniqueName="Fecha" HeaderStyle-Width="80px"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridDateTimeColumn>
                            <telerik:GridDateTimeColumn DataField="DateEntry" DataFormatString="{0:MM/dd/yy}"
                                HeaderText="D.Entry" SortExpression="DateEntry" UniqueName="DateEntry"
                                HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridDateTimeColumn>
                            <telerik:GridNumericColumn AllowFiltering="False" DataField="Time"
                                HeaderText="T.Hrs" SortExpression="Time" UniqueName="Time" Aggregate="Sum"
                                DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}" HeaderStyle-Width="70px"
                                ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridNumericColumn>
                            <telerik:GridTemplateColumn DataField="categoryId" FilterControlAltText="Filter CategoryId column" HeaderStyle-Width="150px"
                                HeaderText="Category" SortExpression="categoryId" UniqueName="categoryId" HeaderStyle-HorizontalAlign="Center">
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="cboCategory" runat="server" DataSourceID="SqlDataSourceCategory" SelectedValue='<%# Bind("categoryId")%>'
                                        DataTextField="Name" DataValueField="Id" Width="600px" AppendDataBoundItems="true">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="(Select Time Sheet Category...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>

                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="CategoryLabel" runat="server" Text='<%# Eval("Category")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn AllowFiltering="False" DataField="InvoiceNumber" HeaderText="Invoice" ReadOnly="True" HeaderTooltip="Invoice Number</br>Time x Rate"
                                SortExpression="InvoiceNumber" UniqueName="InvoiceNumber" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div>
                                        <asp:LinkButton ID="btnNewInvoice" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to Insert Invoice (hr)"
                                            CommandName="NewHrInvoice" UseSubmitBehavior="false" Visible='<%# iif(Eval("invoiceId")=0,True,False) %>'>
                                                <span aria-hidden="true" class="glyphicon glyphicon-plus glyphicon-small"></span>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDeleteInvoice" runat="server" CommandArgument='<%# Eval("invoiceId")%>' ToolTip="Click to delete Invoice (hr)"
                                            CommandName="DeleteHrInvoice" UseSubmitBehavior="false" Visible='<%# iif(Eval("invoiceId")>0,True,False) %>'>
                                                <span aria-hidden="true" class="glyphicon glyphicon-trash glyphicon-small"></span>
                                        </asp:LinkButton>
                                        <a href='<%# LocalAPI.GetSharedLink_URL(4,Eval("invoiceId"))%>' target="_blank" title="view invoice"><%# Eval("InvoiceNumber")%></a>
                                    </div>
                                    <div style="text-align: center">
                                        <%# Eval("TimeInvoice")%> <%# iif(Eval("invoiceId")>0,"  x  ","") %> <%# Eval("RateInvoice")%>
                                    </div>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridNumericColumn AllowFiltering="False" DataField="Amount" ReadOnly="true"
                                HeaderText="Amount" SortExpression="Amount" UniqueName="Amount" Aggregate="Sum"
                                DataFormatString="{0:N2}" FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="70px"
                                ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridNumericColumn>
                            <telerik:GridNumericColumn AllowFiltering="False" DataField="AmountDue" ReadOnly="true"
                                HeaderText="A.Due" SortExpression="AmountDue" UniqueName="AmountDue" Aggregate="Sum"
                                DataFormatString="{0:N2}" FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="70px"
                                ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridNumericColumn>


                            <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                                HeaderText="Description" SortExpression="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center">
                                <EditItemTemplate>
                                    <telerik:RadTextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description")%>' Width="600px" MaxLength="512" Rows="3" TextMode="MultiLine">
                                    </telerik:RadTextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="DescriptionLabel" runat="server" Font-Size="X-Small" Text='<%# Eval("DescriptionCompuesta")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <EditFormSettings>
                            <PopUpSettings Modal="true" Width="700px" />
                            <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                    <PagerStyle AlwaysVisible="false" />
                </telerik:RadGrid>
            </div>

        </div>
    </div>
    <div style="height: 1px; overflow: auto">
        <telerik:RadGrid ID="RadGridExportData" runat="server" DataSourceID="SqlDataSource1" AllowPaging="True" PageSize="10">
            <MasterTableView DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="Id">
                <Columns>
                    <telerik:GridBoundColumn DataField="nEmployee" HeaderText="Employee" UniqueName="nEmployee">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JobNumber" HeaderText="Job" UniqueName="JobNumber">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Fecha" HeaderText="Date of Work" UniqueName="Fecha" DataFormatString="{0:MM/dd/yy}">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Time" HeaderText="Time (Hrs.)" UniqueName="Time" Aggregate="Sum"
                        DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="InvoiceNumber" HeaderText="InvoiceNumber" UniqueName="InvoiceNumber">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Amount" HeaderText="Amount" UniqueName="Amount" Aggregate="Sum"
                        DataFormatString="{0:N2}" FooterAggregateFormatString="{0:N2}">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AmountDue" HeaderText="Amount Due" UniqueName="AmountDue" Aggregate="Sum"
                        DataFormatString="{0:N2}" FooterAggregateFormatString="{0:N2}">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Description" HeaderText="Description" UniqueName="Description">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <telerik:RadToolTip ID="RadToolTipConfirmInsert" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <table class="table-condensed" style="width: 800px">
            <tr>
                <td colspan="2">
                    <h2 style="margin: 0; text-align: center; width: 800px">
                        <span class="label label-default center-block">
                            <asp:Label ID="lblActionMesage" runat="server"></asp:Label>
                        </span>
                    </h2>

                </td>
            </tr>
            <tr>
                <td style="width: 150px; text-align: right">Time Worked:
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtTimeSel" runat="server" MaxLength="3"
                        MinValue="0.1" ShowSpinButtons="True" ButtonsPosition="Right" ToolTip="Time in hours"
                        Value="1" Width="150px" MaxValue="999">
                        <NumberFormat DecimalDigits="1" />
                        <IncrementSettings Step="0.5" />
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; text-align: right">Rate:
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtRate" runat="server"
                        Width="150px">
                        <NumberFormat DecimalDigits="2" />
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td>Notes:</td>
                <td>
                    <telerik:RadTextBox ID="txtTimeDescription" runat="server" Rows="4" TextMode="MultiLine" Width="100%" MaxLength="512" ValidationGroup="time_insert">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: center; padding-top: 25px" colspan="2">
                    <asp:LinkButton ID="btnOk" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="100px">
                                    <span class="glyphicon glyphicon-ok"></span> Ok
                    </asp:LinkButton>

                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-default btn" CausesValidation="false" UseSubmitBehavior="false" Width="100px">
                                    Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>


    <telerik:RadToolTip ID="RadToolTipConfirmDelete" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <table class="table table-bordered" style="width: 500px">
            <tr>
                <td colspan="2">
                    <h2 style="margin: 0; text-align: center; width: 500px">
                        <span class="label label-default center-block">
                            <asp:Label ID="lblActionMesage2" runat="server"></asp:Label>
                        </span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td style="text-align: center" colspan="2">
                    <asp:LinkButton ID="btnOk2" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="100px">
                                    <span class="glyphicon glyphicon-ok"></span> Ok
                    </asp:LinkButton>

                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancel2" runat="server" CssClass="btn btn-default btn" CausesValidation="false" UseSubmitBehavior="false" Width="100px">
                                    Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>



    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="TIMES_JOB_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="TIME_UPDATE" UpdateCommandType="StoredProcedure"
        DeleteCommand="INVOICE_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" DefaultValue="" Name="JobId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Fecha" Type="DateTime" />
            <asp:Parameter Name="DateEntry" Type="DateTime" />
            <asp:Parameter Name="Time" />
            <asp:Parameter Name="categoryId" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="lblInvoiceSelected" DefaultValue="" Name="Id" PropertyName="Text" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Employees_time_categories] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblInvoiceSelected" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTimeId" runat="server" Visible="False"></asp:Label>
</asp:Content>
