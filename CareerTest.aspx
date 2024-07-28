<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="CareerTest.aspx.cs" Inherits="UniFinder.CareerTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p class="auto-style27">
        Unsure of what kind of degree to take or your dream career? Our test can help you.
    </p>
    <p class="auto-style27">
        <asp:LinkButton ID="LinkButtonTakeQuiz" runat="server" OnClick="LinkButtonTakeQuiz_Click">Take Career Test</asp:LinkButton>
    </p>
</asp:Content>
