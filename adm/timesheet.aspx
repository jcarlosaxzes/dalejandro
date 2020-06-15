<%@ Page Title="Time Sheet" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="timesheet.aspx.vb" Inherits="pasconcept20.timesheet" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cboEmployee">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManagerJob"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadDatePickerFrom">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerTo" />
                    <telerik:AjaxUpdatedControl ControlID="lblMesName" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnBack">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerFrom" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerTo" />
                    <telerik:AjaxUpdatedControl ControlID="lblMesName" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNext">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerFrom" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerTo" />
                    <telerik:AjaxUpdatedControl ControlID="lblMesName" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
    <div class="Formulario">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 100px; text-align:right">From:
                </td>
                <td style="width: 130px">
                    <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" Width="100%" AutoPostBack="true"
                        DateFormat="MM/dd/yyyy">
                    </telerik:RadDatePicker>
                </td>
                <td style="width: 50px; text-align:right">To:
                </td>
                <td style="width: 130px">
                    <telerik:RadDateInput ID="RadDatePickerTo" runat="server" Width="100%" DateFormat="MM/dd/yyyy" ToolTip="Payroll Closing Date"
                        ReadOnly="True">
                    </telerik:RadDateInput>
                </td>
                <td style="width: 100px; text-align:right">Employee:
                </td>
                <td style="width:250px">
                    <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmpl" Height="400px"
                        Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains"
                        AutoPostBack="True">
                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                    </telerik:RadComboBox>
                </td>
                <td style="width: 130px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" Width="100%">
                                    <i class="fas fa-backward"></i> Previous
                    </asp:LinkButton>
                </td>
                <td style="width: 130px">
                    <asp:LinkButton ID="btnNext" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" Width="100%">
                                    <i class="fas fa-forward"></i> Next
                    </asp:LinkButton>
                </td>
                <td style="text-align: center">
                    <h3 style="margin: 0">Time Sheet
                    </h3>
                </td>

            </tr>
        </table>
    </div>

    <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Auto" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceJobs"
        PageSize="100" AllowPaging="true" HeaderStyle-Font-Size="X-Small" HeaderStyle-HorizontalAlign="Center">
        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceJobs" ShowFooter="True" EditFormSettings-FormCaptionStyle-HorizontalAlign="Center">
            <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
            <Columns>
                <telerik:GridTemplateColumn DataField="Id" FilterControlAltText="Filter JobName column" HeaderText="Job" SortExpression="Id"
                    UniqueName="Id" ItemStyle-HorizontalAlign="Left" Aggregate="Count" FooterAggregateFormatString="{0:N0}" ItemStyle-Font-Size="X-Small">
                    <ItemTemplate>
                        <asp:Panel ID="PanelJobTime" runat="server" Visible='<%# Eval("TimeType") = 2%>'>
                            <div>
                                <%--  <h4 style="margin: 0">
                                                <a style="color: blue" href='<%#String.Concat("Job_job.aspx?JobId=", Eval("Id")) %>' target="_blank" title="Click to View Job"><%# Eval("Code")%></a>
                                                <%# String.Concat("  ",Eval("itemName"))%>
                                            </h4>--%>


                                <asp:LinkButton ID="btnEditJob" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to View/Edit Job" CommandName="EditJob" UseSubmitBehavior="false">
                                                <%#Eval("Code")%> 
                                </asp:LinkButton>
                                <b><%# String.Concat("  ",Eval("itemName"))%></b>
                            </div>
                        </asp:Panel>
                        <asp:Panel ID="PanelNonJobTime" runat="server" Visible='<%# Eval("TimeType") = 1%>'>
                            <div>
                                <h3 style="margin: 0; color: darkgreen">
                                    <%# Eval("itemName")%>
                                </h3>
                            </div>
                        </asp:Panel>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>


                <telerik:GridTemplateColumn DataField="D13" FilterControlAltText="Filter D13 column" HeaderText="D13" SortExpression="D13" UniqueName="D13"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D13")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="D12" FilterControlAltText="Filter D12 column" HeaderText="D12" SortExpression="D12" UniqueName="D12"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D12")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="D11" FilterControlAltText="Filter D11 column" HeaderText="D11" SortExpression="D11" UniqueName="D11"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D11")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="D10" FilterControlAltText="Filter D10 column" HeaderText="D10" SortExpression="D10" UniqueName="D10"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D10")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="D9" FilterControlAltText="Filter D9 column" HeaderText="D9" SortExpression="D9" UniqueName="D9"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D9")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="D8" FilterControlAltText="Filter D8 column" HeaderText="D8" SortExpression="D8" UniqueName="D8"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D8")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="D7" FilterControlAltText="Filter D7 column" HeaderText="D7" SortExpression="D7" UniqueName="D7"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D7")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="D6" FilterControlAltText="Filter D6 column" HeaderText="D6" SortExpression="D6" UniqueName="D6"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D6")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="D5" FilterControlAltText="Filter D5 column" HeaderText="D5" SortExpression="D5" UniqueName="D5"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D5")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="D4" FilterControlAltText="Filter D4 column" HeaderText="D4" SortExpression="D4" UniqueName="D4"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D4")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="D3" FilterControlAltText="Filter D3 column" HeaderText="D3" SortExpression="D3" UniqueName="D3"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D3")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="D2" FilterControlAltText="Filter D2 column" HeaderText="D2" SortExpression="D2" UniqueName="D2"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D2")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="D1" FilterControlAltText="Filter D1 column" HeaderText="D1" SortExpression="D1" UniqueName="D1"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D1")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="D0" FilterControlAltText="Filter D0 column" HeaderText="D0" SortExpression="D0" UniqueName="D0"
                    HeaderStyle-Width="70px" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("D0")%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="Total" HeaderText="Total" SortExpression="Total"
                    UniqueName="Total" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="80px"
                    Aggregate="Sum" FooterAggregateFormatString="{0:N1}" FooterStyle-Font-Bold="true">
                    <ItemTemplate>

                        <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("Total", "{0:N1}")%>' Font-Bold="true"></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
        <ClientSettings>
            <Virtualization EnableVirtualization="false" InitiallyCachedItemsCount="100"
                ItemsPerView="100" EnableCurrentPageScrollOnly="true" />
            <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="450px" />
        </ClientSettings>
    </telerik:RadGrid>

    <telerik:RadWindowManager ID="RadWindowManagerJob" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <asp:SqlDataSource ID="SqlDataSourceJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="TIMESHEET_BY_EMPLOYEE_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployee" Name="Employee" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpl" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
