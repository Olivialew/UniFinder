<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UniversityDetail.aspx.cs" Inherits="UniFinder.UniversityDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style29 {
            width: 100%; /* Adjust width to fit the parent */
        }

        .auto-style30 {
            width: auto; /* Adjust based on content */
        }

        .auto-style31 {
            width: auto; /* Adjust based on content */
        }

        .auto-style32 {
            width: auto; /* Adjust based on content */
        }

        .auto-style38 {
            width: 100%; /* Ensure this row spans the full width */
        }

        .SummaryHeader {
            text-align: center;
        }

        table {
            width: 100%; /* Ensure table takes up the full width of its parent */
            border-collapse: collapse; /* Optional: For better border handling */
        }

        td {
            padding: 8px; /* Optional: Adjust padding as needed */
            border: 1px solid #ddd; /* Optional: Add border for clarity */
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
                                <strong>YouTube Introduction:</strong><br />
                                <asp:Literal ID="ltYouTubeVideo" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style38" colspan="3">
                                <strong>Google Maps Location:</strong><br />
                                <asp:Literal ID="ltGoogleMaps" runat="server"></asp:Literal>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
