<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="CareerTestResults.aspx.cs" Inherits="UniFinder.CareerTestResults" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
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
    <div>
        <h2>Your Quiz Results</h2>
        <asp:Label ID="ResultLabel" runat="server" Text="Your recommended university program will be displayed here."></asp:Label>

        <asp:HiddenField ID="compareListHiddenField" runat="server" />
        <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="comparison-table"></asp:Label>

        <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" RepeatColumns="4" Height="460px" Width="1419px">
            <ItemTemplate>
                <div class="program-item">
                    <div class="programmeImgContainer">
                        <asp:ImageButton ID="imgUni" runat="server" ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>' AlternateText='<%# Eval("ProgrammeName") %>' CssClass="uniLogo" OnClick="imgBtnSelectProgram" />
                    </div>
                    <div class="programmeName" style="text-align: center;">
                        <strong><asp:Label ID="lblProgrammeName" runat="server" Text='<%# Eval("ProgrammeName") %>'></asp:Label></strong>
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

    </div>
</asp:Content>
