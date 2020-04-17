<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_notes.aspx.vb" Inherits="pasconcept20.job_notes" %>

<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">
        <div class="row">
            <div class="form-group">
                <asp:LinkButton ID="btnNewNote" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false">
             <span class="glyphicon glyphicon-plus"></span> Note
                </asp:LinkButton>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
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
            </div>
        </div>
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

    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

