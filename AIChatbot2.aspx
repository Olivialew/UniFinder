<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AIChatbot2.aspx.cs" Inherits="UniFinder.AIChatbot2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style28 {
            width: 887px;
        }

        .auto-style29 {
            height: 351px;
            width: 983px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">
        function sendMessage() {
            var userInput = $("#userInput").val();
            console.log("Sending message: " + userInput);

            $.ajax({
                type: "POST",
                url: "AIChatbot2.aspx/Chat",
                data: JSON.stringify({ message: userInput }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log("Response received: " + response.d);

                    var messages = $("#messages");
                    messages.append("<p><strong>You:</strong> " + userInput + "</p>");
                    messages.append("<p><strong>EduBot:</strong> " + response.d + "</p>");
                    $("#userInput").val('');
                },
                error: function (xhr, status, error) {
                    console.error("Error: " + status + " " + error);
                }
            });
        }
    </script>

    <div id="chatbox">
        <div id="messages" style="border: 1px solid #ccc; padding: 10px; overflow-y: scroll;" class="auto-style29"></div>
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="text" id="userInput" placeholder="Type your message here..." class="auto-style28" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <button type="button" onclick="sendMessage()">Send</button>
    </div>
</asp:Content>
