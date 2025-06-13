<%@ Page Title="About Us" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="UniFinder.AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        /* General styling */
        .about-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
        }

        .about-container h3 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 20px;
        }

        .about-container p, .about-container ul {
            font-size: 1rem;
            line-height: 1.6;
            color: #555;
        }

        .about-container ul {
            list-style-type: disc;
            margin-left: 20px;
        }

        .about-container ul li {
            margin-bottom: 10px;
        }

        .about-container strong {
            color: #000;
        }

        .contact-info {
            margin-top: 20px;
        }

        .contact-info a {
            color: #007BFF;
            text-decoration: none;
        }

        .contact-info a:hover {
            text-decoration: underline;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="about-container">
        <h3><strong>About Us</strong></h3>
        <p><strong>Welcome to EduPath</strong></p>
        <p>At EduPath, we believe that every student should find the perfect university that matches their goals, interests, and passion. Whether you are a high school student looking to advance your studies to the tertiary level or a professional seeking to further your degree, EduPath is the one-stop destination to find your desired programme and university.</p>

        <p><strong>Our Mission</strong></p>
        <p>Our mission is to simplify the college-finding process by offering a comprehensive, user-friendly platform that connects students with local educational institutions in Malaysia. We aim to provide students with the information and tools they need to make informed decisions about their future.</p>

        <p><strong>What We Offer</strong></p>
        <ul>
            <li><strong>Centralised University Database:</strong> Explore hundreds of universities and colleges across various states, programmes, and fields of study.</li>
            <li><strong>Detailed Information:</strong> Access essential details about each university such as branches, founding year, campus tours, programmes offered, tuition fees, and more.</li>
            <li><strong>Career Path:</strong> Take a career test to discover which field of study suits you best and get recommendations for relevant programmes.</li>
            <li><strong>Wishlist:</strong> Compare desired programmes side-by-side to get a clearer picture of critical aspects such as tuition fees, location, and university.</li>
            <li><strong>Personal AI Assistant:</strong> If you have any doubts, you can always ask our AI chatbot questions about universities or programmes offered.</li>
        </ul>

        <p><strong>Why Choose UniFinder?</strong></p>
        <ul>
            <li><strong>Expertise:</strong> Our team consists of skilled admins, IT technicians, software engineers, top management, education professionals, former admission officers, and data analysts to help you succeed.</li>
            <li><strong>Accuracy:</strong> Our admin regularly updates our database to ensure the most up-to-date and accurate information is available on the website.</li>
            <li><strong>User-Friendly Experience:</strong> Our intuitive interface makes it easy for users to learn and use, including navigating, searching, and comparing universities.</li>
            <li><strong>Support:</strong> We offer personalized support to answer questions and help solve problems encountered during your university search.</li>
        </ul>

        <p><strong>Contact Us</strong></p>
        <p class="contact-info">Have any questions or need help? Our support team is always ready to assist! Reach out to us at <a href="mailto:support@edupath.com">support@edupath.com</a> or follow us on social media for the latest updates and useful tips.</p>
    </div>
</asp:Content>
