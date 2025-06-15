<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="University.aspx.cs" Inherits="UniFinder.University" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="script1.js" defer></script>
    <style type="text/css">
        .header {
            color: black;
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

        .search-sort-container {
            display: flex;
            justify-content: space-between; /* Distributes space between search and sort */
            align-items: center;
        }

        .search-container {
            flex-grow: 1; /* Optional: ensures search box takes up remaining space */
        }

        .apply-filters-container {
            background-color: #005f5f;
            padding: 10px;
            width: 100%;
        }

        .search-column{
            width: 60%;
            margin: auto;
            padding-top: 15px;
            padding-bottom: 25px;
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

        @media only screen and (max-width: 767px) {
            .cours-search {
                margin-bottom: 30px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bigContainer" style="background-color: #FFFFFF">
        <div class="mainSide">
            <div class="auto-style41">

                <strong>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Branch]"></asp:SqlDataSource>
                </strong><span class="auto-style39">
                    <br />
                </span>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="auto-style39"></asp:Label>
                <br class="auto-style39" />

                <div class="apply-filters-container">
                    <div class="search-column">
                        <h2 style="text-align: center; padding: 15px; color: white;">Universities to Explore</h2>
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <asp:TextBox ID="txtSearch" runat="server" placeholder="What university are you thinking?" CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="cours-search" style="text-align: center;">
                                <strong>
                                    <asp:DropDownList ID="ddlUniType" runat="server" CssClass="btn btn-secondary dropdown-toggle">
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
                                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="btn btn-secondary dropdown-toggle">
                                    </asp:DropDownList>
                                </strong>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>
                                    <div style="text-align: center">
                                        <br />
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-warning" OnClick="btnSearch_Click" />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-secondary" OnClick="btnReset_Click" />
                                        <br />
                                        <br />
                                <asp:Label ID="lblNoResults" runat="server" CssClass="auto-style47"></asp:Label>
                                    </div>
                                </strong>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
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
