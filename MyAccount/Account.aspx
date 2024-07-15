<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="UniFinder.Account" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <strong>My Account</strong><br />
    Login Status:
    <asp:LoginStatus ID="LoginStatus1" runat="server" />
    <br />
    Login Account:
    <asp:LoginName ID="LoginName1" runat="server" />
    <br />
    <br />
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/ChangePassword.aspx">Change Password</asp:HyperLink>
    <br />
    <br />
    <br />
</asp:Content>
