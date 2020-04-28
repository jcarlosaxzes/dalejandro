<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.Master" CodeBehind="ticket.aspx.vb" Inherits="pasconcept20.ticket1" %>

<%@ MasterType VirtualPath="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.master" %>

<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .glyphicon.glyphicon-share {
            font-size: 32px;
        }
    </style>
    <div class="main-content">
        <table>
            <tr>
                <td>
                    <h2 style="margin: 0; text-align: center">
                        <asp:Label ID="lblJob" runat="server"></asp:Label>
                    </h2>
                </td>
                <td style="text-align: center;width:100px">
                    <a runat="server" id="urlPublicLink" class="glyphicon glyphicon-share" title="Click to View Ticket List" href='<%# GetJobGUID() %>'
                        target="_blank" aria-hidden="true"></a>
                </td>
            </tr>
        </table>




        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%">
            <ItemTemplate>
                <table class="table-condensed" style="width: 100%; text-align: left">
                    <tr>
                        <td style="width: 180px">Ticket #:
                        </td>
                        <td>
                            <asp:Label ID="lblID" runat="server" Text='<%# Eval("Id") %>' Font-Bold="true" Font-Size="Large"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Location/Module:
                        </td>
                        <td>
                            <%# Eval("AppName") %>
                        </td>
                    </tr>
                    <tr>
                        <td>App. Name:
                        </td>
                        <td>
                            <%# Eval("Id") %>
                        </td>
                    </tr>


                    <tr>
                        <td>Title:
                        </td>
                        <td>
                            <%# Eval("Title") %>
                        </td>
                    </tr>
                    <tr>
                        <td>Client Description:
                        </td>
                        <td>
                            <%# Eval("ClientDescription") %>
                        </td>
                    </tr>
                    <tr>
                        <td>Company Description:
                        </td>
                        <td>
                            <%# Eval("CompanyDescription") %>
                        </td>
                    </tr>
                    <tr>
                        <td>Type:
                        </td>
                        <td>
                            <span class="<%# LocalAPI.GetTickectTypeLabelCSS(Eval("Type")) %>"><%# Eval("Type") %></span>
                        </td>
                    </tr>

                    <tr>
                        <td>Priority:
                        </td>
                        <td>
                            <%# Eval("Priority") %>
                        </td>
                    </tr>

                    <tr>
                        <td>Status:
                        </td>
                        <td>
                            <span class="<%# LocalAPI.GetTickectStatusLabelCSS(Eval("Status")) %>"><%# Eval("Status") %></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Expected Start Date:
                        </td>
                        <td>
                            <%# Eval("ExpectedStartDate") %>
                        </td>
                    </tr>
                    <tr>
                        <td>Client Approved Status:
                        </td>
                        <td>
                            <span class="<%# LocalAPI.GetTickectApprovedStatusLabelCSS(Eval("ApprovedStatus")) %>"><%# Eval("ApprovedStatus") %></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Expected Staging Date:
                        </td>
                        <td>
                            <%# Eval("StagingDate") %>
                        </td>
                    </tr>
                    <tr>
                        <td>Expected Production Date:
                        </td>
                        <td>
                            <%# Eval("ProductionDate") %>
                        </td>
                    </tr>
                    <tr>
                        <td>Client Feedback:
                        </td>
                        <td>
                            <%# Eval("Notes") %>
                        </td>
                    </tr>

                    <tr>
                        <td>Business Client Name:
                        </td>
                        <td>
                            <%# Eval("NotificationClientName") %>
                        </td>
                    </tr>
                    <tr>
                        <td>Client Emails to be notified:
                        </td>
                        <td>
                            <%# Eval("NotificationClientEmail") %>
                        </td>
                    </tr>

                    <tr>
                        <td>Trello URL
                        </td>
                        <td>
                            <a href='<%# Eval("trelloURL") %>' target="_blank">Click to view</a> Trello Card
                        </td>
                    </tr>
                    <tr>
                        <td>Jira URL
                        </td>
                        <td>
                            <a href='<%# Eval("jiraURL") %>' target="_blank">Click to view </a>Jira Card
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <asp:LinkButton runat="server" ID="btnEdit" CssClass="btn btn-success btn-lg" ToolTip="Edit Ticket" CommandName="Edit"
                                Visible='<%#LocalAPI.IsTicketEditable(Eval("Status")) %>'>
                                Edit Ticket
                            </asp:LinkButton>
                        </td>
                    </tr>


                </table>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                    Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true"
                    ValidationGroup="EditTicket" />


                <table class="table-condensed" style="width: 100%; text-align: left">

                    <tr>
                        <td style="text-align: right">Priority:
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="cboPriorityEdit" runat="server" AppendDataBoundItems="true" Width="350px"
                                SelectedText='<%# Bind("Priority") %>'>
                                <Items>
                                    <telerik:DropDownListItem Text="Low" />
                                    <telerik:DropDownListItem Text="Medium" />
                                    <telerik:DropDownListItem Text="High" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align: right">Client Approved Status:</td>
                        <td>
                            <telerik:RadDropDownList ID="cboApprovedStatus" runat="server" AppendDataBoundItems="true" Width="350px" ZIndex="50001"
                                SelectedText='<%# Bind("ApprovedStatus") %>'>
                                <Items>
                                    <telerik:DropDownListItem Text="Pending" Selected="true" />
                                    <telerik:DropDownListItem Text="Approved" />
                                    <telerik:DropDownListItem Text="Rejected" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Client Feedback:</td>
                        <td>
                            <telerik:RadTextBox ID="txtNotes" runat="server" Rows="3" TextMode="MultiLine" Width="100%" ToolTip="Notes"
                                Text='<%# Bind("Notes") %>'>
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Business Client Name:</td>
                        <td>
                            <telerik:RadTextBox ID="txtNotificationClientName" runat="server" MaxLength="80" Width="100%" ToolTip="Notification Client Name"
                                Text='<%# Bind("NotificationClientName") %>'>
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Client Emails to be notified:</td>
                        <td>
                            <telerik:RadTextBox ID="txtNotificationClientEmail" runat="server" MaxLength="128" Width="100%" ToolTip="Notification Client Email"
                                Text='<%# Bind("NotificationClientEmail") %>'>
                            </telerik:RadTextBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align: right">Trello URL:</td>
                        <td>
                            <telerik:RadTextBox ID="txttrelloURL" runat="server" MaxLength="128" Width="100%" ToolTip="Link to Trello Card"
                                Text='<%# Bind("trelloURL") %>'>
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Jira URL:</td>
                        <td>
                            <telerik:RadTextBox ID="txtJiraURL" runat="server" MaxLength="128" Width="100%" ToolTip="Link to Jira Card"
                                Text='<%# Bind("jiraURL") %>'>
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                </table>

                <br />
                <table style="width: 100%">
                    <tr>
                        <td style="text-align: center">
                            <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-info btn-lg" UseSubmitBehavior="false" Width="150px" CommandName="Update" CausesValidation="true" ValidationGroup="EditTicket">
                                Update Ticket
                            </asp:LinkButton>

                            &nbsp;&nbsp;&nbsp;
                             <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-default btn-lg" UseSubmitBehavior="false" Width="150px" CommandName="Cancel" CausesValidation="false">
                                Cancel
                             </asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMsg" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>


            </EditItemTemplate>
        </asp:FormView>



    </div>

    <%-- <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    </telerik:RadWindowManager>--%>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Jobs_ticket_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Jobs_ticket_by_client_UPDATE" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="Notes" />
            <asp:Parameter Name="Priority" />
            <asp:Parameter Name="ApprovedStatus" />
            <asp:Parameter Name="NotificationClientName" />
            <asp:Parameter Name="NotificationClientEmail" />
            <asp:Parameter Name="trelloURL" />
            <asp:Parameter Name="jiraURL" />

            <asp:ControlParameter ControlID="lblTicketId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblTicketId" Name="Id" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblTicketId" runat="server" Text="0" Visible="false"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lbljobGUID" runat="server" Text="0" Visible="False"></asp:Label>


</asp:Content>

