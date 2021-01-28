<%@ Page Title="Notes" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterPROPOSAL.Master" CodeBehind="pro_notes.aspx.vb" Inherits="pasconcept20.pro_notes" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/adm/MasterPROPOSAL.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">Notes</span>
        <span style="float: right; vertical-align: middle;">
            <asp:LinkButton ID="btnNewNote" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ToolTip="Add New Note for Proposal">
                Add Note
            </asp:LinkButton>
        </span>
    </div>
    <div>
        <telerik:RadGrid ID="RadGridNotes" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowAutomaticInserts="true"
            AutoGenerateColumns="False" DataSourceID="SqlDataSourceNotes" HeaderStyle-HorizontalAlign="Center">
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceNotes" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" HeaderText="" HeaderStyle-Width="50px" UniqueName="EditCommandColumn">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" Display="False" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn DataField="Date" DataFormatString="{0:MM/dd/yyyy}" ReadOnly="true" HeaderText="Date" SortExpression="Date" UniqueName="Date" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridTemplateColumn DataField="Note" HeaderText="Note" SortExpression="Note"
                        UniqueName="Note">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="NoteTextBox" runat="server" MaxLength="1024" Text='<%# Bind("Note") %>'
                                TextMode="MultiLine" Rows="8" Width="800px">
                            </telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("Note") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="NoteBy" HeaderText="Note By" SortExpression="NoteBy" UniqueName="NoteBy" ReadOnly="true">
                        <ItemTemplate>
                            <asp:Label ID="NoteByLabel" runat="server" Text='<%# Eval("NoteBy") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this note?"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn" HeaderText="" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn ButtonType="PushButton">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceNotes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Proposal_notes] WHERE [Id] = @Id"
        SelectCommand="SELECT [Proposal_notes].Id, ProposalId, Date, Note, Employees.Name as NoteBy FROM [Proposal_notes] left outer join Employees on [Proposal_notes].employeeId=Employees.Id WHERE ([ProposalId] = @ProposalId) ORDER BY [Proposal_notes].[Id] desc"
        UpdateCommand="UPDATE [Proposal_notes] SET  [Note] = @Note WHERE [Id] = @Id"
        InsertCommand="INSERT INTO Proposal_notes([ProposalId],[Date],[Note], [employeeId]) VALUES(@ProposalId, dbo.CurrentTime(),@Note, @employeeId)">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Note" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" />
            <asp:Parameter Name="Note" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" DefaultValue="0" Name="ProposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
</asp:Content>
