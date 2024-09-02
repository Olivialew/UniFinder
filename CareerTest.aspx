<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="CareerTest.aspx.cs" Inherits="UniFinder.CareerTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            width: 935px;
            height: 67px;
        }

        .center {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />
    <map name="bannerClickBtn">
        <area shape="rect" coords="409,343,226,72,415" href="/CareerTestQuiz.aspx" alt="HTTP" />
    </map>
    <img usemap="#bannerClickBtn" src="/Images/CareerTestBanner.png" style="width: 836px; height: 418px">

    <p class="auto-style27" style ="text-align: center;">
        Unsure of what kind of degree to take or your dream career? Our test can help you.
    </p>
    <p class="auto-style27" style ="text-align: center;">
        <asp:LinkButton ID="LinkButtonTakeQuiz" runat="server" OnClick="LinkButtonTakeQuiz_Click" CssClass="button">Take Career Test</asp:LinkButton>
    </p>
</asp:Content>
