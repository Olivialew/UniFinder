<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage3.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="UniFinder.LoginPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<form id="form1" runat="server">--%>
        <div>
            Welcome to EduPath!<br />
            <asp:Login ID="Login1" runat="server" OnAuthenticate="Login1_Authenticate">
            </asp:Login>
            <br />
            <asp:Label ID="lblErrorMsg" runat="server"></asp:Label>
            <br />
            <br />
            Create new account?
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/CreateUser.aspx">Click Here</asp:HyperLink>
            <br />
            <br />
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Home.aspx">Go Back to Menu</asp:HyperLink>
        </div>
   <%-- </form>--%>
</asp:Content>

