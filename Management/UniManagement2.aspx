<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="UniManagement2.aspx.cs" Inherits="UniFinder.UniManagement2" %>

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
        }

        .auto-style28 {
            font-size: x-large;
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

        .no-records-message {
            color: red;
            font-weight: bold;
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
        <strong><span class="auto-style28">University Management</span></strong>
    </div>
    <br />
    <strong>Search By:
        <br />
        University Name</strong><span class="auto-style16"><br />
            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Enter university title"></asp:TextBox>
            <br />
            <br />
            <span class="auto-style27"><strong>Filter By:<br />
                University Type<br />
                <%--<asp:DropDownList ID="ddlUniType" runat="server" DataSourceID="SqlDataSource1" DataTextField="uniType" DataValueField="uniType">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [University]"></asp:SqlDataSource>
                            <br />--%>
                <asp:DropDownList ID="ddlUniType" runat="server" CssClass="auto-style27">
                    <asp:ListItem><-- Select University Type --></asp:ListItem>
                    <asp:ListItem>Research university</asp:ListItem>
                    <asp:ListItem>International university</asp:ListItem>
                    <asp:ListItem>Focused university</asp:ListItem>
                    <asp:ListItem>Technical university</asp:ListItem>
                    <asp:ListItem>Comprehensive university</asp:ListItem>
                    <asp:ListItem>Islamic university</asp:ListItem>
                    <asp:ListItem>Premier polytechnic (university status)</asp:ListItem>
                    <asp:ListItem>Conventional polytechnic</asp:ListItem>
                    <asp:ListItem>METrO polytechnic</asp:ListItem>
                    <asp:ListItem>Private university</asp:ListItem>
                    <asp:ListItem>Private university college</asp:ListItem>
                    <asp:ListItem Value="&quot;&quot;">Others</asp:ListItem>
                </asp:DropDownList>
                <br />
            </strong></span>
        </span><strong>
            <br />
            Location<br />
            <%--<asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="SqlDataSource2" DataTextField="location" DataValueField="location">
            </asp:DropDownList>--%>
            <asp:DropDownList ID="ddlLocation" runat="server">
            </asp:DropDownList>
            <br />
            <br />
            Sort By:<br />
            <asp:DropDownList ID="ddlSortBy" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSortBy_SelectedIndexChanged">
                <asp:ListItem Text="Sort by Oldest" Value="ASC"></asp:ListItem>
                <asp:ListItem Text="Sort by Latest" Value="DESC"></asp:ListItem>
            </asp:DropDownList>

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Branch]"></asp:SqlDataSource>
        </strong>

    &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnSearch" runat="server" BackColor="#009999" BorderStyle="None" Height="33px" Text="Search" Width="129px" Style="border-radius: 10px;" ForeColor="#242424" OnClick="btnSearch_Click2" />
    &nbsp;
                <asp:Button ID="btnReset" runat="server" BackColor="#242424" BorderStyle="Solid" Height="33px" Text="Reset" Width="129px" Style="border-radius: 10px; color: #FFFFFF;" BorderColor="#009999" CssClass="auto-style21" OnClick="btnReset_Click2" />
    <br />
    <br />
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Management/AddUniversity.aspx">Add University</asp:HyperLink>
    <br />
    <br />
    <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
    <br />
    <asp:Label ID="lblNoRecords" runat="server" Text="No records found." CssClass="no-records-message" Visible="false" />

    <div class="gridview-container" style="margin-top: 30px">
        <asp:GridView ID="GridView1" runat="server" CssClass="gridview-table" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False"
            AllowPaging="True" AllowSorting="True" DataKeyNames="uniID"
            OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowEditing="GridView1_RowEditing"
            OnRowUpdating="GridView1_RowUpdating" OnRowDeleting="GridView1_RowDeleting"
            OnRowCancelingEdit="GridView1_RowCancelingEdit" OnPageIndexChanging="GridView1_PageIndexChanging">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("uniID") %>' Text="Edit" />
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("uniID") %>' Text="Delete"
                            OnClientClick="return confirmDelete();" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CommandArgument='<%# Eval("uniID") %>' Text="Update" />
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CommandArgument='<%# Eval("uniID") %>' Text="Cancel" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="uniID" HeaderText="University ID" ReadOnly="True" SortExpression="uniID" />


                <asp:TemplateField HeaderText="English Name" SortExpression="uniNameEng">
                    <ItemTemplate>
                        <%# Eval("uniNameEng") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtNameEng" runat="server" Text='<%# Bind("uniNameEng") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Malay Name" SortExpression="uniNameMalay">
                    <ItemTemplate>
                        <%# Eval("uniNameMalay") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtNameMalay" runat="server" Text='<%# Bind("uniNameMalay") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Acronym" SortExpression="uniAcronym">
                    <ItemTemplate>
                        <%# Eval("uniAcronym") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtAcronym" runat="server" Text='<%# Bind("uniAcronym") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Found Year" SortExpression="foundationYear">
                    <ItemTemplate>
                        <%# Eval("foundationYear") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtFoundationYear" runat="server" Text='<%# Bind("foundationYear") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="University Type" SortExpression="uniType">
                    <ItemTemplate>
                        <%# Eval("uniType") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtUniType" runat="server" Text='<%# Bind("uniType") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Campus Tour Link" SortExpression="campusTourLink">
                    <ItemTemplate>
                        <%# Eval("campusTourLink") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtCampusTourLink" runat="server" Text='<%# Bind("campusTourLink") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Youtube Link" SortExpression="youtubeLink">
                    <ItemTemplate>
                        <%# Eval("youtubeLink") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtYoutubeLink" runat="server" Text='<%# Bind("youtubeLink") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Google Maps Link" SortExpression="googleMapsLink">
                    <ItemTemplate>
                        <%# Eval("googleMapsLink") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtGoogleMapsLink" runat="server" Text='<%# Bind("googleMapsLink") %>' TextMode="MultiLine" Rows="3" CssClass="editable-textbox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Logo Image">
                    <ItemTemplate>
                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>' Width="100px" Height="100px" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Image ID="imgProductEdit" runat="server" ImageUrl='<%# GetImageUrl(Eval("uniLogo")) %>' Width="100px" Height="100px" />
                        <asp:FileUpload ID="fileUploadImage" runat="server" />
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

        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            DeleteCommand="DELETE FROM [University] WHERE [uniID] = @uniID"
            InsertCommand="INSERT INTO [University] ([uniID], [uniNameEng], [uniNameMalay], [uniAcronym], [foundationYear], [uniType], [campusTourLink], [youtubeLink], [googleMapsLink], [uniLogo]) 
                                        VALUES (@uniID, @uniNameEng, @uniNameMalay, @uniAcronym, @foundationYear, @uniType, @campusTourLink, @youtubeLink, @googleMapsLink, @uniLogo)"
            SelectCommand="SELECT U.uniID, U.uniNameEng, U.uniNameMalay, U.uniAcronym, U.foundationYear, U.uniType, U.campusTourLink, U.youtubeLink, U.googleMapsLink, U.uniLogo, B.location 
                                        FROM University U INNER JOIN Branch B ON U.uniID = B.uniID"
            UpdateCommand="UPDATE [University] SET [uniNameEng] = @uniNameEng, [uniNameMalay] = @uniNameMalay, [uniAcronym] = @uniAcronym, [foundationYear] = @foundationYear, 
                                        [uniType] = @uniType, [campusTourLink] = @campusTourLink, [youtubeLink] = @youtubeLink, [googleMapsLink] = @googleMapsLink, [uniLogo] = @uniLogo 
                                        WHERE [uniID] = @uniID">
            <DeleteParameters>
                <asp:Parameter Name="uniID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="uniID" Type="Int32" />
                <asp:Parameter Name="uniNameEng" Type="String" />
                <asp:Parameter Name="uniNameMalay" Type="String" />
                <asp:Parameter Name="uniAcronym" Type="String" />
                <asp:Parameter Name="foundationYear" Type="String" />
                <asp:Parameter Name="uniType" Type="String" />
                <asp:Parameter Name="campusTourLink" Type="String" />
                <asp:Parameter Name="youtubeLink" Type="String" />
                <asp:Parameter Name="googleMapsLink" Type="String" />
                <asp:Parameter Name="uniLogo" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="uniNameEng" Type="String" />
                <asp:Parameter Name="uniNameMalay" Type="String" />
                <asp:Parameter Name="uniAcronym" Type="String" />
                <asp:Parameter Name="foundationYear" Type="String" />
                <asp:Parameter Name="uniType" Type="String" />
                <asp:Parameter Name="campusTourLink" Type="String" />
                <asp:Parameter Name="youtubeLink" Type="String" />
                <asp:Parameter Name="googleMapsLink" Type="String" />
                <asp:Parameter Name="uniLogo" Type="String" />
                <asp:Parameter Name="uniID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    <script type="text/javascript">
        function confirmDelete() {
            return confirm('Are you sure you want to delete this record?');
        }
    </script>

</asp:Content>
