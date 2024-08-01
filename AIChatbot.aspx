<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AIChatbot.aspx.cs" Inherits="UniFinder.AIChatbot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style28 {
            font-size: large;
        }

        .auto-style29 {
            font-size: medium;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p class="auto-style28">
        <strong>AI Chatbot</strong>
    </p>
    <p class="auto-style29">
        &nbsp;
    </p>
    <div>
        <h2>EduBot: Your Program Recommender Assistant</h2>
        <asp:Label ID="lblMessage" runat="server" Text="What programme criteria do you have today?" />
        <br />
        <br />
        <asp:TextBox ID="txtCriteria" runat="server" Width="300px" />
        <br />
        <br />
        <asp:Label ID="lblMaxFees" runat="server" Text="Enter maximum fees: " />
        <asp:TextBox ID="txtMaxFees" runat="server" Width="100px" />
        <br />
        <br />
        <asp:Label ID="lblMaxDuration" runat="server" Text="Enter maximum duration in years: " />
        <asp:TextBox ID="txtMaxDuration" runat="server" Width="100px" />
        <br />
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
        <br />
        <br />
        <asp:Label ID="lblResults" runat="server" Text="" />
        <br />
        <br />
        <asp:Button ID="btnContinue" runat="server" Text="Continue" OnClick="btnContinue_Click" Visible="false" />
        <asp:Button ID="btnEnd" runat="server" Text="End" OnClick="btnEnd_Click" Visible="false" />
    </div>
</asp:Content>
