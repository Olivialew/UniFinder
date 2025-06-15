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

        .apply-filters-container{
            position: relative;
            z-index: 1;
        }

        .search-column{
            width: 60%;
            margin: auto;
            padding-top: 15px;
            padding-bottom: 25px;
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

        .program-item, .uni-item {
            display: inline-block;
            width: 300px; /* Adjust width as needed */
            padding: 10px;
            box-sizing: border-box;
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

        .programmeImgContainer {
            /* Adjust to maintain the aspect ratio and size */
            height: 200px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .uniLogo {
            width: 80%;
            height: 80%;
            object-fit: contain; /* Ensures the image fits within the square without distortion */
        }

        .programmeName {
            color: #242424;
        }

        .form-control {
            width: 50%;
        }

        .search-btn {
            margin-left: 10px;
        }

        .black-font {
            text-align: center;
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
            margin: 10px 15px;
        }

            .program-item .btnAddToCompare {
                padding: 10px 20px;
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background-color: #005f5f;
                border: none;
                border-radius: 5px;
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

        .programmeName {
            word-wrap: break-word; /* Allow long words to wrap onto the next line */
            overflow-wrap: break-word; /* Handle text overflow */
            margin-top: 10px; /* Add some space above the name */
            font-size: 16px; /* Adjust as needed */
            font-weight: bold; /* Optionally, make the name bold */
            display: block; /* Make sure the name behaves like a block-level element */
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

        .apply-filters-container {
            background-color: #005f5f;
            padding: 10px;
            width: 100%;
        }

        .auto-style43 {
            width: 99%;
        }

        .no-program-message {
            color: red;
            font-size: 16px;
            font-weight: bold;
            margin-top: 20px;
        }

        .input-group>.form-control {
            position: relative;
            -ms-flex: 1 1 auto;
            flex: 1 1 auto;
            width: 1%;
            margin-bottom: 0;
        }

        .input-group .form-control, .input-group-addon, .input-group-btn {
            display: table-cell;
        }

        .cours-search .form-control {
            border: 0;
            height: 50px;
            border-radius: 4px !important;
            padding: 10px 20px;
            font-size: 16px;
        }

        .input-group{
            width: 100%;
            position: relative;
            display: -ms-flexbox;
            display: flex;
            -ms-flex-wrap: wrap;
            flex-wrap: wrap;
            -ms-flex-align: stretch;
            align-items: stretch;
        }

        .ddlGroup{
            display: flex; 
        }

            .ddlGroup .ddl-right{
                display: flex; 
                justify-content: flex-end;
                margin-left: auto;
                margin-right: 0;
            }

        * {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        div {
            display: block;
            unicode-bidi: isolate;
        }

        .program-item{
            padding: 15px;
            box-shadow: 0 0 25px 0 rgba(29, 25, 0, 0.25);
            border-radius: 4px;
            overflow: hidden;
            height: 450px;
        }

        .uni-item{
            box-shadow: 0 0 25px 0 rgba(29, 25, 0, 0.25);
            border-radius: 4px;
            overflow: hidden;
            height: 300px;
            padding: 15px;
            margin: 10px 15px;
        }

        .action-box{
            overflow: hidden;
            position: relative;
        }

        .programmeName, .uniName{
            padding: 15px;
            font-size: 13px;
            position: relative;
            text-align: center !important;
        }

        .cours-more-info .fees, .cours-more-info .location, .cours-more-info .duration{
            width: 50%;
            padding: 5px 15px;
        }

        .cours-more-info{
            border-top: 1px solid #e6e6e6;
            display: flex;
            margin: 0;
            width: inherit;
        }

        .cours-more-info .fees
        {
            border-right: 1px solid #e6e6e6;
        }

        .cours-more-info .duration
        {
            border-left: 1px solid #e6e6e6;
        }

        .course-detail-bx .cours-more-info .fees, .cours-more-info .location, .cours-more-info .duration{
            padding: 8px 20px;
            overflow: auto;
        }

        @media only screen and (max-width: 1200px) {
            .cours-more-info .fees, .cours-more-info .location, .cours-more-info .duration{
                padding: 8px 12px;                
            }
        }

        @media only screen and (max-width: 767px) {
            .cours-search {
                margin-bottom: 30px;
            }
        }
        </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bigContainer" style="background-color: #FFFFFF;">
        <div class="auto-style38">
            <div class="mainSide">
                <div class="apply-filters-container">
                    <div class="search-column">
                        <h2 style="text-align: center; padding: 15px; color: white;">Programmes to Learn</h2>

                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [University]"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                            SelectCommand="SELECT * FROM [Branch] WHERE ([uniID] = @uniID) OR @uniID = 'All'">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlUni" Name="uniID" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                            <table class="auto-style43">                            
                                <tr>
                                    <td class="cours-search" colspan="5">
                                        <div class="input-group">
                                            <asp:TextBox ID="txtSearch" runat="server" placeholder="What programme do you want to study?" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </td>
                                <tr>
                                    <td class="cours-search" colspan="5">
                                        &nbsp;</td>
                                <tr>
                                    <td colspan="5">
                                        <strong>
                                            <div class="ddlGroup">
                                                <div class="ddl-left">
                                                    <asp:DropDownList ID="ddlUni" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlUni_SelectedIndexChanged1" CssClass="btn btn-secondary dropdown-toggle">
                                                    </asp:DropDownList>
                                                    <asp:DropDownList ID="ddlBranch" runat="server" DataTextField="location" DataValueField="branchID" CssClass="btn btn-secondary dropdown-toggle">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="ddl-right">
                                                    <asp:DropDownList ID="ddlSortBy" runat="server" AutoPostBack="true" CssClass="btn btn-secondary dropdown-toggle">
                                                        <asp:ListItem Text="Sort by Fees" Value=""></asp:ListItem>
                                                        <asp:ListItem Text="Fees Ascending" Value="fees_asc"></asp:ListItem>
                                                        <asp:ListItem Text="Fees Descending" Value="fees_desc"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="color: white;" class="black-font">
                                        <span>Minimum Tuition Fees (RM)</span><strong>
                                            <asp:TextBox ID="txtMinFees" runat="server" CssClass="form-control"></asp:TextBox></strong></td>
                                    <td style="color: white;" class="black-font">

                                        -</td>
                                    <td style="color: white;" class="black-font">

                                        <span>Maximum Tuition Fees (RM)</span><strong><asp:TextBox ID="txtMaxFees" runat="server" CssClass="form-control"></asp:TextBox></strong></td>
                                    <td style="color: white;" class="black-font">

                                        &nbsp;</td>
                                    <td style="color: white;" class="black-font">

                                        <span>Duration (year(s))</span><strong><asp:TextBox ID="txtDuration" runat="server" CssClass="form-control"></asp:TextBox>

                                        </strong></td>
                                </tr>
                            
                                <tr>
                                    <td style="color: white;" class="black-font">
                                        &nbsp;</td>
                                    <td style="color: white;" class="black-font">

                                        &nbsp;</td>
                                    <td style="color: white;" class="black-font">

                                        &nbsp;</td>
                                    <td style="color: white;" class="black-font">

                                        &nbsp;</td>
                                    <td style="color: white;" class="black-font">

                                        &nbsp;</td>
                                </tr>
                            
                                </table>

                            <div style="text-align: center;">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-warning" OnClick="btnSearch_Click" />
                                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-secondary" OnClick="btnReset_Click" />
                            </div>
                            <span class="black-font">&nbsp;&nbsp;&nbsp;&nbsp;</span></strong><span class="black-font"><br />
                            </span>
                        <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="black-font"></asp:Label>
                    </div>
                </div>


                <span class="black-font">
                    <br />

                    <div class="panel">
                        <asp:HiddenField ID="compareListHiddenField" runat="server" />

                        <%--<asp:Panel ID="pnlStep1" runat="server" CssClass="panel-class" ClientIDMode="Static" Style="display: block" Width="815px">--%>
                        <asp:Label ID="lblNoPrograms" runat="server" Text="No program found." Visible="False" CssClass="no-program-message"></asp:Label>

                        <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" RepeatColumns="4">
                            <ItemTemplate>
                                <div class="program-item">
                                    <div class="programmeImgContainer">
                                        <div class="action-box">
                                            <asp:ImageButton ID="imgUni" runat="server" ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>' AlternateText='<%# Eval("ProgrammeName") %>' CssClass="uniLogo" OnClick="imgBtnSelectProgram" />
                                        </div>
                                    </div>
                                    <div class="programmeName" style="text-align: center;">
                                        <strong>
                                            <asp:Label ID="lblProgrammeName" runat="server" Text='<%# Eval("ProgrammeName") %>'></asp:Label></strong>
                                    </div>
                                    <div class="cours-more-info">
                                        <div class="fees">
                                            RM
                                            <asp:Label ID="lblFees" runat="server" Text='<%# Eval("fees") %>'></asp:Label>
                                        </div>
                                        <div class="location">
                                            <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("location") %>'></asp:Label>
                                        </div>
                                        <div class="duration">
                                            <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("duration") %>'></asp:Label>
                                            years
                                        </div>
                                    </div>
                                    <div style="text-align: center; padding: 15px;">
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
                    <asp:Label ID="lblPageNumber" runat="server" Text="Page 1" CssClass="black-font"></asp:Label>
                    &nbsp;&nbsp;
                    <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" Width="91px" CssClass="button" />
                </div>

                <div class="auto-style1">

                    <span class="black-font">

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
