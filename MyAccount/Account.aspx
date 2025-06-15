<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="UniFinder.Account" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .header {
            text-align: center;
            font-size: 20px;
        }

        /* Basic button styling */
        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: white; /* Button text color */
            background-color: #0094ff; /* Button background color */
            text-align: center;
            text-decoration: none; /* Remove underline */
            border-radius: 5px; /* Rounded corners */
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

            /* Button hover effect */
            .button:hover {
                background-color: #0056b3; /* Darker shade on hover */
            }

            /* Button active effect */
            .button:active {
                background-color: #004085; /* Even darker shade when clicked */
                transform: scale(0.98); /* Slightly shrink the button on click */
            }

        .auto-style2 {
            font-size: x-large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="title-head">My Account</h2>
    <asp:LoginName ID="LoginName1" runat="server" FormatString="You are logged in as: {0}" />
    <br />
    Email:
    <asp:Label ID="lblEmail" runat="server"></asp:Label>
    <br />
    <br />
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/MyAccount/ChangePassword.aspx" CssClass="button">Change Password</asp:HyperLink>
    <br />
    <br />
    <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/MyAccount/ResetPassword.aspx" CssClass="button">Reset Password</asp:HyperLink>
    <br />
    <br />
    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/MyAccount/ChangeProfile.aspx" CssClass="button">Change Profile</asp:HyperLink>
    <br />
    <br />
    <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/MyAccount/Wishlist.aspx" CssClass="button">My Wishlist</asp:HyperLink>
    <br />
    <br />
    <asp:LoginStatus ID="LoginStatus1" runat="server" CssClass="button" />
    <br />
    <br />
    <%--<asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/LoginPage.aspx">Log In</asp:HyperLink>
    <br />
    <br />--%>
    <%--    <asp:LoginStatus ID="LoginStatus1" runat="server" LoginPageUrl="~/LoginPage.aspx" OnLoggingOut="LoginStatus1_LoggingOut"/>--%>
    <asp:Button ID="btnDisableAccount" runat="server" CssClass="button" OnClick="btnDisableAccount_Click" Text="Disable Account" OnClientClick="return confirmDisable();" />
    <br />
    <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
    <br />
    <script type="text/javascript">
        function confirmDisable() {
            return confirm("Are you sure you want to disable your account? You can reactivate it later.");
        }
    </script>
</asp:Content>
