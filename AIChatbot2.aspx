<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AIChatbot2.aspx.cs" Inherits="UniFinder.AIChatbot2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style28 {
            width: 887px;
        }

        .auto-style29 {
            height: 600px;
            width: 998px;
        }

        .auto-style30 {
            font-size: large;
        }

        .message-container {
            display: flex;
            margin-bottom: 10px;
        }

        .user-message {
            background-color: #dcf8c6;
            color: #000;
            padding: 10px;
            border-radius: 10px;
            max-width: 70%;
            align-self: flex-end;
            margin-left: auto;
        }

        .bot-message {
            background-color: #f1f0f0;
            color: #000;
            padding: 10px;
            border-radius: 10px;
            max-width: 70%;
            align-self: flex-start;
            margin-right: auto;
            white-space: pre-wrap; /* Ensures that line breaks are handled properly */
        }

        #messages {
            border: 1px solid #ccc;
            padding: 10px;
            overflow-y: scroll;
            height: 300px;
        }

        #chatbox {
            margin-top: 20px;
        }

        .auto-style31 {
            width: 552px;
        }

        .auto-style32 {
            width: 102px;
        }

        .auto-style33 {
            font-size: x-large;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <strong><span class="auto-style33">Our AI Chatbot - Edu Bot</span><br class="auto-style30" />
        <span class="auto-style30">
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
                            messages.append(
                                "<div class='message-container'><div class='user-message'><strong>You:</strong> " +
                                userInput +
                                "</div></div>"
                            );

                            var botMessageContainer = $("<div class='message-container'><div class='bot-message'><strong>EduBot:</strong> </div></div>");
                            messages.append(botMessageContainer);

                            var botMessageElement = botMessageContainer.find(".bot-message")[0];
                            displayTypingEffect(response.d, botMessageElement);

                            $("#userInput").val('');
                            messages.scrollTop(messages[0].scrollHeight);
                        },
                        error: function (xhr, status, error) {
                            console.error("Error: " + status + " " + error);
                        }
                    });
                }

                function displayTypingEffect(message, element) {
                    let words = message.split(" ");
                    let i = 0;
                    function typeWord() {
                        if (i < words.length) {
                            element.innerHTML += words[i] + " ";
                            i++;
                            setTimeout(typeWord, 10); // Adjust the speed by changing the delay (200ms)
                        }
                    }
                    typeWord();
                }
            </script>
        </span></strong>

    <div id="chatbox">
        <div id="messages" class="auto-style29"></div>
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="text" id="userInput" placeholder="Type your message here..." class="auto-style31" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <button type="button" onclick="sendMessage()" class="auto-style32">Send</button>
    </div>
</asp:Content>
