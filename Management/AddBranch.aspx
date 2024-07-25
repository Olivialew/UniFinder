<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="AddBranch.aspx.cs" Inherits="UniFinder.Management.AddBranch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">



        .auto-style27 {
            color: #000000;
            font-size: large;
        }
        .auto-style28 {
            width: 195px;
        }
        .auto-style29 {
            width: 19px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
    <span class="auto-style27"><strong>
                Add Branch</strong></span></p>
    <p>
        <table style="width:100%;">
            <tr>
                <td class="auto-style28">University*</td>
                <td class="auto-style29">&nbsp;</td>
                <td>
                <asp:DropDownList ID="ddlUni" runat="server" DataSourceID="SqlDataSource1" DataTextField="uniNameEng" DataValueField="uniID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [University]"></asp:SqlDataSource>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlUni" ErrorMessage="University is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style28">&nbsp;</td>
                <td class="auto-style29">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style28">Location*</td>
                <td class="auto-style29">&nbsp;</td>
                <td>
                    <asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="SqlDataSource2" DataTextField="location" DataValueField="location">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Branch]"></asp:SqlDataSource>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlLocation" ErrorMessage="Location is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style28">&nbsp;</td>
                <td class="auto-style29">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style28">Address*</td>
                <td class="auto-style29">&nbsp;</td>
                <td>
                    <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtAddress" ErrorMessage="Address is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </p>
   
    <strong>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
        <p>
        <br />
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
    <br />
        <br />
        <asp:Button ID="btnClearBranch" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
        <asp:Button ID="btnAddBranch" runat="server" OnClick="btnAddBranch_Click" Text="Submit" />
    </strong>
    </p>
</asp:Content>
