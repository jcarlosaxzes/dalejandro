<%@ Page Title="Export Clients" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="exportclientscsv.aspx.vb" Inherits="pasconcept20.exportclientscsv" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="600px" class="table-condensed">
        <tr>
            <td colspan="2">
                <br />
                CSV files are simple text files containing tabular data. Each field in the file is separated from the next by a comma. 
                <br />
                Most spreadsheets support this format, although you can create and edit CSV files with any text editor. Files in the CSV format end with the .csv suffix. 
                <br />
                <br />
                Both <b>QuickBooks</b> and <b>Microsoft Excel</b> can easily import and export files of this type<br />
            </td>
        </tr>
        <tr>
            <td width="120px">Filename:
            </td>
            <td>
                <telerik:RadTextBox ID="txtFileName" runat="server" LabelWidth="" Resize="None" Text="Clients.csv" Width="430px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>Separator char:
            </td>
            <td>
                <telerik:RadComboBox ID="cboSep" Runat="server" Culture="en-US" Width="120px">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="comma (,)" Value="," />
                        <telerik:RadComboBoxItem runat="server" Text="semicolon (;)" Value=";" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="right">
                <telerik:RadButton ID="btnOk" runat="server" Text="Export">
                </telerik:RadButton>
            </td>
        </tr>
    </table>
</asp:Content>

