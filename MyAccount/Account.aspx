<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="UniFinder.Account" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <strong>My Account<br />
    </strong>
    <br />
    <asp:LoginName ID="LoginName1" runat="server" FormatString="You are logged in as: {0}" />
    <br />
    <br />
    <asp:LoginStatus ID="LoginStatus1" runat="server" />
    <br />
    <br />
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/MyAccount/ChangePassword.aspx">Change Password</asp:HyperLink>
    <br />
    <br />
    <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/MyAccount/Wishlist.aspx">My Wishlist</asp:HyperLink>
    <br />
    <br />
    <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/LoginPage.aspx">Log In</asp:HyperLink>
    <br />
    <br />
    <%--    <asp:LoginStatus ID="LoginStatus1" runat="server" LoginPageUrl="~/LoginPage.aspx" OnLoggingOut="LoginStatus1_LoggingOut"/>--%>
    <asp:Button ID="btnDeleteAccount" runat="server" OnClick="btnDeleteAccount_Click" Text="Delete Account" OnClientClick="return confirmDelete();" />
    <br />
    <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
    <br />
    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete your account? This action cannot be undone.");
    </script>
</asp:Content>
