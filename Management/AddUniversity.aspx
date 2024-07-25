<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="AddUniversity.aspx.cs" Inherits="UniFinder.AddUniversity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
    .auto-style27 {
        font-weight: bold;
    }
    .auto-style28 {
        width: 220px;
    }
    .auto-style29 {
        width: 22px;
    }
    .auto-style30 {
        width: 220px;
        height: 32px;
    }
    .auto-style31 {
        width: 22px;
        height: 32px;
    }
    .auto-style32 {
        height: 32px;
    }
    .auto-style33 {
        color: #000000;
        font-size: large;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <span class="auto-style33"><strong>Add University</strong></span><br />
    <strong>
        <br />
    </strong>
<table style="width: 100%;">
    <tr>
        <td class="auto-style28">English Name*</td>
        <td class="auto-style29">&nbsp;</td>
        <td>
        <asp:TextBox ID="txtUniNameEng" runat="server" CssClass="auto-style27"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUniNameEng" ErrorMessage="English Name is required" ForeColor="Red">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <strong>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style28">Malay Name*</td>
        <td class="auto-style29">&nbsp;</td>
        <td>
        <asp:TextBox ID="txtUniNameMalay" runat="server" CssClass="auto-style27"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtUniNameMalay" ErrorMessage="Malay Name is required" ForeColor="Red">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="auto-style28">&nbsp;</td>
        <td class="auto-style29">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style28">Acronym*</td>
        <td class="auto-style29">&nbsp;</td>
        <td>
        <asp:TextBox ID="txtUniAcronym" runat="server" CssClass="auto-style27"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtUniAcronym" ErrorMessage="Acronym is required" ForeColor="Red">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="auto-style28">&nbsp;</td>
        <td class="auto-style29">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style28">Foundation Year*</td>
        <td class="auto-style29">&nbsp;</td>
        <td>
        <asp:TextBox ID="txtFoundYear" runat="server" CssClass="auto-style27"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtFoundYear" ErrorMessage="Foundation Year is required" ForeColor="Red">*</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtFoundYear" ErrorMessage="Year must be after or equal 1900" ForeColor="Red" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="1900">*</asp:CompareValidator>
        </td>
    </tr>
    <tr>
        <td class="auto-style28">&nbsp;</td>
        <td class="auto-style29">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style28">University Type*</td>
        <td class="auto-style29">&nbsp;</td>
        <td>
    <asp:DropDownList ID="ddlUniType" runat="server" CssClass="auto-style27">
        <asp:ListItem>&lt;-- Select Type --&gt;</asp:ListItem>
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
        <asp:ListItem>Others</asp:ListItem>
    </asp:DropDownList>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlUniType" ErrorMessage="University Type is required" ForeColor="Red">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="auto-style28">&nbsp;</td>
        <td class="auto-style29">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style28">University Logo*</td>
        <td class="auto-style29">&nbsp;</td>
        <td>
        <asp:FileUpload ID="FileUploadUniLogo" runat="server" CssClass="auto-style27" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="FileUploadUniLogo" ErrorMessage="University Logo is required" ForeColor="Red">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="auto-style28">&nbsp;</td>
        <td class="auto-style29">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style28">Campus Tour Link</td>
        <td class="auto-style29">&nbsp;</td>
        <td>
        <asp:TextBox ID="txtCampusTour" runat="server" CssClass="auto-style27"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="auto-style28">&nbsp;</td>
        <td class="auto-style29">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style30">YouTube Link</td>
        <td class="auto-style31"></td>
        <td class="auto-style32">
        <asp:TextBox ID="txtYouTube" runat="server" CssClass="auto-style27"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="auto-style30">&nbsp;</td>
        <td class="auto-style31">&nbsp;</td>
        <td class="auto-style32">&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style28">Google Maps Link</td>
        <td class="auto-style29">&nbsp;</td>
        <td>
        <asp:TextBox ID="txtGoogleMaps" runat="server" CssClass="auto-style27"></asp:TextBox>
        </td>
    </tr>
</table>
    </strong>
    <br />
    <strong>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
        <br />
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
    <br />
        <br />
        <asp:Button ID="btnClearUni" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
        <asp:Button ID="btnAddUniversity" runat="server" OnClick="btnAddUniversity_Click" Text="Submit" />
        <br />
    </strong>
    <br />
</asp:Content>
