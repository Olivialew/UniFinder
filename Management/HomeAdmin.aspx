<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="HomeAdmin.aspx.cs" Inherits="UniFinder.Management.HomeAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .block {
            flex-basis: calc(23.6% - 1%); /* Adjust for margin */
            width: 350px;
            height: 120px;
            margin: 0.5%;
            border: none;
            background-color: #04AA6D;
            color: white;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            box-sizing: border-box;
            text-decoration: none;
            line-height: 120px;
            vertical-align: middle;
        }

        .block-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            padding: 10px;
            box-sizing: border-box;
        }

        .block:hover {
            background-color: #ddd;
            color: black;
        }

        .block-wrapper {
            width: 100%;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            padding: 10px;
            box-sizing: border-box; /* Ensure padding and border are included in the element's width */
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="block-wrapper">
        <a class="block" href="/Management/ProgrammeManagement.aspx">Manage Programme</a>
        <a class="block" href="/Management/UniManagement2.aspx">Manage University</a>
        <a class="block" href="/Management/BranchManagement.aspx">Manage Branch</a>
        <a class="block" href="/Management/AccountManagement.aspx">Manage Account</a>
    </div>
    <br />
    <br />
    <br />
</asp:Content>
