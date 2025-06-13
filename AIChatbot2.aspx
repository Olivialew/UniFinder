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

        /* Container for the chatbot */
        .chatbot-container {
            width: 1000px; /* Fixed width for the chatbot */
            max-width: 1000px; /* Ensure it doesn't exceed 1000px */
            margin: 0 auto; /* Center the container horizontally */
            box-sizing: border-box; /* Include padding and border in the width */
            background-color: #f9f9f9; /* Optional: Background color */
            padding: 20px; /* Optional: Padding for content */
            border-radius: 8px; /* Optional: Rounded corners */
            border: 1px solid #ddd; /* Optional: Border for better visibility */
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

        /* Chatbox container */
        #chatbox {
            width: 100%;
            max-width: 1000px; /* Adjust as needed */
            margin: 20px auto;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            height: 500px; /* Adjust as needed */
            box-sizing: border-box; /* Ensure padding and borders are included in the total width */
        }

        /* Messages container */
        #messages {
            flex: 1;
            overflow-y: auto;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
            display: flex;
            flex-direction: column;
            box-sizing: border-box; /* Ensure padding and borders are included in the total width */
        }

        /* Message bubbles */
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
            box-sizing: border-box; /* Ensure padding and borders are included in the total width */
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
            box-sizing: border-box; /* Ensure padding and borders are included in the total width */
        }

        /* Input container */
        .chatbox-input-container {
            display: flex;
            align-items: center;
            padding: 10px;
            border-top: 1px solid #ddd;
            background-color: #f9f9f9;
            box-sizing: border-box; /* Ensure padding and borders are included in the total width */
        }

        /* Styled text input */
        .chatbox-input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 20px;
            font-size: 16px;
            outline: none;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
            transition: border-color 0.3s ease;
            box-sizing: border-box; /* Ensure padding and borders are included in the total width */
        }

        /* Styled button */
        .chatbox-button {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            background-color: #009999;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            margin-left: 10px;
        }

            /* Button hover and active states */
            .chatbox-button:hover {
                background-color: #007f7f;
            }

            .chatbox-button:active {
                transform: scale(0.98);
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

    <div id="chatbox" class="chatbot-container">
        <div id="messages">
            <!-- Messages will be dynamically added here -->
        </div>
        <div class="chatbox-input-container">
            <input type="text" id="userInput" placeholder="Type your message here..." class="chatbox-input" />
            <button type="button" onclick="sendMessage()" class="chatbox-button">Send</button>
        </div>
    </div>
</asp:Content>
