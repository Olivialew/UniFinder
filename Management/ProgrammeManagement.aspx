<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="ProgrammeManagement.aspx.cs" Inherits="UniFinder.Programme_Management" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style28 {
            font-size: large;
        }

        .search-box {
            width: 300px;
        }

        .search-btn {
            margin-left: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <span class="auto-style16"><strong>&nbsp;Programme Management</strong></span><br class="auto-style16" />
    <table class="auto-style24">
        <tr>
            <td class="auto-style25" style="background-color: #ECECEC; vertical-align: top; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">
                <strong><span class="auto-style28">Programme Management</span><br />
                    <br />
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Enter Programme Name" CssClass="search-box"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="auto-style26">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sort by: 
               
                        <asp:DropDownList ID="ddlSortBy" runat="server" AutoPostBack="true">
                            <asp:ListItem Text="Select Sort" Value=""></asp:ListItem>
                            <asp:ListItem Text="Fees Ascending" Value="fees_asc"></asp:ListItem>
                            <asp:ListItem Text="Fees Descending" Value="fees_desc"></asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        Filter by:<br />
                        <br />
                        University<br />
                        <asp:DropDownList ID="ddlUni" runat="server" DataSourceID="SqlDataSource3" DataTextField="uniNameEng" DataValueField="uniID">
                        </asp:DropDownList>
                    </span>
                    <%--                <br /><br />
                <asp:DropDownList ID="ddlFilterBy" runat="server" AutoPostBack="true">
                    <asp:ListItem Text="Select Filter" Value=""></asp:ListItem>
                    <asp:ListItem Text="University Name" Value="UniversityName"></asp:ListItem>
                    <asp:ListItem Text="Fees" Value="Fees"></asp:ListItem>
                    <asp:ListItem Text="Duration" Value="Duration"></asp:ListItem>
                </asp:DropDownList>--%>
                    <br />
                    <br />
                    <span class="auto-style26">Branch Location</span><br />
                    <asp:DropDownList ID="ddlBranch" runat="server" DataSourceID="SqlDataSource2" DataTextField="location" DataValueField="branchID">
                    </asp:DropDownList>
                    <br />
                    <br />
                    <span class="auto-style26">Fees</span><br class="auto-style26" />
                    <span class="auto-style26">Minimum: </span>
                    <asp:TextBox ID="txtMinFees" runat="server"></asp:TextBox><br class="auto-style26" />
                    <span class="auto-style26">Maximum: </span>
                    <asp:TextBox ID="txtMaxFees" runat="server"></asp:TextBox><span class="auto-style26"><br />
                        <br />
                        Duration<br />
                    </span>
                    <asp:TextBox ID="txtDuration" runat="server"></asp:TextBox>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [University]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Branch] WHERE ([uniID] = @uniID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlUni" Name="uniID" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    &nbsp;<asp:Button ID="btnSearch" runat="server" BackColor="#009999" BorderStyle="None" Height="33px" Text="Search" Width="129px" Style="border-radius: 10px;" ForeColor="#242424" OnClick="btnSearch_Click3" />
                    &nbsp;
                <asp:Button ID="btnReset" runat="server" BackColor="#242424" BorderStyle="Solid" Height="33px" Text="Reset" Width="129px" Style="border-radius: 10px; color: #FFFFFF;" BorderColor="#009999" CssClass="auto-style21" OnClick="btnReset_Click3" />
                    <br />
                    <br />
                </strong>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Management/AddProgramme.aspx">Add Programme</asp:HyperLink>
                <strong>
                    <br />
                    <br />
                </strong>
                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
                <strong>
                    <br />

                </strong>

                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="programID" ForeColor="#333333" GridLines="None" AllowPaging="True" AllowSorting="True" OnPageIndexChanging="GridView1_PageIndexChanging">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="programID" HeaderText="Programme ID" ReadOnly="True" SortExpression="programID" />
                        <asp:BoundField DataField="programName" HeaderText="Name" SortExpression="programName" />
                        <asp:BoundField DataField="programLink" HeaderText="Programme Link" SortExpression="programLink" />
                        <asp:BoundField DataField="introduction" HeaderText="Introduction" SortExpression="introduction" />
                        <asp:BoundField DataField="contact" HeaderText="Contact" SortExpression="contact" />
                        <asp:BoundField DataField="duration" HeaderText="Duration" SortExpression="duration" />
                        <asp:BoundField DataField="fees" HeaderText="Fees" SortExpression="fees" />
                        <asp:BoundField DataField="facLink" HeaderText="Faculty Link" SortExpression="facLink" />
                        <asp:BoundField DataField="uniID" HeaderText="University ID" SortExpression="uniID" />
                        <asp:BoundField DataField="branchID" HeaderText="Branch ID" SortExpression="branchID" />
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
            </td>
        </tr>
        <tr>
            <td class="auto-style25" style="background-color: #ECECEC; vertical-align: top; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style25" style="background-color: #ECECEC; vertical-align: top; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">&nbsp;</td>
        </tr>
    </table>
</asp:Content>
