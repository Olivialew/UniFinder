<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UniversityDetail.aspx.cs" Inherits="UniFinder.UniversityDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style27 {
            width: 866px;
        }
        .auto-style29 {
            width: 1114px;
        }
        .auto-style30 {
            width: 801px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="SummaryHeader">
        <asp:Image ID="imgUniversityLogo" runat="server" Height="180px" Width="180px" />
    </div>
    <div class="SummaryContent">
        <table>
            <tr>
                <td class="auto-style29">
                    <table>
                        <tr>
                            <td class="auto-style35" colspan="2"><strong>University (English):<br />
                                <asp:Label ID="lblUniNameEng" runat="server"></asp:Label>
                            </strong></td>
                        </tr>
                        <tr>
                            <td class="auto-style35" colspan="2"><strong>University (Malay):<br />
                                <asp:Label ID="lblUniNameMalay" runat="server"></asp:Label>
                            </strong></td>
                        </tr>
                        <tr>
                            <td class="auto-style35" colspan="2"><strong>Acronym:<br />
                                <asp:Label ID="lblUniAcronym" runat="server"></asp:Label>
                            </strong></td>
                        </tr>
                        <tr>
                            <td class="auto-style35" colspan="2"><strong>Foundation Year:<br />
                                <asp:Label ID="lblFoundationYear" runat="server"></asp:Label>
                            </strong></td>
                        </tr>
                        <tr>
                            <td class="auto-style35" colspan="2"><strong>Type:<br />
                                <asp:Label ID="lblUniType" runat="server"></asp:Label>
                            </strong></td>
                        </tr>
                        <tr>
                            <td class="auto-style38" colspan="2">
                                <asp:Literal ID="ltCampusTour" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style38" colspan="2">
                                <asp:Literal ID="ltYouTubeVideo" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style38" colspan="2">
                                <asp:Literal ID="ltGoogleMaps" runat="server"></asp:Literal>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>

</asp:Content>
