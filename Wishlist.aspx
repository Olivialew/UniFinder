<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="UniFinder.Wishlist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
    Wishlist</p>
<p>
    <asp:LoginView ID="LoginView1" runat="server">
    </asp:LoginView>
</p>
<p>
    <asp:LoginStatus ID="LoginStatus1" runat="server" LogoutAction="Redirect" LogoutPageUrl="~/Home.aspx" />
</p>
<p>
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Home.aspx">Go Back to Menu</asp:HyperLink>
        </p>
</asp:Content>
