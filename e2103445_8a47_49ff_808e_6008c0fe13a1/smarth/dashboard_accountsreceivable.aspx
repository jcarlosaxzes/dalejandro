<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/smarth/mastersmarth.Master" CodeBehind="dashboard_accountsreceivable.aspx.vb" Inherits="pasconcept20.dashboard_accountsreceivable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <style>
        h1 {
            font-size: 50px;
            padding-top:20px;
        }

        h2 {
            font-size: 28px;
            padding-top:20px;
        }
        .PanelGreen{
            font-size:16px;
            color:black;
            font-weight:bold;
            background-color:rgb(145, 199, 148);
        }
        .PanelRed{
            font-size:16px;
            color:black;
            font-weight:bold;
            background-color:rgb(214, 76, 76);
        }
        .PanelBlue{
            font-size:16px;
            color:black;
            font-weight:bold;
            background-color:rgb(92, 194, 241);
        }
        .ComboLabel{
            font-size:14px;
            color:darkblue;
            font-weight:bold;
        }
    </style>


    <div id="main-section-header" class="row">
        <table class="table-condensed" style="width:100%">
            <tr>
                <td style="text-align: right;">
                    <telerik:RadComboBox ID="cboTimeFrame" runat="server" AppendDataBoundItems="true" 
                        AutoPostBack="true" Label="Time Frame:" Width="95%" LabelCssClass="ComboLabel" Font-Size="12px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="All Years" Value="1" Selected="true"/>
                            <telerik:RadComboBoxItem runat="server" Text="Last Year" Value="2" />
                            <telerik:RadComboBoxItem runat="server" Text="This Year" Value="3" />
                            <telerik:RadComboBoxItem runat="server" Text="Last Quarter" Value="4" />
                            <telerik:RadComboBoxItem runat="server" Text="This Quarter" Value="5" />
                            <telerik:RadComboBoxItem runat="server" Text="Last Month" Value="6" />
                            <telerik:RadComboBoxItem runat="server" Text="This Month" Value="7" />
                            <telerik:RadComboBoxItem runat="server" Text="Last 30 Days" Value="8" />
                            <telerik:RadComboBoxItem runat="server" Text="Last 15 Days" Value="9" />
                            <telerik:RadComboBoxItem runat="server" Text="Last 7 Days" Value="10" />
                            <telerik:RadComboBoxItem runat="server" Text="Last  Day" Value="11" />
                            <telerik:RadComboBoxItem runat="server" Text="ToDay" Value="12" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <telerik:RadComboBox ID="cboDepartment" runat="server" DataSourceID="SqlDataSourceDepartments" AutoPostBack="true" 
                        Label="Department:" LabelCssClass="ComboLabel"
                        DataTextField="Name" DataValueField="Id" Width="95%" AppendDataBoundItems="true" Font-Size="12px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="0" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>

                </td>
            </tr>
        </table>

        <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" Width="100%">
        <ItemTemplate>
             <div style="text-align: center;width:100%">

                 <table class="table-condensed" style="width: 98%">
                    <tr>
                        <td></td>
                         <td colspan="3">
                            <h1 style="color: darkred"><%# Eval("AmountDue", "{0:C0}")%></h1>
                            <p class="text-success input-lg PanelBlue">Accounts Receivable Total Due</p>
                        </td>
                    </tr>

                     <tr>
                         <td></td>
                         <td style="width:48%">
                             <h2 style="color: darkred"><%# Eval("Billed", "{0:C0}")%></h2>
                            <p class="text-success input-lg PanelGreen">Billed</p>
                         </td>
                         <td></td>
                         <td style="width:48%">
                             <h2 style="color: darkgreen"><%# Eval("Collected", "{0:C0}")%></h2>
                            <p class="text-success input-lg PanelRed">Collected</p>
                         </td>
                     </tr>

                     <tr>
                         <td></td>
                         <td style="width:48%">
                             <h2 style="color: darkred"><%# Eval("BadDebt", "{0:C0}")%></h2>
                            <p class="text-success input-lg PanelRed">Bad Debt</p>
                         </td>
                         <td></td>
                         <td style="width:48%">
                             <h2 style="color: darkgreen"><%# Eval("NotEmitted", "{0:C0}")%></h2>
                            <p class="text-success input-lg PanelGreen">Not Emitted</p>
                         </td>
                     </tr>

                     <tr>
                         <td></td>
                         <td style="width:48%">
                             <h2 style="color: darkred"><%# Eval("90D+", "{0:C0}")%></h2>
                            <p class="text-success input-lg PanelBlue">Due  +90D</p>
                         </td>
                         <td></td>
                         <td style="width:48%">
                             <h2 style="color: orangered"><%# Eval("L90D", "{0:C0}")%></h2>
                            <p class="text-success input-lg PanelBlue">Due 61D to 90D</p>
                         </td>
                     </tr>

                     <tr>
                         <td></td>
                         <td style="width:48%">
                             <h2 style="color: darkorange"><%# Eval("L60D", "{0:C0}")%></h2>
                            <p class="text-success input-lg PanelBlue">Due 31D to 60D</p>
                         </td>
                         <td></td>
                         <td style="width:48%">
                             <h2 style="color: orange"><%# Eval("L30D", "{0:C0}")%></h2>
                            <p class="text-success input-lg PanelBlue">Due 1D to 30D</p>
                         </td>
                     </tr>

                    

                     </table>
             </div>
        </ItemTemplate>
        </asp:FormView>


        
    </div>

     <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Dashboard3_AccountsReceivable" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboTimeFrame" Name="TimeFrameId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartment" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
     </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
</asp:Content>
