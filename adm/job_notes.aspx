<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_notes.aspx.vb" Inherits="pasconcept20.job_notes" %>

<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">
        <div class="pasconcept-bar">
            <span class="pasconcept-pagetitle">Notes</span>
            <span style="float: right; vertical-align: middle;">
                 <asp:LinkButton ID="btnNewNote" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                            Add Note
                    </asp:LinkButton>
            </span>
        </div>

        <table class="table-sm" style="width: 100%">
            
            <tr>
                <td>
                    <telerik:RadGrid ID="RadGridNotes" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowAutomaticInserts="true"
                        AutoGenerateColumns="False" DataSourceID="SqlDataSourceNotes" GridLines="None">
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceNotes"
                            ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small" EditMode="PopUp">
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" HeaderText="Edit" HeaderStyle-Width="30px" UniqueName="EditCommandColumn">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" Display="False" HeaderText="ID"
                                    ReadOnly="True" SortExpression="Id" UniqueName="Id">
                                </telerik:GridBoundColumn>
                                <telerik:GridDateTimeColumn DataField="Date" DataFormatString="{0:MM/dd/yyyy}" FilterControlAltText="Filter Date column" ReadOnly="true"
                                    HeaderText="Date" SortExpression="Date" UniqueName="Date" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                </telerik:GridDateTimeColumn>
                                <telerik:GridTemplateColumn DataField="Note" HeaderText="Note" SortExpression="Note"
                                    UniqueName="Note" HeaderStyle-HorizontalAlign="Center">
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="NoteTextBox" runat="server" MaxLength="1024" Text='<%# Bind("Note") %>'
                                            TextMode="MultiLine" Rows="8" Width="350px">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="NoteLabel" runat="server" Text='<%# Eval("Note") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="NoteBy" HeaderText="NoteBy" SortExpression="NoteBy"
                                    UniqueName="NoteBy" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                                    <ItemTemplate>
                                        <asp:Label ID="NoteByLabel" runat="server" Text='<%# Eval("NoteBy") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this note?"
                                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                    UniqueName="DeleteColumn" HeaderText="Delete" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>

        </table>

        <div class="pasconcept-bar">
            <span class="pasconcept-pagetitle">Messages</span>
        </div>
    
                    <table style="width: 100%">
                        <tr>
                            <td class="PanelFilter">
                                <asp:Panel ID="pnlFindMessages" runat="server" DefaultButton="btnFindMessages">
                                    <table class="table-sm pasconcept-bar" style="width: 100%">
                                        <tr>
                                            <td style="width: 400px">
                                                <telerik:RadComboBox ID="cboTimeFrame" runat="server" AppendDataBoundItems="true" Width="100%">
                                                    <Items>
                                                        <telerik:RadComboBoxItem runat="server" Text="All Years" Value="1" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Last Year" Value="2" />
                                                        <telerik:RadComboBoxItem runat="server" Text="This Year" Value="3" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Last Quarter" Value="4" />
                                                        <telerik:RadComboBoxItem runat="server" Text="This Quarter" Value="5" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Last Month" Value="6" />
                                                        <telerik:RadComboBoxItem runat="server" Text="This Month" Value="7" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Last 30 Days" Value="8" Selected="true"/>
                                                        <telerik:RadComboBoxItem runat="server" Text="Last 15 Days" Value="9" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Last 7 Days" Value="10" Selected="true" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Last  Day" Value="11" />
                                                        <telerik:RadComboBoxItem runat="server" Text="ToDay" Value="12" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtFind" runat="server" EmptyMessage="Search From, To, Subject or Body..." Width="40%">
                                                </telerik:RadTextBox>
                                            </td>
                                            <td style="width: 150px; text-align: right">
                                                <asp:LinkButton ID="btnFindMessages" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" OnClick="btnFindMessages_Click">
                                                        <i class="fas fa-search"></i> Filter/Search
                                                </asp:LinkButton>

                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                    <telerik:RadGrid ID="RadGridMessages" runat="server" DataSourceID="SqlDataSourceMessages" AutoGenerateColumns="False" AllowSorting="True"
                        PageSize="50" AllowPaging="true" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small" >
                        <ClientSettings>
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                        </ClientSettings>
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceMessages" ShowFooter="True" ClientDataKeyNames="Id">
                            <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                            <Columns>
                                <telerik:GridTemplateColumn DataField="To" HeaderText="From/To/Date/Subject" SortExpression="To" UniqueName="To" HeaderStyle-Width="350px" ItemStyle-Width="150px" ItemStyle-Wrap="true" ItemStyle-VerticalAlign="Top">
                                    <ItemTemplate>
                                        <table class="table-sm" style="width: 100%; height:100px;">
                                            <tr>
                                                <td>
                                                    <b>From:</b> <%# Eval("From")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <b>To:</b> <%# Eval("To")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <%# Eval("Received")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <b><%# Eval("Subject")%></b>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Body" HeaderText="Body" SortExpression="Body" UniqueName="Body" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                

    </div>
    <asp:SqlDataSource ID="SqlDataSourceNotes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Jobs_notes] WHERE [Id] = @Id"
        SelectCommand="SELECT [Jobs_notes].Id, JobId, Date, Note, Employees.Name as NoteBy FROM [Jobs_notes] left outer join Employees on [Jobs_notes].employeeId=Employees.Id WHERE ([JobId] = @Job) ORDER BY [Jobs_notes].[Id] desc"
        UpdateCommand="UPDATE [Jobs_notes] SET  [Note] = @Note WHERE [Id] = @Id"
        InsertCommand="INSERT INTO Jobs_notes([JobId],[Date],[Note], [employeeId]) VALUES(@JobId, dbo.CurrentTime(),'', @employeeId)">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Note" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" />
            <asp:Parameter Name="Note" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" DefaultValue="0" Name="Job" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceMessages" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Messages_v20_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" PropertyName="Text" Name="Filter" Type="String" ConvertEmptyStringToNull="False" />
            <asp:Parameter Name="clientId" DefaultValue="0" Type="Int32" /> 
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboTimeFrame" Name="TimeFrameId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

