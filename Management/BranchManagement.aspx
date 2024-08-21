<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="BranchManagement.aspx.cs" Inherits="UniFinder.BranchManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .centered-text {
            display: flex;
            justify-content: center; /* Centers horizontally */
            align-items: center; /* Centers vertically */
            height: 100%; /* Ensure the container has height if vertical centering is needed */
            text-align: center; /* Center text within the container */
        }

        .auto-style27 {
            color: #000000;
            font-size: medium;
        }

        .auto-style28 {
            font-size: medium;
        }

        .auto-style30 {
            font-size: large;
        }

        .auto-style31 {
            font-size: x-large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="centered-text">
        <strong><span class="auto-style31">Branch Management</span></strong>
    </div>

    <br class="auto-style30" />
    <p class="auto-style27">
        <%--                    <span class="auto-style29"><strong>Search By</strong></span><span class="auto-style16"><br class="auto-style28" />--%>
        <%--<asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Enter university title"></asp:TextBox>--%>
        <%--                    </span>--%>
        <span class="auto-style28">
            <strong><span class="auto-style26">Filter By:
            </span>
            </strong>
        </span>
        <p class="auto-style27">
            <span class="auto-style26"><strong>University</strong><br />
                <asp:DropDownList ID="ddlUni" runat="server" DataSourceID="SqlDataSource3" DataTextField="uniNameEng" DataValueField="uniID" AutoPostBack="True" OnSelectedIndexChanged="ddlUni_SelectedIndexChanged">
                </asp:DropDownList>
            </span>
            <%--                <br /><br />
                <asp:DropDownList ID="ddlFilterBy" runat="server" AutoPostBack="true">
                    <asp:ListItem Text="Select Filter" Value=""></asp:ListItem>
                    <asp:ListItem Text="University Name" Value="UniversityName"></asp:ListItem>
                    <asp:ListItem Text="Fees" Value="Fees"></asp:ListItem>
                    <asp:ListItem Text="Duration" Value="Duration"></asp:ListItem>
                </asp:DropDownList>--%>
    <p class="auto-style27">
        <span class="auto-style26"><strong>Branch Location</strong></span><br />
        <asp:DropDownList ID="ddlBranch" runat="server" DataSourceID="SqlDataSource2" DataTextField="location" DataValueField="branchID">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [University]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT * FROM [Branch] WHERE ([uniID] = @uniID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlUni" Name="uniID" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <p class="auto-style27">
            <span class="auto-style28">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </span>
            <asp:Button ID="btnSearch" runat="server" BackColor="#009999" BorderStyle="None" Height="33px" Text="Search" Width="129px" Style="border-radius: 10px;" ForeColor="#242424" OnClick="btnSearch_Click2" />
            <span class="auto-style28">&nbsp;
            </span>
            <asp:Button ID="btnReset" runat="server" BackColor="#242424" BorderStyle="Solid" Height="33px" Text="Reset" Width="129px" Style="border-radius: 10px; color: #FFFFFF;" BorderColor="#009999" CssClass="auto-style21" OnClick="btnReset_Click2" />
            <span class="auto-style28">
                <br />
                <br />
            </span>

            <span class="auto-style28">
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Management/AddBranch.aspx">Add Branch</asp:HyperLink>
                <strong>
                    <br />
                    <br />
                </strong>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red"></asp:Label>
            </span>
            <div>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="branchID" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="branchID" HeaderText="Branch ID" ReadOnly="True" SortExpression="branchID" />
                        <asp:BoundField DataField="uniID" HeaderText="University ID" SortExpression="uniID" />
                        <asp:BoundField DataField="location" HeaderText="Location" SortExpression="location" />
                        <asp:BoundField DataField="address" HeaderText="Address" SortExpression="address" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </div>
            <strong>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    DeleteCommand="DELETE FROM [Branch] WHERE [branchID] = @branchID"
                    InsertCommand="INSERT INTO [Branch] ([branchID], [uniID], [location], [address]) VALUES (@branchID, @uniID, @location, @address)"
                    SelectCommand="SELECT * FROM [Branch]"
                    UpdateCommand="UPDATE [Branch] SET [uniID] = @uniID, [location] = @location, [address] = @address WHERE [branchID] = @branchID">
                    <DeleteParameters>
                        <asp:Parameter Name="branchID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="branchID" Type="String" />
                        <asp:Parameter Name="uniID" Type="String" />
                        <asp:Parameter Name="location" Type="String" />
                        <asp:Parameter Name="address" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="uniID" Type="String" />
                        <asp:Parameter Name="location" Type="String" />
                        <asp:Parameter Name="address" Type="String" />
                        <asp:Parameter Name="branchID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </strong>
</asp:Content>
