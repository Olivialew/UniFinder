<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="UniFinder.Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .header {
            text-align: center;
            font-size: 20px;
        }

        .auto-style2 {
            font-size: x-large;
        }

        .comparison-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
        }

        .comparison-item {
            flex: 1 1 calc(25% - 20px); /* Maintain this to control the width */
            border: 1px solid #ddd;
            padding: 10px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            background-color: #fff7e7;
            margin-bottom: 20px; /* Space between rows */
            /* Centering items */
            display: flex;
            flex-direction: column; /* Stacks children vertically */
            align-items: center; /* Horizontally centers children */
            justify-content: center; /* Vertically centers children */
            text-align: center; /* Centers text inside */
        }

            .comparison-item h4 {
                margin-top: 0;
            }

            .comparison-item .remove-button {
                display: block;
                margin-top: 10px;
                padding: 5px 10px;
                background-color: #a55129;
                color: white;
                border: none;
                cursor: pointer;
                text-align: center;
            }

                .comparison-item .remove-button:hover {
                    background-color: #93451f;
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
            width: 80%;
            height: 80%;
            object-fit: contain; /* Ensures the image fits within the square without distortion */
        }
    </style>

    <div class="header">
        <h3 class="auto-style2"><strong>Wishlist</strong></h3>
    </div>

    <p>
        <asp:LoginView ID="LoginView1" runat="server">
        </asp:LoginView>
    </p>
    <p>
        Status:
        <asp:LoginStatus ID="LoginStatus1" runat="server" LogoutAction="Redirect" LogoutPageUrl="~/Home.aspx" />
    </p>

    <div>
        <strong>University Comparison<br />
        </strong>

        <!-- Comparison List using a Repeater Control -->
        <div class="comparison-container">
            <asp:Repeater ID="comparisonRepeater" runat="server">
                <ItemTemplate>
                    <div class="comparison-item">
                        <div class="programmeImgContainer">
                            <asp:ImageButton ID="imgUni" runat="server"
                                ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>'
                                AlternateText='<%# Eval("ProgrammeName") %>'
                                CssClass="uniLogo"
                                OnClick="imgBtnSelectProgram" />
                        </div>
                        <h4><%# Eval("ProgrammeName") %></h4>
                        <p><strong>Fees:</strong> RM <%# Eval("Fees") %></p>
                        <p><strong>Location:</strong> <%# Eval("Location") %></p>
                        <p><strong>University:</strong> <%# Eval("University") %></p>
                        <p><strong>Duration:</strong> <%# Eval("Duration") %></p>
                        <div>
                            <asp:Button ID="RemoveButton" runat="server"
                                Text="Remove"
                                CssClass="remove-button"
                                CommandArgument='<%# Eval("ProgramID") %>'
                                OnClick="RemoveButton_Click" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <p>
        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Home.aspx">Go Back to Menu</asp:HyperLink>
    </p>
</asp:Content>
