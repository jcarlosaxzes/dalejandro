<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="invoices.aspx.vb" Inherits="pasconcept20.invoices1" %>


<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table class="table-condensed" style="width: 100%">
        <tr>
            <td style="width: 80px">Company:
            </td>
            <td style="width: 350px">
                <telerik:RadComboBox ID="cboCompany" runat="server" AppendDataBoundItems="true"
                    DataSourceID="SqlDataSourceCompany" Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(All Companies...)" Value="-1" />
                    </Items>
                </telerik:RadComboBox>

            </td>
            <td style="width: 100px">Invoice Status:
            </td>
            <td style="width: 150px">
                <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" AppendDataBoundItems="true">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="Pending" Value="0" />
                        <telerik:RadComboBoxItem runat="server" Text="Past Due" Value="2" Selected="true" />
                        <telerik:RadComboBoxItem runat="server" Text="Paid" Value="1" />
                        <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="-1" />
                    </Items>
                </telerik:RadComboBox>

            </td>
            <td style="width: 70px">Method:
            </td>
            <td style="width: 250px">
                <telerik:RadComboBox ID="cboPaymentMethod" runat="server" DataSourceID="SqlDataSourcePaimentMethod"
                    DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="true">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(All Payment Methods)" Value="-1" />
                    </Items>

                </telerik:RadComboBox>
            </td>

            <td style="text-align: right">
                <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-search"></span> Search
                </asp:LinkButton>
            </td>
        </tr>
    </table>
    <table class="table-condensed" style="width: 100%">
        <tr>
            <td>
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowSorting="True" AutoGenerateColumns="False"
                    DataSourceID="SqlDataSource1" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" AllowPaging="true" PageSize="25">
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                        <Columns>
                            <telerik:GridBoundColumn DataField="Id" HeaderText="Id" UniqueName="Id" ReadOnly="True" Display="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="Number" HeaderText="#" ReadOnly="True" SortExpression="Number" UniqueName="Number"
                                HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit">
                                <%# Eval("Number") %>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Company" HeaderText="Company - Contact" SortExpression="Company" UniqueName="Company" ReadOnly="True">
                                <ItemTemplate>
                                    <b><%# Eval("Company")%></b> - <%# Eval("Contact")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="CreateDate" HeaderText="Created" SortExpression="CreateDate" UniqueName="CreateDate" ReadOnly="True"
                                HeaderStyle-Width="100px" DataFormatString="{0:d}">
                            </telerik:GridBoundColumn>
                            <telerik:GridDateTimeColumn DataField="ExpirationDate" HeaderText="Expiration" SortExpression="ExpirationDate" UniqueName="ExpirationDate"
                                HeaderStyle-Width="100px" DataFormatString="{0:d}" PickerType="DatePicker">
                            </telerik:GridDateTimeColumn>
                            <telerik:GridBoundColumn DataField="Amount" HeaderText="Amount" SortExpression="Amount" UniqueName="Amount" ItemStyle-HorizontalAlign="Right"
                                HeaderStyle-Width="100px" DataFormatString="{0:C2}" Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Status" HeaderText="Status" SortExpression="Status" UniqueName="Status" ReadOnly="True"
                                HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Notes" HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" Display="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridDateTimeColumn DataField="PaidDate" HeaderText="Paid Date" SortExpression="PaidDate" UniqueName="PaidDate"
                                HeaderStyle-Width="100px" DataFormatString="{0:d}" PickerType="DatePicker">
                            </telerik:GridDateTimeColumn>
                            <telerik:GridTemplateColumn DataField="Method" HeaderText="Method" SortExpression="Method" UniqueName="Method" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Center">
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="cboMethod" runat="server" DataSourceID="SqlDataSourcePaimentMethod"
                                        DataTextField="Name" DataValueField="Id" Width="100%" SelectedValue='<%# Bind("Method")%>' AppendDataBoundItems="true">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(N/A)" Value="0" />
                                        </Items>

                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%# Eval("PaimentMethod")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>


                            <telerik:GridTemplateColumn HeaderText="Axzes" UniqueName="Axzes" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center" ReadOnly="true">
                                <ItemTemplate>
                                    <table style="text-align: center; width: 100%">
                                        <tr>
                                            <td style="width: 100%">
                                                <asp:LinkButton ID="btnBindAxzes" runat="server" CommandName="BindAxzesInvoice" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false"
                                                    ToolTip="Bind Company to Axzes Invoice" Visible='<%# Eval("AxzesJobId") > 0 %>'>
                                                    <span class="glyphicon glyphicon-credit-card"></span>
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <%# Eval("AxzesInvoiceNumber")%>
                                            </td>
                                        </tr>
                                    </table>


                                </ItemTemplate>
                            </telerik:GridTemplateColumn>



                            <telerik:GridButtonColumn ConfirmText="Delete this Invoice?" ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete" HeaderText=""
                                UniqueName="DeleteColumn" HeaderStyle-Width="50px">
                            </telerik:GridButtonColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn UniqueName="EditCommandColumn1" ButtonType="PushButton">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>

    <telerik:RadToolTip ID="RadToolTipBindAxzesClient" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table table-bordered" style="width: 650px">
            <tr>
                <td>
                    <h2 style="margin: 0; text-align: center; color:white; width: 650px">
                        <span class="navbar bg-dark">Bind PASconcept Invoice to Axzes Invoice
                        </span>
                    </h2>

                    <p>
                        To link the invoices of PASconcept to those of Axzes, it is required that the Company and the Job have been previously linked from CompanyList.
                        <br />
                        Linked invoices must have the same Amount.
                    </p>
                </td>
            </tr>
            <tr>
                <td>
                    <h3>
                        <asp:Label ID="lblCompanyName" runat="server"></asp:Label></h3>
                </td>
            </tr>
            <tr>
                <td>
                    <p>
                        Create NEW Axzes Invoice or Select one from Invoice List?
                    </p>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadComboBox ID="cboAxzesInvoices" runat="server" DataSourceID="SqlDataSourceAxzesInvoices"
                        DataTextField="InvoiceNumber" DataValueField="Id" Width="100%" AppendDataBoundItems="True" ZIndex="50001" Height="350px"
                        MarkFirstMatch="True" Filter="Contains">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Create NEW Axzes Invoice...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>

                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <asp:LinkButton ID="btnBindAxzesInvoice" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-ok"></span> Update
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PASconceptInvoices_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="DELETE FROM [Company_Payments] WHERE [Id] = @Id"
        UpdateCommand="PASconceptInvoices_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboCompany" Name="companyId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="statusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboPaymentMethod" Name="paymentMethodId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ExpirationDate" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="Notes" />
            <asp:Parameter Name="PaidDate" />
            <asp:Parameter Name="Method" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />

        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceCompany" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT companyId as [Id], [Name] FROM [Company]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePaimentMethod" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Payment_methods]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceAxzesInvoices" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select Id, InvoiceNumber=dbo.InvoiceNumber(Id) from Invoices where JobId=@AxzesJobId and Amount=(select Amount from [Company_Payments] where Id=@PASInvoiveId) order by id desc ">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="AxzesJobId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblSelectedInvoiceId" Name="PASInvoiveId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblSelectedInvoiceId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>

