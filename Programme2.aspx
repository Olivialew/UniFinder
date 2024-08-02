<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Programme2.aspx.cs" Inherits="UniFinder.Programme2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bigContainer" style="background-color: #FFFFFF">
        <div class="header">
            <h3 class="auto-style37"><strong>Programme</strong></h3>
        </div>
        <div class="content">
            <div class="mainSide">
                <strong>
                    <span class="auto-style26">Search by:</span>
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Enter Programme Name" CssClass="search-box"></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="search-btn" OnClick="btnSearch_Click" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="auto-style26">Sort by: 
                <asp:DropDownList ID="ddlSortBy" runat="server" AutoPostBack="true">
                    <asp:ListItem Text="Select Sort" Value=""></asp:ListItem>
                    <asp:ListItem Text="Fees Ascending" Value="fees_asc"></asp:ListItem>
                    <asp:ListItem Text="Fees Descending" Value="fees_desc"></asp:ListItem>
                </asp:DropDownList>
                        <br />
                        <br />
                        Filter by:<br />
                        University<br />
                        <asp:DropDownList ID="ddlUni" runat="server" DataSourceID="SqlDataSource1" DataTextField="uniNameEng" DataValueField="uniID">
                            <asp:ListItem>&lt;-- Select University --&gt;</asp:ListItem>
                        </asp:DropDownList>
                    </span></strong>
                <%--                <br /><br />
                <asp:DropDownList ID="ddlFilterBy" runat="server" AutoPostBack="true">
                    <asp:ListItem Text="Select Filter" Value=""></asp:ListItem>
                    <asp:ListItem Text="University Name" Value="UniversityName"></asp:ListItem>
                    <asp:ListItem Text="Fees" Value="Fees"></asp:ListItem>
                    <asp:ListItem Text="Duration" Value="Duration"></asp:ListItem>
                </asp:DropDownList>--%>
               <%-- <br />
                <br />
                <span class="auto-style26"><strong>Branch Location</strong></span><br />
                <asp:DropDownList ID="ddlBranch" runat="server" DataSourceID="SqlDataSource2" DataTextField="location" DataValueField="branchID">
                </asp:DropDownList>
                <br />
                <br />
                <span class="auto-style26"><strong>Fees</strong></span><br class="auto-style26" />
                <span class="auto-style26">Minimum: </span>
                <asp:TextBox ID="txtMinFees" runat="server"></asp:TextBox><br class="auto-style26" />
                <span class="auto-style26">Maximum: </span>
                <asp:TextBox ID="txtMaxFees" runat="server"></asp:TextBox><span class="auto-style26"><br />
                    <br />
                    <strong>Duration</strong><br />
                </span>
                <asp:TextBox ID="txtDuration" runat="server"></asp:TextBox>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [University]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Branch] WHERE ([uniID] = @uniID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlUni" Name="uniID" PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <strong>
                    <asp:Button ID="btnFilter" runat="server" Text="Apply Filters" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="search-btn" OnClick="btnSearch_Click" />
                </strong>
                <br />
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red"></asp:Label>
                <br />

                <div class="panel">
                    <asp:Panel ID="pnlStep1" runat="server" CssClass="panel-class" ClientIDMode="Static" Style="display: block" Width="791px">
                        <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" RepeatColumns="4" Height="460px" DataSourceID="SqlDataSource3" Width="1164px">
                            <ItemTemplate>
                                programName:
                                <asp:Label ID="programNameLabel" runat="server" Text='<%# Eval("programName") %>' />
                                <br />
                                duration:
                                <asp:Label ID="durationLabel" runat="server" Text='<%# Eval("duration") %>' />
                                <br />
                                fees:
                                <asp:Label ID="feesLabel" runat="server" Text='<%# Eval("fees") %>' />
                                <br />
                                uniNameEng:
                                <asp:Label ID="uniNameEngLabel" runat="server" Text='<%# Eval("uniNameEng") %>' />
                                <br />
                                location:
                                <asp:Label ID="locationLabel" runat="server" Text='<%# Eval("location") %>' />
                                <br />
                                <br />
                            </ItemTemplate>
                        </asp:DataList>

                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT P.[programName], P.[duration], P.[fees], U.[uniNameEng], B.[location] 
                                    FROM [Programme] P
                                    JOIN [University] U ON P.uniID = U.uniID
                                    JOIN [Branch] B ON P.branchID = B.branchID
                                    WHERE 
                                        (P.[branchID] = @branchID) AND 
                                        (P.[duration] = @duration) AND 
                                        (P.[fees] &lt;= @maxFees) AND 
                                        (P.[fees] &gt;= @minFees) AND 
                                        (P.[uniID] = @uniID)
                                    ">
                            <SelectParameters>
                                <asp:Parameter Name="branchID" />
                                <asp:Parameter Name="duration" />
                                <asp:Parameter Name="maxFees" />
                                <asp:Parameter Name="minFees" />
                                <asp:Parameter Name="uniID" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:Label ID="WishlistLabel" runat="server" Text="Wishlist:"></asp:Label>
                        <asp:HiddenField ID="WishlistCount" runat="server" />
                        <br />
                        <asp:Button ID="CompareButton" runat="server" Text="Compare" OnClick="CompareButton_Click" />

                        <div class="pagination">
                            <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" />
                            <asp:Label ID="lblPageNumber" runat="server" Text="Page 1"></asp:Label>
                            <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" />
                        </div>

                        <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                            <asp:ListItem Text="5" Value="5" />
                            <asp:ListItem Text="10" Value="10" Selected="True" />
                            <asp:ListItem Text="15" Value="15" />
                        </asp:DropDownList>

                        <script type="text/javascript">
                            function validateWishlist() {
                                var wishlistCount = parseInt(document.getElementById('WishlistCount').value, 10);
                                if (wishlistCount >= 4) {
                                    alert("You can only add up to 4 programs to the wishlist.");
                                    return false; // Prevent postback
                                }
                                return true;
                            }
                        </script>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>--%>

