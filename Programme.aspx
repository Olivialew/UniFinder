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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bigContainer" style="background-color: #FFFFFF">
        <div class="header">
            <h3 class="auto-style37"><strong>Programme</strong></h3>
        </div>
        <div class="auto-style38">
            <div class="mainSide">
                <div class="search-sort-container">
                    <div class="search-container">
                        <strong class="auto-style39"><span class="comparison-table">Search by:</span></strong>
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Enter Programme Name" CssClass="search-box"></asp:TextBox>
                    </div>

                    <div class="sort-container">
                        <strong class="auto-style39"><span class="comparison-table">Sort by Fees:</span></strong>
                        <asp:DropDownList ID="ddlSortBy" runat="server" AutoPostBack="true">
                            <asp:ListItem Text="Select Sort" Value=""></asp:ListItem>
                            <asp:ListItem Text="Fees Ascending" Value="fees_asc"></asp:ListItem>
                            <asp:ListItem Text="Fees Descending" Value="fees_desc"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <span class="comparison-table">
                    <br />
                    <strong>Filter by:<br />
                        University</strong><br />
                </span>
                <asp:DropDownList ID="ddlUni" runat="server" DataSourceID="SqlDataSource1" DataTextField="uniNameEng" DataValueField="uniID" AutoPostBack="True">
                </asp:DropDownList>
                </span></strong>
                <span class="comparison-table">

                    <br />
                    <br />
                    <span class="auto-style26"><strong>Branch Location</strong></span><br />
                </span>

                <asp:DropDownList ID="ddlBranch" runat="server" DataSourceID="SqlDataSource2" DataTextField="location" DataValueField="branchID">
                </asp:DropDownList>


                <span class="auto-style26"><strong>Fees<br />
                    <br />
                    <span class="comparison-table">Tuition Fees</span></strong></span><br class="auto-style26" />
                <span class="auto-style26"><span class="comparison-table">Minimum: </span></span>
                <asp:TextBox ID="txtMinFees" runat="server"></asp:TextBox><span class="comparison-table"><br class="auto-style26" />
                    <span class="auto-style26">Maximum: </span>
                </span>
                <asp:TextBox ID="txtMaxFees" runat="server"></asp:TextBox><span class="comparison-table"><br />
                    <br />

                    <strong>Duration:</strong>
                </span>
                <asp:TextBox ID="txtDuration" runat="server"></asp:TextBox>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [University]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    SelectCommand="SELECT * FROM [Branch] WHERE ([uniID] = @uniID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlUni" Name="uniID" PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <strong>
                    <br />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="search-btn" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="search-btn" OnClick="btnReset_Click" Width="60px" />
                    <span class="comparison-table">&nbsp;&nbsp;&nbsp;&nbsp;</span></strong><span class="comparison-table"><br />
                    </span>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="comparison-table"></asp:Label>
                <span class="comparison-table">
                    <br />

                    <div class="panel">
                        <asp:HiddenField ID="compareListHiddenField" runat="server" />

                        <%--<asp:Panel ID="pnlStep1" runat="server" CssClass="panel-class" ClientIDMode="Static" Style="display: block" Width="815px">--%>

                        <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" RepeatColumns="4" Height="460px" Width="1419px">
                            <ItemTemplate>
                                <div class="program-item">
                                    <div class="programmeImgContainer">
                                        <asp:ImageButton ID="imgUni" runat="server" ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>' AlternateText='<%# Eval("ProgrammeName") %>' CssClass="uniLogo" OnClick="imgBtnSelectProgram" />
                                    </div>
                                    <div class="programmeName">
                                        <asp:Label ID="lblProgrammeName" runat="server" Text='<%# Eval("ProgrammeName") %>'></asp:Label>
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
                                    <div style="text-align: center;">
                                        <!-- Center the button -->
                                        <asp:Button ID="btnAddToCompare" runat="server" Text="Add to Compare" CssClass="compare-btn" CommandName="AddToCompare" CommandArgument='<%# Eval("programID") %>' OnClick="AddToCompareButton_Click" />
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>

                        <%--<asp:Label ID="WishlistLabel" runat="server" Text="Wishlist:"></asp:Label>
                        <asp:HiddenField ID="WishlistCount" runat="server" />--%>
                        <%--<asp:Button ID="CompareButton" runat="server" Text="Compare" OnClick="CompareButton_Click" />--%>
                </span>

                <br />

                <div class="auto-style1">
                    <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" />
                    &nbsp;&nbsp;
                    <asp:Label ID="lblPageNumber" runat="server" Text="Page 1" CssClass="comparison-table"></asp:Label>
                    &nbsp;&nbsp;
                    <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" Width="91px" />
                </div>

                <div class="auto-style1">

                    <%--<asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                    <asp:ListItem Text="5" Value="5" />
                    <asp:ListItem Text="10" Value="10" Selected="True" />
                    <asp:ListItem Text="15" Value="15" />
                </asp:DropDownList>--%>

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
    </div>
</asp:Content>
