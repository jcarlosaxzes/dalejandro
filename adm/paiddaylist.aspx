<%@ Page Title="Payroll Calendar" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="paiddaylist.aspx.vb" Inherits="pasconcept20.paiddaylist" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1"  />
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnInsert">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" EnableEmbeddedSkins="false" />

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Payroll Calendar</span>
    </div>

    <table class="table-sm" style="width:100%">
        <tr>
            <td style="width:200px">
                <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Culture="en-US" DateInput-Label="Date:" Width="100%">
                </telerik:RadDatePicker>

            </td>
            <td style="width:180px">
                <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    Add Closing Date
                </asp:LinkButton>
            </td>
            <td>

            </td>
            <td style="width:300px;text-align:right">
                <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear"
                        DataTextField="nYear" DataValueField="Year" Width="150px">
                    </telerik:RadComboBox>
                <asp:LinkButton ID="btnInicializeCalendar" runat="server" ToolTip="Initialize Calendar this year"
                    CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                     Initialize Year
                </asp:LinkButton>
            </td>
        </tr>
    </table>

    <table class="table-sm" style="width: 100%">
        <tr>
            <td style="width: 200px">
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSourcePayrollCalendar" GridLines="None"
                    AutoGenerateColumns="False" AllowAutomaticDeletes="True" Width="100%" AllowAutomaticUpdates="True"
                    AllowPaging="True" CellSpacing="0" AllowSorting="True" PageSize="50" Height="600px"
                    HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                    <ClientSettings>
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="PaidDay" DataSourceID="SqlDataSourcePayrollCalendar">
                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                        <Columns>
                            <telerik:GridTemplateColumn DataField="PaidDay" DataType="System.DateTime" HeaderText="Closing Date" ItemStyle-Font-Size="X-Small"
                                SortExpression="PaidDay" UniqueName="PaidDay" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="PaidDayLabel" runat="server" Text='<%# Eval("PaidDay", "{0:d}") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ButtonType="ImageButton"
                                HeaderText="" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="45px">
                            </telerik:GridButtonColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
            <td>
                <telerik:RadScheduler RenderMode="Native" runat="server" ID="RadScheduler1" SelectedView="YearView" Skin="Material"
                    DataSourceID="SqlDataSourcePayrollCalendar" Height="600px" DataKeyField="PaidDay" DataSubjectField="PaidDay" DataStartField="PaidDay"
                    DataEndField="PaidDay" ReadOnly="true" ShowHeader="false" Enabled="false">
                    <YearView UserSelectable="true" ShowDateHeaders="false" ReadOnly="true" />
                    <TimelineView UserSelectable="false"></TimelineView>
                    <MultiDayView UserSelectable="false"></MultiDayView>
                    <DayView UserSelectable="false"></DayView>
                    <WeekView UserSelectable="false"></WeekView>
                    <MonthView UserSelectable="false"></MonthView>

                </telerik:RadScheduler>
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="SqlDataSourcePayrollCalendar" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [PaidDays] WHERE [PaidDay] = @PaidDay"
        SelectCommand="SELECT [PaidDay] FROM [PaidDays] WHERE companyId=@companyId and Year(PaidDay)=@year ORDER BY [PaidDay] DESC"
        UpdateCommand="UPDATE PaidDays SET PaidDay = CONVERT(DATETIME, @PaidDay, 102)">
        <DeleteParameters>
            <asp:Parameter Name="PaidDay" Type="DateTime" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="PaidDay" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Years] where [Year]>2000 ORDER BY [Year] DESC "></asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
