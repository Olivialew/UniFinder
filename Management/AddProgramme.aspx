<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.Master" AutoEventWireup="true" CodeBehind="AddProgramme.aspx.cs" Inherits="UniFinder.Management.AddProgramme" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style27 {
            color: #000000;
            font-size: x-large;
        }

        .auto-style28 {
            width: 202px;
            text-align: left;
        }

        .auto-style29 {
            width: 22px;
        }

        .auto-style30 {
            font-size: large;
        }

        .auto-style31 {
            width: 202px;
            height: 34px;
            text-align: left;
        }

        .auto-style32 {
            width: 22px;
            height: 34px;
        }

        .auto-style34 {
            width: 202px;
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

        .auto-style43 {
            width: 247px;
            text-align: right;
        }

        .auto-style44 {
            width: 202px;
            height: 32px;
            text-align: right;
        }

        .auto-style45 {
            width: 202px;
            text-align: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="text-align: center;">
        <span class="auto-style27"><strong>Add Programme<br />
    </div>
    </strong></span>
    <br class="auto-style30" />
    <table style="width: 100%;">
        <tr>
            <td class="auto-style28">Programme Name*</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">
                <asp:TextBox ID="txtProgramName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtProgramName" ErrorMessage="Program Name is required" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">Programme Link*</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">
                <asp:TextBox ID="txtPLink" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPLink" ErrorMessage="Program Link is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtPLink" ErrorMessage="Incorrect link format for programme link, Eg. https://abc.edu.my" ForeColor="Red" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">Introduction*</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">
                <asp:TextBox ID="txtIntro" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtIntro" ErrorMessage="Introduction is required" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style43">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28"><strong>Contact</strong></td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style43">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style45">Phone*</td>
            <td class="auto-style40">&nbsp;</td>
            <td>
                <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPhone" ErrorMessage="Contact is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtPhone" ErrorMessage="Invalid Phone Number format" ForeColor="Red" ValidationExpression="\d{3}-?\d{7,8}">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style45">&nbsp;</td>
            <td class="auto-style40">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style44">Fax</td>
            <td class="auto-style41">&nbsp;</td>
            <td class="auto-style36">
                <asp:TextBox ID="txtFax" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtFax" ErrorMessage="Invalid Fax Number format" ForeColor="Red" ValidationExpression="^(\+?\d{1,3})?[-.\s]?(\(?\d{3}\)?)?[-.\s]?\d{3}[-.\s]?\d{4}$">*</asp:RegularExpressionValidator>
                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtFax" ErrorMessage="Invalid Fax Number format" ForeColor="Red" ValidationExpression="\d{3}-?\d{7,8}">*</asp:RegularExpressionValidator>--%>
            </td>
        </tr>
        <tr>
            <td class="auto-style44"></td>
            <td class="auto-style41"></td>
            <td class="auto-style36"></td>
        </tr>
        <tr>
            <td class="auto-style45">Email</td>
            <td class="auto-style40">&nbsp;</td>
            <td>
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid Phone Number format" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>--%>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtEmail" ErrorMessage="Incorrect email format" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style31">Duration*</td>
            <td class="auto-style32"></td>
            <td class="auto-style39">
                <asp:TextBox ID="txtDuration" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtDuration" ErrorMessage="Duration is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtDuration" Enabled="True" ErrorMessage="Duration must be between 1 to 10 years" ForeColor="Red" MaximumValue="100000" MinimumValue="1000">*</asp:RangeValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style31">Tuition Fees*</td>
            <td class="auto-style32"></td>
            <td class="auto-style39">
                <asp:TextBox ID="txtFees" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtFees" ErrorMessage="Tuition Fees is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:RangeValidator
                    ID="RangeValidator1"
                    runat="server"
                    ControlToValidate="txtFees"
                    ErrorMessage="Tuition fee must be between RM1000 and RM100,000"
                    ForeColor="Red"
                    MaximumValue="100000"
                    MinimumValue="1000"
                    Type="Double">*</asp:RangeValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style34"></td>
            <td class="auto-style35"></td>
            <td class="auto-style38"></td>
        </tr>
        <tr>
            <td class="auto-style31">Faculty Link*</td>
            <td class="auto-style32"></td>
            <td class="auto-style39">
                <asp:TextBox ID="txtFacLink" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtFacLink" ErrorMessage="Faculty Link is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtFacLink" ErrorMessage="Incorrect link format for faculty link" ForeColor="Red" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">&nbsp;</td>
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
        </tr>
        <tr>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style37">&nbsp;</td>
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
        </tr>
    </table>
    <br />
    <strong>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
        <br />
        <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
        <br />
        <br />
        <div style="text-align: center;">
            <asp:Button ID="btnClearProgram" runat="server" class="button" OnClick="btnCancel_Click" Text="Cancel" />
            &nbsp;<asp:Button ID="btnAddProgram" runat="server" class="button" OnClick="btnAddUniversity_Click" Text="Submit" />
        </div>
    </strong>
</asp:Content>
