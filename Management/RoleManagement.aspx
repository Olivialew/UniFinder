<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="RoleManagement.aspx.cs" Inherits="UniFinder.RoleManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        
        .auto-style2 {
            width: 21px;
        }
        .auto-style27 {
            width: 177px;
        }
        .auto-style28 {
            font-size: large;
        }
        .auto-style29 {
            width: 241px;
            font-size: large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <strong><span class="auto-style28">Role Management</span></strong><span class="auto-style29"><strong>
                </strong></span>
        <br class="auto-style28" />
        <br class="auto-style28" />
        <table style="width: 100%;">
            <tr>
                <td class="auto-style27">Role</td>
                <td class="auto-style2">:</td>
                <td>
                    <asp:TextBox ID="txtRole" runat="server"></asp:TextBox>
                    &nbsp;<asp:Button ID="btnCreate" runat="server" OnClick="btnCreate_Click" Text="Create" />
                </td>
            </tr>
            <tr>
                <td class="auto-style27">&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style27">Display Role(s)<br />
                </td>
                <td class="auto-style2">:</td>
                <td>
                    <asp:Button ID="btnRetrieve" runat="server" OnClick="btnRetrieve_Click" Text="Retrieve Role" />
                    <br />
                    <br />
                    Select Role<br />
                    <asp:ListBox ID="lstRole" runat="server" AutoPostBack="True" OnSelectedIndexChanged="lstRole_SelectedIndexChanged" Height="150px" Width="160px"></asp:ListBox>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style27">&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style27">Display User(s)</td>
                <td class="auto-style2">:</td>
                <td>
                    <asp:Button ID="btnRetrieveU" runat="server" OnClick="btnRetrieveU_Click" Text="Retrieve User" />
                    <br />
                    <br />
                    Select User<br />
                    <asp:ListBox ID="lstUser" runat="server" AutoPostBack="True" OnSelectedIndexChanged="lstUser_SelectedIndexChanged" Height="150px" Width="160px"></asp:ListBox>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style27">&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style27">Assign user to Role</td>
                <td class="auto-style2">:</td>
                <td><asp:TextBox ID="txtR" runat="server"></asp:TextBox>
                    <asp:TextBox ID="txtU" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;<asp:Button ID="btnAssign" runat="server" OnClick="btnAssign_Click" Text="Assign" />
                </td>
            </tr>
            <tr>
                <td class="auto-style27">&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style27">Display Users based on Role Selected</td>
                <td class="auto-style2">:</td>
                <td>
                        <asp:Button ID="btnGetRole" runat="server" OnClick="btnGetRole_Click" Text="Get Role" />
                    <br />
                    <asp:DropDownList ID="ddlRole" runat="server" AutoPostBack="True">
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                        </td>
            </tr>
            <tr>
                <td class="auto-style27">&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style27">&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>
                    <asp:Button ID="btnDisplayU" runat="server" OnClick="btnDisplayU_Click" Text="Display User based on Role Selected" Width="292px" />
                    <br />
                    <asp:ListBox ID="lstUR" runat="server" Height="150px" Width="160px"></asp:ListBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
            </tr>
            <tr>
                <td class="auto-style27">&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style27">&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style27">&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style27">&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style27">&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>
</asp:Content>
