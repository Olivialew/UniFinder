<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="UniFinder.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ChangePassword ID="ChangePassword1" runat="server" CancelDestinationPageUrl="~/MyAccount/Account.aspx" ContinueDestinationPageUrl="~/MyAccount/Account.aspx">
    </asp:ChangePassword>
</asp:Content>
