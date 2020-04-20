<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_tags.aspx.vb" Inherits="pasconcept20.job_tags" %>

<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">
        <div class="row">
            <div class="form-group">
                <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name" Enabled="false"
                    DataValueField="Id" Width="40%" AppendDataBoundItems="true" AutoPostBack="true" Label="Department:">
                </telerik:RadComboBox>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <telerik:RadComboBox ID="cboPreExistingTags" runat="server" DataSourceID="SqlDataSourceDepartment_USED_tags" DataTextField="Tag" DataValueField="Tag" Width="90%" AppendDataBoundItems="true"
                    MarkFirstMatch="True" Filter="Contains" Height="450px" AutoPostBack ="true" Label="Pre-Existing Tag:">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(Select Pre-Existing Tag...)" Value="-1" Selected="true" />
                    </Items>
                </telerik:RadComboBox>
            </div>
        </div>
        <asp:Panel runat="server" ID="panelCategoryTags">
            <div class="row">
                <div class="form-group">
                    <h4>Or Create One, Selecting Tags by Category</h4>
                </div>
            </div>
            <div>
                <table class="table-condensed" style="width: 100%">
                    <tr>
                        <td style="width: 33%">
                            <asp:Label ID="lblCategory0" runat="server" Text="Category 0" CssClass="label label-default"></asp:Label>
                            <telerik:RadComboBox ID="cboTagCat0" runat="server" DataSourceID="SqlDataSourceTagCat0" DataTextField="Tag" DataValueField="Id" Width="90%" AppendDataBoundItems="true"
                                MarkFirstMatch="True" Filter="Contains" Height="250px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Select Tag Category 0...)" Value="-1" Selected="true" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td style="width: 33%">
                            <asp:Label ID="lblCategory1" runat="server" Text="Category 1" CssClass="label label-default"></asp:Label>
                            <telerik:RadComboBox ID="cboTagCat1" runat="server" DataSourceID="SqlDataSourceTagCat1" DataTextField="Tag" DataValueField="Id" Width="90%" AppendDataBoundItems="true"
                                MarkFirstMatch="True" Filter="Contains" Height="250px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Select Tag Category 1...)" Value="-1" Selected="true" />
                                </Items>
                            </telerik:RadComboBox>

                        </td>
                        <td>
                            <asp:Label ID="lblCategory2" runat="server" Text="Category 2" CssClass="label label-default"></asp:Label>
                            <telerik:RadComboBox ID="cboTagCat2" runat="server" DataSourceID="SqlDataSourceTagCat2" DataTextField="Tag" DataValueField="Id" Width="90%" AppendDataBoundItems="true"
                                MarkFirstMatch="True" Filter="Contains" Height="250px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Select Tag Category 2...)" Value="-1" Selected="true" />
                                </Items>
                            </telerik:RadComboBox>

                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblCategory3" runat="server" Text="Category 3" CssClass="label label-default"></asp:Label>
                            <telerik:RadComboBox ID="cboTagCat3" runat="server" DataSourceID="SqlDataSourceTagCat3" DataTextField="Tag" DataValueField="Id" Width="90%" AppendDataBoundItems="true"
                                MarkFirstMatch="True" Filter="Contains" Height="250px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Select Tag Category 3...)" Value="-1" Selected="true" />
                                </Items>
                            </telerik:RadComboBox>

                        </td>
                        <td>
                            <asp:Label ID="lblCategory4" runat="server" Text="Category 4" CssClass="label label-default"></asp:Label>
                            <telerik:RadComboBox ID="cboTagCat4" runat="server" DataSourceID="SqlDataSourceTagCat4" DataTextField="Tag" DataValueField="Id" Width="90%" AppendDataBoundItems="true"
                                MarkFirstMatch="True" Filter="Contains" Height="250px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Select Tag Category 4...)" Value="-1" Selected="true" />
                                </Items>
                            </telerik:RadComboBox>

                        </td>
                        <td>
                            <asp:Label ID="lblCategory5" runat="server" Text="Category 5" CssClass="label label-default"></asp:Label>
                            <telerik:RadComboBox ID="cboTagCat5" runat="server" DataSourceID="SqlDataSourceTagCat5" DataTextField="Tag" DataValueField="Id" Width="90%" AppendDataBoundItems="true"
                                MarkFirstMatch="True" Filter="Contains" Height="250px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Select Tag Category 5...)" Value="-1" Selected="true" />
                                </Items>
                            </telerik:RadComboBox>

                        </td>

                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblCategory6" runat="server" Text="Category 6" CssClass="label label-default"></asp:Label>
                            <telerik:RadComboBox ID="cboTagCat6" runat="server" DataSourceID="SqlDataSourceTagCat6" DataTextField="Tag" DataValueField="Id" Width="90%" AppendDataBoundItems="true"
                                MarkFirstMatch="True" Filter="Contains" Height="250px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Select Tag Category 6...)" Value="-1" Selected="true" />
                                </Items>
                            </telerik:RadComboBox>

                        </td>
                        <td>
                            <asp:Label ID="lblCategory7" runat="server" Text="Category 7" CssClass="label label-default"></asp:Label>
                            <telerik:RadComboBox ID="cboTagCat7" runat="server" DataSourceID="SqlDataSourceTagCat7" DataTextField="Tag" DataValueField="Id" Width="90%" AppendDataBoundItems="true"
                                MarkFirstMatch="True" Filter="Contains" Height="250px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Select Tag Category 7...)" Value="-1" Selected="true" />
                                </Items>
                            </telerik:RadComboBox>

                        </td>
                        <td>
                            <asp:Label ID="lblCategory8" runat="server" Text="Category 8" CssClass="label label-default"></asp:Label>
                            <telerik:RadComboBox ID="cboTagCat8" runat="server" DataSourceID="SqlDataSourceTagCat8" DataTextField="Tag" DataValueField="Id" Width="90%" AppendDataBoundItems="true"
                                MarkFirstMatch="True" Filter="Contains" Height="250px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Select Tag Category 8...)" Value="-1" Selected="true" />
                                </Items>
                            </telerik:RadComboBox>

                        </td>

                    </tr>
                </table>
            </div>
        </asp:Panel>
        <div style="margin-top: 25px">
            <asp:LinkButton ID="btnAddTags" runat="server" ToolTip="Insert selected Tags"
                CssClass="btn btn-primary" UseSubmitBehavior="false" ValidationGroup="Tag">
                            <span class="glyphicon glyphicon-plus"></span> TAGs
            </asp:LinkButton>
        </div>

        <div class="row">
            <div class="form-group">
                <h4>Job Tags List</h4>
                <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="SqlDataSourceTagOfJob" DataKeyNames="Id" ItemPlaceholderID="Container1" BorderWidth="1"
                    BorderStyle="Solid">
                    <LayoutTemplate>
                        <fieldset style="width: 100%">
                            <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                        </fieldset>

                    </LayoutTemplate>
                    <ItemTemplate>
                        <telerik:RadButton ID="btnTag" runat="server" Text='<%# Eval("Tag")%>' CommandArgument='<%# Eval("Tag")%>' CssClass="btn-success" CommandName="DeleteTAG">
                            <ConfirmSettings ConfirmText="Are you sure to delete TAG from Job?" Title="Confirm Delete TAG" Width="300" />
                        </telerik:RadButton>

                    </ItemTemplate>
                </telerik:RadListView>
                <small>Click Tag to Delete from List</small>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceCRUD" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Jobs_tags] WHERE [jobId] = @jobId and Tag=@Tag"
        InsertCommand="Jobs_tags_INSERT" InsertCommandType="StoredProcedure"
        SelectCommand="prj_tags_for_Job_SELECT" SelectCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblTag" Name="Tag" PropertyName="Text" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblTag" Name="Tag" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTagCat0" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Project_tags_JOB_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>

            <asp:ControlParameter ControlID="cboDepartments" Name="departmenId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="CategoryId" DefaultValue="0" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTagCat1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Project_tags_JOB_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>

            <asp:ControlParameter ControlID="cboDepartments" Name="departmenId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="CategoryId" DefaultValue="1" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTagCat2" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Project_tags_JOB_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>

            <asp:ControlParameter ControlID="cboDepartments" Name="departmenId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="CategoryId" DefaultValue="2" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTagCat3" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Project_tags_JOB_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>

            <asp:ControlParameter ControlID="cboDepartments" Name="departmenId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="CategoryId" DefaultValue="3" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTagCat4" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Project_tags_JOB_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>

            <asp:ControlParameter ControlID="cboDepartments" Name="departmenId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="CategoryId" DefaultValue="4" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTagCat5" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Project_tags_JOB_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboDepartments" Name="departmenId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="CategoryId" DefaultValue="5" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTagCat6" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Project_tags_JOB_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboDepartments" Name="departmenId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="CategoryId" DefaultValue="6" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTagCat7" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Project_tags_JOB_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboDepartments" Name="departmenId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="CategoryId" DefaultValue="7" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTagCat8" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Project_tags_JOB_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboDepartments" Name="departmenId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="CategoryId" DefaultValue="8" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment_USED_tags" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Department_USED_tags_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTagOfJob" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select Id, Tag from Jobs_tags where JobId=@jobId order by Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTag" runat="server" Visible="False"></asp:Label>
</asp:Content>

