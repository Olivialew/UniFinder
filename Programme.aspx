<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Programme.aspx.cs" Inherits="UniFinder.Programme" EnableEventValidation="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="script1.js" defer></script>

    <style type="text/css">
        .header {
            text-align: center;
            font-size: 20px;
        }

        .content {
            /*            width: 100%;*/
            display: flex;
            justify-content: space-between;
            color: white
        }

        .mainSide {
            flex: 1;
            padding-left: 10px;
            padding-right: 10px;
            flex-direction: column;
            gap: 10px;
        }

        .search-sort-container {
            display: flex;
            justify-content: space-between; /* Distributes space between search and sort */
            align-items: center;
        }

        .search-container {
            flex-grow: 1; /* Optional: ensures search box takes up remaining space */
        }

        .sort-container {
            display: flex;
            align-items: center;
            gap: 10px; /* Space between "Sort by" text and dropdown */
        }

        .sort-by-text {
            color: rgb(255, 255, 255);
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            font-size: medium;
        }

        .rightSide {
            flex: 0.5;
            padding-left: 100px;
            border: 4px double gold;
            border-radius: 5%;
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
            border: 1px solid pink;
            margin-top: 20px;
            align-content: center;
        }

        /*.programmeImgContainer {
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            position: relative;
            max-height: 400px;
            max-width: 400px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }*/

        .programmeImgContainer {
            /* Adjust to maintain the aspect ratio and size */
            width: 300px;
            height: 300px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /*.uniLogo {
            width: 253px;
            height: 375.14px;
            margin-right: 2.5%;
            box-sizing: border-box;
        }*/

        .uniLogo {
            width: 80%;
            height: 80%;
            object-fit: contain; /* Ensures the image fits within the square without distortion */
        }

        .programmeName {
            color: #242424;
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

        .comparison-table {
            color: black;
        }

        .programmeName, .fees, .location, .duration {
            color: #000000; /* Ensures text is black */
        }

        .program-item {
            /*display: inline-block;*/
            display: flex;
            flex-direction: column;
            align-items: center; /* Centers content horizontally */
            /*width: 24%;*/ /* Adjust this width to ensure four items per row */
            /*box-sizing: border-box;*/
            padding: 10px;
            margin: 0;
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

        .auto-style38 {
            display: flex;
            justify-content: space-between;
            color: white;
            width: 98%;
            box-sizing: border-box;
            padding: 10px;
            background-color: #fff;
        }

        .auto-style39 {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            font-size: medium;
        }

        .apply-filters-container {
            background-color: #dae7f0;
            padding: 10px;
            width: 100%;
        }

        .auto-style40 {
            width: 10px;
        }

        .auto-style41 {
            width: 209px;
        }

        .auto-style42 {
            width: 312px;
        }

        .auto-style43 {
            width: 99%;
        }

        .auto-style44 {
            width: 104px;
        }

        .auto-style45 {
            width: 10px;
            color: black;
        }

        .no-program-message {
            color: red;
            font-size: 16px;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bigContainer" style="background-color: #FFFFFF">
        <div class="header">
            <h3 class="auto-style37"><strong>Programme</strong></h3>
        </div>
        <div class="auto-style38">
            <div class="mainSide">

                <div class="apply-filters-container">

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [University]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                        SelectCommand="SELECT * FROM [Branch] WHERE ([uniID] = @uniID) OR @uniID = 'All'">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlUni" Name="uniID" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <strong>
                        <br />
                        <table class="auto-style43">
                            <tr>
                                <td class="auto-style44">
                                    <strong class="auto-style39"><span class="comparison-table">Search by:</span></strong></td>
                                <td class="auto-style40">&nbsp;</td>
                                <td class="auto-style42">

                                    <strong>
                                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Enter Programme Name" CssClass="search-box"></asp:TextBox>
                                    </strong></td>
                                <td class="auto-style41">
                                    <strong class="auto-style39"><span class="comparison-table">Sort by Fees:</span></strong>
                                    <asp:DropDownList ID="ddlSortBy" runat="server" AutoPostBack="true">
                                        <asp:ListItem Text="Select Sort" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Fees Ascending" Value="fees_asc"></asp:ListItem>
                                        <asp:ListItem Text="Fees Descending" Value="fees_desc"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style44">&nbsp;</td>
                                <td class="auto-style40">&nbsp;</td>
                                <td class="auto-style42">&nbsp;</td>
                                <td class="auto-style41">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style44">

                                    <span class="comparison-table">
                                        <strong>Filter by:</strong></span></td>
                                <td class="auto-style40">&nbsp;</td>
                                <td class="auto-style42">&nbsp;</td>
                                <td class="auto-style41">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style44">

                                    <span class="comparison-table">
                                        <strong>University</strong></span></td>
                                <td class="auto-style45">:</td>
                                <td class="auto-style42">
                                    <asp:DropDownList ID="ddlUni" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlUni_SelectedIndexChanged1">
                                    </asp:DropDownList>
                                </td>
                                <td class="auto-style41">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style44">
                                    <span class="comparison-table">

                                        <span class="auto-style26"><strong>Branch Location</strong></span></span></td>
                                <td class="auto-style45">:</td>
                                <td class="auto-style42">

                                    <asp:DropDownList ID="ddlBranch" runat="server" DataTextField="location" DataValueField="branchID">
                                    </asp:DropDownList>

                                </td>
                                <td class="auto-style41">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style44">


                                    <strong>
                                        <span class="comparison-table">Tuition Fees (RM)</span></strong></td>
                                <td class="auto-style45">&nbsp;</td>
                                <td class="auto-style42">&nbsp;</td>
                                <td class="auto-style41">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style44">


                                    <strong>
                                        <span class="auto-style26"><span class="comparison-table">Minimum</span></span></strong></td>
                                <td class="auto-style45">:</td>
                                <td class="auto-style42">

                                    <strong>
                                        <asp:TextBox ID="txtMinFees" runat="server"></asp:TextBox></strong></td>
                                <td class="auto-style41">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style44">

                                    <strong>
                                        <span class="auto-style26">

                                            <span class="comparison-table">Maximum</span></span></strong></td>
                                <td class="auto-style45">:</td>
                                <td class="auto-style42">

                                    <strong>
                                        <asp:TextBox ID="txtMaxFees" runat="server"></asp:TextBox></strong></td>
                                <td class="auto-style41">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style44">

                                    <strong><span class="comparison-table">Duration</span></strong></td>
                                <td class="auto-style45">:</td>
                                <td class="auto-style42">
                                    <asp:TextBox ID="txtDuration" runat="server"></asp:TextBox>

                                </td>
                                <td class="auto-style41">&nbsp;</td>
                            </tr>
                        </table>
                        <br />
                        <div style="text-align: center">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="button" OnClick="btnSearch_Click" />
                            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="button" OnClick="btnReset_Click" />
                        </div>
                        <span class="comparison-table">&nbsp;&nbsp;&nbsp;&nbsp;</span></strong><span class="comparison-table"><br />
                        </span>
                    <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="comparison-table"></asp:Label>

                </div>
                <span class="comparison-table">
                    <br />

                    <div class="panel">
                        <asp:HiddenField ID="compareListHiddenField" runat="server" />

                        <%--<asp:Panel ID="pnlStep1" runat="server" CssClass="panel-class" ClientIDMode="Static" Style="display: block" Width="815px">--%>
                        <asp:Label ID="lblNoPrograms" runat="server" Text="No program found." Visible="False" CssClass="no-program-message"></asp:Label>

                        <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" RepeatColumns="4" Height="460px" Width="1419px">
                            <ItemTemplate>
                                <div class="program-item">
                                    <div class="programmeImgContainer">
                                        <asp:ImageButton ID="imgUni" runat="server" ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>' AlternateText='<%# Eval("ProgrammeName") %>' CssClass="uniLogo" OnClick="imgBtnSelectProgram" />
                                    </div>
                                    <div class="programmeName" style="text-align: center;">
                                        <strong>
                                            <asp:Label ID="lblProgrammeName" runat="server" Text='<%# Eval("ProgrammeName") %>'></asp:Label></strong>
                                    </div>
                                    <div class="fees">
                                        Tuition Fees: RM
                        <asp:Label ID="lblFees" runat="server" Text='<%# Eval("fees") %>'></asp:Label>
                                    </div>
                                    <div class="location">
                                        Location: 
                        <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("location") %>'></asp:Label>
                                    </div>
                                    <div class="duration">
                                        Duration: 
                        <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("duration") %>'></asp:Label>
                                        years
                                    </div>
                                    <br />
                                    <div style="text-align: center;">
                                        <!-- Center the button -->
                                        <asp:Button ID="btnAddToCompare" runat="server" Text="Add to Compare" CssClass="compare-btn" CommandName="AddToCompare" CommandArgument='<%# Eval("programID") %>' OnClick="AddToCompareButton_Click" />
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                </span>

                <br />

                <div class="auto-style1">
                    <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" CssClass="button" />
                    &nbsp;&nbsp;
                    <asp:Label ID="lblPageNumber" runat="server" Text="Page 1" CssClass="comparison-table"></asp:Label>
                    &nbsp;&nbsp;
                    <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" Width="91px" CssClass="button" />
                </div>

                <div class="auto-style1">

                    <span class="comparison-table">

                        <script type="text/javascript">
                            function validateWishlist() {
                                var wishlistCount = parseInt(document.getElementById('WishlistCount').value, 10);
                                if (wishlistCount >= 4) {
                                    alert("You can only add up to 4 programs to the wishlist.");
                                    return false; // Prevent postback
                                }
                                return true;
                            }
                        </script>
                        <%--</asp:Panel>--%>
                    </span>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
