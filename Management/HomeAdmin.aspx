<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="HomeAdmin.aspx.cs" Inherits="UniFinder.Management.HomeAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .block {
            display: inline-block;
            width: 23.6%;
            height: 120px;
            margin: 0.5%;
            border: none;
            background-color: #04AA6D;
            color: white;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            box-sizing: border-box;
            text-decoration: none; /* Remove underline */
            line-height: 120px; /* Vertically center the text */
            vertical-align: middle; /* Ensure proper vertical alignment */
        }
            .block:hover {
                background-color: #ddd;
                color: black;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div style="overflow: hidden; width: 100%;">
        <a class="block" href="/Management/ProgrammeManagement.aspx">Manage Programme</a>
        <a class="block" href="/Management/UniManagement2.aspx">Manage University</a>
        <a class="block" href="/Management/BranchManagement.aspx">Manage Branch</a>
        <a class="block" href="/Management/AccountManagement.aspx">Manage Account</a>
    </div>
    <br />
    <br />
    <br />
</asp:Content>
