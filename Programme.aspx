<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Programme.aspx.cs" Inherits="UniFinder.Programme" EnableEventValidation="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="script1.js" defer></script>

    <style type="text/css">
        .header {
            text-align: center;
            font-size: 20px;
        }

        .content {
            width: 100%;
            display: flex;
            justify-content: space-between;
            color: white;
        }

        .mainSide {
            width: 80%;
            flex: 1;
            padding-right: 100px;
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

        .programmeImgContainer {
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            position: relative;
            max-height: 375.14px;
            max-width: 253px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .uniLogo {
            width: 253px;
            height: 375.14px;
            margin-right: 2.5%;
            box-sizing: border-box;
        }

        .programmeName{
            color: #242424;
        }

        .auto-style25 {
            color: #242424;
            height: 118px;
        }

        .auto-style29 {
            width: 175px;
        }

        .auto-style30 {
            width: 1227px;
        }

        .auto-style33 {
            color: #242424;
            height: 77px;
            width: 423px;
        }

        .auto-style34 {
            color: #242424;
            height: 77px;
            width: 514px;
        }

        .auto-style35 {
            color: #242424;
            height: 83px;
        }

        .auto-style37 {
            font-size: xx-large;
            color: #242424;
        }

        .auto-style38 {
            color: #242424;
            height: 77px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bigContainer" style="background-color: #FFFFFF">
        <div class="header">
            <h3 class="auto-style37">Programme</h3>
        </div>
        <div class="content">
            <div class="mainSide">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Enter Programme Name" CssClass="search-box"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="search-btn" OnClick="btnSearch_Click" />

                <br />
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red"></asp:Label>
                <br />

                <div class="panel">
                    <asp:Panel ID="pnlStep1" runat="server" CssClass="panel-class" ClientIDMode="Static" Style="display: block" Width="815px">
                        <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" RepeatColumns="4" Height="460px" DataSourceID="SqlDataSource1">
                            <ItemTemplate>
                                <div class="programmeImgContainer">
                                    <asp:ImageButton ID="imgUni" runat="server" ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>' AlternateText='<%# Eval("programName") %>' CssClass="uniLogo" Style="max-height: 300px; max-width: 300px; margin-right: 50px; margin-left: 20px; margin-top: 10px" OnClick="imgBtnSelectProgram" />
                                </div>
                                <div class="programmeName">
                                    <asp:Label ID="lblProgrammeName" runat="server" Text='<%# Eval("programName") %>' Style="margin-top: 3px; margin-bottom: 5px; margin-left: 30px;"></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>                        
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                            SelectCommand="SELECT P.programName, U.uniLogo FROM Programme P JOIN University U ON P.uniID = U.uniID">
                        </asp:SqlDataSource>
                        <script type="text/javascript">
                            function getImageTitle(imgButton) {
                                var programName = $(imgButton).data('programName'); // Retrieve the title from data-title attribute
                                $('#lblProgrammeName').text(programName); // Update the label text with the selected movie title
                            }
                        </script>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
