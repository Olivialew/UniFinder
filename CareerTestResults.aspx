<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="CareerTestResults.aspx.cs" Inherits="UniFinder.CareerTestResults" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h2>Your Quiz Results</h2>
        <asp:Label ID="ResultLabel" runat="server" Text="Your recommended university program will be displayed here."></asp:Label>


    </div>
</asp:Content>
