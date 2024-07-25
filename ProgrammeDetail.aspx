<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ProgrammeDetail.aspx.cs" Inherits="UniFinder.ProgrammeDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style27 {
            width: 866px;
        }

        .auto-style29 {
            width: 1114px;
        }

        .auto-style30 {
            width: 801px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="SummaryHeader">
        <asp:Image ID="imgUniversityLogo" runat="server" Height="180px" Width="180px" />
    </div>
    <div class="SummaryContent">
        <table>
            <tr>
                <td class="auto-style29">
                    <table>
                        <tr>
                            <td class="auto-style35" colspan="2"><strong>Programme:<br />
                                <asp:Label ID="lblProgramName" runat="server"></asp:Label>
                            </strong></td>
                        </tr>
                        <tr>
                            <td class="auto-style35" colspan="2"><strong>University:<br />
                                <asp:Label ID="lblUniversity" runat="server"></asp:Label>
                            </strong></td>
                        </tr>
                        <tr>
                            <td class="auto-style35" colspan="2"><strong>Location:<br />
                                <asp:Label ID="lblLocation" runat="server"></asp:Label>
                            </strong></td>
                        </tr>
                        <tr>
                            <td aria-checked="true" class="auto-style35" colspan="2"><strong>Introduction:<br />
                                <asp:Label ID="lblProgrammeIntro" runat="server"></asp:Label>
                            </strong></td>
                        </tr>
                        <tr>
                            <td aria-checked="true" class="auto-style35" colspan="2"><strong>Contact:<br />
                                <asp:Label ID="lblProgrammeContact" runat="server"></asp:Label>
                            </strong></td>
                        </tr>
                        <tr>
                            <td class="auto-style30"><strong>Duration:<br />
                                <asp:Label ID="lblProgrammeDuration" runat="server"></asp:Label>
                            </strong></td>
                            <td class="auto-style27"><strong>Tuition Fees:</strong><br />
                                <strong>
                                    <asp:Label ID="lblTuitionFee" runat="server"></asp:Label>
                                </strong></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;
                                <div>
                                    <asp:Literal ID="LiteralIframe" runat="server"></asp:Literal>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style38" colspan="2"><strong>
                                <%--<div class="movie-details">  <!--after hover the poster --> 
                            <h3 class="movieTitle"><%# Eval("title") %></h3>
                            <asp:Button ID="btnSelectMovie" runat="server" Text="Book Now" CssClass="btnSelect" OnClick="btnSelectMovie"  />
    
                       </div>--%>
                                <asp:HyperLink ID="hlProgramLink" runat="server">Click Here to go to Official Program Page</asp:HyperLink>
                                <br />
                                <%--<div class="movie-details">  <!--after hover the poster --> 
                            <h3 class="movieTitle"><%# Eval("title") %></h3>
                            <asp:Button ID="btnSelectMovie" runat="server" Text="Book Now" CssClass="btnSelect" OnClick="btnSelectMovie"  />
    
                       </div>--%>
                                <asp:HyperLink ID="hlFacLink" runat="server">Click Here to go to Official Faculty Page</asp:HyperLink>
                            </strong></td>
                        </tr>
                    </table>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>

</asp:Content>
