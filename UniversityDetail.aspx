<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UniversityDetail.aspx.cs" Inherits="UniFinder.UniversityDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style29 {
            width: 1114px;
        }

        .auto-style30 {
            width: 412px;
        }

        .auto-style31 {
            width: 212px;
        }

        .auto-style32 {
            width: 20px;
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
                            <td class="auto-style31"><strong>University (English)</strong></td>
                            <td class="auto-style32">:</td>
                            <td class="auto-style30">
                                <asp:Label ID="lblUniNameEng" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style31"><strong>University (Malay)</strong></td>
                            <td class="auto-style32">:</td>
                            <td class="auto-style30">
                                <asp:Label ID="lblUniNameMalay" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style31"><strong>Acronym</strong></td>
                            <td class="auto-style32">:</td>
                            <td class="auto-style30">
                                <asp:Label ID="lblUniAcronym" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style31"><strong>Foundation Year</strong></td>
                            <td class="auto-style32">:</td>
                            <td class="auto-style30">
                                <asp:Label ID="lblFoundationYear" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style31"><strong>Type</strong></td>
                            <td class="auto-style32">:</td>
                            <td class="auto-style30">
                                <asp:Label ID="lblUniType" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style38" colspan="3">
                                <strong>Campus Tour:</strong><br />
                                <asp:Literal ID="ltCampusTour" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style38" colspan="3">
                                <strong>YouTube Intoduction:</strong><br />
                                <asp:Literal ID="ltYouTubeVideo" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style38" colspan="3">
                                <strong>Google Maps Location:</strong><br />
                                <asp:Literal ID="ltGoogleMaps" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <%-- <tr>
                            <td class="auto-style31">
<%--                                <asp:Literal ID="LiteralMainUniversity" runat="server"></asp:Literal>--%>
                        <%--  </td>
                            <td class="auto-style32">
                                &nbsp;</td>
                            <td class="auto-style30">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style31">
                                <strong>Branches</strong></td>
                            <td class="auto-style32">
                                :</td>
                            <td class="auto-style30">
                                <asp:Literal ID="LiteralBranches" runat="server"></asp:Literal>
                            </td>
                        </tr>--%>
                    </table>
                    <td>&nbsp;</td>
        </table>
    </div>

</asp:Content>
