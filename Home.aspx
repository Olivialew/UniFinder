<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="UniFinder.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        body, html {
            height: 100%;
        }

        /* The hero image */
        .hero-image {
            /* Use "linear-gradient" to add a darken background effect to the image (photographer.jpg). This will make the text easier to read */
            background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url("~/Images/EduPathBanner.png");
            /* Set a specific height */
            height: 50%;
            /* Position and center the image to scale nicely on all screens */
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            position: relative;
        }

        /* Place text in the middle of the image */
        .hero-text {
            text-align: center;
            position: absolute;
            top: 50%;
            right: 10%;
            transform: translate(-50%, -50%);
            color: white;
        }
    </style>
    <div class="hero-image">
        <div class="hero-text">
<%--            <h1>I am John Doe</h1>
            <p>And I'm a Photographer</p>--%>
            <button>Find now</button>
        </div>
    </div>
</asp:Content>
