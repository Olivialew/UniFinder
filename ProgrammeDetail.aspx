<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ProgrammeDetail.aspx.cs" Inherits="UniFinder.ProgrammeDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style29 {
            width: 100%; /* Adjust to fit the parent element */
            max-width: 1114px; /* Ensure it does not exceed this width */
            box-sizing: border-box; /* Include padding and border in the element's total width and height */
        }

        .auto-style31, .auto-style32 {
            width: auto; /* Adjust based on content */
        }

        .auto-style38 {
            color: white;
            width: 100%; /* Full width of its parent */
            box-sizing: border-box; /* Include padding and border in the element's total width and height */
            padding: 10px;
            background-color: #fff; /* Background color of the section */
        }

        .imgUniversityLogo {
            max-width: 100%; /* Ensure image fits within its container */
            max-height: 100%; /* Ensure image fits within its container */
            object-fit: contain; /* Maintain aspect ratio */
        }

        .SummaryHeader {
            display: flex;
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
            width: 300px; /* Adjust width as needed */
            height: 300px; /* Adjust height as needed */
            margin: auto; /* Center the container horizontally */
        }

        .compare-btn {
            padding: 8px 25px;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background-color: #009999;
            border: none;
            border-radius: 8px;
            color: ghostwhite;
            font-size: 16px;
            font-weight: 400;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .compare-btn.greyed-out {
            background-color: #A9A9A9; /* Greyed out color */
            cursor: not-allowed;
        }

        .link-style {
            display: block;
            width: 100%;
            text-align: center;
            padding: 10px 0;
            color: blue; /* Adjust color to match your design */
            text-decoration: none; /* Remove underline */
            transition: color 0.3s ease; /* Smooth color transition */
        }

        .link-style:hover {
            color: darkblue; /* Color on hover */
        }

        table {
            width: 100%; /* Ensure table fits its container */
            border-collapse: collapse; /* Collapse borders for cleaner appearance */
        }

        td {
            padding: 8px; /* Adjust padding as needed */
            border: 1px solid #ddd; /* Add border for clarity */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="SummaryHeader">
        <asp:Image ID="imgUniversityLogo" runat="server" CssClass="imgUniversityLogo" Height="180px" Width="180px" />
        <asp:HiddenField ID="compareListHiddenField" runat="server" />
    </div>
    <div class="SummaryContent">
        <table>
            <tr>
                <td class="auto-style29">
                    <table>
                        <tr>
                            <td class="auto-style31"><strong>Programme:</strong></td>
                            <td class="auto-style32">
                                <asp:Label ID="lblProgramName" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style31">&nbsp;</td>
                            <td class="auto-style32">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style31"><strong>University:</strong></td>
                            <td class="auto-style32">
                                <asp:Label ID="lblUniversity" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style31">&nbsp;</td>
                            <td class="auto-style32">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style31"><strong>Location:</strong></td>
                            <td class="auto-style32">
                                <asp:Label ID="lblLocation" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style31">&nbsp;</td>
                            <td class="auto-style32">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style31"><strong>Introduction:</strong></td>
                            <td class="auto-style32">
                                <asp:Label ID="lblProgrammeIntro" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style31">&nbsp;</td>
                            <td class="auto-style32">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style31"><strong>Contact:</strong></td>
                            <td class="auto-style32">
                                <asp:Label ID="lblProgrammeContact" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style31">&nbsp;</td>
                            <td class="auto-style32">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style31"><strong>Duration:</strong></td>
                            <td class="auto-style32">
                                <asp:Label ID="lblProgrammeDuration" runat="server"></asp:Label> years<br />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style31">&nbsp;</td>
                            <td class="auto-style32">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style31"><strong>Tuition Fees (Local):</strong></td>
                            <td class="auto-style32">
                                RM <asp:Label ID="lblTuitionFee" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style38" colspan="2">
                                <strong>
                                    <asp:HyperLink ID="hlProgramLink" runat="server" CssClass="link-style">Click Here to go to Official Program Page</asp:HyperLink>
                                    <br />
                                    <asp:HyperLink ID="hlFacLink" runat="server" CssClass="link-style">Click Here to go to Official Faculty Page</asp:HyperLink>
                                </strong>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style38" colspan="2">
                                <div style="text-align: center;">
                                    <!-- Center the button -->
                                    <asp:Button ID="btnAddToCompare" runat="server" CommandArgument='<%# Eval("programID") %>' CommandName="AddToCompare" CssClass="compare-btn" OnClick="AddToCompareButton_Click" Text="Add to Compare" />
                                </div>
                                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="comparison-table"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>
</asp:Content>
