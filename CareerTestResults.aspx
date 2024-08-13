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

        .programmeImgContainer {
            /* Adjust to maintain the aspect ratio and size */
            width: 300px;
            height: 300px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .uniLogo {
            width: 100%;
            height: 100%;
            object-fit: contain; /* Ensures the image fits within the square without distortion */
        }

        .programmeName {
            color: #242424;
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
    <div>
        <h2>Your Quiz Results</h2>
        <asp:Label ID="ResultLabel" runat="server" Text="Your recommended university program will be displayed here."></asp:Label>

        <asp:HiddenField ID="compareListHiddenField" runat="server" />
        <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="comparison-table"></asp:Label>

        <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" RepeatColumns="4" Height="460px">
            <ItemTemplate>
                <div class="program-item">
                    <div class="programmeImgContainer">
                        <asp:ImageButton ID="uniLogo" runat="server" ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>' AlternateText='<%# Eval("ProgrammeName") %>' CssClass="uniLogo" OnClick="imgBtnSelectProgram" />
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
                    <asp:Button ID="btnAddToCompare" runat="server" Text="Add to Compare" CommandName="AddToCompare" CommandArgument='<%# Eval("programID") %>' OnClick="AddToCompareButton_Click" />
                </div>
            </ItemTemplate>
        </asp:DataList>

    </div>
</asp:Content>
