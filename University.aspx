<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="University.aspx.cs" Inherits="UniFinder.University" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="script1.js" defer></script>
    <style type="text/css">
        .header {
            text-align: center;
            font-size: 20px;
        }

        .content {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap; /* Allow items to wrap if necessary */
            color: white;
            padding: 20px; /* Optional padding for spacing */
            box-sizing: border-box; /* Include padding in width/height */
        }

        .mainSide {
            flex: 1 1 auto; /* Allow it to grow and shrink based on content */
            padding: 10px;
            max-width: 100%; /* Ensure it does not exceed container width */
            box-sizing: border-box; /* Include padding in element's width */
        }

        .rightSide {
            flex: 0 0 300px; /* Fixed width for the right side */
            padding: 10px; /* Adjust padding as needed */
            border: 4px double gold;
            border-radius: 5%;
            box-sizing: border-box; /* Include padding in width/height */
        }

        .buttons button {
            padding: 8px 25px;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background-color: #009999;
            border: none;
            border-radius: 8px;
            color: ghostwhite;
            font-size: 16px;
            font-weight: 400;
            cursor: pointer;
        }

        .panel-class {
            display: none;
            max-width: 1000px;
            margin-top: 20px;
            align-content: center;
        }

        .uniImgContainer {
            width: 300px;
            height: 300px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .uniLogo {
            width: 80%;
            height: 80%;
            object-fit: contain; /* Ensure the image fits within the container without distortion */
        }

        .uniName {
            color: #242424;
            text-align: center; /* Center-align text */
        }

        .auto-style37 {
            font-size: xx-large;
            color: #000000;
        }

        .search-box {
            width: 300px;
        }

        .search-btn {
            margin-left: 10px;
        }

        .auto-style38, .auto-style39 {
            display: none; /* Hide unused styles */
            max-width: 1000px;
            margin-top: 20px;
            align-content: center;
            color: #000000;
        }

        .program-item {
            display: flex;
            flex-direction: column;
            align-items: center; /* Center items horizontally */
            flex: 1 1 calc(25% - 20px); /* Adjust width to fit multiple items per row */
            padding: 10px;
            margin: 10px;
            box-sizing: border-box; /* Include padding in element's width */
        }

            .program-item .btnAddToCompare {
                padding: 10px 20px;
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background-color: #005f5f;
                border: none;
                border-radius: 5px;
                color: white;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                text-align: center;
                margin-top: 10px; /* Adds space between the button and the content above */
                transition: background-color 0.3s ease; /* Smooth transition for hover effect */
            }

                .program-item .btnAddToCompare:hover {
                    background-color: #009999; /* Change background on hover */
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

        .auto-style37 {
            font-size: xx-large;
            color: #000000;
        }

        .search-box {
            width: 300px;
        }

        .search-btn {
            margin-left: 10px;
        }

        .auto-style40 {
            color: black;
        }

        .auto-style41 {
            flex: 1 1 auto; /* Allow it to grow and shrink based on content */
            ;
            padding: 10px;
            max-width: 100%; /* Ensure it does not exceed container width */
            ;
            box-sizing: border-box;
            width: 1413px;
        }

        .auto-style42 {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            color: white;
            box-sizing: border-box;
            width: 98%;
            padding: 10px;
            background-color: #fff;
        }

        .auto-style43 {
            width: 177px;
        }

        .auto-style44 {
            width: 177px;
            color: black;
        }

        .apply-filters-container {
            background-color: #dae7f0;
            padding: 10px;
            width: 100%;
        }

        .auto-style45 {
            width: 32px;
        }

        .auto-style46 {
            width: 32px;
            color: black;
        }

        .auto-style47 {
            color: red;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bigContainer" style="background-color: #FFFFFF">
        <div class="header">
            <h3 class="auto-style37">University</h3>
        </div>
        <div class="auto-style42">
            <div class="auto-style41">
                <strong>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Branch]"></asp:SqlDataSource>
                </strong><span class="auto-style39">
                    <br />
                </span>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="auto-style39"></asp:Label>
                <br class="auto-style39" />

                <div class="apply-filters-container">
                    <table style="width: 100%;">
                        <tr>
                            <td class="auto-style43">
                                <span class="auto-style40"><strong>S</strong></span><span class="auto-style39"><strong>Search by:</strong></span><span class="auto-style40"><strong>earch by:</strong></span></td>
                            <td class="auto-style45">&nbsp;</td>
                            <td>
                                <asp:TextBox ID="txtSearch" runat="server" placeholder="Enter University Name" CssClass="search-box"></asp:TextBox>

                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style43">&nbsp;</td>
                            <td class="auto-style45">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style43">
                                <strong>
                                    <span class="auto-style40">Filter by:</span></strong></td>
                            <td class="auto-style45">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style44"><strong>University Type</strong></td>
                            <td class="auto-style46"><strong>:</strong></td>
                            <td>
                                <strong>
                                    <asp:DropDownList ID="ddlUniType" runat="server">
<%--                                        <asp:ListItem>&lt;-- Select University Type --&gt;</asp:ListItem>--%>
                                        <asp:ListItem>Research university</asp:ListItem>
                                        <asp:ListItem>International university</asp:ListItem>
                                        <asp:ListItem>Focused university</asp:ListItem>
                                        <asp:ListItem>Technical university</asp:ListItem>
                                        <asp:ListItem>Comprehensive university</asp:ListItem>
                                        <asp:ListItem>Islamic university</asp:ListItem>
                                        <asp:ListItem>Premier polytechnic (university status)</asp:ListItem>
                                        <asp:ListItem>Conventional polytechnic</asp:ListItem>
                                        <asp:ListItem>METrO polytechnic</asp:ListItem>
                                        <asp:ListItem>Private university</asp:ListItem>
                                        <asp:ListItem>Private university college</asp:ListItem>
                                        <asp:ListItem>Others</asp:ListItem>
                                    </asp:DropDownList>
                                </strong>

                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style44"><strong>Branch</strong></td>
                            <td class="auto-style46"><strong>:</strong></td>
                            <td>
                                <strong>
                                    <%-- <asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="SqlDataSource2" DataTextField="location" DataValueField="location">
                                    </asp:DropDownList>--%>
                                    <asp:DropDownList ID="ddlLocation" runat="server">
                                    </asp:DropDownList>
                                </strong>

                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style43">&nbsp;</td>
                            <td class="auto-style45">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:Label ID="lblNoResults" runat="server" CssClass="auto-style47"></asp:Label>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <strong>
                                    <div style="text-align: center">
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="button" OnClick="btnSearch_Click" />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="button" OnClick="btnReset_Click" />
                                    </div>
                                </strong>

                            </td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </div>

                <div class="panel">
                    <asp:Panel ID="pnlStep1" runat="server" CssClass="auto-style38" ClientIDMode="Static" Style="display: block" Width="1413px">
                        <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" RepeatColumns="4" Height="460px">
                            <ItemTemplate>
                                <div class="program-item">
                                    <div class="uniImgContainer">
                                        <asp:ImageButton
                                            ID="imgUni"
                                            runat="server"
                                            ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>'
                                            AlternateText='<%# GetUniName(Eval("uniNameEng"), Eval("uniNameMalay")) %>'
                                            CssClass="uniLogo"
                                            Style="max-height: 300px; max-width: 300px; margin-right: 50px; margin-left: 20px; margin-top: 10px"
                                            OnClick="imgBtnSelectUni"
                                            data-unieng='<%# Eval("uniNameEng") %>'
                                            data-unimalay='<%# Eval("uniNameMalay") %>' />
                                    </div>
                                    <div class="uniName">
                                        <strong>
                                            <asp:Label
                                                ID="lblUniName"
                                                runat="server"
                                                Text='<%# GetUniName(Eval("uniNameEng"), Eval("uniNameMalay")) %>'></asp:Label></strong>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>

                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                            SelectCommand="SELECT DISTINCT U.[uniNameEng], U.[uniNameMalay], U.[uniLogo]
                                FROM [University] U
                                JOIN [Branch] B ON U.uniID = B.uniID
                                WHERE ((U.[uniNameEng] = @uniNameEng) AND (U.[uniType] = @uniType)) AND (B.location = @location))">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtSearch" Name="uniNameEng" PropertyName="Text" />
                                <asp:ControlParameter ControlID="ddlUniType" Name="uniType" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="ddlLocation" Name="location" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <script type="text/javascript">
                            function getImageTitle(imgButton) {
                                var uniNameEng = $(imgButton).data('unieng'); // Retrieve the title from data-title attribute
                                var uniNameMalay = $(imgButton).data('unimalay');
                                var uniName = uniNameEng || uniNameMalay; // Use uniNameEng if available, otherwise use uniNameMalay
                                $('#lbluniNameEng').text(uniName); // Update the label text with the selected university title
                            }
                        </script>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
