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
            color: white;
        }

        .mainSide {
            flex: 1;
            padding-left: 10px;
            padding-right: 10px;
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
            width: 100%;
            height: 100%;
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
            display: inline-block;
            /*width: 24%;*/ /* Adjust this width to ensure four items per row */
            box-sizing: border-box;
            padding: 10px;
            margin: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bigContainer" style="background-color: #FFFFFF">
        <div class="header">
            <h3 class="auto-style37"><strong>Programme</strong></h3>
        </div>
        <div class="content">
            <div class="mainSide">
                <strong>
                    <span class="comparison-table">Search by:</span><br class="comparison-table" />
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Enter Programme Name" CssClass="search-box"></asp:TextBox>
                    <span class="comparison-table">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="auto-style26"><span class="comparison-table">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sort by: 
               
                    </span>

                        <asp:DropDownList ID="ddlSortBy" runat="server" AutoPostBack="true">
                            <asp:ListItem Text="Select Sort" Value=""></asp:ListItem>
                            <asp:ListItem Text="Fees Ascending" Value="fees_asc"></asp:ListItem>
                            <asp:ListItem Text="Fees Descending" Value="fees_desc"></asp:ListItem>
                        </asp:DropDownList>
                        <span class="comparison-table">
                            <br />
                            <br />
                            Filter by:<br />
                            University<br />
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


                <span class="auto-style26"><strong>Fees</strong></span><br class="auto-style26" />
                <span class="auto-style26"><span class="comparison-table">Minimum: </span> </span>
                <asp:TextBox ID="txtMinFees" runat="server"></asp:TextBox><span class="comparison-table"><br class="auto-style26" />
                    <span class="auto-style26">Maximum: </span>
                </span>
                <asp:TextBox ID="txtMaxFees" runat="server"></asp:TextBox><span class="comparison-table"><br />
                    <br />

                    <strong>Duration</strong><br />
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

                        <%--                    <asp:Panel ID="pnlStep1" runat="server" CssClass="panel-class" ClientIDMode="Static" Style="display: block" Width="815px">--%>

                        <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" RepeatColumns="4" Height="460px">
                            <ItemTemplate>
                                <div class="program-item">
                                    <div class="programmeImgContainer">
                                        <%--                                    Style="max-height: 300px; max-width: 300px; margin-right: 50px; margin-left: 20px; margin-top: 10px"--%>
                                        <asp:ImageButton ID="imgUni" runat="server" ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>' AlternateText='<%# Eval("ProgrammeName") %>' CssClass="uniLogo" OnClick="imgBtnSelectProgram" />
                                    </div>
                                    <div class="programmeName">
                                        <asp:Label ID="lblProgrammeName" runat="server" Text='<%# Eval("ProgrammeName") %>' Style="margin-top: 3px; margin-bottom: 5px; margin-left: 30px;"></asp:Label>
                                    </div>
                                    <div class="fees">
                                        <asp:Label ID="lblFees" runat="server" Text='<%# Eval("fees") %>' Style="margin-top: 3px; margin-bottom: 5px; margin-left: 30px;"></asp:Label>
                                    </div>
                                    <div class="location">
                                        <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("location") %>' Style="margin-top: 3px; margin-bottom: 5px; margin-left: 30px;"></asp:Label>
                                    </div>
                                    <div class="duration">
                                        <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("duration") %>' Style="margin-top: 3px; margin-bottom: 5px; margin-left: 30px;"></asp:Label>
                                    </div>
                                    <%--                                <asp:Button ID="AddToWishlistButton" runat="server" Text="Add to Wishlist" CommandName="AddToWishlist" CommandArgument='<%# Eval("programID") %>' OnClientClick="return validateWishlist();" />--%>
                                    <asp:Button ID="btnAddToCompare" runat="server" Text="Add to Compare" CommandName="AddToCompare" CommandArgument='<%# Eval("programID") %>' OnClick="AddToCompareButton_Click" />
                                </div>
                            </ItemTemplate>
                        </asp:DataList>

                        <asp:Label ID="WishlistLabel" runat="server" Text="Wishlist:"></asp:Label>
                        <asp:HiddenField ID="WishlistCount" runat="server" />
                        <br />
                        <%--                        <asp:Button ID="CompareButton" runat="server" Text="Compare" OnClick="CompareButton_Click" />--%>
                </span>

                <div class="pagination">
                    <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" />
                    <asp:Label ID="lblPageNumber" runat="server" Text="Page 1" CssClass="comparison-table"></asp:Label>
                    <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" />
                </div>

                <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                    <asp:ListItem Text="5" Value="5" />
                    <asp:ListItem Text="10" Value="10" Selected="True" />
                    <asp:ListItem Text="15" Value="15" />
                </asp:DropDownList>

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
                    <%--                    </asp:Panel>--%>
                </span>
            </div>
        </div>
    </div>
    </div>
</asp:Content>
