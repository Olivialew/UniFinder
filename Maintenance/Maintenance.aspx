<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Maintenance.aspx.cs" Inherits="UniFinder.Maintenance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        Logged In User:
        <asp:LoginName ID="LoginName1" runat="server" />
    </p>
    <p>
        If this is not your account:
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/LoginPage.aspx">Click Here</asp:HyperLink>
    </p>
</asp:Content>
