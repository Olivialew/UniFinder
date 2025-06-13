<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="UniFinder.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .img {
            margin-left: 0px;
        }

        .frame {
            margin-left: 0px;
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

        .auto-style24 {
            max-width: 1000px;
            position: relative;
            margin: auto;
            left: 1px;
            top: 0px;
        }

        .auto-style25 {
            font-size: x-large;
        }

        .scroll-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
            position: relative;
        }

        .data-list-wrapper {
            overflow-x: auto;
            overflow-y: hidden;
            white-space: nowrap;
            flex-grow: 1;
            scroll-behavior: smooth;
            margin: 0 20px; /* Adds some space for arrows */
        }

        .program-item {
            display: inline-block;
            width: 300px; /* Adjust width as needed */
            padding: 10px;
            box-sizing: border-box;
        }

        .scroll-btn {
            background-color: #ccc;
            border: none;
            padding: 10px;
            cursor: pointer;
            z-index: 100;
        }

            .scroll-btn.left {
                position: absolute;
                left: 0;
            }

            .scroll-btn.right {
                position: absolute;
                right: 0;
            }

        .programmeImgContainer {
            /* Adjust to maintain the aspect ratio and size */
            width: 300px;
            height: 300px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /*.uniLogo {
            width: 253px;
            height: 375.14px;
            margin-right: 2.5%;
            box-sizing: border-box;
        }*/

        .uniLogo {
            width: 80%;
            height: 80%;
            object-fit: contain; /* Ensures the image fits within the square without distortion */
        }

        .programmeName {
            color: #242424;
        }

        .auto-style37 {
            font-size: xx-large;
            color: #000000;
        }

        .search-box {
            width: 300px;
        }

        .search-btn {
            margin-left: 10px;
        }

        .comparison-table {
            color: black;
        }

        .programmeName, .fees, .location, .duration {
            color: #000000; /* Ensures text is black */
        }

        /*.program-item {
            flex: 0 0 220px;*/ /* Fixed width for each item to show 4 items in view */
        /*padding: 10px;
            box-sizing: border-box;
            text-align: center;
            background-color: #f8f8f8;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin: 0 10px;*/ /* Space between items */
        /*}*/
        .program-item {
            /*display: inline-block;*/
            display: flex;
            flex-direction: column;
            align-items: center; /* Centers content horizontally */
            /*width: 24%;*/ /* Adjust this width to ensure four items per row */
            /*box-sizing: border-box;*/
            padding: 10px;
            margin: 0;
            /*background-color: #f8f8f8;
            border: 1px solid #ddd;
            border-radius: 5px;*/
        }

            .program-item .btnAddToCompare {
                padding: 10px 20px;
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background-color: #005f5f;
                border: none;
                border-radius: 5px;
                color: white;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                text-align: center;
                margin-top: 10px; /* Adds space between the button and the content above */
                transition: background-color 0.3s ease; /* Smooth transition for hover effect */
            }

                .program-item .btnAddToCompare:hover {
                    background-color: #009999; /* Change background on hover */
                }

        .scroll-container {
            display: flex;
            flex-direction: column;
            align-items: center; /* Center items horizontally */
            width: 100%;
            position: relative;
            overflow: hidden; /* Hide overflow if necessary */
        }

        .data-list-wrapper {
            display: flex;
            flex-wrap: wrap; /* Allow items to wrap to the next line */
            justify-content: center; /* Center items horizontally */
            width: 100%;
            max-width: 1200px; /* Adjust to fit 4 items at a time */
            margin: 0 auto; /* Center container */
            box-sizing: border-box; /* Include padding and border in element's total width and height */
        }

        /*.program-item {
            flex: 0 0 22%;*/ /* Adjust width to fit 4 items (with margin) */
        /*margin: 10px;*/ /* Space between items */
        /*box-sizing: border-box;*/ /* Include padding and border in element's total width and height */
        /*background-color: #f8f8f8;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
            padding: 10px;*/ /* Add padding inside each item */
        /*height: auto;*/ /* Allow height to adjust based on content */
        /*}*/

        .programmeName {
            word-wrap: break-word; /* Allow long words to wrap onto the next line */
            overflow-wrap: break-word; /* Handle text overflow */
            margin-top: 10px; /* Add some space above the name */
            font-size: 16px; /* Adjust as needed */
            font-weight: bold; /* Optionally, make the name bold */
            display: block; /* Make sure the name behaves like a block-level element */
        }

        .button-container {
            text-align: center; /* Center-aligns content inside this container */
            width: 100%; /* Full width of the container */
        }

        .see-more {
            display: inline-block; /* Keep the button size as per content */
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            text-align: center;
        }

            .see-more:hover {
                background-color: #0056b3;
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

    <div class="auto-style24">

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

    <br />
    <br />

    <span class="auto-style25"><strong>Programme</strong></span>
    <br />
    <%--<div class="scroll-container">--%>
    <%--<div class="data-list-wrapper">--%>
    <%--<asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" RepeatColumns="4">
                <ItemTemplate>
                    <div class="program-item">
                        <div class="programmeImgContainer">
                            <asp:ImageButton ID="imgUni" runat="server" ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>' AlternateText='<%# Eval("ProgrammeName") %>' CssClass="uniLogo" OnClick="imgBtnSelectProgram" />
                        </div>
                        <div class="programmeName">
                            <asp:Label ID="lblProgrammeName" runat="server" Text='<%# Eval("ProgrammeName") %>'></asp:Label>
                        </div>
                        <div class="fees">
                            Tuition Fees: RM
                        <asp:Label ID="lblFees" runat="server" Text='<%# Eval("fees") %>'></asp:Label>
                        </div>
                        <div class="location">
                            Location: 
                        <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("location") %>'></asp:Label>
                        </div>
                        <div class="duration">
                            Duration: 
                        <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("duration") %>'></asp:Label>
                            years
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>--%>
    <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" RepeatColumns="4">
        <ItemTemplate>
            <div class="program-item">
                <div class="programmeImgContainer">
                    <%--<asp:ImageButton ID="imgUni" runat="server" ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>' AlternateText='<%# Eval("ProgrammeName") %>' CssClass="uniLogo" />--%>
                    <asp:ImageButton ID="imgUni" runat="server" ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>' AlternateText='<%# Eval("ProgrammeName") %>' CssClass="uniLogo" OnClick="imgBtnSelectProgram" />
                </div>
                <div class="programmeName">
                    <asp:Label ID="lblProgrammeName" runat="server" Text='<%# Eval("ProgrammeName") %>'></asp:Label>
                </div>
                <div class="fees">
                    Tuition Fees: RM
                <asp:Label ID="lblFees" runat="server" Text='<%# Eval("fees") %>'></asp:Label>
                </div>
                <div class="location">
                    Location:
                <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("location") %>'></asp:Label>
                </div>
                <div class="duration">
                    Duration:
                <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("duration") %>'></asp:Label>
                </div>
            </div>
        </ItemTemplate>
    </asp:DataList>
    <%--</div>--%>
    <div class="button-container">
        <a href="/Programme.aspx" class="see-more">See More</a>
    </div>
    <%--</div>--%>

    <br />
    <br />
    <span class="auto-style25"><strong>Universities</strong></span>
    <br />
    <asp:DataList ID="DataList2" runat="server" RepeatDirection="Horizontal" RepeatColumns="4" Height="460px">
        <ItemTemplate>
            <div class="program-item">
                <div class="uniImgContainer">
                    <asp:ImageButton
                        ID="imgUni"
                        runat="server"
                        ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>'
                        AlternateText='<%# GetUniName(Eval("uniNameEng"), Eval("uniNameMalay")) %>'
                        CssClass="uniLogo"
                        Style="max-height: 300px; max-width: 300px; margin-right: 50px; margin-left: 20px; margin-top: 10px"
                        OnClick="imgBtnSelectUni"
                        data-unieng='<%# Eval("uniNameEng") %>'
                        data-unimalay='<%# Eval("uniNameMalay") %>' />
                </div>
                <div class="uniName">
                    <strong>
                        <asp:Label
                            ID="lblUniName"
                            runat="server"
                            Text='<%# GetUniName(Eval("uniNameEng"), Eval("uniNameMalay")) %>'></asp:Label></strong>
                </div>
            </div>
        </ItemTemplate>
    </asp:DataList>

    <div class="button-container">
        <a href="/University.aspx" class="see-more">See More</a>
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

        function scrollLeft() {
            const container = document.querySelector('.data-list-wrapper');
            const scrollAmount = 240 * 4; // Adjust the amount to match 4 items
            container.scrollBy({ left: -scrollAmount, behavior: 'smooth' });
        }

        function scrollRight() {
            const container = document.querySelector('.data-list-wrapper');
            const scrollAmount = 240 * 4; // Adjust the amount to match 4 items
            container.scrollBy({ left: scrollAmount, behavior: 'smooth' });
        }

    </script>
</asp:Content>
