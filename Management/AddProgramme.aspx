<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="AddProgramme.aspx.cs" Inherits="UniFinder.Management.AddProgramme" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">


        .auto-style27 {
            color: #000000;
            font-size: large;
        }
        .auto-style28 {
            width: 176px;
            text-align: left;
        }
        .auto-style29 {
            width: 22px;
        }
        .auto-style30 {
            font-size: large;
        }
        .auto-style31 {
            width: 176px;
            height: 34px;
            text-align: left;
        }
        .auto-style32 {
            width: 22px;
            height: 34px;
        }
        .auto-style33 {
            height: 34px;
        }
        .auto-style34 {
            width: 176px;
            height: 32px;
            text-align: left;
        }
        .auto-style35 {
            width: 22px;
            height: 32px;
        }
        .auto-style36 {
            height: 32px;
        }
        .auto-style37 {
            width: 247px;
        }
        .auto-style38 {
            width: 247px;
            height: 32px;
        }
        .auto-style39 {
            width: 247px;
            height: 34px;
        }
        .auto-style40 {
            width: 17px;
        }
        .auto-style41 {
            width: 17px;
            height: 32px;
        }
        .auto-style42 {
            width: 17px;
            height: 34px;
        }
        .auto-style43 {
            width: 247px;
            text-align: right;
        }
        .auto-style44 {
            width: 247px;
            height: 32px;
            text-align: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <span class="auto-style27"><strong>
                Add Programme<br />
    </strong></span><br class="auto-style30" />
    <table style="width:100%;">
        <tr>
            <td class="auto-style28">Programme Name*</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">
                <asp:TextBox ID="txtProgramName" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtProgramName" ErrorMessage="Program Name is required" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">&nbsp;</td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">Programme Link*</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">
                <asp:TextBox ID="txtPLink" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPLink" ErrorMessage="Program Link is required" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">&nbsp;</td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">Introduction*</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">
                <asp:TextBox ID="txtIntro" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtIntro" ErrorMessage="Introduction is required" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style43">&nbsp;</td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">Contact</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style43">Phone*</td>
            <td class="auto-style40">&nbsp;</td>
            <td>
                <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPhone" ErrorMessage="Contact is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtPhone" ErrorMessage="Invalid Phone Number format" ForeColor="Red" ValidationExpression="^(\+?60)?[-\s]?(1[0-9]|[3-9][0-9])[-\s]?(\d{7,8})$">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style43">&nbsp;</td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style34"></td>
            <td class="auto-style35"></td>
            <td class="auto-style44">Fax</td>
            <td class="auto-style41">&nbsp;</td>
            <td class="auto-style36">
                <asp:TextBox ID="txtFax" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtFax" ErrorMessage="Invalid Fax Number format" ForeColor="Red" ValidationExpression="^(\+?\d{1,3})?[-.\s]?(\(?\d{3}\)?)?[-.\s]?\d{3}[-.\s]?\d{4}$">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style34"></td>
            <td class="auto-style35"></td>
            <td class="auto-style44"></td>
            <td class="auto-style41"></td>
            <td class="auto-style36"></td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style43">Email</td>
            <td class="auto-style40">&nbsp;</td>
            <td>
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid Phone Number format" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">&nbsp;</td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">Duration*</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">
                <asp:TextBox ID="txtDuration" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtDuration" ErrorMessage="Duration is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtDuration" ErrorMessage="Duration needs to be Interger bigger than 0" ForeColor="Red" Operator="GreaterThan" Type="Integer" ValueToCompare="0">*</asp:CompareValidator>
            </td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">&nbsp;</td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style31">Tuition Fees*</td>
            <td class="auto-style32"></td>
            <td class="auto-style39">
                <asp:TextBox ID="txtFees" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtFees" ErrorMessage="Tuition Fees is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="txtFees" ErrorMessage="Tuition Fees needs to be Interger bigger than 0" ForeColor="Red" Operator="GreaterThan" Type="Integer" ValueToCompare="0">*</asp:CompareValidator>
            </td>
            <td class="auto-style42">&nbsp;</td>
            <td class="auto-style33">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style34"></td>
            <td class="auto-style35"></td>
            <td class="auto-style38"></td>
            <td class="auto-style41">&nbsp;</td>
            <td class="auto-style36">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">Faculty Link*</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">
                <asp:TextBox ID="txtFacLink" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtFacLink" ErrorMessage="Faculty Link is required" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">&nbsp;</td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">University*</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">
                <asp:DropDownList ID="ddlUni" runat="server" DataSourceID="SqlDataSource1" DataTextField="uniNameEng" DataValueField="uniID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [University]"></asp:SqlDataSource>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlUni" ErrorMessage="University is required" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">&nbsp;</td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">Branch Location*</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">
                <asp:DropDownList ID="ddlBranch" runat="server" DataSourceID="SqlDataSource2" DataTextField="location" DataValueField="branchID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Branch]"></asp:SqlDataSource>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlBranch" ErrorMessage="Branch is required" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <br />
    <strong>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
        <br />
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
    <br />
        <br />
        <asp:Button ID="btnClearProgram" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
        <asp:Button ID="btnAddProgram" runat="server" OnClick="btnAddUniversity_Click" Text="Submit" />
    </strong>
</asp:Content>
