<%@ Page Title="Messages Templates" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="messagestemplates.aspx.vb" Inherits="pasconcept20.messagestemplates" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function OnClientCommandExecuting(editor, args) {
            var name = args.get_name();
            var val = args.get_value();
            if (name == "Variables") {
                editor.pasteHtml(val);
                //Cancel the further execution of the command as such a command does not exist in the editor command list        
                args.set_cancel(true);
            }   
        }
    </script>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"  EnableEmbeddedSkins="false" />

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Messages Templates</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>

            <asp:LinkButton ID="btnRestore" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    Restore Defaults
            </asp:LinkButton>

        </span>
    </div>


    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
            AutoGenerateColumns="False" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowSorting="True"
            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"  OnItemDataBound="RadGrid1_ItemDataBound">
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>

                    <telerik:GridTemplateColumn  HeaderText="Edit" HeaderStyle-Width="50px"> 
                        <ItemTemplate> 
                            <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Edit Template"
                                CommandName="Edit" Visible='<%# Eval("isEditable") %>'>
                                <i class="far fa-edit"></i>
                            </asp:LinkButton>

                            <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="View Template"
                                CommandName="Edit" Visible='<%# iif(Eval("isEditable") = 0, True, False) %>'>
                                <i class="far fa-eye"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn> 


                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" ReadOnly="true" Display="false" SortExpression="Id" UniqueName="Id"
                        ItemStyle-Width="40px" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Description" HeaderText="Description" SortExpression="Description" ReadOnly="true"
                        UniqueName="Description" HeaderStyle-Width="300px" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Subject" FilterControlAltText="Filter Subject column" ItemStyle-HorizontalAlign="Left"
                        HeaderText="Subject" SortExpression="Subject" UniqueName="Subject" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="SubjetLabel" runat="server" Text='<%# Eval("Subject") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Body" Display="False" HeaderText="Body" ItemStyle-HorizontalAlign="Left"
                        SortExpression="Body" UniqueName="Body">
                        <ItemTemplate>
                            <asp:Label ID="BodyLabel" runat="server" Text='<%# Eval("Body") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="text-align: right; width: 220px;vertical-align: top;font-weight: bold;">Subject:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="SubjectTextBox" runat="server" Text='<%# Bind("Subject") %>'
                                        Width="800px" MaxLength="255" Enabled='<%# Eval("isEditable") %>'>
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;vertical-align: top;font-weight: bold;">Body:
                                </td>
                                <td>
                                     <telerik:RadEditor ID="GridEditorBody" runat="server" Content='<%# Bind("Body") %>'
                                        Height="400px" AllowScripts="True" RenderMode="Auto" ToolsFile="~/BasicTools.xml"
                                        Width="790px" OnClientCommandExecuting="OnClientCommandExecuting" Enabled='<%# Eval("isEditable") %>'>                                            
                                    </telerik:RadEditor>
                                    <br />
                                </td>
                            </tr>
                            
                            <tr>
                                <td></td>
                                <td>
                                    <asp:LinkButton ID="btnUpdate" CssClass="btn-success btn-lg" 
                                        Text="Update" runat="server" CommandName="Update" Visible='<%# Eval("isEditable") %>'></asp:LinkButton>
                                    &nbsp;&nbsp;
                                    <asp:LinkButton ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" CssClass="btn-secondary btn-lg" 
                                        CommandName="Cancel" Visible='<%# Eval("isEditable") %>'></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </FormTemplate>
                </EditFormSettings>
            </MasterTableView>
            <FilterMenu EnableImageSprites="False">
            </FilterMenu>
            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
            </HeaderContextMenu>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Messages_Templates] WHERE [Id] = @Id "
        SelectCommand="Messages_Templatet_Select" SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE [Messages_Templates] SET [Subject] = @Subject, [Body]=@Body WHERE [Id]=@Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="String" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"  Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Subject" Type="String" />
            <asp:Parameter Name="Body" Type="String" />
            <asp:Parameter Name="Id" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTemplateId" runat="server" Visible="False"></asp:Label>
</asp:Content>

