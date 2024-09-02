<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="AccountManagement.aspx.cs" Inherits="UniFinder.Management.AccountManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .centered-text {
            display: flex;
            justify-content: center; /* Centers horizontally */
            align-items: center; /* Centers vertically */
            height: 100%; /* Ensure the container has height if vertical centering is needed */
            text-align: center; /* Center text within the container */
        }

        .auto-style2 {
            font-size: large;
        }

        .search-box {
            width: 300px;
        }

        .auto-style3 {
            font-size: medium;
        }

        .auto-style4 {
            width: 300px;
            font-size: medium;
        }
        .auto-style5 {
            font-size: x-large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="centered-text">
        <strong><span class="auto-style5">Account Management</span></strong>
    </div>
    <p class="auto-style3"><strong>Search By:</strong></p>
    <p class="auto-style2">
        <strong>
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Enter Username" CssClass="auto-style4"></asp:TextBox>
            <span class="auto-style3">&nbsp;&nbsp;&nbsp;&nbsp; </span>
            <asp:Button ID="btnSearch" runat="server" BackColor="#009999" BorderStyle="None" Height="33px" Text="Search" Width="129px" Style="border-radius: 10px;" ForeColor="#242424" OnClick="btnSearch_Click" CssClass="auto-style3" />
            <span class="auto-style3">&nbsp;</span>
            <asp:Button ID="btnReset" runat="server" BackColor="#242424" BorderStyle="Solid" Height="33px" Text="Reset" Width="129px" Style="border-radius: 10px; color: #FFFFFF; font-size: medium;" BorderColor="#009999" CssClass="auto-style21" OnClick="btnReset_Click" />
        </strong>
    </p>
    <p class="auto-style3">
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Management/CreateAdmin.aspx">Create Admin</asp:HyperLink>
    </p>
    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete this account? This action cannot be undone.");
        }
        function confirmDisable() {
            return confirm("Are you sure you want to disable this account?");
        }
        function confirmReactivate() {
            return confirm("Are you sure you want to reactivate this account?");
        }
    </script>
    <p class="auto-style2">
        <asp:GridView ID="GridView1" runat="server" CssClass="gridview-table" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="UserName" ForeColor="#333333" GridLines="None" AllowPaging="True" AllowSorting="True" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowCommand="GridView1_RowCommand">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField  ShowEditButton="True" />
<%--ShowDeleteButton="True"--%>
                <asp:TemplateField HeaderText="Username" SortExpression="UserName">
                    <ItemTemplate>
                        <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtUserName" runat="server" Text='<%# Bind("UserName") %>' ReadOnly="True" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Email" SortExpression="Email">
                    <ItemTemplate>
                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Role">
                    <ItemTemplate>
                        <asp:Label ID="lblRole" runat="server" Text='<%# GetUserRoles(Eval("UserName").ToString()) %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server" Text='<%# (bool)Eval("IsApproved") ? "Active" : "Disabled" %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
<%--                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%# Eval("UserName") %>' />--%>
                        <asp:Button ID="btnDisable" runat="server" Text="Disable" CommandName="Disable" CommandArgument='<%# Eval("UserName") %>' OnClientClick="return confirmDisable();" />
                        <asp:Button ID="btnReactivate" runat="server" Text="Reactivate" CommandName="Reactivate" CommandArgument='<%# Eval("UserName") %>' OnClientClick="return confirmReactivate();" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# Eval("UserName") %>' OnClientClick="return confirmDelete();" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandName="Update" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" />
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#7C6F57" />
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#E3EAEB" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F8FAFA" />
            <SortedAscendingHeaderStyle BackColor="#246B61" />
            <SortedDescendingCellStyle BackColor="#D4DFE1" />
            <SortedDescendingHeaderStyle BackColor="#15524A" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
        <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
    </p>
</asp:Content>
