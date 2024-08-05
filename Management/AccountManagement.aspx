<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="AccountManagement.aspx.cs" Inherits="UniFinder.Management.AccountManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
    .auto-style2 {
        font-size: large;
    }

        .search-box {
            width: 300px;
        }

        .auto-style3 {
        font-size: medium;
    }

        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <p class="auto-style2">
    <strong>Account Management</strong></p>
<p class="auto-style3">
    <strong>Search By:</strong></p>
    <p class="auto-style2">
                <strong>
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Enter Username" CssClass="search-box"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="btnSearch" runat="server" BackColor="#009999" BorderStyle="None" Height="33px" Text="Search" Width="129px" Style="border-radius: 10px;" ForeColor="#242424" OnClick="btnSearch_Click3" />
                    &nbsp;
                <asp:Button ID="btnReset" runat="server" BackColor="#242424" BorderStyle="Solid" Height="33px" Text="Reset" Width="129px" Style="border-radius: 10px; color: #FFFFFF;" BorderColor="#009999" CssClass="auto-style21" OnClick="btnReset_Click3" />
                    </strong></p>
    <p class="auto-style2">
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Management/CreateAdmin.aspx">Create Admin</asp:HyperLink>
                </p>
    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete this account? This action cannot be undone.");
        }
    </script>
<p class="auto-style2">
    <%--<asp:GridView ID="GridView1" runat="server" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>--%>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowDeleting="GridView1_RowDeleting" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="UserName" HeaderText="Username" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" OnClientClick="return confirmDelete();" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
    <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
</p>

</asp:Content>
