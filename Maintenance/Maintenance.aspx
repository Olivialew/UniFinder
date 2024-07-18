<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="Maintenance.aspx.cs" Inherits="UniFinder.Maintenance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <asp:LoginName ID="LoginName1" runat="server" FormatString="You are logged in as: {0}" />
    </p>
<p>
        &nbsp;</p>
    <p>
        If this is not your account:
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/LoginPage.aspx">Click Here</asp:HyperLink>
    </p>
    <p>
        &nbsp;</p>
    <p>
        <asp:LoginStatus ID="LoginStatus2" runat="server" LogoutAction="RedirectToLoginPage" />
    </p>
</asp:Content>
