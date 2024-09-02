<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage3.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="UniFinder.ResetPassword1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            width: 172px;
        }
        .auto-style3 {
            width: 17px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h2>Reset Your Password</h2>
        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label><br />

        <!-- Email input -->
        <table style="width:100%;">
            <tr>
                <td class="auto-style2">Email</td>
                <td class="auto-style3">:</td>
                <td>
        <asp:TextBox ID="txtEmail" runat="server" Placeholder="Enter your email"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="auto-style2">OTP</td>
                <td class="auto-style3">:</td>
                <td>
        <asp:TextBox ID="txtOTP" runat="server" Placeholder="Enter OTP"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnRequestOTP" runat="server" Text="Request OTP" OnClick="btnRequestOTP_Click" /></td>
            </tr>
            <tr>
                <td class="auto-style2">New Password</td>
                <td class="auto-style3">:</td>
                <td>
        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" Placeholder="New Password"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="auto-style2">Confirm Password</td>
                <td class="auto-style3">:</td>
                <td>
        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" Placeholder="Confirm Password"></asp:TextBox></td>
            </tr>
        </table>
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Reset Password" OnClick="btnSubmit_Click" />
    &nbsp; <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
    </div>
</asp:Content>
