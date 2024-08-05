<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="UniFinder.Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /*table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        .auto-style27 {
            font-size: medium;
        }*/

        /* Ensure the TreeView has minimal padding and margin */
        /*.treeview {
            padding: 0;
            margin: 0;
        }*/

        /* Adjust the TreeView nodes */
        /*.treeview ul {
            list-style-type: none;*/ /* Remove bullet points */
        /*padding-left: 20px;*/ /* Adjust padding as needed */
        /*}

        .treeview li {
            margin: 0;
            padding: 5px 10px;*/ /* Adjust padding for each item */
        /*border: none;*/ /* Remove border if any */
        /*}*/

        /* Additional adjustments for TreeView appearance */
        /*.treeview a {
            text-decoration: none;*/ /* Remove underline from links */
        /*color: black;*/ /* Set text color */
        /*}

        .treeview a:hover {
            text-decoration: underline;*/ /* Add underline on hover */
        /*}*/
    </style>

    <p class="auto-style27">
        <strong>Wishlist</strong>
    </p>
    <p>
        <asp:LoginView ID="LoginView1" runat="server">
        </asp:LoginView>
    </p>
    <p>
        Status:
        <asp:LoginStatus ID="LoginStatus1" runat="server" LogoutAction="Redirect" LogoutPageUrl="~/Home.aspx" />
    </p>

    <div>
        <strong>University Comparison<br />
        </strong>
        <%--        <asp:GridView ID="ComparisonGridView" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="UniversityName" HeaderText="University Name" />
                <asp:BoundField DataField="ProgrammeName" HeaderText="Programme Name" />
                <asp:BoundField DataField="Location" HeaderText="Location" />
                <asp:BoundField DataField="Fees" HeaderText="Tuition Fees" />
                <asp:BoundField DataField="Duration" HeaderText="Duration" />
            </Columns>
        </asp:GridView>--%>
        <asp:GridView ID="comparisonGridView" runat="server" AutoGenerateColumns="False" CssClass="comparison-table" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2">
            <Columns>
                <asp:BoundField DataField="ProgrammeName" HeaderText="Programme Name" />
                <asp:BoundField DataField="Fees" HeaderText="Fees" />
                <asp:BoundField DataField="Location" HeaderText="Location" />
                <asp:BoundField DataField="University" HeaderText="University" />
                <asp:BoundField DataField="Duration" HeaderText="Duration" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="RemoveButton" runat="server" Text="Remove" CommandArgument='<%# Eval("ProgramID") %>' OnClick="RemoveButton_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FFF1D4" />
            <SortedAscendingHeaderStyle BackColor="#B95C30" />
            <SortedDescendingCellStyle BackColor="#F1E5CE" />
            <SortedDescendingHeaderStyle BackColor="#93451F" />
        </asp:GridView>

    </div>

    <p>
        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Home.aspx">Go Back to Menu</asp:HyperLink>
    </p>
</asp:Content>
