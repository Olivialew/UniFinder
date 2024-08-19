<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="UniFinder.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .img {
            margin-left: 0px;
        }

        .frame {
            margin-left: 0px;
        }

        .auto-style21 {
            color: #FEFFFF;
        }

        .auto-style23 {
            font-weight: normal;
            color: #FFFFFF;
        }

        .slideshow-container {
            max-width: 1000px;
            position: relative;
            margin: auto;
        }

        /* Next & previous buttons */
        .prev, .next {
            cursor: pointer;
            position: absolute;
            top: 50%;
            width: auto;
            padding: 16px;
            margin-top: -22px;
            color: white;
            font-weight: bold;
            font-size: 18px;
            transition: 0.6s ease;
            border-radius: 0 3px 3px 0;
            user-select: none;
        }

        /* Position the "next button" to the right */
        .next {
            right: 0;
            border-radius: 3px 0 0 3px;
        }

            /* On hover, add a black background color with a little bit see-through */
            .prev:hover, .next:hover {
                background-color: rgba(0,0,0,0.8);
            }


        /* Number text (1/3 etc) */
        .numbertext {
            color: #f2f2f2;
            font-size: 12px;
            padding: 8px 12px;
            position: absolute;
            top: 0;
        }

        /* The dots/bullets/indicators */
        .dot {
            height: 15px;
            width: 15px;
            margin: 0 2px;
            background-color: #bbb;
            border-radius: 50%;
            display: inline-block;
            transition: background-color 0.6s ease;
        }

        .active {
            background-color: #717171;
        }

        /* Fading animation */
        .fade {
            animation-name: fade;
            animation-duration: 1.5s;
        }

        @keyframes fade {
            from {
                opacity: .4
            }

            to {
                opacity: 1
            }
        }

        /* On smaller screens, decrease text size */
        @media only screen and (max-width: 300px) {
            .prev, .next, .text {
                font-size: 11px
            }
        }

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--    <div class="hero-image">
        <div class="hero-text">
            <%--            <h1>I am John Doe</h1>
            <p>And I'm a Photographer</p>--%>
    <%--<button>Find now</button>
        </div>
    </div>--%>
    <%--banner--%>
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
            <ContentTemplate>
                <asp:AdRotator ID="AdRotator1" runat="server" AdvertisementFile="~/slider.xml" CssClass="auto-style16"/>
                <asp:Timer ID="Timer1" runat="server" Interval="2500"></asp:Timer>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>--%>

    <div class="slideshow-container">

        <div class="frame">

            <div class="mySlides fade">
                <div class="numbertext">1 / 5</div>
                <a href="/AboutUs.aspx">
                    <img src="/Images/EduPathBanner2.png" style="width: 100%; height: 418px"></a>
            </div>

            <div class="mySlides fade">
                <div class="numbertext">2 / 5</div>
                <a href="/University.aspx">
                    <img src="/Images/UniversityBanner2.png" style="width: 100%; height: 418px"></a>
            </div>

            <div class="mySlides fade">
                <div class="numbertext">3 / 5</div>
                <a href="/Programme.aspx">
                    <img src="/Images/ProgrammeBanner.png" style="width: 100%; height: 418px"></a>
            </div>

            <div class="mySlides fade">
                <div class="numbertext">4 / 5</div>
                <a href="/CareerTest.aspx">
                    <img src="/Images/CareerTestBanner.png" style="width: 100%; height: 418px"></a>
            </div>

            <div class="mySlides fade">
                <div class="numbertext">5 / 5</div>
                <a href="/AIChatbot2.aspx">
                    <img src="/Images/AIChatbotBanner.png" style="width: 100%; height: 418px"></a>
            </div>

        </div>

        <a class="prev" onclick="plusSlides(-1)">❮</a>
        <a class="next" onclick="plusSlides(1)">❯</a>

    </div>
    <br />

    <div style="text-align: center">
        <span class="dot" onclick="currentSlide(1)"></span>
        <span class="dot" onclick="currentSlide(2)"></span>
        <span class="dot" onclick="currentSlide(3)"></span>
        <span class="dot" onclick="currentSlide(4)"></span>
        <span class="dot" onclick="currentSlide(5)"></span>
    </div>

    <script>
        var slideIndex = 1;
        var timer = null;
        showSlides(slideIndex);

        function plusSlides(n) {
            clearTimeout(timer);
            showSlides(slideIndex += n);
        }

        function currentSlide(n) {
            clearTimeout(timer);
            showSlides(slideIndex = n);
        }

        function showSlides(n) {
            var i;
            var slides = document.getElementsByClassName("mySlides");
            var dots = document.getElementsByClassName("dot");
            if (n == undefined) { n = ++slideIndex }
            if (n > slides.length) { slideIndex = 1 }
            if (n < 1) { slideIndex = slides.length }
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].className += " active";
            timer = setTimeout(showSlides, 3000);
        }
    </script>

</asp:Content>
