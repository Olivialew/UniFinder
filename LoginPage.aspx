<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage3.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="UniFinder.LoginPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<form id="form1" runat="server">--%>

    <style>
        *, ::after, ::before {
            box-sizing: border-box;
        }

        .button{
            border: 1px solid rgba(0, 0, 0, 0);
            border-width: 0;
            border-style: solid;
            border-color: transparent;
            line-height: 1.42857;
            border-radius: 3px;
            transition: all 0.2s ease-in-out 0s;
            vertical-align: middle;
            white-space: nowrap;
            font-family: rubik;
            background-color: #f7b205;
            color: #000;
            font-size: 16px;
            font-weight: 500;
        }

        .button:hover{
            border: 1px solid rgba(0, 0, 0, 0);
            border-width: 0;
            border-style: solid;
            border-color: transparent;
            line-height: 1.42857;
            border-radius: 3px;
            transition: all 0.2s ease-in-out 0s;
            vertical-align: middle;
            white-space: nowrap;
            font-family: rubik;
            background-color: #4c1864;
            color: #fff;
            font-size: 16px;
            font-weight: 500;
        }

        .box{
            padding: 15px;
            box-shadow: 0 0 25px 0 rgba(29, 25, 0, 0.25);
            border-radius: 4px;
            overflow: hidden;
            height: 550px;
        }

        .form-control {
            width: auto;
        }

        h2{
            width: max-content;
        }
    </style>

        <div>
            <h2 class="title-head">Welcome to EduPath!</h2>
            <asp:Login ID="Login1" runat="server" OnAuthenticate="Login1_Authenticate">
                <LayoutTemplate>
                    <div class="box">
                        <table cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
                            <tr>
                                <td>
                                    <table cellpadding="0">
                                        <tr>
                                            <!--<td align="center" colspan="2" style="color:White;background-color:#5D7B9D;font-size:0.9em;font-weight:bold;">Log In</td>-->
                                            <td align="left" colspan="2"><h2 class="title-head">Login to your <span>Account</span></h2></td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" CssClass="form-label">Username</asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="UserName" runat="server" Font-Size="0.8em" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="Username is required." ToolTip="Username is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="middle" style="height: 100px;">
                                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" CssClass="form-label">Password</asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="Password" runat="server" Font-Size="0.8em" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div class="form-group form-forget">
                                                    <div class="custom-control custom-checkbox">
                                                        <asp:CheckBox ID="RememberMe" runat="server" CssClass="custom-control-input"/>
                                                        <label class="form-check-label" for="chkRememberMe">Remember me</label>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2" style="color:Red;">
                                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="2">
                                                <asp:Button ID="LoginButton" runat="server" CssClass="button" CommandName="Login" Text="Log In" ValidationGroup="Login1" Height="43px" Width="105px" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </LayoutTemplate>
            </asp:Login>
            <p><asp:Label ID="lblErrorMsg" runat="server"></asp:Label></p>
            Create new account?
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/CreateUser.aspx">Click Here</asp:HyperLink>
            <br />
            <br />
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Home.aspx">Go Back to Menu</asp:HyperLink>
        </div>
   <%-- </form>--%>
</asp:Content>

