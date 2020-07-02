<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="messagestemplates.aspx.vb" Inherits="pasconcept20.messagestemplates1" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td width="100%">
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" 
                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" 
                    AutoGenerateColumns="False" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowSorting="True" >
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderText="Edit" HeaderStyle-Width="50px">
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn DataField="Id" HeaderText="Id" ReadOnly="true" HeaderStyle-Width="50px"
                                SortExpression="Id" UniqueName="Id" >
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Type" HeaderText="Message Type" SortExpression="Type" ReadOnly="true" UniqueName="Type" >
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="Subject" FilterControlAltText="Filter Subject column" HeaderText="Subject" SortExpression="Subject" UniqueName="Subject">
                                <EditItemTemplate>
                                    <telerik:RadTextBox ID="SubjectTextBox" runat="server" Text='<%# Bind("Subject") %>'
                                        Width="800px" MaxLength="255">
                                    </telerik:RadTextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%# Eval("Subject") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Body" Display="False" HeaderText="Body" SortExpression="Body" UniqueName="Body">
                                <ItemTemplate>
                                    <%# Eval("Body") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadEditor ID="gridEditor_Body" runat="server" Content='<%# Bind("Body") %>' RenderMode="Auto" Height="300px" ToolsFile="~/BasicTools.xml" AllowScripts="True" EditModes="Design"
                                        Width="800px">
                                    </telerik:RadEditor>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                           <%-- <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" AllowFiltering="False" ItemStyle-HorizontalAlign="Center" 
                                HeaderStyle-Width="32px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnApply" runat="server" CommandName="ApplyToAllCompanies" CommandArgument='<%# Eval("Type") %>'
                                        ToolTip="Apply to all existing companies">
                                                <span style="color:red" class="fas fa-check"></span>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>--%>
                        </Columns>
                        <EditFormSettings CaptionDataField="Type" CaptionFormatString="Edit {0}" EditColumn-HeaderStyle-VerticalAlign="Top">
                            <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                            <FormMainTableStyle GridLines="None" CellSpacing="0" CellPadding="3" BackColor="White"
                                Width="100%" />
                            <FormTableStyle CellSpacing="0" CellPadding="2" BackColor="White" />
                            <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                            <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1"
                                CancelText="Cancel">
                            </EditColumn>
                            
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM Messages_TemplatesTEMPLATE ORDER BY Id"
        UpdateCommand="UPDATE [Messages_TemplatesTEMPLATE] SET [Subject] = @Subject, [Body]=@Body WHERE [Id]=@Id" 
        InsertCommand="Messages_TemplatetYPE_UPDATEallcOMPANIES" InsertCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="Subject" Type="String" />
            <asp:Parameter Name="Body" Type="String" />
            <asp:Parameter Name="Id" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblSelectedType" Name="Type" PropertyName="Text"  />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblSelectedType" runat="server" Visible="false" Text=""></asp:Label>
</asp:Content>

