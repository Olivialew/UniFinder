<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage3.Master" AutoEventWireup="true" CodeBehind="RequestResetPassword.aspx.cs" Inherits="UniFinder.ResetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h2>Password Reset Request</h2>
        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label><br />
        <asp:TextBox ID="txtEmail" runat="server" Placeholder="Enter your email"></asp:TextBox><br />
        <asp:Button ID="btnResetPassword" runat="server" Text="Request Password Reset" OnClick="btnResetPassword_Click" />
    </div>
</asp:Content>
