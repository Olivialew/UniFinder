<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage3.Master" AutoEventWireup="true" CodeBehind="ChangeProfile.aspx.cs" Inherits="UniFinder.MyAccount.ChangeProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Change Profile</h2>
    <asp:Label ID="lblCurrentPassword" runat="server" Text="Current Password:" AssociatedControlID="txtCurrentPassword"></asp:Label>
    <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
    <br /><br />
    <asp:Label ID="lblNewUsername" runat="server" Text="New Username:" AssociatedControlID="txtNewUsername"></asp:Label>
    <asp:TextBox ID="txtNewUsername" runat="server"></asp:TextBox>
    <br /><br />
    <asp:Label ID="lblNewEmail" runat="server" Text="New Email:" AssociatedControlID="txtNewEmail"></asp:Label>
    <asp:TextBox ID="txtNewEmail" runat="server"></asp:TextBox>
    <br /><br />
    <asp:Button ID="btnChangeProfile" runat="server" OnClick="btnChangeProfile_Click" Text="Change Profile" />
    &nbsp;<asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
    <br /><br />
    <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
</asp:Content>
