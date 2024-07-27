<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="UniManagement2.aspx.cs" Inherits="UniFinder.UniManagement2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style24 {
            width: 100%;
        }

        .auto-style25 {
            height: 467px;
        }

        .auto-style27 {
            color: #000000;
        }

        .auto-style28 {
            font-size: large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <span class="auto-style16"><strong>&nbsp;University Management</strong></span><br class="auto-style16" />
    <table class="auto-style24">
        <tr>
            <td class="auto-style25" style="background-color: #ECECEC; vertical-align: top; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">
                <strong><span class="auto-style28">University Management</span><br />
                    <br />
                    search by</strong></span><span class="auto-style16"><br />
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Enter university title"></asp:TextBox>
                        <br />
                        <br />
                        <span class="auto-style27"><strong>Filter By</strong></span>
                        <br />
                    </span>
                <asp:DropDownList ID="ddlUniType" runat="server">
                    <asp:ListItem>- University Type -</asp:ListItem>
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
                </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                <div style="margin-top: 30px">
                    <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False"
                        AllowPaging="True" AllowSorting="True" DataKeyNames="uniID" DataSourceID="SqlDataSource3"
                        OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowEditing="GridView1_RowEditing"
                        OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="uniID" HeaderText="uniID" ReadOnly="True" SortExpression="uniID" />
                            <asp:BoundField DataField="uniNameEng" HeaderText="uniNameEng" SortExpression="uniNameEng" />
                            <asp:BoundField DataField="uniNameMalay" HeaderText="uniNameMalay" SortExpression="uniNameMalay" />
                            <asp:BoundField DataField="uniAcronym" HeaderText="uniAcronym" SortExpression="uniAcronym" />
                            <asp:BoundField DataField="foundationYear" HeaderText="foundationYear" SortExpression="foundationYear" />
                            <asp:BoundField DataField="uniType" HeaderText="uniType" SortExpression="uniType" />
                            <asp:BoundField DataField="campusTourLink" HeaderText="campusTourLink" SortExpression="campusTourLink" />
                            <asp:BoundField DataField="youtubeLink" HeaderText="youtubeLink" SortExpression="youtubeLink" />
                            <asp:BoundField DataField="googleMapsLink" HeaderText="googleMapsLink" SortExpression="googleMapsLink" />
                            <asp:TemplateField HeaderText="Image">
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
                        SelectCommand="SELECT * FROM [University]"
                        UpdateCommand="UPDATE [University] SET [uniNameEng] = @uniNameEng, [uniNameMalay] = @uniNameMalay, [uniAcronym] = @uniAcronym, [foundationYear] = @foundationYear, 
                                        [uniType] = @uniType, [campusTourLink] = @campusTourLink, [youtubeLink] = @youtubeLink, [googleMapsLink] = @googleMapsLink, [uniLogo] = @uniLogo 
                                        WHERE [uniID] = @uniID">
                        <DeleteParameters>
                            <asp:Parameter Name="uniID" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="uniID" Type="String" />
                            <asp:Parameter Name="uniNameEng" Type="String" />
                            <asp:Parameter Name="uniNameMalay" Type="String" />
                            <asp:Parameter Name="uniAcronym" Type="String" />
                            <asp:Parameter Name="foundationYear" Type="String" />
                            <asp:Parameter Name="uniType" Type="String" />
                            <asp:Parameter Name="campusTourLink" Type="String" />
                            <asp:Parameter Name="youtubeLink" Type="String" />
                            <asp:Parameter Name="googleMapsLink" Type="String" />
                            <asp:Parameter Name="uniLogo" Type="Object" />
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
                            <asp:Parameter Name="uniLogo" Type="Object" />
                            <asp:Parameter Name="uniID" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <br />
                </div>
            </td>
        </tr>
    </table>
    <br />
</asp:Content>

