﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="ProgrammeManagement.aspx.cs" Inherits="UniFinder.Programme_Management" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .centered-text {
            display: flex;
            justify-content: center; /* Centers horizontally */
            align-items: center; /* Centers vertically */
            height: 100%; /* Ensure the container has height if vertical centering is needed */
            text-align: center; /* Center text within the container */
        }

        .search-sort-container {
            display: flex;
            justify-content: space-between; /* Distributes space between search and sort */
            align-items: center;
        }

        .search-container {
            flex-grow: 1; /* Optional: ensures search box takes up remaining space */
        }

        .sort-container {
            display: flex;
            align-items: center;
            gap: 10px; /* Space between "Sort by" text and dropdown */
        }

        .sort-by-text {
            color: rgb(255, 255, 255);
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            font-size: medium;
        }

        .comparison-table {
            color: black;
        }

        .auto-style39 {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            font-size: medium;
        }

        .auto-style28 {
            font-size: x-large;
        }

        .search-box {
            width: 300px;
        }

        .search-btn {
            margin-left: 10px;
        }

        .gridview-container {
            width: 100%;
            overflow-x: auto; /* Allows horizontal scrolling if content exceeds container width */
        }

        .gridview-table {
            width: 100%;
            table-layout: fixed; /* Ensures columns don’t expand too much */
        }

            .gridview-table th, .gridview-table td {
                word-wrap: break-word; /* Ensures long words break to fit within cells */
            }

            .gridview-table .editable-textbox {
                width: 100%;
                box-sizing: border-box;
            }

        .editable-textbox {
            width: 100%;
            box-sizing: border-box; /* Ensures padding is included in the width */
            overflow: auto; /* Adds scrollbars if the content overflows */
        }

            .editable-textbox[rows] {
                resize: vertical; /* Allows vertical resizing only */
            }

        @media (max-width: 768px) {
            .gridview-table {
                font-size: 14px; /* Adjust font size for smaller screens */
            }

                .gridview-table th, .gridview-table td {
                    display: block;
                    width: 100%;
                    box-sizing: border-box;
                }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="centered-text">
        <strong><span class="auto-style28">Programme Management</span></strong>
    </div>
    <br />
    <div class="search-sort-container">
        <div class="search-container">
            <strong class="auto-style39"><span class="comparison-table">Search by:</span></strong>
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Enter Programme Name" CssClass="search-box"></asp:TextBox>
        </div>

        <div class="sort-container">
            <strong>Sort by: </strong>
            <asp:DropDownList ID="ddlSortBy" runat="server">
                <asp:ListItem Value="">Select</asp:ListItem>
                <asp:ListItem Value="fees_asc">Fees (Low to High)</asp:ListItem>
                <asp:ListItem Value="fees_desc">Fees (High to Low)</asp:ListItem>
                <asp:ListItem Value="name_asc">Programme Name (A to Z)</asp:ListItem>
                <asp:ListItem Value="name_desc">Programme Name (Z to A)</asp:ListItem>
                <asp:ListItem Value="latest">Latest Record (by ProgramID)</asp:ListItem>
                <asp:ListItem Value="oldest">Oldest Record (by ProgramID)</asp:ListItem>
            </asp:DropDownList>

        </div>
    </div>
    <br />
    <br />
    <strong>Filter by:<br />
        University<br />
        <asp:DropDownList ID="ddlUni" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlUni_SelectedIndexChanged">
        </asp:DropDownList>

        <%--                <br /><br />
                <asp:DropDownList ID="ddlFilterBy" runat="server" AutoPostBack="true">
                    <asp:ListItem Text="Select Filter" Value=""></asp:ListItem>
                    <asp:ListItem Text="University Name" Value="UniversityName"></asp:ListItem>
                    <asp:ListItem Text="Fees" Value="Fees"></asp:ListItem>
                    <asp:ListItem Text="Duration" Value="Duration"></asp:ListItem>
                </asp:DropDownList>--%>
        <br />
        <br />
    </strong>
    <span class="auto-style26"><strong>Branch Location</strong></span><strong><br />
        <asp:DropDownList ID="ddlBranch" runat="server" DataTextField="location" DataValueField="branchID">
        </asp:DropDownList>
        <br />
        <br />
    </strong>
    <span class="auto-style26"><strong>Fees</strong></span><strong><br class="auto-style26" />
    </strong>
    <span class="auto-style26"><strong>Minimum: </strong></span>
    <strong>
        <asp:TextBox ID="txtMinFees" runat="server"></asp:TextBox><br class="auto-style26" />
    </strong>
    <span class="auto-style26"><strong>Maximum: </strong></span>
    <strong>
        <asp:TextBox ID="txtMaxFees" runat="server"></asp:TextBox></strong><span class="auto-style26"><strong><br />
            <br />
            Duration</strong><br />
        </span>
    <asp:TextBox ID="txtDuration" runat="server"></asp:TextBox>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [University]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM [Branch] WHERE ([uniID] = @uniID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlUni" Name="uniID" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    &nbsp;<asp:Button ID="btnSearch" runat="server" BackColor="#009999" BorderStyle="None" Height="33px" Text="Search" Width="129px" Style="border-radius: 10px;" ForeColor="#242424" OnClick="btnSearch_Click3" />
    &nbsp;
          <asp:Button ID="btnReset" runat="server" BackColor="#242424" BorderStyle="Solid" Height="33px" Text="Reset" Width="129px" Style="border-radius: 10px; color: #FFFFFF;" BorderColor="#009999" CssClass="auto-style21" OnClick="btnReset_Click3" />
    <br />
    <br />
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Management/AddProgramme.aspx">Add Programme</asp:HyperLink>
    <strong>
        <br />
        <br />
    </strong>
    <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>

    <asp:Label ID="lblNoPrograms" runat="server" ForeColor="Red" Visible="False"></asp:Label>


    <div class="gridview-container">
        <asp:GridView ID="GridView1" runat="server" CssClass="gridview-table" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="programID" ForeColor="#333333" GridLines="None" AllowPaging="True" AllowSorting="True" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDeleting="GridView1_RowDeleting">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />

                <%--<asp:BoundField DataField="programID" HeaderText="Programme ID" SortExpression="programID" />--%>

                <asp:TemplateField HeaderText="Programme ID" SortExpression="programID">
                    <ItemTemplate>
                        <asp:Label ID="lblProgramID" runat="server" Text='<%# Eval("programID") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="lblProgramID" runat="server" Text='<%# Eval("programID") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Programme Name" SortExpression="programName">
                    <ItemTemplate>
                        <asp:Label ID="lblProgrammeName" runat="server" Text='<%# Eval("programName") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtProgramName" runat="server" Text='<%# Eval("programName") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Programme Link" SortExpression="programLink">
                    <ItemTemplate>
                        <asp:Label ID="lblProgramLink" runat="server" Text='<%# Eval("programLink") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtProgramLink" runat="server" Text='<%# Bind("programLink") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Introduction" SortExpression="introduction">
                    <ItemTemplate>
                        <asp:Label ID="lblIntroduction" runat="server" Text='<%# Eval("introduction") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtIntroduction" runat="server" Text='<%# Bind("introduction") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Contact" SortExpression="contact">
                    <ItemTemplate>
                        <asp:Label ID="lblContact" runat="server" Text='<%# Eval("contact") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtContact" runat="server" Text='<%# Bind("contact") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Duration" SortExpression="duration">
                    <ItemTemplate>
                        <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("duration") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDuration" runat="server" Text='<%# Bind("duration") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fees" SortExpression="fees">
                    <ItemTemplate>
                        <asp:Label ID="lblFees" runat="server" Text='<%# Eval("fees") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtFees" runat="server" Text='<%# Bind("fees") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Faculty Link" SortExpression="facLink">
                    <ItemTemplate>
                        <asp:Label ID="lblFacLink" runat="server" Text='<%# Eval("facLink") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtFacLink" runat="server" Text='<%# Bind("facLink") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="University ID" SortExpression="uniID">
                    <ItemTemplate>
                        <asp:Label ID="lblUniID" runat="server" Text='<%# Eval("uniID") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtUniID" runat="server" Text='<%# Bind("uniID") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Branch ID" SortExpression="branchID">
                    <ItemTemplate>
                        <asp:Label ID="lblBranchID" runat="server" Text='<%# Eval("branchID") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtBranchID" runat="server" Text='<%# Bind("branchID") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
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
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Programme] WHERE [programID] = @programID" InsertCommand="INSERT INTO [Programme] ([programID], [programName], [programLink], [introduction], [contact], [duration], [fees], [facLink], [uniID], [branchID]) VALUES (@programID, @programName, @programLink, @introduction, @contact, @duration, @fees, @facLink, @uniID, @branchID)" SelectCommand="SELECT * FROM [Programme]" UpdateCommand="UPDATE [Programme] SET [programName] = @programName, [programLink] = @programLink, [introduction] = @introduction, [contact] = @contact, [duration] = @duration, [fees] = @fees, [facLink] = @facLink, [uniID] = @uniID, [branchID] = @branchID WHERE [programID] = @programID">
        <DeleteParameters>
            <asp:Parameter Name="programID" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="programID" Type="String" />
            <asp:Parameter Name="programName" Type="String" />
            <asp:Parameter Name="programLink" Type="String" />
            <asp:Parameter Name="introduction" Type="String" />
            <asp:Parameter Name="contact" Type="String" />
            <asp:Parameter Name="duration" Type="Int32" />
            <asp:Parameter Name="fees" Type="Int32" />
            <asp:Parameter Name="facLink" Type="String" />
            <asp:Parameter Name="uniID" Type="String" />
            <asp:Parameter Name="branchID" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="programName" Type="String" />
            <asp:Parameter Name="programLink" Type="String" />
            <asp:Parameter Name="introduction" Type="String" />
            <asp:Parameter Name="contact" Type="String" />
            <asp:Parameter Name="duration" Type="Int32" />
            <asp:Parameter Name="fees" Type="Int32" />
            <asp:Parameter Name="facLink" Type="String" />
            <asp:Parameter Name="uniID" Type="String" />
            <asp:Parameter Name="branchID" Type="String" />
            <asp:Parameter Name="programID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
