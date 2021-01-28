<%@ Page Title="Opening and Closing Text" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterPROPOSAL.Master" CodeBehind="pro_openingclosing.aspx.vb" Inherits="pasconcept20.pro_openingclosing" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/adm/MasterPROPOSAL.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">Opening and Closing Text</span>
        <span style="float: right; vertical-align: middle;">
            <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ToolTip="Update">
                Update
            </asp:LinkButton>
        </span>
    </div>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DefaultMode="Edit" DataSourceID="SqlDataSource1" Width="100%" EnableViewState="false">
        <EditItemTemplate>
            <table class="table-sm" style="width: 100%;">
                <tr>
                    <td>
                        <h4>Opening Text</h4>
                        <telerik:RadEditor ID="radEditorBegin" runat="server" Content='<%# Bind("TextBegin") %>'
                            Height="350px" ToolsFile="~/BasicTools.xml" AllowScripts="True" EditModes="Design,Preview" RenderMode="Auto"
                            Width="100%">
                        </telerik:RadEditor>
                    </td>
                </tr>
                <tr>
                    <td>
                        <h4>Closing Text</h4>
                        <telerik:RadEditor ID="radEditorEnd" runat="server" Content='<%# Bind("TextEnd") %>'
                            Height="350px" ToolsFile="~/BasicTools.xml" AllowScripts="True" EditModes="Design,Preview" RenderMode="Auto"
                            Width="100%">
                        </telerik:RadEditor>
                    </td>
                </tr>
                <tr>
                    <td>
                        <h4>Additional Link with more info:</h4>
                        <telerik:RadTextBox ID="RadTextBox1" runat="server" Text='<%# Bind("Link") %>' Width="100%" MaxLength="150">
                        </telerik:RadTextBox>
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select Id, TextBegin, TextEnd, Link from Proposal where Id=@Id"
        UpdateCommand="update Proposal set TextBegin=@TextBegin, TextEnd=@TextEnd, Link=@Link where Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="TextBegin" />
            <asp:Parameter Name="TextEnd" />
            <asp:Parameter Name="Link" />
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
</asp:Content>
