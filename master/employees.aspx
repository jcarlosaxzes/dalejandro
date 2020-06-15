<%@ Page Title="Employees" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="employees.aspx.vb" Inherits="pasconcept20.employees1" %>

<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>Company Users (Employee) List</h2>
    <asp:Label ID="lblMsg" runat="server" CssClass="Error"></asp:Label>

    <h3>Employee Info</h3>
    <p>
        
    </p>

        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 80px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
                    </asp:LinkButton>
                </td>
                <td>
                    Insert New Employee to Company. Email must be exist in other company!
                </td>
                <td></td>
            </tr>
        </table>

    <div>
        <asp:ValidationSummary ID="vsClient" runat="server" ValidationGroup="NewEmployee" ForeColor="Red"
            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were this errors:"></asp:ValidationSummary>

                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" ValidationGroup="NewEmployee"
                                    ErrorMessage="Email is Required" Display="None"></asp:RequiredFieldValidator>

                <asp:RegularExpressionValidator ID="emailValidator" runat="server" Display="None" ValidationGroup="NewEmployee"
                    ErrorMessage="(*) Please, enter valid e-mail address." ValidationExpression="^[\w\.\-]+@[a-zA-Z0-9\-]+(\.[a-zA-Z0-9\-]{1,})*(\.[a-zA-Z]{2,3}){1,2}$"
                    ControlToValidate="txtEmail"></asp:RegularExpressionValidator>
                <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Select Role...)" Display="None"
                                        Operator="NotEqual" ControlToValidate="cboRoles" Text="*" ErrorMessage="Define Role" SetFocusOnError="true" ValidationGroup="NewEmployee"> </asp:CompareValidator>


    </div>
    <table class="table-condensed" style="width: 800px">
        <tr>
            <td style="text-align: right; width: 180px">Role:
            </td>
            <td>
                <telerik:RadComboBox ID="cboRoles" runat="server" Width="350px" AppendDataBoundItems="true"
                    DataSourceID="SqlDataSourceRoles" DataTextField="Name" DataValueField="Id" Height="300px">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(Select Role...)" Value="-1" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Email:
            </td>
            <td colspan="2">
                <telerik:RadTextBox ID="txtEmail" runat="server" Width="100%">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center">
                <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="NewEmployee">
                                    <i class="fas fa-plus"></i> Insert Employee
                </asp:LinkButton>
            </td>
        </tr>
    </table>

    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                <Columns>
                    <telerik:GridBoundColumn DataField="Id" HeaderText="ID" SortExpression="Id" UniqueName="Id">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FullName" HeaderText="Name" SortExpression="FullName" UniqueName="FullName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Email" HeaderText="Email" SortExpression="Email" UniqueName="Email">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Role" HeaderText="Role" SortExpression="Role" UniqueName="Role">
                    </telerik:GridBoundColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
            <FilterMenu EnableImageSprites="False">
            </FilterMenu>
            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
            </HeaderContextMenu>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Email, FullName, Role FROM Employees WHERE (companyId = @companyId) ORDER BY FullName"
        InsertCommand="EMPLOYEE_shot_INSERT" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboRoles" Name="roleId" PropertyName="SelectedValue" />
            <asp:Parameter Direction="InputOutput" Name="Id_OUT" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceRoles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Employees_roles where companyId=@companyId order by Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedEmailUser" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblNewEmployeeInsertedId" runat="server" Visible="False"></asp:Label>
</asp:Content>
