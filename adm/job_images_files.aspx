<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_images_files.aspx.vb" Inherits="pasconcept20.Job_images_files" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">
        <div class="row">
            <div class="form-group">
                <asp:Image ID="imgGoogleStreetview" runat="server" ImageUrl='<%# LocalAPI.GetJobStreeViewImage(lblJobId.Text, "1024x768") %>'  />
            </div>

        </div>


        <h3 style="margin: 0px 0px 5px 0px">Other Images</h3>
        <div class="row">
            <div class="form-group">
                <div class="BorderZone">
                    <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="SqlDataSourceFotos" DataKeyNames="Id" ItemPlaceholderID="Container1"
                        BorderStyle="Solid">
                        <LayoutTemplate>
                            <fieldset style="width: 100%">
                                <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                            </fieldset>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <fieldset style="float: left; width: 220px;">
                                <table class="table-condensed">
                                    <tr>
                                        <td style="text-align: center; width: 200px">

                                            <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" AlternateText="Job Photo"
                                                Width="200px" Height="230px" ResizeMode="Fit" ImageUrl='<%# Eval("Photo")%>'></telerik:RadBinaryImage>


                                        </td>
                                    </tr>
                                    <%--<tr>
                                        <td style="text-align: right">
                                            <asp:Button ID="lnkZoom" runat="server" CommandName="Select" Text="Zoom"></asp:Button>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <asp:Button ID="btnDelFoto2" runat="server" CommandName="Delete" OnClientClick="if(!confirm('Are you sure you want to delete this photo?')) return false;"
                                                                        Text="Delete"></asp:Button>
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td>
                                            <table style="width:100%">
                                                <tr>
                                                    <td style="text-align: center">
                                                        <%#Eval("OriginalFileName")%>
                                                    </td>
                                                    <td style="width:10px">
                                                        <asp:LinkButton ID="btnDelFoto" runat="server" UseSubmitBehavior="false" ToolTip="Delete Image" width="100%" 
                                                            CausesValidation="false" CommandName="Delete" CssClass="btn btn-danger"
                                                            OnClientClick="if(!confirm('Are you sure you want to delete this photo?')) return false;"> x
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </ItemTemplate>
                    </telerik:RadListView>
                </div>

            </div>
        </div>
        <div class="row">
            <div class="form-group">

                <table class="table-condensed">
                    <tr>
                        <td>
                            <telerik:RadCloudUpload ID="RadCloudUploadOthers" runat="server" MultipleFileSelection="Automatic" CssClass="BorderZone"
                                ProviderType="Azure"
                                MaxFileSize="10145728" Width="200px"
                                AllowedFileExtensions=".png,.jpg,.jpeg">
                                <FileListPanelSettings PanelContainerSelector="#fileList" Height="100px" MaxHeight="180px" RenderButtonText="true" ShowEmptyFileListPanel="false" />
                            </telerik:RadCloudUpload>

                        </td>
                        <td>
                            <asp:LinkButton ID="btnSaveOthers" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Upload and Save selected image" CausesValidation="false">
                                 Upload
                            </asp:LinkButton>

                        </td>
                    </tr>
                    <tr>
                        <td style="width: 270px">
                            <div id="fileList">
                            </div>
                        </td>

                    </tr>

                </table>
            </div>
        </div>
    </div>
    <br />
    <asp:SqlDataSource ID="SqlDataSourceFotos" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOB_Photos_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="UPDATE Jobs_azureuploads SET Deleted=1 WHERE (Id = @Id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" DefaultValue="0" Name="JobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
